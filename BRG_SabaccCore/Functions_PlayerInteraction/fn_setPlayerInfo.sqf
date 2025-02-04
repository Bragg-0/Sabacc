#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_playerInfo", [], [[]]]];

private _gameInformation = getGameInfo(_GameNumber);

(_gameInformation select 4) set [(_playerNumber - 1), _playerInfo];

BRG_SabaccGameInformation set [_GameNumber - 1, _gameInformation];
publicVariable "BRG_SabaccGameInformation";