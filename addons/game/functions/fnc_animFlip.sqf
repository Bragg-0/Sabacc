#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Flips a card: shows its back, squeezes it, then opens it on its face.
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Face texture <STRING>
 * 2: Delay <NUMBER> (default: 0)
 * 3: Duration <NUMBER> (default: 0.35)
 *
 * Return Value:
 * None
 */
params ["_ctrl", "_texture", ["_delay", 0], ["_duration", 0.35]];

private _base = _ctrl getVariable [QGVAR(basePos), ctrlPosition _ctrl];
_ctrl ctrlSetText TEXTURE_BACK;
_ctrl ctrlSetPosition _base;
_ctrl ctrlCommit 0;

[{
    params ["_ctrl", "_texture", "_base", "_duration"];
    if (isNull _ctrl) exitWith {};
    _base params ["_x", "_y", "_w", "_h"];
    _ctrl ctrlSetPosition [_x + _w / 2, _y, 0, _h];
    _ctrl ctrlCommit (_duration / 2);

    [{
        params ["_ctrl", "_texture", "_base", "_duration"];
        if (isNull _ctrl) exitWith {};
        _ctrl ctrlSetText _texture;
        _ctrl ctrlSetPosition _base;
        _ctrl ctrlCommit (_duration / 2);
    }, _this, _duration / 2] call CBA_fnc_waitAndExecute;
}, [_ctrl, _texture, _base, _duration], _delay max 0.01] call CBA_fnc_waitAndExecute;
