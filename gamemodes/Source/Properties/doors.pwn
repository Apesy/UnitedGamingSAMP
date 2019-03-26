//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum gateEnum
{
    GateID,
    GateFactionID,
    GateLocked,
    GateLinkedID,
    Float:GateClosedPosX,
    Float:GateClosedPosY,
    Float:GateClosedPosZ,
    Float:GateClosedPosRX,
    Float:GateClosedPosRY,
    Float:GateClosedPosRZ,
    Float:GateOpenPosX,
    Float:GateOpenPosY,
    Float:GateOpenPosZ,
    Float:GateOpenPosRX,
    Float:GateOpenPosRY,
    Float:GateOpenPosRZ,
    GateInterior,
    GateVW,
    Float:GateSpeed,
    Float:GateRange,
    GateModelID,
    GateCode,
    GateCloseSeconds,

    GateObjectID
}
new GateInfo[MAX_GATES][gateEnum],
    bool:GateOpened[MAX_GATES],
    Cache:gateCache;

stock LoadGates()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `gates`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            gateCache = cache_save();
            cache_get_value_int(i, "ID", GateInfo[i][GateID]);

            cache_get_value_int(i, "FactionID", GateInfo[i][GateFactionID]);
            cache_get_value_int(i, "Locked", GateInfo[i][GateLocked]);
            cache_get_value_int(i, "Type", GateInfo[i][GateLinkedID]);

            cache_get_value_float(i, "ClosedPosX", GateInfo[i][GateClosedPosX]);
            cache_get_value_float(i, "ClosedPosY", GateInfo[i][GateClosedPosY]);
            cache_get_value_float(i, "ClosedPosZ", GateInfo[i][GateClosedPosZ]);
            cache_get_value_float(i, "ClosedPosRX", GateInfo[i][GateClosedPosRX]);
            cache_get_value_float(i, "ClosedPosRY", GateInfo[i][GateClosedPosRY]);
            cache_get_value_float(i, "ClosedPosRZ", GateInfo[i][GateClosedPosRZ]);

            cache_get_value_float(i, "OpenPosX", GateInfo[i][GateOpenPosX]);
            cache_get_value_float(i, "OpenPosY", GateInfo[i][GateOpenPosY]);
            cache_get_value_float(i, "OpenPosZ", GateInfo[i][GateOpenPosZ]);
            cache_get_value_float(i, "OpenPosRX", GateInfo[i][GateOpenPosRX]);
            cache_get_value_float(i, "OpenPosRY", GateInfo[i][GateOpenPosRY]);
            cache_get_value_float(i, "OpenPosRZ", GateInfo[i][GateOpenPosRZ]);

            cache_get_value_int(i, "Interior", GateInfo[i][GateInterior]);
            cache_get_value_int(i, "VW", GateInfo[i][GateVW]);
            cache_get_value_float(i, "Speed", GateInfo[i][GateSpeed]);
            cache_get_value_float(i, "Distance", GateInfo[i][GateRange]);
            cache_get_value_int(i, "ModelID", GateInfo[i][GateModelID]);
            cache_get_value_int(i, "Code", GateInfo[i][GateCode]);
            cache_get_value_int(i, "CloseSeconds", GateInfo[i][GateCloseSeconds]);
            
            UpdateGate(i);
            Iter_Add(Gates,i);
            cache_set_active(gateCache);
        }
    }
    cache_delete(result); 
}

