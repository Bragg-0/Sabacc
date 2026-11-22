#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Creates an empty table and registers it. Used by the terminal ("create") and by
 * physical tables placed in the world (brg_sabacc_game_fnc_addWorldTable).
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
params ["_name", "_maxPlayers", ["_ownerUid", ""], ["_object", objNull], ["_rules", createHashMap]];

// Rules: variant (see brg_sabacc_game_fnc_tableRule), droid level, tournament length (0 = none)
private _variant = _rules getOrDefault ["variant", "classic"];
if !(_variant in VARIANTS) then {_variant = "classic"};
private _botLevel = (round (_rules getOrDefault ["botLevel", BOT_NORMAL])) max BOT_EASY min BOT_HARD;
private _tournament = round (_rules getOrDefault ["tournament", 0]);
if !(_tournament in TOURNAMENT_SIZES) then {_tournament = 0};

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
    ["rules", createHashMapFromArray [["variant", _variant], ["botLevel", _botLevel], ["tournament", _tournament]]],
    ["tourGame", 0],               // tournament: number of the current game (1..tournament)
    ["tourPoints", createHashMap], // tournament: uid -> points
    ["tourNames", createHashMap],  // tournament: uid -> name (players who left stay in the standings)
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
