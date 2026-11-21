#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Draws a holographic panel: translucent fill, thin border, bright corner
 * brackets and an optional title strip.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Grid rectangle [x, y, w, h] (40 x 25 GUI grid) <ARRAY>
 * 2: Title (structured text, "" = no title strip) <STRING> (default: "")
 * 3: Accent color <ARRAY> (default: COLOR_HOLO)
 * 4: Fill color <ARRAY> (default: COLOR_PANEL_LIGHT)
 *
 * Return Value:
 * [fill, title (controlNull without title), other controls...] <ARRAY>
 */
params ["_display", "_rect", ["_title", ""], ["_accent", COLOR_HOLO], ["_fill", COLOR_PANEL_LIGHT]];
_rect params ["_px", "_py", "_pw", "_ph"];

private _fnc_rect = {
    params ["_rx", "_ry", "_rw", "_rh", "_color"];
    private _ctrl = [_display, QGVAR(Text), GRID(_rx,_ry,_rw,_rh)] call FUNC(createCtrl);
    _ctrl ctrlSetBackgroundColor _color;
    _ctrl
};

private _fillCtrl = [_px, _py, _pw, _ph, _fill] call _fnc_rect;
private _others = [];
private _line = (_accent select [0, 3]) + [0.3];
private _faint = (_accent select [0, 3]) + [0.1];

// Title strip
private _titleCtrl = controlNull;
if (_title != "") then {
    _others pushBack ([_px, _py, _pw, 0.85, _faint] call _fnc_rect);
    _others pushBack ([_px, _py + 0.85, _pw, 0.04, _line] call _fnc_rect);
    _titleCtrl = [_display, QGVAR(StructuredText), GRID(_px + 0.35,_py + 0.04,_pw - 0.7,0.8)] call FUNC(createCtrl);
    _titleCtrl ctrlSetStructuredText parseText _title;
};

// Thin border
private _t = 0.05;
_others append [
    [_px, _py, _pw, _t, _line] call _fnc_rect,
    [_px, _py + _ph - _t, _pw, _t, _line] call _fnc_rect,
    [_px, _py, _t, _ph, _line] call _fnc_rect,
    [_px + _pw - _t, _py, _t, _ph, _line] call _fnc_rect
];

// Corner brackets
private _l = 0.8;
private _b = 0.12;
{
    _x params ["_cx", "_cy", "_cw", "_ch"];
    _others pushBack ([_cx, _cy, _cw, _ch, _accent] call _fnc_rect);
} forEach [
    [_px, _py, _l, _b], [_px, _py, _b, _l],
    [_px + _pw - _l, _py, _l, _b], [_px + _pw - _b, _py, _b, _l],
    [_px, _py + _ph - _b, _l, _b], [_px, _py + _ph - _l, _b, _l],
    [_px + _pw - _l, _py + _ph - _b, _l, _b], [_px + _pw - _b, _py + _ph - _l, _b, _l]
];

[_fillCtrl, _titleCtrl] + _others
