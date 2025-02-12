#include "macro.hpp"

class CfgPatches
{
    class BRG_SabaccCore
    {
        name = "[BRG] Sabacc - Core";
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
        class BonusInteraction
        {
            file = "\BRG_SabaccCore\functions\BonusInteraction";
            F(getPlayerBonus);
            F(setPlayerBonus);
            F(usePlayerBonus);
        };
        class CardInteraction
        {
            file = "\BRG_SabaccCore\functions\CardInteraction";
            F(dropPlayerCard);
            F(getCards);
            F(getLastDropedCard);
            F(getNewCard);
            F(getPlayerCard);
            F(setPlayerCard);
        };
        class ChipsInteraction
        {
            file = "\BRG_SabaccCore\functions\ChipsInteraction";
            F(addChips);
            F(getChips);
            F(setChips);
            F(subChips);
        };
        class GameFlow
        {
            file = "\BRG_SabaccCore\functions\GameFlow";
            F(endGame);      // Todo
            F(endRound);     // Todo
            F(endTurn);      // Todo
            F(getGameOrder); // Todo
            F(getWhosTurn);  // Todo
            F(init);         // Todo
            F(joinGame);     // Todo
            F(leaveGame);    // Todo
            F(startGame);    // Todo
            F(startRound);   // Todo
            F(startTurn);    // Todo
        };
        class GameInteraction
        {
            file = "\BRG_SabaccCore\functions\GameInteraction";
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
        class PlayerInteraction
        {
            file = "\BRG_SabaccCore\functions\PlayerInteraction";
            F(checkExistPlayer);
            F(getAllplayers);
            F(getGameNumberFromUnit);
            F(getPlayerInfo);
            F(getPlayerNumberFromUnit);
            F(setPlayerInfo);
        };
        class UIInteraction
        {
            file = "\BRG_SabaccCore\functions\UIInteraction";
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
#include "Dialogs\SabaccGamesMenu.hpp"