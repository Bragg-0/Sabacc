#include "..\Functions\script_macro.hpp"

class SabaccGamesMenu
{
	idd = SabaccMenu;
	movingEnable = false;

	class ControlsBackground
	{
		/* Main Frame */
		class Background
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.45;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorTransparent;
			font = DefaultFont;
			SizeEx;
		};
		class Title
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.04;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class GameInfoFrame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.50375;
			y = safeZoneY + safeZoneH * 0.27444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.24;
			style = 64;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class GamesListFrame
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.30375;
			y = safeZoneY + safeZoneH * 0.27444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.39;
			style = 64;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class GameNameTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.51375;
			y = safeZoneY + safeZoneH * 0.28444445;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.02;
			style = 0;
			text = "GameName :";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class PlayerInGameTitle
		{
			type = 0;
			idc = 0;
			x = safeZoneX + safeZoneW * 0.51375;
			y = safeZoneY + safeZoneH * 0.35444445;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Players :";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Params */
		class BackgroundParams
		{
			type = 0;
			idc = MenuBackgroundParams;
			x = safeZoneX + safeZoneW * 0.71375;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.2;
			style = 0;
			text = "";
			colorBackground[] = ColorBlack50;
			colorText[] = ColorTransparent;
			font = DefaultFont;
			SizeEx;
		};
		class TitleParams
		{
			type = 0;
			idc = MenuTitleParams;
			x = safeZoneX + safeZoneW * 0.71375;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.04;
			style = 0;
			text = "";
			colorBackground[] = ColorLightBlue50;
			colorText[] = ColorBlack;
			font = DefaultFont;
			SizeEx;
		};
		class FrameParms
		{
			type = 0;
			idc = MenuFrameParms;
			x = safeZoneX + safeZoneW * 0.72375;
			y = safeZoneY + safeZoneH * 0.27444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.08;
			style = 64;
			text = "";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class GameParmsTitlePlayersQtt
		{
			type = 0;
			idc = MenuGameParmsTitlePlayersQtt;
			x = safeZoneX + safeZoneW * 0.73375;
			y = safeZoneY + safeZoneH * 0.28444445;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Players qtt :";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
	};
	class Controls
	{
		/* GamesList */
		class GamesList
		{
			type = 5;
			idc = MenuGamesList;
			x = safeZoneX + safeZoneW * 0.31375;
			y = safeZoneY + safeZoneH * 0.28444445;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.36555556;
			style = 16;
			colorBackground[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorSelect[] = ColorRed;
			colorText[] = ColorWhite;
			font = DefaultFont;
			maxHistoryDelay = 0;
			rowHeight = 0;
			SizeEx;
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1.0};
			class ListScrollBar
			{
				color[] = ColorWhite;
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
		};

		/* Button Main Frame*/
		class JoinGameButton
		{
			type = 1;
			idc = MenuJoinGameButton;
			x = safeZoneX + safeZoneW * 0.50375;
			y = safeZoneY + safeZoneH * 0.52444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 0 + 2;
			text = "Join Game";
			borderSize = 0;
			colorBackground[] = ColorGreen50;
			colorBackgroundActive[] = ColorGreen50;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack;
			colorFocused[] = ColorWhite;
			colorShadow[] = ColorBlack50;
			colorText[] = ColorWhite;
			font = DefaultFont;
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			SizeEx;
			SoundClick;
		};
		class LeaveGameButton
		{
			type = 1;
			idc = MenuLeaveGameButton;
			x = safeZoneX + safeZoneW * 0.50375;
			y = safeZoneY + safeZoneH * 0.57444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 0 + 2;
			text = "Leave the Game";
			borderSize = 0;
			colorBackground[] = ColorRed50;
			colorBackgroundActive[] = ColorRed50;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack;
			colorFocused[] = ColorWhite;
			colorShadow[] = ColorBlack50;
			colorText[] = ColorWhite;
			font = DefaultFont;
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			SizeEx;
			SoundClick;
		};
		class CreateNewGameButton
		{
			type = 1;
			idc = MenuCreateGameButton;
			x = safeZoneX + safeZoneW * 0.50375;
			y = safeZoneY + safeZoneH * 0.62444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 0 + 2;
			text = "Create New Game";
			borderSize = 0;
			colorBackground[] = ColorGreen50;
			colorBackgroundActive[] = ColorGreen50;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack;
			colorFocused[] = ColorWhite;
			colorShadow[] = ColorBlack50;
			colorText[] = ColorWhite;
			font = DefaultFont;
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			SizeEx;
			SoundClick;
		};

		/* InfoPanel */
		class GameNameSelected
		{
			type = 0;
			idc = MenuGameNameSelected;
			x = safeZoneX + safeZoneW * 0.52375;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Game 1";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class Player1InGame
		{
			type = 0;
			idc = MenuPlayer1InGame;
			x = safeZoneX + safeZoneW * 0.52375;
			y = safeZoneY + safeZoneH * 0.38444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Player 1 (Owner)";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class Player2InGame
		{
			type = 0;
			idc = MenuPlayer2InGame;
			x = safeZoneX + safeZoneW * 0.52375;
			y = safeZoneY + safeZoneH * 0.41444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Player 2";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class Player3InGame
		{
			type = 0;
			idc = MenuPlayer3InGame;
			x = safeZoneX + safeZoneW * 0.52375;
			y = safeZoneY + safeZoneH * 0.44444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Player 3";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};
		class Player3InGame
		{
			type = 0;
			idc = MenuPlayer4InGame;
			x = safeZoneX + safeZoneW * 0.52375;
			y = safeZoneY + safeZoneH * 0.47444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02;
			style = 0;
			text = "Player 4";
			colorBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			SizeEx;
		};

		/* Params */
		class DeleteGameButton
		{
			type = 1;
			idc = MenuDeleteGameButton;
			x = safeZoneX + safeZoneW * 0.72375;
			y = safeZoneY + safeZoneH * 0.37444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 0 + 2;
			text = "Delete Game";
			borderSize = 0;
			colorBackground[] = ColorRed50;
			colorBackgroundActive[] = ColorRed50;
			colorBackgroundDisabled[] = ColorBlack50;
			colorBorder[] = ColorTransparent;
			colorDisabled[] = ColorBlack;
			colorFocused[] = ColorWhite;
			colorShadow[] = ColorBlack50;
			colorText[] = ColorWhite;
			font = DefaultFont;
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			SizeEx;
			SoundClick;
		};
		class GameParmsPlayersQtt
		{
			type = 4;
			idc = MenuGameParmsPlayersQtt;
			x = safeZoneX + safeZoneW * 0.74375;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.02555556;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = ColorTransparent;
			colorDisabled[] = ColorBlack50;
			colorSelect[] = ColorRed;
			colorSelectBackground[] = ColorTransparent;
			colorText[] = ColorWhite;
			font = DefaultFont;
			maxHistoryDelay = 0;
			SizeEx;
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse", 0.1, 1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand", 0.1, 1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect", 0.1, 1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = ColorWhite;
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
		};
	};
};
