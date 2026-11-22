// Functions, sorted by folder (addons/game/functions/<folder>/fnc_<name>.sqf)

// Server: tables, players, turns, rounds, shift tokens, droids, statistics
PREP_SUB(server,serverActivePlayers);
PREP_SUB(server,serverAddBot);
PREP_SUB(server,serverApplyShift);
PREP_SUB(server,serverArmTimer);
PREP_SUB(server,serverAutoChoose);
PREP_SUB(server,serverBeginTurn);
PREP_SUB(server,serverBotPlay);
PREP_SUB(server,serverBuildView);
PREP_SUB(server,serverCheckChoices);
PREP_SUB(server,serverCreateTable);
PREP_SUB(server,serverCurrentUid);
PREP_SUB(server,serverEndGame);
PREP_SUB(server,serverEndTurn);
PREP_SUB(server,serverFindPlayer);
PREP_SUB(server,serverGameAction);
PREP_SUB(server,serverInit);
PREP_SUB(server,serverJoinTable);
PREP_SUB(server,serverLeave);
PREP_SUB(server,serverLog);
PREP_SUB(server,serverNewPlayer);
PREP_SUB(server,serverNewTable);
PREP_SUB(server,serverNextImpostor);
PREP_SUB(server,serverNextRound);
PREP_SUB(server,serverNotify);
PREP_SUB(server,serverRequest);
PREP_SUB(server,serverResolveChoice);
PREP_SUB(server,serverResolveRound);
PREP_SUB(server,serverReveal);
PREP_SUB(server,serverSeatBot);
PREP_SUB(server,serverSendStats);
PREP_SUB(server,serverStartGame);
PREP_SUB(server,serverStartRound);
PREP_SUB(server,serverStatsAdd);
PREP_SUB(server,serverStatsSave);
PREP_SUB(server,serverStopWatching);
PREP_SUB(server,serverSync);
PREP_SUB(server,serverSyncLobby);
PREP_SUB(server,serverTimeout);
PREP_SUB(server,serverWatch);

// Physical tables (objects of the world) and the Eden module
PREP_SUB(world,addWorldTable);
PREP_SUB(world,moduleTable);
PREP_SUB(world,serverResetWorldTable);
PREP_SUB(world,serverWorldTableCheck);
PREP_SUB(world,worldTableAct);
PREP_SUB(world,worldTableCan);
PREP_SUB(world,worldTableCards);
PREP_SUB(world,worldTableMyCards);
PREP_SUB(world,worldTableProps);
PREP_SUB(world,worldTableScan);
PREP_SUB(world,worldTableSeat);
PREP_SUB(world,worldTableSound);

// Game rules: deck, hands, table rules, ranking
PREP_SUB(rules,cardName);
PREP_SUB(rules,createDeck);
PREP_SUB(rules,evaluateHand);
PREP_SUB(rules,gameRanking);
PREP_SUB(rules,tableRule);

// Client: initialisation, requests to the server, sounds
PREP_SUB(client,canOpenTerminal);
PREP_SUB(client,clientInit);
PREP_SUB(client,onStateChanged);
PREP_SUB(client,openTerminal);
PREP_SUB(client,playSound);
PREP_SUB(client,rematchInfo);
PREP_SUB(client,request);
PREP_SUB(client,viewSubject);

// Terminal menu (list of tables)
PREP_SUB(menu,menuOnLoad);
PREP_SUB(menu,menuOnUnload);
PREP_SUB(menu,menuRefresh);
PREP_SUB(menu,menuUpdateInfo);
PREP_SUB(menu,menuUpdateStart);

// Game screen
PREP_SUB(game,gameAction);
PREP_SUB(game,gameAnimate);
PREP_SUB(game,gameEndRefresh);
PREP_SUB(game,gameOnLoad);
PREP_SUB(game,gameOnUnload);
PREP_SUB(game,gamePulse);
PREP_SUB(game,gameRefresh);
PREP_SUB(game,gameUpdateHeader);

// Animations of the game screen
PREP_SUB(anim,animBanner);
PREP_SUB(anim,animDice);
PREP_SUB(anim,animFadeIn);
PREP_SUB(anim,animFlip);
PREP_SUB(anim,animFloatText);
PREP_SUB(anim,animFly);
PREP_SUB(anim,animPop);
PREP_SUB(anim,animScale);

// Interface helpers (controls, frames, texts, textures)
PREP_SUB(ui,cardHelp);
PREP_SUB(ui,cardTexture);
PREP_SUB(ui,createCtrl);
PREP_SUB(ui,formatMessage);
PREP_SUB(ui,formatResult);
PREP_SUB(ui,shiftInfo);
PREP_SUB(ui,statsText);
PREP_SUB(ui,statusName);
PREP_SUB(ui,uiFrame);
PREP_SUB(ui,uiHelp);
PREP_SUB(ui,uiRow);
PREP_SUB(ui,uiTitle);
