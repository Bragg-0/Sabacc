#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Starts a new round: fresh decks, one Sand and one Blood card per player,
 * one card of each suit face up on the discard piles, dealer moves on.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _players = _table get "players";
private _count = count _players;

_table set ["round", (_table get "round") + 1];
_table set ["turn", 1];
_table set ["standStreak", 0]; // consecutive stands, see serverEndTurn
_table set ["effects", createHashMap];
_table set ["results", []];

private _sandDeck = [SUIT_SAND] call FUNC(createDeck);
private _bloodDeck = [SUIT_BLOOD] call FUNC(createDeck);

{
    if (_x get "out") then {
        _x set ["sand", CARD_NONE];
        _x set ["blood", CARD_NONE];
    } else {
        _x set ["sand", _sandDeck deleteAt 0];
        _x set ["blood", _bloodDeck deleteAt 0];
    };
    _x set ["pot", 0];
    _x set ["drawn", CARD_NONE];
    _x set ["immune", false];
    _x set ["lastAction", ""];
    _x set ["pending", []];
    _x set ["queue", []];
    _x set ["resolved", [-1, -1]];
    _x set ["shiftUsed", false];
} forEach _players;

_table set ["discards", [[_sandDeck deleteAt 0], [_bloodDeck deleteAt 0]]];
_table set ["decks", [_sandDeck, _bloodDeck]];

// Active players in seat order, starting right after the given seat index
private _fnc_after = {
    params ["_start"];
    private _result = [];
    for "_i" from 1 to _count do {
        private _player = _players select ((_start + _i) mod _count);
        if !(_player get "out") then {_result pushBack _player};
    };
    _result
};

// The dealer moves to the next active player, the player after the dealer opens
private _oldDealer = _players findIf {(_x get "uid") == (_table get "dealerUid")};
private _dealer = ([_oldDealer max 0] call _fnc_after) select 0;
private _dealerIndex = _players findIf {(_x get "uid") == (_dealer get "uid")};

_table set ["dealerUid", _dealer get "uid"];
_table set ["order", ([_dealerIndex] call _fnc_after) apply {_x get "uid"}];
_table set ["lapPos", 0];
_table set ["phase", PHASE_TURN];

[_table, LSTRING(LogRoundStarted), [_table get "round", _dealer get "name"]] call FUNC(serverLog);
[_table] call FUNC(serverBeginTurn);