function Query_LoadGates()
{
    if(!cache_num_rows())
		return 1;

	new rows = cache_num_rows();

	for(new i = 0; i < rows && i < MAX_GATES; i++)
	{
        cache_get_value_int(i, "ID", GateInfo[i][GateID]);

        cache_get_value_int(i, "FactionID", GateInfo[i][GateFactionID]);
        cache_get_value_int(i, "Locked", GateInfo[i][GateLocked]);
        cache_get_value_int(i, "Type", GateInfo[i][GateLinkedID]);

        cache_get_value_float(i, "ClosedPosX", GateInfo[i][GateClosedPosX]);
        cache_get_value_float(i, "ClosedPosY", GateInfo[i][GateClosedPosY]);
        cache_get_value_float(i, "ClosedPosZ", GateInfo[i][GateClosedPosZ]);
        cache_get_value_float(i, "ClosedPosRX", GateInfo[i][GateClosedPosRX]);
        cache_get_value_float(i, "ClosedPosRY", GateInfo[i][GateClosedPosRY]);
        cache_get_value_float(i, "ClosedPosRZ", GateInfo[i][GateClosedPosRZ]);

        cache_get_value_float(i, "OpenPosX", GateInfo[i][GateOpenPosX]);
        cache_get_value_float(i, "OpenPosY", GateInfo[i][GateOpenPosY]);
        cache_get_value_float(i, "OpenPosZ", GateInfo[i][GateOpenPosZ]);
        cache_get_value_float(i, "OpenPosRX", GateInfo[i][GateOpenPosRX]);
        cache_get_value_float(i, "OpenPosRY", GateInfo[i][GateOpenPosRY]);
        cache_get_value_float(i, "OpenPosRZ", GateInfo[i][GateOpenPosRZ]);

        cache_get_value_int(i, "Interior", GateInfo[i][GateInterior]);
        cache_get_value_int(i, "VW", GateInfo[i][GateVW]);
        cache_get_value_float(i, "Speed", GateInfo[i][GateSpeed]);
        cache_get_value_float(i, "Distance", GateInfo[i][GateRange]);
        cache_get_value_int(i, "ModelID", GateInfo[i][GateModelID]);
        cache_get_value_int(i, "Code", GateInfo[i][GateCode]);
        cache_get_value_int(i, "CloseSeconds", GateInfo[i][GateCloseSeconds]);
        
        UpdateGate(i);
	}
    return 1;
}

new GateAutoClose[MAX_GATES];

function CloseGate(i)
{
    MoveDynamicObject(GateInfo[i][GateObjectID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], GateInfo[i][GateSpeed],GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ]);
    GateOpened[i] = false;
    return 1;
}

stock ToggleGate(playerid, i)
{
    if(GateOpened[i] == false)
    {
        for (new link = 0; link < MAX_GATES; link++)
		{
			if (GateInfo[link][GateID] && link != i && GateInfo[link][GateLinkedID] == GateInfo[i][GateID])
			{
                if(GateInfo[i][GateCloseSeconds] > 0)
                {
                    GateAutoClose[link] = SetTimerEx("CloseGate", GateInfo[link][GateCloseSeconds]*1000, false, "d", link);
                }
				MoveDynamicObject(GateInfo[link][GateObjectID], GateInfo[link][GateOpenPosX], GateInfo[link][GateOpenPosY], GateInfo[link][GateOpenPosZ], GateInfo[link][GateSpeed],GateInfo[link][GateOpenPosRX], GateInfo[link][GateOpenPosRY], GateInfo[link][GateOpenPosRZ]);
				GateOpened[link] = true;
			}
		}

        SendAMe(playerid, "opens the gate/door.");
        MoveDynamicObject(GateInfo[i][GateObjectID], GateInfo[i][GateOpenPosX], GateInfo[i][GateOpenPosY], GateInfo[i][GateOpenPosZ], GateInfo[i][GateSpeed],GateInfo[i][GateOpenPosRX], GateInfo[i][GateOpenPosRY], GateInfo[i][GateOpenPosRZ]);
        GateOpened[i] = true;
        if(GateInfo[i][GateCloseSeconds] > 0)
        {
            GateAutoClose[i] = SetTimerEx("CloseGate", GateInfo[i][GateCloseSeconds]*1000, false, "d", i);
        }
    }
    else
    {
        for (new link = 0; link < MAX_GATES; link++)
		{
			if (GateInfo[link][GateID] && link != i && GateInfo[link][GateLinkedID] == GateInfo[i][GateID])
			{
				MoveDynamicObject(GateInfo[link][GateObjectID], GateInfo[link][GateClosedPosX], GateInfo[link][GateClosedPosY], GateInfo[link][GateClosedPosZ], GateInfo[link][GateSpeed],GateInfo[link][GateClosedPosRX], GateInfo[link][GateClosedPosRY], GateInfo[link][GateClosedPosRZ]);
				GateOpened[link] = false;
                KillTimer(GateAutoClose[link]);
			}
		}

        SendAMe(playerid, "closes the gate/door.");
        MoveDynamicObject(GateInfo[i][GateObjectID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], GateInfo[i][GateSpeed],GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ]);
        GateOpened[i] = false;
        KillTimer(GateAutoClose[i]);
    }
}

