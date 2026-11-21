#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Builds the game screen (holographic style). Layout on the 40 x 25 GUI grid:
 *
 *   y 0      header: table, round, turn pips, countdown + bar
 *   y 2      up to 3 opponents (cards, chips / pot / shifts, last action)
 *   y 9.25   status line
 *   y 10.6   draw piles (+ dice choice overlay)  |  table log
 *   y 18.3   my station: cards, stats, actions, shift tokens, analysis
 *
 * Controls read by other functions are stored as display variables
 * (seats, piles, choice, mySand, myBlood, myDrawn, handInfo, myPanel, statusLine...).
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 */
params ["_display"];

uiNamespace setVariable [QGVAR(gameDisplay), _display];
hintSilent ""; // a Sabacc hint left on screen would cover the interface
GVAR(targeting) = -1;
GVAR(leaveConfirm) = false;
GVAR(lastView) = createHashMap; // makes the first refresh play the dealing animation
GVAR(pulse) = false;
GVAR(bannerUntil) = 0;

private _fnc_ctrl = {
    params ["_class", "_position"];
    [_display, _class, _position] call FUNC(createCtrl)
};
private _fnc_rect = {
    params ["_position", "_color"];
    private _ctrl = [QGVAR(Text), _position] call _fnc_ctrl;
    _ctrl ctrlSetBackgroundColor _color;
    _ctrl
};
private _fnc_frame = {
    params ["_rect", ["_title", ""], ["_accent", COLOR_HOLO]];
    [_display, _rect, _title, _accent] call FUNC(uiFrame)
};
private _fnc_text = {
    params ["_position", ["_text", ""]];
    private _ctrl = [QGVAR(StructuredText), _position] call _fnc_ctrl;
    _ctrl ctrlSetStructuredText parseText _text;
    _ctrl
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
            if !(_ctrl getVariable [QGVAR(clickable), false]) exitWith {};
            [_ctrl, 1] call FUNC(animScale);
            [_ctrl getVariable QGVAR(action), _ctrl getVariable QGVAR(args)] call FUNC(gameAction);
        }];
    };
    // Hover: grows a little when usable, and explains itself in the analysis panel.
    // Pictures stay enabled (so hovering always works), "clickable" decides if a click does something.
    _picture ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrl"];
        private _banner = diag_tickTime < (missionNamespace getVariable [QGVAR(bannerUntil), 0]);
        if (!_banner && {_ctrl getVariable [QGVAR(clickable), false]}) then {[_ctrl, 1.08] call FUNC(animScale)};
        private _help = _ctrl getVariable [QGVAR(help), ""];
        if (_help != "") then {((ctrlParent _ctrl) getVariable "inspector") ctrlSetStructuredText parseText _help};
    }];
    _picture ctrlAddEventHandler ["MouseExit", {
        params ["_ctrl"];
        [_ctrl, 1] call FUNC(animScale);
        private _display = ctrlParent _ctrl;
        (_display getVariable "inspector") ctrlSetStructuredText parseText (_display getVariable ["inspectorDefault", ""]);
    }];
    _picture
};
private _fnc_button = {
    params ["_position", ["_class", QGVAR(Button)]];
    private _button = [_class, _position] call _fnc_ctrl;
    _button ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        [_ctrl getVariable [QGVAR(action), ""], _ctrl getVariable [QGVAR(args), []]] call FUNC(gameAction);
    }];
    _button
};
private _fnc_caption = {
    params ["_position", "_text", ["_color", HTML_MUTED]];
    [_position, format ["<t align='center' size='0.65' font='PuristaSemibold' color='%1'>%2</t>", _color, toUpper _text]] call _fnc_text
};

// ===================================================================== Background
[GRID(0,0,40,25), COLOR_PANEL] call _fnc_rect;

// ===================================================================== Header
[GRID(0,0,40,1.6), COLOR_HEADER] call _fnc_rect;
[GRID(0,1.55,40,0.05), COLOR_HOLO_FAINT] call _fnc_rect;
[GRID(0,0,0.25,1.6), COLOR_AMBER] call _fnc_rect;

_display setVariable ["title", [GRID(0.6,0.05,15.3,1.5)] call _fnc_text];
// Round on top, then turn (or phase) with its 3 pips underneath
_display setVariable ["roundInfo", [GRID(18.5,0.05,9.2,0.85)] call _fnc_text];
_display setVariable ["phaseInfo", [GRID(18.5,0.8,5.85,0.75)] call _fnc_text];
_display setVariable ["turnPips", [0, 1, 2] apply {[GRID(24.6 + _x * 1.05,1.0,0.9,0.36), COLOR_HOLO_FAINT] call _fnc_rect}];

