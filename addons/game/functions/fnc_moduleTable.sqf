#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Eden module "Sabacc table": every object synchronized with the module becomes a
 * physical table (the module itself is used when nothing is synchronized).
 *
 * Arguments:
 * 0: Module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 */
params [["_logic", objNull, [objNull]], "", ["_activated", true, [true]]];

if (!isServer || {!_activated} || {isNull _logic}) exitWith {};

private _name = _logic getVariable ["Name", ""];
private _maxPlayers = _logic getVariable ["MaxPlayers", MAX_PLAYERS_WIDE];
private _droids = _logic getVariable ["Droids", 0];

private _objects = (synchronizedObjects _logic) select {!(_x isKindOf "Logic")};
if (_objects isEqualTo []) then {_objects = [_logic]};

{
    // Several objects: number the tables so they can be told apart in the menu
    private _tableName = if (count _objects > 1 && {_name != ""}) then {format ["%1 %2", _name, _forEachIndex + 1]} else {_name};
    [_x, _tableName, _maxPlayers, _droids] call FUNC(addWorldTable);
} forEach _objects;
