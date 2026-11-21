#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Moves the next queued Impostor choice of a player into "pending".
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Player <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table", "_player"];

private _queue = _player get "queue";
if (_queue isEqualTo []) then {
    _player set ["pending", []];
} else {
    (_queue deleteAt 0) params ["_dice", "_suit"];
    _player set ["pending", ["impostor", _dice, _suit]];
};
