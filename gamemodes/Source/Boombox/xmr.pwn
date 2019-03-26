//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/*
	Radio Station Backend System
	Commands: 
	[Level 4+ Admin] /createradio -> Dialog: Set URL, Set Name, Set Category.
	[Level 4+ Admin] /editradio -> Dialog: Select Category -> Dialog: Select Station -> Dialog: Set URL, Set Name, Set Category, Delete
	[Level 4+ Admin] /deleteradio -> Dialog: Select Category -> Dialog: Select Station -> Dialog: Confirm Delete.
*/

/*
	Categories IDs:
	1. Pop
	2. Adult Contemporay
	3. Country
	4. Hip Hop
	5. Dance/EDM
	6. Jazz & Blues
	7. Easy Listening
	8. Folk
	9. Latin
	10. International
	11. Christian/Gospel
	12. Classical
	13. Seasonal
	14. Talk Show
*/

// Includes
#include <YSI\y_hooks>

// Defines
#define MAX_RADIO_STATIONS 50 // The number of radio stations, increase this limit as needed.

enum radioStationEnum
{
	ID, // Database ID
	Name[32], // Station Name
	URL[128], // Station URL
	Category, // Category
	CreatedBy[MAX_PLAYER_NAME], // The person who created the radio.
	CreatedTimestamp, // The timestamp that it was created [Unix time/gettime()]
};
new RadioStations[MAX_RADIO_STATIONS][radioStationEnum],
	Cache:radioCache;

new RadioCategories[][128] = 
{
	{"Pop"},
	{"Adult Contemporay"},
	{"Country"},
	{"Hip Hop"},
	{"Dance/EDM"},
	{"Jazz & Blues"},
	{"Easy Listening"},
	{"Folk"},
	{"Latin"},
	{"International"},
	{"Christian/Gospel"},
	{"Classical"},
	{"Seasonal"},
	{"Talk Show"}
};

new RadioSelect[MAX_PLAYERS][MAX_RADIO_STATIONS], RadioSelectType[MAX_PLAYERS];
new EditingRadio[MAX_PLAYERS];

stock ResetRadioStation(id)
{
	RadioStations[id][ID] = 0;
	RadioStations[id][Name][0] = 0;
	RadioStations[id][URL][0] = 0;
	RadioStations[id][Category] = -1;
	RadioStations[id][CreatedBy][0] = 0;
	RadioStations[id][CreatedTimestamp] = 0;
}

stock StopStream(playerid)
{
    StopAudioStreamForPlayer(playerid);
}

stock PlayStream(playerid, url[], Float:posX = 0.0, Float:posY = 0.0, Float:posZ = 0.0, Float:distance = 50.0, usepos = 0)
{
    PlayAudioStreamForPlayer(playerid, url, posX, posY, posZ, distance, usepos);
}

stock LoadRadioStations()
{
	for(new i; i < MAX_RADIO_STATIONS; i++)
	{
		ResetRadioStation(i);
	}

	new rows;
    new Cache:radio_result;

    radio_result = mysql_query(g_SQL, "SELECT * FROM `Radio_Stations`");
	if (cache_get_row_count(rows))
    {
        for(new i = 0; i < rows; i++) 
        {
            radioCache = cache_save();
            cache_get_value_int(i, "ID", RadioStations[i][ID]);

            cache_get_value(i, "Name", RadioStations[i][Name], 32);
			cache_get_value(i, "URL", RadioStations[i][URL], 128);
            cache_get_value_int(i, "Category", RadioStations[i][Category]);
			cache_get_value(i, "CreatedBy", RadioStations[i][CreatedBy], MAX_PLAYER_NAME);
			cache_get_value_int(i, "CreatedTimestamp", RadioStations[i][CreatedTimestamp]);
            cache_set_active(radioCache);
        }
		printf("[SYSTEM]: Loaded %d radio stations.", rows);
    }
	else printf("[WARNING]: Cannot load radio stations, none probably exist.");
    cache_delete(radio_result); 
}

new tempRadioName[MAX_PLAYERS][128],
	tempRadioURL[MAX_PLAYERS][32];

