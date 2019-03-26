//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

// Feature created by Hansrutger, adapted for DC-RP by Seanny

#include <YSI\y_hooks>

//internals

#define MAX_CHARGES 30

enum e_Charges {
	cExists,
	cDescription[128]
};
new Charges[MAX_PLAYERS][MAX_CHARGES][e_Charges];
new ChargeSuspect[MAX_PLAYERS][MAX_PLAYER_NAME];
new ChargeHolder[MAX_PLAYERS][MAX_CHARGES];
new ChargeCounter[MAX_PLAYERS];
new gActiveTickets[MAX_PLAYERS][25];

enum {
	MDC_TYPE_NONE,
	MDC_TYPE_MENU,
	MDC_TYPE_INSERT,
	MDC_TYPE_INFO
};

enum {
	MDC_NONE,
	MDC_MAIN_MENU,
	MDC_SEARCH_CITIZEN,
	MDC_SEARCH_CITIZEN_SIMP,
	MDC_SEARCH_CITIZEN_ADV,
	MDC_CITIZEN_PLAYERS_LINKS,
	MDC_CITIZEN_LINKS_SIMP,
	MDC_CITIZEN_LINKS_ADV,
	MDC_CITIZEN_SEARCH_LINKS,
	MDC_CITIZEN_INFO_SIMP,
	MDC_CITIZEN_INFO_ADV,
	MDC_CITIZEN_VEH_SIMP,
	MDC_CITIZEN_VEH_ADV,
	MDC_CITIZEN_PROP_SIMP,
	MDC_CITIZEN_PROP_ADV,
	MDC_CITIZEN_PHONE_SIMP,
	MDC_CITIZEN_PHONE_ADV,
	MDC_CITIZEN_LICS_SIMP,
	MDC_CITIZEN_LICS_ADV,
	MDC_SEARCH_PLATE,
	MDC_SEARCH_ADDRESS,
	MDC_SEARCH_SERIAL,
	MDC_RECORD_MENU,
	MDC_CHARGE_MENU,
	MDC_TICKET_MENU
};
new MDCProcess[MAX_PLAYERS]; // will hold from the enum above

new MDCSearch_Fullname[MAX_PLAYERS][MAX_PLAYER_NAME];
new MDCSearch_Phone[MAX_PLAYERS];
new MDCSearch_Bloodtype[MAX_PLAYERS];
new MDCSearch_Gender[MAX_PLAYERS];
new MDCSearch_Age[MAX_PLAYERS][32];
new MDCSearch_HolderID[MAX_PLAYERS];
new MDCSearch_Any[MAX_PLAYERS][128];

new MDCQuery[MAX_PLAYERS][1024];
new MDCQueryID[MAX_PLAYERS][5];

enum e_Player
{
	PlayerText:pText[100],
	pSelected
}
new Players[MAX_PLAYERS][e_Player];

hook OnPlayerConnect(playerid)
{
	CreateFullMDC(playerid);
	return 1;
}

//functions
IsCharNumber(i[])
{
	if (i[0] == '9' || i[0] == '8' || i[0] == '7' || i[0] == '6' || i[0] == '5' || i[0] == '4' || i[0] == '3' || i[0] == '2' || i[0] == '1' || i[0] == '0')
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

GetGenderName(number)
{
	new str[8];

	if (!number)
	{
		str = "Male";
	}
	else
	{
		str = "Female";
	}
	
	return str;
}

TrimName(name[])
{
	new pname[MAX_PLAYER_NAME];
	
	for (new i = 0, l = strlen(name); i < l; i++)
	{
		if (name[i] == '_')
		{
			pname[i] = ' ';
		}
		else
		{
			pname[i] = name[i];
		}
	}
	return pname;
}

ShowPlayerTextDraws(playerid, min, max)
{
	for (new i = min; i <= max; i++)
	{
		PlayerTextDrawShow(playerid, Players[playerid][pText][i]);
	}
	return 1;
}

HidePlayerTextDraws(playerid, min, max)
{
	for (new i = min; i <= max; i++)
	{
		PlayerTextDrawHide(playerid, Players[playerid][pText][i]);
	}
	return 1;
}

FetchAdvancedSearch(playerid)
{
	mysql_tquery(g_SQL, MDCQuery[playerid], "OnSearchPlayerAdvance", "i", playerid);
}

CreateFullMDC(playerid)
{
	CreateMDCBackground(playerid);
	CreateMDCBackButton(playerid);
	CreateMDCType_Menu(playerid);
}

HideMDC(playerid)
{
	HidePlayerTextDraws(playerid, 47, 66);
}

ShowMDCBackground(playerid)
{
	PlayerTextDrawShow(playerid, Players[playerid][pText][47]);
	PlayerTextDrawShow(playerid, Players[playerid][pText][48]);
	PlayerTextDrawShow(playerid, Players[playerid][pText][49]);
	return 1;
}

CreateMDCBackground(playerid)
{
	Players[playerid][pText][47] = CreatePlayerTextDraw(playerid, 163, 175, "_");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][47], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][47], 1);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][47], 0.5, 20);
	PlayerTextDrawColor(playerid, Players[playerid][pText][47], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][47], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][47], 1);
	PlayerTextDrawUseBox(playerid, Players[playerid][pText][47], 1);
	PlayerTextDrawBoxColor(playerid, Players[playerid][pText][47], 102);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][47], 476, 0.0);
	
	Players[playerid][pText][48] = CreatePlayerTextDraw(playerid, 163, 175, "_");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][48], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][48], 1);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][48], 0.5, 1.9);
	PlayerTextDrawColor(playerid, Players[playerid][pText][48], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][48], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][48], 1);
	PlayerTextDrawUseBox(playerid, Players[playerid][pText][48], 1);
	PlayerTextDrawBoxColor(playerid, Players[playerid][pText][48], 0x00BFFF88);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][48], 476, 0.0);
	
	Players[playerid][pText][49] = CreatePlayerTextDraw(playerid, 320, 177, "Mobile Data Computer");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][49], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][49], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][49], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][49], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][49], 1);
	PlayerTextDrawAlignment(playerid, Players[playerid][pText][49], 2);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][49], 1);
}

SetMDCHeader(playerid, text[])
{
	PlayerTextDrawSetString(playerid, Players[playerid][pText][49], text);
}

CreateMDCBackButton(playerid)
{
	Players[playerid][pText][50] = CreatePlayerTextDraw(playerid, 170, 176, "~<~");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][50], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][50], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][50], 0.3, 1.5);
	PlayerTextDrawColor(playerid, Players[playerid][pText][50], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][50], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][50], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][50], 185, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][50], 1);
}

ShowMDCBackButton(playerid)
{
	PlayerTextDrawShow(playerid, Players[playerid][pText][50]);
}

/*HideMDCBackButton(playerid)
{
	PlayerTextDrawHide(playerid, Players[playerid][pText][50]);
}*/

CreateMDCType_Menu(playerid)
{
	new Float:a = 180;
	new Float:b = 210;
	new Float:e = 29;
	Players[playerid][pText][51] = CreatePlayerTextDraw(playerid, a, b, "Option 1");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][51], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][51], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][51], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][51], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][51], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][51], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][51], 450, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][51], 1);
	
	b += e;
	Players[playerid][pText][52] = CreatePlayerTextDraw(playerid, a, b, "Option 2");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][52], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][52], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][52], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][52], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][52], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][52], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][52], 450, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][52], 1);
	
	b += e;
	Players[playerid][pText][53] = CreatePlayerTextDraw(playerid, a, b, "Option 3");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][53], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][53], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][53], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][53], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][53], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][53], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][53], 450, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][53], 1);
	
	b += e;
	Players[playerid][pText][54] = CreatePlayerTextDraw(playerid, a, b, "Option 4");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][54], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][54], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][54], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][54], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][54], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][54], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][54], 450, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][54], 1);
	
	b += e;
	Players[playerid][pText][55] = CreatePlayerTextDraw(playerid, a, b, "Option 5");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][55], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][55], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][55], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][55], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][55], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][55], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][55], 450, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][55], 1);

	a = 180;
	b = 210;
	e = 15;
	Players[playerid][pText][56] = CreatePlayerTextDraw(playerid, a, b, "Question One");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][56], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][56], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][56], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][56], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][56], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][56], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][56], a + 150, 10.0);
	
	b += e;
	Players[playerid][pText][57] = CreatePlayerTextDraw(playerid, a, b, "> Answer One");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][57], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][57], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][57], 0.2, 1.0);
	PlayerTextDrawColor(playerid, Players[playerid][pText][57], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][57], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][57], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][57], a + 150, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][57], 1);
	
	a = 180;
	b = 260;
	e = 15;
	Players[playerid][pText][58] = CreatePlayerTextDraw(playerid, a, b, "Question Two");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][58], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][58], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][58], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][58], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][58], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][58], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][58], a + 150, 10.0);
	
	b += e;
	Players[playerid][pText][59] = CreatePlayerTextDraw(playerid, a, b, "> Answer Two");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][59], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][59], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][59], 0.2, 1.0);
	PlayerTextDrawColor(playerid, Players[playerid][pText][59], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][59], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][59], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][59], a + 150, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][59], 1);
	
	a = 180;
	b = 310;
	e = 15;
	Players[playerid][pText][60] = CreatePlayerTextDraw(playerid, a, b, "Question Three");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][60], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][60], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][60], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][60], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][60], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][60], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][60], a + 150, 10.0);
	
	b += e;
	Players[playerid][pText][61] = CreatePlayerTextDraw(playerid, a, b, "> Answer Three");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][61], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][61], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][61], 0.2, 1.0);
	PlayerTextDrawColor(playerid, Players[playerid][pText][61], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][61], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][61], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][61], a + 150, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][61], 1);
	
	a = 365;
	b = 210;
	e = 15;
	Players[playerid][pText][62] = CreatePlayerTextDraw(playerid, a, b, "Side One");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][62], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][62], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][62], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][62], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][62], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][62], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][62], a + 100, 10.0);
	
	b += e;
	Players[playerid][pText][63] = CreatePlayerTextDraw(playerid, a, b, "> Side Answer One");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][63], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][63], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][63], 0.2, 1.0);
	PlayerTextDrawColor(playerid, Players[playerid][pText][63], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][63], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][63], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][63], a + 100, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][63], 1);
	
	a = 365;
	b = 260;
	e = 15;
	Players[playerid][pText][64] = CreatePlayerTextDraw(playerid, a, b, "Side Two");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][64], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][64], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][64], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][64], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][64], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][64], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][64], a + 100, 10.0);
	
	b += e;
	Players[playerid][pText][65] = CreatePlayerTextDraw(playerid, a, b, "> Side Answer Two");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][65], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][65], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][65], 0.2, 1.0);
	PlayerTextDrawColor(playerid, Players[playerid][pText][65], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][65], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][65], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][65], a + 100, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][65], 1);
	
	a = 375;
	b = 325;
	Players[playerid][pText][66] = CreatePlayerTextDraw(playerid, a, b, "Search");
	PlayerTextDrawBackgroundColor(playerid, Players[playerid][pText][66], 255);
	PlayerTextDrawFont(playerid, Players[playerid][pText][66], 2);
	PlayerTextDrawLetterSize(playerid, Players[playerid][pText][66], 0.3, 1.2);
	PlayerTextDrawColor(playerid, Players[playerid][pText][66], -1);
	PlayerTextDrawSetOutline(playerid, Players[playerid][pText][66], 1);
	PlayerTextDrawSetProportional(playerid, Players[playerid][pText][66], 1);
	PlayerTextDrawTextSize(playerid, Players[playerid][pText][66], a + 75, 10.0);
	PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][66], 1);
}

