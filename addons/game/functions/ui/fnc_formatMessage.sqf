#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Localizes a message sent by the server. Messages travel as [key, args] so every client
 * reads them in its own language. Arguments can be:
 *   - "STR_..." keys (localized)
 *   - ["card", card] (card name)
 *   - ["msg", key, args] (nested message)
 *
 * Arguments:
 * 0: Stringtable key <STRING>
 * 1: Arguments <ARRAY>
 *
 * Return Value:
 * Text <STRING>
 *
 * Example:
 * [LSTRING(LogStand), ["Bragg"]] call brg_sabacc_game_fnc_formatMessage
 */
params [["_key", "", [""]], ["_args", [], [[]]]];

private _parsed = _args apply {
    switch (true) do {
        case (_x isEqualType "" && {(_x select [0, 4]) == "STR_"}): {localize _x};
        case (_x isEqualType [] && {(_x select 0) isEqualTo "card"}): {[_x select 1] call FUNC(cardName)};
        case (_x isEqualType [] && {(_x select 0) isEqualTo "msg"}): {[_x select 1, _x select 2] call FUNC(formatMessage)};
        default {_x};
    };
};

format ([localize _key] + _parsed)