CMD:createradio(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
	{
		Dialog_Show(playerid, CreateRadio_URL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
		The URL should in in something like .m3u, .pls, .mp3 or something similar (Not .php or html).", "Continue", "Exit");
	}
	return 1;
}

Dialog:CreateRadio_URL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 5 || strlen(inputtext) >= 128)
		{
			Dialog_Show(playerid, CreateRadio_URL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
				The URL should end in something like .m3u, .pls, .mp3 or something similar (Not .php or html).\n\
				ERROR: The URL cannot be above 127 characters or below 5 characters.", "Continue", "Exit");
			return 1;
		}

		format(tempRadioURL[playerid], 128, "%s", inputtext);
		Dialog_Show(playerid, CreateRadio_Name, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
			This should be the actual name of the radio station.\n\
			Example: Kickin' Country.", "Continue", "Exit");
	}
	return 1;
}

Dialog:CreateRadio_Name(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 5 || strlen(inputtext) >= 32)
		{
			Dialog_Show(playerid, CreateRadio_Name, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
			This should be the actual name of the radio station.\n\
			Example: Kickin' Country.\n\
			ERROR: The name cannot be above 31 characters or below 5 characters.", "Continue", "Exit");
			return 1;
		}

		format(tempRadioName[playerid], 32, "%s", inputtext);

		new string[240];
		for(new i; i < sizeof(RadioCategories); i++)
		{
			format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
		}

		Dialog_Show(playerid, CreateRadio_Category, DIALOG_STYLE_LIST, "Set Category", string, "Continue", "Exit");
	}
	else
	{
		Dialog_Show(playerid, CreateRadio_URL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
		The URL should in in something like .m3u, .pls, .mp3 or something similar (Not .php or html).", "Continue", "Exit");
	}
	return 1;
}

Dialog:CreateRadio_Category(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		for(new i; i < sizeof(RadioStations); i++)
		{
			if(!RadioStations[i][ID])
			{
				new query[128+32+256];
				mysql_format(g_SQL, query, sizeof query, "INSERT INTO `Radio_Stations` (`Name`, `URL`, `Category`, `CreatedBy`, `CreatedTimestamp`) \
				VALUES ('%e', '%e', %d, '%e', %d)", tempRadioName[playerid], tempRadioURL[playerid], listitem, GetMasterName(playerid), gettime());
				mysql_tquery(g_SQL, query, "OnCreateRadioStation", "ddd", playerid, i, listitem);
				return 1;
			}
		}
		SendErrorMessage(playerid, "Cannot create station, limit was reached. (Limit: %d)", MAX_RADIO_STATIONS);
	}
	else
	{
		new string[240];
		for(new i; i < sizeof(RadioCategories); i++)
		{
			format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
		}

		Dialog_Show(playerid, CreateRadio_Category, DIALOG_STYLE_LIST, "Set Category", string, "Continue", "Exit");
	}
	return 1;
}

function OnCreateRadioStation(playerid, id, cat)
{
	RadioStations[id][ID] = cache_insert_id();
	format(RadioStations[id][Name], 32, "%s", tempRadioName[playerid]);
	format(RadioStations[id][URL], 128, "%s", tempRadioURL[playerid]);
	RadioStations[id][Category] = cat;
	SendServerMessage(playerid, "Created radio station with ID %d.", id);
	return 1;
}

stock ShowRadioStations(playerid)
{
	new string[240];
	for(new i; i < sizeof(RadioCategories); i++)
	{
		format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
	}
	format(string, sizeof string, "%s{FFFF00}Turn Off\n", string);

	Dialog_Show(playerid, Radio_Category, DIALOG_STYLE_LIST, "Select Genre", string, "Select ", "Exit");
	return 1;
}

hook OnPlayerConnect(playerid)
{
	for(new i; i < MAX_RADIO_STATIONS; i++)
	{
		RadioSelect[playerid][i] = 0;
	}
	RadioSelectType[playerid] = 0;
	EditingRadio[playerid] = -1;
	return 1;
}

