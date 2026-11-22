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
                    class Five {name = "5"; value = 5;};
                    class Six {name = "6"; value = 6;};
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
                    class Four {name = "4"; value = 4;};
                    class Five {name = "5"; value = 5;};
                };
            };
            class Variant: Combo {
                property = QGVAR(moduleTable_variant);
                displayName = CSTRING(RulesVariant);
                tooltip = CSTRING(RulesVariantTip);
                typeName = "STRING";
                defaultValue = "'classic'";
                class Values {
                    class Classic {name = CSTRING(VariantClassic); value = "classic";};
                    class Quick {name = CSTRING(VariantQuick); value = "quick";};
                    class NoShifts {name = CSTRING(VariantNoShifts); value = "noShifts";};
                    class HighStakes {name = CSTRING(VariantHighStakes); value = "highStakes";};
                };
            };
            class DroidLevel: Combo {
                property = QGVAR(moduleTable_droidLevel);
                displayName = CSTRING(RulesDroidLevel);
                tooltip = CSTRING(RulesDroidLevelTip);
                typeName = "NUMBER";
                defaultValue = "1";
                class Values {
                    class Easy {name = CSTRING(DroidEasy); value = 0;};
                    class Normal {name = CSTRING(DroidNormal); value = 1;};
                    class Hard {name = CSTRING(DroidHard); value = 2;};
                };
            };
            class Tournament: Combo {
                property = QGVAR(moduleTable_tournament);
                displayName = CSTRING(RulesTournament);
                tooltip = CSTRING(RulesTournamentTip);
                typeName = "NUMBER";
                defaultValue = "0";
                class Values {
                    class None {name = CSTRING(TournamentNone); value = 0;};
                    class Three {name = CSTRING(Tournament3); value = 3;};
                    class Five {name = CSTRING(Tournament5); value = 5;};
                };
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(ModuleTableDesc);
        };
    };
};
