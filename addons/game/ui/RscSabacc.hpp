// Both displays are empty shells: every control is created at runtime by the onLoad functions
// (see fnc_menuOnLoad.sqf / fnc_gameOnLoad.sqf), which keeps the layout in one readable place.

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
