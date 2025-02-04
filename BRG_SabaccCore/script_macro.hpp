/* Color */
#define ColorBlack {0, 0, 0, 1}
#define ColorBlack25 {0, 0, 0, 0.25}
#define ColorBlack50 {0, 0, 0, 0.5}
#define ColorBlack75 {0, 0, 0, 0.75}
#define ColorDarkYellow {0.4, 0.4, 0, 1}
#define ColorGreen50 {0, 0.2, 0, 0.5}
#define ColorLightBlue {0, 1, 1, 1}
#define ColorLightBlue50 {0, 0.8, 0.8, 0.5}
#define ColorTransparent {0, 0, 0, 0}
#define ColorWhite {1, 1, 1, 1}

/* Dialog Config */
#define DefaultFont "PuristaMedium"
#define SizeEx sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)
#define SoundClick                                                            \
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};   \
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};   \
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0}; \
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0}

/* Sabacc Game Interface*/
#define SabaccInterface 22

/* Player Card Button*/
#define Card1Button 220001
#define Card2Button 220002

/* Table Card Button*/
#define TableCard1Button 220101
#define TableCard2Button 220102
#define DropedCard1Button 220103
#define DropedCard2Button 220104

/* Player Bonus Button*/
#define Bonus1Button 220201
#define Bonus2Button 220202

/* Players Button*/
#define Player1Button 220301
#define Player2Button 220302
#define Player3Button 220303
#define Player4Button 220304

/* Timer*/
#define Timer 220401
#define TimerBar 220402
#define TimerBackground 220403

/* MimiTable Card*/
#define MimiTableCard1 220501
#define MimiTableCard2 220502
#define MiniDropedCard1 220503
#define MiniDropedCard2 220504
#define MiniTableBackground 220505

/* Table Card*/
#define TableCard1 220601
#define TableCard2 220602
#define DropedCard1 220603
#define DropedCard2 220604
#define TableBackground 220605

/* Player Chips*/
#define PlayerChipsReserveCounter 220701
#define PlayerChipsInGameCounter 220702
#define PlayerChipsReserve 220703
#define PlayerChipsInGame 220704
#define PlayerChipsReserveBackground 220705
#define PlayerChipsInGameBackground 220706

/* Player Card*/
#define PlayerCard1 220801
#define PlayerCard2 220802
#define CardBackground 220803

/* Player Bonus*/
#define PlayerBonus1 220901
#define PlayerBonus1Name 220902
#define PlayerBonus2 220903
#define PlayerBonus2Name 220904
#define PlayerBonusBackground 220905

/* Dice */
#define Dice1 221001
#define Dice2 221002
#define DiceBackground 221003

/* Player 1 InfoPanel*/
#define PlayInfoPlayer1 221101
#define NamePlayer1 221102
#define ChipsInRoundPlayer1 221103
#define ChipsInRoundCounterPlayer1 221104
#define ChipsReservePlayer1 221105
#define ChipsReserveCounterPlayer1 221106
#define Bonus1Player1 221107
#define Bonus2Player1 221108
#define Card1Player1 221109
#define Card2Player1 221110
#define Player1Background 221111
#define Player1ChipsBackground 221112

/* Player 2 InfoPanel*/
#define PlayInfoPlayer2 221201
#define NamePlayer2 221202
#define ChipsInRoundPlayer2 221203
#define ChipsInRoundCounterPlayer2 221204
#define ChipsReservePlayer2 221205
#define ChipsReserveCounterPlayer2 221206
#define Bonus1Player2 221207
#define Bonus2Player2 221208
#define Card1Player2 221209
#define Card2Player2 221210
#define Player2Background 221211
#define Player2ChipsBackground 221212

/* Player 3 InfoPanel*/
#define PlayInfoPlayer3 221301
#define NamePlayer3 221302
#define ChipsInRoundPlayer3 221303
#define ChipsInRoundCounterPlayer3 221304
#define ChipsReservePlayer3 221305
#define ChipsReserveCounterPlayer3 221306
#define Bonus1Player3 221307
#define Bonus2Player3 221308
#define Card1Player3 221309
#define Card2Player3 221310
#define Player3Background 221311
#define Player3ChipsBackground 221312

