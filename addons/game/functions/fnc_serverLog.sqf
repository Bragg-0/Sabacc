#include "..\script_component.hpp"
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
