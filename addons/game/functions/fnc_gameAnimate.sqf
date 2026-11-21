#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Compares the previous and the new table view and plays the matching animations:
 * dealing, drawing, discarding, reveal flips, chips won/lost, dice, banners, sounds.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Previous view <HASHMAP>
 * 2: New view <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_display", "_prev", "_state"];

if (_prev isEqualTo _state) exitWith {};

([_state] call FUNC(viewSubject)) params ["_myUid", "_me", "_spectator"];
private _players = _state get "players";
private _prevPlayers = _prev getOrDefault ["players", []];
private _prevMeIndex = _prevPlayers findIf {(_x get "uid") == _myUid};
private _prevMe = if (_prevMeIndex >= 0) then {_prevPlayers select _prevMeIndex} else {createHashMap};

private _status = _state get "status";
private _phase = _state get "phase";
private _firstView = count _prev == 0 || {(_prev get "id") != (_state get "id")};
private _newRound = _firstView || {(_prev get "round") != (_state get "round")};
private _prevPhase = _prev getOrDefault ["phase", ""];

// Pile positions, in the order created by gameOnLoad: sand deck, sand discard, blood discard, blood deck
private _piles = (_display getVariable "piles") apply {_x select 0};
private _pilePos = _piles apply {_x getVariable [QGVAR(basePos), ctrlPosition _x]};
private _deckPos = [_pilePos select 0, _pilePos select 3];
private _discardCtrls = [_piles select 1, _piles select 2];
private _deckCtrls = [_piles select 0, _piles select 3];

private _seats = _display getVariable "seats";
private _seatUids = _display getVariable ["seatUids", []];
private _fnc_chipsPos = {
    params ["_uid"];
    private _ctrl = if (_uid == _myUid) then {
        _display getVariable "handInfo"
    } else {
        private _index = _seatUids find _uid;
        if (_index < 0) exitWith {controlNull};
        (_seats select _index) select 2
    };
    if (isNull _ctrl) exitWith {[]};
    (ctrlPosition _ctrl) params ["_px", "_py"];
    [_px + GW(1), _py]
};

// ---- New round: deal the cards ----
if (_newRound && {_status == STATUS_PLAYING} && {_phase == PHASE_TURN}) then {
    private _delay = 0.1;
    // Opponents first, then me, like a real dealer
    {
        if (ctrlShown (_x select 0)) then {
            [_x select 3, _deckPos select 0, 0.35, _delay] call FUNC(animFly);
            [_x select 4, _deckPos select 1, 0.35, _delay + 0.08] call FUNC(animFly);
            _delay = _delay + 0.2;
        };
    } forEach _seats;
    [_display getVariable "mySand", _deckPos select 0, 0.4, _delay] call FUNC(animFly);
    [_display getVariable "myBlood", _deckPos select 1, 0.4, _delay + 0.1] call FUNC(animFly);
    {[_x, _delay + 0.4] call FUNC(animPop)} forEach _discardCtrls;

    [_display, format [LLSTRING(BannerRound), _state get "round"], "#ffe0a0"] call FUNC(animBanner);
    if ((_state get "round") == 1) then {["FD_Start_F"] call FUNC(playSound)};
};

if (_firstView) exitWith {};

// ---- Piles: somebody drew or discarded ----
if (!_newRound) then {
    private _prevTops = _prev get "discardTops";
    private _prevCounts = _prev get "deckCounts";
    {
        if ((_prevTops select _forEachIndex) != _x) then {[_discardCtrls select _forEachIndex] call FUNC(animPop)};
    } forEach (_state get "discardTops");
    {
        if ((_prevCounts select _forEachIndex) != _x) then {[_deckCtrls select _forEachIndex] call FUNC(animPop)};
    } forEach (_state get "deckCounts");

    // My drawn card comes from the pile it was taken from
    private _drawn = _me get "drawn";
    if (_drawn >= 0 && {(_prevMe getOrDefault ["drawn", CARD_NONE]) < 0}) then {
        private _suit = CARD_SUIT(_drawn);
        private _fromDeck = ((_state get "deckCounts") select _suit) < (_prevCounts select _suit);
        private _from = if (_fromDeck) then {_deckPos select _suit} else {_pilePos select (1 + _suit)};
        [_display getVariable "myDrawn", _from, 0.35] call FUNC(animFly);
    };

    // A card of my hand was replaced (kept drawn card, or a shift swapped my hand)
    private _drawnPos = (_display getVariable "myDrawn") getVariable [QGVAR(basePos), []];
    {
        _x params ["_key", "_ctrlName"];
        private _old = _prevMe getOrDefault [_key, CARD_NONE];
        if (_old >= 0 && {(_me get _key) != _old} && {_phase == PHASE_TURN}) then {
            [_display getVariable _ctrlName, _drawnPos, 0.3] call FUNC(animFly);
        };
    } forEach [["sand", "mySand"], ["blood", "myBlood"]];
};

