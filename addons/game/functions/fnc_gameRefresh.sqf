#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Redraws the whole game screen from the last view received from the server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _display = uiNamespace getVariable [QGVAR(gameDisplay), displayNull];
if (isNull _display) exitWith {};

private _state = GVAR(state);
if (count _state == 0) exitWith {_display closeDisplay 2};

// "Me" is the player shown in the bottom station: myself, or the 4th player for a spectator
([_state] call FUNC(viewSubject)) params ["_myUid", "_me", "_spectator"];
_display setVariable ["viewUid", _myUid];
private _players = _state get "players";
private _myIndex = _players findIf {(_x get "uid") == _myUid};
if (_myIndex < 0 && {!_spectator}) exitWith {_display closeDisplay 2};
private _placeholder = _spectator && {_myIndex < 0}; // spectator of a table with 3 players or fewer
private _status = _state get "status";
private _phase = _state get "phase";
private _current = _state get "current";
private _effects = _state get "effects";
private _results = _state get "results";
private _showResults = _results isNotEqualTo [] && {_phase == PHASE_RESULTS || {_status == STATUS_OVER}};
private _isOwner = !_spectator && {(_state get "ownerUid") == _myUid};

private _drawn = _me get "drawn";
private _pending = _me get "pending";
private _myTurn = !_spectator && {_status == STATUS_PLAYING} && {_phase == PHASE_TURN} && {_current == _myUid};
private _canAct = _myTurn && {_pending isEqualTo []};
if (!_myTurn) then {GVAR(targeting) = -1};
private _targeting = GVAR(targeting) > 0;

private _fnc_nameOf = {
    params ["_uid"];
    private _index = _players findIf {(_x get "uid") == _uid};
    if (_index < 0) exitWith {"?"};
    (_players select _index) get "name"
};
private _fnc_resultOf = {
    params ["_uid"];
    private _index = _results findIf {(_x select 0) == _uid};
    if (_index < 0) exitWith {[]};
    _results select _index
};
private _fnc_tags = {
    params ["_uid"];
    private _tags = [];
    if (_uid == (_state get "ownerUid")) then {
        _tags pushBack format ["<t color='%1'>[%2]</t>", HTML_HOLO, toUpper LLSTRING(GameHost)];
    };
    _tags joinString " "
};
private _fnc_hand = {
    // Evaluation of a hand without dice: [labelText, isSabacc, penalty] or [] if a Mirage is unknown
    params ["_sand", "_blood"];
    if (_sand < 0 || {_blood < 0}) exitWith {[]};
    private _values = [CARD_VALUE(_sand), CARD_VALUE(_blood)];
    if (VALUE_IMPOSTOR in _values && {!(_effects getOrDefault ["impostorSix", false])}) exitWith {[]};
    _values = _values apply {
        switch (true) do {
            case (_x == VALUE_IMPOSTOR): {6};
            case (_x == VALUE_SYLOP && {_effects getOrDefault ["sylopZero", false]}): {0};
            default {_x};
        }
    };
    private _eval = (_values + [_effects]) call FUNC(evaluateHand);
    [format ([localize (_eval select 3)] + (_eval select 4)), _eval select 1, _eval select 2]
};

// ===================================================================== Header
(_display getVariable "title") ctrlSetStructuredText parseText format [
    // Two lines: the game title, then the table name
    "<t font='PuristaBold' size='0.95' color='%1'>%5</t><br/><t size='0.62' color='%2'>//  </t><t font='PuristaMedium' size='0.62' color='%3'>%4</t>",
    HTML_AMBER, HTML_DIM, HTML_TEXT, toUpper (_state get "name"), toUpper LLSTRING(GameTitle)
];
call FUNC(gameUpdateHeader);

// ===================================================================== Opponents, in play order after me
private _opponents = [];
private _count = count _players;
if (_myIndex < 0) then {
    _opponents = _players select [0, 3];
} else {
    for "_i" from 1 to (_count - 1) do {_opponents pushBack (_players select ((_myIndex + _i) mod _count))};
};
_display setVariable ["seatUids", _opponents apply {_x get "uid"}];

