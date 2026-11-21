#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Called every 0.5 s: makes the active areas "breathe" (my hand when it is my turn,
 * the seat of the player who is playing, the winners during the results).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _display = uiNamespace getVariable [QGVAR(gameDisplay), displayNull];
private _state = GVAR(state);
if (isNull _display || {count _state == 0}) exitWith {};

GVAR(pulse) = !GVAR(pulse);

private _myUid = getPlayerUID player;
private _current = _state getOrDefault ["current", ""];
private _showResults = (_state get "phase") == PHASE_RESULTS || {(_state get "status") == STATUS_OVER};
private _winners = ((_state get "results") select {_x select 6}) apply {_x select 0};
private _fnc_highlighted = {
    params ["_uid"];
    _uid == _current || {_showResults && {_uid in _winners}}
};

// My hand
private _myTurn = _current == _myUid;
private _myPanel = _display getVariable "myPanel";
private _myHighlight = [_myUid] call _fnc_highlighted;
_myPanel ctrlSetBackgroundColor ([COLOR_PANEL_LIGHT, [COLOR_ACTIVE, COLOR_WIN] select _showResults] select _myHighlight);
_myPanel ctrlSetFade ([0, 0.5] select (_myHighlight && GVAR(pulse)));
_myPanel ctrlCommit 0.5;

// Opponents
private _seatUids = _display getVariable ["seatUids", []];
{
    private _bg = _x select 0;
    private _highlight = [_seatUids param [_forEachIndex, ""]] call _fnc_highlighted;
    _bg ctrlSetFade ([0, 0.45] select (_highlight && GVAR(pulse)));
    _bg ctrlCommit 0.5;
} forEach (_display getVariable "seats");

// Status line
private _statusLine = _display getVariable "statusLine";
_statusLine ctrlSetFade ([0, 0.35] select (_myTurn && GVAR(pulse)));
_statusLine ctrlCommit 0.5;
