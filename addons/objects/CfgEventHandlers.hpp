// The Sabacc table object registers itself as a physical table (server). Delayed so that a
// "Sabacc table" module synchronized with it can register it first, with its own settings.
class Extended_InitPost_EventHandlers {
    class GVAR(table) {
        class ADDON {
            serverInit = QUOTE([ARR_3({if (!isNull (_this select 0)) then {[ARR_1(_this select 0)] call EFUNC(game,addWorldTable)}},_this,2)] call CBA_fnc_waitAndExecute);
        };
    };
};