/* Player 4 InfoPanel*/
#define PlayInfoPlayer4 221401
#define NamePlayer4 221402
#define ChipsInRoundPlayer4 221403
#define ChipsInRoundCounterPlayer4 221404
#define ChipsReservePlayer4 221405
#define ChipsReserveCounterPlayer4 221406
#define Bonus1Player4 221407
#define Bonus2Player4 221408
#define Card1Player4 221409
#define Card2Player4 221410
#define Player4Background 221411
#define Player4ChipsBackground 221412

/**
 * BRG_fnc_createNewGame - Create new game
 * @param _unit <object> - Player unit
 * @return <int> - Game number
 */
#define createNewGame [_unit] call BRG_fnc_createNewGame

/**
 * BRG_fnc_getGameCardDeck - Get game card deck
 * @param _GameNumber <int> - Game number
 * @return <array> - Card deck array
 */
#define getGameCardDeck(_GameNumber) [_GameNumber] call BRG_fnc_getGameCardDeck

/**
 * BRG_fnc_getGameInfo - Get game information
 * @param _GameNumber <int> - Game number
 * @return <array> - Game information array
 */
#define getGameInfo(_GameNumber) [_GameNumber] call BRG_fnc_getGameInfo

/**
 * BRG_fnc_getGameOwner - Get game owner
 * @param _GameNumber <int> - Game number
 * @return <object> - Game owner unit
 */
#define getGameOwner(_GameNumber) [_GameNumber] call BRG_fnc_getGameOwner

/**
 * BRG_fnc_getGameParms - Get game parameters
 * @param _GameNumber <int> - Game number
 * @return <array> - Game parameters array
 */
#define getGameParams(_GameNumber) [_GameNumber] call BRG_fnc_getGameParms

/**
 * BRG_fnc_getGamePlayersMax - Get game maximum players
 * @param _GameNumber <int> - Game number
 * @return <int> - Game maximum players
 */
#define getGamePlayersMax(_GameNumber) [_GameNumber] call BRG_fnc_getGamePlayersMax

/**
 * BRG_fnc_getGameStatus - Get game status
 * @param _GameNumber <int> - Game number
 * @return <int> - Game status
 */
#define getGameStatus(_GameNumber) [_GameNumber] call BRG_fnc_getGameStatus

/**
 * BRG_fnc_setGamePlayersMax - Set game maximum players
 * @param _GameNumber <int> - Game number
 * @param _GamePlayersMax <int> - Game maximum players
 */
#define setGamePlayersMax(_GameNumber, _GamePlayersMax) [ _GameNumber, _GamePlayersMax ] call BRG_fnc_setGamePlayersMax

/**
 * BRG_fnc_setGameStatus - Set game status
 * @param _GameNumber <int> - Game number
 * @param _GameStatus <int> - Game status
 */
#define setGameStatus(_GameNumber, _GameStatus) [ _GameNumber, _GameStatus ] call BRG_fnc_setGameStatus

/**
 * BRG_fnc_checkExistPlayer - Set player information
 * @param _GameNumber <int> - Game number
 * @param _unit <object> - Player unit
 */
#define checkExistPlayer(_GameNumber, _unit) [ _GameNumber, _unit ] call BRG_fnc_checkExistPlayer

/**
 * BRG_fnc_deletePlayerInfo - Delete player information
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 */
#define deletePlayerInfo(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_setPlayerInfo

/**
 * BRG_fnc_getAllplayers - Get all players
 * @param _GameNumber <int> - Game number
 * @return <array> - All players array
 */
#define getAllplayers(_GameNumber) [_GameNumber] call BRG_fnc_getAllplayers

/**
 * BRG_fnc_getGameNumberFromUnit - Get game number from unit
 * @param _unit <object> - Player unit
 * @return <int> - Game number
 */
#define getGameNumberFromUnit(_unit) [_unit] call BRG_fnc_getGameNumberFromUnit

/**
 * BRG_fnc_getPlayerInfo - Get player information
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @return <array> - Player information array
 */
