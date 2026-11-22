// Seated at a Sabacc table: the sitting poses of the hub animations (one at random when sitting down),
// with the head free (the hub template uses head = "headNo", which locks the view)
#define SITTING_FREE_HEAD \
    head = "headDefault"; \
    aiming = "aimingNo"; \
    aimingBody = "aimingUpDefault"; \
    leaning = "leaningDefault"; \
    enableDirectControl = 1; \
    ConnectTo[] = {}; \
    InterpolateTo[] = {"Unconscious", 0.02};

class CfgMovesBasic;
class CfgMovesMaleSdr: CfgMovesBasic {
    class States {
        class HubSittingChairA_idle1;
        class HubSittingChairB_idle1;
        class HubSittingChairUA_idle1;
        class HubSittingChairUB_idle1;
        class DOUBLES(GVAR(sitting),A): HubSittingChairA_idle1 {
            SITTING_FREE_HEAD
        };
        class DOUBLES(GVAR(sitting),B): HubSittingChairB_idle1 {
            SITTING_FREE_HEAD
        };
        class DOUBLES(GVAR(sitting),UA): HubSittingChairUA_idle1 {
            SITTING_FREE_HEAD
        };
        class DOUBLES(GVAR(sitting),UB): HubSittingChairUB_idle1 {
            SITTING_FREE_HEAD
        };
    };
};
