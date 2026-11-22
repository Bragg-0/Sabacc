// Sound effects of the game (synthesized for the mod: tools/gen_sounds.py)
// Played with brg_game_fnc_playSound, e.g. ["chips"] call brg_game_fnc_playSound
#define SFX(SND) class DOUBLES(GVAR(sfx),SND) { \
    name = QUOTE(SND); \
    sound[] = {QPATHTOF(data\sounds\SND.wss), 1, 1}; \
    titles[] = {}; \
}

class CfgSounds {
    SFX(click);
    SFX(card_draw);
    SFX(card_place);
    SFX(card_flip);
    SFX(shuffle);
    SFX(chips);
    SFX(dice);
    SFX(turn);
    SFX(round);
    SFX(reveal);
    SFX(win);
    SFX(lose);
    SFX(victory);
    SFX(eliminated);
    SFX(shift);
    SFX(tick);
};
