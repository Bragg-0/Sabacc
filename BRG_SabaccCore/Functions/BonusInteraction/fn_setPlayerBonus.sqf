#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_bonusNumber", 0, [0]], ["_bonusType", 0, [0]]];

private _playerInformation = getPlayerInfo(_GameNumber, _playerNumber);

private _playerBonus = _playerInformation select 3;

private _bonus = _playerBonus select _bonusNumber;

private _newBonus = _bonus set [0, _bonusType];
_newBonus = _bonus set [1, true];

_playerBonus set [_bonusNumber, _newBonus];

_playerInformation set [3, _playerBonus];

setPlayerInfo(_GameNumber, _playerNumber, _playerInformation);