// Types: 1: Car Radio, 2: House Radio, 3: Business Radio, 4: Boombox, 5: Edit Radio, 6: Delete Radio
stock ShowRadios(playerid, category)
{
	new string[40*MAX_RADIO_STATIONS], count = 0;

	// Loop through all the radio stations.
	for(new i; i < MAX_RADIO_STATIONS; i++)
	{
		// Check if the radio station exists by getting its ID and then check if the saved Category is thr same as the ShowRadios category.
		if(RadioStations[i][ID] > 0 && RadioStations[i][Category] == category)
		{
			// Add the radio script ID (not database ID) to the RadioSelect variable.
			RadioSelect[playerid][count] = i;

			// Add the radio station to the list string.
			format(string, sizeof string, "%s%s\n", string, RadioStations[i][Name]);

			// Increment the count variable by 1.
			count++;
		}
	}
	// Show the dialog.
	Dialog_Show(playerid, Radio_Select, DIALOG_STYLE_LIST, "Select Station", string, "Select", "Back");
}

Dialog:Radio_Category(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == sizeof(RadioCategories)+1)
		{
			new string[128];
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				CoreVehicle[vehicleid][RadioURL][0] = 0;

				// Send a green /ame that shows that the player has changed their radio station.
				format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
				SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

				// Send a message to all players inside the car stating that the radio was turned off and then stop the audio stream.
				foreach(new i: Player)
				{
					if(GetPlayerVehicleID(i) == vehicleid)
					{
						StopAudioStreamForPlayer(playerid);
						SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
					}
				}
				return 1;
			}
			new houseid = IsPlayerInsideHouse(playerid);
			if(houseid != -1)
			{
				HouseBoomboxOn[houseid] = false;
				HouseBoomboxURL[houseid][0] = 0;

				// Send a green /ame that shows that the player has changed their radio station.
				format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
				SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

				// Send a message to all players inside the house stating that the radio was turned off and then stop the audio stream.
				foreach(new i: Player)
				{
					if(IsPlayerInsideHouse(i) == houseid)
					{
						StopAudioStreamForPlayer(playerid);
						SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
					}
				}
				return 1;
			}
			new biz = IsPlayerInsideBiz(playerid);
			if(biz != -1)
			{
				// Send a green /ame that shows that the player has changed their radio station.
				format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
				SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

				// Send a message to all players inside the business stating that the radio was turned off and then stop the audio stream.
				foreach(new i: Player)
				{
					if(IsPlayerInsideBiz(i) == houseid)
					{
						StopAudioStreamForPlayer(playerid);
						SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
					}
				}
				return 1;
			}
			new boombox = IsPlayerNearBoombox(playerid);
			if(boombox != -1)
			{
				if(BoomboxInfo[boombox][OwnerID] != playerid)
				{
					SendErrorMessage(playerid, "You do not own this boombox.");
					return 1;
				}
				BoomboxInfo[boombox][URL][0] = 0;

				// Send a green /ame that shows that the player has changed their radio station.
				format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
				SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

				// Send a message to all players inside the business stating that the radio was turned off and then stop the audio stream.
				foreach(new i: Player)
				{
					if(IsPlayerNearBoombox(i, BoomboxInfo[boombox][AudioRange]) == boombox)
					{
						StopAudioStreamForPlayer(playerid);
						SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
					}
				}
				return 1;
			}
			SendErrorMessage(playerid, "Cannot turn off radio, you need to be inside a business, house or vehicle. Use /stopaudio if you got an active audio stream.");
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerVehicleSeat(playerid) != 0 && GetPlayerVehicleSeat(playerid) != 1)
			{
				SendErrorMessage(playerid, "You need to the the driver or front passenger to use this.");
				return 1;
			}
			RadioSelectType[playerid] = 1;
			ShowRadios(playerid, listitem);
			return 1;
		}
		if(IsPlayerInsideHouse(playerid) != -1)
		{
			RadioSelectType[playerid] = 2;
			ShowRadios(playerid, listitem);
			return 1;
		}
		new biz = IsPlayerInsideBiz(playerid);
		if(biz != -1)
		{
			if(BusinessInfo[biz][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
			{
				SendErrorMessage(playerid, "You need to own this business to change the boombox radio.");
				return 1;
			}
			RadioSelectType[playerid] = 3;
			ShowRadios(playerid, listitem);
			return 1;
		}
		new bbid = IsPlayerNearBoombox(playerid);
		if(bbid != -1)
		{
			if(BoomboxInfo[bbid][OwnerID] != playerid)
			{
				SendErrorMessage(playerid, "You do not own this boombox.");
				return 1;
			}
			RadioSelectType[playerid] = 4;
			ShowRadios(playerid, listitem);
			return 1;
		}
	}
	return 1;
}

