#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_cardType", 0, [0]]];

private _deck = getGameCardDeck(_GameNumber);

private _cards = _deck select _cardType;

_cards