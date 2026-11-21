#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Small "drop" bounce: the control appears slightly smaller and higher, then settles.
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Delay <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 */
params ["_ctrl", ["_delay", 0]];

[{
    params ["_ctrl"];
    if (isNull _ctrl) exitWith {};
    private _base = _ctrl getVariable [QGVAR(basePos), ctrlPosition _ctrl];
    _base params ["_px", "_py", "_pw", "_ph"];

    _ctrl ctrlSetPosition [_px + _pw * 0.1, _py + _ph * 0.1 - GH(1), _pw * 0.8, _ph * 0.8];
    _ctrl ctrlSetFade 0.4;
    _ctrl ctrlCommit 0;

    [{
        params ["_ctrl", "_base"];
        if (isNull _ctrl) exitWith {};
        _ctrl ctrlSetPosition _base;
        _ctrl ctrlSetFade 0;
        _ctrl ctrlCommit 0.25;
    }, [_ctrl, _base]] call CBA_fnc_execNextFrame;
}, [_ctrl], _delay max 0.01] call CBA_fnc_waitAndExecute;
