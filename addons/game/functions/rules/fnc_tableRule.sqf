#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * One rule of a table: its variant overrides the server settings (CBA).
 *   classic: server settings | quick: 5 chips, 1 shift token, 30 s turns
 *   noShifts: no shift token | highStakes: 12 chips, 3 shift tokens
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Rule: "startChips", "shifts" or "turnTime" <STRING>
 *
 * Return Value:
 * Value <NUMBER>
 *
 * Example:
 * [_table, "startChips"] call brg_game_fnc_tableRule
 */
params ["_table", "_key"];

private _variant = (_table getOrDefault ["rules", createHashMap]) getOrDefault ["variant", "classic"];
switch (_key) do {
    case "startChips": {
        switch (_variant) do {
            case "quick": {5};
            case "highStakes": {12};
            default {round GVAR(startChips)};
        }
    };
    case "shifts": {
        switch (_variant) do {
            case "quick": {1};
            case "noShifts": {0};
            case "highStakes": {3};
            default {round GVAR(shiftsPerPlayer)};
        }
    };
    case "turnTime": {[GVAR(turnTime), 30] select (_variant == "quick")};
    default {0};
}