Dialog:GatePasswordCheck(playerid, response, listitem, inputtext[])
{
	new i = GetPVarInt(playerid, "GateID");
	if (response)
	{
		if (!GateInfo[i][GateID])
			return SendErrorMessage(playerid, "Gate does not exist any more.");

        if(isnull(inputtext) || IsNumeric(inputtext))
        {
			SendErrorMessage(playerid, "You must insert a code which is a number.");
			return Dialog_Show(playerid, GatePasswordCheck, DIALOG_STYLE_INPUT, "Password", "Please input the correct password.", "Submit", "Cancel");
		}
		
		new val = strval(inputtext);
		if (val == GateInfo[i][GateCode])
		{
			ToggleGate(playerid, i);
		}
		else
		{
			SendErrorMessage(playerid, "You have input the incorrect code, please try again.");
			return Dialog_Show(playerid, GatePasswordCheck, DIALOG_STYLE_INPUT, "Password", "Please input the correct password.", "Submit", "Cancel");
		}
	}
	return 1;
}

CMD:gate(playerid, params[])
{
    new i = IsPlayerNearGate(playerid);
    if(i == -1)
        return SendErrorMessage(playerid, "You are not near any gate.");
    
    if(GateInfo[i][GateCode] && TempVar[playerid][AdminDuty] == false)
    {
        SetPVarInt(playerid, "GateID", i);
        Dialog_Show(playerid, GatePasswordCheck, DIALOG_STYLE_INPUT, "Password", "Please input the correct password.", "Submit", "Cancel");
        return 1;
    }

    if(GateInfo[i][GateFactionID] > 0 && PlayerInfo[playerid][pFaction] != GateInfo[i][GateFactionID])
    {
        if(TempVar[playerid][AdminDuty] == false)
        {
            SendErrorMessage(playerid, "You cannot access this gate.");
            return 1;
        }
    }

    ToggleGate(playerid, i);
    return 1;
}
alias:gate("door", "doors", "gates", "open", "close", "barrier");

stock SaveGates()
{
    for(new i; i < MAX_GATES; i++)
    {
        SaveGate(i);
    }
    return 1;
}

stock SaveGate(i)
{
    if(GateInfo[i][GateID])
    {
        new query[256];
        mysql_format(g_SQL, query, sizeof query, "UPDATE gates SET FactionID = %d, Locked = %d, Type = %d WHERE ID = %d LIMIT 1", 
        GateInfo[i][GateFactionID], GateInfo[i][GateLocked], GateInfo[i][GateLinkedID], GateInfo[i][GateID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof query, "UPDATE gates SET ClosedPosX = %f, ClosedPosY = %f, ClosedPosZ = %f, ClosedPosRX = %f, ClosedPosRY = %f, ClosedPosRZ = %f WHERE ID = %d LIMIT 1", 
        GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ],GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ], GateInfo[i][GateID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof query, "UPDATE gates SET OpenPosX = %f, OpenPosY = %f, OpenPosZ = %f, OpenPosRX = %f, OpenPosRY = %f, OpenPosRZ = %f WHERE ID = %d LIMIT 1", 
        GateInfo[i][GateOpenPosX], GateInfo[i][GateOpenPosY], GateInfo[i][GateOpenPosZ],GateInfo[i][GateOpenPosRX], GateInfo[i][GateOpenPosRY], GateInfo[i][GateOpenPosRZ], GateInfo[i][GateID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof query, "UPDATE gates SET Interior = %d, VW = %d WHERE ID = %d LIMIT 1", 
        GateInfo[i][GateInterior], GateInfo[i][GateVW], GateInfo[i][GateID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof query, "UPDATE gates SET Speed = %f, Distance = %f, ModelID = %d, Code = %d WHERE ID = %d LIMIT 1", 
        GateInfo[i][GateSpeed], GateInfo[i][GateRange], GateInfo[i][GateModelID], GateInfo[i][GateCode], GateInfo[i][GateID]);
        mysql_tquery(g_SQL, query);
    }
}

stock UpdateGate(i)
{
    if(!GateInfo[i][GateID])
    {
        return 0;
    }

    if(IsValidDynamicObject(GateInfo[i][GateObjectID]))
    {
        DestroyDynamicObject(GateInfo[i][GateObjectID]);
    }

    GateInfo[i][GateObjectID] = CreateDynamicObject(GateInfo[i][GateModelID], 
    GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], 
    GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ], 
    GateInfo[i][GateVW], GateInfo[i][GateInterior]);

    if(GateOpened[i] == true)
    {
        SetDynamicObjectPos(GateInfo[i][GateObjectID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ]);
        SetDynamicObjectRot(GateInfo[i][GateObjectID], GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ]);
    }
    return 1;
}

