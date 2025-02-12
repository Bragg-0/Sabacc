class CfgPatches
{
    class BRG_SabaccItems
    {
        name = "[BRG] Sabacc - Items";
        author = "Bragg";
        requiredAddons[] = {"BRG_SabaccCore", "A3_Weapons_F", "A3_Drones_F"};
        units[] = {"BRG_SabaccItemTerminal"};
        weapons[] = {"BRG_SabaccTerminal"};
    };
};

class cfgWeapons
{
    class ItemCore;
    class BRG_SabaccTerminal : ItemCore
    {
        scope = 2;
        displayName = "$STR_Sabacc_Terminal_DisplayName";
        author = "Bragg";
        model = "\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_Civ_F";
        picture = "\BRG_SabaccItem\UI\Terminal_ca.paa";
        descriptionShort = "$STR_Sabacc_Terminal_Description";
        class ItemInfo
        {
            mass = 1;
        };
    };
};

class cfgVehicles
{
    class Item_Base_F;
    class BRG_SabaccItemTerminal : Item_Base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_Sabacc_Terminal_DisplayName";
        author = "Bragg";
        model = "\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_Civ_F";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        class TransportItems
        {
            class XX_BRG_SabaccTerminal
            {
                name = "BRG_SabaccTerminal";
                count = 1;
            };
        };
    };
};