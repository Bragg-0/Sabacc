#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Turns an object of the world into a physical Sabacc table (server only).
 * Players near the object can sit (no terminal needed), watch a game, or open their table.
 * The table stays when everybody leaves: it goes back to waiting, with its droids.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Table name <STRING> (default: "")
 * 2: Max players (2..6) <NUMBER> (default: 4)
 * 3: Droids already seated <NUMBER> (default: 0)
 * 4: Variant: "classic", "quick", "noShifts" or "highStakes" <STRING> (default: "classic")
 * 5: Droid level: 0 easy, 1 normal, 2 hard <NUMBER> (default: 1)
 * 6: Tournament: 0 (none), 3 or 5 games <NUMBER> (default: 0)
 *
 * Return Value:
 * Table id (-1 on failure) <NUMBER>
 *
 * Example:
 * [myTable, "Cantina", 4, 1] call brg_game_fnc_addWorldTable
 */
params [
    ["_object", objNull, [objNull]], ["_name", "", [""]], ["_maxPlayers", MAX_PLAYERS_WIDE, [0]], ["_droids", 0, [0]],
    ["_variant", "classic", [""]], ["_botLevel", BOT_NORMAL, [0]], ["_tournament", 0, [0]]
];

if (!isServer) exitWith {
    WARNING("addWorldTable must run on the server");
    -1
};
if (isNull _object) exitWith {-1};
if ((_object getVariable [QGVAR(tableId), -1]) >= 0) exitWith {_object getVariable QGVAR(tableId)};

// The server initialisation may not have run yet (module placed in the editor)
if (isNil QGVAR(tables)) then {call FUNC(serverInit)};

if (_name isEqualTo "") then {_name = format ["Sabacc #%1", GVAR(nextTableId)]};
private _rules = createHashMapFromArray [["variant", _variant], ["botLevel", _botLevel], ["tournament", _tournament]];
private _table = [_name select [0, 24], _maxPlayers, "", _object, _rules] call FUNC(serverNewTable);
_table set ["droids", (round _droids) max 0 min ((_table get "maxPlayers") - 1)];
for "_i" from 1 to (_table get "droids") do {[_table] call FUNC(serverSeatBot)};

_object setVariable [QGVAR(tableId), _table get "id", true];
[_table] call FUNC(worldTableProps); // Sabacc table model: stools and cards on the felt
call FUNC(serverSyncLobby);

_table get "id"
