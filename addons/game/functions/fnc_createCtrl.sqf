#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Creates a control on a display at a position. The position is remembered
 * as the "rest" position used by the animations.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Control class <STRING>
 * 2: Position [x, y, w, h] <ARRAY>
 * 3: Parent controls group <CONTROL> (default: controlNull)
 *
 * Return Value:
 * Control <CONTROL>
 *
 * Example:
 * [_display, QGVAR(Text), [0, 0, 0.1, 0.05]] call brg_game_fnc_createCtrl
 */
params ["_display", "_class", "_position", ["_group", controlNull]];

private _ctrl = if (isNull _group) then {
    _display ctrlCreate [_class, -1]
} else {
    _display ctrlCreate [_class, -1, _group]
};
_ctrl ctrlSetPosition _position;
_ctrl ctrlCommit 0;
_ctrl setVariable [QGVAR(basePos), _position];
_ctrl