_display setVariable ["timerText", [GRID(28.4,0.1,9.9,1.1)] call _fnc_text];
[GRID(28.6,1.18,9.6,0.18), [0.37, 0.85, 1, 0.12]] call _fnc_rect;
_display setVariable ["timerBar", [GRID(28.6,1.18,9.6,0.18), COLOR_HOLO] call _fnc_rect];

private _close = [QGVAR(ButtonDanger), GRID(38.65,0.2,1.15,1.15)] call _fnc_ctrl;
_close ctrlSetText "X";
_close ctrlSetTooltip LLSTRING(MenuClose);
_close ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay 2}];

// ===================================================================== Opponents
private _seats = [];
private _seatShifts = [];
for "_i" from 0 to 2 do {
    private _x0 = 0.5 + _i * 13.1;
    private _frame = [[_x0, 2, 12.8, 7], " "] call _fnc_frame;
    _frame params ["_fill", "_title"];

    private _sand = ["RscPicture", GRID(_x0 + 0.5,3.05,2.6,5.2)] call _fnc_ctrl;
    private _blood = ["RscPicture", GRID(_x0 + 3.35,3.05,2.6,5.2)] call _fnc_ctrl;
    private _stats = [GRID(_x0 + 6.3,3.05,6.1,2.2)] call _fnc_text;
    _stats ctrlSetTooltip LLSTRING(TipSeatStats);
    private _status = [GRID(_x0 + 6.3,6.4,6.1,1.4)] call _fnc_text;

    private _extras = (_frame select [2, count _frame]) + [
        [GRID(_x0 + 0.3,8.1,3,0.7), LLSTRING(Sand), HTML_SAND] call _fnc_caption,
        [GRID(_x0 + 3.15,8.1,3,0.7), LLSTRING(Blood), HTML_BLOOD] call _fnc_caption,
        [GRID(_x0 + 6.3,6.35,6.1,0.04), COLOR_HOLO_FAINT] call _fnc_rect
    ];
    private _bonusLabel = [GRID(_x0 + 6.3,5.3,2.4,0.9), format ["<t size='0.72' color='%1'>%2</t>", HTML_MUTED, toUpper LLSTRING(LabelShifts)]] call _fnc_text;

    // Shift tokens of this opponent (hover = description in the analysis panel)
    private _icons = [];
    for "_j" from 0 to 3 do {
        _icons pushBack ([GRID(_x0 + 8.75 + _j * 0.95,5.25,0.9,0.9)] call _fnc_picture);
    };
    _seatShifts pushBack ([_bonusLabel] + _icons); // index 0 = "BONUS" label, then 4 icons

    private _target = [GRID(_x0 + 6.3,7.85,6.1,0.95), QGVAR(ButtonAccent)] call _fnc_button;
    _target ctrlSetText toUpper LLSTRING(GameTarget);
    _target setVariable [QGVAR(action), "target"];

    // Indexes 0..6 are used by gameRefresh / gameAnimate / gamePulse
    _seats pushBack ([_fill, _title, _stats, _sand, _blood, _status, _target] + _extras);
};
_display setVariable ["seats", _seats];
_display setVariable ["seatShifts", _seatShifts];

// ===================================================================== Status line
[GRID(0.5,9.25,39,1.1), COLOR_STRIP] call _fnc_rect;
[GRID(0.5,9.25,0.15,1.1), COLOR_AMBER] call _fnc_rect;
[GRID(39.35,9.25,0.15,1.1), COLOR_AMBER] call _fnc_rect;
[GRID(0.5,10.3,39,0.05), COLOR_HOLO_FAINT] call _fnc_rect;
_display setVariable ["statusLine", [GRID(1,9.3,38,1)] call _fnc_text];

// ===================================================================== Table: draw piles
[[0.5, 10.6, 20.6, 7.4], [LLSTRING(PanelTable)] call FUNC(uiTitle)] call _fnc_frame;
[GRID(1,11.55,9.5,0.7), format ["<t size='0.7' font='PuristaSemibold' color='%1'>%2</t>", HTML_SAND, toUpper LLSTRING(Sand)]] call _fnc_text;
[GRID(11.1,11.55,9.5,0.7), format ["<t size='0.7' font='PuristaSemibold' color='%1' align='right'>%2</t>", HTML_BLOOD, toUpper LLSTRING(Blood)]] call _fnc_text;
[GRID(10.78,11.7,0.05,5.9), COLOR_HOLO_FAINT] call _fnc_rect;

private _piles = [];
{
    _x params ["_x0", "_source"];
    private _pile = [GRID(_x0,12.05,2.7,5.4), "draw", [_source]] call _fnc_picture;
    _pile setVariable [QGVAR(source), _source];
    private _label = [GRID(_x0 - 0.9,17.05,4.5,0.8)] call _fnc_text;
    _piles pushBack [_pile, _label];
} forEach [
    [1.9, SOURCE_SAND_DECK],
    [6.3, SOURCE_SAND_DISCARD],
    [12.6, SOURCE_BLOOD_DISCARD],
    [17.0, SOURCE_BLOOD_DECK]
];
_display setVariable ["piles", _piles];

