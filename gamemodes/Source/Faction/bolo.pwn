//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/***************************************************************

	Feature created by Hansrutger
	
	Information
	APB

****************************************************************/


#define MAX_BOLO_PERSON 				10
#define MAX_BOLO_VEHICLE 				10
#define MAX_BOLO 						10

enum e_PBolo {
	pbExists,
	pbID,
	pbFactionID,
	pbReporter[32],
	pbSuspect[32],
	pbReason[128],
	pbDate[32]
};
new PBOLO[MAX_BOLO_PERSON][e_PBolo];
new TempHolderP[MAX_PLAYERS][e_PBolo];

enum e_VBolo {
	vbExists,
	vbID,
	vbFactionID,
	vbReporter[32],
	vbModel[128],
	vbDesc[128],
	vbReason[128],
	vbDate[32]
};
new VBOLO[MAX_BOLO_VEHICLE][e_VBolo];
new TempHolderV[MAX_PLAYERS][e_VBolo];
new BoloChooser[MAX_PLAYERS][MAX_BOLO];
new DialogType[MAX_PLAYERS];

enum
{
    TYPE_CREATE = 1,
    TYPE_READ,
    TYPE_UPDATE,
    TYPE_DELETE
}

//functions
GetNextVBoloID()
{
	for (new i = 0; i < MAX_BOLO_VEHICLE; i++)
	{
		if (!VBOLO[i][vbExists])
		{
			return i;
		}
	}
	return -1;
}

AddVehicleBolo(playerid, model[], desc[], reason[])
{
	new id = GetNextVBoloID();
	if (id == -1)
	{
		ShowAPB(playerid);
		return SendErrorMessage(playerid, "Too many active BOLO's at this time.");
	}

	VBOLO[id][vbExists] = 1;
	VBOLO[id][vbFactionID] = PlayerInfo[id][pFaction];
	format(VBOLO[id][vbReporter], 32, "%s", GetUserName(playerid));
	format(VBOLO[id][vbModel], 128, "%s", model);
	format(VBOLO[id][vbDesc], 128, "%s", desc);
	format(VBOLO[id][vbReason], 128, "%s", reason);
	format(VBOLO[id][vbDate], 32, "%s", GetDateTime());

	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO h_bolovehicles (facID, reporter, model, description, reason, date) VALUES (%i, '%e', '%e', '%e', '%e', '%e')",
	VBOLO[id][vbFactionID],
	VBOLO[id][vbReporter],
	VBOLO[id][vbModel],
	VBOLO[id][vbDesc],
	VBOLO[id][vbReason],
	VBOLO[id][vbDate]
	);
	mysql_tquery(g_SQL, query, "OnReloadVBolo", "ii", playerid, id);
	return 1;
}

FDeleteVBolo(i)
{
	if (VBOLO[i][vbExists])
	{
		new query[128];
		format(query, sizeof(query), "DELETE FROM h_bolovehicles WHERE ID = %i", VBOLO[i][vbID]);
		mysql_tquery(g_SQL, query);

		VBOLO[i][vbExists] = 0;
		return 1;
	}
	return 0;
}

ShowActiveVBolo(playerid)
{
	new list[2048], counter = 0;
	for (new x = (MAX_BOLO_VEHICLE-1); x >= 0; x--)
	{
		if (VBOLO[x][vbExists])
		{
			format(list, sizeof(list), "%s\n%i. %s", list, (counter+1), VBOLO[x][vbModel]);
			BoloChooser[playerid][counter] = x;
			counter++;
		}
	}
	if (counter == 0)
	{
		ShowAPB(playerid);
		return SendErrorMessage(playerid, "No active BOLO's were found.");
	}
	return Dialog_Show(playerid, ShowActiveVBolo, DIALOG_STYLE_LIST, "Active BOLO Display", list, "View", "Back");
}

