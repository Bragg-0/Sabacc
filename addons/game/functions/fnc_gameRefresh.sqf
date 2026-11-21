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

private _myUid = getPlayerUID player;
private _players = _state get "players";
private _myIndex = _players findIf {(_x get "uid") == _myUid};
if (_myIndex < 0) exitWith {_display closeDisplay 2};

private _me = _players select _myIndex;
private _status = _state get "status";
private _phase = _state get "phase";
private _current = _state get "current";
private _effects = _state get "effects";
private _results = _state get "results";
private _showResults = _results isNotEqualTo [] && {_phase == PHASE_RESULTS || {_status == STATUS_OVER}};
private _isOwner = (_state get "ownerUid") == _myUid;

private _drawn = _me get "drawn";
private _pending = _me get "pending";
private _myTurn = _status == STATUS_PLAYING && {_phase == PHASE_TURN} && {_current == _myUid};
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
    private _tags = "";
    if (_uid == (_state get "dealerUid") && {_status == STATUS_PLAYING}) then {
        _tags = _tags + format ["  <t size='0.75' color='#ffc040'>[%1]</t>", LLSTRING(GameDealer)];
    };
    if (_uid == (_state get "ownerUid")) then {
        _tags = _tags + format ["  <t size='0.75' color='#a0c8ff'>[%1]</t>", LLSTRING(GameHost)];
    };
    _tags
};

// ---- Header ----
(_display getVariable "title") ctrlSetStructuredText parseText format [
    "<t font='PuristaBold' size='1.05'>SABACC</t>   <t color='#ffe0a0'>%1</t>", _state get "name"
];
call FUNC(gameUpdateHeader);

// ---- Opponents, in play order after me ----
private _opponents = [];
private _count = count _players;
for "_i" from 1 to (_count - 1) do {_opponents pushBack (_players select ((_myIndex + _i) mod _count))};

{
    private _seat = _x;
    private _seatIndex = _forEachIndex;
    _seat params ["_bg", "_name", "_info", "_sand", "_blood", "_statusCtrl", "_target"];

    if (_seatIndex >= count _opponents) then {
        {_x ctrlShow false} forEach _seat;
    } else {
        {_x ctrlShow true} forEach _seat;
        private _player = _opponents select _seatIndex;
        private _uid = _player get "uid";

        _name ctrlSetStructuredText parseText format ["<t font='PuristaBold'>%1</t>%2", _player get "name", [_uid] call _fnc_tags];
        _info ctrlSetStructuredText parseText format [
            "<img image='%1'/> %2   <t color='#bbbbbb'>%3 %4   %5 %6</t>",
            TEXTURE_CHIPS, _player get "chips",
            LLSTRING(GamePot), _player get "pot",
            LLSTRING(GameShifts), _player get "shiftCount"
        ];
        _sand ctrlSetText ([_player get "sand"] call FUNC(cardTexture));
        _blood ctrlSetText ([_player get "blood"] call FUNC(cardTexture));

        private _lines = [];
        switch (true) do {
            case (_player get "left"): {_lines pushBack format ["<t color='#ff7070'>%1</t>", LLSTRING(SeatLeft)]};
            case (_player get "out"): {_lines pushBack format ["<t color='#ff7070'>%1</t>", LLSTRING(SeatOut)]};
        };
        if (_showResults) then {
            private _result = [_uid] call _fnc_resultOf;
            if (_result isNotEqualTo []) then {_lines append ([_result] call FUNC(formatResult))};
        } else {
            if (_player get "waiting") then {_lines pushBack LLSTRING(SeatChoosing)};
            switch (_player get "lastAction") do {
                case "stand": {_lines pushBack LLSTRING(ActionStood)};
                case "draw": {_lines pushBack LLSTRING(ActionDrew)};
            };
            if (_player get "immune") then {_lines pushBack format ["<t color='#80c0ff'>%1</t>", LLSTRING(SeatImmune)]};
        };
        _statusCtrl ctrlSetStructuredText parseText format ["<t size='0.85'>%1</t>", _lines joinString "<br/>"];

        _bg ctrlSetBackgroundColor (switch (true) do {
            case (_player get "out"): {COLOR_OUT};
            case (_uid == _current): {COLOR_ACTIVE};
            case (_targeting): {COLOR_TARGET};
            default {COLOR_PANEL_LIGHT};
        });

        _target setVariable [QGVAR(args), [_uid]];
        _target ctrlShow (_targeting && {!(_player get "out")});
    };
} forEach (_display getVariable "seats");

