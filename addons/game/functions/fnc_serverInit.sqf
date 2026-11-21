#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Server initialization. The server is the only authority on game state:
 * clients send requests, the server validates them and sends each player
 * a personal view of the table (opponents' cards stay hidden).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
if (!isServer) exitWith {};
// Can be called early by brg_game_fnc_addWorldTable (editor module), then by the post-init
if (!isNil QGVAR(tables)) exitWith {};

GVAR(tables) = createHashMap;   // table id -> table
GVAR(seats) = createHashMap;    // player uid -> table id
GVAR(watching) = createHashMap; // spectator uid -> table id
GVAR(nextTableId) = 1;

// Statistics saved in the server profile: [[uid, [name, games, wins, rounds, roundWins, sabaccs, pure]], ...]
GVAR(stats) = createHashMapFromArray (profileNamespace getVariable [QGVAR(stats), []]);

GVAR(lobby) = [];
publicVariable QGVAR(lobby);

[EVENT_REQUEST, {_this call FUNC(serverRequest)}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["HandleDisconnect", {
    params ["", "", "_uid"];
    if !([_uid] call FUNC(serverStopWatching)) then {[_uid] call FUNC(serverLeave)};
    false
}];

INFO("Sabacc server initialized");
