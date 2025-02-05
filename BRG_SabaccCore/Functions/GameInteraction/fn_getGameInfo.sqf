#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]]];

private _gameInformation = BRG_SabaccGameInformation select {
	(_x select 0) == _GameNumber
};

_gameInformation