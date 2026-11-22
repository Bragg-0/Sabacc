#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Formats the statistics panel of the menu: my statistics, then the server ranking.
 *
 * Arguments:
 * 0: [my stats, top 5] as sent by the server (empty while waiting) <ARRAY>
 *    stats = [name, games played, games won, rounds played, rounds won, sabaccs, pure sabaccs]
 *
 * Return Value:
 * Structured text <STRING>
 */
params [["_data", [], [[]]]];

if (_data isEqualTo []) exitWith {
    format ["<t size='0.85' color='%1'>%2</t>", HTML_MUTED, LLSTRING(StatsLoading)]
};
_data params ["_mine", "_top"];
_mine params ["", "_games", "_wins", "_rounds", "_roundWins", "_sabaccs", "_pure"];

private _fnc_percent = {
    params ["_part", "_total"];
    if (_total <= 0) exitWith {""};
    format ["  <t size='0.75' color='%1'>(%2%%)</t>", HTML_MUTED, round (100 * _part / _total)]
};

private _lines = [
    format ["<t size='1.1' font='PuristaBold' color='%1'>%2</t>", HTML_AMBER, toUpper LLSTRING(StatsMine)],
    [LLSTRING(StatsGames), _games, HTML_TEXT, 0.85] call FUNC(uiRow),
    [LLSTRING(StatsWins), format ["%1%2", _wins, [_wins, _games] call _fnc_percent], HTML_GOOD, 0.85] call FUNC(uiRow),
    [LLSTRING(StatsRounds), _rounds, HTML_TEXT, 0.85] call FUNC(uiRow),
    [LLSTRING(StatsRoundWins), format ["%1%2", _roundWins, [_roundWins, _rounds] call _fnc_percent], HTML_GOOD, 0.85] call FUNC(uiRow),
    [LLSTRING(StatsSabaccs), _sabaccs, HTML_HOLO, 0.85] call FUNC(uiRow),
    [LLSTRING(StatsPure), _pure, HTML_AMBER, 0.85] call FUNC(uiRow),
    "",
    format ["<t size='1.1' font='PuristaBold' color='%1'>%2</t>", HTML_AMBER, toUpper LLSTRING(StatsRanking)]
];

if (_top isEqualTo []) then {
    _lines pushBack format ["<t size='0.8' color='%1'>%2</t>", HTML_MUTED, LLSTRING(StatsNoRanking)];
} else {
    {
        _x params ["_name", "_g", "_w"];
        _lines pushBack ([
            format ["#%1  %2", _forEachIndex + 1, _name],
            format [LLSTRING(StatsRankingRow), _w, _g],
            [HTML_TEXT, HTML_AMBER] select (_forEachIndex == 0),
            0.8
        ] call FUNC(uiRow));
    } forEach _top;
};

_lines joinString "<br/>"
