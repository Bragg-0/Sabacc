#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

private _cardDeck = _gameInformation select 2;

_cardDeck