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

/* Player Card*/
#define PlayerCard1 220801
#define PlayerCard2 220802

/* Player Bonus*/
#define PlayerBonus1 220901
#define PlayerBonus1Name 220902
#define PlayerBonus2 220903
#define PlayerBonus2Name 220904

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

/* Player & Game interaction*/
/**
 * @param GameInfo <array> - Game information array
 *  @param GameNumber <int> - Game number
 *  @param GameStatus <int> - Game status
 *  @param CardDeck <array> - Card deck array
 *  @param GameParms <array> - Game parameters array
 *   @param GameOwner <object> - Game owner unit
 *   @param GamePlayersMax <int> - Game maximum players
 * @param PlayerInfo <array> - Player information array (can be have 0 - 4 players)
 *  @param Unit <object> - Player unit
 *  @param Name <string> - Player name
 *  @param Bonus1 <int> - Player bonus 1 number
 *  @param Bonus2 <int> - Player bonus 2 number
 */

#define createNewGame [] call BRG_fnc_createNewGame
#define getGameCardDeck(_GameNumber) [_GameNumber] call BRG_fnc_getGameCardDeck
#define getGameInfo(_GameNumber) [_GameNumber] call BRG_fnc_getGameInfo
#define getGameOwner(_GameNumber) [_GameNumber] call BRG_fnc_getGameOwner
#define getGameParams(_GameNumber) [_GameNumber] call BRG_fnc_getGameParms
#define getGamePlayersMax(_GameNumber) [_GameNumber] call BRG_fnc_getGamePlayersMax
#define getGameStatus(_GameNumber) [_GameNumber] call BRG_fnc_getGameStatus
#define setGameCardDeck(_GameNumber, _CardDeck) [ _GameNumber, _CardDeck ] call BRG_fnc_setGameCardDeck
#define setGameOwner(_GameNumber, _GameOwner) [ _GameNumber, _GameOwner ] call BRG_fnc_setGameOwner
#define setGameParams(_GameNumber, _GameParms) [ _GameNumber, _GameParms ] call BRG_fnc_setGameParms
#define setGamePlayersMax(_GameNumber, _GamePlayersMax) [ _GameNumber, _GamePlayersMax ] call BRG_fnc_setGamePlayersMax
#define setGameStatus(_GameNumber, _GameStatus) [ _GameNumber, _GameStatus ] call BRG_fnc_setGameStatus

#define checkExistPlayer(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_checkExistPlayer
#define deletePlayerInfo(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_setPlayerInfo
#define getAllplayers(_GameNumber) [_GameNumber] call BRG_fnc_getAllplayers
#define getGameNumberFromUnit(_unit) [_unit] call BRG_fnc_getGameNumberFromUnit
#define getPlayerInfo(_GameNumber, _playerNumber) [ _GameNumber, _playerNumber ] call BRG_fnc_getPlayerInfo
#define getPlayerNumberFromUnit(_GameNumber, _unit) [ _GameNumber, _unit ] call BRG_fnc_getPlayerNumberFromUnit
#define setPlayerInfo(_GameNumber, _playerNumber, _playerInfo) [ _GameNumber, _playerNumber, _playerInfo ] call BRG_fnc_setPlayerInfo

/* Card interaction*/
#define DefaultCardsDeck [ [ [ "1", 0 ], [ "1", 0 ], [ "1", 0 ], [ "2", 0 ], [ "2", 0 ], [ "2", 0 ], [ "3", 0 ], [ "3", 0 ], [ "3", 0 ], [ "4", 0 ], [ "4", 0 ], [ "4", 0 ], [ "5", 0 ], [ "5", 0 ], [ "5", 0 ], [ "6", 0 ], [ "6", 0 ], [ "6", 0 ], [ "I", 0 ], [ "I", 0 ], [ "I", 0 ], [ "S", 0 ], [ "S", 0 ] ], [ [ "1", 0 ], [ "1", 0 ], [ "1", 0 ], [ "2", 0 ], [ "2", 0 ], [ "2", 0 ], [ "3", 0 ], [ "3", 0 ], [ "3", 0 ], [ "4", 0 ], [ "4", 0 ], [ "4", 0 ], [ "5", 0 ], [ "5", 0 ], [ "5", 0 ], [ "6", 0 ], [ "6", 0 ], [ "6", 0 ], [ "I", 0 ], [ "I", 0 ], [ "I", 0 ], [ "S", 0 ], [ "S", 0 ] ] ]

#define dropPlayerCard(_GameNumber, _playerNumber, _cardType) [ _GameNumber, _playerNumber, _cardType ] call BRG_fnc_dropPlayerCard
#define getLastDropedCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getLastDropedCard
#define getNewCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getNewCard
#define getPlayerCard(_GameNumber, _playerNumber, _cardType) [ _GameNumber, _playerNumber, _cardType ] call BRG_fnc_getPlayerCard
#define getRandomCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getRandomCard
#define getTableCard(_GameNumber, _cardType) [ _GameNumber, _cardType ] call BRG_fnc_getTableCard
#define setPlayerCard(_GameNumber, _playerNumber, _cardNumber, _cardType) [ _GameNumber, _playerNumber, _cardNumber, _cardType ] call BRG_fnc_setPlayerCard
#define setTableCard(_GameNumber, _cardNumber, _cardType) [ _GameNumber, _cardNumber, _cardType ] call BRG_fnc_setTableCard

/* Bonus interaction */
#define checkIfUseBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusNumber ] call BRG_fnc_checkIfUseBonus
#define getPlayerBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusType ] call BRG_fnc_getPlayerBonus
#define setPlayerBonus(_GameNumber, _playerNumber, _bonusNumber, _bonusType) [ _GameNumber, _playerNumber, _bonusNumber, _bonusType ] call BRG_fnc_setPlayerBonus
#define usePlayerBonus(_GameNumber, _playerNumber, _bonusNumber) [ _GameNumber, _playerNumber, _bonusNumber ] call BRG_fnc_usePlayerBonus

/* Chips interaction */
#define addChips(_GameNumber, _playerNumber, _chips, _chipsType) [ _GameNumber, _playerNumber, _chips, _chipsType ] call BRG_fnc_addChips
#define getChips(_GameNumber, _playerNumber, _chipsType) [ _GameNumber, _playerNumber, _chipsType ] call BRG_fnc_getChips
#define setChips(_GameNumber, _playerNumber, _chips, _chipsType) [ _GameNumber, _playerNumber, _chips, _chipsType ] call BRG_fnc_setChips