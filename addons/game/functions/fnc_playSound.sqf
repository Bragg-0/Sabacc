#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Plays a sound effect of the game in the interface (only for this player).
 *
 * Arguments:
 * 0: Sound name (see CfgSounds.hpp: "chips", "dice", "turn"...) <STRING>
 * 1: Delay in seconds <NUMBER> (default: 0)
 * 2: Volume factor <NUMBER> (default: 1)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["chips", 0.3] call brg_game_fnc_playSound
 */
params [["_sound", "", [""]], ["_delay", 0, [0]], ["_volume", 1, [0]]];

if (!GVAR(sounds) || {_sound isEqualTo ""}) exitWith {};
private _class = format ["%1_%2", QGVAR(sfx), _sound];
if (_delay > 0) exitWith {
    [{playSoundUI [_this select 0, _this select 1]}, [_class, _volume * GVAR(soundVolume)], _delay] call CBA_fnc_waitAndExecute;
};
playSoundUI [_class, _volume * GVAR(soundVolume)];
