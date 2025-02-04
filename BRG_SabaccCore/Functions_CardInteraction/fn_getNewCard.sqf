#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_cardType", 0, [0]]];

private _cards = getCards(_GameNumber, _cardType);

private _newCardDefine = false;

private _newCard = [];

private _newCardID = -1;

while { !_newCardDefine } do {
	_newCard = selectRandom _cards;
	if ((_newCard select 1) == 0) exitWith {
		_newCardID = _newCard select 2;
		_newCardDefine = true;
	};
};

_newCardID