ShowMDCType_Menu(playerid, title[], opt1[], opt2[], opt3[], opt4[], opt5[])
{
	HideMDC(playerid);
	ShowMDCBackground(playerid);
	
	SetMDCHeader(playerid, title);

	if (!isnull(opt1))
	{
		ShowPlayerTextDraws(playerid, 51, 51);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][51], opt1);
	}

	if (!isnull(opt2))
	{
		ShowPlayerTextDraws(playerid, 52, 52);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][52], opt2);
	}

	if (!isnull(opt3))
	{
		ShowPlayerTextDraws(playerid, 53, 53);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][53], opt3);
	}

	if (!isnull(opt4))
	{
		ShowPlayerTextDraws(playerid, 54, 54);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][54], opt4);
	}

	if (!isnull(opt5))
	{
		ShowPlayerTextDraws(playerid, 55, 55);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][55], opt5);
	}

	SelectTextDraw(playerid, 0x00BFFFAA);
	return 1;
}

ShowMDCType_Quest(playerid, title[], quest1[], ans1[], quest2[], ans2[], quest3[], ans3[], sideq1[], sidea1[], sideq2[], sidea2[], button[], selectable = 1)
{
	HideMDC(playerid);
	ShowMDCBackground(playerid);
	
	SetMDCHeader(playerid, title);

	if (!isnull(quest1))
	{
		ShowPlayerTextDraws(playerid, 56, 56);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][56], quest1);
	}

	if (!isnull(ans1))
	{
		PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][57], selectable);
		ShowPlayerTextDraws(playerid, 57, 57);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][57], ans1);
	}

	if (!isnull(quest2))
	{
		ShowPlayerTextDraws(playerid, 58, 58);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][58], quest2);
	}
	
	if (!isnull(ans2))
	{
		PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][59], selectable);
		ShowPlayerTextDraws(playerid, 59, 59);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][59], ans2);
	}
	
	if (!isnull(quest3))
	{
		ShowPlayerTextDraws(playerid, 60, 60);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][60], quest3);
	}
	
	if (!isnull(ans3))
	{
		PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][61], selectable);
		ShowPlayerTextDraws(playerid, 61, 61);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][61], ans3);
	}
	
	if (!isnull(sideq1))
	{
		ShowPlayerTextDraws(playerid, 62, 62);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][62], sideq1);
	}
	
	if (!isnull(sidea1))
	{
		PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][63], selectable);
		ShowPlayerTextDraws(playerid, 63, 63);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][63], sidea1);
	}
	
	if (!isnull(sideq2))
	{
		ShowPlayerTextDraws(playerid, 64, 64);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][64], sideq2);
	}
	
	if (!isnull(sidea2))
	{
		PlayerTextDrawSetSelectable(playerid, Players[playerid][pText][65], selectable);
		ShowPlayerTextDraws(playerid, 65, 65);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][65], sidea2);
	}
	
	if (!isnull(button))
	{
		ShowPlayerTextDraws(playerid, 66, 66);
		PlayerTextDrawSetString(playerid, Players[playerid][pText][66], button);
	}
	
	SelectTextDraw(playerid, 0x00BFFFAA);
	return 1;
}