// Dice choice, drawn above the piles
_display setVariable ["choice", [
    [GRID(0.55,10.65,20.5,7.3), [0.01, 0.04, 0.07, 0.97]] call _fnc_rect,
    [GRID(1,11.1,19.6,1.9)] call _fnc_text,
    [GRID(5.6,13.0,3.4,3.4), "choose", [0]] call _fnc_picture,
    [GRID(12.1,13.0,3.4,3.4), "choose", [1]] call _fnc_picture,
    // Value of each die + what it would give (indexes 4 and 5)
    [GRID(3.3,16.35,8,1.55)] call _fnc_text,
    [GRID(9.8,16.35,8,1.55)] call _fnc_text
]];

// ===================================================================== Log
[[21.5, 10.6, 18, 7.4], [LLSTRING(PanelLog)] call FUNC(uiTitle)] call _fnc_frame;
_display setVariable ["log", [GRID(21.8,11.55,17.4,6.35)] call _fnc_text];

// ===================================================================== My station
private _myFrame = [[0.5, 18.3, 39, 6.4], " ", COLOR_AMBER] call _fnc_frame;
_display setVariable ["myPanel", _myFrame select 0];
_display setVariable ["myTitle", _myFrame select 1];

_display setVariable ["mySand", [GRID(1,19.3,2.5,5), "swapCard", [SUIT_SAND]] call _fnc_picture];
_display setVariable ["myBlood", [GRID(3.8,19.3,2.5,5), "swapCard", [SUIT_BLOOD]] call _fnc_picture];
_display setVariable ["myDrawn", [GRID(7.1,19.3,2.5,5), "keepHand", []] call _fnc_picture]; // click = discard it
_display setVariable ["myCaptions", [
    [GRID(0.75,23.95,3,0.7), LLSTRING(Sand), HTML_SAND] call _fnc_caption,
    [GRID(3.55,23.95,3,0.7), LLSTRING(Blood), HTML_BLOOD] call _fnc_caption
]];
_display setVariable ["drawnLabel", [GRID(6.85,23.95,3,0.7), LLSTRING(GameDrawnCard), HTML_AMBER] call _fnc_caption];

private _divider1 = [GRID(10,19.35,0.05,5.1), COLOR_HOLO_FAINT] call _fnc_rect;
_display setVariable ["handInfo", [GRID(10.3,19.25,9.4,5.3)] call _fnc_text];
_display setVariable ["outBanner", [GRID(0.8,19.3,18.9,5.2)] call _fnc_text]; // shown when eliminated
private _divider2 = [GRID(19.95,19.35,0.05,5.1), COLOR_HOLO_FAINT] call _fnc_rect;
_display setVariable ["myDividers", [_divider1, _divider2]]; // hidden when eliminated

_display setVariable ["buttons", [
    [GRID(20.3,19.4,7.3,1.45), QGVAR(ButtonAccent)] call _fnc_button,
    [GRID(20.3,21.05,7.3,1.45)] call _fnc_button,
    [GRID(20.3,23.05,7.3,1.2), QGVAR(ButtonDanger)] call _fnc_button
]];

[GRID(27.95,19.35,0.05,5.1), COLOR_HOLO_FAINT] call _fnc_rect;
_display setVariable ["shiftsTitle", [GRID(28.3,19.2,11,0.8), [LLSTRING(PanelShifts)] call FUNC(uiTitle)] call _fnc_text];
private _slots = [];
for "_i" from 0 to 3 do {
    _slots pushBack ([GRID(28.45 + _i * 2.3,20.0,1.9,1.9), "shift", [_i]] call _fnc_picture);
};
_display setVariable ["shiftSlots", _slots];

// Analysis panel: explains what the mouse is over
[GRID(28.3,22.0,11,2.55), COLOR_STRIP] call _fnc_rect;
[GRID(28.3,22.0,0.1,2.55), COLOR_HOLO] call _fnc_rect;
private _inspector = [GRID(28.55,22.02,10.7,2.5)] call _fnc_text;
_display setVariable ["inspector", _inspector];
_display setVariable ["shiftText", _inspector];

// ===================================================================== End screen (created last: drawn above everything)
GVAR(endHidden) = false;
private _endDim = [GRID(0,1.6,40,23.4), [0, 0, 0, 0.78]] call _fnc_rect;
private _endFrame = [[8, 3.2, 24, 18.8], [LLSTRING(EndTitle)] call FUNC(uiTitle), COLOR_AMBER] call _fnc_frame;
(_endFrame select 0) ctrlSetBackgroundColor COLOR_PANEL;

