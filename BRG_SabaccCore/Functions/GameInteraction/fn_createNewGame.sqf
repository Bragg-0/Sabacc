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
private _Chips = [0, 0];

private _NewGameInfo = GameInfo(_GameNumber, _GameStatus, _CardDeck, _GameOwner, _GamePlayersMax, _Unit, _Name, _Bonus, _Chips);

BRG_SabaccGameInformation pushBack _NewGameInfo;
publicVariable "BRG_SabaccGameInformation";

_GameNumber