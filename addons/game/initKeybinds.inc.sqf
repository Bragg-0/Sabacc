[
    LLSTRING(GameTitle), QGVAR(openTerminal),
    [LLSTRING(KeybindOpen), LLSTRING(KeybindOpenTip)],
    {
        if (!([player] call FUNC(canOpenTerminal))) exitWith {false};
        [] call FUNC(openTerminal);
        true
    },
    {false}
] call CBA_fnc_addKeybind;
