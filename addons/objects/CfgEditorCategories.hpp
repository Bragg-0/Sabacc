// Eden: own "Sabacc" category
class CfgEditorCategories {
    class PREFIX {
        displayName = "Sabacc";
    };
};

class CfgEditorSubcategories {
    class DOUBLES(PREFIX,equipment) {
        displayName = CSTRING(EditorEquipment);
    };
    class DOUBLES(PREFIX,tables) {
        displayName = CSTRING(EditorTables);
    };
    class DOUBLES(PREFIX,furniture) {
        displayName = CSTRING(EditorFurniture);
    };
};
