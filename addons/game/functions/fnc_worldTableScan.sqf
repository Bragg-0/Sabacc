#include "..\script_component.hpp"
/*
 * Author: Bragg
 * Adds the interactions to the physical tables listed in the lobby (once per object):
 * scroll-wheel actions always, and with ACE the compat_ace addon reacts to the
 * local event QGVAR(worldTableAdded) to add ACE interactions as well.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 */
if (!hasInterface) exitWith {};

{
    _x params ["", "", "", "", "", "", ["_world", false], ["_object", objNull]];
    if (_world && {!isNull _object} && {!(_object getVariable [QGVAR(actionsAdded), false])}) then {
        _object setVariable [QGVAR(actionsAdded), true];

        {
            _x params ["_kind", "_title"];
            _object addAction [
                format ["<img image='%1'/> %2", TEXTURE_TERMINAL, _title],
                {
                    params ["_target", "", "", "_kind"];
                    [_target, _kind] call FUNC(worldTableAct);
                },
                _kind, 6, true, true, "",
                format ["[_target, '%1'] call %2", _kind, QFUNC(worldTableCan)],
                WORLD_TABLE_RANGE
            ];
        } forEach [
            ["sit", LLSTRING(ActionSit)],
            ["watch", LLSTRING(ActionWatch)],
            ["open", LLSTRING(ActionOpenTable)]
        ];

        [QGVAR(worldTableAdded), [_object]] call CBA_fnc_localEvent;
    };
} forEach (missionNamespace getVariable [QGVAR(lobby), []]);
