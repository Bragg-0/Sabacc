#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Moves a control from a position to its normal place (cards dealt, drawn...).
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Start position [x, y, w, h] <ARRAY>
 * 2: Duration <NUMBER> (default: 0.35)
 * 3: Delay <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 */
params ["_ctrl", "_from", ["_duration", 0.35], ["_delay", 0]];

private _base = _ctrl getVariable [QGVAR(basePos), ctrlPosition _ctrl];

// Hidden at the start position until the animation begins
_ctrl ctrlSetPosition _from;
_ctrl ctrlSetFade parseNumber (_delay > 0);
_ctrl ctrlCommit 0;

[{
    params ["_ctrl", "_base", "_duration"];
    if (isNull _ctrl) exitWith {};
    _ctrl ctrlSetPosition _base;
    _ctrl ctrlSetFade 0;
    _ctrl ctrlCommit _duration;
}, [_ctrl, _base, _duration], _delay max 0.01] call CBA_fnc_waitAndExecute;
