#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Shows a short text that rises and fades out (chips won / lost).
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Text <STRING>
 * 2: Screen position [x, y] <ARRAY>
 * 3: Color (html) <STRING> (default: "#ffffff")
 * 4: Delay <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 */
params ["_display", "_text", "_position", ["_color", "#ffffff"], ["_delay", 0]];

[{
    params ["_display", "_text", "_position", "_color"];
    if (isNull _display) exitWith {};
    _position params ["_px", "_py"];

    private _ctrl = _display ctrlCreate [QGVAR(StructuredText), -1];
    _ctrl ctrlSetPosition [_px, _py, GW(6), GH(1.6)];
    _ctrl ctrlSetStructuredText parseText format [
        "<t size='1.5' font='PuristaBold' color='%1' shadow='2'>%2</t>", _color, _text
    ];
    _ctrl ctrlCommit 0;

    _ctrl ctrlSetPosition [_px, _py - GH(2.5), GW(6), GH(1.6)];
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 1.8;

    [{ctrlDelete _this}, _ctrl, 1.9] call CBA_fnc_waitAndExecute;
}, [_display, _text, _position, _color], _delay max 0.01] call CBA_fnc_waitAndExecute;
