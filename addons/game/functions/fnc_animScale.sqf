#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Scales a control around its center (hover effect). 1 = normal size.
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Scale <NUMBER>
 * 2: Duration <NUMBER> (default: 0.12)
 *
 * Return Value:
 * None
 */
params ["_ctrl", "_scale", ["_duration", 0.12]];

private _base = _ctrl getVariable [QGVAR(basePos), ctrlPosition _ctrl];
_base params ["_px", "_py", "_pw", "_ph"];

private _newW = _pw * _scale;
private _newH = _ph * _scale;
_ctrl ctrlSetPosition [_px - (_newW - _pw) / 2, _py - (_newH - _ph) / 2, _newW, _newH];
_ctrl ctrlCommit _duration;
