#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Client initialization: receives the table view from the server and adds the
 * "Open Sabacc terminal" interaction (ACE self-interaction if ACE is loaded,
 * scroll-wheel action otherwise).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
if (!hasInterface) exitWith {};

GVAR(state) = createHashMap;
GVAR(targeting) = -1;
GVAR(leaveConfirm) = false;
GVAR(flash) = ["", -100];
GVAR(diceRolling) = false;
GVAR(openOnState) = false;    // open the screen when the server answers (physical tables)
GVAR(infoMode) = "";          // menu information panel: "", "rules" or "stats"
GVAR(statsData) = [];         // [my stats, top 5] received from the server

[EVENT_STATE, {
    params [["_view", createHashMap, [createHashMap]]];
    private _previous = GVAR(state);
    GVAR(state) = _view;
    [_previous] call FUNC(onStateChanged);
}] call CBA_fnc_addEventHandler;

[EVENT_NOTIFY, {
    params ["_key", ["_args", []]];
    GVAR(openOnState) = false; // a refused "sit" / "watch" must not open the screen later
    private _text = [_key, _args] call FUNC(formatMessage);
    GVAR(flash) = [_text, time];
    systemChat format ["[Sabacc] %1", _text];
    call FUNC(gameRefresh);
    call FUNC(menuRefresh);
}] call CBA_fnc_addEventHandler;

// The lobby is a public variable (so JIP players get it), and every change is also broadcast as an event
[QGVAR(lobbyChanged), {
    params [["_lobby", [], [[]]]];
    GVAR(lobby) = _lobby;
    call FUNC(worldTableScan);
    call FUNC(menuRefresh);
}] call CBA_fnc_addEventHandler;

// Statistics requested from the menu
[QGVAR(stats), {
    GVAR(statsData) = _this;
    call FUNC(menuUpdateInfo);
}] call CBA_fnc_addEventHandler;

// Physical tables already placed (JIP: the lobby public variable is already there).
// Next frame: compat_ace starts after this addon and must be listening first.
[{call FUNC(worldTableScan)}] call CBA_fnc_execNextFrame;

// Respawn: tell the server about the new unit so the table view keeps arriving
["unit", {
    if (count GVAR(state) > 0) then {["refresh"] call FUNC(request)};
}] call CBA_fnc_addPlayerEventHandler;

// With ACE, the self-interaction action comes from the brg_compat_ace addon (config only).
// Without ACE, a scroll-wheel action is added to the player.
if !(isClass (configFile >> "CfgPatches" >> "ace_interact_menu")) then {
    ["unit", {
        params ["_unit"];
        if (_unit getVariable [QGVAR(actionAdded), false]) exitWith {};
        _unit setVariable [QGVAR(actionAdded), true];
        _unit addAction [
            format ["<img image='%1'/> %2", TEXTURE_TERMINAL, LLSTRING(ActionOpen)],
            {[] call FUNC(openTerminal)},
            nil, 0.5, false, true, "",
            QUOTE([_this] call FUNC(canOpenTerminal))
        ];
    }, true] call CBA_fnc_addPlayerEventHandler;
};
