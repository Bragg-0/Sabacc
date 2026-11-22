#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Plays a sound of the game at a physical table, for this player only, if they are nearby and
 * do not already hear it in their own game screen (players and spectators of that table).
 *
 * Arguments:
 * 0: Table object <OBJECT>
 * 1: Sound name (see CfgSounds.hpp) <STRING>
 * 2: Table id <NUMBER>
 *
 * Return Value:
 * None
 */
params ["_object", "_sound", "_id"];

if (!hasInterface || {!GVAR(sounds)} || {isNull _object} || {player distance _object > 30}) exitWith {};
// Same table on screen: the interface already plays this sound
if ((GVAR(state) getOrDefault ["id", -1]) == _id && {!isNull (uiNamespace getVariable [QGVAR(gameDisplay), displayNull])}) exitWith {};

private _file = (getArray (configFile >> "CfgSounds" >> format ["%1_%2", QGVAR(sfx), _sound] >> "sound")) param [0, ""];
if (_file isEqualTo "") exitWith {};
// playSound3D wants the path without its leading backslash (SQF strings do not escape "\")
if ((_file select [0, 1]) == "\") then {_file = _file select [1]};
// Local 3D sound, a little above the table top
playSound3D [_file, objNull, false, (getPosASL _object) vectorAdd [0, 0, 1], 1.4 * GVAR(soundVolume), 1, 25, 0, true];