ViewSpecificVBolo(playerid, id, type)
{
	new msg[512];
	format(msg, sizeof(msg), "{DEDEDE}Reporter: %s\nDate: %s\n\nModel: %s\nDescription:\n%s\n\nReason:\n%s",
	TrimName(VBOLO[id][vbReporter]),
	VBOLO[id][vbDate],
	VBOLO[id][vbModel],
	VBOLO[id][vbDesc],
	VBOLO[id][vbReason]
	);

	switch(type)
	{
		case TYPE_READ:
		{
			Dialog_Show(playerid, ReadVBolo, DIALOG_STYLE_MSGBOX, "Active BOLO Display - View", msg, "Print", "Back");
		}
		case TYPE_DELETE:
		{
			Dialog_Show(playerid, DeleteVBolo, DIALOG_STYLE_MSGBOX, "Active BOLO Display - Delete", msg, "Delete", "Back");
		}
	}
}

LoadVBolos()
{
	new query[128];
	format(query, sizeof(query), "SELECT * FROM h_bolovehicles LIMIT %i", MAX_BOLO_VEHICLE);
	mysql_tquery(g_SQL, query, "OnLoadVehicleBolos");
}

LoadPBolos()
{
	new query[128];
	format(query, sizeof(query), "SELECT * FROM h_bolopersons LIMIT %i", MAX_BOLO_PERSON);
	mysql_tquery(g_SQL, query, "OnLoadPersonBolos");
}

GetNextPBoloID()
{
	for (new i = 0; i < MAX_BOLO_PERSON; i++)
	{
		if (!PBOLO[i][pbExists])
		{
			return i;
		}
	}
	return -1;
}

AddPBolo(playerid, suspect[], reason[])
{
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT CharacterID, Name FROM characters WHERE Name = '%e'", suspect);
	mysql_tquery(g_SQL, query, "OnAddPersonBolo", "iss", playerid, suspect, reason);
}

DeletePBolo(i)
{
	if (PBOLO[i][pbExists])
	{
		new query[128];
		format(query, sizeof(query), "DELETE FROM h_bolopersons WHERE ID=%i", PBOLO[i][pbID]);
		mysql_tquery(g_SQL, query);

		PBOLO[i][pbExists] = 0;
		return 1;
	}
	return 0;
}

ShowAPB(playerid)
{
	Dialog_Show(playerid, ShowAPB, DIALOG_STYLE_LIST, "All-points Bulletin", "Active BOLO\nSubmit BOLO\nDelete BOLO", "Select", "Cancel");
	return 1;
}

ShowActivePBolo(playerid)
{
	new list[2048], counter = 0;
	for (new x = (MAX_BOLO_PERSON-1); x >= 0; x--)
	{
		if (PBOLO[x][pbExists])
		{
			format(list, sizeof(list), "%s\n%i. %s - %s", list, (counter+1), PBOLO[x][pbSuspect], PBOLO[x][pbDate]);
			BoloChooser[playerid][counter] = x;
			counter++;
		}
	}
	if (counter == 0)
	{
		ShowAPB(playerid);
		return SendErrorMessage(playerid, "No active BOLO's were found.");
	}
	return Dialog_Show(playerid, ShowActivePBolo, DIALOG_STYLE_LIST, "Active BOLO Display", list, "View", "Back");
}

ViewSpecificPBolo(playerid, id, type)
{
	new msg[512];
	format(msg, sizeof(msg), "{DEDEDE}Reporter: %s\nDate: %s\nSuspect: %s\n\nReason:\n%s",
		TrimName(PBOLO[id][pbReporter]),
		PBOLO[id][pbDate],
		TrimName(PBOLO[id][pbSuspect]),
		PBOLO[id][pbReason]
	);

	switch(type)
	{
		case TYPE_READ:
		{
			Dialog_Show(playerid, ReadPBolo, DIALOG_STYLE_MSGBOX, "Active BOLO Display - View", msg, "Print", "Back");
		}
		case TYPE_DELETE:
		{
			Dialog_Show(playerid, DeletePBolo, DIALOG_STYLE_MSGBOX, "Active BOLO Display - Delete", msg, "Delete", "Back");
		}
	}
}

