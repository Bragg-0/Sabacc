#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Server initialization. The server is the only authority on game state:
 * clients send requests, the server validates them and sends each player
 * a personal view of the table (opponents' cards stay hidden).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
if (!isServer) exitWith {};

GVAR(tables) = createHashMap;   // table id -> table
GVAR(seats) = createHashMap;    // player uid -> table id
GVAR(nextTableId) = 1;

GVAR(lobby) = [];
publicVariable QGVAR(lobby);

[EVENT_REQUEST, {_this call FUNC(serverRequest)}] call CBA_fnc_addEventHandler;

addMissionEventHandler ["HandleDisconnect", {
    params ["", "", "_uid"];
    [_uid] call FUNC(serverLeave);
    false
}];

INFO("Sabacc server initialized");
