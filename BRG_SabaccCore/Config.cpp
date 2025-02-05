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
        };
        class Functions_CardInteraction
        {
            F(dropPlayerCard);
            F(getCards);
            F(getLastDropedCard);
            F(getNewCard);
            F(getPlayerCard);
            F(setPlayerCard);
        };
        class Functions_ChipsInteraction
        {
            F(addChips);
            F(getChips);
            F(setChips);
            F(subChips);
        };
        class Functions_GameFlow
        {
            F(endGame);         // Todo
            F(endRound);        // Todo
            F(endTurn);         // Todo
            F(getGameOrder);    // Todo
            F(getWhosNextTurn); // Todo
            F(getWhosTurn);     // Todo
            F(init);            // Todo
            F(joinGame);        // Todo
            F(leaveGame);       // Todo
            F(startGame);       // Todo
            F(startRound);      // Todo
            F(startTurn);       // Todo
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