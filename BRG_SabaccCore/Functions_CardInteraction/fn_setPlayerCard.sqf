#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_cardType", 0, [0]], ["_cardID", -1, [0]]];

private _cards = getCards(_GameNumber, _cardType);

_card = _cards select {
	(_x select 2) == _cardID
};

private _cardIndex = _cards find _card;

_card set [1, _playerNumber];

_cards set [_cardIndex, _card];

private _gameInformation = getGameInfo(_GameNumber);

(_gameInformation select 4) set [(_playerNumber - 1), _card];

BRG_SabaccGameInformation set [_GameNumber - 1, _gameInformation];
publicVariable "BRG_SabaccGameInformation";