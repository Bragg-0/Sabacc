#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the players still in the game (not eliminated, not left).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * Players <ARRAY>
 */
params ["_table"];

(_table get "players") select {!(_x get "out")}
