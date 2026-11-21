#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Physical tables waiting for players: a player who walks away from the table
 * (more than WORLD_TABLE_RANGE) is removed from it. Called every second by the server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
{
    private _table = _y;
    private _object = _table get "object";
    if ((_table get "world") && {(_table get "status") == STATUS_LOBBY}) then {
        {
            private _unit = _x get "unit";
            if (isNull _unit || {!alive _unit} || {isNull _object} || {_unit distance _object > WORLD_TABLE_RANGE}) then {
                [_x get "uid"] call FUNC(serverLeave);
                [_unit, LSTRING(InfoLeftWorldTable)] call FUNC(serverNotify);
            };
        } forEach ((_table get "players") select {!(_x get "bot") && {!(_x get "left")}});
    };
} forEach +GVAR(tables);