{
    private _seat = _x;
    private _seatIndex = _forEachIndex;
    _seat params ["_bg", "_title", "_stats", "_sand", "_blood", "_statusCtrl", "_target"];

    ((_display getVariable "seatOut") select _seatIndex) params ["_capSand", "_capBlood", "_outLabel"];
    if (_seatIndex >= count _opponents) then {
        {_x ctrlShow false} forEach (_seat + ((_display getVariable "seatShifts") select _seatIndex) + [_outLabel]);
    } else {
        {_x ctrlShow true} forEach _seat;
        private _player = _opponents select _seatIndex;
        // Eliminated: no suit captions, a big "ELIMINATED" where the cards were
        private _seatOut = _player get "out";
        {_x ctrlShow !_seatOut} forEach [_capSand, _capBlood];
        _outLabel ctrlShow _seatOut;
        private _uid = _player get "uid";
        private _isCurrent = _uid == _current;

        _title ctrlSetStructuredText parseText format [
            "<t align='left' font='PuristaSemibold' size='0.85' color='%1'>%2%3</t><t align='right' size='0.7'>%4</t>",
            [HTML_TEXT, HTML_AMBER] select _isCurrent,
            ["", "> "] select _isCurrent,
            toUpper (_player get "name"),
            [_uid] call _fnc_tags
        ];

        private _chips = _player get "chips";
        _stats ctrlSetStructuredText parseText ([
            [LLSTRING(LabelChips), _chips, [HTML_TEXT, HTML_BAD] select (_chips <= 2), 1.15] call FUNC(uiRow),
            [LLSTRING(LabelPot), _player get "pot", HTML_AMBER] call FUNC(uiRow)
        ] joinString "<br/>");

        // Shift tokens still in hand: icons with their description
        private _theirShifts = _player get "shifts";
        ((_display getVariable "seatShifts") select _seatIndex) params ["_bonusLabel"];
        _bonusLabel ctrlShow !(_player get "out");
        {
            if (_forEachIndex < count _theirShifts && {!(_player get "out")}) then {
                private _shift = _theirShifts select _forEachIndex;
                ([_shift] call FUNC(shiftInfo)) params ["_shiftName", "_shiftDesc", "_needsTarget", "_texture"];
                _x ctrlShow true;
                _x ctrlSetText _texture;
                [_x, _shiftName, _shiftDesc, HTML_AMBER, format [LLSTRING(HelpOpponentShift), _player get "name"]] call FUNC(uiHelp);
            } else {
                _x ctrlShow false;
            };
        } forEach (((_display getVariable "seatShifts") select _seatIndex) select [1, 4]);

        {
            _x params ["_ctrl", "_card"];
            _ctrl ctrlSetText ([_card] call FUNC(cardTexture));
            ([_card] call FUNC(cardHelp)) params ["_helpTitle", "_helpText", "_helpColor"];
            [_ctrl, _helpTitle, _helpText, _helpColor] call FUNC(uiHelp);
        } forEach [[_sand, _player get "sand"], [_blood, _player get "blood"]];

        // Last action / result
        private _line = switch (true) do {
            case (_player get "left"): {format ["<t color='%1'>%2</t>", HTML_BAD, toUpper LLSTRING(SeatLeft)]};
            case (_showResults && {([_uid] call _fnc_resultOf) isNotEqualTo []}): {
                ([[_uid] call _fnc_resultOf] call FUNC(formatResult)) joinString "<br/>"
            };
            case (_player get "out"): {format ["<t color='%1'>%2</t>", HTML_BAD, toUpper LLSTRING(SeatOut)]};
            case (_player get "waiting"): {format ["<t color='%1'>%2</t>", HTML_AMBER, LLSTRING(SeatChoosing)]};
            case (_isCurrent): {format ["<t color='%1'>%2</t>", HTML_AMBER, LLSTRING(SeatPlaying)]};
            case ((_player get "lastAction") == "stand"): {LLSTRING(ActionStood)};
            case ((_player get "lastAction") == "draw"): {LLSTRING(ActionDrew)};
            default {format ["<t color='%1'>%2</t>", HTML_MUTED, LLSTRING(SeatWaiting)]};
        };
        if ((_player get "immune") && {!_showResults}) then {
            _line = _line + format ["<br/><t color='%1'>%2</t>", HTML_HOLO, LLSTRING(SeatImmune)];
        };
        _statusCtrl ctrlSetStructuredText parseText format ["<t size='0.75' color='%1'>%2</t>", HTML_TEXT, _line];

        _bg ctrlSetBackgroundColor (switch (true) do {
            case (_showResults && {([_uid] call _fnc_resultOf) param [6, false]}): {COLOR_WIN};
            case (_player get "out"): {COLOR_OUT};
            case (_isCurrent): {COLOR_ACTIVE};
            case (_targeting): {COLOR_TARGET};
            default {COLOR_PANEL_LIGHT};
        });

        _target setVariable [QGVAR(args), [_uid]];
        _target ctrlShow (_targeting && {!(_player get "out")});
    };
} forEach (_display getVariable "seats");

