#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], "_unit"];

private _players = getAllplayers(_GameNumber);

private _playerNumber = -1;

{
	if (_unit == _x) then {
		_playerNumber = _forEachIndex;
	};
} forEach _players;

_playerNumber