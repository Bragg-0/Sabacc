#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Creates a new table and seats its creator (who becomes the host).
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Uid <STRING>
 * 2: [name <STRING>, maxPlayers <NUMBER>] <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_unit", "_uid", "_args"];
_args params [["_name", "", [""]], ["_maxPlayers", MAX_PLAYERS, [0]]];

if (_uid in GVAR(seats)) exitWith {[_unit, LSTRING(ErrorAlreadySeated)] call FUNC(serverNotify)};

_name = ([_name] call CBA_fnc_trim) select [0, 24];
if (_name isEqualTo "") then {_name = name _unit};

private _id = GVAR(nextTableId);
GVAR(nextTableId) = _id + 1;

private _table = createHashMapFromArray [
    ["id", _id],
    ["name", _name],
    ["ownerUid", _uid],
    ["dealerUid", ""],
    ["status", STATUS_LOBBY],
    ["phase", ""],
    ["maxPlayers", (round _maxPlayers) max MIN_PLAYERS min MAX_PLAYERS],
    ["players", [[_unit, _uid] call FUNC(serverNewPlayer)]],
    ["decks", [[], []]],
    ["discards", [[], []]],
    ["round", 0],
    ["turn", 0],
    ["order", []],
    ["lapPos", 0],
    ["effects", createHashMap],
    ["log", []],
    ["token", 0],
    ["deadline", -1],
    ["results", []],
    ["winner", ""]
];

GVAR(tables) set [_id, _table];
GVAR(seats) set [_uid, _id];

[_table, LSTRING(LogCreated), [name _unit]] call FUNC(serverLog);
[_table] call FUNC(serverSync);
