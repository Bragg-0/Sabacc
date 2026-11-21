// Eden module: turns the synchronized objects into physical Sabacc tables
class CfgFactionClasses {
    class NO_CATEGORY;
    class GVAR(modules): NO_CATEGORY {
        displayName = "Sabacc";
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Edit;
            class Combo;
            class ModuleDescription;
        };
        class ModuleDescription {};
    };

    class GVAR(moduleTable): Module_F {
        scope = 2;
        displayName = CSTRING(ModuleTable);
        icon = TEXTURE_TERMINAL;
        category = QGVAR(modules);
        function = QFUNC(moduleTable);
        functionPriority = 10;
        isGlobal = 0;
        isTriggerActivated = 0;
        isDisposable = 0; // the module itself is the table when nothing is synchronized
        is3DEN = 0;

        class Attributes: AttributesBase {
            class Name: Edit {
                property = QGVAR(moduleTable_name);
                displayName = CSTRING(ModuleTableName);
                tooltip = CSTRING(ModuleTableNameTip);
                typeName = "STRING";
                defaultValue = "''";
            };
            class MaxPlayers: Combo {
                property = QGVAR(moduleTable_maxPlayers);
                displayName = CSTRING(ModuleTableSeats);
                tooltip = CSTRING(ModuleTableSeatsTip);
                typeName = "NUMBER";
                defaultValue = "4";
                class Values {
                    class Two {name = "2"; value = 2;};
                    class Three {name = "3"; value = 3;};
                    class Four {name = "4"; value = 4;};
                };
            };
            class Droids: Combo {
                property = QGVAR(moduleTable_droids);
                displayName = CSTRING(ModuleTableDroids);
                tooltip = CSTRING(ModuleTableDroidsTip);
                typeName = "NUMBER";
                defaultValue = "0";
                class Values {
                    class Zero {name = "0"; value = 0;};
                    class One {name = "1"; value = 1;};
                    class Two {name = "2"; value = 2;};
                    class Three {name = "3"; value = 3;};
                };
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(ModuleTableDesc);
        };
    };
};
