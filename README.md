# 🎲 Sabacc - A Star Wars Game in Arma 3

Play **Kessel Sabacc** with other players (or droids) from a terminal item, anywhere in Arma 3.
Multiplayer-ready: the server runs the game and every player only receives their own hand.

## 🃏 How to play

1. Get a **Sabacc Terminal** (Arsenal / Zeus / editor: *Equipment > Inventory items*).
2. Open it: ACE self-interaction *Equipment > Play Sabacc*, the scroll-wheel action without ACE, or the *Open Sabacc terminal* keybind (CBA controls).
3. Create a table, wait for players (or **add droids**), then start the game.

Rules in short: you always hold one **Sand** and one **Blood** card. A pair is a *Sabacc* (the lower the better, two Sylops = *Pure Sabacc*); without a pair, the smallest difference wins. Each round has 3 turns: stand for free, or draw a card for 1 chip. **Shift tokens** (16 kinds) bend the rules once per game. The full rules are available in-game (*Rules* button).

## ⚙️ Settings (CBA, server-side)

| Setting | Default |
|---|---|
| Starting chips | 8 |
| Shift tokens per player | 2 |
| Turn time | 60 s |
| Results display time | 12 s |
| Sabacc terminal required | yes |

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
| `addons/items` | the Sabacc Terminal item |
| `addons/game` | game logic (`fnc_server*`), UI (`fnc_menu*`, `fnc_game*`), settings, textures |

## 📜 Licence

<a href="https://www.bohemia.net/community/licenses/arma-public-license-share-alike">
  <img src="https://files.bistudio.com/public/2d36aa7e-6a0e-4ae8-bdab-dfeb2273f731-1" alt="licence">
</a>

The source code and **original** resources of this project are available under the [APL-SA](https://www.bohemia.net/community/licenses/arma-public-license-share-alike) license.

> [!CAUTION]
> This mod is an unofficial resource and is not affiliated with Lucasfilm Ltd, the Walt Disney Company, Electronic Arts Inc., or Twentieth Century Fox. The "Star Wars" brand and all intellectual content in this mod are based on the property of The Walt Disney Company.
>
> Star Wars © 1977 Twentieth Century Fox Film Corporation. All rights reserved. ™ & Copyright 1977 Lucasfilm Ltd. Star Wars logo and all related characters, names, and indicia are trademarks & copyright 2012 Lucasfilm Ltd. All rights reserved, or their respective trademark and copyright holders.

## 💬 Feedback

We appreciate your feedback! Please open an issue on GitHub if you have suggestions or find bugs.
