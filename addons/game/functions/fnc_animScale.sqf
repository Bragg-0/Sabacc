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
_base params ["_x", "_y", "_w", "_h"];

private _newW = _w * _scale;
private _newH = _h * _scale;
_ctrl ctrlSetPosition [_x - (_newW - _w) / 2, _y - (_newH - _h) / 2, _newW, _newH];
_ctrl ctrlCommit _duration;