#define getPlayerInfo(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_getPlayerInfo

/**
 * BRG_fnc_getPlayerNumberFromUnit - Get player number from unit
 * @param _GameNumber <int> - Game number
 * @param _unit <object> - Player unit
 * @return <int> - Player number
 */
#define getPlayerNumberFromUnit(_GameNumber, _unit) [ _GameNumber, _unit ] call BRG_fnc_getPlayerNumberFromUnit

/**
 * BRG_fnc_setPlayerInfo - Set player information
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _playerInfo <array> - Player information array
 */
#define setPlayerInfo(_GameNumber, _playerNumber, _playerInfo) [ _GameNumber, _playerNumber, _playerInfo ] call BRG_fnc_setPlayerInfo

/**
 * BRG_fnc_joinGame - Join game
 * @param _GameNumber <int> - Game number
 * @param _unit <object> - Player unit
 */
#define joinGame(_GameNumber, _unit) [ _GameNumber, _unit ] call BRG_fnc_joinGame

/**
 * BRG_fnc_leaveGame - Leave game
 * @param _GameNumber <int> - Game number
 * @param _unit <object> - Player unit
 */
#define leaveGame(_GameNumber, _unit) [ _GameNumber, _unit ] call BRG_fnc_leaveGame

/**
 * BRG_fnc_endGame - End game
 * @param _GameNumber <int> - Game number
 * @return <int> - Game status
 */
#define endGame(_GameNumber) [_GameNumber] call BRG_fnc_endGame

/**
 * BRG_fnc_endRound - End game round
 * @param _GameNumber <int> - Game number
 * @return <int> - Game status
 */
#define endRound(_GameNumber) [_GameNumber] call BRG_fnc_endRound

/**
 * BRG_fnc_endTurn - End player turn
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @return <int> - Game status
 */
#define endTurn(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_endTurn

/**
 * BRG_fnc_getGameOrder - Get game order
 * @param _GameNumber <int> - Game number
 * @return <array> - Game order array
 */
#define getGameOrder(_GameNumber) [_GameNumber] call BRG_fnc_getGameOrder

/**
 * BRG_fnc_getWhosNextTurn - Get next player turn
 * @param _GameNumber <int> - Game number
 * @return <int> - Player number
 */
#define getWhosNextTurn(_GameNumber) [_GameNumber] call BRG_fnc_getWhosNextTurn

/**
 * BRG_fnc_getWhosTurn - Get player turn
 * @param _GameNumber <int> - Game number
 * @return <int> - Player number
 */
#define getWhosTurn(_GameNumber) [_GameNumber] call BRG_fnc_getWhosTurn

/**
 * BRG_fnc_setWhosTurn - Set player turn
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 */
#define setWhosTurn(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_setWhosTurn

/**
 * BRG_fnc_startGame - Start game
 * @param _GameNumber <int> - Game number
 * @return <int> - Game status
 */
#define startGame(_GameNumber) [_GameNumber] call BRG_fnc_startGame

/**
 * BRG_fnc_startRound - Start game round
 * @param _GameNumber <int> - Game number
 * @return <int> - Game status
 */
#define startRound(_GameNumber) [_GameNumber] call BRG_fnc_startRound

/**
 * BRG_fnc_startTurn - Start player turn
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @return <int> - Game status
 */
#define startTurn(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_startTurn

/**
 * BRG_fnc_dropPlayerCard - Drop player card
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _cardType <int> - Card type
 */
#define dropPlayerCard(_GameNumber, _playerNumber, _cardType) [ _GameNumber, _playerNumber, _cardType, _CardID ] call BRG_fnc_dropPlayerCard

/**
 * BRG_fnc_getCards - Get table card
 * @param _GameNumber <int> - Game number
 * @param _cardType <int> - Card type
 * @return <array> - Card
 */
#define getCards(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getCards

/**
 * BRG_fnc_getLastDropedCard - Get last droped card
 * @param _GameNumber <int> - Game number
 * @param _cardType <int> - Card type
 * @return <int> - Card ID
 */
#define getLastDropedCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getLastDropedCard

