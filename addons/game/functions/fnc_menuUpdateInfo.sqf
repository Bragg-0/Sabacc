#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Updates the information panel and the buttons of the terminal menu.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _display = uiNamespace getVariable [QGVAR(menuDisplay), displayNull];
if (isNull _display) exitWith {};

private _lobby = missionNamespace getVariable [QGVAR(lobby), []];
private _list = _display getVariable "list";
private _selected = lbCurSel _list;
private _selectedId = if (_selected >= 0) then {_list lbValue _selected} else {-1};
private _entryIndex = _lobby findIf {(_x select 0) == _selectedId};
private _entry = if (_entryIndex >= 0) then {_lobby select _entryIndex} else {[]};

private _state = GVAR(state);
private _seated = count _state > 0;
private _myStatus = _state getOrDefault ["status", ""];
private _isOwner = _seated && {(_state get "ownerUid") == getPlayerUID player};
private _seatedCount = {!(_x get "left")} count (_state getOrDefault ["players", []]);

// ---- Information panel ----
private _text = switch (true) do {
    case (GVAR(showRules)): {LLSTRING(RulesText)};
    case (_entry isNotEqualTo []): {
        _entry params ["", "_name", "_ownerName", "_names", "_max", "_status"];
        format [
            "<t size='1.2' font='PuristaBold'>%1</t><br/>%2<br/>%3<br/><br/><t color='#ffe0a0'>%4 (%5/%6)</t><br/>%7",
            _name,
            format [LLSTRING(MenuOwner), _ownerName],
            [_status] call FUNC(statusName),
            LLSTRING(MenuPlayers), count _names, _max,
            _names joinString "<br/>"
        ]
    };
    case (_lobby isEqualTo []): {LLSTRING(MenuNoTables)};
    default {LLSTRING(MenuSelectTable)};
};

private _info = _display getVariable "info";
_info ctrlSetStructuredText parseText _text;
private _position = ctrlPosition _info;
_position set [3, (ctrlTextHeight _info) max GH(8.7)];
_info ctrlSetPosition _position;
_info ctrlCommit 0;

// ---- Seat status ----
private _seatText = if (_seated) then {
    private _line = format [LLSTRING(MenuSeatedAt), _state get "name", [_myStatus] call FUNC(statusName)];
    if (_myStatus != STATUS_PLAYING) then {
        _line = _line + "  " + ([LLSTRING(MenuWaitingHost), LLSTRING(MenuHostHint)] select _isOwner);
    };
    _line
} else {
    LLSTRING(MenuNotSeated)
};
(_display getVariable "seat") ctrlSetStructuredText parseText _seatText;

// ---- Buttons ----
private _canJoin = !_seated
    && {_entry isNotEqualTo []}
    && {(_entry select 5) != STATUS_PLAYING}
    && {count (_entry select 3) < (_entry select 4)};

(_display getVariable "btnJoin") ctrlEnable _canJoin;
(_display getVariable "btnCreate") ctrlEnable !_seated;
(_display getVariable "btnLeave") ctrlEnable _seated;
(_display getVariable "btnStart") ctrlEnable (_isOwner && {_myStatus != STATUS_PLAYING} && {_seatedCount >= MIN_PLAYERS});
(_display getVariable "btnBot") ctrlEnable (_isOwner && {_myStatus != STATUS_PLAYING} && {_seatedCount < (_state get "maxPlayers")});
(_display getVariable "btnOpen") ctrlEnable (_myStatus in [STATUS_PLAYING, STATUS_OVER]);
(_display getVariable "btnRules") ctrlSetText ([LLSTRING(MenuRules), LLSTRING(MenuBack)] select GVAR(showRules));
