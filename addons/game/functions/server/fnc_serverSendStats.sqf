#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Sends a player their statistics and the server ranking (top 5 by games won).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Uid <STRING>
 *
 * Return Value:
 * None
 */
params ["_unit", "_uid"];

private _mine = GVAR(stats) getOrDefault [_uid, [name _unit, 0, 0, 0, 0, 0, 0]];

// Ranking: games won, then rounds won, then fewer games played
// (sort keys only, the last key is an index so two entries never compare as equal)
private _all = values GVAR(stats);
private _ranking = [];
{_ranking pushBack [-(_x select 2), -(_x select 4), _x select 1, _forEachIndex]} forEach _all;
_ranking sort true;
private _top = (_ranking select [0, 5]) apply {_all select (_x select 3)};

[QGVAR(stats), [_mine, _top], _unit] call CBA_fnc_targetEvent;
