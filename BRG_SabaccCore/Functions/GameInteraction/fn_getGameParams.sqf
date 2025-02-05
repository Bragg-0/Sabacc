#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

private _gameParms = _gameInformation select 3;

_gameParms