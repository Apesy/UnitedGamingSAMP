//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum entranceEnum
{
	EntranceID,
	EntranceName[128],
	EntranceFactionID,
	EntranceHouseID,
	EntranceBusinessID,
	Float:EntranceX,
	Float:EntranceY,
	Float:EntranceZ,
	Float:EntranceA,
	EntranceOutsideInt,
	EntranceOutsideVW,
	Float:EntranceIntX,
	Float:EntranceIntY,
	Float:EntranceIntZ,
	Float:EntranceIntA,
	EntranceInsideInt,
	EntranceInsideVW,
	EntranceLocked,
    EntranceVehicle,
    EntranceCustomExt,

    Text3D:EntranceLabel,
    Text3D:InsideLabel,
    EntrancePickup
}
new EntranceInfo[MAX_ENTRANCE][entranceEnum],
    Cache:eCache;

stock LoadEntrance()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `entrances`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            eCache = cache_save();
            cache_get_value_int(i, "ID", EntranceInfo[i][EntranceID]);

            cache_get_value(i, "Name", EntranceInfo[i][EntranceName]);
            cache_get_value_int(i, "FactionID", EntranceInfo[i][EntranceFactionID]);
            cache_get_value_int(i, "HouseID", EntranceInfo[i][EntranceHouseID]);
            cache_get_value_int(i, "BusinessID", EntranceInfo[i][EntranceBusinessID]);
            cache_get_value_float(i, "X", EntranceInfo[i][EntranceX]);
            cache_get_value_float(i, "Y", EntranceInfo[i][EntranceY]);
            cache_get_value_float(i, "Z", EntranceInfo[i][EntranceZ]);
            cache_get_value_float(i, "A", EntranceInfo[i][EntranceA]);
            cache_get_value_int(i, "OutsideInt", EntranceInfo[i][EntranceOutsideInt]);
            cache_get_value_int(i, "OutsideVW", EntranceInfo[i][EntranceOutsideVW]);
            cache_get_value_float(i, "IntX", EntranceInfo[i][EntranceIntX]);
            cache_get_value_float(i, "IntY", EntranceInfo[i][EntranceIntY]);
            cache_get_value_float(i, "IntZ", EntranceInfo[i][EntranceIntZ]);
            cache_get_value_float(i, "IntA", EntranceInfo[i][EntranceIntA]);
            cache_get_value_int(i, "InsideInt", EntranceInfo[i][EntranceInsideInt]);
            cache_get_value_int(i, "InsideVW", EntranceInfo[i][EntranceInsideVW]);
            cache_get_value_int(i, "Locked", EntranceInfo[i][EntranceLocked]);
            cache_get_value_int(i, "CustomExt", EntranceInfo[i][EntranceCustomExt]);
            
            if(EntranceInfo[i][EntranceFactionID] > 0 && EntranceInfo[i][EntranceLocked] == 0)
                EntranceInfo[i][EntranceLocked] = 1;

            UpdateEntrancePickup(i);
            Iter_Add(Entrances,i);
            cache_set_active(eCache);
        }
    }
    cache_delete(result); 
}

stock UpdateEntrancePickup(i)
{
    if(IsValidDynamic3DTextLabel(EntranceInfo[i][EntranceLabel]))
    {
        DestroyDynamic3DTextLabel(EntranceInfo[i][EntranceLabel]);
    }

    if(IsValidDynamic3DTextLabel(EntranceInfo[i][InsideLabel]))
    {
        DestroyDynamic3DTextLabel(EntranceInfo[i][InsideLabel]);
    }

    if(IsValidDynamicPickup(EntranceInfo[i][EntrancePickup]))
    {
        DestroyDynamicPickup(EntranceInfo[i][EntrancePickup]);
    }

    if(EntranceInfo[i][EntranceID])
    {
        new string[128];
        format(string, sizeof(string), "%s\n{%06x}/enter", EntranceInfo[i][EntranceName], COLOR_YELLOW >>> 8);
        EntranceInfo[i][EntranceLabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, 
        EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]+0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 
        EntranceInfo[i][EntranceOutsideVW], EntranceInfo[i][EntranceOutsideInt]);

        EntranceInfo[i][InsideLabel] = CreateDynamic3DTextLabel("/exit", COLOR_YELLOW, 
        EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 
        EntranceInfo[i][EntranceInsideVW], EntranceInfo[i][EntranceInsideInt]);

        EntranceInfo[i][EntrancePickup] = CreateDynamicPickup(1239, 1, 
        EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ], 
        EntranceInfo[i][EntranceOutsideVW], EntranceInfo[i][EntranceOutsideInt]);
    }
}