Dialog:Radio_Select(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(RadioSelectType[playerid])
		{
			case 1:
			{
				// Set the radio URL.
				new vehicleid = GetPlayerVehicleID(playerid), radio = RadioSelect[playerid][listitem], string[128];
				format(CoreVehicle[vehicleid][RadioURL], 128, "%s", RadioStations[radio][URL]);

				// Send a green /ame that shows that the player has changed their radio station.
				format(string, sizeof string, "* %s changed the radio station to %s.", GetRPName(playerid), RadioStations[radio][Name]);
				SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

				// Send a message to all players inside the car stating that the radio was changed and then play the new audio stream.
				foreach(new i: Player)
				{
					if(GetPlayerVehicleID(i) == vehicleid)
					{
						PlayAudioStreamForPlayer(i, CoreVehicle[vehicleid][RadioURL]);
						SendClientMessageEx(i, COLOR_GREEN, "Radio Station changed to {FFFFFF}%s{%06x} by %s.", RadioStations[radio][Name], COLOR_GREEN >>> 8, GetRPName(playerid));
					}
				}
			}
			case 2:
			{
				new houseid = IsPlayerInsideHouse(playerid), radio = RadioSelect[playerid][listitem], string[128];
				if(houseid != -1)
				{
					HouseBoomboxOn[houseid] = true;
					format(HouseBoomboxURL[houseid], 128, "%s", RadioStations[radio][URL]);

					// Send a green /ame that shows that the player has changed their radio station.
					format(string, sizeof string, "* %s changed the radio station to %s.", GetRPName(playerid), RadioStations[radio][Name]);
					SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

					// Send a message to all players inside the house stating that the radio was changed and then play the new audio stream.
					foreach(new i: Player)
					{
						if(IsPlayerInsideHouse(i) == houseid)
						{
							PlayAudioStreamForPlayer(i, HouseBoomboxURL[houseid]);
							SendClientMessageEx(i, COLOR_GREEN, "Radio Station changed to {FFFFFF}%s{%06x} by %s.", RadioStations[radio][Name], COLOR_GREEN >>> 8, GetRPName(playerid));
						}
					}
				}
			}
			case 3:
			{
				new biz = IsPlayerInsideBiz(playerid), radio = RadioSelect[playerid][listitem], string[128];
				if(biz != -1)
				{
					format(BizBoomboxURL[biz], 128, "%s", RadioStations[radio][URL]);

					// Send a green /ame that shows that the player has changed their radio station.
					format(string, sizeof string, "* %s changed the radio station to %s.", GetRPName(playerid), RadioStations[radio][Name]);
					SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

					// Send a message to all players inside the house stating that the radio was changed and then play the new audio stream.
					foreach(new i: Player)
					{
						if(IsPlayerInsideBiz(i) == biz)
						{
							PlayAudioStreamForPlayer(i, BizBoomboxURL[biz]);
							SendClientMessageEx(i, COLOR_GREEN, "Radio Station changed to {FFFFFF}%s{%06x} by %s.", RadioStations[radio][Name], COLOR_GREEN >>> 8, GetRPName(playerid));
						}
					}
				}
			}
			case 4:
			{
				new bbid = IsPlayerNearBoombox(playerid), radio = RadioSelect[playerid][listitem], string[128];
				if(bbid != -1)
				{
					if(BoomboxInfo[bbid][OwnerID] != playerid)
					{
						SendErrorMessage(playerid, "You do not own this boombox.");
						return 1;
					}
					format(BoomboxInfo[bbid][URL], 128, "%s", RadioStations[radio][URL]);

					// Send a green /ame that shows that the player has changed their radio station.
					format(string, sizeof string, "* %s changed the radio station to %s.", GetRPName(playerid), RadioStations[radio][Name]);
					SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

					// Play the audio new audio stream with a range of 50 meters.
						
					// Send a message to all players inside the house stating that the radio was changed and then play the new audio stream.
					foreach(new i: Player)
					{
						if(IsPlayerNearBoombox(i, BoomboxInfo[bbid][AudioRange]) == bbid)
						{
							PlayBoombox(i, bbid);
							SendClientMessageEx(i, COLOR_GREEN, "Radio Station changed to {FFFFFF}%s{%06x} by %s.", RadioStations[radio][Name], COLOR_GREEN >>> 8, GetRPName(playerid));
						}
					}
				}
			}
			case 5:
			{
				EditingRadio[playerid] = RadioSelect[playerid][listitem];
				Dialog_Show(playerid, EditRadio_Main, DIALOG_STYLE_LIST, "Edit Radio", "Set URL\n\
					Set Name\n\
					Set Category", "Select", "Exit");
			}
			case 6:
			{
				EditingRadio[playerid] = RadioSelect[playerid][listitem];
				Dialog_Show(playerid, DeleteRadio_Confirm, DIALOG_STYLE_LIST, "Delete Radio", "You are about to delete radio %d: %s\n\
				Are you sure you want to do this?\n\n\
				This action CANNOT be reversed!", "Confirm", "Exit");
			}
		}
	}
	return 1;
}

