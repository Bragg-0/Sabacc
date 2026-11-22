#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Creates a new table from the terminal and seats its creator (who becomes the host).
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
_args params [["_name", "", [""]], ["_maxPlayers", MAX_PLAYERS_WIDE, [0]], ["_variant", "classic", [""]], ["_botLevel", BOT_NORMAL, [0]], ["_tournament", 0, [0]]];

if (_uid in GVAR(seats) || {_uid in GVAR(watching)}) exitWith {[_unit, LSTRING(ErrorAlreadySeated)] call FUNC(serverNotify)};

_name = ([_name] call CBA_fnc_trim) select [0, 24];
if (_name isEqualTo "") then {_name = name _unit};

private _rules = createHashMapFromArray [["variant", _variant], ["botLevel", _botLevel], ["tournament", _tournament]];
private _table = [_name, _maxPlayers, _uid, objNull, _rules] call FUNC(serverNewTable);
(_table get "players") pushBack ([_unit, _uid] call FUNC(serverNewPlayer));
GVAR(seats) set [_uid, _table get "id"];

[_table, LSTRING(LogCreated), [name _unit]] call FUNC(serverLog);
[_table] call FUNC(serverSync);
