#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Ranking of a finished game: winner first, then whoever was eliminated last, then by chips,
 * then by rounds won.
 *
 * Arguments:
 * 0: Players (hashmaps with name, out, eliminatedRound, chips, roundsWon) <ARRAY>
 * 1: Winner name ("" = no winner) <STRING>
 *
 * Return Value:
 * Players, best first <ARRAY>
 */
params ["_players", "_winner"];

// Sort keys only (the last key is the player index, so two players never compare as equal)
private _keys = [];
{
    private _isWinner = (_x get "name") == _winner && {!(_x get "out")};
    private _eliminated = _x get "eliminatedRound";
    _keys pushBack [
        parseNumber !_isWinner,
        -([_eliminated, 999] select (_eliminated < 0)),
        -(_x get "chips"),
        -(_x get "roundsWon"),
        _forEachIndex
    ];
} forEach _players;
_keys sort true;
_keys apply {_players select (_x select 4)}
