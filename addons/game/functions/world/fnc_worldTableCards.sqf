#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Shows the game on the felt of a Sabacc table model (server): each player's two cards in front of
 * their seat (face down, face up at the reveal), a card back on each non-empty deck, the top card of
 * each discard pile. Only changes what changed (textures and visibility are global).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _cards = _table getOrDefault ["cardObjects", []];
if (_cards isEqualTo []) exitWith {};
_cards params ["_seatCards", "_piles"];

private _status = _table get "status";
private _inGame = _status != STATUS_LOBBY;
private _revealed = (_table get "phase") == PHASE_RESULTS || {_status == STATUS_OVER};

// texture "" = hidden
private _fnc_set = {
    params ["_card", "_texture"];
    private _hidden = _texture isEqualTo "";
    if ((_card getVariable [QGVAR(hidden), true]) != _hidden) then {
        _card hideObjectGlobal _hidden;
        _card setVariable [QGVAR(hidden), _hidden];
    };
    if (!_hidden && {(_card getVariable [QGVAR(texture), ""]) != _texture}) then {
        _card setObjectTextureGlobal [0, _texture];
        _card setVariable [QGVAR(texture), _texture];
        _card setVariable [QGVAR(publicTexture), _texture, true]; // what everybody sees (see worldTableMyCards)
    };
};

// Seats: players in order (left / eliminated players have no cards on the table)
private _players = _table get "players";
{
    private _seat = _forEachIndex;
    private _index = TABLE_SEAT_ORDER find _seat;
    private _player = _players param [_index, createHashMap];
    private _show = _inGame && {count _player > 0} && {!(_player get "out")} && {(_player get "sand") >= 0};
    {
        private _value = _player getOrDefault [["sand", "blood", "drawn"] select _forEachIndex, CARD_NONE];
        private _texture = switch (true) do {
            case (!_show || {_value < 0}): {""};
            case (_revealed && {_forEachIndex < 2}): {[_value] call FUNC(cardTexture)};
            default {TEXTURE_BACK};
        };
        [_x, _texture] call _fnc_set;
    } forEach _x;
} forEach _seatCards;

// Chips: reserve in stacks of 5 (rounded up, 4 stacks at most), pot chip by chip (5 at most)
private _fnc_show = {
    params ["_object", "_show"];
    if ((_object getVariable [QGVAR(hidden), true]) == _show) then {
        _object hideObjectGlobal !_show;
        _object setVariable [QGVAR(hidden), !_show];
    };
};
{
    _x params ["_reserve", "_pot"];
    private _player = _players param [TABLE_SEAT_ORDER find _forEachIndex, createHashMap];
    private _present = _inGame && {count _player > 0} && {!(_player get "left")};
    private _stacks = if (_present) then {ceil ((_player get "chips") / 5) min 4} else {0};
    private _potChips = if (_present) then {(_player get "pot") min 5} else {0};
    {[_x, _forEachIndex < _stacks] call _fnc_show} forEach _reserve;
    {[_x, _forEachIndex < _potChips] call _fnc_show} forEach _pot;
} forEach (_table getOrDefault ["chipObjects", []]);

// Piles: sand deck, sand discard, blood discard, blood deck
private _decks = _table get "decks";
private _discards = _table get "discards";
{
    private _texture = "";
    if (_inGame) then {
        _texture = switch (_forEachIndex) do {
            case 0: {["", TEXTURE_BACK] select ((_decks select SUIT_SAND) isNotEqualTo [])};
            case 3: {["", TEXTURE_BACK] select ((_decks select SUIT_BLOOD) isNotEqualTo [])};
            default {
                private _pile = _discards select ([SUIT_SAND, SUIT_BLOOD] select parseNumber (_forEachIndex == 2));
                if (_pile isEqualTo []) then {""} else {[_pile select -1] call FUNC(cardTexture)}
            };
        };
    };
    [_x, _texture] call _fnc_set;
} forEach _piles;
