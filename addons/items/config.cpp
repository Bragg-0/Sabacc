#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"Bragg"};
        url = ECSTRING(main,url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QUOTE(MAIN_ADDON), "A3_Weapons_F", "A3_Drones_F"};
        units[] = {QGVAR(terminal_item)};
        weapons[] = {QGVAR(terminal)};
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
