private _category = ["Sabacc", LLSTRING(SettingsRules)];

[
    QGVAR(startChips), "SLIDER",
    [LSTRING(SettingStartChips), LSTRING(SettingStartChipsTip)],
    _category, [4, 20, 8, 0], 1
] call CBA_fnc_addSetting;

[
    QGVAR(shiftsPerPlayer), "SLIDER",
    [LSTRING(SettingShifts), LSTRING(SettingShiftsTip)],
    _category, [0, 4, 2, 0], 1
] call CBA_fnc_addSetting;

[
    QGVAR(turnTime), "SLIDER",
    [LSTRING(SettingTurnTime), LSTRING(SettingTurnTimeTip)],
    _category, [15, 180, 60, 0], 1
] call CBA_fnc_addSetting;

[
    QGVAR(resultsTime), "SLIDER",
    [LSTRING(SettingResultsTime), LSTRING(SettingResultsTimeTip)],
    _category, [5, 30, 12, 0], 1
] call CBA_fnc_addSetting;

[
    QGVAR(requireTerminal), "CHECKBOX",
    [LSTRING(SettingRequireTerminal), LSTRING(SettingRequireTerminalTip)],
    ["Sabacc", LLSTRING(SettingsAccess)], true, 1
] call CBA_fnc_addSetting;

[
    QGVAR(sounds), "CHECKBOX",
    [LSTRING(SettingSounds), LSTRING(SettingSoundsTip)],
    ["Sabacc", LLSTRING(SettingsInterface)], true, 0
] call CBA_fnc_addSetting;
