#include "..\..\script_component.hpp"
/*
 * Author: Bragg
 * Holographic messages above the dealer droids (client, every frame from a Draw3D handler): the last
 * thing that happened at the table (its log, published on the table object by brg_game_fnc_serverLog),
 * typed out in cyan above the droid, slightly flickering, for a few seconds, sized with the distance.
 * Not drawn through walls nor from far away.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */

private _camera = positionCameraToWorld [0, 0, 0];
{
    private _object = _x select 7;
    if (!isNull _object && {_object isKindOf TABLE_CLASS}) then {
        private _droid = _object getVariable [QGVAR(dealer), objNull];
        private _holo = _object getVariable [QGVAR(holo), []];
        if (isNull _droid || {_holo isEqualTo []}) exitWith {};
        _holo params ["_id", "_key", "_args", "_sent"];

        private _age = CBA_missionTime - _sent;
        if (_age < 0 || {_age > HOLO_DURATION}) exitWith {};
        private _pos = _droid modelToWorldVisual [0, 0, HOLO_HEIGHT];
        private _distance = _camera distance _pos;
        if (_distance > HOLO_RANGE) exitWith {};
        if (lineIntersectsSurfaces [AGLToASL _camera, AGLToASL _pos, player, _droid, true, 1] isNotEqualTo []) exitWith {};

        // Localized once per message (each client in its own language)
        if ((_object getVariable [QGVAR(holoSeen), -1]) != _id) then {
            _object setVariable [QGVAR(holoSeen), _id];
            _object setVariable [QGVAR(holoText), toArray ([_key, _args] call FUNC(formatMessage))];
        };
        private _chars = _object getVariable [QGVAR(holoText), []];

        // Typed out at first (code points: accents stay whole), fading in and out, flickering
        private _shown = toString (_chars select [0, ceil (count _chars * ((_age / HOLO_TYPING) min 1))]);
        private _alpha = ((_age / 0.25) min 1) min ((HOLO_DURATION - _age) / 0.8);
        _alpha = _alpha * (0.82 + 0.12 * sin (time * 47) + 0.06 * sin (time * 13));
        if (random 1 < 0.03) then {_alpha = _alpha * 0.45};
        private _scale = (2.2 / (_distance max 0.8)) min 2.2;

        drawIcon3D [TEXTURE_HOLO, [0.45, 0.85, 1, _alpha * 0.9], _pos, 0.9 * _scale, 0.9 * _scale, 0,
            _shown, 0, 0.032 * _scale, "EtelkaMonospacePro", "center"];
    };
} forEach (missionNamespace getVariable [QGVAR(lobby), []]);