// ===================================================================== Status line
private _statusText = switch (true) do {
    case (_status == STATUS_OVER): {
        private _winner = _state get "winner";
        if (_winner == "") then {LLSTRING(StatusGameOverDraw)} else {format [LLSTRING(StatusGameOver), _winner]}
    };
    case (_phase == PHASE_RESULTS): {LLSTRING(StatusResults)};
    case (_phase == PHASE_CHOICE): {
        if (_pending isNotEqualTo []) then {LLSTRING(StatusImpostorChoice)} else {LLSTRING(StatusWaitingChoices)}
    };
    case (_spectator && {_phase == PHASE_TURN}): {format [LLSTRING(StatusSpectatorTurn), [_current] call _fnc_nameOf]};
    case (_spectator): {LLSTRING(StatusSpectator)};
    case (_me get "out"): {LLSTRING(StatusEliminated)};
    case (!_myTurn): {format [LLSTRING(StatusTurnOf), [_current] call _fnc_nameOf]};
    case (_pending isNotEqualTo []): {LLSTRING(StatusPriorityChoice)};
    case (_drawn != CARD_NONE): {LLSTRING(StatusDiscard)};
    case (_targeting): {LLSTRING(StatusTargeting)};
    default {LLSTRING(StatusYourTurn)};
};
private _statusColor = [HTML_TEXT, HTML_AMBER] select _myTurn;

// A recent notification (error...) takes over for a few seconds
GVAR(flash) params ["_flashText", "_flashTime"];
if (time - _flashTime < 4) then {
    _statusText = _flashText;
    _statusColor = HTML_BAD;
};

(_display getVariable "statusLine") ctrlSetStructuredText parseText format [
    "<t align='center' font='PuristaSemibold' size='1.05' color='%1'>%2</t>", _statusColor, toUpper _statusText
];

// ===================================================================== Draw piles
private _tops = _state get "discardTops";
private _counts = _state get "deckCounts";
private _freeDraw = (_effects getOrDefault ["freeDraw", ""]) == _myUid;
private _canDraw = _canAct && {_drawn == CARD_NONE} && {!_targeting} && {(_me get "chips") > 0 || _freeDraw};
private _cost = [LLSTRING(HelpCostOne), LLSTRING(HelpCostFree)] select _freeDraw;
{
    _x params ["_pile", "_label"];
    private _source = _pile getVariable QGVAR(source);
    private _suit = _source mod 2;
    private _suitName = localize ([LSTRING(Sand), LSTRING(Blood)] select _suit);
    private _suitHtml = [HTML_SAND, HTML_BLOOD] select _suit;
    private _isDiscard = _source >= SOURCE_SAND_DISCARD;
    private _card = if (_isDiscard) then {_tops select _suit} else {[CARD_NONE, CARD_HIDDEN] select ((_counts select _suit) > 0)};
    private _usable = _canDraw && {_card != CARD_NONE};

    _pile ctrlSetText ([_card] call FUNC(cardTexture));
    _pile setVariable [QGVAR(clickable), _usable];
    private _color = [COLOR_DIM, COLOR_WHITE] select (_usable || {!_myTurn});
    _pile ctrlSetTextColor _color;
    _pile ctrlSetActiveColor _color;

    private _caption = if (_isDiscard) then {
        LLSTRING(CaptionDiscard)
    } else {
        format [LLSTRING(CaptionDeck), _counts select _suit]
    };
    _label ctrlSetStructuredText parseText format [
        "<t align='center' size='0.62' font='PuristaSemibold' color='%1'>%2</t>", _suitHtml, toUpper _caption
    ];

    if (_isDiscard) then {
        ([_card] call FUNC(cardHelp)) params ["_helpTitle", "_helpText", "_helpColor"];
        if (_card == CARD_NONE) then {_helpTitle = format ["%1 %2", LLSTRING(CaptionDiscard), _suitName]; _helpText = LLSTRING(HelpEmptyPile); _helpColor = _suitHtml};
        [_pile, _helpTitle, _helpText, _helpColor, format ["%1 %2", format [LLSTRING(HelpDiscard), _suitName], _cost]] call FUNC(uiHelp);
    } else {
        [_pile, format [LLSTRING(CaptionDeck), _counts select _suit], format [LLSTRING(HelpDeck), _suitName], _suitHtml, _cost] call FUNC(uiHelp);
    };
} forEach (_display getVariable "piles");

