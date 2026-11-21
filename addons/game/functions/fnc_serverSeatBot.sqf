#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Seats one droid at a table (no check: callers make sure there is a free seat).
 *
 * Arguments:
 * 0: Table <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_table"];

if (isNil QGVAR(nextBotId)) then {GVAR(nextBotId) = 1};
private _botId = GVAR(nextBotId);
GVAR(nextBotId) = _botId + 1;

private _botUid = format ["bot_%1", _botId];
private _name = format ["DRD-%1", 10 + _botId];
(_table get "players") pushBack ([objNull, _botUid, _name] call FUNC(serverNewPlayer));
GVAR(seats) set [_botUid, _table get "id"];

[_table, LSTRING(LogJoined), [_name]] call FUNC(serverLog);
