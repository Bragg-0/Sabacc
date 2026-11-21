#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Seats a player at an existing table that has not started yet.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Uid <STRING>
 * 2: [tableId <NUMBER>] <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_unit", "_uid", "_args"];
_args params [["_id", -1, [0]]];

if (_uid in GVAR(seats) || {_uid in GVAR(watching)}) exitWith {[_unit, LSTRING(ErrorAlreadySeated)] call FUNC(serverNotify)};

private _table = GVAR(tables) getOrDefault [_id, createHashMap];
if (count _table == 0) exitWith {[_unit, LSTRING(ErrorTableNotFound)] call FUNC(serverNotify)};
if ((_table get "status") == STATUS_PLAYING) exitWith {[_unit, LSTRING(ErrorAlreadyStarted)] call FUNC(serverNotify)};

// A physical table is joined by sitting at it: the player must be next to the object
private _object = _table get "object";
if ((_table get "world") && {isNull _object || {_unit distance _object > WORLD_TABLE_RANGE}}) exitWith {
    [_unit, LSTRING(ErrorGoToTable)] call FUNC(serverNotify);
};

private _players = _table get "players";
if (({!(_x get "left")} count _players) >= (_table get "maxPlayers")) exitWith {
    [_unit, LSTRING(ErrorTableFull)] call FUNC(serverNotify);
};

_players pushBack ([_unit, _uid] call FUNC(serverNewPlayer));
GVAR(seats) set [_uid, _id];

// First human seated at a physical table becomes its host
if ((_table get "ownerUid") isEqualTo "") then {_table set ["ownerUid", _uid]};

[_table, LSTRING(LogJoined), [name _unit]] call FUNC(serverLog);
[_table] call FUNC(serverSync);