// ---- Reveal ----
if (_phase == PHASE_RESULTS && {_prevPhase != PHASE_RESULTS}) then {
    ["FD_CP_Clear_F"] call FUNC(playSound);
    private _results = _state get "results";
    private _delay = 0.1;
    {
        private _seat = _x;
        private _index = _forEachIndex;
        if (ctrlShown (_seat select 0) && {_index < count _seatUids}) then {
            private _uid = _seatUids select _index;
            private _player = _players select (_players findIf {(_x get "uid") == _uid});
            // Everyone who took part in the round, even if eliminated by this result
            if (_results findIf {(_x select 0) == _uid} >= 0) then {
                [_seat select 3, [_player get "sand"] call FUNC(cardTexture), _delay] call FUNC(animFlip);
                [_seat select 4, [_player get "blood"] call FUNC(cardTexture), _delay + 0.15] call FUNC(animFlip);
                _delay = _delay + 0.35;
            };
        };
    } forEach _seats;

    // Chips won / lost, once the cards are visible
    {
        _x params ["_uid", "", "", "", "", "", "_won", "_delta"];
        private _position = [_uid] call _fnc_chipsPos;
        if (_position isNotEqualTo [] && {_delta != 0}) then {
            private _text = if (_delta > 0) then {format ["+%1", _delta]} else {str _delta};
            [_display, _text, _position, ["#ff7070", "#70ff70"] select _won, _delay + 0.3] call FUNC(animFloatText);
        };
        if (_uid == _myUid && {!_spectator}) then {
            if (_won) then {
                [_display, LLSTRING(BannerWin), "#70ff70", _delay + 0.4] call FUNC(animBanner);
                ["FD_Finish_F"] call FUNC(playSound);
            } else {
                [_display, LLSTRING(BannerLose), "#ff7070", _delay + 0.4] call FUNC(animBanner);
            };
        };
    } forEach _results;
};

// ---- Chips moving during a round (draw cost, taxes, refunds...) ----
if (!_newRound && {_phase != PHASE_RESULTS}) then {
    {
        private _uid = _x get "uid";
        private _prevIndex = _prevPlayers findIf {(_x get "uid") == _uid};
        if (_prevIndex >= 0) then {
            private _delta = (_x get "chips") - ((_prevPlayers select _prevIndex) get "chips");
            private _position = [_uid] call _fnc_chipsPos;
            if (_delta != 0 && {_position isNotEqualTo []}) then {
                private _text = if (_delta > 0) then {format ["+%1", _delta]} else {str _delta};
                [_display, _text, _position, ["#ffa050", "#a0ff80"] select (_delta > 0)] call FUNC(animFloatText);
            };
        };
    } forEach _players;
};

// ---- My turn ----
private _current = _state get "current";
if (!_spectator && {_current == _myUid} && {(_prev get "current") != _myUid}) then {
    [_display, LLSTRING(BannerYourTurn), "#ffc040", [0, 1.2] select _newRound] call FUNC(animBanner);
    ["FD_Timer_F"] call FUNC(playSound);
};

// ---- Dice ----
private _pending = _me get "pending";
if (_pending isNotEqualTo [] && {(_prevMe getOrDefault ["pending", []]) isEqualTo []}) then {
    private _choice = _display getVariable "choice";
    [[_choice select 2, _choice select 3], _pending select 1] call FUNC(animDice);
};

// ---- Game over ----
if (_status == STATUS_OVER && {(_prev get "status") != STATUS_OVER}) then {
    private _winner = _state get "winner";
    if (!_spectator && {_winner == (_me get "name")}) then {
        [_display, LLSTRING(BannerVictory), "#70ff70", 2.5] call FUNC(animBanner);
        ["FD_Finish_F"] call FUNC(playSound);
    } else {
        [_display, LLSTRING(BannerGameOver), "#ffe0a0", 2.5] call FUNC(animBanner);
    };

    // The end screen appears once the last results and the banner have been seen
    GVAR(endHidden) = true;
    {_x ctrlShow false} forEach (_display getVariable "endScreen");
    [{
        params ["_display"];
        if (isNull _display || {(GVAR(state) getOrDefault ["status", ""]) != STATUS_OVER}) exitWith {};
        GVAR(endHidden) = false;
        call FUNC(gameRefresh);
        {
            _x ctrlSetFade 1;
            _x ctrlCommit 0;
            _x ctrlSetFade 0;
            _x ctrlCommit 0.6;
        } forEach (_display getVariable "endScreen");
    }, [_display], 4.5] call CBA_fnc_waitAndExecute;
};