HandleMDCBack(playerid)
{	switch (MDCProcess[playerid])
	{
		case MDC_SEARCH_CITIZEN, MDC_SEARCH_ADDRESS, MDC_SEARCH_PLATE, MDC_SEARCH_SERIAL:
		{
			StartMDC(playerid);
		}
		case MDC_SEARCH_CITIZEN_SIMP:
		{
			ShowSearchCitizen(playerid);
		}
		case MDC_SEARCH_CITIZEN_ADV:
		{
			ShowSearchCitizen(playerid);
		}
		case MDC_CITIZEN_LINKS_SIMP:
		{
			ShowSearchCitizen(playerid);
		}
		case MDC_CITIZEN_LINKS_ADV:
		{
			FetchAdvancedSearch(playerid);
		}
		case MDC_CITIZEN_SEARCH_LINKS:
		{
			ShowSearchCitizen(playerid);
		}
		case MDC_CITIZEN_INFO_SIMP, MDC_CITIZEN_LICS_SIMP, MDC_CITIZEN_PHONE_SIMP, MDC_CITIZEN_PROP_SIMP, MDC_CITIZEN_VEH_SIMP:
		{
			MDCProcess[playerid] = MDC_CITIZEN_LINKS_SIMP;
			ShowMDCType_Menu(playerid, "Simple Search Links", "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
			ShowMDCBackButton(playerid);
		}
		case MDC_CITIZEN_INFO_ADV, MDC_CITIZEN_LICS_ADV, MDC_CITIZEN_PHONE_ADV, MDC_CITIZEN_PROP_ADV, MDC_CITIZEN_VEH_ADV:
		{
			MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;
			ShowMDCType_Menu(playerid, "Advanced Search Links", "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
			ShowMDCBackButton(playerid);
		}
	}
}

HandleButtonPush(playerid)
{
	switch (MDCProcess[playerid])
	{
		case MDC_SEARCH_CITIZEN_SIMP:
		{
			if (isnull(MDCSearch_Fullname[playerid]))
			{
				SendErrorMessage(playerid, "You haven't typed in any name yet.");
				return 1;
			}
			else
			{
				new pid = GetPlayeridByName(MDCSearch_Fullname[playerid]);
				if (pid == INVALID_PLAYER_ID || !Player[pid][IsLoggedIn])
				{
					new query[256];
					mysql_format(g_SQL, query, sizeof(query), "SELECT CharacterID, Name FROM characters WHERE Name = '%e'", MDCSearch_Fullname[playerid]);
					mysql_tquery(g_SQL, query, "OnSearchPlayerSimple", "i", playerid);
				}
				else
				{
					MDCSearch_HolderID[playerid] = Player[pid][ID];
				
					new title[64];
					format(title, sizeof(title), "Citizen Search - %s", GetUserName(pid));
					
					MDCProcess[playerid] = MDC_CITIZEN_LINKS_SIMP;
					ShowMDCType_Menu(playerid, title, "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
					ShowMDCBackButton(playerid);
				}
				return 1;
			}
		}
		case MDC_SEARCH_CITIZEN_ADV:
		{
			if (isnull(MDCSearch_Fullname[playerid]) && !MDCSearch_Phone[playerid])
			{
				SendErrorMessage(playerid, "Too big selection, put at least either a name or phone number.");
			}
			
			if (!MDCSearch_Phone[playerid])
			{
				new where[256];
				format(where, sizeof(where), "Name LIKE '%%%s%%'", MDCSearch_Fullname[playerid]);
				
				if (MDCSearch_Bloodtype[playerid] != 0)
				{
					format(where, sizeof(where), "%s AND BloodType = %i", where, MDCSearch_Bloodtype[playerid]);
				}
				
				if (MDCSearch_Gender[playerid] != 2)
				{
					format(where, sizeof(where), "%s AND Gender = %i", where, MDCSearch_Gender[playerid]);
				}
				
				new startnumber[5], endnumber[5], bool:next = false, bool:foundone = false, lastsign = 0, finished = 0;
				for (new i = 0; i < strlen(MDCSearch_Age[playerid]); i++)
				{
					if (IsCharNumber(MDCSearch_Age[playerid][i]))
					{
						if (next)
						{
							format(endnumber, sizeof(endnumber), "%s%c", endnumber, MDCSearch_Age[playerid][i]);
						}
						else
						{
							format(startnumber, sizeof(startnumber), "%s%c", startnumber, MDCSearch_Age[playerid][i]);
						}
					}
					else if (MDCSearch_Age[playerid][i] == ',')
					{
						lastsign = 1;
						next = true;
					}
					else if (MDCSearch_Age[playerid][i] == '-')
					{
						lastsign = 2;
						next = true;
					}
					
					if (MDCSearch_Age[playerid][i] == '\0' || MDCSearch_Age[playerid][i] == ' ' || strlen(MDCSearch_Age[playerid]) - 1 == i)
					{
						finished = 1;
					}
					
					if (finished)
					{
						new startyear, endyear;
						
						new year, month, day;
						getdate(year, month, day);
						if (lastsign == 0)
						{
							if (!foundone)
							{
								startyear = year - strval(startnumber);
								format(where, sizeof(where), "%s AND (Year = %i", where, startyear);
							}
							else
							{
								startyear = year - strval(startnumber);
								format(where, sizeof(where), "%s OR Year = %i", where, startyear);
							}
						}
						else if (lastsign == 1)
						{
							if (!foundone)
							{
								startyear = year - strval(startnumber);
								endyear = year - strval(endnumber);
								format(where, sizeof(where), "%s AND (Year = %i OR Year = %i", where, startyear, endyear);
							}
							else
							{
								startyear = year - strval(startnumber);
								endyear = year - strval(endnumber);
								format(where, sizeof(where), "%s OR Year = %i OR Year = %i", where, startyear, endyear);
							}
						}
						else if (lastsign == 2)
						{
							if (!foundone)
							{
								startyear = year - strval(startnumber);
								endyear = year - strval(endnumber);
								format(where, sizeof(where), "%s AND ((Year <= %i AND Year >= %i)", where, startyear, endyear);
							}
							else
							{
								startyear = year - strval(startnumber);
								endyear = year - strval(endnumber);
								format(where, sizeof(where), "%s OR (Year <= %i AND Year >= %i)", where, startyear, endyear);
							}
						}
						
						format(startnumber, sizeof(startnumber), "");
						format(endnumber, sizeof(endnumber), "");
						next = false;
						lastsign = 0;
						foundone = true;
						finished = 0;
					}
				}
				
				if (foundone)
				{
					format(where, sizeof(where), "%s)", where);
				}
				
				mysql_format(g_SQL, MDCQuery[playerid], 1024, "SELECT CharacterID, Name FROM characters WHERE '%e'", where);
				
				FetchAdvancedSearch(playerid);
			}
			else
			{
				SendErrorMessage(playerid, "No such phone found.");
				/*new query[512];
				format(query, sizeof(query), "SELECT * FROM h_phonenumbers WHERE Number = %i", MDCSearch_Phone[playerid]);
				printf("number 1: %i", MDCSearch_Phone[playerid]);
				mysql_tquery(g_SQL, query, "OnAdvancedPhone", "i", playerid);*/
			}
		}
		case MDC_SEARCH_PLATE:
		{
			if (!strcmp(MDCSearch_Any[playerid], "N/A") || isnull(MDCSearch_Any[playerid]))
			{
				return SendErrorMessage(playerid, "That is invalid input.");
			}
			
			new id = -1;
			for (new i = 0; i < MAX_DYN_VEH; i++)
			{
				if (VehicleInfo[i][vID] && !strcmp(MDCSearch_Any[playerid], VehicleInfo[i][vPlates]))
				{
					id = i;
					break;
				}
			}
			
			if (id == -1)
			{
				return SendErrorMessage(playerid, "No vehicles with that plate found.");
			}
			
			if (VehicleInfo[id][vOwnerID])
			{
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "SELECT Name FROM characters WHERE CharacterID = %i", VehicleInfo[id][vOwnerID]);
				mysql_tquery(g_SQL, query, "OnPlateSearchOwner", "ii", playerid, id);
			}
			else
			{
				ShowMDCType_Quest(playerid, "Plate Information", "Plate:", VehicleInfo[id][vPlates], "Model:", ReturnVehicleModelName(VehicleInfo[id][vModel]), "Owner:", "None/Company", "Alarm:", (VehicleInfo[id][vAlarm] ? "Yes" : "No"), "", "", "", 0);
				ShowMDCBackButton(playerid);
			}
		}
		case MDC_SEARCH_ADDRESS:
		{
			if (!strcmp(MDCSearch_Any[playerid], "N/A") || isnull(MDCSearch_Any[playerid]))
			{
				return SendErrorMessage(playerid, "That is invalid input.");
			}
			
			new id = -1;
			for (new i = 0; i < MAX_HOUSES; i++)
			{
				if (HouseInfo[i][HouseID] && !strcmp(MDCSearch_Any[playerid], HouseInfo[i][HouseAddress]))
				{
					id = i;
					break;
				}
			}
			
			if (id == -1)
			{
				return SendErrorMessage(playerid, "No property with that address was found.");
			}
			
			if (HouseInfo[id][HouseOwnerID])
			{
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "SELECT Name FROM characters WHERE CharacterID = %i", HouseInfo[id][HouseOwnerID]);
				mysql_tquery(g_SQL, query, "OnAddressSearchOwner", "ii", playerid, id);
			}
			else
			{
				new zone[128];
				GetLocation(HouseInfo[id][HouseExteriorX], HouseInfo[id][HouseExteriorY], HouseInfo[id][HouseExteriorZ], zone, sizeof zone);

				ShowMDCType_Quest(playerid, "Property Information", "Address:", HouseInfo[id][HouseAddress], "Owner:", "No one", "Location:", zone, "", "", "", "", "", 0);
				ShowMDCBackButton(playerid);
			}
		}
		case MDC_SEARCH_SERIAL:
		{
			if (!strcmp(MDCSearch_Any[playerid], "N/A") || isnull(MDCSearch_Any[playerid]))
			{
				return SendErrorMessage(playerid, "That is invalid input.");
			}
			
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM WeaponRegistry WHERE Serial = '%e'", MDCSearch_Any[playerid]);
			mysql_tquery(g_SQL, query, "OnSerialSearch", "i", playerid);
		}
		case MDC_CHARGE_MENU, MDC_TICKET_MENU:
		{
			ShowRecordMenu(playerid);
		}
	}
	
	return 1;
}

StartMDC(playerid)
{
	format(MDCSearch_Any[playerid], 128, "N/A");

	MDCProcess[playerid] = MDC_MAIN_MENU;
	return ShowMDCType_Menu(playerid, "Mobile Data Computer", "Search citizen", "Search plate", "Search address", "Search serial number", "Search Records");
}

ShowSearchCitizen(playerid)
{
	MDCProcess[playerid] = MDC_SEARCH_CITIZEN;
	ShowMDCType_Menu(playerid, "Search Citizen", "Simple search", "Advanced search", "", "", "");
	
	ShowMDCBackButton(playerid);
}

ShowSearchCitizen_Simp(playerid)
{
	format(MDCSearch_Fullname[playerid], MAX_PLAYER_NAME, "");
	MDCProcess[playerid] = MDC_SEARCH_CITIZEN_SIMP;
	ShowMDCType_Quest(playerid, "Search Citizen - Simple", "Full name:", "> Forename Surname", "", "", "", "", "", "", "", "", "Search");
	
	ShowMDCBackButton(playerid);
}

ShowSearchCitizen_Adv(playerid)
{
	format(MDCSearch_Fullname[playerid], MAX_PLAYER_NAME, "");
	format(MDCSearch_Age[playerid], 32, "10-100");
	
	MDCSearch_Phone[playerid] = 0;
	MDCSearch_Bloodtype[playerid] = 0;
	MDCSearch_Gender[playerid] = 2; // both
	
	MDCProcess[playerid] = MDC_SEARCH_CITIZEN_ADV;
	ShowAdvancedSearch(playerid);
	
	//ShowMDCBackButton(playerid); - is written in ShowAdvancedSearch()
}

ShowAdvancedSearch(playerid)
{
	new display1[32], display2[32], display3[32], display4[32], display5[32];
	
	if (isnull(MDCSearch_Fullname[playerid]))
	{
		format(display1, sizeof(display1), "> A few letters...");
	}
	else
	{
		format(display1, sizeof(display1), "> %s", TrimName(MDCSearch_Fullname[playerid]));
	}
	
	if (!MDCSearch_Phone[playerid])
	{
		format(display2, sizeof(display2), "> N/A");
	}
	else
	{
		format(display2, sizeof(display2), "> %i", MDCSearch_Phone[playerid]);
	}
	
	format(display3, sizeof(display3), "> Unavailable");
	
	if (MDCSearch_Gender[playerid] == 2)
	{
		format(display4, sizeof(display4), "> Both");
	}
	else
	{
		format(display4, sizeof(display4), "> %s", GetGenderName(MDCSearch_Gender[playerid]));
	}
	
	format(display5, sizeof(display5), "> %s", MDCSearch_Age[playerid]);
	
	ShowMDCType_Quest(playerid, "Search Citizen - Advanced", "Name:", display1, "Phone:", display2, "Blood type:", display3, "Gender:", display4, "Age:", display5, "Search");
	
	ShowMDCBackButton(playerid);
}

ViewCitizenPhones(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT * FROM characters WHERE OwnerID = %i", MDCSearch_HolderID[playerid]);
	mysql_tquery(g_SQL, query, "OnViewCitizenPhones", "i", playerid);
}

ViewCitizenProperties(playerid)
{
	new cID = MDCSearch_HolderID[playerid];
	
	new list[2048] = "{DEDEDE}Address\t{DEDEDE}Type";
	for (new i = 0; i < MAX_HOUSES; i++)
	{
		if (HouseInfo[i][HouseID] && HouseInfo[i][HouseOwnerID] == cID)
		{
			format(list, sizeof(list), "%s\n%s\tHouse", list, HouseInfo[i][HouseAddress]);
		}
	}

	Dialog_Show(playerid, CitizenProperties, DIALOG_STYLE_TABLIST_HEADERS, "Property List", list, "View", "Back");
}

ViewCitizenVehicles(playerid)
{
	new cID = MDCSearch_HolderID[playerid];
	
	new list[2048] = "{DEDEDE}Model\t{DEDEDE}Plate";
	for (new i = 0; i < MAX_DYN_VEH; i++)
	{
		if (VehicleInfo[i][vID] && VehicleInfo[i][vOwnerID] == cID)
		{
			format(list, sizeof(list), "%s\n%s\t%s", list, ReturnVehicleModelName(VehicleInfo[i][vModel]), VehicleInfo[i][vPlates]);
		}
	}

	Dialog_Show(playerid, NonExistant, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle List", list, "Back", "");
}

ViewCitizenInfo(playerid)
{
	new cID = 0;
	if (MDCProcess[playerid] == MDC_CITIZEN_LINKS_SIMP)
	{
		cID = MDCSearch_HolderID[playerid];
		MDCProcess[playerid] = MDC_CITIZEN_INFO_SIMP;
	}
	else if (MDCProcess[playerid] == MDC_CITIZEN_LINKS_ADV)
	{
		cID = MDCSearch_HolderID[playerid];
		MDCProcess[playerid] = MDC_CITIZEN_INFO_ADV;
	}
	
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT Name FROM characters WHERE CharacterID = %i", cID);
	mysql_tquery(g_SQL, query, "OnSearchPlayerName", "i", playerid);

	new pid = INVALID_PLAYER_ID;
	foreach (new i : Player)
	{
		if (Player[i][IsLoggedIn] && Player[i][ID] == cID)
		{
			pid = i;
			break;
		}
	}

	if (pid == INVALID_PLAYER_ID)
	{
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM characters WHERE CharacterID = %i", cID);
		mysql_tquery(g_SQL, query, "OnFindCitizenInfo", "i", playerid);
	}
	else
	{
		new gender[15];

		if (PlayerInfo[pid][pGender])
		{
			format(gender, sizeof(gender), "Female");
		}
		else
		{
			format(gender, sizeof(gender), "Male");
		}

		new pname[MAX_PLAYER_NAME];
		format(pname, sizeof(pname), "%s", GetUserName(pid));

		ShowMDCType_Quest(playerid, "Citizen Information", "Full name:", pname, "Gender:", gender, "", "", "", "", "", "", "", 0);
		ShowMDCBackButton(playerid);
	}
}

ViewCitizenLicenses(playerid)
{
	new cID = 0;
	if (MDCProcess[playerid] == MDC_CITIZEN_LINKS_SIMP)
	{
		cID = MDCSearch_HolderID[playerid];
		MDCProcess[playerid] = MDC_CITIZEN_LICS_SIMP;
	}
	else if (MDCProcess[playerid] == MDC_CITIZEN_LINKS_ADV)
	{
		cID = MDCSearch_HolderID[playerid];
		MDCProcess[playerid] = MDC_CITIZEN_LICS_ADV;
	}
	
	new query[128];
	format(query, sizeof(query), "SELECT Name FROM characters WHERE CharacterID = %i", cID);
	mysql_tquery(g_SQL, query, "OnSearchPlayerName", "i", playerid);

	new pid = INVALID_PLAYER_ID;
	foreach (new i : Player)
	{
		if (Player[i][IsLoggedIn] && Player[i][ID] == cID)
		{
			pid = i;
			break;
		}
	}

	if (pid == INVALID_PLAYER_ID)
	{
		format(query, sizeof(query), "SELECT * FROM characters WHERE CharacterID = %i", cID);
		mysql_tquery(g_SQL, query, "OnFindCitizenLics", "i", playerid);
	}
	else
	{
		new drivelic[5], weplic[5], flylic[5];

		if (GetInventory(pid, INV_DRV_LIC) == 1)
		{
			drivelic = "Yes";
		}
		else
		{
			drivelic = "No";
		}

		if (GetInventory(pid, INV_WEP_LIC) == 1)
		{
			weplic = "Yes";
		}
		else
		{
			weplic = "No";
		}

		if (PlayerInfo[pid][pFlyingLicense])
		{
			flylic = "Yes";
		}
		else
		{
			flylic = "No";
		}

		ShowMDCType_Quest(playerid, "Licenses & Certificates", "Driving:", drivelic, "Weapon:", weplic, "Flying:", flylic, "", "", "", "", "", 0);
		ShowMDCBackButton(playerid);
	}
}

ShowSearchPlate(playerid)
{
	new a1[128];
	format(a1, sizeof(a1), "> %s", MDCSearch_Any[playerid]);
	
	MDCProcess[playerid] = MDC_SEARCH_PLATE;
	ShowMDCType_Quest(playerid, "Search Plate", "Input plate:", a1, "", "", "", "", "", "", "", "", "Search");
	ShowMDCBackButton(playerid);
}

ShowSearchAddress(playerid)
{
	new a1[128];
	format(a1, sizeof(a1), "> %s", MDCSearch_Any[playerid]);
	
	MDCProcess[playerid] = MDC_SEARCH_ADDRESS;
	ShowMDCType_Quest(playerid, "Search Address", "Address:", a1, "", "", "", "", "", "", "", "", "Search");
	ShowMDCBackButton(playerid);
}

ShowSearchSerial(playerid)
{
	new a1[128];
	format(a1, sizeof(a1), "> %s", MDCSearch_Any[playerid]);
	
	MDCProcess[playerid] = MDC_SEARCH_SERIAL;
	ShowMDCType_Quest(playerid, "Search Serial Number", "Input serial:", a1, "", "", "", "", "", "", "", "", "Search");
	ShowMDCBackButton(playerid);
}

ShowRecordMenu(playerid)
{
	MDCProcess[playerid] = MDC_RECORD_MENU;
	ShowMDCType_Menu(playerid, "Record Links", "Charges", "Tickets", "", "", "");
	ShowMDCBackButton(playerid);
}

ShowChargeMenu(playerid)
{
	MDCProcess[playerid] = MDC_CHARGE_MENU;
	ShowMDCType_Menu(playerid, "Charges", "Insert Charges", "Charge History", "", "", "");
	ShowMDCBackButton(playerid);
}

ShowTicketMenu(playerid)
{
	MDCProcess[playerid] = MDC_TICKET_MENU;
	ShowMDCType_Menu(playerid, "Tickets", "Search Citizen - Active", "Search Citizen - All", "", "", "");
	ShowMDCBackButton(playerid);
}

SubmitCharges(playerid)
{
	for (new i = 0; i < MAX_CHARGES; i++)
	{
		if (Charges[playerid][i][cExists])
		{
			AddChargeEx(playerid, ChargeSuspect[playerid], Charges[playerid][i][cDescription]);

			// Clearing information
			Charges[playerid][i][cExists] = 0;
			format(Charges[playerid][i][cDescription], 128, "");
		}
	}
	return 1;
}

ShowChargeList(playerid)
{
	new msg[2048];
	format(msg, sizeof(msg), "{FFDD00}Add new charge...\n{FFDD00}Submit charges...{FFFFFF}");

	ChargeCounter[playerid] = 0;
	for (new i = 0; i < MAX_CHARGES; i++)
	{
		if (Charges[playerid][i][cExists])
		{
			format(msg, sizeof(msg), "%s\n%s", msg, Charges[playerid][i][cDescription]);
			ChargeHolder[playerid][ChargeCounter[playerid]] = i;
			ChargeCounter[playerid]++;
		}
	}

	new title[52];
	format(title, sizeof(title), "Charges - %s", ChargeSuspect[playerid]);
	Dialog_Show(playerid, ChargeList, DIALOG_STYLE_LIST, title, msg, "Select", "Cancel");
	return 1;
}

//forwards
forward OnFindCitizenLics(playerid);
public OnFindCitizenLics(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "No such citizen found in the database.");
	}

	new iDrivingLicense, iWeaponLicense, iFlyingLicense;
	new generalic[5], weaponlic[5], flyinglic[5];
	cache_get_value_int(0, "DrivingLicense", iDrivingLicense);
	cache_get_value_int(0, "WeaponLicense", iWeaponLicense);
	cache_get_value_int(0, "FlyingLicense", iFlyingLicense);
	
	if (iDrivingLicense)
	{
		generalic = "Yes";
	}
	else
	{
		generalic = "No";
	}

	if (iWeaponLicense)
	{
		weaponlic = "Yes";
	}
	else
	{
		weaponlic = "No";
	}

	if (iFlyingLicense)
	{
		flyinglic = "Yes";
	}
	else
	{
		flyinglic = "No";
	}

	ShowMDCType_Quest(playerid, "Licenses & Certificates", "General:", generalic, "Weapon:", weaponlic, "Flying:", flyinglic, "", "", "", "", "", 0);
	ShowMDCBackButton(playerid);
	return 1;
}

