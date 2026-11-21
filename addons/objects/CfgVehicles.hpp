class CBA_Extended_EventHandlers_base;

class CfgVehicles {
    // Terminal lying on the ground (editor, Zeus)
    class Item_Base_F;
    class GVAR(terminal_item): Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        author = AUTHOR;
        displayName = CSTRING(DisplayName);
        model = "\a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_Civ_F";
        editorCategory = QUOTE(DOUBLES(PREFIX,sabacc));
        editorSubcategory = QUOTE(DOUBLES(PREFIX,sabacc_equipment));
        vehicleClass = "Items";
        class TransportItems {
            class _xx_brg_objects_terminal {
                name = QGVAR(terminal);
                count = 1;
            };
        };
    };

    // Physical Sabacc table: becomes a game table on its own (see CfgEventHandlers.hpp)
    class NonStrategic;
    class GVAR(table): NonStrategic {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(TableObject);
        model = QPATHTOF(data\table\sabacc_table.p3d);
        icon = "iconObject_2x1";
        editorCategory = QUOTE(DOUBLES(PREFIX,sabacc));
        editorSubcategory = QUOTE(DOUBLES(PREFIX,sabacc_tables));
        vehicleClass = "Furniture";
        destrType = "DestructNo";
        mapSize = 2;
        cost = 100;
        // Buildings/props only run CBA's init event handlers when they declare them
        class EventHandlers {
            class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers_base {};
        };
    };
};