stock Entrance_HandleEnter(playerid)
{
    for(new i; i < MAX_ENTRANCE; i++)
    {
        if(EntranceInfo[i][EntranceID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]))
        {
            if(EntranceInfo[i][EntranceOutsideVW] == GetPlayerVirtualWorld(playerid) && EntranceInfo[i][EntranceOutsideInt] == GetPlayerInterior(playerid))
            {
                if(EntranceInfo[i][EntranceLocked] && TempVar[playerid][AdminDuty] == false)
                {
                    PrintFooter(playerid, "~r~Locked", 5);
                    return 1;
                }           

                if(IsPlayerInAnyVehicle(playerid) && EntranceInfo[i][EntranceVehicle] == 0)
                    return SendErrorMessage(playerid, "You need to leave your vehicle.");

                if(IsPlayerInAnyVehicle(playerid) && EntranceInfo[i][EntranceVehicle] == 1)
                {
                    new vehicleid = GetPlayerVehicleID(playerid);
                    SetVehiclePos(vehicleid, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]);
                    SetVehicleZAngle(vehicleid, EntranceInfo[i][EntranceIntA]);
                    LinkVehicleToInterior(vehicleid, EntranceInfo[i][EntranceInsideInt]);
                    SetVehicleVirtualWorld(vehicleid, EntranceInfo[i][EntranceInsideVW]);
                }
                else
                {
                    SetPlayerPosEx(playerid, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]);
                    SetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceIntA]);
                }
                SetPlayerInterior(playerid, EntranceInfo[i][EntranceInsideInt]);
                SetPlayerVirtualWorld(playerid, EntranceInfo[i][EntranceInsideVW]);
                TogglePlayerWait(playerid);
                SetCameraBehindPlayer(playerid);
		        PrintFooter(playerid, "~w~Type /exit to get out", 5);
                return 1;
            }
        }
    }
    return 1;
}

stock Entrance_HandleExit(playerid)
{
    for(new i; i < MAX_ENTRANCE; i++)
    {
        if(EntranceInfo[i][EntranceID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]))
        {
            if(EntranceInfo[i][EntranceInsideVW] == GetPlayerVirtualWorld(playerid) && EntranceInfo[i][EntranceInsideInt] == GetPlayerInterior(playerid))
            {
                if(IsPlayerInAnyVehicle(playerid) && EntranceInfo[i][EntranceVehicle] == 0)
                    return SendErrorMessage(playerid, "You need to leave your vehicle.");

                if(IsPlayerInAnyVehicle(playerid) && EntranceInfo[i][EntranceVehicle] == 1)
                {
                    new vehicleid = GetPlayerVehicleID(playerid);
                    SetVehiclePos(vehicleid, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]);
                    SetVehicleZAngle(vehicleid, EntranceInfo[i][EntranceA]);
                    LinkVehicleToInterior(vehicleid, EntranceInfo[i][EntranceOutsideInt]);
                    SetVehicleVirtualWorld(vehicleid, EntranceInfo[i][EntranceOutsideVW]);
                }
                else
                {
                    SetPlayerPosEx(playerid, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]);
                    SetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceA]);
                }
                SetPlayerInterior(playerid, EntranceInfo[i][EntranceOutsideInt]);
                SetPlayerVirtualWorld(playerid, EntranceInfo[i][EntranceOutsideVW]);
                SetCameraBehindPlayer(playerid);
                if(EntranceInfo[i][EntranceOutsideInt] > 0 || EntranceInfo[i][EntranceCustomExt] == 1)
                {
                    TogglePlayerWait(playerid);
                }
                return 1;
            }
        }
    }
    return 1;
}

