#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds and shuffles one suit of the Kessel deck (3 x 1..6, 3 Impostors, 2 Sylops).
 *
 * Arguments:
 * 0: Suit (SUIT_SAND / SUIT_BLOOD) <NUMBER>
 *
 * Return Value:
 * Shuffled cards <ARRAY>
 *
 * Example:
 * [0] call brg_game_fnc_createDeck
 */
params [["_suit", SUIT_SAND, [0]]];

private _deck = [];
for "_value" from 1 to 6 do {
    for "_i" from 1 to COPIES_NUMBER do {_deck pushBack CARD(_suit,_value)};
};
for "_i" from 1 to COPIES_IMPOSTOR do {_deck pushBack CARD(_suit,VALUE_IMPOSTOR)};
for "_i" from 1 to COPIES_SYLOP do {_deck pushBack CARD(_suit,VALUE_SYLOP)};

[_deck] call CBA_fnc_shuffle
