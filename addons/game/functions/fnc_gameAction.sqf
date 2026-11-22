#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Handles a click on the game screen and forwards it to the server.
 * Nothing is decided here: the server validates every request.
 *
 * Arguments:
 * 0: Action <STRING>
 * 1: Arguments <ARRAY>
 *
 * Return Value:
 * None
 */
params [["_action", "", [""]], ["_args", [], [[]]]];

// No interaction with the table while a banner is shown
if (diag_tickTime < (missionNamespace getVariable [QGVAR(bannerUntil), 0])) exitWith {};

private _state = GVAR(state);
if (count _state == 0) exitWith {};

private _players = _state get "players";
private _myIndex = _players findIf {(_x get "uid") == getPlayerUID player};

// A spectator only stops watching or moves between screens
if (_myIndex < 0) exitWith {
    switch (_action) do {
        case "leave": {["leave"] call FUNC(request)};
        case "hideEnd": {GVAR(endHidden) = true; call FUNC(gameRefresh)};
        case "showEnd": {GVAR(endHidden) = false; call FUNC(gameRefresh)};
        case "backToMenu": {
            (uiNamespace getVariable [QGVAR(gameDisplay), displayNull]) closeDisplay 2;
            [{createDialog QGVAR(menu)}] call CBA_fnc_execNextFrame;
        };
    };
};
private _me = _players select _myIndex;

if (_action in ["stand", "takeDrawn", "keepHand", "start", "target", "shift", "choose"]) then {["click", 0, 0.6] call FUNC(playSound)};

switch (_action) do {
    case "draw": {["draw", _args] call FUNC(request)};
    case "stand": {["stand"] call FUNC(request)};
    case "takeDrawn": {["discard", [1]] call FUNC(request)};
    case "keepHand": {["discard", [0]] call FUNC(request)};
    case "swapCard": {
        // Clicking the hand card of the same suit as the drawn card replaces it
        _args params ["_suit"];
        private _drawn = _me get "drawn";
        if (_drawn >= 0 && {CARD_SUIT(_drawn) == _suit}) then {["discard", [1]] call FUNC(request)};
    };
    case "choose": {["choose", _args] call FUNC(request)};
    case "shift": {
        _args params ["_slot"];
        private _shift = (_me get "shifts") param [_slot, -1];
        if (_shift < 0) exitWith {};
        if (GVAR(targeting) == _shift) exitWith {GVAR(targeting) = -1}; // second click cancels

        if (([_shift] call FUNC(shiftInfo)) select 2) then {
            GVAR(targeting) = _shift;
        } else {
            ["shift", [_shift]] call FUNC(request);
        };
    };
    case "target": {
        _args params ["_uid"];
        private _shift = GVAR(targeting);
        GVAR(targeting) = -1;
        if (_shift > 0) then {["shift", [_shift, _uid]] call FUNC(request)};
    };
    case "start": {
        GVAR(endHidden) = false;
        ["start"] call FUNC(request);
    };
    case "hideEnd": {GVAR(endHidden) = true};   // look at the final table
    case "showEnd": {GVAR(endHidden) = false};
    case "backToMenu": {
        (uiNamespace getVariable [QGVAR(gameDisplay), displayNull]) closeDisplay 2;
        [{createDialog QGVAR(menu)}] call CBA_fnc_execNextFrame;
    };
    case "leave": {
        // During a game, leaving means forfeiting: ask for a second click
        if (GVAR(leaveConfirm) || {(_state get "status") != STATUS_PLAYING} || {_me get "out"}) then {
            GVAR(leaveConfirm) = false;
            ["leave"] call FUNC(request);
        } else {
            GVAR(leaveConfirm) = true;
            [{
                GVAR(leaveConfirm) = false;
                call FUNC(gameRefresh);
            }, [], 3] call CBA_fnc_waitAndExecute;
        };
    };
};

call FUNC(gameRefresh);