forward PrintTicketRecords(playerid);
public PrintTicketRecords(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0) 
	{
		return SendErrorMessage(playerid, "No such ticket found.");
	}
	
	new reason[128], iAmount, iOfficerID, timestamp;
	cache_get_value(0, "Reason", reason, sizeof reason);
	cache_get_value_int(0, "Amount", iAmount);
	cache_get_value_int(0, "OfficerID", iOfficerID);
	cache_get_value_int(0, "Timestamp", timestamp);
	
	SendClientMessageEx(playerid, COLOR_WHITE, "___________________________________________________________");
	SendClientMessageEx(playerid, COLOR_GREY, "Issuer: %s", GetDatabaseName(iOfficerID));
	SendClientMessageEx(playerid, COLOR_GREY, "Amount: $%s", FormatNumber(iAmount));
	SendClientMessageEx(playerid, COLOR_GREY, "Date: %s", date(timestamp));
	SendClientMessageEx(playerid, COLOR_GREY, " ");
	if(strlen(reason) > 70)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: %.70s ...", reason);
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: ... %s", reason[70]);
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "Reason: %s", reason);
	SendClientMessageEx(playerid, COLOR_WHITE, "___________________________________________________________");
	return 1;
}

forward TicketRecords(playerid);
public TicketRecords(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		return SendErrorMessage(playerid, "No active tickets found.");
	}
	else
	{
		new list[2048];
		new reason[256];
		new counter = 0;
		for (new i = 0; i < rows; i++)
		{
			cache_get_value(i, "Reason", reason, sizeof reason);
			format(list, sizeof(list), "%s\n%s", list, reason);
			cache_get_value_int(i, "ID", gActiveTickets[playerid][counter]);
			
			counter++;
			if (counter > 25)
			{
				SendErrorMessage(playerid, "Player has over 25 tickets in their record.");
				break;
			}
		}
		Dialog_Show(playerid, TicketRecords, DIALOG_STYLE_LIST, "Ticket Records", list, "Print", "Back");
	}
	return 1;
}

