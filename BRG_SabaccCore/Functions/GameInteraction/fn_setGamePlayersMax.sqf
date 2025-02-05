#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_GamePlayersMax", 4, [0]]];

private _gameParms = getGameParams(_GameNumber);

_gameParms set [1, _GamePlayersMax];

private _gameInformation = getGameInfo(_GameNumber);

_gameInformation set [3, _gameParms];

BRG_SabaccGameInformation set [_GameNumber - 1, _gameInformation];
publicVariable "BRG_SabaccGameInformation";