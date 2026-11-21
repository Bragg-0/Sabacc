#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Rolls dice pictures for a moment before showing their real values.
 *
 * Arguments:
 * 0: Dice controls <ARRAY>
 * 1: Final values <ARRAY>
 *
 * Return Value:
 * None
 */
params ["_ctrls", "_finals"];

GVAR(diceRolling) = true;

[{
    params ["_args", "_handle"];
    _args params ["_ctrls", "_finals", "_end"];

    if (_ctrls findIf {isNull _x} >= 0) exitWith {
        GVAR(diceRolling) = false;
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (diag_tickTime >= _end) exitWith {
        GVAR(diceRolling) = false;
        {
            _x ctrlSetText format [QPATHTOF(data\dice\%1.paa), _finals select _forEachIndex];
            [_x] call FUNC(animPop);
        } forEach _ctrls;
        [_handle] call CBA_fnc_removePerFrameHandler;
        call FUNC(gameRefresh); // shows the values under the dice

    };

    {
        _x ctrlSetText format [QPATHTOF(data\dice\%1.paa), 1 + floor random 6];
    } forEach _ctrls;
}, 0.07, [_ctrls, _finals, diag_tickTime + 0.9]] call CBA_fnc_addPerFrameHandler;
