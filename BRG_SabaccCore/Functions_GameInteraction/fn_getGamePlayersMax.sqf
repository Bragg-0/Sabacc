#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameParms = getGameParams(_GameNumber);

private _gameMaxPlayer = _gameParms select 1;

_gameMaxPlayer