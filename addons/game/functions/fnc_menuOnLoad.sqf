#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds the terminal menu (holographic style): list of tables, details,
 * new table, and create / join / leave / start / droid buttons.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */
params ["_display"];

uiNamespace setVariable [QGVAR(menuDisplay), _display];
hintSilent ""; // a Sabacc hint left on screen would cover the interface
GVAR(infoMode) = ""; // information panel: "", "rules" or "stats"

private _fnc_ctrl = {
    params ["_class", "_position", ["_group", controlNull]];
    [_display, _class, _position, _group] call FUNC(createCtrl)
};
private _fnc_rect = {
    params ["_position", "_color"];
    private _ctrl = [QGVAR(Text), _position] call _fnc_ctrl;
    _ctrl ctrlSetBackgroundColor _color;
    _ctrl
};
private _fnc_frame = {
    params ["_rect", ["_title", ""], ["_accent", COLOR_HOLO], ["_fill", COLOR_PANEL_LIGHT]];
    [_display, _rect, _title, _accent, _fill] call FUNC(uiFrame)
};
private _fnc_button = {
    params ["_textKey", "_position", "_code", ["_class", QGVAR(Button)], ["_tooltipKey", ""]];
    private _button = [_class, _position] call _fnc_ctrl;
    _button ctrlSetText toUpper localize _textKey;
    if (_tooltipKey != "") then {_button ctrlSetTooltip localize _tooltipKey};
    _button ctrlAddEventHandler ["ButtonClick", _code];
    _button
};

// ===================================================================== Main frame
[[4, 2, 32, 20.4], ([LLSTRING(MenuTitle)] call FUNC(uiTitle)), COLOR_AMBER, COLOR_PANEL] call _fnc_frame;
[LSTRING(MenuCloseShort), GRID(34.95,2.05,1,0.78), {(ctrlParent (_this select 0)) closeDisplay 2}, QGVAR(ButtonDanger), LSTRING(TipCloseTerminal)] call _fnc_button;

// ===================================================================== Tables
[[4.6, 3.4, 15, 13.2], [LLSTRING(PanelTables)] call FUNC(uiTitle)] call _fnc_frame;
private _list = [QGVAR(ListBox), GRID(4.85,4.45,14.5,11.95)] call _fnc_ctrl;
_list ctrlAddEventHandler ["LBSelChanged", {call FUNC(menuUpdateInfo)}];
_list ctrlSetTooltip LLSTRING(TipTableList);
_display setVariable ["list", _list];

// ===================================================================== Details (scrollable: the rules are long)
// Two versions of the frame: short (with the "new table" panel below) or full height (already seated)
_display setVariable ["detailsShort", [[20.2, 3.4, 15.2, 8.7], [LLSTRING(PanelDetails)] call FUNC(uiTitle)] call _fnc_frame];
_display setVariable ["detailsTall", [[20.2, 3.4, 15.2, 13.2], [LLSTRING(PanelDetails)] call FUNC(uiTitle)] call _fnc_frame];
private _infoGroup = ["RscControlsGroup", GRID(20.45,4.4,14.8,7.55)] call _fnc_ctrl;
_display setVariable ["infoGroup", _infoGroup];
private _info = [QGVAR(StructuredText), [0, 0, GW(14.1), GH(7.55)], _infoGroup] call _fnc_ctrl;
_display setVariable ["info", _info];

// ===================================================================== New table
private _newTable = [[20.2, 12.4, 15.2, 4.2], [LLSTRING(MenuNewTable)] call FUNC(uiTitle)] call _fnc_frame;
private _edit = [QGVAR(Edit), GRID(20.5,13.45,14.6,1.1)] call _fnc_ctrl;
_edit ctrlSetText format [LLSTRING(MenuDefaultName), name player];
_edit ctrlSetTooltip LLSTRING(TipTableName);
_display setVariable ["edit", _edit];

private _combo = [QGVAR(Combo), GRID(20.5,14.9,6.4,1.1)] call _fnc_ctrl;
for "_i" from MIN_PLAYERS to MAX_PLAYERS do {
    _combo lbSetValue [_combo lbAdd format [LLSTRING(MenuPlayersCount), _i], _i];
};
_combo lbSetCurSel (MAX_PLAYERS - MIN_PLAYERS);
_combo ctrlSetTooltip LLSTRING(TipMaxPlayers);
_display setVariable ["combo", _combo];

