#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Saves the statistics in the server profile, so they survive mission restarts.
 * Called at the end of each game (not every round: saving the profile is slow).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
// Stored as [[uid, stats], ...] pairs
profileNamespace setVariable [QGVAR(stats), (keys GVAR(stats)) apply {[_x, GVAR(stats) get _x]}];
saveProfileNamespace;
