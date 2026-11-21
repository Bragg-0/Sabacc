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

if (_uid in GVAR(seats)) exitWith {[_unit, LSTRING(ErrorAlreadySeated)] call FUNC(serverNotify)};

private _table = GVAR(tables) getOrDefault [_id, createHashMap];
if (count _table == 0) exitWith {[_unit, LSTRING(ErrorTableNotFound)] call FUNC(serverNotify)};
if ((_table get "status") == STATUS_PLAYING) exitWith {[_unit, LSTRING(ErrorAlreadyStarted)] call FUNC(serverNotify)};

private _players = _table get "players";
if (({!(_x get "left")} count _players) >= (_table get "maxPlayers")) exitWith {
    [_unit, LSTRING(ErrorTableFull)] call FUNC(serverNotify);
};

_players pushBack ([_unit, _uid] call FUNC(serverNewPlayer));
GVAR(seats) set [_uid, _id];

[_table, LSTRING(LogJoined), [name _unit]] call FUNC(serverLog);
[_table] call FUNC(serverSync);
