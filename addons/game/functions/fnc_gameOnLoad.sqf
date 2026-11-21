#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds the game screen. Layout on the 40 x 25 GUI grid:
 *
 *   y 0      header (table name, round, turn, countdown)
 *   y 1.6    up to 3 opponents
 *   y 8.9    status line
 *   y 10.2   draw piles + dice choice  |  table log
 *   y 18.1   my hand, chips, actions, shift tokens
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */
params ["_display"];

uiNamespace setVariable [QGVAR(gameDisplay), _display];
GVAR(targeting) = -1;
GVAR(leaveConfirm) = false;

private _fnc_ctrl = {
    params ["_class", "_position"];
    [_display, _class, _position] call FUNC(createCtrl)
};
private _fnc_panel = {
    params ["_position", "_color"];
    private _panel = ["RscText", _position] call _fnc_ctrl;
    _panel ctrlSetBackgroundColor _color;
    _panel
};
private _fnc_picture = {
    params ["_position", ["_action", ""], ["_args", []]];
    private _picture = ["RscActivePicture", _position] call _fnc_ctrl;
    _picture ctrlSetTextColor COLOR_WHITE;
    _picture ctrlSetActiveColor COLOR_WHITE;
    if (_action != "") then {
        _picture setVariable [QGVAR(action), _action];
        _picture setVariable [QGVAR(args), _args];
        _picture ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrl"];
            [_ctrl getVariable QGVAR(action), _ctrl getVariable QGVAR(args)] call FUNC(gameAction);
        }];
    };
    _picture
};
private _fnc_button = {
    params ["_position"];
    private _button = ["RscButton", _position] call _fnc_ctrl;
    _button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        [_ctrl getVariable [QGVAR(action), ""], _ctrl getVariable [QGVAR(args), []]] call FUNC(gameAction);
    }];
    _button
};

// ---- Frame and header ----
[GRID(0,0,40,25), COLOR_PANEL] call _fnc_panel;
[GRID(0,0,40,1.3), COLOR_HEADER] call _fnc_panel;
_display setVariable ["title", ["RscStructuredText", GRID(0.3,0.15,20,1.1)] call _fnc_ctrl];
_display setVariable ["headerInfo", ["RscStructuredText", GRID(19,0.15,19.3,1.1)] call _fnc_ctrl];
private _close = ["RscButton", GRID(38.6,0.1,1.3,1.1)] call _fnc_ctrl;
_close ctrlSetText LLSTRING(MenuCloseShort);
_close ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay 2}];

// ---- Opponents ----
private _seats = [];
for "_i" from 0 to 2 do {
    private _x0 = 0.5 + _i * 13.1;
    // Created in drawing order: the target button must be last to stay on top
    private _seat = [
        [GRID(_x0,1.6,12.8,7), COLOR_PANEL_LIGHT] call _fnc_panel,
        ["RscStructuredText", GRID(_x0 + 0.2,1.7,12.4,1.1)] call _fnc_ctrl,
        ["RscStructuredText", GRID(_x0 + 0.2,2.7,12.4,1)] call _fnc_ctrl,
        ["RscPicture", GRID(_x0 + 0.6,3.5,2.5,5)] call _fnc_ctrl,
        ["RscPicture", GRID(_x0 + 3.6,3.5,2.5,5)] call _fnc_ctrl,
        ["RscStructuredText", GRID(_x0 + 7.4,3.8,5.2,3.4)] call _fnc_ctrl
    ];
    private _target = [GRID(_x0 + 7.4,7.25,5.2,1.15)] call _fnc_button;
    _target ctrlSetText LLSTRING(GameTarget);
    _target setVariable [QGVAR(action), "target"];
    _seat pushBack _target;
    _seats pushBack _seat;
};
_display setVariable ["seats", _seats];

// ---- Status line ----
_display setVariable ["statusLine", ["RscStructuredText", GRID(0.5,8.85,39,1.3)] call _fnc_ctrl];

