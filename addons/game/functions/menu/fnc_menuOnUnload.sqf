#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Terminal menu closed.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Exit code <NUMBER> (2 = our close buttons / Escape; anything else = closed by something else)
 *
 * Return Value:
 * None
 */
params ["", ["_exitCode", -1]];
TRACE_1("menu closed",_exitCode);

uiNamespace setVariable [QGVAR(menuDisplay), displayNull];