forward PrintActiveTicket(playerid);
public PrintActiveTicket(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0) 
	{
		return SendErrorMessage(playerid, "No such ticket found.");
	}
	
	new reason[128], iAmount, iOfficerID, timestamp;
	cache_get_value(0, "Reason", reason, sizeof reason);
	cache_get_value_int(0, "Amount", iAmount);
	cache_get_value_int(0, "OfficerID", iOfficerID);
	cache_get_value_int(0, "Timestamp", timestamp);
	
	SendClientMessageEx(playerid, COLOR_WHITE, "___________________________________________________________");
	SendClientMessageEx(playerid, COLOR_GREY, "Issuer: %s", GetDatabaseName(iOfficerID));
	SendClientMessageEx(playerid, COLOR_GREY, "Amount: $%s", FormatNumber(iAmount));
	SendClientMessageEx(playerid, COLOR_GREY, "Date: %s", date(timestamp));
	SendClientMessageEx(playerid, COLOR_GREY, " ");
	if(strlen(reason) > 70)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: %.70s ...", reason);
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: ... %s", reason[70]);
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "Reason: %s", reason);
	SendClientMessageEx(playerid, COLOR_WHITE, "___________________________________________________________");
	return 1;
}

forward ActiveTickets(playerid);
public ActiveTickets(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		return SendErrorMessage(playerid, "No active tickets found.");
	}
	else
	{
		new list[2048];
		new reason[256];
		new counter = 0;
		for (new i = 0; i < rows; i++)
		{
			cache_get_value(i, "Reason", reason, sizeof reason);
			format(list, sizeof(list), "%s\n%s", list, reason);
			cache_get_value_int(i, "ID", gActiveTickets[playerid][counter]);
			
			counter++;
			if (counter > 25)
			{
				SendErrorMessage(playerid, "Player has over 25 active tickets.");
				break;
			}
		}
		Dialog_Show(playerid, ActiveTickets, DIALOG_STYLE_LIST, "Active Tickets", list, "Print", "Back");
	}
	return 1;
}

forward CitizenRecords(playerid);
public CitizenRecords(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		SendErrorMessage(playerid, "No charges were found for citizen.");
		return Dialog_Show(playerid, ChargeHistory, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you would like to see charge logs of ((input full name)).", "Search", "Cancel");
	}
	
	new reason[128], list[1024], cID, iActive, activeStr[5];
	format(list, sizeof(list), "Charge\t\tActive", list, reason);
	for (new i = 0; i < rows; i++)
	{
		cache_get_value(i, "Charge", reason, sizeof reason);
		cache_get_value_int(i, "ID", cID);
		gActiveTickets[playerid][i] = cID;
		cache_get_value_int(i, "Active", iActive);
		if(iActive)
		{
			activeStr = "Yes";
		}
		else activeStr = "No";
		format(list, sizeof(list), "%s\n%s\t\t%s", list, reason, activeStr);
	}
	Dialog_Show(playerid, CitizenRecordsD, DIALOG_STYLE_TABLIST_HEADERS, "Charge Records", list, "Print", "Back");
	
	return 1;
}

forward PrintPlayerCharge(playerid);
public PrintPlayerCharge(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		SendErrorMessage(playerid, "This charge was not found.");
		return Dialog_Show(playerid, ChargeHistory, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you would like to see charge logs of ((input full name)).", "Search", "Cancel");
	}
	
	new charName[MAX_PLAYER_NAME+1], reason[128], iOfficerID, timestamp;
	cache_get_value(0, "CharacterName", charName, sizeof charName);
	cache_get_value(0, "Charge", reason, sizeof reason);
	cache_get_value_int(0, "OfficerID", iOfficerID);
	cache_get_value_int(0, "Timestamp", timestamp);
	
	SendClientMessageEx(playerid, COLOR_GREEN, "___________________________________________________________");
	SendClientMessageEx(playerid, COLOR_GREY, "Reporter: %s", GetDatabaseName(iOfficerID));
	SendClientMessageEx(playerid, COLOR_GREY, "Suspect: %s", charName);
	SendClientMessageEx(playerid, COLOR_GREY, "Date: %s", date(timestamp));
	SendClientMessageEx(playerid, COLOR_GREY, "");
	if(strlen(reason) > 70)
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: %.70s ...", reason);
		SendClientMessageEx(playerid, COLOR_GREY, "Reason: ... %s", reason[70]);
	}
	else SendClientMessageEx(playerid, COLOR_GREY, "Reason: %s", reason);
	SendClientMessageEx(playerid, COLOR_GREEN, "___________________________________________________________");
	
	return 1;
}

forward OnChargeName(playerid);
public OnChargeName(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		return Dialog_Show(playerid, ChargesName, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you are placing charges upon ((full name)).\n\n{FF0000}Warning! Name must be correct.", "Submit", "Cancel");
	}

	cache_get_value(0, "Name", ChargeSuspect[playerid], MAX_PLAYER_NAME);

	ShowChargeList(playerid);
	return 1;
}

forward OnSearchPlayerName(playerid);
public OnSearchPlayerName(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return 0;
	}

	new pname[MAX_PLAYER_NAME];
	cache_get_value(0, "Name", pname, MAX_PLAYER_NAME);
	
	new query[128];
	format(query, sizeof(query), "SELECT ID FROM h_bolopersons WHERE suspect = '%q'", pname);
	mysql_tquery(g_SQL, query, "OnSearchSuspectName", "is", playerid, pname);
	return 1;
}

forward OnSearchSuspectName(playerid, pname[]);
public OnSearchSuspectName(playerid, pname[])
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return 0;
	}
	
	if (rows == 1)
	{
		SendServerMessage(playerid, "Citizen lookup resulted in %i BOLO on %s, please visit the BOLO page to view more information ((/apb)).", rows, TrimName(pname));
	}
	else
	{
		SendServerMessage(playerid, "Citizen lookup resulted in %i BOLO's on %s, please visit the BOLO page to view more information ((/apb)).", rows, TrimName(pname));
	}
	return 1;
}

forward OnSerialSearch(playerid);
public OnSerialSearch(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "No firearm with that serial number exists.");
	}
	
	new serial[128], info[128], purchasedate[32], pname[MAX_PLAYER_NAME], wepname[32];
	
	cache_get_value(0, "Player", pname, sizeof pname);
	cache_get_value(0, "Info", info, sizeof info);
	cache_get_value(0, "Serial", serial, sizeof serial);
	cache_get_value(0, "WeaponName", wepname, sizeof wepname);
	cache_get_value(0, "Date", purchasedate, sizeof purchasedate);
	
	ShowMDCType_Quest(playerid, "Serial Number Search", "Information:", info, "Owner:", TrimName(pname), "Type:", wepname, "Serial:", serial, "Date:", purchasedate, "", 0);
	ShowMDCBackButton(playerid);
	return 1;
}

forward OnAddressSearchOwner(playerid, cid);
public OnAddressSearchOwner(playerid, cid)
{
	new pname[MAX_PLAYER_NAME];
	cache_get_value(0, "Name", pname, MAX_PLAYER_NAME);
	format(pname, sizeof(pname), "%s", TrimName(pname));
	
	new zone[128];
	GetLocation(HouseInfo[cid][HouseExteriorX], HouseInfo[cid][HouseExteriorY], HouseInfo[cid][HouseExteriorZ], zone, sizeof zone);
	ShowMDCType_Quest(playerid, "Property Information", "Address:", HouseInfo[cid][HouseAddress], "Owner:", pname, "Location:", zone, "", "", "", "", "", 0);
	ShowMDCBackButton(playerid);
	return 1;
}

