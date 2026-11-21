#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Seats a droid (computer player) at the host's table. Useful to play or test alone.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Uid <STRING>
 *
 * Return Value:
 * None
 */
params ["_unit", "_uid"];

private _table = GVAR(tables) getOrDefault [GVAR(seats) getOrDefault [_uid, -1], createHashMap];
if (count _table == 0) exitWith {};
if ((_table get "ownerUid") != _uid) exitWith {[_unit, LSTRING(ErrorNotOwner)] call FUNC(serverNotify)};
if ((_table get "status") == STATUS_PLAYING) exitWith {[_unit, LSTRING(ErrorAlreadyStarted)] call FUNC(serverNotify)};

private _players = _table get "players";
if (({!(_x get "left")} count _players) >= (_table get "maxPlayers")) exitWith {
    [_unit, LSTRING(ErrorTableFull)] call FUNC(serverNotify);
};

[_table] call FUNC(serverSeatBot);
[_table] call FUNC(serverSync);
