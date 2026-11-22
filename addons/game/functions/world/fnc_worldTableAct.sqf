#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Statement of the interactions on a physical table. Sitting or watching opens the
 * screen as soon as the server answers (see brg_sabacc_game_fnc_onStateChanged).
 *
 * Arguments:
 * 0: Table object <OBJECT>
 * 1: Interaction: "sit", "watch" or "open" <STRING>
 *
 * Return Value:
 * None
 */
params ["_object", "_kind"];

private _id = _object getVariable [QGVAR(tableId), -1];
if (_id < 0) exitWith {};

switch (_kind) do {
    case "sit": {
        GVAR(openOnState) = true;
        ["sit", [_id]] call FUNC(request);
    };
    case "watch": {
        GVAR(openOnState) = true;
        ["watch", [_id]] call FUNC(request);
    };
    case "open": {[] call FUNC(openTerminal)};
};
