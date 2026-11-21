#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds what one player is allowed to see of a table: everything public,
 * their own hand, and the opponents' cards only once they are revealed.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Viewer uid <STRING>
 *
 * Return Value:
 * View <HASHMAP>
 */
params ["_table", "_viewerUid"];

private _revealed = (_table get "phase") == PHASE_RESULTS || {(_table get "status") == STATUS_OVER};

private _fnc_hide = {
    params ["_card", "_visible"];
    if (_card == CARD_NONE || _visible) then {_card} else {CARD_HIDDEN}
};

private _players = (_table get "players") apply {
    private _isMe = (_x get "uid") == _viewerUid;
    private _visible = _isMe || _revealed;
    createHashMapFromArray [
        ["uid", _x get "uid"],
        ["name", _x get "name"],
        ["chips", _x get "chips"],
        ["pot", _x get "pot"],
        ["sand", [_x get "sand", _visible] call _fnc_hide],
        ["blood", [_x get "blood", _visible] call _fnc_hide],
        ["drawn", [_x get "drawn", _isMe] call _fnc_hide],
        ["shifts", +(_x get "shifts")], // shift tokens are public (face up on the table)
        ["shiftCount", count (_x get "shifts")],
        ["shiftUsed", _x get "shiftUsed"],
        ["out", _x get "out"],
        ["left", _x get "left"],
        ["immune", _x get "immune"],
        ["lastAction", _x get "lastAction"],
        ["pending", [[], +(_x get "pending")] select _isMe],
        ["waiting", (_x get "pending") isNotEqualTo []],
        ["roundsWon", _x getOrDefault ["roundsWon", 0]],
        ["eliminatedRound", _x getOrDefault ["eliminatedRound", -1]]
    ]
};

createHashMapFromArray [
    ["id", _table get "id"],
    ["name", _table get "name"],
    ["status", _table get "status"],
    ["phase", _table get "phase"],
    ["ownerUid", _table get "ownerUid"],
    ["dealerUid", _table get "dealerUid"],
    ["maxPlayers", _table get "maxPlayers"],
    ["round", _table get "round"],
    ["turn", (_table get "turn") min TURNS_PER_ROUND],
    ["current", [_table] call FUNC(serverCurrentUid)],
    ["deadline", _table get "deadline"],
    ["effects", +(_table get "effects")],
    ["log", +(_table get "log")],
    ["results", +(_table get "results")],
    ["winner", _table get "winner"],
    ["discardTops", (_table get "discards") apply {if (_x isEqualTo []) then {CARD_NONE} else {_x select -1}}],
    ["deckCounts", (_table get "decks") apply {count _x}],
    ["players", _players],
    ["spectator", (_table get "players") findIf {(_x get "uid") == _viewerUid} < 0],
    ["spectatorCount", count (_table get "spectators")],
    ["world", _table get "world"]
]
