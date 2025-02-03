class SabaccGameInterface
{
	idd = 22;
	movingEnable = false;

	class ControlsBackground
	{
		/* Player Cards */
		class PlayerCardBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.3601757;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.27891655;
			h = safeZoneH * 0.32161459;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player Bonus */
		class PlayerBonusBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.6647145;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.23133236;
			h = safeZoneH * 0.32161459;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Chips */
		class PlayerChipsReserveBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.82682292;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.1484375;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsReserve
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.8359375;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 48 + 2;
			text = ""; // Chips img
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsInGameBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.65364584;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.1484375;
			style = 0;
			text = "";
			colorBackground[] = {0.3, 0.8, 0.8, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsInGame
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2 + 48;
			text = ""; // Chips img
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Timer */
		class TimerBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 1 */
		class PlayersInfoBackgroundPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsBackgroundPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.0703125;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = {0.3, 0.8, 0.8, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 2 */
		class PlayersInfoBackgroundPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsBackgroundPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.2890625;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = {0.3, 0.8, 0.8, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 3 */
		class PlayersInfoBackgroundPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsBackgroundPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.5078125;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = {0.3, 0.8, 0.8, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 4 */
		class PlayersInfoBackgroundPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsBackgroundPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.11273793;
			y = safeZoneY + safeZoneH * 0.7265625;
			w = safeZoneW * 0.06954613;
			h = safeZoneH * 0.05729167;
			style = 0;
			text = "";
			colorBackground[] = {0.3, 0.8, 0.8, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
	};
	class Controls
	{

		/* Player Bonus 1*/
		class PlayerBonus1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerBonusName1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.93619792;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.02994792;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player Bonus 2 */
		class PlayerBonus2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerBonusName2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.93619792;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.02994792;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player Card*/
		class PlayerCard1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerCard2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Chips */
		class PlayerChipsInGameCounter
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class PlayerChipsReserveCounter
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.93118595;
			y = safeZoneY + safeZoneH * 0.90885417;
			w = safeZoneW * 0.03147878;
			h = safeZoneH * 0.05729167;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Table for player play*/
		class CentralTableBackgroundPlayerPlay
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.25549049;
			y = safeZoneY + safeZoneH * 0.2890625;
			w = safeZoneW * 0.48828697;
			h = safeZoneH * 0.33984375;
			style = 0;
			text = "";
			colorBackground[] = {0, 0.2, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableCard1PlayerPlay
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableDropCard1PlayerPlay
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26500733;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableCard2PlayerPlay
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableDropCard2PlayerPlay
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.65519766;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Table for player wait is turn*/
		class CentralTableBackground
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.70278185;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.26939971;
			h = safeZoneH * 0.21223959;
			style = 0;
			text = "";
			colorBackground[] = {0, 0.2, 0, 0.5};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableCard1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.76939971;
			y = safeZoneY + safeZoneH * 0.04296875;
			w = safeZoneW * 0.06002929;
			h = safeZoneH * 0.17578125;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableCard2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.84553441;
			y = safeZoneY + safeZoneH * 0.04296875;
			w = safeZoneW * 0.06002929;
			h = safeZoneH * 0.17578125;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableDropCard2
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.06119792;
			w = safeZoneW * 0.04099561;
			h = safeZoneH * 0.13932292;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class TableDropCard1
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.71229869;
			y = safeZoneY + safeZoneH * 0.06119792;
			w = safeZoneW * 0.04099561;
			h = safeZoneH * 0.13932292;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Timer */
		class TimerBar
		{
			type = 8;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 1;
			colorBar[] = {0.4, 0.4, 0, 1};
			colorFrame[] = {0, 0, 0, 0};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
		};
		class Timer
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.92166911;
			y = safeZoneY + safeZoneH * 0.55338542;
			w = safeZoneW * 0.05051245;
			h = safeZoneH * 0.08463542;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;
		};

		/* Player 1 InfoPanel*/
		class PlayInfoPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 1, 1, 1};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class NamePlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.03515625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 0;
		};
		class ChipsInRoundPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsInRoundCounterPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReservePlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReserveCounterPlayer1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.07942709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus1Player1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus2Player1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card1Player1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card2Player1
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.13411459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 2 InfoPanel*/
		class PlayInfoPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 1, 1, 1};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class NamePlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.25390625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 0;
		};
		class ChipsInRoundPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsInRoundCounterPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReservePlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReserveCounterPlayer2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.29817709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus1Player2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus2Player2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card1Player2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card2Player2
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.35286459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 3 InfoPanel */
		class PlayInfoPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 1, 1, 1};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class NamePlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.47265625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 0;
		};
		class ChipsInRoundPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsInRoundCounterPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReservePlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReserveCounterPlayer3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.51692709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus1Player3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus2Player3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card1Player3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card2Player3
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.57161459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Player 4 InfoPanel*/
		class PlayInfoPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.00292826;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			colorBackground[] = {0, 1, 1, 1};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class NamePlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.69140625;
			w = safeZoneW * 0.14568082;
			h = safeZoneH * 0.02994792;
			style = 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0.75};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 0;
		};
		class ChipsInRoundPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.12225476;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsInRoundCounterPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.15080528;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReservePlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.04612006;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 48 + 2;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class ChipsReserveCounterPlayer4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.07467058;
			y = safeZoneY + safeZoneH * 0.73567709;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.0390625;
			style = 0;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus1Player4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.03660323;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Bonus2Player4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.06515374;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card1Player4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.1317716;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class Card2Player4
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.16032211;
			y = safeZoneY + safeZoneH * 0.79036459;
			w = safeZoneW * 0.02196194;
			h = safeZoneH * 0.06640625;
			style = 2 + 48;
			text = "";
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

		/* Button */
		class PlayerBonus1Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.67423134;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class PlayerBonus2Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.78843339;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.09809664;
			h = safeZoneH * 0.26692709;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class PlayerCard1Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class PlayerCard2Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.66276042;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class TableCard1PlayerPlayButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.36969254;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class TableDropCard1PlayerPlayButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26500733;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class TableCard2PlayerPlayButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5124451;
			y = safeZoneY + safeZoneH * 0.30729167;
			w = safeZoneW * 0.11713031;
			h = safeZoneH * 0.30338542;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class TableDropCard2PlayerPlayButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.65519766;
			y = safeZoneY + safeZoneH * 0.34375;
			w = safeZoneW * 0.07906296;
			h = safeZoneH * 0.23958334;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class Player1Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.02473959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class Player2Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.24348959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class Player3Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.46223959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
		class Player4Button
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02708639;
			y = safeZoneY + safeZoneH * 0.68098959;
			w = safeZoneW * 0.1647145;
			h = safeZoneH * 0.19401042;
			style = 0;
			text = "";
			borderSize = 0;
			colorBackground[] = {0, 0, 0, 0};
			colorBackgroundActive[] = {0, 0, 0, 0.25};
			colorBackgroundDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorBorder[] = {0, 0, 0, 0};
			colorDisabled[] = {0.2, 0.2, 0.2, 0.5};
			colorFocused[] = {0.2, 0.2, 0.2, 0.25};
			colorShadow[] = {0, 0, 0, 0};
			colorText[] = {0, 0, 0, 1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0;
			offsetY = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1.0};
		};
	};
};
