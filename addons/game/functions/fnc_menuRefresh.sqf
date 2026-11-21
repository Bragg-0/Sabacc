#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Refreshes the table list of the terminal menu (if it is open).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _display = uiNamespace getVariable [QGVAR(menuDisplay), displayNull];
if (isNull _display) exitWith {};

private _list = _display getVariable "list";
private _selected = lbCurSel _list;
private _selectedId = if (_selected >= 0) then {_list lbValue _selected} else {-1};
private _myId = GVAR(state) getOrDefault ["id", -1];
if (_selectedId < 0) then {_selectedId = _myId};

lbClear _list;
{
    _x params ["_id", "_name", "_ownerName", "_names", "_max", "_status"];
    private _index = _list lbAdd format ["%1   (%2/%3)", _name, count _names, _max];
    _list lbSetValue [_index, _id];
    _list lbSetTextRight [_index, [_status] call FUNC(statusName)];
    if (_id == _myId) then {_list lbSetColor [_index, COLOR_SAND]};
    if (_id == _selectedId) then {_list lbSetCurSel _index};
} forEach (missionNamespace getVariable [QGVAR(lobby), []]);

call FUNC(menuUpdateInfo);
