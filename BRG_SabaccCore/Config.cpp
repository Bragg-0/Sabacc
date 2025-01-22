#include "macro.hpp"

class CfgPatches
{
    class BRG_Sabacc
    {
        name = "[BRG] Sabacc";
        author = "Bragg";
        requiredAddons[] = {};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class BRG_Sabacc_Functions
    {
        tag = "BRG";
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 1;

        /* Client only functions */

        /* Server only functions */

        /* Functions for everyone */
    };
};