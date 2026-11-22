#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Makes the pending dice choices of a player who ran out of time,
 * picking the die closest to the other card (the best hand most of the time).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Player <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table", "_player"];

for "_guard" from 1 to 4 do {
    private _pending = _player get "pending";
    if (_pending isEqualTo []) exitWith {};

    _pending params ["_type", "_dice", "_suit"];
    _dice params ["_first", "_second"];
    private _index = 0;

    if (_type == "impostor") then {
        private _otherSuit = 1 - _suit;
        private _otherCard = _player get (["sand", "blood"] select _otherSuit);
        private _other = CARD_VALUE(_otherCard);
        if (_other == VALUE_IMPOSTOR) then {_other = (_player get "resolved") select _otherSuit};

        _index = if (_other in [1, 2, 3, 4, 5, 6]) then {
            parseNumber (abs (_second - _other) < abs (_first - _other))
        } else {
            parseNumber (_second < _first)
        };
    };

    [_table, _player, _index] call FUNC(serverResolveChoice);
};
