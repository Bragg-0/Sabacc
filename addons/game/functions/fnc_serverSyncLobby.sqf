#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Broadcasts the public list of tables shown in the terminal menu.
 * Entry: [id, name, ownerName, playerNames, maxPlayers, status]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _lobby = (values GVAR(tables)) apply {
    private _table = _x;
    private _seated = (_table get "players") select {!(_x get "left")};
    private _owner = [_table, _table get "ownerUid"] call FUNC(serverFindPlayer);
    [
        _table get "id",
        _table get "name",
        _owner getOrDefault ["name", "?"],
        _seated apply {_x get "name"},
        _table get "maxPlayers",
        _table get "status"
    ]
};
_lobby sort true;

GVAR(lobby) = _lobby;
publicVariable QGVAR(lobby);                                // for players joining later
[QGVAR(lobbyChanged), [_lobby]] call CBA_fnc_globalEvent;   // live refresh of open menus
