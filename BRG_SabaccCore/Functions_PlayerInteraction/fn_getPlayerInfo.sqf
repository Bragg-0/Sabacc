#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

private _playersInfo = _gameInformation select 4;

private _playerInfo = _playersInfo select (_playerNumber - 1);

_playerInfo