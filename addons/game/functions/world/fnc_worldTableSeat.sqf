#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Sits the player on their stool while they are seated at a Sabacc table model, and stands them
 * up when they leave it (or die). Called on every new view of the table.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _state = GVAR(state);
private _object = _state getOrDefault ["object", objNull];
private _players = _state getOrDefault ["players", []];
private _index = _players findIf {(_x get "uid") == getPlayerUID player};
private _stools = _object getVariable [QGVAR(stools), []];

private _stool = objNull;
if (alive player && {!(_state getOrDefault ["spectator", false])} && {_index >= 0} && {_stools isNotEqualTo []}
    && {!((_players select _index) get "left")} && {isNull objectParent player}) then {
    _stool = _stools param [[_index, _state get "maxPlayers"] call FUNC(tableSeat), objNull];
};
private _current = player getVariable [QGVAR(sittingOn), objNull];
if (_stool isEqualTo _current) exitWith {};

// Stand up from the previous stool
if (!isNull _current) then {
    player setVariable [QGVAR(sittingOn), objNull];
    [player, ""] remoteExec ["switchMove", 0];
    player setPosASL ((getPosASL _current) vectorAdd ((vectorDir _current) vectorMultiply -0.6));
    player removeAction (player getVariable [QGVAR(standAction), -1]);
    player removeEventHandler ["Killed", player getVariable [QGVAR(standKilled), -1]];
};

// Sit down, facing the table
if (!isNull _stool) then {
    player setVariable [QGVAR(sittingOn), _stool];
    // Placed on the stool, not attached to it: an attached unit cannot turn, and the camera with it.
    // The sitting pose has no collision and no legs, so the player stays put (see CfgMoves.hpp)
    // Facing the center of the table (the heading of an attached stool is not reliable)
    player setPosASL getPosASL _stool;
    player setDir (_stool getDir _object);
    // A pose at random, so a full table does not look like clones (see CfgMoves.hpp)
    [player, format ["%1_%2", QGVAR(sitting), selectRandom ["A", "B", "UA", "UB"]]] remoteExec ["switchMove", 0];
    // Standing up = leaving the table (a game in progress is forfeited, like the button)
    player setVariable [QGVAR(standAction), player addAction [
        format ["<t color='#ffb347'>%1</t>", LLSTRING(ActionStandUp)],
        {["leave"] call FUNC(request)}, nil, 1.5, false, true, "", "true"
    ]];
    player setVariable [QGVAR(standKilled), player addEventHandler ["Killed", {
        params ["_unit"];
        _unit setVariable [QGVAR(sittingOn), objNull];
    }]];
};
