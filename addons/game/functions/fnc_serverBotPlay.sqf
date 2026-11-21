#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Plays the turn of a droid. Simple strategy:
 *   - with a Sabacc (or no chip left): stand,
 *   - otherwise take a discard card that improves the hand, or draw from a deck,
 *   - after drawing, keep whichever card gives the better hand.
 * Impostors are counted as 3 (average-ish die) when estimating a hand.
 *
 * Arguments:
 * 0: Table id <NUMBER>
 * 1: Turn token <NUMBER>
 *
 * Return Value:
 * None
 */
params ["_id", "_token"];

private _table = GVAR(tables) getOrDefault [_id, createHashMap];
if (count _table == 0 || {(_table get "token") != _token} || {(_table get "status") != STATUS_PLAYING}) exitWith {};

private _uid = [_table] call FUNC(serverCurrentUid);
private _bot = [_table, _uid] call FUNC(serverFindPlayer);
if (count _bot == 0 || {!(_bot get "bot")}) exitWith {};

private _effects = _table get "effects";
private _fnc_value = {
    params ["_card"];
    private _value = CARD_VALUE(_card);
    if (_value == VALUE_IMPOSTOR) then {_value = [3, 6] select (_effects getOrDefault ["impostorSix", false])};
    if (_value == VALUE_SYLOP && {_effects getOrDefault ["sylopZero", false]}) then {_value = 0};
    _value
};
private _fnc_score = {
    params ["_sand", "_blood"];
    ([[_sand] call _fnc_value, [_blood] call _fnc_value, _effects] call FUNC(evaluateHand)) select 0
};

private _sand = _bot get "sand";
private _blood = _bot get "blood";
private _score = [_sand, _blood] call _fnc_score;
private _drawn = _bot get "drawn";

// ---- Second step: keep or discard the drawn card ----
if (_drawn != CARD_NONE) exitWith {
    private _withDrawn = if (CARD_SUIT(_drawn) == SUIT_SAND) then {[_drawn, _blood] call _fnc_score} else {[_sand, _drawn] call _fnc_score};
    [_uid, "discard", [parseNumber (_withDrawn < _score)]] call FUNC(serverGameAction);
};

// ---- First step: stand or draw ----
if (_score < 100 || {(_bot get "chips") < 1}) exitWith {
    [_uid, "stand", []] call FUNC(serverGameAction);
};

private _tops = (_table get "discards") apply {if (_x isEqualTo []) then {CARD_NONE} else {_x select -1}};
private _best = _score;
private _source = -1;
{
    if (_x != CARD_NONE) then {
        private _newScore = if (_forEachIndex == SUIT_SAND) then {[_x, _blood] call _fnc_score} else {[_sand, _x] call _fnc_score};
        if (_newScore < _best) then {
            _best = _newScore;
            _source = [SOURCE_SAND_DISCARD, SOURCE_BLOOD_DISCARD] select _forEachIndex;
        };
    };
} forEach _tops;

// No useful discard: usually try the deck, sometimes stand (keeps chips)
if (_source < 0) then {
    _source = if (random 1 < 0.75) then {selectRandom [SOURCE_SAND_DECK, SOURCE_BLOOD_DECK]} else {-1};
};

if (_source < 0) exitWith {[_uid, "stand", []] call FUNC(serverGameAction)};

[_uid, "draw", [_source]] call FUNC(serverGameAction);
[FUNC(serverBotPlay), [_id, _token], 1.5] call CBA_fnc_waitAndExecute;
