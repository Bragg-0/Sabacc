#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_cardType", 0, [0]]];

private _cardID = getPlayerCard(_GameNumber, _playerNumber, _cardType);

if (isNil "BRG_IndexCardDrop") then {
	BRG_IndexCardDrop = 10;
};

BRG_IndexCardDrop = BRG_IndexCardDrop + 1;
publuicVariable "BRG_IndexCardDrop";

setPlayerCard(_GameNumber, BRG_IndexCardDrop, _cardType, _cardID);