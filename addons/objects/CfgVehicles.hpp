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
        // Eden: the same settings as the "Sabacc table" module (a synchronized module still wins)
        class Attributes {
            class GVAR(name) {
                displayName = ECSTRING(game,ModuleTableName);
                tooltip = ECSTRING(game,ModuleTableNameTip);
                property = QGVAR(name);
                control = "Edit";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "''";
                typeName = "STRING";
            };
            class GVAR(maxPlayers) {
                displayName = ECSTRING(game,ModuleTableSeats);
                tooltip = ECSTRING(game,ModuleTableSeatsTip);
                property = QGVAR(maxPlayers);
                control = "Combo";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "4";
                typeName = "NUMBER";
                class Values {
                    class V0 {name = "2"; value = 2;};
                    class V1 {name = "3"; value = 3;};
                    class V2 {name = "4"; value = 4;};
                    class V3 {name = "5"; value = 5;};
                    class V4 {name = "6"; value = 6;};
                };
            };
            class GVAR(droids) {
                displayName = ECSTRING(game,ModuleTableDroids);
                tooltip = ECSTRING(game,ModuleTableDroidsTip);
                property = QGVAR(droids);
                control = "Combo";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "0";
                typeName = "NUMBER";
                class Values {
                    class V0 {name = "0"; value = 0;};
                    class V1 {name = "1"; value = 1;};
                    class V2 {name = "2"; value = 2;};
                    class V3 {name = "3"; value = 3;};
                    class V4 {name = "4"; value = 4;};
                    class V5 {name = "5"; value = 5;};
                };
            };
            class GVAR(variant) {
                displayName = ECSTRING(game,RulesVariant);
                tooltip = ECSTRING(game,RulesVariantTip);
                property = QGVAR(variant);
                control = "Combo";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "'classic'";
                typeName = "STRING";
                class Values {
                    class V0 {name = ECSTRING(game,VariantClassic); value = "classic";};
                    class V1 {name = ECSTRING(game,VariantQuick); value = "quick";};
                    class V2 {name = ECSTRING(game,VariantNoShifts); value = "noShifts";};
                    class V3 {name = ECSTRING(game,VariantHighStakes); value = "highStakes";};
                };
            };
            class GVAR(droidLevel) {
                displayName = ECSTRING(game,RulesDroidLevel);
                tooltip = ECSTRING(game,RulesDroidLevelTip);
                property = QGVAR(droidLevel);
                control = "Combo";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "1";
                typeName = "NUMBER";
                class Values {
                    class V0 {name = ECSTRING(game,DroidEasy); value = 0;};
                    class V1 {name = ECSTRING(game,DroidNormal); value = 1;};
                    class V2 {name = ECSTRING(game,DroidHard); value = 2;};
                };
            };
            class GVAR(tournament) {
                displayName = ECSTRING(game,RulesTournament);
                tooltip = ECSTRING(game,RulesTournamentTip);
                property = QGVAR(tournament);
                control = "Combo";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "0";
                typeName = "NUMBER";
                class Values {
                    class V0 {name = ECSTRING(game,TournamentNone); value = 0;};
                    class V1 {name = ECSTRING(game,Tournament3); value = 3;};
                    class V2 {name = ECSTRING(game,Tournament5); value = 5;};
                };
            };
            // Stools placed around the table when the mission starts (players sit on them)
            class GVAR(stools) {
                displayName = CSTRING(TableStools);
                tooltip = CSTRING(TableStoolsTip);
                property = QGVAR(stools);
                control = "Checkbox";
                expression = "_this setVariable ['%s', _value, true];";
                defaultValue = "true";
                typeName = "BOOL";
            };
        };
    };

    // Furniture of the set
    class GVAR(stool): NonStrategic {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Stool);
        model = QPATHTOF(data\stool\stool.p3d);
        icon = "iconObject_1x1";
        editorCategory = QUOTE(DOUBLES(PREFIX,sabacc));
        editorSubcategory = QUOTE(DOUBLES(PREFIX,sabacc_furniture));
        vehicleClass = "Furniture";
        destrType = "DestructNo";
        mapSize = 0.5;
        cost = 10;
    };
    class GVAR(sign): NonStrategic {
        author = AUTHOR;
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Sign);
        model = QPATHTOF(data\sign\sign.p3d);
        icon = "iconObject_1x2";
        editorCategory = QUOTE(DOUBLES(PREFIX,sabacc));
        editorSubcategory = QUOTE(DOUBLES(PREFIX,sabacc_furniture));
        vehicleClass = "Furniture";
        destrType = "DestructNo";
        mapSize = 1.3;
        cost = 10;
    };

    // Chips on a physical table (created by the game): a stack of 5 (reserve) and a single chip (pot)
    class GVAR(chips5): NonStrategic {
        author = AUTHOR;
        scope = 1;
        scopeCurator = 0;
        displayName = CSTRING(Chips);
        model = QPATHTOF(data\chips\chips5.p3d);
        destrType = "DestructNo";
    };
    class GVAR(chip1): GVAR(chips5) {
        model = QPATHTOF(data\chips\chip1.p3d);
    };

    // A card lying on a physical table (created by the game, texture set by the game)
    class GVAR(card): NonStrategic {
        author = AUTHOR;
        scope = 1;
        scopeCurator = 0;
        displayName = CSTRING(Card);
        model = QPATHTOF(data\card\card.p3d);
        destrType = "DestructNo";
        hiddenSelections[] = {"camo"};
        hiddenSelectionsTextures[] = {"\x\brg\addons\game\data\ui\cards\back.paa"};
    };
};
