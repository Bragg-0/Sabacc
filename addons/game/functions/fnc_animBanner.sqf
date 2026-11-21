#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Big centered message that zooms in, stays a moment and fades out.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Text <STRING>
 * 2: Color (html) <STRING> (default: "#ffc040")
 * 3: Delay <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 */
params ["_display", "_text", ["_color", "#ffc040"], ["_delay", 0]];

[{
    params ["_display", "_text", "_color"];
    if (isNull _display) exitWith {};

    // Only one banner at a time
    ctrlDelete (_display getVariable [QGVAR(banner), controlNull]);

    private _final = GRID(4,10.6,32,3.4);
    private _ctrl = _display ctrlCreate ["RscStructuredText", -1];
    _display setVariable [QGVAR(banner), _ctrl];
    _ctrl ctrlSetBackgroundColor [0, 0, 0, 0.75];
    _ctrl ctrlSetStructuredText parseText format [
        "<t align='center' valign='middle' size='2.6' font='PuristaBold' color='%1' shadow='2'>%2</t>", _color, _text
    ];
    _ctrl ctrlSetPosition GRID(10,11.4,20,1.8);
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 0;

    _ctrl ctrlSetPosition _final;
    _ctrl ctrlSetFade 0;
    _ctrl ctrlCommit 0.2;

    [{
        if (isNull _this) exitWith {};
        _this ctrlSetFade 1;
        _this ctrlCommit 0.5;
        [{ctrlDelete _this}, _this, 0.55] call CBA_fnc_waitAndExecute;
    }, _ctrl, 1.4] call CBA_fnc_waitAndExecute;
}, [_display, _text, _color], _delay max 0.01] call CBA_fnc_waitAndExecute;
