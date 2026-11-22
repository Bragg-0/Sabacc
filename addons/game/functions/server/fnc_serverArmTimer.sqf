#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Starts the countdown of the current phase. Any previous countdown is
 * invalidated through the table token.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Duration in seconds <NUMBER>
 *
 * Return Value:
 * None
 */
params ["_table", "_seconds"];

_seconds = round _seconds;
private _token = (_table get "token") + 1;
_table set ["token", _token];
_table set ["deadline", CBA_missionTime + _seconds];

[FUNC(serverTimeout), [_table get "id", _token], _seconds] call CBA_fnc_waitAndExecute;
