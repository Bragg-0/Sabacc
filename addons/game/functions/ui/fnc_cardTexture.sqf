#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the texture of a card (CARD_HIDDEN = card back, CARD_NONE = empty).
 *
 * Arguments:
 * 0: Card <NUMBER>
 *
 * Return Value:
 * Texture path <STRING>
 *
 * Example:
 * [14] call brg_game_fnc_cardTexture
 */
params [["_card", CARD_NONE, [0]]];

if (_card == CARD_NONE) exitWith {""};
if (_card == CARD_HIDDEN) exitWith {TEXTURE_BACK};

private _value = CARD_VALUE(_card);
private _name = switch (_value) do {
    case VALUE_IMPOSTOR: {"impostor"};
    case VALUE_SYLOP: {"sylop"};
    default {str _value};
};

format [QPATHTOF(data\ui\cards\%1\%2.paa), ["sand", "blood"] select CARD_SUIT(_card), _name]
