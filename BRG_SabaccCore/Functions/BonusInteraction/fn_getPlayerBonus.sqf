#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_bonusNumber", 0, [0]]];

private _playerInformation = getPlayerInfo(_GameNumber, _playerNumber);

private _playerBonus = _playerInformation select 3;

private _bonus = _playerBonus select _bonusNumber;

_bonus