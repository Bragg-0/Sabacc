#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Creates a seat for a player.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Uid <STRING>
 * 2: Droid name, for a droid (no unit) <STRING> (default: "")
 *
 * Return Value:
 * Player <HASHMAP>
 */
params ["_unit", "_uid", ["_botName", "", [""]]];

private _isBot = _botName != "";

createHashMapFromArray [
    ["uid", _uid],
    ["unit", _unit],
    ["name", if (_isBot) then {_botName} else {name _unit}],
    ["bot", _isBot],
    ["chips", 0],
    ["pot", 0],
    ["sand", CARD_NONE],
    ["blood", CARD_NONE],
    ["drawn", CARD_NONE],
    ["shifts", []],
    ["shiftUsed", false],
    ["out", false],
    ["left", false],
    ["immune", false],
    ["lastAction", ""],
    ["pending", []],        // [type, dice, suit] while a dice choice is expected
    ["queue", []],          // impostor choices still to make at the reveal
    ["resolved", [-1, -1]]  // impostor values chosen at the reveal [sand, blood]
]
