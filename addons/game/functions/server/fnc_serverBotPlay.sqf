#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Plays the turn of a droid (server). Called again after each step of the turn.
 * The level of the table decides how well it plays:
 *   easy:   often careless (random draws, sometimes keeps a worse card), no shift tokens
 *   normal: improves its hand with what it sees, draws blindly now and then, rarely uses a shift token
 *   hard:   weighs every option (discard piles, expected value of each deck), stands on a good hand,
 *           and uses its shift tokens when they are worth it
 *
 * Arguments:
 * 0: Table id <NUMBER>
 * 1: Turn token (ignored if the turn moved on) <NUMBER>
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

private _level = (_table getOrDefault ["rules", createHashMap]) getOrDefault ["botLevel", BOT_NORMAL];
private _effects = _table get "effects";
private _turn = _table get "turn";
private _fnc_next = {[FUNC(serverBotPlay), [_id, _token], 1.2] call CBA_fnc_waitAndExecute};

// ---- Hand evaluation (lower score = better hand, see brg_sabacc_game_fnc_evaluateHand) ----
private _fnc_value = {
    params ["_card"];
    private _value = CARD_VALUE(_card);
    if (_value == VALUE_IMPOSTOR) then {_value = [3, 6] select (_effects getOrDefault ["impostorSix", false])};
    if (_value == VALUE_SYLOP && {_effects getOrDefault ["sylopZero", false]}) then {_value = 0};
    _value
};
private _fnc_scoreValues = {
    params ["_sandValue", "_bloodValue"];
    ([_sandValue, _bloodValue, _effects] call FUNC(evaluateHand)) select 0
};
private _fnc_score = {
    params ["_sand", "_blood"];
    [[_sand] call _fnc_value, [_blood] call _fnc_value] call _fnc_scoreValues
};

private _sand = _bot get "sand";
private _blood = _bot get "blood";
private _score = [_sand, _blood] call _fnc_score;
private _drawn = _bot get "drawn";
private _chips = _bot get "chips";

// ---- Second step: keep or discard the drawn card ----
if (_drawn != CARD_NONE) exitWith {
    private _withDrawn = if (CARD_SUIT(_drawn) == SUIT_SAND) then {[_drawn, _blood] call _fnc_score} else {[_sand, _drawn] call _fnc_score};
    private _keep = _withDrawn < _score;
    // An easy droid sometimes misjudges
    if (_level == BOT_EASY && {random 1 < 0.3}) then {_keep = !_keep};
    [_uid, "discard", [parseNumber _keep]] call FUNC(serverGameAction);
};

// ---- Shift tokens (once per turn, before drawing) ----
if (_level > BOT_EASY && {!(_bot get "shiftUsed")} && {(_bot get "shifts") isNotEqualTo []}) then {
    private _others = ([_table] call FUNC(serverActivePlayers)) select {(_x get "uid") != _uid && {!(_x get "immune")}};
    private _richest = if (_others isEqualTo []) then {createHashMap} else {
        private _sorted = [_others, [], {_x get "chips"}, "DESCEND"] call BIS_fnc_sortBy;
        _sorted select 0
    };
    private _standers = _others select {(_x get "lastAction") == "stand"};
    private _pot = _bot get "pot";
    private _lastTurn = _turn >= TURNS_PER_ROUND;
    private _values = [[_sand] call _fnc_value, [_blood] call _fnc_value];

    // [shift, target uid, worth it] for each token in hand
    private _options = (_bot get "shifts") apply {
        private _shift = _x;
        switch (_shift) do {
            case 1: {[_shift, "", _pot >= 3]};                                                    // Rebate
            case 12: {[_shift, "", _pot >= 2]};                                                   // Discount
            case 9: {[_shift, "", _lastTurn && {_pot >= 2}]};                                    // Shield
            case 7: {[_shift, "", ({(_x get "pot") > 0} count _others) >= 2]};                   // Skim
            case 11: {[_shift, "", count _others >= 2]};                                          // Table fee
            case 10: {[_shift, "", count _standers >= 2]};                                        // Crackdown
            case 2: {[_shift, _richest getOrDefault ["uid", ""], (_richest getOrDefault ["chips", 0]) >= 4]}; // Inspection
            case 14: {[_shift, _richest getOrDefault ["uid", ""], (_richest getOrDefault ["chips", 0]) >= 3]}; // Fine
            case 3: {[_shift, "", VALUE_IMPOSTOR in [CARD_VALUE(_sand), CARD_VALUE(_blood)] && {6 in _values || {(_values select 0) max (_values select 1) >= 5}}]}; // Fixed mirage
            case 15: {[_shift, "", _score < 100 && {(_values select 0) >= 5}]};                  // Upside down: my high Sabacc becomes the best
            case 4: {                                                                             // Forced swap: take the hand of someone who stood
                private _victim = if (_standers isEqualTo []) then {createHashMap} else {selectRandom _standers};
                [_shift, _victim getOrDefault ["uid", ""], _lastTurn && {_score >= 120} && {count _victim > 0}]
            };
            case 16: {                                                                            // Reshuffle: break the hand of someone who stood
                private _victim = if (_standers isEqualTo []) then {createHashMap} else {selectRandom _standers};
                [_shift, _victim getOrDefault ["uid", ""], _lastTurn && {count _victim > 0}]
            };
            case 8: {[_shift, "", _score >= 100 && {_chips <= 2}]};                              // Courtesy draw
            default {[_shift, "", false]};
        }
    };
    _options = _options select {_x select 2};
    // Normal droids use a good token only now and then, hard droids whenever it is worth it
    private _use = (_options isNotEqualTo []) && {_level == BOT_HARD || {random 1 < 0.35}};
    if (_use) then {
        (selectRandom _options) params ["_shift", "_target"];
        [_uid, "shift", [_shift, _target]] call FUNC(serverGameAction);
    };
};
if ((_table get "token") != _token) exitWith {}; // the shift may have ended the turn (it does not, but stay safe)