function OnCreateEntrance(playerid, entranceid, name[], Float:x, Float:y, Float:z, Float:a)
{
	strcpy(EntranceInfo[entranceid][EntranceName], name, 128);

    EntranceInfo[entranceid][EntranceID] = cache_insert_id();
    EntranceInfo[entranceid][EntranceX] = x;
    EntranceInfo[entranceid][EntranceY] = y;
    EntranceInfo[entranceid][EntranceZ] = z;
    EntranceInfo[entranceid][EntranceA] = a;
    EntranceInfo[entranceid][EntranceOutsideInt] = GetPlayerInterior(playerid);
    EntranceInfo[entranceid][EntranceOutsideVW] = GetPlayerVirtualWorld(playerid);

    UpdateEntrancePickup(entranceid);

    new string[128];
    format(string, sizeof string, "%s %s has created a new entrance at %s. (EntranceID: %d)", GetAdminRank(playerid), GetMasterName(playerid), ReturnLocation(playerid), EntranceInfo[entranceid][EntranceID]);
    SendAdminCommand(string, 4);
    return 1;
}

CMD:entrancehelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Vehicle Dealership Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /createentrance, /deleteentrance, /gotoentrance, /goinentrance.");
        SendClientMessageEx(playerid, COLOR_GRAD4, "Commands: /createentrance, /deleteentrance, /gotoentrance, /goinentrance.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:createentrance(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/createentrance [Entrance Name]");

        if(strlen(params) < 5)
            return SendErrorMessage(playerid, "Entrance Name is too short (min 5 characters).");

        if(strlen(params) > 127)
            return SendErrorMessage(playerid, "Entrance Name is too long (max 127 characters).");

        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);

        for(new i = 0; i < MAX_ENTRANCE; i++)
        {
            if(!EntranceInfo[i][EntranceID])
            {
                new queryBuffer[1024];
                mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "INSERT INTO entrances (Name, X, Y, Z, A, OutsideInt, OutsideVW) VALUES('%e', %f, %f, %f, %f, %i, %i)", params, x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
                mysql_tquery(g_SQL, queryBuffer, "OnCreateEntrance", "iisffff", playerid, i, params, x, y, z, a);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance slots are currently full.");
    }
    return 1;
}

CMD:deleteentrance(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new entranceID;
        if(sscanf(params, "d", entranceID))
            return SendUsageMessage(playerid, "/deleteentrance [Entrance ID]");

        if(entranceID < 1 || entranceID > MAX_ENTRANCE)
            return SendErrorMessage(playerid, "Entrance ID must be between 1 and %d.", entranceID);

        for(new i = 0; i < MAX_ENTRANCE; i++)
        {
            if(EntranceInfo[i][EntranceID] == entranceID)
            {
                new queryBuffer[1024];
                mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "DELETE FROM entrances WHERE ID = %i", entranceID);
                mysql_tquery(g_SQL, queryBuffer);

                EntranceInfo[i][EntranceID] = 0;
                EntranceInfo[i][EntranceX] = 0;
                EntranceInfo[i][EntranceY] = 0;
                EntranceInfo[i][EntranceZ] = 0;
                EntranceInfo[i][EntranceA] = 0;
                EntranceInfo[i][EntranceOutsideInt] = 0;
                EntranceInfo[i][EntranceOutsideVW] = 0;

                UpdateEntrancePickup(i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance slots are currently full.");
    }
    return 1;
}

CMD:gotoentrance(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new entranceID;
        if(sscanf(params, "d", entranceID))
            return SendUsageMessage(playerid, "/gotoentrance [Entrance ID]");

        if(entranceID < 1 || entranceID > MAX_ENTRANCE)
            return SendErrorMessage(playerid, "Entrance ID must be between 1 and %d.", entranceID);

        for(new i = 0; i < MAX_ENTRANCE; i++)
        {
            if(EntranceInfo[i][EntranceID] == entranceID)
            {
                SetPlayerPosEx(playerid, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]);
                SetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceA]);
                SetPlayerInterior(playerid, EntranceInfo[i][EntranceOutsideInt]);
                SetPlayerVirtualWorld(playerid, EntranceInfo[i][EntranceOutsideVW]);
                SendTeleportMessage(playerid);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance not found/not created.");
    }
    return 1;
}

