/**
 * GameTextDraws by iFarbod 2014
 * ifarbod@outlook.com
 *
 * Description : This Library, improves the (GameText) Feature, which is in SA:MP.
 *
 * FAQ:
 * What This Library will do?
 * - A Fix for buggy GameText Styles.
 * - Using custom color for each style.
 * - Adding more styles to GameTextFor(All/Player) Function (In the next versions).
 * 
 * What is bugs with original GameTextFor(All/Player) styles? (http://wiki.sa-mp.com/wiki/GameTextStyle)
 * - Style 0 : Appears for 9 seconds regardless of time setting. Hides textdraws and any other gametext on screen.
 * - Style 1 : Fades out after 8 seconds, regardless of time set. If you have a time setting longer than that, it will re-appear after fading out and repeat until the time ends.
 * - Style 2 : Does not disappear until the player respawns.
 * - Style 5 : Displays for 3 seconds, regardless of what time you set. Will refuse to be shown if it is 'spammed'.
 */

// We define this to setting the 'color' parameter to optional. and also avioding unwanted things.
#if !defined DEFAULT_COLOR
	#define DEFAULT_COLOR 0xFFFFFF03
#endif

#if !defined GAMETEXT_STYLES
	#define GAMETEXT_STYLES 12
#endif

// Variables
new
	PlayerText:GameTextDraw[MAX_PLAYERS][GAMETEXT_STYLES], // This array will hold all textdraws we've used in this library.

	GTHideTimer[MAX_PLAYERS][GAMETEXT_STYLES], // This will hold timers.

	GTIsShown[MAX_PLAYERS][GAMETEXT_STYLES]; // This one will track the shown/hidden status of a specific style.

new
	gStyleDefaultColor[GAMETEXT_STYLES] = 
	{
		0x906210FF,
		0x906210FF,
		0xE1E1E1FF,
		0x906210FF,
		0x906210FF,
		0xE1E1E1FF,
		0xACCBF1FF,
		0x906210FF,
		0x36682CFF,
		0xD7D3CCFF,
		0xD7D3CCFF,
		0xACCBF1FF
	};

/**
native GameTextForPlayer_(playerid, string[], time, style, color = DEFAULT_COLOR);
native GameTextForAll_(string[], time, style, color = DEFAULT_COLOR);
*/

stock GameTextForPlayer_(playerid, string[], time, style, color = DEFAULT_COLOR)
{
	if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid)) return 0;

	if(GTIsShown[playerid][style])
	{
		if(GTHideTimer[playerid][style])
		{
			KillTimer(GTHideTimer[playerid][style]);
		}
	}
	
	PlayerTextDrawHide(playerid, GameTextDraw[playerid][style]);

	if(color != DEFAULT_COLOR)
	{
		PlayerTextDrawColor(playerid, GameTextDraw[playerid][style], color);
	}

	else
	{
		PlayerTextDrawColor(playerid, GameTextDraw[playerid][style], gStyleDefaultColor[style]);
	}

	PlayerTextDrawSetString(playerid, GameTextDraw[playerid][style], string);
	PlayerTextDrawShow(playerid, GameTextDraw[playerid][style]);
	GTIsShown[playerid][style] = 1;
	GTHideTimer[playerid][style] = SetTimerEx("HideGameTextForPlayer", time, false, "ii", playerid, style);
	return 1;
}

// Our objective is GameTextForPlayer_. So these are some functions just for who ones like use this.
stock GameTextForAll_(string[], time, style, color = DEFAULT_COLOR)
{
	new
		ret = 0;

	for(new i = 0; i != MAX_PLAYERS; ++i)
	{
		GameTextForPlayer_(i, string, time, style, color);
		ret++;
	}

	return ret;
}

/**
stock GameTextForTeam_(teamid, string[], time, style, color = DEFAULT_COLOR)
{
	for(new i = 0; i != MAX_PLAYERS; ++i)
	{
		GameTextForPlayer_(i, string, time, style, color);
	}
}*/

stock GameTextForAllOthers_(playerid, string[], time, style, color = DEFAULT_COLOR)
{
	new
		ret = 0;

	for(new i = 0; i != MAX_PLAYERS; ++i)
	{
		if(IsPlayerConnected(playerid) && i != playerid)
		{
			GameTextForPlayer_(i, string, time, style, color);
			ret++;
		}
	}

	return ret;
}

