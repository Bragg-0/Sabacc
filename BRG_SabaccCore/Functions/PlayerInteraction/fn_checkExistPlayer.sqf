#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], "_unit"];

private _gameInformation = getGameInfo(_GameNumber);

private _gamePlayersMax = getGamePlayersMax(_GameNumber);

for "_i" from 1 to "_gamePlayersMax" step 1 do {
	private _player = getPlayerInfo(_GameNumber, _i);
	_player = _player select 0;
	if (_player isEqualTo _unit) exitWith {
		true
	};
};

if (_player isEqualTo _unit) then {
	true
} else {
	false
};