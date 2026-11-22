#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"Bragg"};
        url = ECSTRING(main,url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QUOTE(MAIN_ADDON), QUOTE(DOUBLES(PREFIX,objects)), "cba_settings", "cba_keybinding", "A3_Modules_F", "A3_Anims_F", "A3_Anims_F_EPA"};
        units[] = {QGVAR(moduleTable)};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMoves.hpp"
#include "CfgSounds.hpp"
#include "CfgVehicles.hpp"
#include "ui\RscSabacc.hpp"
