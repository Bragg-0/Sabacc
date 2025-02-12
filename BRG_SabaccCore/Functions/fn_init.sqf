#include "script_macro.hpp"

if (!hasInterface) exitWith {};

waitUntil {
	// to prevent MP / JIP issues
	sleep 5;
	!isNull player
};

_statement = {
	[player] call BRG_fnc_openGamesMenu;
};

_condition = {
	alive player && ("BRG_SabaccTerminal" in (items player))
};

_action = [
	"BRG_OpenSabaccTerminalAction",
	"$STR_Sabacc_OpenGameTerminal",
	"\BRG_SabaccItem\UI\Terminal_ca.paa",
	_statement,
	_condition
] call ace_interact_menu_fnc_createAction;

[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;