#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the uid of the player whose turn it is ("" outside of the turn phase).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * Uid <STRING>
 */
params ["_table"];

if ((_table get "phase") != PHASE_TURN) exitWith {""};
(_table get "order") param [_table get "lapPos", ""]
