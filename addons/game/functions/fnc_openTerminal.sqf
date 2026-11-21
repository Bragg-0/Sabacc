#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Opens the game screen if the player is in a game, the table menu otherwise.
 *
 * The dialog is created on the next frame: created in the same frame as the key press /
 * ACE action that asked for it, it can be closed right away by that input (key release,
 * interaction menu closing "the top dialog"). If it still did not open, one more try is made.
 *
 * Arguments:
 * 0: Retry count <NUMBER> (internal, default: 0)
 *
 * Return Value:
 * None
 */
params [["_try", 0, [0]]];

if (!hasInterface || {!isNull (findDisplay IDD_MENU)} || {!isNull (findDisplay IDD_GAME)}) exitWith {};

if (_try == 0) then {["refresh"] call FUNC(request)};

[{
    params ["_try"];
    if (!isNull (findDisplay IDD_MENU) || {!isNull (findDisplay IDD_GAME)}) exitWith {};

    private _inGame = (GVAR(state) getOrDefault ["status", ""]) in [STATUS_PLAYING, STATUS_OVER];
    private _dialog = [QGVAR(menu), QGVAR(game)] select _inGame;
    private _opened = createDialog _dialog;
    TRACE_2("openTerminal",_dialog,_opened);

    // Check two frames later that it is really there, retry once otherwise
    [{
        params ["_try"];
        if (isNull (findDisplay IDD_MENU) && {isNull (findDisplay IDD_GAME)} && {_try < 1}) then {
            WARNING("openTerminal: the dialog was closed right after opening, retrying");
            [_try + 1] call FUNC(openTerminal);
        };
    }, [_try], 2] call CBA_fnc_execAfterNFrames;
}, [_try]] call CBA_fnc_execNextFrame;
