// Holographic style controls, used by ctrlCreate in fnc_menuOnLoad / fnc_gameOnLoad.
// Both displays are empty shells: every control is created at runtime.

class RscText;
class RscStructuredText;
class RscButton;
class RscListBox;
class RscEdit;
class RscCombo;

// Text sized with the layout grid (see UI_H in script_macros.hpp)
class GVAR(Text): RscText {
    sizeEx = QUOTE(UI_H * 0.9);
};

class GVAR(StructuredText): RscStructuredText {
    size = QUOTE(UI_H * 0.92);
};

class GVAR(Button): RscButton {
    font = "PuristaSemibold";
    sizeEx = QUOTE(UI_H * 0.85);
    shadow = 0;
    colorText[] = {0.75, 0.95, 1, 1};
    colorDisabled[] = {0.5, 0.65, 0.7, 0.35};
    colorBackground[] = {0.03, 0.15, 0.21, 0.9};
    colorBackgroundActive[] = {0.1, 0.45, 0.6, 1};
    colorBackgroundDisabled[] = {0.03, 0.06, 0.08, 0.7};
    colorFocused[] = {0.05, 0.24, 0.32, 0.95};
    colorShadow[] = {0, 0, 0, 0};
    colorBorder[] = {0, 0, 0, 0};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
};

class GVAR(ButtonAccent): GVAR(Button) {
    colorText[] = {1, 0.88, 0.6, 1};
    colorBackground[] = {0.32, 0.18, 0.02, 0.92};
    colorBackgroundActive[] = {0.75, 0.45, 0.06, 1};
    colorFocused[] = {0.48, 0.28, 0.03, 0.95};
};

class GVAR(ButtonDanger): GVAR(Button) {
    colorText[] = {1, 0.75, 0.72, 1};
    colorBackground[] = {0.26, 0.04, 0.04, 0.9};
    colorBackgroundActive[] = {0.62, 0.1, 0.08, 1};
    colorFocused[] = {0.38, 0.06, 0.05, 0.95};
};

class GVAR(ListBox): RscListBox {
    font = "PuristaMedium";
    sizeEx = QUOTE(UI_H * 0.9);
    rowHeight = QUOTE(UI_H * 1.3);
    colorBackground[] = {0.01, 0.05, 0.08, 0.85};
    colorText[] = {0.8, 0.95, 1, 1};
    colorSelect[] = {1, 1, 1, 1};
    colorSelect2[] = {1, 1, 1, 1};
    colorSelectBackground[] = {0.1, 0.42, 0.56, 0.85};
    colorSelectBackground2[] = {0.1, 0.42, 0.56, 0.85};
};

class GVAR(Edit): RscEdit {
    font = "PuristaMedium";
    sizeEx = QUOTE(UI_H * 0.9);
    colorBackground[] = {0.01, 0.05, 0.08, 0.9};
    colorText[] = {0.85, 0.97, 1, 1};
    colorBorder[] = {0.37, 0.85, 1, 0.5};
    colorSelection[] = {0.1, 0.42, 0.56, 1};
};

class GVAR(Combo): RscCombo {
    font = "PuristaMedium";
    sizeEx = QUOTE(UI_H * 0.9);
    colorBackground[] = {0.01, 0.05, 0.08, 0.95};
    colorText[] = {0.85, 0.97, 1, 1};
    colorSelect[] = {1, 1, 1, 1};
    colorSelectBackground[] = {0.1, 0.42, 0.56, 0.95};
};

class GVAR(menu) {
    idd = IDD_MENU;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = QUOTE(_this call FUNC(menuOnLoad));
    onUnload = QUOTE(_this call FUNC(menuOnUnload));
    class controlsBackground {};
    class controls {};
};

class GVAR(game) {
    idd = IDD_GAME;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = QUOTE(_this call FUNC(gameOnLoad));
    onUnload = QUOTE(_this call FUNC(gameOnUnload));
    class controlsBackground {};
    class controls {};
};
