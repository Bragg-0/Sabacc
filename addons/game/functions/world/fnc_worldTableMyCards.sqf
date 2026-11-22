#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * On a Sabacc table model, shows this player's own cards face up on the felt (local texture: the
 * others keep seeing their back). Called on every new view, and again a moment later in case the
 * public texture arrived after it.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
private _state = GVAR(state);
private _object = _state getOrDefault ["object", objNull];
private _seatCards = _object getVariable [QGVAR(seatCards), []];
if (_seatCards isEqualTo [] || {_state getOrDefault ["spectator", false]}) exitWith {};

private _players = _state get "players";
private _index = _players findIf {(_x get "uid") == getPlayerUID player};
if (_index < 0) exitWith {};
private _me = _players select _index;
private _cards = _seatCards param [TABLE_SEAT_ORDER select (_index mod 6), []];
{
    private _value = _me getOrDefault [["sand", "blood", "drawn"] select _forEachIndex, CARD_NONE];
    // Only over a card that is on the table (face down for the others)
    if (_value >= 0 && {(_x getVariable [QGVAR(publicTexture), ""]) != ""}) then {
        _x setObjectTexture [0, [_value] call FUNC(cardTexture)];
    };
} forEach _cards;