CMD:goinentrance(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new entranceID;
        if(sscanf(params, "d", entranceID))
            return SendUsageMessage(playerid, "/goinentrance [Entrance ID]");

        if(entranceID < 1 || entranceID > MAX_ENTRANCE)
            return SendErrorMessage(playerid, "Entrance ID must be between 1 and %d.", entranceID);

        for(new i = 0; i < MAX_ENTRANCE; i++)
        {
            if(EntranceInfo[i][EntranceID] == entranceID)
            {
                SetPlayerPosEx(playerid, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]);
                SetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceIntA]);
                SetPlayerInterior(playerid, EntranceInfo[i][EntranceInsideInt]);
                SetPlayerVirtualWorld(playerid, EntranceInfo[i][EntranceInsideVW]);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance not found/not created.");
    }
    return 1;
}

CMD:editentrance(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new entranceID, option[14], param[64];
        if(sscanf(params, "ds[14]S()[64]", entranceID, option, param))
        {
            SendUsageMessage(playerid, "/editentrance [Entrance ID] [Option]");
            SendClientMessage(playerid, -1, "Options: Entrance, Exit, Name, ExteriorWorld, InteriorWorld, Vehicle");
            SendClientMessage(playerid, -1, "Options: FactionID, BusinessID, Locked");
            return 1;
        }

        if(entranceID < 1 || entranceID > MAX_ENTRANCE)
            return SendErrorMessage(playerid, "Entrance ID must be between 1 and %d.", entranceID);

        for(new i = 0; i < MAX_ENTRANCE; i++)
        {
            if(EntranceInfo[i][EntranceID] == entranceID)
            {
                if(strcmp(option, "entrance", true) == 0)
                {
                    GetPlayerPos(playerid, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ]);
	                GetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceA]);
                    EntranceInfo[i][EntranceOutsideInt] = GetPlayerInterior(playerid);
                    EntranceInfo[i][EntranceOutsideVW] = GetPlayerVirtualWorld(playerid);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "You have modified entrance %d's entrance.", EntranceInfo[i][EntranceID]);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "exit", true) == 0)
                {
                    GetPlayerPos(playerid, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]);
	                GetPlayerFacingAngle(playerid, EntranceInfo[i][EntranceIntA]);
                    EntranceInfo[i][EntranceInsideInt] = GetPlayerInterior(playerid);
                    EntranceInfo[i][EntranceInsideVW] = GetPlayerVirtualWorld(playerid);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You have modified entrance %d's exit.", EntranceInfo[i][EntranceID]);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "name", true) == 0)
                {
                    new name[32];
                    if(sscanf(param, "s[32]", name))
                    {
                        return SendUsageMessage(playerid, "/editentrance [entranceid] name [new name]");
                    }

                    strcpy(EntranceInfo[i][EntranceName], name, 32);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You've changed the name of entrance %i to '%s'.", EntranceInfo[i][EntranceID], name);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "interiorworld", true) == 0)
                {
                    new interior;
                    if(sscanf(param, "d", interior))
                    {
                        return SendUsageMessage(playerid, "/editentrance [entranceid] interiorworld [interior]");
                    }

                    EntranceInfo[i][EntranceInsideInt] = interior;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You've changed the inside interior of entrance %i to %d.", EntranceInfo[i][EntranceID], interior);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "exteriorworld", true) == 0)
                {
                    new interior;
                    if(sscanf(param, "d", interior))
                    {
                        return SendUsageMessage(playerid, "/editentrance [entranceid] exteriorworld [interior]");
                    }

                    EntranceInfo[i][EntranceOutsideInt] = interior;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You've changed the outside interior of entrance %i to %d.", EntranceInfo[i][EntranceID], interior);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "vehicle", true) == 0)
                {
                    if(EntranceInfo[i][EntranceVehicle] == 0)
                    {
                        EntranceInfo[i][EntranceVehicle] = 1;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i can now support vehicles.", EntranceInfo[i][EntranceID]);
                    }
                    else
                    {
                        EntranceInfo[i][EntranceVehicle] = 0;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i can no longer support vehicles.", EntranceInfo[i][EntranceID]);
                    }
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "factionid", true) == 0)
                {
                    new factionid;
                    if(sscanf(param, "d", factionid))
                    {
                        return SendUsageMessage(playerid, "/editentrance [entranceid] factionid [interior]");
                    }

                    EntranceInfo[i][EntranceFactionID] = factionid;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You've changed the FactionID of entrance %i to %d.", EntranceInfo[i][EntranceID], factionid);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "businessid", true) == 0)
                {
                    new businessid;
                    if(sscanf(param, "d", businessid))
                    {
                        return SendUsageMessage(playerid, "/editentrance [entranceid] businessid [interior]");
                    }

                    EntranceInfo[i][EntranceBusinessID] = businessid;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "** You've changed the FactionID of entrance %i to %d.", EntranceInfo[i][EntranceID], businessid);
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "locked", true) == 0)
                {
                    if(EntranceInfo[i][EntranceLocked] == 0)
                    {
                        EntranceInfo[i][EntranceLocked] = 1;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i is now locked.", EntranceInfo[i][EntranceID]);
                    }
                    else
                    {
                        EntranceInfo[i][EntranceLocked] = 0;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i is now unlocked.", EntranceInfo[i][EntranceID]);
                    }
                    UpdateEntrancePickup(i);
                }
                else if(strcmp(option, "custexterior", true) == 0)
                {
                    if(EntranceInfo[i][EntranceCustomExt] == 0)
                    {
                        EntranceInfo[i][EntranceCustomExt] = 1;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i is now set as a custom exterior.", EntranceInfo[i][EntranceID]);
                    }
                    else
                    {
                        EntranceInfo[i][EntranceCustomExt] = 0;
                        SendClientMessageEx(playerid, COLOR_YELLOW, "** Entrance %i is now set as a normal exterior.", EntranceInfo[i][EntranceID]);
                    }
                }
                SaveEntrance(i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Entrance not found/not created.");
    }
    return 1;
}

