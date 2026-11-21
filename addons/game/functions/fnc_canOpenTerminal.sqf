#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Checks if a unit can open the Sabacc terminal.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Can open <BOOL>
 *
 * Example:
 * [player] call brg_game_fnc_canOpenTerminal
 */
params [["_unit", objNull, [objNull]]];

// Seated at a physical table or watching a game: no terminal needed to come back to it
alive _unit && {
    !GVAR(requireTerminal)
    || {QEGVAR(objects,terminal) in (items _unit)}
    || {GVAR(state) getOrDefault ["world", false]}
    || {GVAR(state) getOrDefault ["spectator", false]}
}