// ===================================================================== Dice choice
private _choice = _display getVariable "choice";
private _showChoice = _pending isNotEqualTo [];
{_x ctrlShow _showChoice} forEach _choice;
// A pile clicked just before keeps the focus and would be drawn above the dice: hide them meanwhile
{{_x ctrlShow !_showChoice} forEach _x} forEach (_display getVariable "piles");
if (_showChoice) then {
    _pending params ["_type", "_dice", "_suit"];
    private _text = if (_type == "priority") then {
        LLSTRING(ChoicePriority)
    } else {
        format [LLSTRING(ChoiceImpostor), localize ([LSTRING(Sand), LSTRING(Blood)] select _suit)]
    };
    (_choice select 1) ctrlSetStructuredText parseText format [
        "<t align='center' font='PuristaSemibold' size='0.8' color='%1'>%2</t><br/><t align='center' size='0.8' color='%3'>%4</t>",
        HTML_AMBER, toUpper LLSTRING(ChoiceTitle), HTML_TEXT, _text
    ];
    {
        _x setVariable [QGVAR(clickable), true];
        [_x, LLSTRING(ChoiceTitle), format [LLSTRING(HelpDie), _dice select _forEachIndex], HTML_AMBER] call FUNC(uiHelp);
        if !(missionNamespace getVariable [QGVAR(diceRolling), false]) then {
            _x ctrlSetText format [QPATHTOF(data\dice\%1.paa), _dice select _forEachIndex];
        };
    } forEach [_choice select 2, _choice select 3];

    // Under each die: its value, and what choosing it gives
    private _rolling = missionNamespace getVariable [QGVAR(diceRolling), false];
    {
        private _value = _dice select _forEachIndex;
        private _outcome = "";
        if (!_rolling) then {
            if (_type == "priority") then {
                _outcome = format [LLSTRING(EffectPriority), _value];
            } else {
                // Mirage: evaluate the hand with this value (unknown if the other card is a Mirage too)
                private _otherCard = _me get (["blood", "sand"] select _suit);
                private _otherValue = CARD_VALUE(_otherCard);
                if (_otherValue != VALUE_IMPOSTOR) then {
                    if (_otherValue == VALUE_SYLOP && {_effects getOrDefault ["sylopZero", false]}) then {_otherValue = 0};
                    private _values = [[_value, _otherValue], [_otherValue, _value]] select (_suit == SUIT_BLOOD);
                    private _eval = (_values + [_effects]) call FUNC(evaluateHand);
                    _outcome = format ([localize (_eval select 3)] + (_eval select 4));
                };
            };
        };
        _x ctrlSetStructuredText parseText format [
            "<t align='center' font='PuristaBold' size='1.7' color='%1'>%2</t><br/><t align='center' size='0.7' color='%3'>%4</t>",
            HTML_AMBER, ["?", str _value] select !_rolling,
            HTML_HOLO, ["", "> " + toUpper _outcome] select (_outcome != "")
        ];
    } forEach [_choice select 4, _choice select 5];
};

