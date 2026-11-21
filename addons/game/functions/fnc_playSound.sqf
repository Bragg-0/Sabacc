#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Plays an interface sound if sounds are enabled in the CBA settings.
 *
 * Arguments:
 * 0: CfgSounds class <STRING>
 *
 * Return Value:
 * None
 */
params [["_sound", "", [""]]];

if (!GVAR(sounds) || {_sound isEqualTo ""}) exitWith {};
playSound _sound;
