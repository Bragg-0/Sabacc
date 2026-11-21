#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"Bragg"};
        url = CSTRING(url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "A3_Ui_F"};
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        dir = "@Sabacc";
        name = "Sabacc";
        author = AUTHOR;
        overview = "Kessel Sabacc card game for Arma 3.";
        hideName = 0;
        hidePicture = 1;
    };
};