// ===================================================================== Log (newest at the bottom, older entries dimmed)
private _log = (_state get "log") apply {[_x select 0, _x select 1] call FUNC(formatMessage)};
_log = _log select [((count _log) - 8) max 0];
private _logCount = count _log;
{
    private _recent = _forEachIndex >= _logCount - 2;
    _log set [_forEachIndex, format ["<t color='%1'>%2 </t><t color='%3'>%4</t>", HTML_DIM, ">", [HTML_MUTED, HTML_TEXT] select _recent, _x]];
} forEach _log;
(_display getVariable "log") ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", _log joinString "<br/>"];

// ===================================================================== My station
(_display getVariable "myTitle") ctrlSetStructuredText parseText (
    [_me get "name", [_myUid] call _fnc_tags] call FUNC(uiTitle)
);

private _mySand = _me get "sand";
private _myBlood = _me get "blood";
private _hasDrawn = _drawn >= 0;
private _drawnSuit = if (_hasDrawn) then {CARD_SUIT(_drawn)} else {-1};

{
    _x params ["_ctrl", "_card", "_suit"];
    private _swappable = _canAct && {_drawnSuit == _suit};
    _ctrl ctrlSetText ([_card] call FUNC(cardTexture));
    _ctrl setVariable [QGVAR(clickable), _swappable];
    ([_card] call FUNC(cardHelp)) params ["_helpTitle", "_helpText", "_helpColor"];
    [_ctrl, _helpTitle, _helpText, _helpColor, ["", LLSTRING(TooltipSwap)] select _swappable] call FUNC(uiHelp);
} forEach [
    [_display getVariable "mySand", _mySand, SUIT_SAND],
    [_display getVariable "myBlood", _myBlood, SUIT_BLOOD]
];

private _drawnCtrl = _display getVariable "myDrawn";
_drawnCtrl ctrlShow _hasDrawn;
(_display getVariable "drawnLabel") ctrlShow _hasDrawn;
if (_hasDrawn) then {
    _drawnCtrl ctrlSetText ([_drawn] call FUNC(cardTexture));
    _drawnCtrl setVariable [QGVAR(clickable), _canAct];
    ([_drawn] call FUNC(cardHelp)) params ["_helpTitle", "_helpText", "_helpColor"];
    [_drawnCtrl, _helpTitle, _helpText, _helpColor, LLSTRING(TipDiscardDrawn)] call FUNC(uiHelp);
};

// Stats: chips, pot, hand, what a loss would cost, active effects
private _chips = _me get "chips";
private _pot = _me get "pot";
private _rows = [
    [LLSTRING(LabelChips), _chips, [HTML_TEXT, HTML_BAD] select (_chips <= 2), 1.3] call FUNC(uiRow),
    [LLSTRING(LabelPot), _pot, HTML_AMBER, 1.05] call FUNC(uiRow)
];

if (_showResults) then {
    private _result = [_myUid] call _fnc_resultOf;
    if (_result isNotEqualTo []) then {
        ([_result] call FUNC(formatResult)) params ["_handLine", "_deltaLine"];
        _rows pushBack ([LLSTRING(LabelHand), _handLine, HTML_TEXT, 0.85] call FUNC(uiRow));
        _rows pushBack format ["<t align='right' size='0.85'>%1</t>", _deltaLine];
    };
} else {
    private _hand = [_mySand, _myBlood] call _fnc_hand;
    switch (true) do {
        case (_mySand < 0 || {_myBlood < 0}): {}; // no cards (eliminated): nothing to evaluate
        case (_hand isEqualTo []): {
            _rows pushBack ([LLSTRING(LabelHand), LLSTRING(HandDice), HTML_HOLO, 0.85] call FUNC(uiRow));
            _rows pushBack format ["<t size='0.65' color='%1'>%2</t>", HTML_MUTED, LLSTRING(HandUnknown)];
        };
        default {
            _hand params ["_label", "_isSabacc", "_penalty"];
            _rows pushBack ([LLSTRING(LabelHand), _label, [HTML_TEXT, HTML_GOOD] select _isSabacc, 0.9] call FUNC(uiRow));
            // A Mirage only has a value here because a shift token fixed it: say it
            if (VALUE_IMPOSTOR in [CARD_VALUE(_mySand), CARD_VALUE(_myBlood)]) then {
                _rows pushBack format ["<t size='0.65' color='%1'>%2</t>", HTML_AMBER, LLSTRING(HandImpostorFixed)];
            };
            _rows pushBack ([LLSTRING(LabelIfLose), format [LLSTRING(IfLoseValue), _pot + _penalty], HTML_BAD, 0.85] call FUNC(uiRow));
        };
    };
};

