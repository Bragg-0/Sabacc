#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Condition of the interactions on a physical table.
 *
 * Arguments:
 * 0: Table object <OBJECT>
 * 1: Interaction: "sit", "watch" or "open" <STRING>
 *
 * Return Value:
 * Available <BOOL>
 */
params ["_object", "_kind"];

private _id = _object getVariable [QGVAR(tableId), -1];
if (_id < 0 || {!alive player} || {player distance _object > WORLD_TABLE_RANGE}) exitWith {false};

private _lobby = missionNamespace getVariable [QGVAR(lobby), []];
private _index = _lobby findIf {(_x select 0) == _id};
if (_index < 0) exitWith {false};
(_lobby select _index) params ["", "", "", "_names", "_max", "_status"];

private _free = count GVAR(state) == 0; // neither seated nor watching anywhere

switch (_kind) do {
    case "sit": {_free && {_status != STATUS_PLAYING} && {count _names < _max}};
    case "watch": {_free && {_status != STATUS_LOBBY}};
    case "open": {(GVAR(state) getOrDefault ["id", -1]) == _id};
    default {false};
}