private _endTitle = [GRID(8.5,4.25,23,3.0)] call _fnc_text;
private _endSubtitle = [GRID(8.5,7.3,23,1.1)] call _fnc_text;
private _endLine = [GRID(9,8.55,22,0.05), COLOR_HOLO_FAINT] call _fnc_rect;

// Ranking table: fixed columns, one line per player (max 4)
// Columns: rank | player | status | rounds won | chips
private _columns = [[9.2, 1.8], [11, 7.6], [18.6, 6.2], [24.8, 3.6], [28.4, 2.6]];
private _endTable = [];
private _header = _columns apply {[GRID(_x select 0,8.85,_x select 1,0.9)] call _fnc_text};
{
    _x ctrlSetTooltip LLSTRING(TipEndRanking);
} forEach _header;
_endTable append _header;
_endTable pushBack ([GRID(9,9.8,22,0.05), COLOR_HOLO_FAINT] call _fnc_rect);

private _endRows = [];
for "_r" from 0 to 3 do {
    private _y = 10.05 + _r * 1.85;
    private _stripe = [GRID(9,_y,22,1.65), [0.37, 0.85, 1, [0.08, 0.04] select (_r mod 2)]] call _fnc_rect;
    private _cells = _columns apply {[GRID(_x select 0,_y + 0.25,_x select 1,1.2)] call _fnc_text};
    _endRows pushBack ([_stripe] + _cells);
    _endTable append ([_stripe] + _cells);
};

private _endButtons = [
    [GRID(9,17.95,10.8,1.4), QGVAR(ButtonAccent)] call _fnc_button,
    [GRID(20.2,17.95,10.8,1.4)] call _fnc_button,
    [GRID(9,19.7,10.8,1.4)] call _fnc_button,
    [GRID(20.2,19.7,10.8,1.4), QGVAR(ButtonDanger)] call _fnc_button
];
{
    _x params ["_button", "_action", "_textKey", "_tipKey"];
    _button setVariable [QGVAR(action), _action];
    _button ctrlSetText toUpper localize _textKey;
    _button ctrlSetTooltip localize _tipKey;
} forEach [
    [_endButtons select 0, "start", LSTRING(GameRestart), LSTRING(TipStart)],
    [_endButtons select 1, "hideEnd", LSTRING(EndReview), LSTRING(TipEndReview)],
    [_endButtons select 2, "backToMenu", LSTRING(EndBackToMenu), LSTRING(TipEndBackToMenu)],
    [_endButtons select 3, "leave", LSTRING(GameLeave), LSTRING(TipLeaveTable)]
];

_display setVariable ["endScreen", [_endDim] + _endFrame + [_endTitle, _endSubtitle, _endLine] + _endTable + _endButtons];
_display setVariable ["endTexts", [_endTitle, _endSubtitle]];
_display setVariable ["endHeader", _header];
_display setVariable ["endRows", _endRows];
_display setVariable ["endRestart", _endButtons select 0];

// ===================================================================== Tooltips of the fixed elements
// (cards, piles, dice and shift tokens get theirs in gameRefresh, through brg_game_fnc_uiHelp)
{
    _x params ["_ctrl", "_tooltip"];
    _ctrl ctrlSetTooltip _tooltip;
} forEach [
    [_display getVariable "title", LLSTRING(TipTableTitle)],
    [_display getVariable "roundInfo", LLSTRING(TipRound)],
    [_display getVariable "phaseInfo", LLSTRING(TipRound)],
    [_display getVariable "timerText", LLSTRING(TipTimer)],
    [_display getVariable "statusLine", LLSTRING(TipStatusLine)],
    [_display getVariable "log", LLSTRING(TipLog)],
    [_display getVariable "myTitle", LLSTRING(TipMyStation)],
    [_display getVariable "inspector", LLSTRING(TipInspector)],
    [(_display getVariable "buttons") select 2, LLSTRING(TipLeaveGame)]
];
{
    _x params ["", "_title", "", "", "", "_status", "_target"];
    _title ctrlSetTooltip LLSTRING(TipSeatTitle);
    _status ctrlSetTooltip LLSTRING(TipSeatStatus);
    _target ctrlSetTooltip LLSTRING(TipTarget);
} forEach _seats;
{_x ctrlSetTooltip LLSTRING(TipRound)} forEach (_display getVariable "turnPips");

// Countdown and pulsing highlights
GVAR(headerPFH) = [{
    call FUNC(gameUpdateHeader);
    call FUNC(gamePulse);
}, 0.5] call CBA_fnc_addPerFrameHandler;

[_display] call FUNC(animFadeIn);
call FUNC(gameRefresh);
