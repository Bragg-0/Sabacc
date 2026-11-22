#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Dealer droid flying above the middle of each Sabacc table model nearby (local object, every frame):
 * it turns smoothly towards the seat whose turn it is, and slowly spins while nobody plays.
 *
 * Arguments:
 * 0: Frame time (seconds since the last call) <NUMBER>
 *
 * Return Value:
 * None
 */
params [["_delta", 0.02]];

{
    private _object = _x select 7;
    if (!isNull _object && {_object isKindOf TABLE_CLASS}) then {
        private _droid = _object getVariable [QGVAR(dealer), objNull];
        private _near = player distance _object < 80;
        if (!_near) exitWith {
            if (!isNull _droid) then {deleteVehicle _droid; _object setVariable [QGVAR(dealer), objNull]};
            {deleteVehicle _x} forEach (_object getVariable [QGVAR(diceLocal), []]);
            _object setVariable [QGVAR(diceLocal), []];
        };
        if (isNull _droid) then {
            _droid = "brg_objects_dealer" createVehicleLocal [0, 0, 0];
            _droid attachTo [_object, [0, 0, TABLE_FELT_Z + DEALER_HEIGHT]];
            _object setVariable [QGVAR(dealer), _droid];
            _droid setVariable [QGVAR(heading), 0];
        };

        // Heading, relative to the table: towards the seat in play, or a slow spin
        private _seat = _object getVariable [QGVAR(turnSeat), -1];
        private _heading = _droid getVariable [QGVAR(heading), 0];
        private _target = if (_seat >= 0) then {
            (TABLE_SEATS select _seat) params ["_sx", "_sy"];
            _sx atan2 _sy
        } else {_heading + 25 * _delta};
        private _diff = ((_target - _heading + 540) mod 360) - 180;
        // Turn at most 200 degrees per second (min / max have the precedence of "+": parentheses)
        private _step = (_diff max (-200 * _delta)) min (200 * _delta);
        _heading = (_heading + _step + 360) mod 360;
        _droid setVariable [QGVAR(heading), _heading];

        // Flying above the middle of the table, gently bobbing (attached: the offset and heading are relative)
        _droid attachTo [_object, [0, 0, TABLE_FELT_Z + DEALER_HEIGHT + 0.015 * sin (time * 90)]];
        _droid setDir _heading;
        // Sensor strip turning around the visor (one turn in 6 s)
        _droid animateSource ["spin", (time / 6) mod 1, true];

        // Dice of the roll being chosen: floating under the droid, slowly spinning, the value on top
        private _roll = _object getVariable [QGVAR(dice), []];
        private _dice = _object getVariable [QGVAR(diceLocal), []];
        if (_dice isEqualTo []) then {
            _dice = TABLE_DICE apply {
                private _die = "brg_objects_die" createVehicleLocal [0, 0, 0];
                _die hideObject true;
                _die
            };
            _object setVariable [QGVAR(diceLocal), _dice];
        };
        {
            private _value = _roll param [_forEachIndex, 0];
            _x hideObject (_value <= 0);
            if (_value > 0) then {
                (TABLE_DICE select _forEachIndex) params ["_dx", "_dy"];
                _x attachTo [_object, [_dx, _dy, TABLE_FELT_Z + DICE_HEIGHT + 0.012 * sin (time * 100 + _forEachIndex * 120)]];
                // Which axis of the die points up (+Z 1, -Z 6, +X 2, -X 5, +Y 3, -Y 4), then turned around the vertical
                (switch (_value) do {
                    case 1: {[[0, 1, 0], [0, 0, 1]]};
                    case 6: {[[0, 1, 0], [0, 0, -1]]};
                    case 2: {[[0, 1, 0], [-1, 0, 0]]};
                    case 5: {[[0, 1, 0], [1, 0, 0]]};
                    case 3: {[[0, 0, 1], [0, -1, 0]]};
                    default {[[0, 0, -1], [0, 1, 0]]};
                }) params ["_dirVector", "_upVector"];
                private _yaw = time * 35 + _forEachIndex * 90;
                private _fnc_turn = {
                    params ["_v"];
                    [(_v select 0) * cos _yaw - (_v select 1) * sin _yaw, (_v select 0) * sin _yaw + (_v select 1) * cos _yaw, _v select 2]
                };
                _x setVectorDirAndUp [[_dirVector] call _fnc_turn, [_upVector] call _fnc_turn];
            };
        } forEach _dice;
    };
} forEach (missionNamespace getVariable [QGVAR(lobby), []]);
