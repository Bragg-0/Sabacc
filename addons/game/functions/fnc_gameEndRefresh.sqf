#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Shows / fills the end screen once the game is over:
 * victory or defeat, winner, final ranking and what to do next.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: View <HASHMAP>
 *
 * Return Value:
 * None
 */
params ["_display", "_state"];

private _visible = (_state get "status") == STATUS_OVER && {!GVAR(endHidden)};
{_x ctrlShow _visible} forEach (_display getVariable "endScreen");

// Arma draws the focused control (last clicked / hovered) above everything, whatever the creation order:
// everything interactive under the end screen is hidden while it is shown
private _under = [
    _display getVariable "log", _display getVariable "inspector",
    _display getVariable "mySand", _display getVariable "myBlood", _display getVariable "myDrawn"
] + ((_display getVariable "piles") apply {_x select 0}) + (_display getVariable "buttons") + (_display getVariable "shiftSlots");
{_under append _x} forEach (_display getVariable "seatShifts");
{_under pushBack (_x select 6)} forEach (_display getVariable "seats"); // target buttons

if (_visible) then {
    {_x ctrlShow false} forEach _under;
} else {
    // gameRefresh already decided the visibility of buttons, piles, cards and shift tokens
    {_x ctrlShow true} forEach [_display getVariable "log", _display getVariable "inspector"];
};
if (!_visible) exitWith {};

private _spectator = _state getOrDefault ["spectator", false];
private _myUid = getPlayerUID player;
private _players = _state get "players";
private _winner = _state get "winner";
private _myIndex = _players findIf {(_x get "uid") == _myUid};
private _iWon = _myIndex >= 0 && {_winner != ""} && {_winner == ((_players select _myIndex) get "name")};

(_display getVariable "endTexts") params ["_title", "_subtitle"];

// ---- Title ----
// Upper case is applied to the text only: upper-cased tags (<T COLOR=...>) would not be parsed
(switch (true) do {
    case (_winner == "" || _spectator): {[HTML_TEXT, LLSTRING(EndDraw)]};
    case (_iWon): {[HTML_GOOD, LLSTRING(EndVictory)]};
    default {[HTML_BAD, LLSTRING(EndDefeat)]};
}) params ["_titleColor", "_titleText"];
_title ctrlSetStructuredText parseText format [
    "<t align='center' font='PuristaBold' size='2.2' color='%1'>%2</t>", _titleColor, toUpper _titleText
];

private _subtitleText = if (_winner == "") then {LLSTRING(EndNoWinner)} else {format [LLSTRING(EndWinnerIs), _winner]};
_subtitle ctrlSetStructuredText parseText format [
    "<t align='center' size='0.9' color='%1'>%2</t><t align='center' size='0.75' color='%3'>   |   %4</t>",
    HTML_TEXT, _subtitleText, HTML_MUTED, format [LLSTRING(EndRoundsPlayed), _state get "round"]
];

// ---- Ranking: winner first, then whoever was eliminated last, then by chips, then by rounds won ----
// Sort keys only (the last key is the player index, so two players never compare as equal)
private _sorted = [];
{
    private _isWinner = (_x get "name") == _winner && {!(_x get "out")};
    private _eliminated = _x get "eliminatedRound";
    _sorted pushBack [
        parseNumber !_isWinner,
        -([_eliminated, 999] select (_eliminated < 0)),
        -(_x get "chips"),
        -(_x get "roundsWon"),
        _forEachIndex
    ];
} forEach _players;
_sorted sort true;
_sorted = _sorted apply {[_x select 0, _x select 1, _x select 2, _players select (_x select 4)]};

private _fnc_cell = {
    params ["_ctrl", "_text", ["_align", "left"], ["_color", HTML_TEXT], ["_size", 1], ["_font", "PuristaMedium"]];
    _ctrl ctrlSetStructuredText parseText format [
        "<t align='%1' valign='middle' size='%2' font='%3' color='%4'>%5</t>", _align, _size, _font, _color, _text
    ];
};

// Header
{
    _x params ["_text", "_align"];
    [(_display getVariable "endHeader") select _forEachIndex, toUpper _text, _align, HTML_MUTED, 0.68, "PuristaSemibold"] call _fnc_cell;
} forEach [
    [LLSTRING(EndColRank), "left"],
    [LLSTRING(EndColPlayer), "left"],
    [LLSTRING(EndColStatus), "left"],
    [LLSTRING(EndColRounds), "center"],
    [LLSTRING(EndColChips), "center"]
];

// One line per player, empty lines hidden
{
    private _row = _x;
    private _rowIndex = _forEachIndex;
    if (_rowIndex >= count _sorted) then {
        {_x ctrlShow false} forEach _row;
    } else {
        private _entry = _sorted select _rowIndex;
        private _player = _entry select 3;
        private _isMe = (_player get "uid") == _myUid;
        private _isWinner = (_entry select 0) == 0;
        private _eliminated = _player get "eliminatedRound";
        private _status = switch (true) do {
            case (_isWinner): {[toUpper LLSTRING(EndWinnerTag), HTML_GOOD]};
            case (_player get "left"): {[LLSTRING(EndLeft), HTML_BAD]};
            case (_eliminated > 0): {[format [LLSTRING(EndEliminated), _eliminated], HTML_BAD]};
            default {["", HTML_TEXT]};
        };

        _row params ["_stripe", "_rankCell", "_nameCell", "_statusCell", "_roundsCell", "_chipsCell"];
        // Winner line highlighted in green, my line in amber
        _stripe ctrlSetBackgroundColor (switch (true) do {
            case (_isWinner): {[0.2, 0.9, 0.45, 0.14]};
            case (_isMe): {[1, 0.7, 0.27, 0.12]};
            default {[0.37, 0.85, 1, [0.07, 0.03] select (_rowIndex mod 2)]};
        });
        [_rankCell, format ["#%1", _rowIndex + 1], "left", [HTML_DIM, HTML_AMBER] select (_rowIndex == 0), 1.05, "PuristaBold"] call _fnc_cell;
        [_nameCell, toUpper (_player get "name"), "left", [HTML_TEXT, HTML_AMBER] select _isMe, 1, "PuristaSemibold"] call _fnc_cell;
        [_statusCell, _status select 0, "left", _status select 1, 0.8] call _fnc_cell;
        [_roundsCell, str (_player get "roundsWon"), "center", HTML_HOLO, 1.05, "PuristaBold"] call _fnc_cell;
        [_chipsCell, str (_player get "chips"), "center", [HTML_TEXT, HTML_GOOD] select ((_player get "chips") > 0), 1.05, "PuristaBold"] call _fnc_cell;
    };
} forEach (_display getVariable "endRows");

// ---- Buttons: a new game starts when every player (droids aside) accepted ----
([_state] call FUNC(rematchInfo)) params ["_canVote", "_voted", "_readyCount", "_humanCount"];
private _restart = _display getVariable "endRestart";
_restart ctrlEnable (_canVote && {!_voted});
_restart ctrlSetText toUpper format [[LLSTRING(GameRematch), LLSTRING(GameRematchWaiting)] select _voted, _readyCount, _humanCount];
// Keep the focus on the end screen so nothing underneath comes back on top
ctrlSetFocus ([(_display getVariable "endScreen") select -3, _restart] select (_canVote && {!_voted}));
_restart ctrlSetTooltip ([LLSTRING(EndSpectatorNoVote), LLSTRING(TipRematch)] select _canVote);
