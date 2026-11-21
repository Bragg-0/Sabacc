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

alive _unit && {!GVAR(requireTerminal) || {QEGVAR(items,terminal) in (items _unit)}}
