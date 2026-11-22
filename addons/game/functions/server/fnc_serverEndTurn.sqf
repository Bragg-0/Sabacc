#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Passes the hand to the next active player. After TURNS_PER_ROUND laps, hands are revealed.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

// Everyone still in the game stood in a row (nobody drew): reveal right away
if ((_table getOrDefault ["standStreak", 0]) >= count ([_table] call FUNC(serverActivePlayers))) exitWith {
    [_table, LSTRING(LogAllStood), []] call FUNC(serverLog);
    [_table] call FUNC(serverReveal);
};

private _order = _table get "order";
private _fnc_isOut = {([_table, _this] call FUNC(serverFindPlayer)) getOrDefault ["out", true]};

private _pos = (_table get "lapPos") + 1;
while {_pos < count _order && {(_order select _pos) call _fnc_isOut}} do {_pos = _pos + 1};

if (_pos >= count _order) then {
    _table set ["turn", (_table get "turn") + 1];
    _pos = 0;
    while {_pos < count _order && {(_order select _pos) call _fnc_isOut}} do {_pos = _pos + 1};
};

_table set ["lapPos", _pos];

if ((_table get "turn") > TURNS_PER_ROUND || {_pos >= count _order}) exitWith {
    [_table] call FUNC(serverReveal);
};

[_table] call FUNC(serverBeginTurn);