stock SaveEntrances()
{
    for(new i = 0; i < MAX_ENTRANCE; i++)
    {
        if(EntranceInfo[i][EntranceID] > 0)
        {
            SaveEntrance(i);
        }
    }
}

stock SaveEntrance(i)
{
    if(!EntranceInfo[i][EntranceID])
		return 0;
		
	new threadSave[256];

	mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE entrances SET Name = '%e', FactionID = %d, HouseID = %i, BusinessID = %i WHERE ID = %i LIMIT 1",
		EntranceInfo[i][EntranceName],
        EntranceInfo[i][EntranceFactionID],
        EntranceInfo[i][EntranceHouseID],
        EntranceInfo[i][EntranceBusinessID],
		EntranceInfo[i][EntranceID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE entrances SET X = %f, Y = %f, Z = %f, A = %f, OutsideInt = %i, OutsideVW = %i WHERE ID = %i LIMIT 1",
		EntranceInfo[i][EntranceX],
        EntranceInfo[i][EntranceY],
        EntranceInfo[i][EntranceZ],
        EntranceInfo[i][EntranceA],
        EntranceInfo[i][EntranceOutsideInt],
        EntranceInfo[i][EntranceOutsideVW],
		EntranceInfo[i][EntranceID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE entrances SET IntX = %f, IntY = %f, IntZ = %f, IntA = %f, InsideInt = %i, InsideVW = %i WHERE ID = %i LIMIT 1",
		EntranceInfo[i][EntranceIntX],
        EntranceInfo[i][EntranceIntY],
        EntranceInfo[i][EntranceIntZ],
        EntranceInfo[i][EntranceIntA],
        EntranceInfo[i][EntranceInsideInt],
        EntranceInfo[i][EntranceInsideVW],
		EntranceInfo[i][EntranceID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE entrances SET Locked = %d WHERE ID = %i LIMIT 1",
		EntranceInfo[i][EntranceLocked],
		EntranceInfo[i][EntranceID]);
	mysql_tquery(g_SQL, threadSave);    
    return 1;
}