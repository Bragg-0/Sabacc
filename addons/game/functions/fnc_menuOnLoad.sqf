#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds the terminal menu (list of tables, create / join / leave / start).
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */
params ["_display"];

uiNamespace setVariable [QGVAR(menuDisplay), _display];
GVAR(showRules) = false;

private _fnc_ctrl = {
    params ["_class", "_position", ["_group", controlNull]];
    [_display, _class, _position, _group] call FUNC(createCtrl)
};
private _fnc_button = {
    params ["_textKey", "_position", "_code"];
    private _button = ["RscButton", _position] call _fnc_ctrl;
    _button ctrlSetText localize _textKey;
    _button ctrlAddEventHandler ["ButtonClick", _code];
    _button
};

// Frame
(["RscText", GRID(5,2.5,30,20)] call _fnc_ctrl) ctrlSetBackgroundColor COLOR_PANEL;
(["RscText", GRID(5,2.5,30,1.3)] call _fnc_ctrl) ctrlSetBackgroundColor COLOR_HEADER;
(["RscStructuredText", GRID(5.3,2.6,25,1.1)] call _fnc_ctrl) ctrlSetStructuredText parseText format [
    "<t font='PuristaBold' size='1.05'>%1</t>", LLSTRING(MenuTitle)
];
[LSTRING(MenuCloseShort), GRID(33.6,2.6,1.3,1.1), {(ctrlParent (_this select 0)) closeDisplay 2}] call _fnc_button;

// Table list
(["RscText", GRID(5.5,4.1,14,1)] call _fnc_ctrl) ctrlSetText LLSTRING(MenuTables);
private _list = ["RscListBox", GRID(5.5,5.1,14,11.1)] call _fnc_ctrl;
_list ctrlAddEventHandler ["LBSelChanged", {call FUNC(menuUpdateInfo)}];
_display setVariable ["list", _list];

// Information panel (scrollable: the rules are long)
(["RscText", GRID(20,4.1,14.5,8.9)] call _fnc_ctrl) ctrlSetBackgroundColor COLOR_PANEL_LIGHT;
private _infoGroup = ["RscControlsGroup", GRID(20.1,4.2,14.3,8.7)] call _fnc_ctrl;
private _info = ["RscStructuredText", [0, 0, GW(13.6), GH(8.7)], _infoGroup] call _fnc_ctrl;
_display setVariable ["info", _info];

// New table
(["RscText", GRID(20,13.2,14.5,1)] call _fnc_ctrl) ctrlSetText LLSTRING(MenuNewTable);
private _edit = ["RscEdit", GRID(20,14.2,14.5,1.1)] call _fnc_ctrl;
_edit ctrlSetText format [LLSTRING(MenuDefaultName), name player];
_display setVariable ["edit", _edit];

private _combo = ["RscCombo", GRID(20,15.6,6.5,1.1)] call _fnc_ctrl;
for "_i" from MIN_PLAYERS to MAX_PLAYERS do {
    _combo lbSetValue [_combo lbAdd format [LLSTRING(MenuPlayersCount), _i], _i];
};
_combo lbSetCurSel (MAX_PLAYERS - MIN_PLAYERS);
_display setVariable ["combo", _combo];

_display setVariable ["btnCreate", [LSTRING(MenuCreate), GRID(26.8,15.6,7.7,1.1), {
    private _display = ctrlParent (_this select 0);
    private _combo = _display getVariable "combo";
    ["create", [ctrlText (_display getVariable "edit"), _combo lbValue (lbCurSel _combo)]] call FUNC(request);
}] call _fnc_button];

// Seat status
private _seat = ["RscStructuredText", GRID(5.5,16.5,29,1.2)] call _fnc_ctrl;
_display setVariable ["seat", _seat];

// Actions
_display setVariable ["btnJoin", [LSTRING(MenuJoin), GRID(5.5,18,7,1.4), {
    private _list = (ctrlParent (_this select 0)) getVariable "list";
    if (lbCurSel _list < 0) exitWith {};
    ["join", [_list lbValue (lbCurSel _list)]] call FUNC(request);
}] call _fnc_button];

_display setVariable ["btnLeave", [LSTRING(MenuLeave), GRID(12.8,18,7,1.4), {
    ["leave"] call FUNC(request);
}] call _fnc_button];

_display setVariable ["btnStart", [LSTRING(MenuStart), GRID(20.1,18,7,1.4), {
    ["start"] call FUNC(request);
}] call _fnc_button];

_display setVariable ["btnOpen", [LSTRING(MenuOpenGame), GRID(27.4,18,7.1,1.4), {
    (ctrlParent (_this select 0)) closeDisplay 2;
    [{createDialog QGVAR(game)}] call CBA_fnc_execNextFrame;
}] call _fnc_button];

_display setVariable ["btnRules", [LSTRING(MenuRules), GRID(5.5,20.3,7,1.4), {
    GVAR(showRules) = !GVAR(showRules);
    call FUNC(menuUpdateInfo);
}] call _fnc_button];

_display setVariable ["btnBot", [LSTRING(MenuAddBot), GRID(12.8,20.3,7,1.4), {
    ["addBot"] call FUNC(request);
}] call _fnc_button];
(_display getVariable "btnBot") ctrlSetTooltip LLSTRING(MenuAddBotTip);

[LSTRING(MenuClose), GRID(27.4,20.3,7.1,1.4), {(ctrlParent (_this select 0)) closeDisplay 2}] call _fnc_button;

call FUNC(menuRefresh);