forward OnPlateSearchOwner(playerid, vehicle);
public OnPlateSearchOwner(playerid, vehicle)
{
	new pname[MAX_PLAYER_NAME];
	cache_get_value(0, "Name", pname, MAX_PLAYER_NAME);
	format(pname, sizeof(pname), "%s", TrimName(pname));
	
	ShowMDCType_Quest(playerid, "Plate Information", "Plate:", VehicleInfo[vehicle][vPlates], "Model:", ReturnVehicleModelName(VehicleInfo[vehicle][vModel]), "Owner:", pname, "Alarm:", (VehicleInfo[vehicle][vAlarm] ? "Yes" : "No"), "", "", "", 0);
	ShowMDCBackButton(playerid);
	return 1;
}

forward OnFindCitizenInfo(playerid);
public OnFindCitizenInfo(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "This citizen does no longer exist.");
	}

	new born[7], origin[32], gender[15], iGender, name[MAX_PLAYER_NAME];//, bloodtype[5];

	cache_get_value_int(0, "Gender", iGender);

	format(born, sizeof(born), "Unknown");

	if (iGender)
	{
		format(gender, sizeof(gender), "Female");
	}
	else
	{
		format(gender, sizeof(gender), "Male");
	}

	cache_get_value(0, "Name", name, MAX_PLAYER_NAME);
	cache_get_value(0, "Origin", origin, 32);

	new pname[MAX_PLAYER_NAME];
	format(pname, sizeof(pname), "%s", TrimName(name));

	ShowMDCType_Quest(playerid, "Citizen Information", "Full name:", pname, "Origin", origin, "Gender", gender, "Born", born, "", "", "", 0);
	ShowMDCBackButton(playerid);
	return 1;
}

forward OnSearchPlayerAdvance(playerid);
public OnSearchPlayerAdvance(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "No matches were found in the database!");
	}
	if (rows > 5)
	{
		return SendErrorMessage(playerid, "Too many matches, make select more specific.");
	}
	
	new name[MAX_PLAYER_NAME];
	new opt1[64], opt2[64], opt3[64], opt4[64], opt5[64];
	for (new i = 0; i < rows; i++)
	{
		cache_get_value(i, "Name", name, sizeof name);
		cache_get_value_int(i, "ID", MDCQueryID[playerid][i]);
		switch (i)
		{
			case 0:
			{
				format(opt1, sizeof(opt1), "View %s", TrimName(name));
			}
			case 1:
			{
				format(opt2, sizeof(opt2), "View %s", TrimName(name));
			}
			case 2:
			{
				format(opt3, sizeof(opt3), "View %s", TrimName(name));
			}
			case 3:
			{
				format(opt4, sizeof(opt4), "View %s", TrimName(name));
			}
			case 4:
			{
				format(opt5, sizeof(opt5), "View %s", TrimName(name));
			}
		}
	}
	
	MDCProcess[playerid] = MDC_CITIZEN_SEARCH_LINKS;
	ShowMDCType_Menu(playerid, "Advanced Search Result", opt1, opt2, opt3, opt4, opt5);
	ShowMDCBackButton(playerid);
	return 1;
}

/*forward OnAdvancedPhone(playerid);
public OnAdvancedPhone(playerid)
{
	if (!cache_get_row_count())
	{
		return SendErrorMessage(playerid, "No such phone number was registered.");
	}
	
	cache_get_value_int(i, "Number", number);
	cache_get_value_int(i, "OwnerID", ownerid);
	
	printf("number: %i | ownerid = %i", number, ownerid);
	
	if (!ownerid)
	{
		for (new i = 0; i < sizeof(Payphones); i++)
		{
			if (Payphones[i][ppExists] && Payphones[i][ppNumber] == number)
			{
				new title[16];
				format(title, sizeof(title), "Payphone: %i", number);
				
				new numberStr[32];
				format(numberStr, sizeof(numberStr), "%i", number);
				ShowMDCType_Quest(playerid, title, "Type:", "Payphone", "Number:", numberStr, "Location:", ReturnLocationEx(Payphones[i][ppX], Payphones[i][ppY], Payphones[i][ppZ]), "", "", "", "", "", 0);
				ShowMDCBackButton(playerid);
				return 1;
			}
		}
		
		SendErrorMessage(playerid, "Something went wrong, this payphone does not exist.");
		return 1;
	}
	else
	{
		foreach (new i : Player)
		{
			if (Player[i][IsLoggedIn] && Players[i][ID] == ownerid)
			{
				MDCSearch_HolderID[playerid] = ownerid;
				
				new title[64];
				format(title, sizeof(title), "Citizen Search - %s", GetUserName(i));
				
				MDCProcess[playerid] = MDC_CITIZEN_LINKS_SIMP;
				ShowMDCType_Menu(playerid, title, "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
				ShowMDCBackButton(playerid);
				return 1;
			}
		}
		
		new query[128];
		format(query, sizeof(query), "SELECT ID, Name FROM h_players WHERE ID = %i", ownerid);
		mysql_tquery(g_SQL, query, "OnAdvancedPlayerPhone", "i", playerid);
		return 1;
	}
}*/

forward OnAdvancedPlayerPhone(playerid);
public OnAdvancedPlayerPhone(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "No such citizen was found with that phone number.");
	}
	
	cache_get_value_int(0, "ID", MDCSearch_HolderID[playerid]);
	new name[MAX_PLAYER_NAME];
	cache_get_value(0, "Name", name, sizeof name);
	
	new title[64];
	format(title, sizeof(title), "Citizen Search - %s", TrimName(name));
	
	MDCProcess[playerid] = MDC_CITIZEN_LINKS_SIMP;
	ShowMDCType_Menu(playerid, title, "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
	ShowMDCBackButton(playerid);
	return 1;
}

forward OnSearchPlayerSimple(playerid);
public OnSearchPlayerSimple(playerid)
{
	new rows; cache_get_row_count(rows);
	if (!rows)
	{
		return SendErrorMessage(playerid, "You such name found in the registry.");
	}
	
	cache_get_value_int(0, "ID", MDCSearch_HolderID[playerid]);
	new name[MAX_PLAYER_NAME];
	cache_get_value(0, "Name", name, MAX_PLAYER_NAME);
	
	new title[64];
	format(title, sizeof(title), "Citizen Search - %s", TrimName(name));
	
	MDCProcess[playerid] = MDC_CITIZEN_LINKS_SIMP;
	ShowMDCType_Menu(playerid, title, "View Information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
	ShowMDCBackButton(playerid);
	return 1;
}

//dialogs
Dialog:TicketActive(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new query[128];
		format(query, sizeof(query), "SELECT `Name` FROM characters WHERE Name = '%e' LIMIT 1", TrimName(inputtext));
		mysql_tquery(g_SQL, query, "OnTicketLookupUser", "i", playerid);
	}
	return 1;
}

function OnTicketLookupUser(playerid)
{
	new rows; cache_get_row_count(rows);
	if(!rows)
		return SendErrorMessage(playerid, "No such user found.");

	new cID, query[128];
	cache_get_value_int(0, "CharacterID", cID);

	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM fines WHERE UserID = %d AND Active = 1 ORDER BY ID DESC", cID);
	mysql_tquery(g_SQL, query, "ActiveTickets", "i", playerid);
	return 1;
}

Dialog:TicketAll(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM fines WHERE UserID = %d ORDER BY ID DESC", TrimName(inputtext));
		mysql_tquery(g_SQL, query, "TicketRecords", "i", playerid);
	}
	return 1;
}

Dialog:TicketRecords(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new cID = gActiveTickets[playerid][listitem];
		new query[128];
		format(query, sizeof(query), "SELECT * FROM fines WHERE ID = %i", cID);
		mysql_tquery(g_SQL, query, "PrintTicketRecords", "i", playerid);
	}
	return 1;
}

Dialog:ActiveTickets(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new cID = gActiveTickets[playerid][listitem];
		new query[128];
		format(query, sizeof(query), "SELECT * FROM h_tickets WHERE ID = %i", cID);
		mysql_tquery(g_SQL, query, "PrintActiveTicket", "i", playerid);
	}
	return 1;
}

Dialog:ChargeHistory(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM CriminalRecords WHERE CharacterName = '%e' ORDER BY Timestamp DESC LIMIT 25", inputtext);
		mysql_tquery(g_SQL, query, "CitizenRecords", "i", playerid);
	}
	return 1;
}

Dialog:CitizenRecordsD(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = gActiveTickets[playerid][listitem];
		new query[128];
		format(query, sizeof(query), "SELECT * FROM CriminalRecords WHERE ID = %i", id);
		mysql_tquery(g_SQL, query, "PrintPlayerCharge", "i", playerid);
	}
	return 1;
}

Dialog:ChargesName(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT CharacterID, Name FROM characters WHERE Name = '%e'", inputtext);
		mysql_tquery(g_SQL, query, "OnChargeName", "i", playerid);
	}
	return 1;
}

Dialog:ChargeAdd(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowChargeList(playerid);
	if (response)
	{
		new len = strlen(inputtext);
		if (len >= 100) return Dialog_Show(playerid, ChargeAdd, DIALOG_STYLE_INPUT, "Input Charge", "{DEDEDE}Describe the charge that you would like to submit.\n\n{FF0000}Warning! Make sure it's not too long text.", "Charge", "Back");

		for (new i = 0; i < MAX_CHARGES; i++)
		{
			if (!Charges[playerid][i][cExists])
			{
				Charges[playerid][i][cExists] = 1;
				format(Charges[playerid][i][cDescription], 128, "%s", inputtext);
				SendServerMessage(playerid, "Charge added.");
				ShowChargeList(playerid);
				break;
			}
		}
	}
	return 1;
}

