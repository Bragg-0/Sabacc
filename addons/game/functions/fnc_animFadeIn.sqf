#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Fades every control of a display in (screen opening).
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Duration <NUMBER> (default: 0.3)
 *
 * Return Value:
 * None
 */
params ["_display", ["_duration", 0.3]];

{
    _x ctrlSetFade 1;
    _x ctrlCommit 0;
    _x ctrlSetFade 0;
    _x ctrlCommit _duration;
} forEach (allControls _display);
