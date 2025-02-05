#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_GameStatus", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

_gameInformation set [1, _GameStatus];

BRG_SabaccGameInformation set [_GameNumber - 1, _gameInformation];
publicVariable "BRG_SabaccGameInformation";