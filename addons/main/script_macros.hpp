// Debug switches: uncomment locally inside a component's script_component.hpp, never commit them enabled.
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#define PREP_RECOMPILE_START ; /* disabled */
#define PREP_RECOMPILE_END ; /* disabled */

// ---------------------------------------------------------------------------
// Assets
// ---------------------------------------------------------------------------
#define TEXTURE_BACK QPATHTOEF(game,data\ui\cards\back.paa)
#define TEXTURE_TERMINAL QPATHTOEF(objects,data\ui\terminal_ca.paa)
#define TEXTURE_CHIPS QPATHTOEF(game,data\ui\chips_ca.paa)
#define TEXTURE_POT QPATHTOEF(game,data\ui\pot_ca.paa)
