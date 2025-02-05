#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

private _gameStatus = _gameInformation select 1;

_gameStatus