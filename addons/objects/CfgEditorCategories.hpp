// Eden: own "Sabacc" category
class CfgEditorCategories {
    class DOUBLES(PREFIX,sabacc) {
        displayName = "Sabacc";
    };
};

class CfgEditorSubcategories {
    class DOUBLES(PREFIX,sabacc_equipment) {
        displayName = CSTRING(EditorEquipment);
    };
    class DOUBLES(PREFIX,sabacc_tables) {
        displayName = CSTRING(EditorTables);
    };
};
