# Rulebook
# Nar Shaddaa Sabacc

*Fan-made card game for Arma 3, 2 to 4 players (droids included).*

*Nar Shaddaa Sabacc is a free, non-commercial fan project, not affiliated with Lucasfilm Ltd. or The Walt Disney Company.*

---

## 1. Goal

Be the **last player with chips left**.

Each round, everyone tries to hold the best hand. The winner gets their bet back, the others lose theirs and pay a penalty. A player with no chip left is out.

---

## 2. Components

### The cards

The deck has **46 cards**, split into two suits of 23 cards: **Amber** (gold) and **Ember** (red).

| Card | Copies per suit | Role |
|---|---|---|
| Values 1 to 6 | 3 of each | Normal value |
| **Mirage** | 3 | Value unknown until the reveal, rolled with dice |
| **Sylop** | 2 | Copies the value of the other card in the hand |

### The chips

- **Reserve**: the chips you own. **8** at the start (from 4 to 20 in the settings).
- **Pot**: the chips you bet during the current round. You get it back if you win the round, and lose it otherwise.
- **Shift tokens**: **2** per player (from 0 to 4 in the settings), drawn at random from 16 different tokens. They lie face up: everyone sees the others' tokens. Each token can be used **once per game**.

---

## 3. Your hand

You **always hold two cards**: **one Amber and one Ember**.

### Hand ranking, from best to worst

| Rank | Hand | Example |
|---|---|---|
| 1 | **Pure Sabacc**: two Sylops | Sylop + Sylop |
| 2 | **Sabacc** (a pair): the lower the value, the better | 1/1, then 2/2… up to 6/6 |
| 3 | **No pair**: the smaller the gap between the two cards, the better | 3/4 (gap 1) beats 2/5 (gap 3) |

- A **Sylop** takes the value of your other card: Sylop + 4 makes a **Sabacc of 4**.
- Between two hands without a pair and with the same gap, the one with the **lowest card** wins: 1/3 beats 4/6.
- If several players share the **same best hand**, they **all** win the round.

---

## 4. Playing a round

### Setup

At the start of each round:

1. Both decks are shuffled.
2. Each player gets **one Amber card and one Ember card**, face down.
3. One card of each suit is turned face up: these are the **discard piles**.
4. The dealer changes every round, and the next player starts.

### Your turn

A round lasts **3 turns around the table** at most. On your turn:

**1. Before acting (optional):** you may play **one** shift token.

**2. Then, choose:**

- **Stand**: you keep your hand. It is free.
- **Draw**: you pay **1 chip**, which goes to your pot, and take one card of your choice:
  - the top of a **deck** (Amber or Ember), without knowing what you take;
  - the top of a **discard pile** (Amber or Ember), whose card you can see.

**3. If you drew:**

- either you **keep the drawn card**, and your card of the same suit goes to the discard pile;
- or you **keep your hand**, and the drawn card goes to the discard pile.

With no chip in your reserve, you can no longer draw: you can only stand.

### Early reveal

If **every player still in the game stands one after the other**, with nobody drawing in between, the reveal happens right away, without waiting for the end of the 3 turns.

---

## 5. The reveal

### Mirages

For each Mirage in hand, its owner **rolls two dice** and **chooses** which one becomes the value of the Mirage. Under each die, the game shows the resulting hand.

### Results

| Player | What happens |
|---|---|
| **Best hand** | Gets their whole pot back into their reserve |
| **The others, with a Sabacc** | Lose their pot **and** pay **1 chip** |
| **The others, without a pair** | Lose their pot **and** pay **the gap between their two cards** |

A player with **no chip left** after the results is **out**.

### End of the game

When only **one player** still has chips, they win the game. An end screen then shows the ranking: the winner, then the players from the last one eliminated to the first.

---

## 6. The 16 shift tokens

A token is played **on your turn, before drawing or standing**, at most **one per turn**. A **tax** moves chips from a player's reserve to their own pot.

| Token | Effect |
|---|---|
| **Rebate** | Take 3 chips back from your pot. |
| **Inspection** *(targeted)* | A player holding at least 3 chips puts 3 in their pot. |
| **Fixed mirage** | Until the reveal, every Mirage is worth 6. |
| **Forced swap** *(targeted)* | You exchange your two cards with a player's. |
| **Dimmed sylop** | Until the reveal, every Sylop is worth 0. |
| **Blockade** | The next player loses their turn. |
| **Skim** | Each other player moves 1 chip from their pot to yours. |
| **Courtesy draw** | Your next draw this round is free. |
| **Shield** | Until the reveal, other players' tokens cannot affect you. |
| **Crackdown** | Every other player who stood on their last turn puts 2 chips in their pot. |
| **Table fee** | Every other player puts 1 chip in their pot. |
| **Discount** | Take 2 chips back from your pot. |
| **Priority odds** | Roll 2 dice and keep one: the Sabacc of that value ranks right after the Pure Sabacc. |
| **Fine** *(targeted)* | A player puts 2 chips in their pot. |
| **Upside down** | Until the reveal, the order of Sabaccs is reversed: 6/6 beats 1/1. |
| **Reshuffle** *(targeted)* | A player discards both cards and draws two new ones. |

**Details:**

- "Until the reveal" effects end at the end of the round.
- A **targeted** token can target neither yourself, nor an eliminated player, nor a player protected by a **Shield**.
- **Blockade** has no effect if the next player is protected by a Shield.
- Taxes never take more chips than the player has, and refunds never more than your pot.
- With **Dimmed sylop**, two Sylops make a Sabacc of 0, and no longer a Pure Sabacc.

---

## 7. Time

Each turn has a **time limit**, **60 seconds** by default. The countdown starts after the "Your turn!" banner, during which the table does not respond to clicks. When time runs out, the game plays for you:

- if you had drawn, you **keep your hand**;
- otherwise, you **stand**;
- a pending dice choice is made automatically (for a Mirage, the die that gives the best hand).

The results of a round stay on screen for **12 seconds** before the next round.

---

## 8. Playing in Arma 3

### Opening the terminal

1. Equip a **Nar Shaddaa Sabacc Terminal** (Arsenal, Zeus or editor: *Equipment > Inventory items*).
2. Open it:
   - with ACE: self-interaction, *Equipment > Play Nar Shaddaa Sabacc*;
   - without ACE: scroll-wheel action;
   - or with the **keybind**, to assign in the CBA controls.

### Creating or joining a table

- **Create**: give a name, choose 2 to 4 seats. You become the **host**.
- **Join**: select a waiting table in the list.
- **Add droid** (host): seats a computer-controlled player, to play or test alone.
- **Start** (host): starts the game, from 2 players.
- **Leaving** a table during a game means **forfeiting**.

### Server settings (CBA)

| Setting | Default | Range |
|---|---|---|
| Starting chips | 8 | 4 to 20 |
| Shift tokens per player | 2 | 0 to 4 |
| Turn time | 60 s | 15 to 180 s |
| Results display time | 12 s | 5 to 30 s |
| Terminal required to play | yes | yes / no |

---

## 9. Glossary

| Term | Definition |
|---|---|
| **Reserve** | The chips you own |
| **Pot** | Your chips bet during the round |
| **Sabacc** | A hand of two cards of the same value |
| **Pure Sabacc** | Two Sylops, the best hand |
| **Gap** | The difference between the values of your two cards |
| **Tax** | Chips moving from a player's reserve to their pot |
| **Reveal** | The end of the round, when all hands are shown |
