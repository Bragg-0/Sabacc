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
        class Cards
        {
            file = "BRG_SabaccCore\Functions\Cards";
            F(discardCard)        // Todo
            F(getCard)            // Todo
            F(getCardName)        // Todo
            F(getLastDiscardCard) // Todo
            F(getNewCard)         // Todo
            F(initCardDeck)       // Todo
            F(pickNewCard)        // Todo
            F(setCard)            // Todo
        };
        class Bonus
        {
            file = "BRG_SabaccCore\Functions\Bonus";
            F(bonusSelector) // Todo
            F(initBonus)     // Todo
            F(useBonus)      // Todo
        };
        class Chips
        {
            file = "BRG_SabaccCore\Functions\Chips";
            F(addChips)    // Todo
            F(getChips)    // Todo
            F(initChips)   // Todo
            F(removeChips) // Todo
        };
        class Core
        {
            file = "BRG_SabaccCore\Functions\Core";
            F(initGame)             // Todo
            F(initPlayer)           // Todo
            F(calculateWinner)      // Todo
            F(calculatePlayerScore) // Todo
        };
        class Other
        {
            file = "BRG_SabaccCore\Functions\Other";
            F(launchDice) // Todo
            F(revealDice) // Todo
            F(showRules)  // Todo
        };
        class UI
        {
            file = "BRG_SabaccCore\Functions\UI";
            F(initUI)           // Todo
            F(clickTarget)      // Todo
            F(clickBonus)       // Todo
            F(clickCardInHand)  // Todo
            F(clickNewCard)     // Todo
            F(clickDiscardCard) // Todo
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