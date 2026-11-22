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
        name = "Nar Shaddaa Sabacc";
        author = AUTHOR;
        overview = "Nar Shaddaa Sabacc, a fan-made Sabacc card game for Arma 3.";
        hideName = 0;
        hidePicture = 1;
    };
};
