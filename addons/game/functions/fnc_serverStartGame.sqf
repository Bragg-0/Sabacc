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
if ((_table get "status") == STATUS_PLAYING) exitWith {};
// First game: the host starts it. After a game: every player votes for a new one
private _rematch = (_table get "status") == STATUS_OVER;
if (!_rematch && {(_table get "ownerUid") != _uid}) exitWith {[_unit, LSTRING(ErrorNotOwner)] call FUNC(serverNotify)};

// A physical table is started on the spot: the host must stand at it
private _object = _table get "object";
if ((_table get "world") && {isNull _object || {_unit distance _object > WORLD_TABLE_RANGE}}) exitWith {
    [_unit, LSTRING(ErrorStartAtTable)] call FUNC(serverNotify);
};

if (_rematch) then {
    private _humans = ((_table get "players") select {!(_x get "bot") && {!(_x get "left")}}) apply {_x get "uid"};
    private _ready = (_table getOrDefault ["ready", []]) select {_x in _humans};
    if !(_uid in _ready) then {
        _ready pushBack _uid;
        private _player = [_table, _uid] call FUNC(serverFindPlayer);
        [_table, LSTRING(LogRematchVote), [_player get "name", count _ready, count _humans]] call FUNC(serverLog);
    };
    _table set ["ready", _ready];
};
// Somebody has not accepted yet: wait
private _waiting = ((_table get "players") select {!(_x get "bot") && {!(_x get "left")}}) findIf {!((_x get "uid") in (_table getOrDefault ["ready", []]))};
if (_rematch && {_waiting >= 0}) exitWith {[_table] call FUNC(serverSync)};
_table set ["ready", []];

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
    _x set ["roundsWon", 0];
    _x set ["eliminatedRound", -1];
    _x set ["shifts", _pool select [_forEachIndex * _perPlayer, _perPlayer]];
} forEach _players;

_table set ["status", STATUS_PLAYING];
_table set ["round", 0];
_table set ["winner", ""];
_table set ["results", []];
_table set ["dealerUid", (selectRandom _players) get "uid"];

[_table, LSTRING(LogGameStarted), []] call FUNC(serverLog);
[_table] call FUNC(serverStartRound);
