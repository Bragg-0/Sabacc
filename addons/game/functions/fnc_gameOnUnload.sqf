#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Game screen closed.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Exit code <NUMBER> (2 = our close buttons / Escape; anything else = closed by something else)
 *
 * Return Value:
 * None
 */
params ["", ["_exitCode", -1]];
TRACE_1("game screen closed",_exitCode);

uiNamespace setVariable [QGVAR(gameDisplay), displayNull];
GVAR(targeting) = -1;
GVAR(leaveConfirm) = false;

if (!isNil QGVAR(headerPFH)) then {
    [GVAR(headerPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(headerPFH) = nil;
};
