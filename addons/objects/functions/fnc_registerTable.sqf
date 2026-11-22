#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Registers a Sabacc table object as a physical game table, with the settings given in Eden
 * (server). Does nothing if a synchronized "Sabacc table" module already registered it.
 *
 * Arguments:
 * 0: Sabacc table object <OBJECT>
 *
 * Return Value:
 * None
 */
params ["_object"];

[
    _object,
    _object getVariable [QGVAR(name), ""],
    _object getVariable [QGVAR(maxPlayers), 4],
    _object getVariable [QGVAR(droids), 0],
    _object getVariable [QGVAR(variant), "classic"],
    _object getVariable [QGVAR(droidLevel), 1],
    _object getVariable [QGVAR(tournament), 0]
] call EFUNC(game,addWorldTable);
