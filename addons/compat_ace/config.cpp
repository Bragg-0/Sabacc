#include "script_component.hpp"

// Loaded only when ACE is present: adds the "Play" self-interaction to open the terminal.
// Without ACE, the game addon adds a scroll-wheel action instead.
class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"Bragg"};
        url = ECSTRING(main,url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {QUOTE(DOUBLES(PREFIX,game)), "ace_interact_menu"};
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
