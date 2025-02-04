#include "..\script_macro.hpp"

params ["_unit"];

if (isNil "BRG_SabaccGameInformation") then {
	BRG_SabaccGameInformation = [];
};

private _GameNumber = count BRG_SabaccGameInformation + 1;
private _GameStatus = 0;
private _CardDeck = DefaultCardsDeck;
private _GameOwner = _unit;
private _GamePlayersMax = 4;
private _Unit = _unit;
private _Name = name _unit;
private _Bonus = [0, 0];

BRG_SabaccGameInformation = GameInfo(_GameNumber, _GameStatus, _CardDeck, _GameOwner, _GamePlayersMax, _Unit, _Name, _Bonus);
publicVariable "BRG_SabaccGameInformation";