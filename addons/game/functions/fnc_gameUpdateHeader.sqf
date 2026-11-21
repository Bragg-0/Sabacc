#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Updates the header (every 0.5 s): round, turn pips, countdown text and bar.
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

private _status = _state get "status";
private _phase = _state get "phase";
private _playing = _status == STATUS_PLAYING;

// Round and phase
private _phaseText = switch (true) do {
    case (!_playing): {toUpper ([_status] call FUNC(statusName))};
    case (_phase == PHASE_TURN): {format [LLSTRING(GameTurn), _state get "turn", TURNS_PER_ROUND]};
    case (_phase == PHASE_CHOICE): {LLSTRING(PhaseReveal)};
    default {LLSTRING(PhaseResults)};
};
(_display getVariable "roundInfo") ctrlSetStructuredText parseText format [
    "<t align='right' size='0.72' color='%1'>%2 </t><t align='right' font='PuristaBold' size='0.9' color='%3'>%4</t>",
    HTML_MUTED, toUpper LLSTRING(LabelRound), HTML_TEXT, _state get "round"
];
(_display getVariable "phaseInfo") ctrlSetStructuredText parseText format [
    "<t align='right' size='0.62' color='%1'>%2</t>", HTML_MUTED, toUpper _phaseText
];

// Turn pips: done = holo, current = amber, to come = faint
private _turn = _state get "turn";
{
    _x ctrlSetBackgroundColor (switch (true) do {
        case (!_playing || {_phase != PHASE_TURN}): {COLOR_HOLO_FAINT};
        case (_forEachIndex + 1 < _turn): {COLOR_HOLO};
        case (_forEachIndex + 1 == _turn): {COLOR_AMBER};
        default {COLOR_HOLO_FAINT};
    });
} forEach (_display getVariable "turnPips");

// Countdown
private _total = switch (_phase) do {
    case PHASE_TURN: {GVAR(turnTime)};
    case PHASE_CHOICE: {GVAR(turnTime) min 30};
    default {GVAR(resultsTime)};
};
private _remaining = if (_playing) then {(ceil ((_state get "deadline") - CBA_missionTime)) max 0} else {0};
// The server adds a short grace while the banner is shown: the countdown displays the full time until then
_remaining = _remaining min (ceil _total);
private _urgent = _playing && {_remaining <= 10};
private _minutes = floor (_remaining / 60);
private _seconds = _remaining mod 60;
private _clock = format ["%1%2:%3%4", ["", "0"] select (_minutes < 10), _minutes, ["", "0"] select (_seconds < 10), _seconds];

(_display getVariable "timerText") ctrlSetStructuredText parseText format [
    "<t align='left' size='0.7' color='%1'>%2</t><t align='right' font='EtelkaMonospacePro' size='1.05' color='%3'>%4</t>",
    HTML_MUTED, toUpper LLSTRING(LabelTime),
    [HTML_TEXT, HTML_BAD] select _urgent,
    ["--:--", _clock] select _playing
];

private _bar = _display getVariable "timerBar";
private _position = +(_bar getVariable QGVAR(basePos));
_position set [2, (_position select 2) * ((_remaining / (_total max 1)) min 1)];
_bar ctrlSetPosition _position;
_bar ctrlSetBackgroundColor ([COLOR_HOLO, COLOR_DANGER] select _urgent);
_bar ctrlCommit 0.5;
