#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Scores a resolved hand. Mirages must already be replaced by their dice value.
 * A lower score is a better hand.
 *
 *   0        Pure Sabacc (two Sylops)
 *   1        Sabacc made "priority" by the "Priority odds" shift
 *   2..9     Sabacc (pair), 1/1 is the best (order reversed by the "Upside down" shift)
 *   100+     No Sabacc: smallest difference first, then lowest card
 *
 * Arguments:
 * 0: Sand value (0..6 or VALUE_SYLOP) <NUMBER>
 * 1: Blood value (0..6 or VALUE_SYLOP) <NUMBER>
 * 2: Round effects <HASHMAP>
 *
 * Return Value:
 * [score, isSabacc, penalty, labelKey, labelArgs] <ARRAY>
 *
 * Example:
 * [3, 3, createHashMap] call brg_sabacc_game_fnc_evaluateHand
 */
params [["_sand", 0, [0]], ["_blood", 0, [0]], ["_effects", createHashMap, [createHashMap]]];

if (_sand == VALUE_SYLOP && {_blood == VALUE_SYLOP}) exitWith {
    [0, true, 1, LSTRING(HandPure), []]
};

// A Sylop copies the value of the other card
if (_sand == VALUE_SYLOP) then {_sand = _blood};
if (_blood == VALUE_SYLOP) then {_blood = _sand};

if (_sand == _blood) exitWith {
    private _score = 1;
    if (_sand != (_effects getOrDefault ["priority", -1])) then {
        _score = 2 + ([_sand, 7 - _sand] select (_effects getOrDefault ["inverted", false]));
    };
    [_score, true, 1, LSTRING(HandSabacc), [_sand]]
};

private _diff = abs (_sand - _blood);
[100 + _diff * 10 + (_sand min _blood), false, _diff, LSTRING(HandDiff), [_diff]]
