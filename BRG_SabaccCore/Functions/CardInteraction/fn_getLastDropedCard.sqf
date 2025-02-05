#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_cardType", 0, [0]]];

private _Cards = getCards(_GameNumber, _cardType);

private _max = 5;
private _cardID = -1;

{
	if ((_x select 1) > _max) then {
		_max = (_x select 1);
		_cardID = (_x select 2);
	};
} forEach _Cards;

_cardID