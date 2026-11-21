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
private _spectator = _state getOrDefault ["spectator", false];
private _isOwner = _seated && {!_spectator} && {(_state get "ownerUid") == getPlayerUID player};
private _seatedCount = {!(_x get "left")} count (_state getOrDefault ["players", []]);

// ---- Information panel ----
private _text = switch (true) do {
    case (GVAR(infoMode) == "rules"): {format ["<t size='0.85' color='%1'>%2</t>", HTML_TEXT, LLSTRING(RulesText)]};
    case (GVAR(infoMode) == "stats"): {[GVAR(statsData)] call FUNC(statsText)};
    case (_entry isNotEqualTo []): {
        _entry params ["", "_name", "_ownerName", "_names", "_max", "_status", ["_world", false], "", ["_watchers", 0]];
        private _full = count _names >= _max;
        private _statusColor = switch (_status) do {
            case STATUS_PLAYING: {HTML_AMBER};
            case STATUS_OVER: {HTML_MUTED};
            default {HTML_GOOD};
        };
        private _seats = [];
        for "_i" from 0 to (_max - 1) do {
            _seats pushBack (if (_i < count _names) then {
                format ["<t color='%1'>%2 </t><t color='%3'>%4</t>", HTML_HOLO, "+", HTML_TEXT, _names select _i]
            } else {
                format ["<t color='%1'>- %2</t>", HTML_DIM, LLSTRING(MenuFreeSeat)]
            });
        };
        [
            format ["<t size='1.15' font='PuristaBold' color='%1'>%2</t>", HTML_AMBER, toUpper _name],
            [LLSTRING(LabelHost), _ownerName, HTML_TEXT, 0.85] call FUNC(uiRow),
            [LLSTRING(LabelStatus), toUpper ([_status] call FUNC(statusName)), _statusColor, 0.85] call FUNC(uiRow),
            [LLSTRING(LabelSeats), format ["%1 / %2", count _names, _max], [HTML_TEXT, HTML_BAD] select _full, 0.85] call FUNC(uiRow),
            [LLSTRING(LabelSpectators), _watchers, HTML_HOLO, 0.85] call FUNC(uiRow),
            ["", format ["<t size='0.72' color='%1'>%2</t>", HTML_AMBER, LLSTRING(MenuPhysicalHint)]] select _world,
            "",
            format ["<t size='0.85'>%1</t>", _seats joinString "<br/>"]
        ] joinString "<br/>"
    };
    case (_lobby isEqualTo []): {format ["<t size='0.85' color='%1'>%2</t>", HTML_MUTED, LLSTRING(MenuNoTables)]};
    default {format ["<t size='0.85' color='%1'>%2</t>", HTML_MUTED, LLSTRING(MenuSelectTable)]};
};

// Seated: no need to create a table, the details use the whole column
{_x ctrlShow !_seated} forEach ((_display getVariable "newTable") + (_display getVariable "detailsShort"));
{_x ctrlShow _seated} forEach (_display getVariable "detailsTall");
private _groupHeight = [7.55, 12.05] select _seated;
private _infoGroup = _display getVariable "infoGroup";
_infoGroup ctrlSetPosition GRID(20.45,4.4,14.8,_groupHeight);
_infoGroup ctrlCommit 0;

private _info = _display getVariable "info";
_info ctrlSetStructuredText parseText _text;
private _position = ctrlPosition _info;
_position set [3, (ctrlTextHeight _info) max GH(_groupHeight)];
_info ctrlSetPosition _position;
_info ctrlCommit 0;

// ---- Seat status ----
private _seatText = if (_spectator) then {
    format [LLSTRING(MenuWatching), _state get "name"]
} else { if (_seated) then {
    private _line = format [LLSTRING(MenuSeatedAt), _state get "name", [_myStatus] call FUNC(statusName)];
    if (_myStatus != STATUS_PLAYING) then {
        _line = _line + "  " + ([LLSTRING(MenuWaitingHost), LLSTRING(MenuHostHint)] select _isOwner);
    };
    _line
} else {
    LLSTRING(MenuNotSeated)
}};
(_display getVariable "seat") ctrlSetStructuredText parseText format [
    "<t size='0.8' color='%1'>%2</t>", [HTML_MUTED, HTML_TEXT] select _seated, _seatText
];

// ---- Buttons ----
// Join a waiting table (terminal tables only: a physical table is joined on the spot),
// or watch a game in progress
private _entryStatus = _entry param [5, ""];
private _watch = _entryStatus in [STATUS_PLAYING, STATUS_OVER];
private _canJoin = !_seated && {_entry isNotEqualTo []} && {
    if (_watch) then {true} else {
        !(_entry param [6, false]) && {count (_entry select 3) < (_entry select 4)}
    }
};
private _btnJoin = _display getVariable "btnJoin";
_btnJoin ctrlEnable _canJoin;
_btnJoin setVariable [QGVAR(request), ["join", "watch"] select _watch];
_btnJoin ctrlSetText toUpper ([LLSTRING(MenuJoin), LLSTRING(MenuWatch)] select _watch);
_btnJoin ctrlSetTooltip ([LLSTRING(TipJoin), LLSTRING(TipWatch)] select _watch);
(_display getVariable "btnCreate") ctrlEnable !_seated;
(_display getVariable "btnLeave") ctrlEnable _seated;
(_display getVariable "btnLeave") ctrlSetText toUpper ([LLSTRING(MenuLeave), LLSTRING(StopWatching)] select _spectator);
(_display getVariable "btnStart") ctrlEnable (_isOwner && {_myStatus != STATUS_PLAYING} && {_seatedCount >= MIN_PLAYERS});
(_display getVariable "btnBot") ctrlEnable (_isOwner && {_myStatus != STATUS_PLAYING} && {_seatedCount < (_state get "maxPlayers")});
(_display getVariable "btnOpen") ctrlEnable (_myStatus in [STATUS_PLAYING, STATUS_OVER]);
(_display getVariable "btnRules") ctrlSetText toUpper ([LLSTRING(MenuRules), LLSTRING(MenuBack)] select (GVAR(infoMode) == "rules"));
(_display getVariable "btnStats") ctrlSetText toUpper ([LLSTRING(MenuStats), LLSTRING(MenuBack)] select (GVAR(infoMode) == "stats"));
