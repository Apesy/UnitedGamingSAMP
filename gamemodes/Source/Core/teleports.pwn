//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#include <YSI\y_hooks>

stock LoadTeleports()
{
    new rows;
    new Cache:result;
    new query[128];

    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `teleports` LIMIT %d", MAX_TELEPORTS);
    result = mysql_query(g_SQL, query);

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            TeleportCache = cache_save();
            cache_get_value_int(i, "ID", TeleportInfo[i][teleID]);
            cache_get_value_float(i, "X", TeleportInfo[i][teleX]);
            cache_get_value_float(i, "Y", TeleportInfo[i][teleY]);
            cache_get_value_float(i, "Z", TeleportInfo[i][teleZ]);
            cache_get_value_float(i, "A", TeleportInfo[i][teleA]);
            cache_get_value(i, "Name", TeleportInfo[i][teleName], 128);
            cache_get_value_int(i, "World", TeleportInfo[i][teleWorld]);
            cache_get_value_int(i, "Interior", TeleportInfo[i][teleInterior]);
            cache_get_value(i, "AddedBy", TeleportInfo[i][teleAddedBy], MAX_PLAYER_NAME+1);
            cache_get_value(i, "AddedDate", TeleportInfo[i][teleAddedDate], 32);

            cache_set_active(TeleportCache);
        }
    }
    cache_delete(result); 
}

stock GetNextTeleportID()
{
	for (new i = 0; i < MAX_TELEPORTS; i++)
	{
		if (!TeleportInfo[i][teleID])
		{
			return i;
		}
	}
	return -1;
}

CMD:teleports(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        SendClientMessage(playerid, -1, "Active Teleports:");
        for(new i; i < MAX_TELEPORTS; i++)
        {
            if(TeleportInfo[i][teleID])
            {
                SendClientMessageEx(playerid, COLOR_GREY, "%d. %s", i, TeleportInfo[i][teleName]);
            }
        }
    }
    return 1;
}

CMD:addtp(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/addtp [Name] - Example: /addteleport BCSD");
        
        new id = GetNextTeleportID();
        if(id == -1)
            return SendErrorMessage(playerid, "The teleport limit has been reached. (Limit: %d)", MAX_TELEPORTS);

        new Float:x, Float:y, Float:z, Float:a, interior = GetPlayerInterior(playerid), world = GetPlayerVirtualWorld(playerid);
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        TeleportInfo[id][teleX] = x;
        TeleportInfo[id][teleY] = y;
        TeleportInfo[id][teleZ] = z;
        TeleportInfo[id][teleA] = a;
        TeleportInfo[id][teleWorld] = world;
        TeleportInfo[id][teleInterior] = interior;
        
        format(TeleportInfo[id][teleName], 128, "%s", params);
        format(TeleportInfo[id][teleAddedBy], 25, "%s", GetMasterName(playerid));
        format(TeleportInfo[id][teleAddedDate], 32, "%s", GetDateTime());

        new query[512];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO teleports (Name, AddedBy, AddedDate, X, Y, Z, A, World, Interior) VALUES ('%e', '%e', '%e', %f, %f, %f, %f, %i, %i)",
        TeleportInfo[id][teleName],
        TeleportInfo[id][teleAddedBy],
        TeleportInfo[id][teleAddedDate],
        TeleportInfo[id][teleX],
        TeleportInfo[id][teleY],
        TeleportInfo[id][teleZ],
        TeleportInfo[id][teleA],
        TeleportInfo[id][teleWorld],
        TeleportInfo[id][teleInterior]);
        mysql_tquery(g_SQL, query, "OnAddTeleport", "ii", playerid, id);
    }
    return 1;
}

CMD:deletetp(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/deletetp [Teleport ID]");
        
        if(!TeleportInfo[id][teleID])
            return SendErrorMessage(playerid, "Teleport ID is invalid, see /teleports.");

        TeleportInfo[id][teleX] = 0.0;
        TeleportInfo[id][teleY] = 0.0;
        TeleportInfo[id][teleZ] = 0.0;
        TeleportInfo[id][teleA] = 0.0;
        TeleportInfo[id][teleWorld] = 0;
        TeleportInfo[id][teleInterior] = 0;
        
        TeleportInfo[id][teleName][0] = 0;
        TeleportInfo[id][teleAddedBy][0] = 0;
        TeleportInfo[id][teleAddedDate][0] = 0;
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have added teleport %d.", id);

        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM teleports WHERE ID = %d",
        TeleportInfo[id][teleID]);
        mysql_tquery(g_SQL, query);
    }
    return 1;
}

function OnAddTeleport(playerid, id)
{
	TeleportInfo[id][teleID] = cache_insert_id();
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have added teleport %s.", TeleportInfo[id][teleName]);
	return 1;
}

hook OnPlayerConnect(playerid)
{
    for(new i; i < MAX_TELEPORTS; i++)
    {
        TeleportHolder[playerid][i] = -1;
    }
    return 1;
}

Dialog:AdminTeleport(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new i = TeleportHolder[playerid][listitem];
		
		SetVirtualWorld(playerid, TeleportInfo[i][teleWorld]);
		SetInterior(playerid, TeleportInfo[i][teleInterior]);
		SetPlayerPosEx(playerid, TeleportInfo[i][teleX], TeleportInfo[i][teleY], TeleportInfo[i][teleZ]);
        SendTeleportMessage(playerid);
	}
	return 1;
}

Dialog:AdminTeleportPlayer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new i = TeleportHolder[playerid][listitem], targetid = TempVar[playerid][TeleportID];
		
        if(IsPlayerConnected(targetid))
        {
            SetVirtualWorld(targetid, TeleportInfo[i][teleWorld]);
            SetInterior(targetid, TeleportInfo[i][teleInterior]);
            SetPlayerPosEx(targetid, TeleportInfo[i][teleX], TeleportInfo[i][teleY], TeleportInfo[i][teleZ]);
            SendTeleportMessage(targetid);
        }
        else SendErrorMessage(playerid, "/sendto PlayerID disconnected.");
	}
	return 1;
}