// public functions
forward HideGameTextForPlayer(playerid, style);
public HideGameTextForPlayer(playerid, style)
{
	PlayerTextDrawSetString(playerid, GameTextDraw[playerid][style], "_");
	PlayerTextDrawHide(playerid, GameTextDraw[playerid][style]);
	GTIsShown[playerid][style] = 0;
}

// ALS Hookings (Hook Method 7 - Thanks to Y_Less)
public OnPlayerConnect(playerid)
{
	GameTextDraw[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 214.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][0], 3);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][0], 1.299998, 3.599998);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][0], -1872621313);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][0], 0);

	GameTextDraw[playerid][1] = CreatePlayerTextDraw(playerid, 620.000000, 310.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][1], 3);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][1], 3);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][1], 1.000000, 2.599998);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][1], -1872621313);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][1], 0);

	GameTextDraw[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 156.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][2], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][2], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][2], 0);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][2], 2.099998, 4.199998);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][2], 0);

	GameTextDraw[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 154.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][3], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][3], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][3], 0.600000, 2.750000);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][3], -1872621313);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][3], 0);

	GameTextDraw[playerid][4] = CreatePlayerTextDraw(playerid, 320.000000, 115.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][4], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][4], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][4], 0.600000, 2.750000);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][4], -1872621313);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][4], 0);

	GameTextDraw[playerid][5] = CreatePlayerTextDraw(playerid, 320.000000, 217.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][5], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][5], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][5], 0.600000, 2.750000);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][5], -505290241);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][5], 0);

	GameTextDraw[playerid][6] = CreatePlayerTextDraw(playerid, 320.000000, 60.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][6], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][6], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][6], 3);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][6], 1.000000, 3.599999);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][6], -1395920385);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][6], 0);

	GameTextDraw[playerid][7] = CreatePlayerTextDraw(playerid, 320.000000, 115.000000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][7], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][7], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][7], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][7], 0x906210FF);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][7], 0);

	GameTextDraw[playerid][8] = CreatePlayerTextDraw(playerid, 608.0, 344.0, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][8], 3);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][8], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][8], 2);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][8], 1.0, 3.0);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][8], 0x36682CFF);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][8], 0);

	GameTextDraw[playerid][9] = CreatePlayerTextDraw(playerid, 380.0, 341.0, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][9], 2);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][9], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][9], 0.58, 2.4);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][9], 0xD7D3CCFF);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, GameTextDraw[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][9], 0);

	GameTextDraw[playerid][10] = CreatePlayerTextDraw(playerid, 20.000000, 120.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][10], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][10], 0.500000, 2.000000);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][10], -1);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, GameTextDraw[playerid][10], 0);
	PlayerTextDrawUseBox(playerid, GameTextDraw[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, GameTextDraw[playerid][10], 170);
	PlayerTextDrawTextSize(playerid, GameTextDraw[playerid][10], 250.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][10], 0);

	GameTextDraw[playerid][11] = CreatePlayerTextDraw(playerid, 608.000000, 386.500000, "_");
	PlayerTextDrawAlignment(playerid, GameTextDraw[playerid][11], 3);
	PlayerTextDrawBackgroundColor(playerid, GameTextDraw[playerid][11], 255);
	PlayerTextDrawFont(playerid, GameTextDraw[playerid][11], 0);
	PlayerTextDrawLetterSize(playerid, GameTextDraw[playerid][11], 1.200000, 3.799998);
	PlayerTextDrawColor(playerid, GameTextDraw[playerid][11], 0xACCBF1FF);
	PlayerTextDrawSetOutline(playerid, GameTextDraw[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, GameTextDraw[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, GameTextDraw[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, GameTextDraw[playerid][11], 0);

	#if defined GTFix_OnPlayerConnect
        return GTFix_OnPlayerConnect(playerid);
    #else
    	return 1;
	#endif
}

#if defined GTFix_OnPlayerConnect
	forward GTFix_OnPlayerConnect(playerid);
#endif
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect GTFix_OnPlayerConnect


/**
 * IMPORTANT NOTE: Player Text Draws will be destroyed automaticly. NO NEED TO DESTROY THEM!
 */
public OnPlayerDisconnect(playerid, reason)
{
	for(new i = 0; i != GAMETEXT_STYLES; ++i)
	{
		GTIsShown[playerid][i] = 0;
	}

	#if defined GTFix_OnPlayerDisconnect
        return GTFix_OnPlayerDisconnect(playerid, reason);
    #else
    	return 1;
	#endif
}

#if defined GTFix_OnPlayerDisconnect
	forward GTFix_OnPlayerDisconnect(playerid, reason);
#endif
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GTFix_OnPlayerDisconnect