CMD:setstation(playerid, params[])
{
	if(strcmp(params, "off", true) == 0)
	{
		new string[128];
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			CoreVehicle[vehicleid][RadioURL][0] = 0;

			// Send a green /ame that shows that the player has changed their radio station.
			format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
			SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

			// Send a message to all players inside the car stating that the radio was turned off and then stop the audio stream.
			foreach(new i: Player)
			{
				if(GetPlayerVehicleID(i) == vehicleid)
				{
					StopAudioStreamForPlayer(playerid);
					SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
				}
			}
			return 1;
		}
		new houseid = IsPlayerInsideHouse(playerid);
		if(houseid != -1)
		{
			HouseBoomboxOn[houseid] = false;
			HouseBoomboxURL[houseid][0] = 0;

			// Send a green /ame that shows that the player has changed their radio station.
			format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
			SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

			// Send a message to all players inside the house stating that the radio was turned off and then stop the audio stream.
			foreach(new i: Player)
			{
				if(IsPlayerInsideHouse(i) == houseid)
				{
					StopAudioStreamForPlayer(playerid);
					SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
				}
			}
			return 1;
		}
		new biz = IsPlayerInsideBiz(playerid);
		if(biz != -1)
		{
			BizBoomboxURL[biz][0] = 0;

			// Send a green /ame that shows that the player has changed their radio station.
			format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
			SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

			// Send a message to all players inside the business stating that the radio was turned off and then stop the audio stream.
			foreach(new i: Player)
			{
				if(IsPlayerInsideBiz(i) == houseid)
				{
					StopAudioStreamForPlayer(playerid);
					SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
				}
			}
			return 1;
		}
		new bbid = IsPlayerNearBoombox(playerid);
		if(bbid != -1)
		{
			if(BoomboxInfo[bbid][OwnerID] != playerid)
			{
				SendErrorMessage(playerid, "You do not own this boombox.");
				return 1;
			}
			BoomboxInfo[bbid][URL][0] = 0;

			// Send a green /ame that shows that the player has changed their radio station.
			format(string, sizeof string, "* %s has turned off the radio.", GetRPName(playerid));
			SetPlayerChatBubble(playerid, string, COLOR_GREEN, 20.0, 10000);

			// Send a message to all players near the boombox that the radio was turned off and then stop the audio stream.
			foreach(new i: Player)
			{
				if(IsPlayerNearBoombox(i, BoomboxInfo[bbid][AudioRange]) == bbid)
				{
					StopAudioStreamForPlayer(playerid);
					SendClientMessageEx(i, COLOR_GREEN, "Radio Station turned off by %s.", GetRPName(playerid));
				}
			}
			return 1;
		}
		SendErrorMessage(playerid, "Cannot turn off radio, you need to be inside a business, house or vehicle. Use /stopaudio if you got an active audio stream.");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) || IsPlayerInsideHouse(playerid) != -1 || IsPlayerInsideBiz(playerid) != -1 || IsPlayerNearBoombox(playerid) != -1)
	{
		SendClientMessage(playerid, COLOR_GREEN, "[TIP]: {FFFFFF}You can use \"/setstation off\" if you want to turn off the radio.");
		ShowRadioStations(playerid);
	}
	else SendErrorMessage(playerid, "You need to be inside a vehicle, house or business that supports radio functionality.");
	return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(strlen(CoreVehicle[vehicleid][RadioURL]) > 0)
		{
			PlayAudioStreamForPlayer(playerid, CoreVehicle[vehicleid][RadioURL]);
			SendClientMessage(playerid, COLOR_WHITE, "[TIP]: Use \"/setstation off\" if you want to turn off the radio.");
		}
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		StopAudioStreamForPlayer(playerid);
		for(new i; i < MAX_BOOMBOX; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, BoomboxInfo[i][AudioRange], BoomboxInfo[i][PosX], BoomboxInfo[i][PosY], BoomboxInfo[i][PosZ]))
			{
				PlayBoombox(playerid, i);
			}
		}
	}
	return 1;
}

