#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Ends the game. The table stays open so the host can start a new game.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _active = [_table] call FUNC(serverActivePlayers);
private _winner = if (count _active == 1) then {(_active select 0) get "name"} else {""};

_table set ["status", STATUS_OVER];
_table set ["phase", ""];
_table set ["winner", _winner];
_table set ["token", (_table get "token") + 1]; // cancels any pending countdown

// Statistics: everybody who took part played a game, the last one standing won it
{
    [_x, [1, parseNumber (count _active == 1 && {_x isEqualTo (_active select 0)}), 0, 0, 0, 0]] call FUNC(serverStatsAdd);
} forEach (_table get "players");
call FUNC(serverStatsSave);

if (_winner == "") then {
    [_table, LSTRING(LogGameOverDraw), []] call FUNC(serverLog);
} else {
    [_table, LSTRING(LogGameOver), [_winner]] call FUNC(serverLog);
};

[_table] call FUNC(serverSync);