/**
 * BRG_fnc_getNewCard - Get new card
 * @param _GameNumber <int> - Game number
 * @param _cardType <int> - Card type
 * @return <int> - Card ID
 */
#define getNewCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getNewCard

/**
 * BRG_fnc_getPlayerCard - Get player card
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _cardType <int> - Card type
 * @return <int> - Card ID
 */
#define getPlayerCard(_GameNumber, _playerNumber, _cardType) [ _GameNumber, _playerNumber, _cardType ] call BRG_fnc_getPlayerCard

/**
 * BRG_fnc_setPlayerCard - Set player card
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _cardType <int> - Card type
 * @param _CardID <int> - Card ID
 */
#define setPlayerCard(_GameNumber, _playerNumber, _cardType, _CardID) [ _GameNumber, _playerNumber, _cardType, _CardID ] call BRG_fnc_setPlayerCard

/**
 * BRG_fnc_checkIfUseBonus - Check if use bonus
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _bonusNumber <int> - Bonus number
 * @return <bool> - Use bonus
 */
#define checkIfUseBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusNumber ] call BRG_fnc_checkIfUseBonus

/**
 * BRG_fnc_getPlayerBonus - Get player bonus
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _bonusNumber <int> - Bonus number
 * @return <int> - Bonus type
 */
#define getPlayerBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusType ] call BRG_fnc_getPlayerBonus

/**
 * BRG_fnc_setPlayerBonus - Set player bonus
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _bonusNumber <int> - Bonus number
 * @param _bonusType <int> - Bonus type
 */
#define setPlayerBonus(_GameNumber, _playerNumber, _bonusNumber, _bonusType) [ _GameNumber, _playerNumber, _bonusNumber, _bonusType ] call BRG_fnc_setPlayerBonus

/**
 * BRG_fnc_usePlayerBonus - Use player bonus
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _bonusNumber <int> - Bonus number
 */
#define usePlayerBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusNumber ] call BRG_fnc_usePlayerBonus

/**
 * BRG_fnc_addChips - Add chips number
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _chips <int> - Chips number
 * @param _chipsType <int> - Chips type
 * @return <array> - Chips numbers array
 */
#define addChips(_GameNumber, _playerNumber, _chips, _chipsType) [ _GameNumber, _playerNumber, _chips, _chipsType ] call BRG_fnc_addChips

/**
 * BRG_fnc_subChips - Sub chips number
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _chips <int> - Chips number
 * @param _chipsType <int> - Chips type
 * @return <array> - Chips numbers array
 */
#define subChips(_GameNumber, _playerNumber, _chips, _chipsType) [ _GameNumber, _playerNumber, _chips, _chipsType ] call BRG_fnc_subChips

/**
 * BRG_fnc_getChips - Get chips number
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _chipsType <int> - Chips type
 * @return <array> - Chips numbers array
 */
#define getChips(_GameNumber, _playerNumber, _chipsType) [ _GameNumber, _playerNumber, _chipsType ] call BRG_fnc_getChips

/**
 * BRG_fnc_setChips - Set chips number
 * @param _GameNumber <int> - Game number
 * @param _playerNumber <int> - Player number
 * @param _chips <int> - Chips number
 * @param _chipsType <int> - Chips type
 * @return <array> - Chips numbers array
 */
#define setChips(_GameNumber, _playerNumber, _chips, _chipsType) [ _GameNumber, _playerNumber, _chips, _chipsType ] call BRG_fnc_setChips

/**
 * BRG_fnc_enableUI - Enable or disable UI
 * @param _IDC <int> - IDC number
 * @param _enable <bool> - Enable or disable
 * @return <bool> - Enable or disable
 */
#define enableUI(_IDC, _enable) [ _IDC, _enable ] call BRG_fnc_enableUI

/**
 * BRG_fnc_getUIValue - Get UI value
 * @param _IDC <int> - IDC number
 * @return <any> - UI value
 */
#define getUIValue(_IDC) [_IDC] call BRG_fnc_getUIValue

/**
 * BRG_fnc_setUIValue - Set UI value
 * @param _IDC <int> - IDC number
 * @param _value <any> - UI value
 */
