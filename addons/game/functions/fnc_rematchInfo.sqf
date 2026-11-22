#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Rematch vote of a finished game, seen by this player.
 *
 * Arguments:
 * 0: View of the table <HASHMAP>
 *
 * Return Value:
 * [can vote <BOOL>, already voted <BOOL>, votes <NUMBER>, players who vote <NUMBER>] <ARRAY>
 */
params ["_state"];

private _myUid = getPlayerUID player;
private _humans = ((_state get "players") select {!(_x getOrDefault ["bot", false]) && {!(_x get "left")}}) apply {_x get "uid"};
private _ready = (_state getOrDefault ["ready", []]) select {_x in _humans};
[
    !(_state getOrDefault ["spectator", false]) && {_myUid in _humans},
    _myUid in _ready,
    count _ready,
    count _humans
]
