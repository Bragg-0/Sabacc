#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * End of the third turn: every Mirage gets two dice and its owner picks one
 * (unless the Fixed mirage shift set Mirages to 6).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

_table set ["phase", PHASE_CHOICE];
[_table, LSTRING(LogReveal), []] call FUNC(serverLog);

private _fixedImpostor = (_table get "effects") getOrDefault ["impostorSix", false];
private _waiting = false;

{
    private _player = _x;
    private _queue = [];
    if (!_fixedImpostor) then {
        {
            if (CARD_VALUE(_player get _x) == VALUE_IMPOSTOR) then {
                _queue pushBack [[1 + floor random 6, 1 + floor random 6], _forEachIndex];
            };
        } forEach ["sand", "blood"];
    };
    _player set ["queue", _queue];
    _player set ["pending", []];
    [_table, _player] call FUNC(serverNextImpostor);
    if ((_player get "pending") isNotEqualTo []) then {_waiting = true};
} forEach ([_table] call FUNC(serverActivePlayers));

if (_waiting) then {[_table, ([_table, "turnTime"] call FUNC(tableRule)) min 30] call FUNC(serverArmTimer)};

// Droids choose instantly (done after every queue is set, so the round cannot resolve too early)
{
    if (_x get "bot") then {[_table, _x] call FUNC(serverAutoChoose)};
} forEach ([_table] call FUNC(serverActivePlayers));

[_table] call FUNC(serverCheckChoices);
