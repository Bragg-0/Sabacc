#include "macro.hpp"

class CfgPatches
{
    class BRG_Sabacc
    {
        name = "[BRG] Sabacc";
        author = "Bragg";
        requiredAddons[] = {};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions
{
    class BRG_Sabacc_Functions
    {
        tag = "BRG";
        class Functions_BonusInteraction
        {
            F(getPlayerBonus);
            F(setPlayerBonus);
            F(usePlayerBonus);
            F(checkIfUseBonus);
        };
        class Functions_CardInteraction
        {
            F(dropPlayerCard);
            F(getLastDropedCard);
            F(getNewCard);
            F(getPlayerCard);
            F(getRandomCard);
            F(getTableCard);
            F(setPlayerCard);
            F(setTableCard);
        };
        class Functions_ChipsInteraction
        {
            F(addChips);
            F(getChips);
            F(setChips);
        };
        class Functions_GameFlow
        {
            F(endGame);
            F(endRound);
            F(endTurn);
            F(getGameOrder);
            F(getWhosNextTurn);
            F(getWhosTurn);
            F(joinGame);
            F(setWhosTurn);
            F(startGame);
            F(startRound);
            F(startTurn);
        };
        class Functions_GameInteraction
        {
            F(createNewGame);
            F(getGameCardDeck);
            F(getGameInfo);
            F(getGameOwner);
            F(getGameParams);
            F(getGamePlayersMax);
            F(getGameStatus);
            F(setGameCardDeck);
            F(setGameOwner);
            F(setGameParams);
            F(setGamePlayersMax);
            F(setGameStatus);
        };
        class Functions_PlayerInteraction
        {
            F(checkExistPlayer);
            F(getAllplayers);
            F(getGameNumberFromUnit);
            F(getPlayerInfo);
            F(getPlayerNumberFromUnit);
            F(setPlayerInfo);
        };
        class Functions_UIInteraction
        {
            F(enableUI);
            F(getUIValue);
            F(setUIValue);
            F(setUIVisible);
        };
    };
};

class CfgRemoteExec
{
    class Functions
    {
        mode = 2;
        jip = 1;

        /* Client only functions */

        /* Server only functions */

        /* Functions for everyone */
    };
};

#include "Dialogs\SabaccGameInterface.hpp"