//forwards
forward CheckPlayerName(playerid);
public CheckPlayerName(playerid)
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		return Dialog_Show(playerid, AddPBoloS, DIALOG_STYLE_INPUT, "Add Suspect", "{DEDEDE}Please write the name of the suspect ((or the ID if player is online)).\n\n{FF0000}Warning! There is no such player name.", "Next", "Cancel");
	}
	
    cache_get_value(0, "Name", TempHolderP[playerid][pbSuspect], 32);
	Dialog_Show(playerid, AddPBoloR, DIALOG_STYLE_INPUT, "Add Reason", "{DEDEDE}Please write the reason this person is being looked for.", "Submit", "Cancel");
	return 1;
}

forward OnLoadPersonBolos();
public OnLoadPersonBolos()
{
	new rows; cache_get_row_count(rows);
	for (new i = 0; i < rows; i++)
	{
		PBOLO[i][pbExists] = 1;
        cache_get_value_int(0, "ID", PBOLO[i][pbID]);
        cache_get_value_int(0, "facID", PBOLO[i][pbFactionID]);
        cache_get_value(0, "reporter", PBOLO[i][pbReporter], 32);
        cache_get_value(0, "suspect", PBOLO[i][pbSuspect], 32);
        cache_get_value(0, "reason", PBOLO[i][pbReason], 128);
        cache_get_value(0, "date", PBOLO[i][pbDate], 32);
	}
}

forward OnLoadVehicleBolos();
public OnLoadVehicleBolos()
{
	new rows; cache_get_row_count(rows);
	for (new i = 0; i < rows; i++)
	{
		VBOLO[i][vbExists] = 1;

        cache_get_value_int(0, "ID", VBOLO[i][vbID]);
        cache_get_value_int(0, "facID", VBOLO[i][vbFactionID]);
        cache_get_value(0, "reporter", VBOLO[i][vbReporter], 32);
        cache_get_value(0, "model", VBOLO[i][vbModel], 128);
        cache_get_value(0, "description", VBOLO[i][vbDesc], 128);
        cache_get_value(0, "reason", VBOLO[i][vbReason], 128);
        cache_get_value(0, "date", VBOLO[i][vbDate], 32);
	}
}

forward OnReloadPBolo(playerid, id);
public OnReloadPBolo(playerid, id)
{
	PBOLO[id][pbID] = cache_insert_id();

    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTRED, "[BOLO] %s %s has placed a bolo on %s",
    GetPlayerRank(playerid),
	GetRPName(playerid),
	TrimName(PBOLO[id][pbSuspect]));

	ShowAPB(playerid);
	return 1;
}

forward OnReloadVBolo(playerid, id);
public OnReloadVBolo(playerid, id)
{
	VBOLO[id][vbID] = cache_insert_id();

    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTRED, "[BOLO] %s %s has placed a vehicle bolo (Model: %s, Desc: %s)",
    GetPlayerRank(playerid),
	GetRPName(playerid),
	VBOLO[id][vbModel],
	VBOLO[id][vbDesc]);

	ShowAPB(playerid);
	return 1;
}

forward OnAddPersonBolo(playerid, suspect[], reason[]);
public OnAddPersonBolo(playerid, suspect[], reason[])
{
	new rows; cache_get_row_count(rows);
	if (rows == 0)
	{
		ShowAPB(playerid);
		return SendErrorMessage(playerid, "No such name found.");
	}

	new id = GetNextPBoloID();
	if (id == -1)
	{
		ShowAPB(playerid);
		return SendErrorMessage(playerid, "Too many active BOLO's at this time.");
	}

    cache_get_value(0, "Name", PBOLO[id][pbSuspect], 128);

	PBOLO[id][pbExists] = 1;
	PBOLO[id][pbFactionID] = PlayerInfo[playerid][pFaction];
	format(PBOLO[id][pbReporter], 32, "%s", GetUserName(playerid));
	format(PBOLO[id][pbReason], 128, "%s", reason);
	format(PBOLO[id][pbDate], 32, "%s", GetDateTime());

	new query[512];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO h_bolopersons (facID, reporter, suspect, reason, date) VALUES (%i, '%e', '%e', '%e', '%e')",
	PBOLO[id][pbFactionID],
	PBOLO[id][pbReporter],
	PBOLO[id][pbSuspect],
	PBOLO[id][pbReason],
	PBOLO[id][pbDate]
	);
	mysql_tquery(g_SQL, query, "OnReloadPBolo", "ii", playerid, id);
	return 1;
}

