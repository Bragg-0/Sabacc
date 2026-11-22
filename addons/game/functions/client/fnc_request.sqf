#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Sends a request to the server (see brg_sabacc_game_fnc_serverRequest).
 *
 * Arguments:
 * 0: Request type <STRING>
 * 1: Arguments <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["draw", [0]] call brg_sabacc_game_fnc_request
 */
params [["_type", "", [""]], ["_args", [], [[]]]];

[EVENT_REQUEST, [player, _type, _args]] call CBA_fnc_serverEvent;
