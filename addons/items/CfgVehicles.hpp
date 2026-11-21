class CfgVehicles {
    class Item_Base_F;
    class GVAR(terminal_item): Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        author = AUTHOR;
        displayName = CSTRING(DisplayName);
        model = "\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_Civ_F";
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        class TransportItems {
            class _xx_brg_items_terminal {
                name = QGVAR(terminal);
                count = 1;
            };
        };
    };
};
