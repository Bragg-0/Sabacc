#include "..\Functions\script_macro.hpp"

class SabaccGameInterface
{
	idd = SabaccInterface;
	movingEnable = false;

	class ControlsBackground
	{
		/* Player Cards*/
		class BRG_PlayerCardBackground
		{
			type = 0;
			idc = CardBackground;
			x = safeZoneX + safeZoneW * 0.3601757;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.27891655;
			h = safeZoneH * 0.32161459;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Player Bonus*/
		class BRG_PlayerBonusBackground
		{
			type = 0;
			idc = PlayerBonusBackground;
			x = safeZoneX + safeZoneW * 0.6647145;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.23133236;
			h = safeZoneH * 0.32161459;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Chips*/
		class BRG_PlayerChipsReserveBackground
		{
			type = 0;
			idc = PlayerChipsReserveBackground;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.82682292;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.1484375;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsReserve
		{
			type = 0;
			idc = PlayerChipsReserve;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.8359375;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 48 + 2;
			text = ""; // Chips img
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsInGameBackground
		{
			type = 0;
			idc = PlayerChipsInGameBackground;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.1484375;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsInGame
		{
			type = 0;
			idc = PlayerChipsInGame;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2 + 48;
			text = ""; // Chips img
			colorBackground[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Timer*/
		class BRG_TimerBackground
		{
			type = 0;
			idc = TimerBackground;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 1*/
		class BRG_PlayersInfoBackgroundPlayer1
		{
			type = 0;
			idc = Player1Background;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsBackgroundPlayer1
		{
			type = 0;
			idc = Player1ChipsBackground;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.0703125;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 2*/
		class BRG_PlayersInfoBackgroundPlayer2
		{
			type = 0;
			idc = Player2Background;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsBackgroundPlayer2
		{
			type = 0;
			idc = Player2ChipsBackground;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.2890625;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 3*/
		class BRG_PlayersInfoBackgroundPlayer3
		{
			type = 0;
			idc = Player3Background;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsBackgroundPlayer3
		{
			type = 0;
			idc = Player3ChipsBackground;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.5078125;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 4*/
		class BRG_PlayersInfoBackgroundPlayer4
		{
			type = 0;
			idc = Player4Background;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsBackgroundPlayer4
		{
			type = 0;
			idc = Player4ChipsBackground;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.7265625;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
	};
	class Controls
	{

		/* Player Bonus 1*/
		class BRG_PlayerBonus1
		{
			type = 0;
			idc = PlayerBonus1Name;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerBonusName1
		{
			type = 0;
			idc = PlayerBonus2Name;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.93619792;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.02994792;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Player Bonus 2*/
		class BRG_PlayerBonus2
		{
			type = 0;
			idc = PlayerBonus1;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerBonusName2
		{
			type = 0;
			idc = PlayerBonus2;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.93619792;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.02994792;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Player Card*/
		class BRG_PlayerCard1
		{
			type = 0;
			idc = PlayerCard1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerCard2
		{
			type = 0;
			idc = PlayerCard2;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Dice */
		class BRG_DiceTableBackground
		{
			type = 0;
			idc = DiceBackground;
			x = safeZoneX + safeZoneW * 0.385625;
			y = safeZoneY + safeZoneH * 0.02888889;
			w = safeZoneW * 0.228125;
			h = safeZoneH * 0.19;
			style = 0;
			text = "";
			colorBackground[] = ColorGreen50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Dice1
		{
			type = 0;
			idc = Dice1;
			x = safeZoneX + safeZoneW * 0.39;
			y = safeZoneY + safeZoneH * 0.03777778;
			w = safeZoneW * 0.096875;
			h = safeZoneH * 0.17333334;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Dice2
		{
			type = 0;
			idc = Dice2;
			x = safeZoneX + safeZoneW * 0.51;
			y = safeZoneY + safeZoneH * 0.03777778;
			w = safeZoneW * 0.096875;
			h = safeZoneH * 0.17333334;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Chips*/
		class BRG_PlayerChipsInGameCounter
		{
			type = 0;
			idc = PlayerChipsInGameCounter;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_PlayerChipsReserveCounter
		{
			type = 0;
			idc = PlayerChipsReserveCounter;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.90885417;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Table for player play*/
		class BRG_CentralTableBackgroundPlayerPlay
		{
			type = 0;
			idc = TableBackground;
			x = safeZoneX + safeZoneW * 0.25549049;
			y = safeZoneY + safeZoneH * 0.2890625;
			w = safeZoneW * 0.48828697;
			h = safeZoneH * 0.33984375;
			style = 0;
			text = "";
			colorBackground[] = ColorGreen50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableCard1PlayerPlay
		{
			type = 0;
			idc = TableCard1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableCard2PlayerPlay
		{
			type = 0;
			idc = TableCard2;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableDropCard1PlayerPlay
		{
			type = 0;
			idc = DropedCard1;
			x = safeZoneX + safeZoneW * 0.26500733;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableDropCard2PlayerPlay
		{
			type = 0;
			idc = DropedCard2;
			x = safeZoneX + safeZoneW * 0.65519766;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* MiniTable for player wait is turn*/
		class BRG_CentralTableBackground
		{
			type = 0;
			idc = MiniTableBackground;
			x = safeZoneX + safeZoneW * 0.70278185;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.26939971;
			h = safeZoneH * 0.21223959;
			style = 0;
			text = "";
			colorBackground[] = ColorGreen50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableCard1
		{
			type = 0;
			idc = MimiTableCard1;
			x = safeZoneX + safeZoneW * 0.76939971;
			y = safeZoneY + safeZoneH * 0.04296875;
			w = safeZoneW * 0.06002929;
			h = safeZoneH * 0.17578125;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableCard2
		{
			type = 0;
			idc = MimiTableCard2;
			x = safeZoneX + safeZoneW * 0.84553441;
			y = safeZoneY + safeZoneH * 0.04296875;
			w = safeZoneW * 0.06002929;
			h = safeZoneH * 0.17578125;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableDropCard1
		{
			type = 0;
			idc = MiniDropedCard1;
			x = safeZoneX + safeZoneW * 0.71229869;
			y = safeZoneY + safeZoneH * 0.06119792;
			w = safeZoneW * 0.04099561;
			h = safeZoneH * 0.13932292;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_TableDropCard2
		{
			type = 0;
			idc = MiniDropedCard2;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.06119792;
			w = safeZoneW * 0.04099561;
			h = safeZoneH * 0.13932292;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Timer*/
		class BRG_TimerBar
		{
			type = 8;
			idc = TimerBar;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 1;
			colorBar[] = ColorDarkYellow;
			colorFrame[] = ColorTransparent;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
		};
		class BRG_Timer
		{
			type = 0;
			idc = Timer;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
			shadow = 1;
		};

		/* Player 1 InfoPanel*/
		class BRG_PlayInfoPlayer1
		{
			type = 0;
			idc = PlayInfoPlayer1;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_NamePlayer1
		{
			type = 0;
			idc = NamePlayer1;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.03515625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
			shadow = 0;
		};
		class BRG_ChipsInRoundPlayer1
		{
			type = 0;
			idc = ChipsInRoundPlayer1;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsInRoundCounterPlayer1
		{
			type = 0;
			idc = ChipsInRoundCounterPlayer1;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReservePlayer1
		{
			type = 0;
			idc = ChipsReservePlayer1;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReserveCounterPlayer1
		{
			type = 0;
			idc = ChipsReserveCounterPlayer1;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus1Player1
		{
			type = 0;
			idc = Bonus1Player1;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus2Player1
		{
			type = 0;
			idc = Bonus2Player1;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card1Player1
		{
			type = 0;
			idc = Card1Player1;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card2Player1
		{
			type = 0;
			idc = Card2Player1;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 2 InfoPanel*/
		class BRG_PlayInfoPlayer2
		{
			type = 0;
			idc = PlayInfoPlayer2;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_NamePlayer2
		{
			type = 0;
			idc = NamePlayer2;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.25390625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
			shadow = 0;
		};
		class BRG_ChipsInRoundPlayer2
		{
			type = 0;
			idc = ChipsInRoundPlayer2;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsInRoundCounterPlayer2
		{
			type = 0;
			idc = ChipsInRoundCounterPlayer2;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReservePlayer2
		{
			type = 0;
			idc = ChipsReservePlayer2;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReserveCounterPlayer2
		{
			type = 0;
			idc = ChipsReserveCounterPlayer2;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus1Player2
		{
			type = 0;
			idc = Bonus1Player2;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus2Player2
		{
			type = 0;
			idc = Bonus2Player2;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card1Player2
		{
			type = 0;
			idc = Card1Player2;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card2Player2
		{
			type = 0;
			idc = Card2Player2;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 3 InfoPanel*/
		class BRG_PlayInfoPlayer3
		{
			type = 0;
			idc = PlayInfoPlayer3;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_NamePlayer3
		{
			type = 0;
			idc = NamePlayer3;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.47265625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
			shadow = 0;
		};
		class BRG_ChipsInRoundPlayer3
		{
			type = 0;
			idc = ChipsInRoundPlayer3;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsInRoundCounterPlayer3
		{
			type = 0;
			idc = ChipsInRoundCounterPlayer3;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReservePlayer3
		{
			type = 0;
			idc = ChipsReservePlayer3;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReserveCounterPlayer3
		{
			type = 0;
			idc = ChipsReserveCounterPlayer3;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus1Player3
		{
			type = 0;
			idc = Bonus1Player3;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus2Player3
		{
			type = 0;
			idc = Bonus2Player3;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card1Player3
		{
			type = 0;
			idc = Card1Player3;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card2Player3
		{
			type = 0;
			idc = Card2Player3;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Player 4 InfoPanel*/
		class BRG_PlayInfoPlayer4
		{
			type = 0;
			idc = PlayInfoPlayer4;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_NamePlayer4
		{
			type = 0;
			idc = NamePlayer4;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.69140625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = ColorBlack75;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
			shadow = 0;
		};
		class BRG_ChipsInRoundPlayer4
		{
			type = 0;
			idc = ChipsInRoundPlayer4;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsInRoundCounterPlayer4
		{
			type = 0;
			idc = ChipsInRoundCounterPlayer4;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReservePlayer4
		{
			type = 0;
			idc = ChipsReservePlayer4;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_ChipsReserveCounterPlayer4
		{
			type = 0;
			idc = ChipsReserveCounterPlayer4;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus1Player4
		{
			type = 0;
			idc = Bonus1Player4;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Bonus2Player4
		{
			type = 0;
			idc = Bonus2Player4;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card1Player4
		{
			type = 0;
			idc = Card1Player4;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class BRG_Card2Player4
		{
			type = 0;
			idc = Card2Player4;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Button*/
		class BRG_PlayerBonus1Button
		{
			type = 1;
			idc = Bonus1Button;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_PlayerBonus2Button
		{
			type = 1;
			idc = Bonus2Button;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_PlayerCard1Button
		{
			type = 1;
			idc = Card1Button;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_PlayerCard2Button
		{
			type = 1;
			idc = Card2Button;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_TableCard1PlayerPlayButton
		{
			type = 1;
			idc = TableCard1Button;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_TableDropCard1PlayerPlayButton
		{
			type = 1;
			idc = DropedCard1Button;
			x = safeZoneX + safeZoneW * 0.26500733;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_TableCard2PlayerPlayButton
		{
			type = 1;
			idc = TableCard2Button;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_TableDropCard2PlayerPlayButton
		{
			type = 1;
			idc = DropedCard2Button;
			x = safeZoneX + safeZoneW * 0.65519766;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_Player1Button
		{
			type = 1;
			idc = Player1Button;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_Player2Button
		{
			type = 1;
			idc = Player2Button;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_Player3Button
		{
			type = 1;
			idc = Player3Button;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
		class BRG_Player4Button
		{
			type = 1;
			idc = Player2Button;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = ColorTransparent;
			colorBackgroundActive[] = ColorBlack25;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorFocused[] = ColorBlack25;
			colorShadow[] = ColorTransparent;
			colorText[] = ColorBlack;
			font = DefaultFont;
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			SizeEx;
			SoundClick;
		};
	};
};
