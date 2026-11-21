class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;
    class GVAR(terminal): CBA_MiscItem {
        scope = 2;
        author = AUTHOR;
        displayName = CSTRING(DisplayName);
        descriptionShort = CSTRING(Description);
        model = "\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_Civ_F";
        picture = QPATHTOF(data\ui\terminal_ca.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 4;
        };
    };
};
