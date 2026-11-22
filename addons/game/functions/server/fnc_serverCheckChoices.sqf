#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * During the reveal, resolves the round once nobody has a dice choice left.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

if ((_table get "phase") != PHASE_CHOICE) exitWith {};

private _waiting = ([_table] call FUNC(serverActivePlayers)) findIf {(_x get "pending") isNotEqualTo []};
if (_waiting < 0) then {
    [_table] call FUNC(serverResolveRound);
} else {
    [_table] call FUNC(serverSync);
};
