#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Creates an empty table and registers it. Used by the terminal ("create") and by
 * physical tables placed in the world (brg_game_fnc_addWorldTable).
 *
 * Arguments:
 * 0: Name <STRING>
 * 1: Max players <NUMBER>
 * 2: Owner uid ("" = no host yet) <STRING>
 * 3: Physical object (objNull = terminal table) <OBJECT>
 *
 * Return Value:
 * Table <HASHMAP>
 */
params ["_name", "_maxPlayers", ["_ownerUid", ""], ["_object", objNull]];

private _id = GVAR(nextTableId);
GVAR(nextTableId) = _id + 1;

private _table = createHashMapFromArray [
    ["id", _id],
    ["name", _name],
    ["ownerUid", _ownerUid],
    ["dealerUid", ""],
    ["status", STATUS_LOBBY],
    ["phase", ""],
    ["maxPlayers", (round _maxPlayers) max MIN_PLAYERS min MAX_PLAYERS],
    ["players", []],
    ["spectators", createHashMap], // uid -> unit
    ["object", _object],
    ["world", !isNull _object],
    ["droids", 0],                 // droids seated again when a physical table is reset
    ["decks", [[], []]],
    ["discards", [[], []]],
    ["round", 0],
    ["turn", 0],
    ["order", []],
    ["lapPos", 0],
    ["effects", createHashMap],
    ["log", []],
    ["token", 0],
    ["deadline", -1],
    ["results", []],
    ["winner", ""]
];

GVAR(tables) set [_id, _table];
_table