Dialog:ChargeShow(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowChargeList(playerid);
	if (response)
	{
		new id = Players[playerid][pSelected];
		if (!Charges[playerid][id][cExists])
		{
			ShowChargeList(playerid);
			return SendErrorMessage(playerid, "This charge doesn't exist.");
		}

		Charges[playerid][id][cExists] = 0;
		format(Charges[playerid][id][cDescription], 128, "");
		SendServerMessage(playerid, "Charge was removed.");
		ShowChargeList(playerid);
	}
	return 1;
}

Dialog:ChargeList(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (listitem == 0)
		{
			if (ChargeCounter[playerid] >= MAX_CHARGES)
			{
				ShowChargeList(playerid);
				return SendErrorMessage(playerid, "You cannot place more charges before submitting.");
			}

			Dialog_Show(playerid, ChargeAdd, DIALOG_STYLE_INPUT, "Input Charge", "{DEDEDE}Describe the charge that you would like to submit.", "Charge", "Back");
		}
		else if (listitem == 1)
		{
			if (ChargeCounter[playerid] == 0)
			{
				ShowChargeList(playerid);
				return SendErrorMessage(playerid, "You haven't placed any charges.");
			}

			SubmitCharges(playerid);
		}
		else
		{
			new id = ChargeHolder[playerid][listitem-2];
			Players[playerid][pSelected] = ChargeHolder[playerid][listitem-2];

			new msg[256];
			format(msg, sizeof(msg), "Suspect: %s\n\nDescription:\n%s", ChargeSuspect[playerid], Charges[playerid][id][cDescription]);

			new title[51];
			format(title, sizeof(title), "Charge #%i", (listitem-1));
			Dialog_Show(playerid, ChargeShow, DIALOG_STYLE_MSGBOX, title, msg, "Delete", "Back");
		}
	}
	return 1;
}

Dialog:CitizenProperties(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new cID = MDCSearch_HolderID[playerid];
		new counter = 0, id = -1;
		for (new i = 0; i < MAX_HOUSES; i++)
		{
			if (HouseInfo[i][HouseID] && HouseInfo[i][HouseOwnerID] == cID)
			{
				if (counter == listitem)
				{
					id = i;
					break;
				}
				counter++;
			}
		}
		
		if (id == -1)
		{
			return SendErrorMessage(playerid, "The building stopped being owned by this citizen.");
		}
		
		Dialog_Show(playerid, CitizenPropInfo, DIALOG_STYLE_MSGBOX, "Property Information", "{DEDEDE}Type: House\nAddress: %s\nAlarm: No", "Back", "", HouseInfo[id][HouseAddress]);
	}
	return 1;
}

Dialog:CitizenPropInfo(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		ViewCitizenProperties(playerid);
	}
	return 1;
}

Dialog:SearchCitizenSimple(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
		{
			SendErrorMessage(playerid, "Input cannot be empty.");
			return Dialog_Show(playerid, SearchCitizenSimple, DIALOG_STYLE_INPUT, "Input Full Name", "{DEDEDE}Please input the full name of the citizen you are searching for.\n\n(( You don't have to put underscore, but name must include both first and last name))", "Input", "Cancel");
		}
		if (strval(inputtext) < 0 || strlen(inputtext) > MAX_PLAYER_NAME)
		{
			SendErrorMessage(playerid, "Too short or too long input.");
			return Dialog_Show(playerid, SearchCitizenSimple, DIALOG_STYLE_INPUT, "Input Full Name", "{DEDEDE}Please input the full name of the citizen you are searching for.\n\n(( You don't have to put underscore, but name must include both first and last name))", "Input", "Cancel");
		}
		
		new spacecounter = 0, scorecounter = 0;
		for (new i = 0; i < strlen(inputtext); i++)
		{
			if (inputtext[i] == ' ')
			{
				spacecounter++;
				inputtext[i] = '_';
			}
			else if (inputtext[i] == '_')
			{
				scorecounter++;
			}
			
			if (spacecounter > 1 || scorecounter > 1)
			{
				SendErrorMessage(playerid, "Invalid input format.");
				return Dialog_Show(playerid, SearchCitizenSimple, DIALOG_STYLE_INPUT, "Input Full Name", "{DEDEDE}Please input the full name of the citizen you are searching for.\n\n(( You don't have to put underscore, but name must include both first and last name))", "Input", "Cancel");
			}
		}
		if (spacecounter == 0 && scorecounter == 0)
		{
			SendErrorMessage(playerid, "Invalid input format.");
			return Dialog_Show(playerid, SearchCitizenSimple, DIALOG_STYLE_INPUT, "Input Full Name", "{DEDEDE}Please input the full name of the citizen you are searching for.\n\n(( You don't have to put underscore, but name must include both first and last name))", "Input", "Cancel");
		}
		
		format(MDCSearch_Fullname[playerid], MAX_PLAYER_NAME, "%s", inputtext);
		
		new display[32];
		format(display, sizeof(display), "> %s", TrimName(MDCSearch_Fullname[playerid]));
		ShowMDCType_Quest(playerid, "Search Citizen - Simple", "Full name:", display, "", "", "", "", "", "", "", "", "Search");
	}
	return 1;
}

Dialog:SearchCitizenAdvName(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if (isnull(inputtext))
		{
			SendErrorMessage(playerid, "Input cannot be empty.");
			return Dialog_Show(playerid, SearchCitizenAdvName, DIALOG_STYLE_INPUT, "Input Part of Name", "{DEDEDE}Input just a part of a name. For instance 'John' or just 'J'.\nYou can use underscore or space as well.\n\nThese will search for any names including the given letters.", "Input", "Cancel");
		}
		if (strval(inputtext) < 0 || strlen(inputtext) > MAX_PLAYER_NAME)
		{
			SendErrorMessage(playerid, "Too short or too long input.");
			return Dialog_Show(playerid, SearchCitizenAdvName, DIALOG_STYLE_INPUT, "Input Part of Name", "{DEDEDE}Input just a part of a name. For instance 'John' or just 'J'.\nYou can use underscore or space as well.\n\nThese will search for any names including the given letters.", "Input", "Cancel");		
		}
		
		new spacecounter = 0, scorecounter = 0;
		for (new i = 0; i < strlen(inputtext); i++)
		{
			if (inputtext[i] == ' ')
			{
				spacecounter++;
				inputtext[i] = '_';
			}
			else if (inputtext[i] == '_')
			{
				scorecounter++;
			}
			
			if (spacecounter > 1 || scorecounter > 1)
			{
				SendErrorMessage(playerid, "Invalid input format.");
				return Dialog_Show(playerid, SearchCitizenAdvName, DIALOG_STYLE_INPUT, "Input Part of Name", "{DEDEDE}Input just a part of a name. For instance 'John' or just 'J'.\nYou can use underscore or space as well.\n\nThese will search for any names including the given letters.", "Input", "Cancel");
			}
		}
		
		format(MDCSearch_Fullname[playerid], MAX_PLAYER_NAME, "%s", inputtext);
		
		ShowAdvancedSearch(playerid);
	}
	return 1;
}

Dialog:SearchCitizenAdvPhone(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new val = strval(inputtext);
		if (val < 0)
		{
			SendErrorMessage(playerid, "Number input cannot be below zero.");
			return Dialog_Show(playerid, SearchCitizenAdvPhone, DIALOG_STYLE_INPUT, "Input Phone Number", "{DEDEDE}Input a phone number, the number must be complete and must exist in the registry.", "Input", "Cancel");
		}

		MDCSearch_Phone[playerid] = val;
		ShowAdvancedSearch(playerid);
	}
	return 1;
}

Dialog:SearchCitizenAdvBlood(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		MDCSearch_Bloodtype[playerid] = listitem - 1;
		ShowAdvancedSearch(playerid);
	}
	return 1;
}

Dialog:SearchCitizenAdvGender(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		MDCSearch_Gender[playerid] = listitem;
		ShowAdvancedSearch(playerid);
	}
	return 1;
}

Dialog:SearchCitizenAdvAge(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new bool:found = false;
		for (new i = 0; i < strlen(inputtext); i++)
		{
			if(IsCharNumber(inputtext[i]))
			{
				found = true;
				break;
			}
		}

		if (!found)
		{
			SendErrorMessage(playerid, "Invalid age format, please also include at least one number.");
			return Dialog_Show(playerid, SearchCitizenAdvAge, DIALOG_STYLE_INPUT, "Select Gender", "{DEDEDE}Please input a range of age. Examples:\n- To select an age range use format 'minage-maxage' (18-50).\n- To select specific ages use format 'firstage, secondage' (18, 50).", "Input", "Cancel");
		}

		format(MDCSearch_Age[playerid], 32, "%s", inputtext);
		ShowAdvancedSearch(playerid);
	}
	return 1;
}

Dialog:SearchPlate(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		format(MDCSearch_Any[playerid], 128, "%s", inputtext);
		ShowSearchPlate(playerid);
	}
	return 1;
}

Dialog:SearchAddress(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		format(MDCSearch_Any[playerid], 128, "%s", inputtext);
		ShowSearchAddress(playerid);
	}
	return 1;
}

Dialog:SearchSerial(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		format(MDCSearch_Any[playerid], 128, "%s", inputtext);
		ShowSearchSerial(playerid);
	}
	return 1;
}

