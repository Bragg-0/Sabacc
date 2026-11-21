// ---------------------------------------------------------------------------
// Cards
// A card is encoded as a single number: SUIT * 10 + VALUE
//   SUIT  : 0 = Sand, 1 = Blood
//   VALUE : 1..6, 7 = Impostor, 8 = Sylop
// ---------------------------------------------------------------------------
#define SUIT_SAND 0
#define SUIT_BLOOD 1

#define VALUE_IMPOSTOR 7
#define VALUE_SYLOP 8

#define CARD(suit,value) ((suit) * 10 + (value))
#define CARD_SUIT(card) (floor ((card) / 10))
#define CARD_VALUE(card) ((card) mod 10)

#define CARD_NONE -1
#define CARD_HIDDEN -2

// Number of copies of each card in one suit (3 x 1..6, 3 Impostors, 2 Sylops = 23 cards)
#define COPIES_NUMBER 3
#define COPIES_IMPOSTOR 3
#define COPIES_SYLOP 2

// ---------------------------------------------------------------------------
// Game flow
// ---------------------------------------------------------------------------
#define TURNS_PER_ROUND 3
#define MIN_PLAYERS 2
#define MAX_PLAYERS 4
#define SHIFT_COUNT 16
#define LOG_SIZE 10

// Draw sources
#define SOURCE_SAND_DECK 0
#define SOURCE_BLOOD_DECK 1
#define SOURCE_SAND_DISCARD 2
#define SOURCE_BLOOD_DISCARD 3

// Table status / phase
#define STATUS_LOBBY "lobby"
#define STATUS_PLAYING "playing"
#define STATUS_OVER "over"

#define PHASE_TURN "turn"
#define PHASE_CHOICE "choice"
#define PHASE_RESULTS "results"

// ---------------------------------------------------------------------------
// Assets
// ---------------------------------------------------------------------------
#define TEXTURE_BACK QPATHTOF(data\cards\back.paa)
#define TEXTURE_CHIPS QPATHTOF(data\ui\chips.paa)
#define TEXTURE_TERMINAL "\x\brg\addons\items\data\ui\terminal_ca.paa"

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------
#define EVENT_REQUEST QGVAR(request)
#define EVENT_STATE QGVAR(state)
#define EVENT_NOTIFY QGVAR(notify)

#define REQUEST(type,args) [EVENT_REQUEST, [player, type, args]] call CBA_fnc_serverEvent

// ---------------------------------------------------------------------------
// UI
// ---------------------------------------------------------------------------
#define IDD_MENU 85100
#define IDD_GAME 85200

#define GX(n) (GUI_GRID_CENTER_X + (n) * GUI_GRID_CENTER_W)
#define GY(n) (GUI_GRID_CENTER_Y + (n) * GUI_GRID_CENTER_H)
#define GW(n) ((n) * GUI_GRID_CENTER_W)
#define GH(n) ((n) * GUI_GRID_CENTER_H)
#define GRID(x,y,w,h) [GX(x), GY(y), GW(w), GH(h)]

#define COLOR_PANEL [0.05, 0.06, 0.08, 0.92]
#define COLOR_PANEL_LIGHT [0.12, 0.14, 0.18, 0.9]
#define COLOR_HEADER [0.55, 0.38, 0.12, 0.95]
#define COLOR_ACTIVE [0.85, 0.6, 0.15, 0.45]
#define COLOR_TARGET [0.2, 0.6, 0.9, 0.45]
#define COLOR_OUT [0.3, 0.05, 0.05, 0.6]
#define COLOR_SAND [0.93, 0.78, 0.45, 1]
#define COLOR_BLOOD [0.85, 0.2, 0.2, 1]
#define COLOR_WHITE [1, 1, 1, 1]
#define COLOR_DIM [1, 1, 1, 0.35]
