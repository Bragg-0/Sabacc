#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_cardType", 0, [0]]];

private _cards = getCards(_GameNumber, _cardType);

private _cardID = -1;

_card = _cards select {
	(_x select 1) == _playerNumber
};

_cardID = _card select 2;

_cardID