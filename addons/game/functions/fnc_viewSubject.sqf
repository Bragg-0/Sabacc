#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Says which player the bottom station of the game screen shows:
 *   - a player: themselves;
 *   - a spectator: the 4th player of the table (the 3 others are in the top seats),
 *     or an empty placeholder when there are 3 players or fewer.
 *
 * Arguments:
 * 0: View <HASHMAP>
 *
 * Return Value:
 * [uid ("" for the placeholder), player <HASHMAP>, spectator <BOOL>] <ARRAY>
 */
params ["_state"];

private _players = _state getOrDefault ["players", []];
private _spectator = _state getOrDefault ["spectator", false];

private _uid = getPlayerUID player;
if (_spectator) then {
    _uid = if (count _players >= 4) then {(_players select 3) get "uid"} else {""};
};

private _index = _players findIf {(_x get "uid") == _uid};
private _subject = if (_index >= 0) then {
    _players select _index
} else {
    createHashMapFromArray [
        ["uid", ""], ["name", LLSTRING(SpectatorTitle)], ["chips", 0], ["pot", 0],
        ["sand", CARD_NONE], ["blood", CARD_NONE], ["drawn", CARD_NONE],
        ["shifts", []], ["shiftCount", 0], ["shiftUsed", false],
        ["out", false], ["left", false], ["immune", false], ["lastAction", ""],
        ["pending", []], ["waiting", false], ["roundsWon", 0], ["eliminatedRound", -1]
    ]
};

[[_uid, ""] select (_index < 0), _subject, _spectator]
