// ---------------------------------------------------------------------------
// Cards
// A card is encoded as a single number: SUIT * 10 + VALUE
//   SUIT  : 0 = Amber ("sand" in the code), 1 = Ember ("blood" in the code)
//   VALUE : 1..6, 7 = Mirage, 8 = Sylop
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

// Number of copies of each card in one suit (3 x 1..6, 3 Mirages, 2 Sylops = 23 cards)
#define COPIES_NUMBER 3
#define COPIES_IMPOSTOR 3
#define COPIES_SYLOP 2

// ---------------------------------------------------------------------------
// Game flow
// ---------------------------------------------------------------------------
#define TURNS_PER_ROUND 3

// Distance (m) to sit at / watch a physical table
#define WORLD_TABLE_RANGE 5

// Seconds added to a human player's turn while the client shows its banner
// ("Your turn!", and "Round N" before it at the start of a round): the countdown starts after it
#define BANNER_TIME 2.2
#define BANNER_TIME_ROUND 3.5
// How long a banner blocks clicks on the client (appear 0.2 s + hold 1.4 s + part of the fade)
#define BANNER_BLOCK 1.9
#define MIN_PLAYERS 2
#define MAX_PLAYERS 6
#define MAX_PLAYERS_WIDE 4 // up to this many players, the game screen uses 3 wide opponent panels
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

// Layout grid of 40 x 25 square cells, centered, filling ~94% of the screen height
// (or width on narrow screens), whatever the Arma interface size setting.
// A cell is UI_H tall and UI_W wide (x units are 4/3 of y units).
#define UI_SCALE 0.94
#define UI_H ((safeZoneH * UI_SCALE / 25) min (safeZoneW * UI_SCALE / 30))
#define UI_W (UI_H * 0.75)
#define UI_X (safeZoneX + (safeZoneW - 40 * UI_W) / 2)
#define UI_Y (safeZoneY + (safeZoneH - 25 * UI_H) / 2)

#define GX(n) (UI_X + (n) * UI_W)
#define GY(n) (UI_Y + (n) * UI_H)
#define GW(n) ((n) * UI_W)
#define GH(n) ((n) * UI_H)
#define GRID(x,y,w,h) [GX(x), GY(y), GW(w), GH(h)]

// Holographic palette
#define COLOR_PANEL [0.01, 0.03, 0.05, 0.94]       // screen background
#define COLOR_PANEL_LIGHT [0.02, 0.08, 0.12, 0.88] // panel fill
#define COLOR_HEADER [0.01, 0.06, 0.09, 0.98]
#define COLOR_STRIP [0.01, 0.04, 0.06, 0.95]
#define COLOR_ACTIVE [0.42, 0.27, 0.04, 0.6]
#define COLOR_TARGET [0.08, 0.36, 0.5, 0.6]
#define COLOR_OUT [0.24, 0.03, 0.03, 0.65]
#define COLOR_WIN [0.06, 0.36, 0.16, 0.65]
#define COLOR_HOLO [0.37, 0.85, 1, 1]
#define COLOR_HOLO_FAINT [0.37, 0.85, 1, 0.25]
#define COLOR_AMBER [1, 0.7, 0.27, 1]
#define COLOR_DANGER [1, 0.35, 0.3, 1]
#define COLOR_SAND [0.93, 0.78, 0.45, 1]
#define COLOR_BLOOD [0.85, 0.2, 0.2, 1]
#define COLOR_WHITE [1, 1, 1, 1]
#define COLOR_DIM [1, 1, 1, 0.35]

// Same palette for structured text
#define HTML_HOLO "#5fd8ff"
#define HTML_DIM "#3c8aa8"
#define HTML_AMBER "#ffb444"
#define HTML_TEXT "#d8f4ff"
#define HTML_MUTED "#86a8b8"
#define HTML_SAND "#e8c06a"
#define HTML_BLOOD "#ff6a5a"
#define HTML_GOOD "#6dff9a"
#define HTML_BAD "#ff6b6b"
