#include "..\..\script_component.hpp"
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

// Clicks on the table are ignored until this banner is gone (see brg_game_fnc_gameAction)
GVAR(bannerUntil) = (missionNamespace getVariable [QGVAR(bannerUntil), 0]) max (diag_tickTime + _delay + BANNER_BLOCK);
// Floating texts wait until the banner is gone (see brg_game_fnc_animFloatText)
GVAR(bannerVisibleUntil) = (missionNamespace getVariable [QGVAR(bannerVisibleUntil), 0]) max (diag_tickTime + _delay + 2);
// Give the buttons back once the banner is gone
[{call FUNC(gameRefresh)}, [], _delay + BANNER_BLOCK + 0.05] call CBA_fnc_waitAndExecute;

[{
    params ["_display", "_text", "_color"];
    if (isNull _display) exitWith {};

    // The focused control is drawn above everything: give the focus to an invisible button
    private _sink = _display getVariable [QGVAR(focusSink), controlNull];
    if (isNull _sink) then {
        _sink = _display ctrlCreate [QGVAR(Button), -1];
        _sink ctrlSetPosition [safeZoneX, safeZoneY, 0, 0];
        _sink ctrlSetText "";
        _sink ctrlCommit 0;
        _display setVariable [QGVAR(focusSink), _sink];
    };
    ctrlSetFocus _sink;

    // Only one banner at a time
    ctrlDelete (_display getVariable [QGVAR(banner), controlNull]);
    ctrlDelete (_display getVariable [QGVAR(bannerDim), controlNull]);

    // Dark veil over the whole table, so the banner stands out
    private _dim = _display ctrlCreate [QGVAR(Text), -1];
    _display setVariable [QGVAR(bannerDim), _dim];
    _dim ctrlSetPosition GRID(0,1.6,40,23.4);
    _dim ctrlSetBackgroundColor [0, 0, 0, 0.6];
    _dim ctrlSetFade 1;
    _dim ctrlCommit 0;
    _dim ctrlSetFade 0;
    _dim ctrlCommit 0.2;

    private _final = GRID(4,10.6,32,3.4);
    private _ctrl = _display ctrlCreate [QGVAR(StructuredText), -1];
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

    // Banner and veil fade out together
    [{
        {
            if (!isNull _x) then {
                _x ctrlSetFade 1;
                _x ctrlCommit 0.5;
                [{ctrlDelete _this}, _x, 0.55] call CBA_fnc_waitAndExecute;
            };
        } forEach _this;
    }, [_ctrl, _dim], 1.4] call CBA_fnc_waitAndExecute;
}, [_display, _text, _color], _delay max 0.01] call CBA_fnc_waitAndExecute;
