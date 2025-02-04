#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameParms = getGameParams(_GameNumber);

private _gameOwner = _gameParms select 0;

_gameOwner