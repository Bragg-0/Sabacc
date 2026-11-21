#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Updates round / turn / countdown in the game screen header (every 0.5 s).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _display = uiNamespace getVariable [QGVAR(gameDisplay), displayNull];
private _state = GVAR(state);
if (isNull _display || {count _state == 0}) exitWith {};

private _parts = [];
if ((_state get "status") == STATUS_PLAYING) then {
    _parts pushBack format [LLSTRING(GameRound), _state get "round"];
    if ((_state get "phase") == PHASE_TURN) then {
        _parts pushBack format [LLSTRING(GameTurn), _state get "turn", TURNS_PER_ROUND];
    };
    private _remaining = (ceil ((_state get "deadline") - CBA_missionTime)) max 0;
    private _color = ["#ffffff", "#ff7050"] select (_remaining <= 10);
    _parts pushBack format ["<t color='%1'>%2</t>", _color, format [LLSTRING(GameTimer), _remaining]];
};

(_display getVariable "headerInfo") ctrlSetStructuredText parseText format [
    "<t align='right'>%1</t>", _parts joinString "   |   "
];