// dialogs
Dialog:ShowActiveVBolo(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		Players[playerid][pSelected] = BoloChooser[playerid][listitem];
		ViewSpecificVBolo(playerid, BoloChooser[playerid][listitem], DialogType[playerid]);
	}
	return 1;
}

Dialog:AddVBoloR(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		AddVehicleBolo(playerid, TempHolderV[playerid][vbModel], TempHolderV[playerid][vbDesc], inputtext);
	}
	return 1;
}

Dialog:AddVBoloD(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		format(TempHolderV[playerid][vbDesc], 128, "%s", inputtext);
		Dialog_Show(playerid, AddVBoloR, DIALOG_STYLE_INPUT, "Add Reason", "{DEDEDE}Please write the reason this vehicle is being looked for.", "Submit", "Cancel");
	}
	return 1;
}

Dialog:AddVBoloM(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		format(TempHolderV[playerid][vbModel], 128, "%s", inputtext);
		Dialog_Show(playerid, AddVBoloD, DIALOG_STYLE_INPUT, "Add Description", "{DEDEDE}Anything worth or note such as license plate or anything\nelse related to the vehicle?", "Next", "Cancel");
	}
	return 1;
}

Dialog:DeleteVBolo(playerid, response, listitem, inputtext[])
{
	if (!response) ShowActiveVBolo(playerid);
	if (response)
	{
		new id = Players[playerid][pSelected];
		if (!VBOLO[id][vbExists]) return SendErrorMessage(playerid, "BOLO doesn't exist.");
		FDeleteVBolo(id);
		SendServerMessage(playerid, "You have deleted a BOLO.");
		VBOLO[id][vbExists] = 0;
		ShowAPB(playerid);
	}
	return 1;
}

Dialog:ReadVBolo(playerid, response, listitem, inputtext[])
{
	if (!response) ShowActiveVBolo(playerid);
	if (response)
	{
		new id = Players[playerid][pSelected];
		if (!VBOLO[id][vbExists]) return SendErrorMessage(playerid, "BOLO doesn't exist.");

		SendClientMessage(playerid, COLOR_GREEN, "___________________________________________________________");
		SendClientMessageEx(playerid, COLOR_GRAD5, "Reporter: %s", TrimName(VBOLO[id][vbReporter]));
		SendClientMessageEx(playerid, COLOR_GRAD4, "Date: %s", VBOLO[id][vbDate]);
		SendClientMessageEx(playerid, COLOR_GRAD3, "Model: %s", VBOLO[id][vbModel]);
		SendClientMessageEx(playerid, COLOR_GRAD2, "Description: %s", VBOLO[id][vbDesc]);
		SendClientMessageEx(playerid, COLOR_GRAD1, "Reason: %s", VBOLO[id][vbReason]);
		SendClientMessage(playerid, COLOR_GREEN, "___________________________________________________________");
	}
	return 1;
}

