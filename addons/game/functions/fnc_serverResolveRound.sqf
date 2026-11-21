#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Compares the hands and settles the chips:
 *   - winners (best hand, ties included) get their pot back,
 *   - losers lose their pot and pay a penalty: 1 chip with a Sabacc,
 *     otherwise the difference between their two cards,
 *   - a player with no chip left is eliminated.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _effects = _table get "effects";
private _fixedImpostor = _effects getOrDefault ["impostorSix", false];
private _zeroSylop = _effects getOrDefault ["sylopZero", false];
private _active = [_table] call FUNC(serverActivePlayers);

private _hands = _active apply {
    private _player = _x;
    private _values = ["sand", "blood"] apply {
        private _value = CARD_VALUE(_player get _x);
        if (_value == VALUE_IMPOSTOR) then {
            _value = if (_fixedImpostor) then {6} else {((_player get "resolved") select (["sand", "blood"] find _x)) max 1};
        };
        if (_value == VALUE_SYLOP && _zeroSylop) then {_value = 0};
        _value
    };
    [_player, _values, (_values + [_effects]) call FUNC(evaluateHand)]
};

private _best = selectMin (_hands apply {(_x select 2) select 0});
private _results = [];

{
    _x params ["_player", "_values", "_eval"];
    _eval params ["_score", "_isSabacc", "_penalty", "_labelKey", "_labelArgs"];

    private _won = _score == _best;
    private _delta = 0;
    if (_won) then {
        _delta = _player get "pot";
        _player set ["chips", (_player get "chips") + _delta];
        _player set ["roundsWon", (_player getOrDefault ["roundsWon", 0]) + 1];
        [_table, LSTRING(LogWinner), [_player get "name", ["msg", _labelKey, _labelArgs]]] call FUNC(serverLog);
    } else {
        private _paid = (_player get "chips") min _penalty;
        _player set ["chips", (_player get "chips") - _paid];
        _delta = -((_player get "pot") + _paid);
    };
    _player set ["pot", 0];

    _results pushBack [
        _player get "uid", _player get "name",
        [_player get "sand", _player get "blood"], _values,
        _labelKey, _labelArgs, _won, _delta
    ];
} forEach _hands;

{
    if ((_x get "chips") <= 0) then {
        _x set ["out", true];
        _x set ["eliminatedRound", _table get "round"];
        [_table, LSTRING(LogEliminated), [_x get "name"]] call FUNC(serverLog);
    };
} forEach _active;

_table set ["results", _results];
_table set ["phase", PHASE_RESULTS];
[_table, GVAR(resultsTime)] call FUNC(serverArmTimer);
[_table] call FUNC(serverSync);
