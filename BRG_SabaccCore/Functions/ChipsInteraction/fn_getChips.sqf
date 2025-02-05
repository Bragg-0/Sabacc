#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_chipsType", 0, [0]]];

private _playerInfo = getPlayerInfo(_GameNumber, _playerNumber);

private _playerChips = _playerInfo select 3;

_playerChips