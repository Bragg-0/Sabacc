#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the localized name of a card, e.g. "Sand 4" / "4 de Sable".
 *
 * Arguments:
 * 0: Card <NUMBER>
 *
 * Return Value:
 * Name <STRING>
 *
 * Example:
 * [17] call brg_game_fnc_cardName
 */
params [["_card", CARD_NONE, [0]]];

if (_card < 0) exitWith {"?"};

private _value = CARD_VALUE(_card);
private _valueName = switch (_value) do {
    case VALUE_IMPOSTOR: {LLSTRING(Impostor)};
    case VALUE_SYLOP: {LLSTRING(Sylop)};
    default {str _value};
};

format [LLSTRING(CardName), localize ([LSTRING(Sand), LSTRING(Blood)] select CARD_SUIT(_card)), _valueName]
