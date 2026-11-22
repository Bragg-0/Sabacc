#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Applies the effect of a shift token. "Taxes" move chips from a player's reserve
 * to their pot (lost if they lose the round). Effects marked "until the reveal"
 * are stored in the round effects and cleared when the next round starts.
 *
 * Arguments:
 * 0: Table <HASHMAP>
 * 1: Player using the token <HASHMAP>
 * 2: Shift id (1..16) <NUMBER>
 * 3: Target uid (targeted tokens only) <STRING>
 *
 * Return Value:
 * Token consumed <BOOL>
 */
params ["_table", "_player", "_shift", ["_targetUid", "", [""]]];

private _unit = _player get "unit";
private _uid = _player get "uid";
private _effects = _table get "effects";
private _others = ([_table] call FUNC(serverActivePlayers)) select {(_x get "uid") != _uid};

// ---- Validation -------------------------------------------------------------
private _target = createHashMap;
if (_shift in [2, 4, 14, 16]) then {
    _target = [_table, _targetUid] call FUNC(serverFindPlayer);
    if (count _target == 0 || {_target get "out"} || {_targetUid == _uid}) then {_target = createHashMap};
};
if (_shift in [2, 4, 14, 16] && {count _target == 0}) exitWith {
    [_unit, LSTRING(ErrorInvalidTarget)] call FUNC(serverNotify);
    false
};
if (count _target > 0 && {_target get "immune"}) exitWith {
    [_unit, LSTRING(ErrorTargetImmune), [_target get "name"]] call FUNC(serverNotify);
    false
};
if (_shift == 2 && {(_target get "chips") < 3}) exitWith {
    [_unit, LSTRING(ErrorAuditChips), [_target get "name"]] call FUNC(serverNotify);
    false
};

// Next player to act, for the Embargo
private _next = createHashMap;
if (_shift == 6) then {
    private _order = _table get "order";
    for "_i" from 1 to count _order do {
        private _candidate = [_table, _order select (((_table get "lapPos") + _i) mod count _order)] call FUNC(serverFindPlayer);
        if !(_candidate get "out") exitWith {_next = _candidate};
    };
};
if (_shift == 6 && {count _next == 0 || {(_next get "uid") == _uid}}) exitWith {
    [_unit, LSTRING(ErrorInvalidTarget)] call FUNC(serverNotify);
    false
};
if (_shift == 6 && {_next get "immune"}) exitWith {
    [_unit, LSTRING(ErrorTargetImmune), [_next get "name"]] call FUNC(serverNotify);
    false
};

// ---- Helpers ----------------------------------------------------------------
private _fnc_tax = {
    params ["_payer", "_amount"];
    if (_payer get "immune") exitWith {0};
    private _paid = (_payer get "chips") min _amount;
    _payer set ["chips", (_payer get "chips") - _paid];
    _payer set ["pot", (_payer get "pot") + _paid];
    _paid
};
private _fnc_refund = {
    params ["_receiver", "_amount"];
    private _back = (_receiver get "pot") min _amount;
    _receiver set ["pot", (_receiver get "pot") - _back];
    _receiver set ["chips", (_receiver get "chips") + _back];
    _back
};

// ---- Effects ----------------------------------------------------------------
switch (_shift) do {
    case 1: {[_player, 3] call _fnc_refund};                  // Rebate
    case 2: {[_target, 3] call _fnc_tax};                     // Inspection
    case 3: {_effects set ["impostorSix", true]};             // Fixed mirage
    case 4: {                                                 // Forced swap
        private _mySand = _player get "sand";
        private _myBlood = _player get "blood";
        _player set ["sand", _target get "sand"];
        _player set ["blood", _target get "blood"];
        _target set ["sand", _mySand];
        _target set ["blood", _myBlood];
    };
    case 5: {_effects set ["sylopZero", true]};               // Dimmed sylop
    case 6: {_effects set ["embargo", _next get "uid"]};      // Blockade
    case 7: {                                                 // Skim
        {
            if (!(_x get "immune") && {(_x get "pot") > 0}) then {
                _x set ["pot", (_x get "pot") - 1];
                _player set ["pot", (_player get "pot") + 1];
            };
        } forEach _others;
    };
    case 8: {_effects set ["freeDraw", _uid]};                // Courtesy draw
    case 9: {_player set ["immune", true]};                   // Shield
    case 10: {                                                // Crackdown
        {
            if ((_x get "lastAction") == "stand") then {[_x, 2] call _fnc_tax};
        } forEach _others;
    };
    case 11: {{[_x, 1] call _fnc_tax} forEach _others};       // Table fee
    case 12: {[_player, 2] call _fnc_refund};                 // Discount
    case 13: {                                                // Priority odds
        _player set ["pending", ["priority", [1 + floor random 6, 1 + floor random 6], -1]];
    };
    case 14: {[_target, 2] call _fnc_tax};                    // Fine
    case 15: {_effects set ["inverted", true]};               // Upside down
    case 16: {                                                // Reshuffle
        private _decks = _table get "decks";
        private _discards = _table get "discards";
        {
            _x params ["_key", "_suit"];
            private _deck = _decks select _suit;
            if (_deck isNotEqualTo []) then {
                (_discards select _suit) pushBack (_target get _key);
                _target set [_key, _deck deleteAt 0];
            };
        } forEach [["sand", SUIT_SAND], ["blood", SUIT_BLOOD]];
    };
};

private _shiftKey = format ["STR_brg_game_Shift%1Name", _shift];
if (count _target > 0) then {
    [_table, LSTRING(LogShiftTarget), [_player get "name", _shiftKey, _target get "name"]] call FUNC(serverLog);
} else {
    [_table, LSTRING(LogShift), [_player get "name", _shiftKey]] call FUNC(serverLog);
};

true
