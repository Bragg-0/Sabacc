#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Called when a countdown expires: plays the safest move for whoever is late.
 *
 * Arguments:
 * 0: Table id <NUMBER>
 * 1: Token <NUMBER>
 *
 * Return Value:
 * None
 */
params ["_id", "_token"];

private _table = GVAR(tables) getOrDefault [_id, createHashMap];
if (count _table == 0 || {(_table get "token") != _token} || {(_table get "status") != STATUS_PLAYING}) exitWith {};

switch (_table get "phase") do {
    case PHASE_TURN: {
        private _uid = [_table] call FUNC(serverCurrentUid);
        private _player = [_table, _uid] call FUNC(serverFindPlayer);
        if (count _player == 0) exitWith {};
        [_table, LSTRING(LogTimeout), [_player get "name"]] call FUNC(serverLog);

        if ((_player get "pending") isNotEqualTo []) then {[_table, _player] call FUNC(serverAutoChoose)};
        if ((_player get "drawn") != CARD_NONE) then {
            [_uid, "discard", [0]] call FUNC(serverGameAction); // keep the hand, discard the drawn card
        } else {
            [_uid, "stand", []] call FUNC(serverGameAction);
        };
    };
    case PHASE_CHOICE: {
        {
            if ((_x get "pending") isNotEqualTo []) then {[_table, _x] call FUNC(serverAutoChoose)};
        } forEach ([_table] call FUNC(serverActivePlayers));
        [_table] call FUNC(serverCheckChoices);
    };
    case PHASE_RESULTS: {
        [_table] call FUNC(serverNextRound);
    };
};