CMD:deleteradio(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
	{
		new string[32*14];
		for(new i; i < sizeof(RadioCategories); i++)
		{
			format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
		}
		Dialog_Show(playerid, Delete_SelectCategory, DIALOG_STYLE_LIST, "Select Category", string, "Select", "Exit");
	}
	return 1;
}

Dialog:Delete_SelectCategory(playerid, response, listitem, inputtext[])
{
	RadioSelectType[playerid] = 6;
	ShowRadios(playerid, listitem);
	return 1;
}

Dialog:DeleteRadio_Confirm(playerid, response, listitem, inputtext[])
{
	new radio = EditingRadio[playerid];
	new query[256];
	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `Radio_Stations` WHERE `ID` = %d LIMIT 1", inputtext, RadioStations[radio][ID]);
	mysql_tquery(g_SQL, query, "OnDeleteRadio", "dd", playerid, radio);
	return 1;
}

function OnDeleteRadio(playerid, radio)
{
	ResetRadioStation(radio);
	SendServerMessage(playerid, "Radio station deleted.");
}

CMD:editradio(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
	{
		new string[32*14];
		for(new i; i < sizeof(RadioCategories); i++)
		{
			format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
		}
		Dialog_Show(playerid, Edit_SelectCategory, DIALOG_STYLE_LIST, "Select Category", string, "Select", "Exit");
	}
	return 1;
}

Dialog:Edit_SelectCategory(playerid, response, listitem, inputtext[])
{
	RadioSelectType[playerid] = 5;
	ShowRadios(playerid, listitem);
	return 1;
}

Dialog:EditRadio_Main(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, EditRadio_SetURL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
				The URL should end in something like .m3u, .pls, .mp3 or something similar (Not .php or .html)", "Continue", "Back");
			}
			case 1:
			{
				Dialog_Show(playerid, EditRadio_SetName, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
				This should be the actual name of the radio station.\n\
				Example: Kickin' Country.", "Continue", "Back");
			}
			case 2:
			{
				// TODO: Set Category
				new string[240];
				for(new i; i < sizeof(RadioCategories); i++)
				{
					format(string, sizeof string, "%s%s\n", string, RadioCategories[i]);
				}
				Dialog_Show(playerid, EditRadio_Category, DIALOG_STYLE_LIST, "Set Category", string, "Select", "Back");
			}
		}
	}
	return 1;
}

