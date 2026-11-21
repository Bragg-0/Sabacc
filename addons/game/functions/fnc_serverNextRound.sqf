#include "..\script_component.hpp"
/*
 * Author: Bragg
 * After the results: next round, or end of the game when one player is left.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

if (count ([_table] call FUNC(serverActivePlayers)) <= 1) then {
    [_table] call FUNC(serverEndGame);
} else {
    [_table] call FUNC(serverStartRound);
};