_display setVariable ["btnCreate", [LSTRING(MenuCreate), GRID(27.1,14.9,8,1.1), {
    private _display = ctrlParent (_this select 0);
    private _combo = _display getVariable "combo";
    ["create", [ctrlText (_display getVariable "edit"), _combo lbValue (lbCurSel _combo)]] call FUNC(request);
}, QGVAR(ButtonAccent), LSTRING(TipCreate)] call _fnc_button];
_display setVariable ["newTable", _newTable + [_edit, _combo, _display getVariable "btnCreate"]];

// ===================================================================== Seat status
[GRID(4.6,17,30.8,1.15), COLOR_STRIP] call _fnc_rect;
[GRID(4.6,17,0.15,1.15), COLOR_AMBER] call _fnc_rect;
_display setVariable ["seat", [QGVAR(StructuredText), GRID(5,17.05,30.3,1.05)] call _fnc_ctrl];
(_display getVariable "seat") ctrlSetTooltip LLSTRING(TipSeatLine);
(_display getVariable "info") ctrlSetTooltip LLSTRING(TipDetails);

// ===================================================================== Actions
_display setVariable ["btnJoin", [LSTRING(MenuJoin), GRID(4.6,18.55,7.4,1.4), {
    // Same button: "join" a waiting table, or "watch" a game in progress
    private _button = _this select 0;
    private _list = (ctrlParent _button) getVariable "list";
    if (lbCurSel _list < 0) exitWith {};
    [_button getVariable [QGVAR(request), "join"], [_list lbValue (lbCurSel _list)]] call FUNC(request);
}, QGVAR(ButtonAccent), LSTRING(TipJoin)] call _fnc_button];

_display setVariable ["btnLeave", [LSTRING(MenuLeave), GRID(12.4,18.55,7.4,1.4), {
    ["leave"] call FUNC(request);
}, QGVAR(ButtonDanger), LSTRING(TipLeaveTable)] call _fnc_button];

_display setVariable ["btnStart", [LSTRING(MenuStart), GRID(20.2,18.55,7.4,1.4), {
    ["start"] call FUNC(request);
}, QGVAR(ButtonAccent), LSTRING(TipStart)] call _fnc_button];

_display setVariable ["btnOpen", [LSTRING(MenuOpenGame), GRID(28,18.55,7.4,1.4), {
    (ctrlParent (_this select 0)) closeDisplay 2;
    [{createDialog QGVAR(game)}] call CBA_fnc_execNextFrame;
}, QGVAR(Button), LSTRING(TipOpenGame)] call _fnc_button];

_display setVariable ["btnRules", [LSTRING(MenuRules), GRID(4.6,20.45,7.4,1.3), {
    GVAR(infoMode) = ["rules", ""] select (GVAR(infoMode) == "rules");
    call FUNC(menuUpdateInfo);
}, QGVAR(Button), LSTRING(TipRules)] call _fnc_button];

_display setVariable ["btnBot", [LSTRING(MenuAddBot), GRID(12.4,20.45,7.4,1.3), {
    ["addBot"] call FUNC(request);
}, QGVAR(Button), LSTRING(MenuAddBotTip)] call _fnc_button];

_display setVariable ["btnStats", [LSTRING(MenuStats), GRID(20.2,20.45,7.4,1.3), {
    GVAR(infoMode) = ["stats", ""] select (GVAR(infoMode) == "stats");
    if (GVAR(infoMode) == "stats") then {["stats"] call FUNC(request)};
    call FUNC(menuUpdateInfo);
}, QGVAR(Button), LSTRING(TipStats)] call _fnc_button];

[LSTRING(MenuClose), GRID(28,20.45,7.4,1.3), {(ctrlParent (_this select 0)) closeDisplay 2}, QGVAR(Button), LSTRING(TipCloseTerminal)] call _fnc_button;

[_display] call FUNC(animFadeIn);
call FUNC(menuRefresh);
