#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Enables the "start" button of the menu. At a physical table, the host must stand at it.
 *
 * Arguments:
 * 0: Menu display <DISPLAY>
 *
 * Return Value:
 * None
 */
params ["_display"];

private _state = GVAR(state);
private _atTable = !(_state getOrDefault ["world", false]) || {
    private _object = _state getOrDefault ["object", objNull];
    !isNull _object && {player distance _object <= WORLD_TABLE_RANGE}
};
private _btnStart = _display getVariable ["btnStart", controlNull];
_btnStart ctrlEnable ((_display getVariable ["canStart", false]) && _atTable);
_btnStart ctrlSetTooltip ([LLSTRING(ErrorStartAtTable), LLSTRING(TipStart)] select _atTable);
