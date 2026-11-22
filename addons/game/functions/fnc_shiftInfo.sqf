#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the display information of a shift token.
 *
 * Arguments:
 * 0: Shift id (1..16) <NUMBER>
 *
 * Return Value:
 * [name, description, needsTarget, texture] <ARRAY>
 *
 * Example:
 * [4] call brg_game_fnc_shiftInfo
 */
params [["_id", 1, [0]]];

[
    localize format ["STR_brg_game_Shift%1Name", _id],
    localize format ["STR_brg_game_Shift%1Desc", _id],
    _id in [2, 4, 14, 16],
    format [QPATHTOF(data\ui\shifts\%1.paa), _id]
]
