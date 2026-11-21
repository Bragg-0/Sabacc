#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Returns the localized name of a table status.
 *
 * Arguments:
 * 0: Status <STRING>
 *
 * Return Value:
 * Name <STRING>
 *
 * Example:
 * ["lobby"] call brg_game_fnc_statusName
 */
params [["_status", STATUS_LOBBY, [""]]];

switch (_status) do {
    case STATUS_PLAYING: {LLSTRING(StatusPlaying)};
    case STATUS_OVER: {LLSTRING(StatusOver)};
    default {LLSTRING(StatusLobby)};
}
