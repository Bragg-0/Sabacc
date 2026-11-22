class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(openTerminal) {
                    displayName = ECSTRING(game,ActionOpen);
                    icon = TEXTURE_TERMINAL;
                    condition = QUOTE([_player] call EFUNC(game,canOpenTerminal));
                    statement = QUOTE([] call EFUNC(game,openTerminal));
                    exceptions[] = {};
                    showDisabled = 0;
                };
            };
        };
    };
};
