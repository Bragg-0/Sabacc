#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Lets a player watch a table without playing. Spectators receive the same view as
 * the players, without any hand: cards stay hidden until the reveal.
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
if ((_table get "status") == STATUS_LOBBY) exitWith {[_unit, LSTRING(ErrorNothingToWatch)] call FUNC(serverNotify)};

(_table get "spectators") set [_uid, _unit];
GVAR(watching) set [_uid, _id];

[EVENT_STATE, [[_table, _uid] call FUNC(serverBuildView)], _unit] call CBA_fnc_targetEvent;
call FUNC(serverSyncLobby);
