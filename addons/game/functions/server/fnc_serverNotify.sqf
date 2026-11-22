#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Sends a localized notification (usually an error) to one client.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Stringtable key <STRING>
 * 2: Arguments <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_unit", "_key", ["_args", []]];

if (isNull _unit) exitWith {}; // droids
[EVENT_NOTIFY, [_key, _args], _unit] call CBA_fnc_targetEvent;
