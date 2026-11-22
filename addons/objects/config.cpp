#include "script_component.hpp"

// Objects of the mod: the terminal (inventory item) and the physical Sabacc table
class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"Bragg"};
        url = ECSTRING(main,url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QUOTE(MAIN_ADDON), "cba_main", "cba_xeh", "A3_Weapons_F", "A3_Drones_F", "A3_Structures_F"};
        units[] = {QGVAR(terminal_item), QGVAR(table), QGVAR(stool), QGVAR(sign), QGVAR(card), QGVAR(chips5), QGVAR(chip1)};
        weapons[] = {QGVAR(terminal)};
        VERSION_CONFIG;
    };
};

#include "CfgEditorCategories.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
