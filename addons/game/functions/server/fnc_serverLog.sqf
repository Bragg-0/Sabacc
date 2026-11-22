#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Adds an entry to the table log (localized on each client).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Stringtable key <STRING>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_table", "_key", ["_args", []]];

private _log = _table get "log";
_log pushBack [_key, _args];
if (count _log > LOG_SIZE) then {_log deleteRange [0, count _log - LOG_SIZE]};

// Physical table: what happens is shown as a hologram above the dealer droid (see
// brg_game_fnc_worldTableHolo) and can be heard around it (see brg_game_fnc_worldTableSound)
if (_table get "world") then {
    private _object = _table get "object";
    if (!isNull _object) then {
        private _id = ((_object getVariable [QGVAR(holo), [0]]) select 0) + 1;
        _object setVariable [QGVAR(holo), [_id, _key, _args, CBA_missionTime], true];
    };

    private _sound = switch (_key) do {
        case LSTRING(LogRoundStarted): {"shuffle"};
        case LSTRING(LogDrawDeck);
        case LSTRING(LogDrawDiscard): {"card_draw"};
        case LSTRING(LogDiscard): {"card_place"};
        case LSTRING(LogShift);
        case LSTRING(LogShiftTarget): {"shift"};
        case LSTRING(LogReveal): {"reveal"};
        case LSTRING(LogImpostor);
        case LSTRING(LogPriority): {"dice"};
        case LSTRING(LogWinner): {"chips"};
        case LSTRING(LogGameOver);
        case LSTRING(LogTournamentWon): {"victory"};
        default {""};
    };
    if (_sound != "") then {[QGVAR(tableSound), [_table get "object", _sound, _table get "id"]] call CBA_fnc_globalEvent};
};
