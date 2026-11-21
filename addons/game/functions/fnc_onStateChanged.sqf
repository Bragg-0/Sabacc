#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Reacts to a new table view from the server: switches screens and refreshes them.
 *
 * Arguments:
 * 0: Previous view <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_previous"];

private _state = GVAR(state);
private _status = _state getOrDefault ["status", ""];
private _myUid = getPlayerUID player;

// Left the table: close the game screen
if (count _state == 0) then {
    private _game = findDisplay IDD_GAME;
    if (!isNull _game) then {_game closeDisplay 2};
};

// The game just started: move everyone from the menu to the game screen
if (_status == STATUS_PLAYING && {(_previous getOrDefault ["status", ""]) != STATUS_PLAYING}) then {
    private _menu = findDisplay IDD_MENU;
    if (isNull _menu) then {
        hint LLSTRING(HintGameStarted);
    } else {
        _menu closeDisplay 2;
        [{createDialog QGVAR(game)}] call CBA_fnc_execNextFrame;
    };
};

// It just became my turn while the terminal is closed
private _myTurn = (_state getOrDefault ["current", ""]) == _myUid;
if (_myTurn && {(_previous getOrDefault ["current", ""]) != _myUid} && {isNull (findDisplay IDD_GAME)}) then {
    hint LLSTRING(HintYourTurn);
};

if (!_myTurn) then {GVAR(targeting) = -1};

call FUNC(menuRefresh);
call FUNC(gameRefresh);
