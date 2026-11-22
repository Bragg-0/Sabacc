#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Seat of a player at a Sabacc table model: players follow each other around the table in one
 * direction (in their order of play), spread evenly by the number of seats of the table
 * (2 players face each other, 3 make a triangle...).
 *
 * Arguments:
 * 0: Index of the player in the table <NUMBER>
 * 1: Seats of the table (2..6) <NUMBER>
 *
 * Return Value:
 * Seat (index in TABLE_SEATS), -1 if none <NUMBER>
 */
params ["_index", "_maxPlayers"];

private _spread = TABLE_SEAT_SPREAD select ((round _maxPlayers) max 2 min 6);
if (_index < 0 || {_index >= count _spread}) exitWith {-1};
TABLE_SEAT_RING select (_spread select _index)