CMD:mdc(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction] < 1)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionMDC] == 0)
		return SendErrorMessage(playerid, "Your faction does not have access to this.");
	
	if (!IsPlayerInAnyVehicle(playerid))
	{
		return SendErrorMessage(playerid, "You must be inside a vehicle to do this.");
	}
	StartMDC(playerid);
	return 1;
}


//hooks

hook OnPlayerClickTD(playerid, Text:clickedid)
{
	if (MDCProcess[playerid] != MDC_NONE && clickedid == INVALID_TEXT_DRAW)
	{
		MDCProcess[playerid] = MDC_NONE;
		HideMDC(playerid);
	}
	return 1;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if (MDCProcess[playerid] != MDC_NONE)
	{
		if (MDCProcess[playerid] != MDC_MAIN_MENU && playertextid == Players[playerid][pText][50])
		{
			HandleMDCBack(playerid);
		}
		else
		{
			switch (MDCProcess[playerid])
			{
				case MDC_MAIN_MENU:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - Search citizen
					{
						ShowSearchCitizen(playerid);
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - Search plate
					{
						ShowSearchPlate(playerid);
					}
					if (playertextid == Players[playerid][pText][53]) // L3 - Search address
					{
						ShowSearchAddress(playerid);
					}
					if (playertextid == Players[playerid][pText][54]) // L4 - Search serial number
					{
						ShowSearchSerial(playerid);
					}
					if (playertextid == Players[playerid][pText][55]) // L5 - Show records
					{
						ShowRecordMenu(playerid);
					}
				}
				case MDC_SEARCH_CITIZEN:
				{
					if (playertextid == Players[playerid][pText][51])
					{
						ShowSearchCitizen_Simp(playerid);
					}
					if (playertextid == Players[playerid][pText][52])
					{
						ShowSearchCitizen_Adv(playerid);
					}
				}
				case MDC_SEARCH_CITIZEN_SIMP:
				{
					if (playertextid == Players[playerid][pText][57]) // A1
					{
						Dialog_Show(playerid, SearchCitizenSimple, DIALOG_STYLE_INPUT, "Input Full Name", "{DEDEDE}Please input the full name of the citizen you are searching for.\n\n(( You don't have to put underscore, but name must include both first and last name))", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][66]) // button
					{
						HandleButtonPush(playerid);
					}
				}
				case MDC_CITIZEN_SEARCH_LINKS, MDC_SEARCH_CITIZEN_ADV:
				{
					// When search result comes
					if (playertextid == Players[playerid][pText][51]) // L1
					{
						MDCSearch_HolderID[playerid] = MDCQueryID[playerid][0];
						MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;

						ShowMDCType_Menu(playerid, "Citizen Links", "View information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
						ShowMDCBackButton(playerid);
					}
					if (playertextid == Players[playerid][pText][52]) // L2
					{
						MDCSearch_HolderID[playerid] = MDCQueryID[playerid][1];
						MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;
						
						ShowMDCType_Menu(playerid, "Citizen Links", "View information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
						ShowMDCBackButton(playerid);
					}
					if (playertextid == Players[playerid][pText][53]) // L3
					{
						MDCSearch_HolderID[playerid] = MDCQueryID[playerid][2];
						MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;
						
						ShowMDCType_Menu(playerid, "Citizen Links", "View information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
						ShowMDCBackButton(playerid);
					}
					if (playertextid == Players[playerid][pText][54]) // L4
					{
						MDCSearch_HolderID[playerid] = MDCQueryID[playerid][3];
						MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;
						
						ShowMDCType_Menu(playerid, "Citizen Links", "View information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
						ShowMDCBackButton(playerid);
					}
					if (playertextid == Players[playerid][pText][55]) // L5
					{
						MDCSearch_HolderID[playerid] = MDCQueryID[playerid][4];
						MDCProcess[playerid] = MDC_CITIZEN_LINKS_ADV;

						ShowMDCType_Menu(playerid, "Citizen Links", "View information", "View vehicles", "View properties", "View registered phones", "Licenses & Certificates");
						ShowMDCBackButton(playerid);
					}
				
					// When searching
					if (playertextid == Players[playerid][pText][57]) // A1
					{
						Dialog_Show(playerid, SearchCitizenAdvName, DIALOG_STYLE_INPUT, "Input Part of Name", "{DEDEDE}Input just a part of a name. For instance 'John' or just 'J'.\nYou can use underscore or space as well.\n\nThese will search for any names including the given letters.", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][59]) // A2
					{
						Dialog_Show(playerid, SearchCitizenAdvPhone, DIALOG_STYLE_INPUT, "Input Phone Number", "{DEDEDE}Input a phone number, the number must be complete and must exist in the registry.", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][61]) // A3
					{
						Dialog_Show(playerid, SearchCitizenAdvBlood, DIALOG_STYLE_LIST, "Select Blood Type", "All\nO-\nO+\nA-\nA+\nB-\nB+\nAB-\nAB+", "Select", "Cancel");
					}
					if (playertextid == Players[playerid][pText][63]) // S1
					{
						Dialog_Show(playerid, SearchCitizenAdvGender, DIALOG_STYLE_LIST, "Select Gender", "Male\nFemale\nBoth", "Select", "Cancel");
					}
					if (playertextid == Players[playerid][pText][65]) // S2
					{
						Dialog_Show(playerid, SearchCitizenAdvAge, DIALOG_STYLE_INPUT, "Select Gender", "{DEDEDE}Please input a range of age. Examples:\n- To select an age range use format 'minage-maxage' (18-50).\n- To select specific ages use format 'firstage, secondage' (18, 50).", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][66]) // button
					{
						HandleButtonPush(playerid);
					}
				}
				case MDC_CITIZEN_LINKS_SIMP:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - View information
					{
						ViewCitizenInfo(playerid);
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - View vehicles
					{
						ViewCitizenVehicles(playerid);
					}
					if (playertextid == Players[playerid][pText][53]) // L3 - View properties
					{
						ViewCitizenProperties(playerid);
					}
					if (playertextid == Players[playerid][pText][54]) // L4 - View registered phones
					{						
						new list[2048] = "{DEDEDE}Phone Number\n";
						format(list, sizeof list, "{AFAFAF}%s's phone number is: {FFFFFF}%d", GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)));
						Dialog_Show(playerid, NonExistant, DIALOG_STYLE_MSGBOX, "Phone Number", list, "Back", "");
					}
					if (playertextid == Players[playerid][pText][55]) // L5 - Licenses & certificates
					{
						ViewCitizenLicenses(playerid);
					}
				}
				case MDC_CITIZEN_LINKS_ADV:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - View information
					{
						ViewCitizenInfo(playerid);
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - View vehicles
					{
						ViewCitizenVehicles(playerid);
					}
					if (playertextid == Players[playerid][pText][53]) // L3 - View properties
					{
						ViewCitizenProperties(playerid);
					}
					if (playertextid == Players[playerid][pText][54]) // L4 - View registered phones
					{						
						ViewCitizenPhones(playerid);
					}
					if (playertextid == Players[playerid][pText][55]) // L5 - Licenses & certificates
					{
						ViewCitizenLicenses(playerid);
					}
				}
				case MDC_SEARCH_PLATE:
				{
					if (playertextid == Players[playerid][pText][57]) // A1
					{
						Dialog_Show(playerid, SearchPlate, DIALOG_STYLE_INPUT, "Input Plate", "{DEDEDE}Input a plate text, remember that spaces also matter when filtering.", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][66]) // button
					{
						HandleButtonPush(playerid);
					}
				}
				case MDC_SEARCH_ADDRESS:
				{
					if (playertextid == Players[playerid][pText][57]) // A1
					{
						Dialog_Show(playerid, SearchAddress, DIALOG_STYLE_INPUT, "Input Address", "{DEDEDE}Input an address, remember that spaces also matter when filtering.", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][66]) // button
					{
						HandleButtonPush(playerid);
					}
				}
				case MDC_SEARCH_SERIAL:
				{
					if (playertextid == Players[playerid][pText][57]) // A1
					{
						Dialog_Show(playerid, SearchSerial, DIALOG_STYLE_INPUT, "Input Firearm Serial Number", "{DEDEDE}Input a serial number, remember to be precise.", "Input", "Cancel");
					}
					if (playertextid == Players[playerid][pText][66]) // button
					{
						HandleButtonPush(playerid);
					}
				}
				case MDC_RECORD_MENU:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - Charges
					{
						ShowChargeMenu(playerid);
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - Tickets
					{
						ShowTicketMenu(playerid);
					}
				}
				case MDC_CHARGE_MENU:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - Insert Charges
					{
						Dialog_Show(playerid, ChargesName, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you are placing charges upon ((full name)).", "Submit", "Cancel");
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - Charge History
					{
						Dialog_Show(playerid, ChargeHistory, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you would like to see charge logs of ((input full name)).", "Search", "Cancel");
					}
				}
				case MDC_TICKET_MENU:
				{
					if (playertextid == Players[playerid][pText][51]) // L1 - Search citizen - Active
					{
						Dialog_Show(playerid, TicketActive, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you would like to see active tickets of ((full name))", "Search", "Cancel");
					}
					if (playertextid == Players[playerid][pText][52]) // L2 - Search citizen - All
					{
						Dialog_Show(playerid, TicketAll, DIALOG_STYLE_INPUT, "Input Name", "{DEDEDE}Please input the name of the individual you would like to see active tickets of ((full name))", "Search", "Cancel");
					}
				}
			}
		}
	}
	return 1;
}