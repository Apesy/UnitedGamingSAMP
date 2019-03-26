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
    Design Info:
    Commands: /editlabel
*/

#define MAX_LABELS 100

enum labelEnum
{
    LabelID,
    LabelText[128],
    LabelColour,
    Float:LabelX,
    Float:LabelY,
    Float:LabelZ,   
    LabelWorld,
    LabelInterior,
    Float:LabelDistance,

    Text3D:LabelLabel
}
new LabelInfo[MAX_LABELS][labelEnum];

stock GetNextLabelID()
{
    for(new i; i < MAX_LABELS; i++)
    {
        if(!LabelInfo[i][LabelID])
        {
            return i;
        }
    }
    return -1;
}

stock UpdateLabel(id)
{
    if(!LabelInfo[id][LabelID])
    {
        return 0;
    }

    if (IsValidDynamic3DTextLabel(LabelInfo[id][LabelLabel]))
	{
		DestroyDynamic3DTextLabel(LabelInfo[id][LabelLabel]);
	}

	LabelInfo[id][LabelLabel] = CreateDynamic3DTextLabel(LabelInfo[id][LabelText], LabelInfo[id][LabelColour], LabelInfo[id][LabelX], LabelInfo[id][LabelY], LabelInfo[id][LabelZ], LabelInfo[id][LabelDistance], .testlos = 0, .worldid = LabelInfo[id][LabelWorld], .interiorid = LabelInfo[id][LabelInterior]);
    return 1;
}

stock ResetLabel(id)
{
    if (IsValidDynamic3DTextLabel(LabelInfo[id][LabelLabel]))
	{
		DestroyDynamic3DTextLabel(LabelInfo[id][LabelLabel]);
	}

    LabelInfo[id][LabelID] = 0;
    LabelInfo[id][LabelText][0] = 0;
    LabelInfo[id][LabelColour] = 0;
    LabelInfo[id][LabelX] = 0;
    LabelInfo[id][LabelY] = 0;
    LabelInfo[id][LabelZ] = 0;
    LabelInfo[id][LabelWorld] = 0;
    LabelInfo[id][LabelInterior] = 0;
    LabelInfo[id][LabelDistance] = 0;
    return 1;
}

stock LoadLabels()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `labels`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            gateCache = cache_save();
            cache_get_value_int(i, "ID", LabelInfo[i][LabelID]);

            cache_get_value(i, "Text", LabelInfo[i][LabelText], 128);
            cache_get_value_int(i, "Colour", LabelInfo[i][LabelColour]);

            cache_get_value_float(i, "X", GateInfo[i][LabelX]);
            cache_get_value_float(i, "Y", GateInfo[i][LabelY]);
            cache_get_value_float(i, "Z", GateInfo[i][LabelZ]);

            cache_get_value_int(i, "World", LabelInfo[i][LabelWorld]);
            cache_get_value_int(i, "Interior", LabelInfo[i][LabelInterior]);
            cache_get_value_float(i, "Distance", GateInfo[i][LabelDistance]);
            
            UpdateLabel(i);
            cache_set_active(gateCache);
        }
    }
    cache_delete(result); 
}

stock SaveLabel(id)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `labels` SET \
    `Text` = '%e', \
    `Colour` = %d, \
    `X` = %f, \
    `Y` = %f, \
    `Z` = %f, \
    `World` = %d, \
    `Interior` = %d, \
    `Distance` = %f \
    WHERE `ID` = %d", LabelInfo[id][LabelText],
    LabelInfo[id][LabelColour],
    LabelInfo[id][LabelX],
    LabelInfo[id][LabelY],
    LabelInfo[id][LabelZ],
    LabelInfo[id][LabelWorld],
    LabelInfo[id][LabelInterior],
    LabelInfo[id][LabelDistance],
    LabelInfo[id][LabelID]);
    mysql_tquery(g_SQL, query);
}

stock SaveLabels()
{
    for(new i; i < MAX_LABELS; i++)
    {
        if(LabelInfo[i][LabelID])
        {
            SaveLabel(i);
        }
    }
}

CMD:labelhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Label Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /labelid, /editlabel, /createlabel, /deletelabel.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:labelid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessage(playerid, -1, "Nearest Labels:");
        for(new i; i < MAX_LABELS; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, LabelInfo[i][LabelDistance], LabelInfo[i][LabelX], LabelInfo[i][LabelY], LabelInfo[i][LabelZ]))
            {
                SendClientMessageEx(playerid, COLOR_GRAD5, "%d: %s", i, LabelInfo[i][LabelText]);
            }
        }
    }
    return 1;
}

CMD:editlabel(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id, text[128];
        if(sscanf(params, "ds[128]", id, text))
            return SendUsageMessage(playerid, "/editlabel [Label ID] [Text] - See /labelid for label ID.");
        
        format(LabelInfo[id][LabelText], 128, "%s", text);
        UpdateLabel(id);
        SaveLabel(id);
    }
    return 1;
}

CMD:deletelabel(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/deletelabel [Label ID] - See /labelid for label ID.");
        
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM Dynamic_Labels Where ID = %d", LabelInfo[id][LabelID]);
        mysql_tquery(g_SQL, query, "OnDeleteLabel", "ii", playerid, id);
    }
    return 1;
}

function OnDeleteLabel(playerid, id)
{
    ResetLabel(id);
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Label %d has been removed.", id);
}

CMD:createlabel(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/createlabel [Text]");
        
        new id = GetNextLabelID();
        if(id == -1)
            return SendErrorMessage(playerid, "The label limit (%d) has been reached.", MAX_LABELS);
        
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO Dynamic_Labels (Text, AddedBy, AddedDate) VALUES ('%e', '%e', '%e')", LabelInfo[id][LabelText], GetMasterName(playerid), GetDateTime());
        mysql_tquery(g_SQL, query, "OnAddLabel", "iis", playerid, id, params);
    }
    return 1;
}

function OnAddLabel(playerid, id, text[])
{
    LabelInfo[id][LabelID] = cache_insert_id();
	LabelInfo[id][LabelColour] = -1;
	LabelInfo[id][LabelWorld] = GetPlayerVirtualWorld(playerid);
	LabelInfo[id][LabelInterior] = GetPlayerInterior(playerid);

    strreplace(text, "~n~", "\n", .maxlenght = 144);
	format(LabelInfo[id][LabelText], 144, "%s", text);

	GetPlayerPos(playerid, LabelInfo[id][LabelX], LabelInfo[id][LabelY], LabelInfo[id][LabelZ]);
	LabelInfo[id][LabelDistance] = 20.0;

    UpdateLabel(id);
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have added label %i.", id);
}