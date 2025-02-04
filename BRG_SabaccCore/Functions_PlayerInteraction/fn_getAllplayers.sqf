#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameInformation = getGameInfo(_GameNumber);

private _gamePlayersMax = getGamePlayersMax(_GameNumber);

private _players = [];

for "_i" from 1 to "_gamePlayersMax" step 1 do {
	private _player = getPlayerInfo(_GameNumber, _i);
	_player = _player select 0;
	_players pushBack _player;
};

_players