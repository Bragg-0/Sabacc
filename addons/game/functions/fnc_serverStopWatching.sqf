#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Removes a spectator from the table they watch.
 *
 * Arguments:
 * 0: Uid <STRING>
 *
 * Return Value:
 * Was watching <BOOL>
 */
params [["_uid", "", [""]]];

if !(_uid in GVAR(watching)) exitWith {false};

private _table = GVAR(tables) getOrDefault [GVAR(watching) get _uid, createHashMap];
GVAR(watching) deleteAt _uid;

if (count _table > 0) then {
    private _unit = (_table get "spectators") getOrDefault [_uid, objNull];
    (_table get "spectators") deleteAt _uid;
    [EVENT_STATE, [createHashMap], _unit] call CBA_fnc_targetEvent;
};

call FUNC(serverSyncLobby);
true