#define setUIValue(_IDC, _value) [ _IDC, _value ] call BRG_fnc_setUIValue

/**
 * BRG_fnc_setUIVisible - Set UI visible or invisible
 * @param _IDC <int> - IDC number
 * @param _visible <bool> - Visible or invisible
 */
#define setUIVisible(_IDC, _visible) [ _IDC, _visible ] call BRG_fnc_setUIVisible

/**
 * Game information array (can be have 1 - infinite games)
 * @param _GameNumber <int> - Game number
 * @param _GameStatus <int> - Game status
 * @param _CardDeck <array> - Card deck array
 * @param _GameParms <array> - Game parameters array :
 *  @param _GameOwner <object> - Game owner unit
 *  @param _GamePlayersMax <int> - Game maximum players
 * @param _PlayerInfo <array> - Player information array (can be have 1 to 4 players) :
 *  @param _Unit <object> - Player unit
 *  @param _Name <string> - Player name
 *  @param _Bonus <array> - Player bonus array
 *  @param _Chips <array> - Player chips array
 *
 * @example
 * GameInfo = [[ 0, 0, DefaultCardsDeck, [ player1, 4 ], [[player1, "Player 1", [0, 0], [0, 0]], [player2, "Player 2", 0, [0, 0], [0, 0]], [player3, "Player 3", 0, [0, 0], [0, 0]], [player4, "Player 4", 0, [0, 0], [0, 0]]] ]]
 */
#define GameInfo(_GameNumber, _GameStatus, _CardDeck, _GameOwner, _GamePlayersMax, _Unit, _Name, _Bonus, _Chips) \
    [[_GameNumber, _GameStatus, _CardDeck, [_GameOwner, _GamePlayersMax], [[_Unit, _Name, _Bonus, _Chips]]]]

/**
 * Default cards deck array
 * @param _typeCart1 <array> - Card type Sand
 *  @param _CardNumber <string> - Card number
 *  @param _CardAssigneTo <int> - Card assigne to ...
 *  @param _CardID <int> - Card ID
 * @param _typeCart2 <array> - Card type Blood
 *  @param _CardNumber <string> - Card number
 *  @param _CardAssigneTo <int> - Card assigne to ...
 *  @param _CardID <int> - Card ID
 */
#define DefaultCardsDeck [                              \
    [                                                   \
        [ "1", 0, 0 ], [ "1", 0, 1 ], [ "1", 0, 2 ],    \
        [ "2", 0, 3 ], [ "2", 0, 4 ], [ "2", 0, 5 ],    \
        [ "3", 0, 6 ], [ "3", 0, 7 ], [ "3", 0, 8 ],    \
        [ "4", 0, 9 ], [ "4", 0, 10 ], [ "4", 0, 11 ],  \
        [ "5", 0, 12 ], [ "5", 0, 13 ], [ "5", 0, 14 ], \
        [ "6", 0, 15 ], [ "6", 0, 16 ], [ "6", 0, 17 ], \
        [ "I", 0, 18 ], [ "I", 0, 19 ], [ "I", 0, 20 ], \
        [ "S", 0, 21 ], [ "S", 0, 22 ]                  \
    ],                                                  \
    [                                                   \
        [ "1", 0, 30 ], [ "1", 0, 31 ], [ "1", 0, 32 ], \
        [ "2", 0, 33 ], [ "2", 0, 34 ], [ "2", 0, 35 ], \
        [ "3", 0, 36 ], [ "3", 0, 37 ], [ "3", 0, 38 ], \
        [ "4", 0, 39 ], [ "4", 0, 40 ], [ "4", 0, 41 ], \
        [ "5", 0, 42 ], [ "5", 0, 43 ], [ "5", 0, 44 ], \
        [ "6", 0, 45 ], [ "6", 0, 46 ], [ "6", 0, 47 ], \
        [ "I", 0, 48 ], [ "I", 0, 49 ], [ "I", 0, 50 ], \
        [ "S", 0, 51 ], [ "S", 0, 52 ]                  \
    ]                                                   \
]