#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Handles in-game actions. Every rule is checked here, never on the client.
 *
 *   "stand"                      keep the hand, end the turn (free)
 *   "draw"    [source]           take a card (1 chip), see SOURCE_* macros
 *   "discard" [keepDrawn]        0: discard the drawn card, 1: keep it and discard the hand card of the same suit
 *   "shift"   [id, targetUid]    use a shift token (once per turn, before drawing/standing)
 *   "choose"  [index]            pick one of two dice (Mirage value or Priority odds)
 *
 * Arguments:
 * 0: Uid <STRING>
 * 1: Action <STRING>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_uid", "_type", ["_args", []]];

private _table = GVAR(tables) getOrDefault [GVAR(seats) getOrDefault [_uid, -1], createHashMap];
if (count _table == 0 || {(_table get "status") != STATUS_PLAYING}) exitWith {};

private _player = [_table, _uid] call FUNC(serverFindPlayer);
if (count _player == 0 || {_player get "out"}) exitWith {};
private _unit = _player get "unit";

// Dice choices can happen outside of the player's turn (Mirages at the reveal)
if (_type == "choose") exitWith {
    _args params [["_index", 0, [0]]];
    [_table, _player, _index] call FUNC(serverResolveChoice);
};

if ([_table] call FUNC(serverCurrentUid) != _uid) exitWith {[_unit, LSTRING(ErrorNotYourTurn)] call FUNC(serverNotify)};
if ((_player get "pending") isNotEqualTo []) exitWith {[_unit, LSTRING(ErrorChoiceFirst)] call FUNC(serverNotify)};

private _effects = _table get "effects";
private _drawn = _player get "drawn";

switch (_type) do {
    case "stand": {
        if (_drawn != CARD_NONE) exitWith {};
        _player set ["lastAction", "stand"];
        _table set ["standStreak", (_table getOrDefault ["standStreak", 0]) + 1];
        [_table, LSTRING(LogStand), [_player get "name"]] call FUNC(serverLog);
        [_table] call FUNC(serverEndTurn);
    };

    case "draw": {
        _args params [["_source", SOURCE_SAND_DECK, [0]]];
        if (_drawn != CARD_NONE || {_source < 0} || {_source > 3}) exitWith {};

        private _free = (_effects getOrDefault ["freeDraw", ""]) == _uid;
        if (!_free && {(_player get "chips") < 1}) exitWith {[_unit, LSTRING(ErrorNoChips)] call FUNC(serverNotify)};

        private _fromDiscard = _source >= SOURCE_SAND_DISCARD;
        private _suit = _source mod 2;
        private _pile = ([_table get "decks", _table get "discards"] select _fromDiscard) select _suit;
        if (_pile isEqualTo []) exitWith {[_unit, LSTRING(ErrorEmptyPile)] call FUNC(serverNotify)};

        // Deck: top card is the first one. Discard: top card is the last one.
        private _card = if (_fromDiscard) then {_pile deleteAt (count _pile - 1)} else {_pile deleteAt 0};

        if (_free) then {
            _effects deleteAt "freeDraw";
        } else {
            _player set ["chips", (_player get "chips") - 1];
            _player set ["pot", (_player get "pot") + 1];
        };
        _player set ["drawn", _card];
        _player set ["lastAction", "draw"];
        _table set ["standStreak", 0];

        if (_fromDiscard) then {
            [_table, LSTRING(LogDrawDiscard), [_player get "name", ["card", _card]]] call FUNC(serverLog);
        } else {
            [_table, LSTRING(LogDrawDeck), [_player get "name", [LSTRING(Sand), LSTRING(Blood)] select _suit]] call FUNC(serverLog);
        };
        [_table] call FUNC(serverSync);
    };

    case "discard": {
        _args params [["_keepDrawn", 0, [0]]];
        if (_drawn == CARD_NONE) exitWith {};

        private _suit = CARD_SUIT(_drawn);
        private _key = ["sand", "blood"] select _suit;
        private _discarded = _drawn;
        if (_keepDrawn == 1) then {
            _discarded = _player get _key;
            _player set [_key, _drawn];
        };

        ((_table get "discards") select _suit) pushBack _discarded;
        _player set ["drawn", CARD_NONE];

        [_table, LSTRING(LogDiscard), [_player get "name", ["card", _discarded]]] call FUNC(serverLog);
        [_table] call FUNC(serverEndTurn);
    };

    case "shift": {
        _args params [["_shift", 0, [0]], ["_targetUid", "", [""]]];
        private _shifts = _player get "shifts";
        if !(_shift in _shifts) exitWith {};
        if (_player get "shiftUsed") exitWith {[_unit, LSTRING(ErrorShiftUsed)] call FUNC(serverNotify)};
        if (_drawn != CARD_NONE) exitWith {[_unit, LSTRING(ErrorShiftBeforeAction)] call FUNC(serverNotify)};

        if ([_table, _player, _shift, _targetUid] call FUNC(serverApplyShift)) then {
            _shifts deleteAt (_shifts find _shift);
            _player set ["shiftUsed", true];
            [_table] call FUNC(serverSync);
        };
    };
};
