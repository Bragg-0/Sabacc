#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Formats one line of round results (hand + chips won or lost) as structured text.
 *
 * Arguments:
 * 0: Result [uid, name, cards, values, labelKey, labelArgs, won, delta] <ARRAY>
 *
 * Return Value:
 * Lines <ARRAY of STRING>
 */
params ["_result"];
_result params ["", "", "", "_values", "_labelKey", "_labelArgs", "_won", "_delta"];

private _hand = format ([localize _labelKey] + _labelArgs);
private _shown = _values apply {[str _x, LLSTRING(Sylop)] select (_x == VALUE_SYLOP)};

[
    format ["<t font='PuristaBold'>%1</t><t size='0.8' color='#bbbbbb'> (%2)</t>", _hand, _shown joinString " / "],
    if (_won) then {
        format ["<t color='#70ff70'>%1</t>", format [LLSTRING(SeatWinner), _delta]]
    } else {
        format ["<t color='#ff7070'>%1</t>", format [LLSTRING(SeatLoser), abs _delta]]
    }
]