Dialog:EditRadio_SetURL(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		// Check if the string is below 5 characters or above 128 characters.
		if(strlen(inputtext) < 5)
		{
			Dialog_Show(playerid, EditRadio_SetURL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
				The URL should end in something like .m3u, .pls, .mp3 or something similar (Not .php or .html)\n\n\
				ERROR: You cannot go below 5 characters.", "Continue", "Back");
			return 1;
		}

		if(strlen(inputtext) > 128)
		{
			Dialog_Show(playerid, EditRadio_SetURL, DIALOG_STYLE_INPUT, "Set URL", "Input the URL of the radio station.\n\
				The URL should end in something like .m3u, .pls, .mp3 or something similar (Not .php or .html)\n\n\
				ERROR: You cannot go above 128 characters.", "Continue", "Back");
			return 1;
		}

		// Set the URL of the selected radio station.
		new radio = EditingRadio[playerid];
		format(RadioStations[radio][URL], 128, "%s", inputtext);
		SendServerMessage(playerid, "Radio %d's URL was changed: %s", radio, inputtext);

		new query[256];
		mysql_format(g_SQL, query, sizeof query, "UPDATE `Radio_Stations` SET `URL` = '%e' WHERE `ID` = %d LIMIT 1", inputtext, RadioStations[radio][ID]);
		mysql_tquery(g_SQL, query);
	}
	Dialog_Show(playerid, EditRadio_Main, DIALOG_STYLE_LIST, "Edit Radio", "Set URL\n\
		Set Name\n\
		Set Category", "Select", "Exit");
	return 1;
}

Dialog:EditRadio_SetName(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		// Check if the string is below 5 characters or above 32 characters.
		if(strlen(inputtext) < 5)
		{
			Dialog_Show(playerid, EditRadio_SetName, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
				This should be the actual name of the radio station.\n\
				Example: Kickin' Country.\n\n\
				ERROR: You cannot go below 5 characters.", "Continue", "Back");
			return 1;
		}

		if(strlen(inputtext) > 32)
		{
			Dialog_Show(playerid, EditRadio_SetName, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
				This should be the actual name of the radio station.\n\
				Example: Kickin' Country.\n\n\
				ERROR: You cannot go above 32 characters.", "Continue", "Back");
			return 1;
		}

		// Set the URL of the selected radio station.
		new radio = EditingRadio[playerid];
		format(RadioStations[radio][Name], 32, "%s", inputtext);
		SendServerMessage(playerid, "Radio %d's Name was changed: %s", radio, inputtext);

		new query[32+128];
		mysql_format(g_SQL, query, sizeof query, "UPDATE `Radio_Stations` SET `Name` = '%e' WHERE `ID` = %d LIMIT 1", inputtext, RadioStations[radio][ID]);
		mysql_tquery(g_SQL, query);
	}
	Dialog_Show(playerid, EditRadio_Main, DIALOG_STYLE_LIST, "Edit Radio", "Set URL\n\
		Set Name\n\
		Set Category", "Select", "Exit");
	return 1;
}

Dialog:EditRadio_Category(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		// Check if the string is below 5 characters or above 32 characters.
		if(strlen(inputtext) < 5)
		{
			Dialog_Show(playerid, EditRadio_SetName, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
				This should be the actual name of the radio station.\n\
				Example: Kickin' Country.\n\n\
				ERROR: You cannot go below 5 characters.", "Continue", "Back");
			return 1;
		}

		if(strlen(inputtext) > 32)
		{
			Dialog_Show(playerid, EditRadio_SetName, DIALOG_STYLE_INPUT, "Set Name", "Input the Name of the radio station.\n\
				This should be the actual name of the radio station.\n\
				Example: Kickin' Country.\n\n\
				ERROR: You cannot go above 32 characters.", "Continue", "Back");
			return 1;
		}

		// Set the URL of the selected radio station.
		new radio = EditingRadio[playerid];
		RadioStations[radio][Category] = listitem;
		SendServerMessage(playerid, "Radio %d's Name was category: %s", radio, RadioCategories[listitem]);

		new query[32+128];
		mysql_format(g_SQL, query, sizeof query, "UPDATE `Radio_Stations` SET `Name` = '%e' WHERE `ID` = %d LIMIT 1", inputtext, RadioStations[radio][ID]);
		mysql_tquery(g_SQL, query);
	}
	Dialog_Show(playerid, EditRadio_Main, DIALOG_STYLE_LIST, "Edit Radio", "Set URL\n\
		Set Name\n\
		Set Category", "Select", "Exit");
	return 1;
}