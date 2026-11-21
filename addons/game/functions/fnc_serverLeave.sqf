#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Removes a player from their table (leave button or disconnect).
 * During a game the seat is kept but the player forfeits (out of the game).
 *
 * Arguments:
 * 0: Uid <STRING>
 *
 * Return Value:
 * None
 */
params [["_uid", "", [""]]];

private _id = GVAR(seats) getOrDefault [_uid, -1];
GVAR(seats) deleteAt _uid;

private _table = GVAR(tables) getOrDefault [_id, createHashMap];
if (count _table == 0) exitWith {};

private _players = _table get "players";
private _index = _players findIf {(_x get "uid") == _uid};
if (_index < 0) exitWith {};

private _player = _players select _index;
private _unit = _player get "unit";
[_table, LSTRING(LogLeft), [_player get "name"]] call FUNC(serverLog);

if ((_table get "status") == STATUS_PLAYING) then {
    private _wasCurrent = ([_table] call FUNC(serverCurrentUid)) == _uid;

    {_player set _x} forEach [
        ["out", true], ["left", true], ["chips", 0], ["pot", 0], ["eliminatedRound", [_player get "eliminatedRound", _table get "round"] select ((_player getOrDefault ["eliminatedRound", -1]) < 0)],
        ["drawn", CARD_NONE], ["pending", []], ["queue", []]
    ];

    if (count ([_table] call FUNC(serverActivePlayers)) <= 1) then {
        [_table] call FUNC(serverEndGame);
    } else {
        if (_wasCurrent) then {[_table] call FUNC(serverEndTurn)};
        [_table] call FUNC(serverCheckChoices);
    };
} else {
    _players deleteAt _index;
};

// Clear the view of the player who left
[EVENT_STATE, [createHashMap], _unit] call CBA_fnc_targetEvent;

// A table with only droids left is closed
private _remaining = _players select {!(_x get "left") && {!(_x get "bot")}};
if (_remaining isEqualTo []) exitWith {
    {GVAR(seats) deleteAt (_x get "uid")} forEach (_players select {_x get "bot"});
    _table set ["token", (_table get "token") + 1];
    GVAR(tables) deleteAt _id;
    call FUNC(serverSyncLobby);
};

if ((_table get "ownerUid") == _uid) then {
    _table set ["ownerUid", (_remaining select 0) get "uid"];
};

[_table] call FUNC(serverSync);