// ---- Status line ----
private _statusText = switch (true) do {
    case (_status == STATUS_OVER): {
        private _winner = _state get "winner";
        if (_winner == "") then {LLSTRING(StatusGameOverDraw)} else {format [LLSTRING(StatusGameOver), _winner]}
    };
    case (_phase == PHASE_RESULTS): {LLSTRING(StatusResults)};
    case (_phase == PHASE_CHOICE): {
        if (_pending isNotEqualTo []) then {LLSTRING(StatusImpostorChoice)} else {LLSTRING(StatusWaitingChoices)}
    };
    case (_me get "out"): {LLSTRING(StatusEliminated)};
    case (!_myTurn): {format [LLSTRING(StatusTurnOf), [_current] call _fnc_nameOf]};
    case (_pending isNotEqualTo []): {LLSTRING(StatusPriorityChoice)};
    case (_drawn != CARD_NONE): {LLSTRING(StatusDiscard)};
    case (_targeting): {LLSTRING(StatusTargeting)};
    default {LLSTRING(StatusYourTurn)};
};
if (_myTurn) then {_statusText = format ["<t color='#ffc040'>%1</t>", _statusText]};

// A recent notification (error...) takes over for a few seconds
GVAR(flash) params ["_flashText", "_flashTime"];
if (time - _flashTime < 4) then {_statusText = format ["<t color='#ff9060'>%1</t>", _flashText]};

(_display getVariable "statusLine") ctrlSetStructuredText parseText format ["<t align='center' size='1.15'>%1</t>", _statusText];

// ---- Draw piles ----
private _tops = _state get "discardTops";
private _counts = _state get "deckCounts";
private _canDraw = _canAct && {_drawn == CARD_NONE} && {!_targeting} && {(_me get "chips") > 0 || {(_effects getOrDefault ["freeDraw", ""]) == _myUid}};
{
    _x params ["_pile", "_label"];
    private _source = _pile getVariable QGVAR(source);
    private _suit = _source mod 2;
    private _isDiscard = _source >= SOURCE_SAND_DISCARD;
    private _card = if (_isDiscard) then {_tops select _suit} else {[CARD_NONE, CARD_HIDDEN] select ((_counts select _suit) > 0)};

    private _color = [COLOR_DIM, COLOR_WHITE] select (_canDraw || {!_myTurn});
    _pile ctrlSetText ([_card] call FUNC(cardTexture));
    _pile ctrlEnable (_canDraw && {_card != CARD_NONE});
    _pile ctrlSetTextColor _color;
    _pile ctrlSetActiveColor _color;

    private _labelText = localize (_label getVariable QGVAR(key));
    if (!_isDiscard) then {_labelText = format ["%1 (%2)", _labelText, _counts select _suit]};
    _label ctrlSetStructuredText parseText format [
        "<t align='center' size='0.8' color='%1'>%2</t>", ["#f0c870", "#ff6060"] select _suit, _labelText
    ];
} forEach (_display getVariable "piles");

// ---- Dice choice ----
private _choice = _display getVariable "choice";
private _showChoice = _pending isNotEqualTo [];
{_x ctrlShow _showChoice} forEach _choice;
if (_showChoice) then {
    _pending params ["_type", "_dice", "_suit"];
    private _text = if (_type == "priority") then {
        LLSTRING(ChoicePriority)
    } else {
        format [LLSTRING(ChoiceImpostor), localize ([LSTRING(Sand), LSTRING(Blood)] select _suit)]
    };
    (_choice select 1) ctrlSetStructuredText parseText format ["<t align='center'>%1</t>", _text];
    (_choice select 2) ctrlSetText format [QPATHTOF(data\dice\%1.paa), _dice select 0];
    (_choice select 3) ctrlSetText format [QPATHTOF(data\dice\%1.paa), _dice select 1];
};

// ---- Log ----
private _log = (_state get "log") apply {[_x select 0, _x select 1] call FUNC(formatMessage)};
_log = _log select [((count _log) - 8) max 0];
(_display getVariable "log") ctrlSetStructuredText parseText format ["<t size='0.8'>%1</t>", _log joinString "<br/>"];

// ---- My hand ----
(_display getVariable "myName") ctrlSetStructuredText parseText format [
    "<t font='PuristaBold'>%1</t>%2", LLSTRING(GameYou), [_myUid] call _fnc_tags
];

private _mySand = _me get "sand";
private _myBlood = _me get "blood";
private _drawnSuit = if (_drawn >= 0) then {CARD_SUIT(_drawn)} else {-1};

{
    _x params ["_ctrl", "_card", "_suit"];
    _ctrl ctrlSetText ([_card] call FUNC(cardTexture));
    _ctrl ctrlSetTooltip (["", LLSTRING(TooltipSwap)] select (_canAct && {_drawnSuit == _suit}));
} forEach [
    [_display getVariable "mySand", _mySand, SUIT_SAND],
    [_display getVariable "myBlood", _myBlood, SUIT_BLOOD]
];

private _hasDrawn = _drawn >= 0;
(_display getVariable "myDrawn") ctrlShow _hasDrawn;
(_display getVariable "drawnLabel") ctrlShow _hasDrawn;
if (_hasDrawn) then {
    (_display getVariable "myDrawn") ctrlSetText ([_drawn] call FUNC(cardTexture));    (_display getVariable "drawnLabel") ctrlSetStructuredText parseText format ["<t size='0.8' color='#ffc040'>%1</t>", LLSTRING(GameDrawnCard)];
};