private _active = [];
if (_effects getOrDefault ["impostorSix", false]) then {_active pushBack LLSTRING(EffectImpostorSix)};
if (_effects getOrDefault ["sylopZero", false]) then {_active pushBack LLSTRING(EffectSylopZero)};
if (_effects getOrDefault ["inverted", false]) then {_active pushBack LLSTRING(EffectInverted)};
if ((_effects getOrDefault ["priority", -1]) > 0) then {_active pushBack format [LLSTRING(EffectPriority), _effects get "priority"]};
if (_freeDraw) then {_active pushBack LLSTRING(EffectFreeDraw)};
if (_me get "immune") then {_active pushBack LLSTRING(SeatImmune)};
if (_active isNotEqualTo []) then {
    _rows pushBack format ["<t size='0.65' color='%1'>%2</t>", HTML_HOLO, toUpper (_active joinString " | ")];
};

private _handInfo = _display getVariable "handInfo";
_handInfo ctrlSetStructuredText parseText (_rows joinString "<br/>");

// Eliminated: the station says it clearly instead of showing an empty hand
private _isOut = (_me get "out") || _placeholder;
private _outBanner = _display getVariable "outBanner";
_outBanner ctrlShow _isOut;
// The cards of the round that eliminated me would show under the banner
{_x ctrlShow !_isOut} forEach [_display getVariable "mySand", _display getVariable "myBlood"];
if (_isOut) then {(_display getVariable "myDrawn") ctrlShow false};
_handInfo ctrlShow !_isOut;
{_x ctrlShow !_isOut} forEach ((_display getVariable "myCaptions") + (_display getVariable "myDividers") + [_display getVariable "shiftsTitle"]);
if (_isOut) then {
    private _round = (_me get "eliminatedRound") max 1;
    // [title color, title, reason, help]
    (switch (true) do {
        case (_placeholder): {[HTML_HOLO, LLSTRING(SpectatorTitle), LLSTRING(SpectatorReason), LLSTRING(SpectatorHelp)]};
        case (_spectator): {[HTML_BAD, LLSTRING(OutTitle), format [LLSTRING(OutReasonOther), _me get "name", _round], LLSTRING(SpectatorHelp)]};
        case (_me get "left"): {[HTML_BAD, LLSTRING(OutTitle), LLSTRING(OutLeft), LLSTRING(OutHelp)]};
        default {[HTML_BAD, LLSTRING(OutTitle), format [LLSTRING(OutReason), _round], LLSTRING(OutHelp)]};
    }) params ["_titleColor", "_title", "_reason", "_help"];
    _outBanner ctrlSetStructuredText parseText format [
        "<t align='center' font='PuristaBold' size='2.4' color='%1'>%2</t><br/><t align='center' size='0.95' color='%3'>%4</t><br/><t align='center' size='0.75' color='%5'>%6</t>",
        _titleColor, toUpper _title, HTML_TEXT, _reason, HTML_MUTED, _help
    ];
};
_handInfo ctrlSetTooltip LLSTRING(TipMyStats);

// ===================================================================== Buttons
(_display getVariable "buttons") params ["_main", "_second", "_leave"];

switch (true) do {
    case (_status == STATUS_OVER): {
        _main ctrlShow _isOwner;
        _main ctrlEnable true;
        _main ctrlSetText toUpper LLSTRING(GameRestart);
        _main setVariable [QGVAR(action), "start"];
    };
    case (_hasDrawn): {
        _main ctrlShow true;
        _main ctrlEnable _canAct;
        _main ctrlSetText toUpper LLSTRING(GameTakeDrawn);
        _main setVariable [QGVAR(action), "takeDrawn"];
    };
    default {
        _main ctrlShow (_status == STATUS_PLAYING && {!(_me get "out")} && {!_spectator});
        _main ctrlEnable (_canAct && {!_targeting});
        _main ctrlSetText toUpper LLSTRING(GameStand);
        _main setVariable [QGVAR(action), "stand"];
    };
};
_main ctrlSetTooltip ([LLSTRING(TipStand), LLSTRING(TipTakeDrawn)] select _hasDrawn);