stock ResetGate(i)
{
    if (IsValidDynamicObject(GateInfo[i][GateObjectID]))
	{
		DestroyDynamicObject(GateInfo[i][GateObjectID]);
	}

    GateInfo[i][GateFactionID] = 0;
    GateInfo[i][GateModelID] = 0;
    GateInfo[i][GateCode] = 0;

    GateInfo[i][GateClosedPosX] = 0;
    GateInfo[i][GateClosedPosY] = 0;
    GateInfo[i][GateClosedPosZ] = 0;
    GateInfo[i][GateClosedPosRX] = 0;
    GateInfo[i][GateClosedPosRY] = 0;
    GateInfo[i][GateClosedPosRZ] = 0;
    GateInfo[i][GateOpenPosX] = 0;
    GateInfo[i][GateOpenPosY] = 0;
    GateInfo[i][GateOpenPosZ] = 0;
    GateInfo[i][GateOpenPosRX] = 0;
    GateInfo[i][GateOpenPosRY] = 0;
    GateInfo[i][GateOpenPosRZ] = 0;
    GateInfo[i][GateVW] = 0;
    GateInfo[i][GateInterior] = 0;
}

function OnCreateGate(playerid, i, factionid, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    GateInfo[i][GateID] = cache_insert_id();

    GateInfo[i][GateFactionID] = factionid;
    GateInfo[i][GateModelID] = modelid;
    GateInfo[i][GateCode] = 0;

    GateInfo[i][GateClosedPosX] = x;
    GateInfo[i][GateClosedPosY] = y;
    GateInfo[i][GateClosedPosZ] = z;
    GateInfo[i][GateClosedPosRX] = rx;
    GateInfo[i][GateClosedPosRY] = ry;
    GateInfo[i][GateClosedPosRZ] = rz;
    GateInfo[i][GateVW] = GetPlayerVirtualWorld(playerid);
    GateInfo[i][GateInterior] = GetPlayerInterior(playerid);

    UpdateGate(i);

    TempVar[playerid][EditType] = EDIT_TYPE_GATE_CLOSEDPOS;
    TempVar[playerid][EditingGateClosed] = GateInfo[i][GateID];
    EditDynamicObject(playerid, GateInfo[i][GateObjectID]);

    new string[128];
    format(string, sizeof string, "%s %s has created a new gate at %s. (GateID: %d)", GetAdminRank(playerid), GetMasterName(playerid), ReturnLocation(playerid), GateInfo[i][GateID]);
    SendAdminCommand(string, 4);
    return 1;
}

stock IsPlayerNearGate(playerid)
{
    //new Float:bestrange = 21.0;
	//new bestid = -1;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
    for(new i; i < MAX_GATES; i++)
    {
        if(GateInfo[i][GateID] && IsPlayerInRangeOfPoint(playerid, GateInfo[i][GateRange], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ]))
        {
            if(GetPlayerVirtualWorld(playerid) == GateInfo[i][GateVW] && GetPlayerInterior(playerid) == GateInfo[i][GateInterior])
            {
                return i;
                /*new Float:range = floatsqroot(((x - GateInfo[i][GateClosedPosX]) * (x - GateInfo[i][GateClosedPosX])) + ((y - GateInfo[i][GateClosedPosY]) * (y - GateInfo[i][GateClosedPosZ])));
                if (range <= bestrange)
                {
                    bestid = i;
                    bestrange = range;
                }*/
            }
        }
    }
    return-1;
}

