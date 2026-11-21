#include "script_component.hpp"

// Physical tables: ACE interactions on the object (sit / watch / open), in addition to the
// scroll-wheel actions. The game addon raises this local event once per table object it discovers.
[QEGVAR(game,worldTableAdded), {
    params ["_object"];

    // One "Sabacc" node holding the 3 actions: inside the object's "Interactions" menu when it has one,
    // otherwise a single point slightly above the object (several root points would overlap)
    private _hasMain = isClass (configOf _object >> "ACE_Actions" >> "ACE_MainActions");
    private _parentPath = [[], ["ACE_MainActions"]] select _hasMain;

    private _node = [
        QGVAR(table),
        "Sabacc",
        "\x\brg\addons\items\data\ui\terminal_ca.paa",
        {},
        {
            private _target = _this select 0;
            ["sit", "watch", "open"] findIf {[_target, _x] call EFUNC(game,worldTableCan)} >= 0
        },
        {},
        [],
        [0, 0, 0.4]
    ] call ace_interact_menu_fnc_createAction;
    [_object, 0, _parentPath, _node] call ace_interact_menu_fnc_addActionToObject;

    {
        _x params ["_kind", "_titleKey"];
        private _action = [
            format ["%1_%2", QGVAR(table), _kind],
            localize _titleKey,
            "\x\brg\addons\items\data\ui\terminal_ca.paa",
            {[_target, _this select 2] call EFUNC(game,worldTableAct)},
            {[_target, _this select 2] call EFUNC(game,worldTableCan)},
            {},
            _kind
        ] call ace_interact_menu_fnc_createAction;
        [_object, 0, _parentPath + [QGVAR(table)], _action] call ace_interact_menu_fnc_addActionToObject;
    } forEach [
        ["sit", ELSTRING(game,ActionSit)],
        ["watch", ELSTRING(game,ActionWatch)],
        ["open", ELSTRING(game,ActionOpenTable)]
    ];
}] call CBA_fnc_addEventHandler;
