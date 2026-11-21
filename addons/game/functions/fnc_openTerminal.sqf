#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Opens the game screen if the player is in a game, the table menu otherwise.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
if (!hasInterface || {!isNull (findDisplay IDD_MENU)} || {!isNull (findDisplay IDD_GAME)}) exitWith {};

["refresh"] call FUNC(request);

if ((GVAR(state) getOrDefault ["status", ""]) in [STATUS_PLAYING, STATUS_OVER]) then {
    createDialog QGVAR(game);
} else {
    createDialog QGVAR(menu);
};
