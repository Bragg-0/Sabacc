#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Sabacc table model only (server): places the stools around it (unless disabled in Eden) and
 * the card objects lying on the felt (hidden until a game shows them, see worldTableCards).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _object = _table get "object";
if (isNull _object || {!(_object isKindOf TABLE_CLASS)}) exitWith {};
if ((_table getOrDefault ["cardObjects", []]) isNotEqualTo []) exitWith {};

// ---- Stools, turned towards the table (players sit on them, see worldTableSeat)
private _stools = [];
if (_object getVariable ["brg_objects_stools", true]) then {
    {
        _x params ["_sx", "_sy"];
        private _stool = createVehicle ["brg_objects_stool", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _stool attachTo [_object, [_sx, _sy, 0]];
        _stool setDir ((-_sx) atan2 (-_sy));
        _stools pushBack _stool;
    } forEach TABLE_SEATS;
};
_object setVariable [QGVAR(stools), _stools, true];

// ---- Cards: two per seat (side by side, pointing at the seat), then the four piles
private _fnc_card = {
    params ["_x0", "_y0", "_dir"];
    private _card = createVehicle ["brg_objects_card", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _card attachTo [_object, [_x0, _y0, TABLE_FELT_Z]];
    _card setDir _dir;
    _card hideObjectGlobal true;
    _card
};
private _seatCards = [];
{
    _x params ["_cx", "_cy"];
    (TABLE_SEATS select _forEachIndex) params ["_sx", "_sy"];
    private _dir = _sx atan2 _sy;               // the card points at its seat
    private _tx = cos _dir * 0.05;              // half the gap between the two cards, across
    private _ty = -(sin _dir) * 0.05;
    private _len = sqrt (_sx ^ 2 + _sy ^ 2);
    _seatCards pushBack [
        [_cx - _tx, _cy - _ty, _dir] call _fnc_card,
        [_cx + _tx, _cy + _ty, _dir] call _fnc_card,
        // Drawn card: on the left of the hand (seen from the seat), clear of the piles in the middle
        [_cx + _tx * 3 - _sx / _len * 0.02, _cy + _ty * 3 - _sy / _len * 0.02, _dir] call _fnc_card
    ];
} forEach TABLE_CARD_SPOTS;
private _piles = TABLE_PILES apply {[_x select 0, _x select 1, 0] call _fnc_card};
_table set ["cardObjects", [_seatCards, _piles]];
// Clients show their own cards face up on these (see worldTableMyCards)
_object setVariable [QGVAR(seatCards), _seatCards, true];

// ---- Chips of each seat: reserve = up to 4 stacks of 5 beside the cards, pot = a column of up to 5
// chips towards the center, clear of the draw piles (see worldTableCards)
private _fnc_chip = {
    params ["_class", "_x0", "_y0", "_z"];
    private _chip = createVehicle [_class, [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _chip attachTo [_object, [_x0, _y0, TABLE_FELT_Z + _z]];
    _chip hideObjectGlobal true;
    _chip
};
private _seatChips = [];
{
    _x params ["_cx", "_cy"];
    (TABLE_SEATS select _forEachIndex) params ["_sx", "_sy"];
    private _len = sqrt (_sx ^ 2 + _sy ^ 2);
    private _dx = _sx / _len;   // towards the seat
    private _dy = _sy / _len;
    private _tx = _dy;          // across
    private _ty = -_dx;
    // Reserve: 2 x 2 stacks on the right of the hand (seen from the seat)
    private _reserve = [[-0.115, 0], [-0.16, 0], [-0.115, 0.045], [-0.16, 0.045]] apply {
        _x params ["_across", "_towards"];
        ["brg_objects_chips5", _cx + _tx * _across + _dx * _towards, _cy + _ty * _across + _dy * _towards, 0] call _fnc_chip
    };
    private _pot = [0, 1, 2, 3, 4] apply {
        ["brg_objects_chip1", _cx - _dx * 0.1, _cy - _dy * 0.1, _x * 0.0035] call _fnc_chip
    };
    _seatChips pushBack [_reserve, _pot];
} forEach TABLE_CARD_SPOTS;
_table set ["chipObjects", _seatChips];
