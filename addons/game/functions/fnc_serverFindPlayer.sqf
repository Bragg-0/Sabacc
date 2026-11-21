#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Finds a seated player on a table.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Player uid <STRING>
 *
 * Return Value:
 * Player (empty hashmap if not found) <HASHMAP>
 */
params ["_table", ["_uid", "", [""]]];

private _players = _table get "players";
private _index = _players findIf {(_x get "uid") == _uid};

if (_index < 0) exitWith {createHashMap};
_players select _index
