#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Explains a card: title, rule and title color (to use with brg_game_fnc_uiHelp).
 *
 * Arguments:
 * 0: Card <NUMBER>
 *
 * Return Value:
 * [title, text, color] <ARRAY>
 */
params [["_card", CARD_NONE, [0]]];

if (_card == CARD_NONE) exitWith {["", "", HTML_TEXT]};
if (_card == CARD_HIDDEN) exitWith {[LLSTRING(HelpHiddenShort), LLSTRING(HelpHidden), HTML_MUTED]};

private _value = CARD_VALUE(_card);
private _rule = switch (_value) do {
    case VALUE_IMPOSTOR: {LLSTRING(HelpImpostor)};
    case VALUE_SYLOP: {LLSTRING(HelpSylop)};
    default {format [LLSTRING(HelpNumber), _value]};
};

[[_card] call FUNC(cardName), _rule, [HTML_SAND, HTML_BLOOD] select CARD_SUIT(_card)]
