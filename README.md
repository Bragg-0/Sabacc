# 🎲 Nar Shaddaa Sabacc - a fan-made card game for Arma 3

Play **Nar Shaddaa Sabacc** with other players (or droids) from a terminal item, anywhere in Arma 3.
Nar Shaddaa Sabacc is a fan-made variant inspired by the Sabacc card game of a famous space saga: its rules, card names and shift tokens are its own.
Multiplayer-ready: the server runs the game and every player only receives their own hand.

## 🃏 How to play

1. Get a **Nar Shaddaa Sabacc Terminal** (Arsenal / Zeus / editor: *Equipment > Inventory items*).
2. Open it: ACE self-interaction *Equipment > Play Nar Shaddaa Sabacc*, the scroll-wheel action without ACE, or the *Open the Nar Shaddaa Sabacc terminal* keybind (CBA controls).
3. Create a table, wait for players (or **add droids**), then start the game.

Rules in short: you always hold one **Amber** and one **Ember** card. A pair is a *Sabacc* (the lower the better, two Sylops = *Pure Sabacc*); without a pair, the smallest difference wins. Each round has 3 turns: stand for free, or draw a card for 1 chip. **Shift tokens** (16 kinds) bend the rules once per game. The full rules are available in-game (*Rules* button) and in the rulebook: English [Markdown](rules/en_us.md), French [Markdown](rules/fr_fr.md).

## 🪑 Physical tables, spectators and statistics

- **Physical tables**: place the editor module *Sabacc > Sabacc table* and synchronize it with any object (table, crate...). Players walk up to it to sit, watch or open their game, without a terminal. In a script (server): `[myObject, "Cantina", 4, 1] call brg_game_fnc_addWorldTable;` (object, name, seats, droids).
- **Spectators**: select a game in progress in the menu, then *Watch*. Cards stay hidden until the reveal.
- **Statistics**: *Statistics* button in the menu: your games, rounds, Sabaccs and the server top 5. Saved in the server profile.

## ⚙️ Settings (CBA, server-side)

| Setting | Default |
|---|---|
| Starting chips | 8 |
| Shift tokens per player | 2 |
| Turn time | 60 s |
| Results display time | 12 s |
| Nar Shaddaa Sabacc terminal required | yes |

## 🛠️ Development

Requires [HEMTT](https://hemtt.dev) and [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997). ACE3 is optional.

```sh
hemtt dev      # build + file patching
hemtt launch   # build and start Arma 3 (Ctrl+Shift+B in VS Code)
hemtt release  # signed release
```

| Addon | Content |
|---|---|
| `addons/main` | mod metadata, shared macros |
| `addons/items` | the Nar Shaddaa Sabacc Terminal item |
| `addons/game` | game logic (`fnc_server*`), UI (`fnc_menu*`, `fnc_game*`), settings, textures |
| `addons/compat_ace` | ACE self-interaction to open the terminal (loaded only when ACE is present) |

## 📜 Licence

<a href="https://www.bohemia.net/community/licenses/arma-public-license-share-alike">
  <img src="https://files.bistudio.com/public/2d36aa7e-6a0e-4ae8-bdab-dfeb2273f731-1" alt="licence">
</a>

The source code and **original** resources of this project are available under the [APL-SA](https://www.bohemia.net/community/licenses/arma-public-license-share-alike) license.

> [!CAUTION]
> Nar Shaddaa Sabacc is a free, non-commercial fan project. It is not sold, and no paid content is attached to it.
>
> If you hold rights on any element of this mod and want it changed or removed, please open an issue on GitHub: it will be handled promptly.
>
> This mod is an unofficial resource and is not affiliated with Lucasfilm Ltd, the Walt Disney Company, Electronic Arts Inc., or Twentieth Century Fox. The "Star Wars" brand and all intellectual content in this mod are based on the property of The Walt Disney Company.
>
> Star Wars © 1977 Twentieth Century Fox Film Corporation. All rights reserved. ™ & Copyright 1977 Lucasfilm Ltd. Star Wars logo and all related characters, names, and indicia are trademarks & copyright 2012 Lucasfilm Ltd. All rights reserved, or their respective trademark and copyright holders.

## 💬 Feedback

We appreciate your feedback! Please open an issue on GitHub if you have suggestions or find bugs.
