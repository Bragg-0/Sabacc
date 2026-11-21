#include "..\script_component.hpp"
/*
 * Author: Bragg
 * A physical table that no human uses anymore goes back to waiting,
 * with its initial droids, instead of being deleted.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

{GVAR(seats) deleteAt (_x get "uid")} forEach (_table get "players");

// Spectators go back to the menu: there is nothing left to watch
{
    GVAR(watching) deleteAt _x;
    [EVENT_STATE, [createHashMap], _y] call CBA_fnc_targetEvent;
} forEach (_table get "spectators");
_table set ["spectators", createHashMap];

_table set ["players", []];
_table set ["ownerUid", ""];
_table set ["status", STATUS_LOBBY];
_table set ["phase", ""];
_table set ["round", 0];
_table set ["results", []];
_table set ["winner", ""];
_table set ["log", []];
_table set ["token", (_table get "token") + 1]; // cancels any pending countdown

for "_i" from 1 to (_table get "droids") do {[_table] call FUNC(serverSeatBot)};

[_table] call FUNC(serverSync);