// Chips, pot, hand preview, active effects
private _lines = [
    format ["<img image='%1'/> %2 : <t font='PuristaBold'>%3</t>", TEXTURE_CHIPS, LLSTRING(GameChips), _me get "chips"],
    format ["%1 : <t font='PuristaBold'>%2</t>", LLSTRING(GamePot), _me get "pot"]
];

if (_showResults) then {
    private _result = [_myUid] call _fnc_resultOf;
    if (_result isNotEqualTo []) then {_lines append ([_result] call FUNC(formatResult))};
} else {
    if (_mySand >= 0 && {_myBlood >= 0}) then {
        private _values = [CARD_VALUE(_mySand), CARD_VALUE(_myBlood)];
        if (VALUE_IMPOSTOR in _values && {!(_effects getOrDefault ["impostorSix", false])}) then {
            _lines pushBack format ["<t size='0.85'>%1</t>", LLSTRING(HandUnknown)];
        } else {
            _values = _values apply {
                switch (true) do {
                    case (_x == VALUE_IMPOSTOR): {6};
                    case (_x == VALUE_SYLOP && {_effects getOrDefault ["sylopZero", false]}): {0};
                    default {_x};
                }
            };
            private _eval = (_values + [_effects]) call FUNC(evaluateHand);
            _lines pushBack format [LLSTRING(HandPreview), format ([localize (_eval select 3)] + (_eval select 4))];
        };
    };
};

private _active = [];
if (_effects getOrDefault ["impostorSix", false]) then {_active pushBack LLSTRING(EffectImpostorSix)};
if (_effects getOrDefault ["sylopZero", false]) then {_active pushBack LLSTRING(EffectSylopZero)};
if (_effects getOrDefault ["inverted", false]) then {_active pushBack LLSTRING(EffectInverted)};
if ((_effects getOrDefault ["priority", -1]) > 0) then {_active pushBack format [LLSTRING(EffectPriority), _effects get "priority"]};
if ((_effects getOrDefault ["freeDraw", ""]) == _myUid) then {_active pushBack LLSTRING(EffectFreeDraw)};
if (_me get "immune") then {_active pushBack LLSTRING(SeatImmune)};
if (_active isNotEqualTo []) then {
    _lines pushBack format ["<t size='0.8' color='#80c0ff'>%1</t>", _active joinString "<br/>"];
};
(_display getVariable "handInfo") ctrlSetStructuredText parseText (_lines joinString "<br/>");

// ---- Buttons ----
(_display getVariable "buttons") params ["_main", "_second", "_leave"];

switch (true) do {
    case (_status == STATUS_OVER): {
        _main ctrlShow _isOwner;
        _main ctrlEnable true;
        _main ctrlSetText LLSTRING(GameRestart);
        _main setVariable [QGVAR(action), "start"];
    };
    case (_hasDrawn): {
        _main ctrlShow true;
        _main ctrlEnable _canAct;
        _main ctrlSetText LLSTRING(GameTakeDrawn);
        _main setVariable [QGVAR(action), "takeDrawn"];
    };
    default {
        _main ctrlShow (_status == STATUS_PLAYING);
        _main ctrlEnable (_canAct && {!_targeting});
        _main ctrlSetText LLSTRING(GameStand);
        _main setVariable [QGVAR(action), "stand"];
    };
};

_second ctrlShow _hasDrawn;
_second ctrlEnable _canAct;
_second ctrlSetText LLSTRING(GameKeepHand);
_second setVariable [QGVAR(action), "keepHand"];

_leave ctrlSetText ([LLSTRING(GameLeave), LLSTRING(GameLeaveConfirm)] select GVAR(leaveConfirm));
_leave setVariable [QGVAR(action), "leave"];

// ---- Shift tokens ----
private _myShifts = _me get "shifts";
private _canShift = _canAct && {!_hasDrawn} && {!(_me get "shiftUsed")};
{
    if (_forEachIndex < count _myShifts) then {
        private _shift = _myShifts select _forEachIndex;
        ([_shift] call FUNC(shiftInfo)) params ["_shiftName", "_shiftDesc", "", "_texture"];
        _x ctrlShow true;
        _x ctrlSetText _texture;
        _x ctrlSetTooltip format ["%1 : %2", _shiftName, _shiftDesc];
        _x ctrlEnable _canShift;
        _x ctrlSetTextColor ([COLOR_DIM, COLOR_WHITE] select (_canShift && {!_targeting || {GVAR(targeting) == _shift}}));
    } else {
        _x ctrlShow false;
    };
} forEach (_display getVariable "shiftSlots");

private _shiftText = switch (true) do {
    case (_myShifts isEqualTo []): {LLSTRING(ShiftNone)};
    case (_targeting): {format [LLSTRING(ShiftTargeting), ([GVAR(targeting)] call FUNC(shiftInfo)) select 0]};
    case (_myTurn && {_me get "shiftUsed"}): {LLSTRING(ShiftUsedThisTurn)};
    default {LLSTRING(ShiftHint)};
};
(_display getVariable "shiftText") ctrlSetStructuredText parseText format ["<t size='0.75' color='#cccccc'>%1</t>", _shiftText];
