#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Entry point of every client request (server, unscheduled).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Request type <STRING>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "join", [1]] call brg_game_fnc_serverRequest
 */
params [["_unit", objNull, [objNull]], ["_type", "", [""]], ["_args", [], [[]]]];

if (!isServer || {isNull _unit}) exitWith {};

private _uid = getPlayerUID _unit;
if (_uid isEqualTo "") exitWith {};

TRACE_3("request",_uid,_type,_args);

// Keep the unit up to date (respawning creates a new unit)
private _table = GVAR(tables) getOrDefault [GVAR(seats) getOrDefault [_uid, -1], createHashMap];
if (count _table > 0) then {
    private _player = [_table, _uid] call FUNC(serverFindPlayer);
    if (count _player > 0) then {_player set ["unit", _unit]};
};

switch (_type) do {
    case "refresh": {
        private _view = if (count _table > 0) then {[_table, _uid] call FUNC(serverBuildView)} else {createHashMap};
        [EVENT_STATE, [_view], _unit] call CBA_fnc_targetEvent;
    };
    case "create": {[_unit, _uid, _args] call FUNC(serverCreateTable)};
    case "join": {[_unit, _uid, _args] call FUNC(serverJoinTable)};
    case "leave": {[_uid] call FUNC(serverLeave)};
    case "start": {[_unit, _uid] call FUNC(serverStartGame)};
    case "addBot": {[_unit, _uid] call FUNC(serverAddBot)};
    default {[_uid, _type, _args] call FUNC(serverGameAction)};
};