// ---- Draw piles ----
[GRID(0.5,10.2,20.6,7.6), COLOR_PANEL_LIGHT] call _fnc_panel;
private _piles = [];
{
    _x params ["_x0", "_source", "_labelKey", "_tooltipKey"];
    private _pile = [GRID(_x0,10.3,3.6,7.2), "draw", [_source]] call _fnc_picture;
    _pile setVariable [QGVAR(source), _source];
    _pile ctrlSetTooltip localize _tooltipKey;
    private _label = ["RscStructuredText", GRID(_x0 - 0.7,16.7,5,1)] call _fnc_ctrl;
    _label setVariable [QGVAR(key), _labelKey];
    _piles pushBack [_pile, _label];
} forEach [
    [1.5, SOURCE_SAND_DECK, LSTRING(GameSandDeck), LSTRING(TooltipDrawDeck)],
    [6.3, SOURCE_SAND_DISCARD, LSTRING(GameSandDiscard), LSTRING(TooltipDrawDiscard)],
    [11.4, SOURCE_BLOOD_DISCARD, LSTRING(GameBloodDiscard), LSTRING(TooltipDrawDiscard)],
    [16.2, SOURCE_BLOOD_DECK, LSTRING(GameBloodDeck), LSTRING(TooltipDrawDeck)]
];
_display setVariable ["piles", _piles];

// ---- Dice choice (drawn above the piles) ----
_display setVariable ["choice", [
    [GRID(0.5,10.2,20.6,7.6), [0.02, 0.03, 0.05, 0.97]] call _fnc_panel,
    ["RscStructuredText", GRID(1,10.5,19.6,2)] call _fnc_ctrl,
    [GRID(5,12.6,4.4,4.4), "choose", [0]] call _fnc_picture,
    [GRID(12.2,12.6,4.4,4.4), "choose", [1]] call _fnc_picture
]];

// ---- Log ----
[GRID(21.5,10.2,18,7.6), COLOR_PANEL_LIGHT] call _fnc_panel;
_display setVariable ["log", ["RscStructuredText", GRID(21.7,10.3,17.6,7.4)] call _fnc_ctrl];

// ---- My hand ----
[GRID(0.5,18.1,39,6.5), COLOR_PANEL_LIGHT] call _fnc_panel;
_display setVariable ["myName", ["RscStructuredText", GRID(0.8,18.2,8.2,1.1)] call _fnc_ctrl];
_display setVariable ["mySand", [GRID(1,18.4,3.1,6.2), "swapCard", [SUIT_SAND]] call _fnc_picture];
_display setVariable ["myBlood", [GRID(4.4,18.4,3.1,6.2), "swapCard", [SUIT_BLOOD]] call _fnc_picture];
_display setVariable ["drawnLabel", ["RscStructuredText", GRID(8.3,18.2,4.2,1.1)] call _fnc_ctrl];
_display setVariable ["myDrawn", ["RscPicture", GRID(8.8,18.4,3.1,6.2)] call _fnc_ctrl];
_display setVariable ["handInfo", ["RscStructuredText", GRID(13,18.3,8.2,6.2)] call _fnc_ctrl];

_display setVariable ["buttons", [
    [GRID(21.4,19.4,6.6,1.4)] call _fnc_button,
    [GRID(21.4,21.05,6.6,1.4)] call _fnc_button,
    [GRID(21.4,22.7,6.6,1.4)] call _fnc_button
]];

// ---- Shift tokens ----
(["RscText", GRID(28.4,18.2,11,1.1)] call _fnc_ctrl) ctrlSetText LLSTRING(GameShiftsTitle);
private _slots = [];
for "_i" from 0 to 3 do {
    _slots pushBack ([GRID(28.5 + _i * 2.7,19.4,2.5,2.5), "shift", [_i]] call _fnc_picture);
};
_display setVariable ["shiftSlots", _slots];
_display setVariable ["shiftText", ["RscStructuredText", GRID(28.4,22,11,2.5)] call _fnc_ctrl];

// Countdown
GVAR(headerPFH) = [{call FUNC(gameUpdateHeader)}, 0.5] call CBA_fnc_addPerFrameHandler;

call FUNC(gameRefresh);