CMD:gatehelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Admin Gate Help:{FFFFFF} Type a command for more information.");
        SendClientMessage(playerid, COLOR_GRAD5, "Commands: /creategate, /deletegate, /editgate");
        SendClientMessage(playerid, COLOR_GRAD4, "Commands: /gateid, /gotogate");
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:creategate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new modelID, factionID;
        if(sscanf(params, "dd", modelID, factionID))
            return SendUsageMessage(playerid, "/creategate [Model ID] [FactionID] - See dev.prineside.com for gates.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        for(new i = 0; i < MAX_GATES; i++)
        {
            if(!GateInfo[i][GateID])
            {
                new queryBuffer[256];
                mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "INSERT INTO gates (FactionID, ClosedPosX, ClosedPosY, ClosedPosZ, ModelID) VALUES(%d, %f, %f, %f, %i)", FactionID, x, y, z, modelID);
                mysql_tquery(g_SQL, queryBuffer, "OnCreateGate", "iiiiffffff", playerid, i, factionID, modelID, x, y, z, 0, 0, 0);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance slots are currently full.");
    }
    return 1;
}

CMD:gotogate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new gateID;
        if(sscanf(params, "d", gateID))
            return SendUsageMessage(playerid, "/gotogate [Gate ID]");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        for(new i = 0; i < MAX_GATES; i++)
        {
            if(GateInfo[i][GateID] == gateID)
            {
                SetPlayerPosEx(playerid, GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ]+0.5);
                SetPlayerInterior(playerid, GateInfo[i][GateInterior]);
                SetPlayerVirtualWorld(playerid, GateInfo[i][GateVW]);
                if(GateInfo[i][GateInterior] > 0)
                {
                    TogglePlayerWait(playerid);
                }
                SendTeleportMessage(playerid);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Cannot find gate %d.", gateID);
    }
    return 1;
}

CMD:gateid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_WHITE, "Nearest gates...");
        for(new i = 0; i < MAX_GATES; i++)
        {
            if(GateInfo[i][GateID] > 0)
            {
                if(IsPlayerInRangeOfPoint(playerid, 20.0, GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ]))
                {
                    SendClientMessageEx(playerid, COLOR_GRAD5, "ID: %d, Model: %d, Code: %d", GateInfo[i][GateID], GateInfo[i][GateModelID], GateInfo[i][GateCode]);
                }
            }
        }
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:duplicategate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new gateID;
        if(sscanf(params, "d", gateID))
            return SendUsageMessage(playerid, "/duplicategate [Gate ID] - /gateid.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        for(new i = 0; i < MAX_GATES; i++)
        {
            if(GateInfo[i][GateID] == gateID)
            {
                for(new d = 0; d < MAX_GATES; d++)
                {
                    if(!GateInfo[d][GateID])
                    {
                        new queryBuffer[256];
                        mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "INSERT INTO gates (FactionID, ClosedPosX, ClosedPosY, ClosedPosZ, ModelID) VALUES(%d, %f, %f, %f, %i)", GateInfo[i][GateFactionID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], GateInfo[i][GateModelID]);
                        mysql_tquery(g_SQL, queryBuffer, "OnCreateGate", "iiiifff", playerid, d, GateInfo[i][GateFactionID], GateInfo[i][GateModelID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], GateInfo[i][GateClosedPosRX], GateInfo[i][GateClosedPosRY], GateInfo[i][GateClosedPosRZ]);
                        return 1;
                    }
                }
            }
        }
        SendErrorMessage(playerid, "Gate slots are currently full.");
    }
    return 1;
}

CMD:deletegate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new gateID;
        if(sscanf(params, "d", gateID))
            return SendUsageMessage(playerid, "/creategate [Gate ID] - /gateid.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        for(new i = 0; i < MAX_GATES; i++)
        {
            if(GateInfo[i][GateID] == gateID)
            {
                new queryBuffer[256];
                mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "DELETE FROM gates WHERE ID = %d LIMIT 1", gateID);
                mysql_tquery(g_SQL, queryBuffer);
                ResetGate(i);
                DestroyDynamicObject(GateInfo[i][GateObjectID]);
                SendServerMessage(playerid, "Gate %d has been destroyed.", gateID);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Gate slots are currently full.");
    }
    return 1;
}