// ---- First step: stand or draw ----
private _canPay = _chips >= 1 || {(_effects getOrDefault ["freeDraw", ""]) == _uid};
private _tops = (_table get "discards") apply {if (_x isEqualTo []) then {CARD_NONE} else {_x select -1}};

private _source = -1;
switch (_level) do {
    case BOT_EASY: {
        // Stands on a Sabacc most of the time, otherwise draws blindly or stands at random
        _source = if (_score < 100 && {random 1 < 0.8}) then {-1} else {
            selectRandom [SOURCE_SAND_DECK, SOURCE_BLOOD_DECK, -1]
        };
    };
    case BOT_NORMAL: {
        if (_score >= 100) then {
            private _best = _score;
            {
                if (_x != CARD_NONE) then {
                    private _newScore = if (_forEachIndex == SUIT_SAND) then {[_x, _blood] call _fnc_score} else {[_sand, _x] call _fnc_score};
                    if (_newScore < _best) then {_best = _newScore; _source = [SOURCE_SAND_DISCARD, SOURCE_BLOOD_DISCARD] select _forEachIndex};
                };
            } forEach _tops;
            // No useful discard: usually try a deck, sometimes stand (keeps chips)
            if (_source < 0 && {random 1 < 0.75}) then {_source = selectRandom [SOURCE_SAND_DECK, SOURCE_BLOOD_DECK]};
        };
    };
    default {
        // Hard: gain of each option. Discard piles are known; a deck is worth its expected result
        // (the droid keeps the better of its card and the drawn one). A draw costs a chip.
        private _deckCards = [[1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3], [[3, 6] select (_effects getOrDefault ["impostorSix", false]), 3], [[VALUE_SYLOP, 0] select (_effects getOrDefault ["sylopZero", false]), 2]];
        private _sandValue = [_sand] call _fnc_value;
        private _bloodValue = [_blood] call _fnc_value;
        private _bestGain = 0;
        {
            private _suit = _forEachIndex;
            // Discard pile of this suit
            if (_x != CARD_NONE) then {
                private _new = if (_suit == SUIT_SAND) then {[[_x] call _fnc_value, _bloodValue] call _fnc_scoreValues} else {[_sandValue, [_x] call _fnc_value] call _fnc_scoreValues};
                private _gain = _score - _new;
                if (_gain > _bestGain) then {_bestGain = _gain; _source = [SOURCE_SAND_DISCARD, SOURCE_BLOOD_DISCARD] select _suit};
            };
            // Deck of this suit (only if not empty)
            if (((_table get "decks") select _suit) isNotEqualTo [] || {count ((_table get "discards") select _suit) > 1}) then {
                private _sum = 0;
                private _weights = 0;
                {
                    _x params ["_value", "_weight"];
                    private _new = if (_suit == SUIT_SAND) then {[_value, _bloodValue] call _fnc_scoreValues} else {[_sandValue, _value] call _fnc_scoreValues};
                    _sum = _sum + _weight * (_new min _score);
                    _weights = _weights + _weight;
                } forEach _deckCards;
                private _gain = _score - _sum / _weights;
                if (_gain > _bestGain) then {_bestGain = _gain; _source = [SOURCE_SAND_DECK, SOURCE_BLOOD_DECK] select _suit};
            };
        } forEach _tops;
        // A chip spent must be worth it: more demanding with few chips left
        private _threshold = [4, 9] select (_chips <= 2);
        if (_bestGain < _threshold) then {_source = -1};
    };
};

if (_source < 0 || {!_canPay}) exitWith {[_uid, "stand", []] call FUNC(serverGameAction)};

[_uid, "draw", [_source]] call FUNC(serverGameAction);
// The draw was refused (empty pile...): stand rather than wait for the timer
if ((_bot get "drawn") == CARD_NONE) exitWith {[_uid, "stand", []] call FUNC(serverGameAction)};
call _fnc_next;
