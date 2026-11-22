#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Applies a dice choice: a Mirage value at the reveal, or the Priority odds shift.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Player <HASHMAP>
 * 2: Dice index (0 or 1) <NUMBER>
 *
 * Return Value:
 * None
 */
params ["_table", "_player", ["_index", 0, [0]]];

private _pending = _player get "pending";
if (_pending isEqualTo []) exitWith {};

_pending params ["_type", "_dice", "_suit"];
private _value = _dice select ((round _index) max 0 min 1);

if (_type == "priority") exitWith {
    (_table get "effects") set ["priority", _value];
    _player set ["pending", []];
    [_table, LSTRING(LogPriority), [_player get "name", _value]] call FUNC(serverLog);
    [_table] call FUNC(serverSync);
};

// Mirage
if ((_table get "phase") != PHASE_CHOICE) exitWith {};
(_player get "resolved") set [_suit, _value];
[_table, LSTRING(LogImpostor), [_player get "name", [LSTRING(Sand), LSTRING(Blood)] select _suit, _value]] call FUNC(serverLog);
[_table, _player] call FUNC(serverNextImpostor);
[_table] call FUNC(serverCheckChoices);