CMD:editgate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new gateID, option[32], param[32];
        if(sscanf(params, "ds[14]S()[64]", gateID, option, param))
        {
            SendUsageMessage(playerid, "/editgate [Gate ID] [Option] [Param]");
            SendClientMessage(playerid, -1, "Options: OpenPos, ClosedPos, FactionID, ModelID");
            SendClientMessage(playerid, -1, "Options: Speed, LinkedID, Locked, Range, AutoClose");
            return 1;
        }

        if(TempVar[playerid][EditType] > 0)
            return SendErrorMessage(playerid, "You are already editing something.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        for(new i = 0; i < MAX_GATES; i++)
        {
            if(GateInfo[i][GateID] == gateID)
            {
                if(strcmp(option, "closedpos", true) == 0)
                {
                    TempVar[playerid][EditType] = EDIT_TYPE_GATE_CLOSEDPOS;
                    TempVar[playerid][EditingGateClosed] = GateInfo[i][GateID];
                    EditDynamicObject(playerid, GateInfo[i][GateObjectID]);
                }
                else if(strcmp(option, "openpos", true) == 0)
                {
                    TempVar[playerid][EditType] = EDIT_TYPE_GATE_OPENPOS;
                    TempVar[playerid][EditingGateOpen] = GateInfo[i][GateID];
                    EditDynamicObject(playerid, GateInfo[i][GateObjectID]);
                }
                else if(strcmp(option, "factionid", true) == 0)
                {
                    new factionid;
                    if(sscanf(param, "d", factionid))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] FactionID [Faction ID]");
                    }

                    GateInfo[i][GateFactionID] = factionid;
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d faction id set to %d.", gateID, factionid);
                }
                else if(strcmp(option, "modelid", true) == 0)
                {
                    new modelid;
                    if(sscanf(param, "d", modelid))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] ModelID [Model ID] - See dev.prineside.com for model ids.");
                    }

                    GateInfo[i][GateModelID] = modelid;
                    UpdateGate(i);
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d model id set to %d.", gateID, modelid);
                }
                else if(strcmp(option, "code", true) == 0)
                {
                    new code;
                    if(sscanf(param, "d", code))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] Code [Code]");
                    }

                    GateInfo[i][GateCode] = code;
                    UpdateGate(i);
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d code set to %d.", gateID, code);
                }
                else if(strcmp(option, "linkedid", true) == 0)
                {
                    new linkedid;
                    if(sscanf(param, "d", linkedid))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] Code [Code]");
                    }

                    GateInfo[i][GateLinkedID] = linkedid;
                    UpdateGate(i);
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d has been linked to Gate %d.", gateID, linkedid);
                }
                else if(strcmp(option, "speed", true) == 0)
                {
                    new Float:speed;
                    if(sscanf(param, "f", speed))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] Speed [Speed]");
                    }

                    GateInfo[i][GateSpeed] = speed;
                    UpdateGate(i);
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d speed set to %f.", gateID, speed);
                }
                else if(strcmp(option, "range", true) == 0)
                {
                    new Float:speed;
                    if(sscanf(param, "f", speed))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] Range [Speed]");
                    }

                    GateInfo[i][GateRange] = speed;
                    UpdateGate(i);
                    SaveGate(i);
                    SendServerMessage(playerid, "Gate %d range set to %f.", gateID, speed);
                }
                else if(strcmp(option, "locked", true) == 0)
                {
                    if(GateInfo[i][GateLocked] == 0)
                    {
                        GateInfo[i][GateLocked] = 1;
                        SendServerMessage(playerid, "Gate %d has been locked.", gateID);
                    }
                    else
                    {
                        GateInfo[i][GateLocked] = 0;
                        SendServerMessage(playerid, "Gate %d has been unlocked.", gateID);
                    }
                    UpdateGate(i);
                    SaveGate(i);
                }
                else if(strcmp(option, "autoclose", true) == 0)
                {
                    new seconds;
                    if(sscanf(param, "d", seconds))
                    {
                        return SendUsageMessage(playerid, "/editgate [Gate ID] AutoClose [Seconds(0 to disable)]");
                    }

                    if(seconds > 0)
                    {
                        GateInfo[i][GateCloseSeconds] = seconds;
                        SendServerMessage(playerid, "Gate %d auto close seconds set to %d.", gateID, seconds);
                    }
                    else
                    {
                        GateInfo[i][GateCloseSeconds] = 0;
                        SendServerMessage(playerid, "Gate %d auto close has been disabled.", gateID);
                    }

                    UpdateGate(i);
                    SaveGate(i);
                }
                return 1;
            }
        }
    }
    return 1;
}