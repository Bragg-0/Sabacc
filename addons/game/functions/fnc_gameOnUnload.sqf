#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Game screen closed.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
uiNamespace setVariable [QGVAR(gameDisplay), displayNull];
GVAR(targeting) = -1;
GVAR(leaveConfirm) = false;

if (!isNil QGVAR(headerPFH)) then {
    [GVAR(headerPFH)] call CBA_fnc_removePerFrameHandler;
    GVAR(headerPFH) = nil;
};
