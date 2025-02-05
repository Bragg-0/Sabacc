#include "..\script_macro.hpp"

params ["_unit"];

private _gameNumber = -1;

{
	private _players = getAllplayers(_forEachIndex);
	if (_unit in _players) then {
		_gameNumber = _forEachIndex;
	};
} forEach BRG_SabaccGameInformation;

_gameNumber