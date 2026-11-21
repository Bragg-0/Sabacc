#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Sends its personal view of the table to every seated player, then refreshes the lobby.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

{
    if (!(_x get "left") && {!(_x get "bot")}) then {
        [EVENT_STATE, [[_table, _x get "uid"] call FUNC(serverBuildView)], _x get "unit"] call CBA_fnc_targetEvent;
    };
} forEach (_table get "players");

call FUNC(serverSyncLobby);