if (_status == STATUS_OVER) then {
    // Brings back the end screen after "see the table"
    _second ctrlShow true;
    _second ctrlEnable true;
    _second ctrlSetText toUpper LLSTRING(GameResults);
    _second ctrlSetTooltip LLSTRING(TipShowEnd);
    _second setVariable [QGVAR(action), "showEnd"];
} else {
    _second ctrlShow _hasDrawn;
    _second ctrlEnable _canAct;
    _second ctrlSetText toUpper LLSTRING(GameKeepHand);
    _second ctrlSetTooltip LLSTRING(TipKeepHand);
    _second setVariable [QGVAR(action), "keepHand"];
};

_leave ctrlSetText toUpper (switch (true) do {
    case (_spectator): {LLSTRING(StopWatching)};
    case (GVAR(leaveConfirm)): {LLSTRING(GameLeaveConfirm)};
    default {LLSTRING(GameLeave)};
});
_leave setVariable [QGVAR(action), "leave"];

// ===================================================================== Shift tokens
private _myShifts = _me get "shifts";
private _canShift = _canAct && {!_hasDrawn} && {!(_me get "shiftUsed")};
{
    if (_forEachIndex < count _myShifts) then {
        private _shift = _myShifts select _forEachIndex;
        ([_shift] call FUNC(shiftInfo)) params ["_shiftName", "_shiftDesc", "_needsTarget", "_texture"];
        private _selected = GVAR(targeting) == _shift;
        _x ctrlShow !(_me get "out");
        _x ctrlSetText _texture;
        _x setVariable [QGVAR(clickable), _canShift];
        _x ctrlSetTextColor ([COLOR_DIM, COLOR_WHITE] select (_canShift && {!_targeting || _selected}));
        [_x, _shiftName, _shiftDesc, HTML_AMBER, ["", LLSTRING(HelpTargetedLong)] select _needsTarget] call FUNC(uiHelp);
    } else {
        _x ctrlShow false;
    };
} forEach (_display getVariable "shiftSlots");

// Default text of the analysis panel (when the mouse is over nothing)
private _default = switch (true) do {
    case (_targeting): {format [LLSTRING(ShiftTargeting), ([GVAR(targeting)] call FUNC(shiftInfo)) select 0]};
    case (_myShifts isEqualTo []): {LLSTRING(ShiftNone)};
    case (_myTurn && {_me get "shiftUsed"}): {LLSTRING(ShiftUsedThisTurn)};
    default {LLSTRING(InspectorDefault)};
};
_default = format ["<t size='0.7' color='%1'>%2</t>", [HTML_MUTED, HTML_AMBER] select _targeting, _default];
_display setVariable ["inspectorDefault", _default];
(_display getVariable "inspector") ctrlSetStructuredText parseText _default;

// ===================================================================== End screen
[_display, _state] call FUNC(gameEndRefresh);

// ===================================================================== Animations (only what changed since the last view)
[_display, missionNamespace getVariable [QGVAR(lastView), createHashMap], _state] call FUNC(gameAnimate);
GVAR(lastView) = _state;

// While a banner is shown (possibly just started by gameAnimate) every button is disabled,
// so nothing looks usable; animBanner refreshes the screen again once the banner is gone
private _endButtons = (_display getVariable "endScreen") select [count (_display getVariable "endScreen") - 4, 4];
if (diag_tickTime < (missionNamespace getVariable [QGVAR(bannerUntil), 0])) then {
    {_x ctrlEnable false} forEach (
        (_display getVariable "buttons")
        + ((_display getVariable "seats") apply {_x select 6})
        + _endButtons
    );
} else {
    // Buttons whose state is not decided elsewhere (stand / keep hand and "new game" are)
    {_x ctrlEnable true} forEach (
        [(_display getVariable "buttons") select 2]
        + ((_display getVariable "seats") apply {_x select 6})
        + (_endButtons select [1, 3])
    );
};
