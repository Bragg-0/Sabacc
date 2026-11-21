#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Starts (or restarts) a game. Host only.
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
if ((_table get "status") == STATUS_PLAYING) exitWith {};

// Forget the seats of players who left the previous game
_table set ["players", (_table get "players") select {!(_x get "left")}];
private _players = _table get "players";
if (count _players < MIN_PLAYERS) exitWith {[_unit, LSTRING(ErrorNotEnoughPlayers)] call FUNC(serverNotify)};

// Deal the shift tokens from one shared pool so nobody holds the same token twice
private _pool = [];
for "_i" from 1 to SHIFT_COUNT do {_pool pushBack _i};
_pool = [_pool] call CBA_fnc_shuffle;
private _perPlayer = (round GVAR(shiftsPerPlayer)) min (floor (SHIFT_COUNT / count _players));

{
    _x set ["chips", round GVAR(startChips)];
    _x set ["pot", 0];
    _x set ["out", false];
    _x set ["shifts", _pool select [_forEachIndex * _perPlayer, _perPlayer]];
} forEach _players;

_table set ["status", STATUS_PLAYING];
_table set ["round", 0];
_table set ["winner", ""];
_table set ["results", []];
_table set ["dealerUid", (selectRandom _players) get "uid"];

[_table, LSTRING(LogGameStarted), []] call FUNC(serverLog);
[_table] call FUNC(serverStartRound);