Dialog:ReadPBolo(playerid, response, listitem, inputtext[])
{
	if (!response) ShowActivePBolo(playerid);
	if (response)
	{
		new id = Players[playerid][pSelected];
		if (!PBOLO[id][pbExists]) return SendErrorMessage(playerid, "BOLO doesn't exist.");

		SendClientMessage(playerid, COLOR_GREEN, "___________________________________________________________");
		SendClientMessageEx(playerid, COLOR_GRAD5, "Reporter: %s", TrimName(PBOLO[id][pbReporter]));
		SendClientMessageEx(playerid, COLOR_GRAD4, "Date: %s", PBOLO[id][pbDate]);
		SendClientMessageEx(playerid, COLOR_GRAD3, "Suspect: %s", TrimName(PBOLO[id][pbSuspect]));
		SendClientMessageEx(playerid, COLOR_GRAD2, "Reason: %s", PBOLO[id][pbReason]);
		SendClientMessage(playerid, COLOR_GREEN, "___________________________________________________________");
	}
	return 1;
}

Dialog:DeletePBolo(playerid, response, listitem, inputtext[])
{
	if (!response) ShowActivePBolo(playerid);
	if (response)
	{
		new id = Players[playerid][pSelected];
		if (!PBOLO[id][pbExists]) return SendErrorMessage(playerid, "BOLO doesn't exist.");
		DeletePBolo(id);
		SendServerMessage(playerid, "You have deleted a BOLO.");
		PBOLO[id][pbExists] = 0;
		ShowAPB(playerid);
	}
	return 1;
}

Dialog:ShowActivePBolo(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		Players[playerid][pSelected] = BoloChooser[playerid][listitem];
		ViewSpecificPBolo(playerid, BoloChooser[playerid][listitem], DialogType[playerid]);
	}
	return 1;
}

Dialog:AddPBoloR(playerid, response, listitem, inputtext[])
{
	if (!response) ShowAPB(playerid);
	if (response)
	{
		AddPBolo(playerid, TempHolderP[playerid][pbSuspect], inputtext);
	}
	return 1;
}

Dialog:AddPBoloS(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		new id = GetPlayeridByName(inputtext);
		if (IsPlayerConnected(id) && Player[id][IsLoggedIn])
		{
			format(TempHolderP[playerid][pbSuspect], 32, "%s", GetUserName(id));
			Dialog_Show(playerid, AddPBoloR, DIALOG_STYLE_INPUT, "Add Reason", "{DEDEDE}Please write the reason this person is being looked for.", "Submit", "Cancel");
			return 1;
		}

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT CharacterID, Name FROM characters WHERE Name = '%e'", inputtext);
		mysql_tquery(g_SQL, query, "CheckPlayerName", "i", playerid);
	}
	return 1;
}


Dialog:ChooseBolo(playerid, response, listitem, inputtext[])
{
	if (!response) return ShowAPB(playerid);
	if (response)
	{
		if (listitem == 0)
		{
			if (DialogType[playerid] == TYPE_CREATE)
			{
				return Dialog_Show(playerid, AddPBoloS, DIALOG_STYLE_INPUT, "Add Suspect", "{DEDEDE}Please write the name of the suspect ((or the ID if player is online)):", "Next", "Cancel");
			}
			ShowActivePBolo(playerid);
		}
		else if (listitem == 1)
		{
			if (DialogType[playerid] == TYPE_CREATE)
			{
				return Dialog_Show(playerid, AddVBoloM, DIALOG_STYLE_INPUT, "Add Model", "{DEDEDE}Please write the model type of the vehicle.", "Next", "Cancel");
			}
			ShowActiveVBolo(playerid);
		}
	}
	return 1;
}

Dialog:ShowAPB(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch(listitem)
		{
			case 0: DialogType[playerid] = TYPE_READ;
			case 1:	DialogType[playerid] = TYPE_CREATE;
			case 2: DialogType[playerid] = TYPE_DELETE;
		}
		Dialog_Show(playerid, ChooseBolo, DIALOG_STYLE_LIST, "BOLO Type", "Persons\nVehicles", "Select", "Back");
	}
	return 1;
}

CMD:bolo(playerid, params[])
{
	new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(!FactionInfo[factionid][FactionMDC])
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

	ShowAPB(playerid);
	return 1;
}