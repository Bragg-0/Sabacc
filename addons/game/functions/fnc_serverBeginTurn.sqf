#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Gives the hand to the current player and starts their countdown.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

private _uid = [_table] call FUNC(serverCurrentUid);
private _player = [_table, _uid] call FUNC(serverFindPlayer);
if (count _player == 0) exitWith {[_table] call FUNC(serverEndTurn)};

_player set ["shiftUsed", false];

// Embargo shift: this player skips the turn
private _effects = _table get "effects";
if ((_effects getOrDefault ["embargo", ""]) == _uid) exitWith {
    _effects deleteAt "embargo";
    _player set ["lastAction", "stand"];
    [_table, LSTRING(LogEmbargoSkip), [_player get "name"]] call FUNC(serverLog);
    [_table] call FUNC(serverEndTurn);
};

[_table, GVAR(turnTime)] call FUNC(serverArmTimer);

if (_player get "bot") then {
    [FUNC(serverBotPlay), [_table get "id", _table get "token"], 1.5 + random 1.5] call CBA_fnc_waitAndExecute;
};

[_table] call FUNC(serverSync);
