#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Adds to the statistics of a player (droids are ignored).
 * Stored on the server: uid -> [name, games played, games won, rounds played, rounds won, sabaccs, pure sabaccs]
 *
 * Arguments:
 * 0: Player <HASHMAP>
 * 1: Increments [games played, games won, rounds played, rounds won, sabaccs, pure sabaccs] <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_player", "_increments"];

if (_player getOrDefault ["bot", false]) exitWith {};

private _uid = _player get "uid";
private _stats = GVAR(stats) getOrDefault [_uid, [_player get "name", 0, 0, 0, 0, 0, 0]];
_stats set [0, _player get "name"]; // keep the latest name
{
    _stats set [_forEachIndex + 1, (_stats select (_forEachIndex + 1)) + _x];
} forEach _increments;
GVAR(stats) set [_uid, _stats];
