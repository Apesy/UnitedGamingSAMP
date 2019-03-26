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


*/

#define MAX_ATMS 300

enum atmEnum
{
    AtmID,
    AtmMoney,
    Float:AtmX,
    Float:AtmY,
    Float:AtmZ,
    Float:AtmRX,
    Float:AtmRY,
    Float:AtmRZ,
    AtmWorld,
    AtmInterior,
    AtmAddedBy[MAX_PLAYER_NAME],
    AtmPlacedDate[32],

    AtmObject,
    Text3D:AtmLabel,
}
new AtmInfo[MAX_ATMS][atmEnum];

function DeleteATM(id)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "DELETE FROM Atm WHERE ID = %d", AtmInfo[id][AtmID]);
    mysql_tquery(g_SQL, query);

    AtmInfo[id][AtmID] = 0;
    AtmInfo[id][AtmX] = 0;
    AtmInfo[id][AtmY] = 0;
    AtmInfo[id][AtmZ] = 0;
    AtmInfo[id][AtmRX] = 0;
    AtmInfo[id][AtmRY] = 0;
    AtmInfo[id][AtmRZ] = 0;

    if(IsValidDynamicObject(AtmInfo[id][AtmObject]))
    {
        DestroyDynamicObject(AtmInfo[id][AtmObject]);
    }

    if(IsValidDynamic3DTextLabel(AtmInfo[id][AtmLabel]))
    {
        DestroyDynamic3DTextLabel(AtmInfo[id][AtmLabel]);
    }
    return 1;
}

stock GetNextAtmID()
{
    for (new i = 0; i < MAX_ATMS; i++)
	{
		if (!AtmInfo[i][AtmID])
		{
			return i;
		}
	}
	return -1;
}

stock SaveATMs()
{
    for (new i = 0; i < MAX_ATMS; i++)
	{
		if (AtmInfo[i][AtmID])
		{
			SaveATM(i);
		}
	}
}

stock SaveATM(id)
{
    new query[256];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE Atm SET Money = %i, X = %f, Y = %f, Z = %f, RX = %f, RY = %f, RZ = %f, World = %i, Interior = %i WHERE ID = %i",
	AtmInfo[id][AtmMoney],
	AtmInfo[id][AtmX],
	AtmInfo[id][AtmY],
	AtmInfo[id][AtmZ],
	AtmInfo[id][AtmRX],
	AtmInfo[id][AtmRY],
	AtmInfo[id][AtmRZ],
	AtmInfo[id][AtmWorld],
	AtmInfo[id][AtmInterior],
	AtmInfo[id][AtmID]);
	mysql_tquery(g_SQL, query);
}

stock LoadATMs()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM Atm");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "ID", AtmInfo[i][AtmID]);
		
            cache_get_value_int(i, "Money", AtmInfo[i][AtmMoney]);
            cache_get_value_float(i, "X", AtmInfo[i][AtmX]);
            cache_get_value_float(i, "Y", AtmInfo[i][AtmY]);
            cache_get_value_float(i, "Z", AtmInfo[i][AtmZ]);
            cache_get_value_float(i, "RX", AtmInfo[i][AtmRX]);
            cache_get_value_float(i, "RY", AtmInfo[i][AtmRY]);
            cache_get_value_float(i, "RZ", AtmInfo[i][AtmRZ]);
            cache_get_value_int(i, "World", AtmInfo[i][AtmWorld]);
            cache_get_value_int(i, "World", AtmInfo[i][AtmWorld]);
            cache_get_value(i, "AddedBy", AtmInfo[i][AtmAddedBy], MAX_PLAYER_NAME);
            cache_get_value(i, "AddedDate", AtmInfo[i][AtmPlacedDate], 32);

            ReloadATM(i);
        }
    }
    cache_delete(result); 
}

CMD:atmhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "ATM Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /createatm, /deleteatm, /editatm, /gotoatm.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:createatm(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for (new i = 0; i < MAX_ATMS; i++)
        {
            if (IsPlayerInRangeOfPoint(playerid, 3.0, AtmInfo[i][AtmX], AtmInfo[i][AtmY], AtmInfo[i][AtmZ]))
            {
                SendErrorMessage(playerid, "You are too close another ATM.");
                return 1;
            }
        }

        new id = GetNextAtmID();
        if(id == -1)
            return SendErrorMessage(playerid, "You cannot create an ATM at the moment because the limit has been reached, inform a developer.");
        
        new query[256], Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO Atm (AddedBy, AddedDate) VALUES ('%e', '%e')",
        AtmInfo[id][AtmAddedBy],
        AtmInfo[id][AtmPlacedDate]);
        mysql_tquery(g_SQL, query, "OnCreateATM", "ii", playerid, id);
    }
    return 1;
}

function OnCreateATM(playerid, id)
{
    AtmInfo[id][AtmID] = cache_insert_id();
    GetPlayerPos(playerid, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ]);
    GetPlayerFacingAngle(playerid, AtmInfo[id][AtmRZ]);
    AtmInfo[id][AtmWorld] = GetPlayerVirtualWorld(playerid);
    AtmInfo[id][AtmInterior] = GetPlayerInterior(playerid);
    AtmInfo[id][AtmMoney] = 10000;
    AtmInfo[id][AtmObject] = CreateDynamicObject(19473, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ], 0.0, 0.0, AtmInfo[id][AtmRZ], .worldid = AtmInfo[id][AtmWorld], .interiorid = AtmInfo[id][AtmInterior]);

    format(AtmInfo[id][AtmAddedBy], MAX_PLAYER_NAME, "%s", GetUserName(playerid));
    format(AtmInfo[id][AtmPlacedDate], 32, "%s", GetDateTime());
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have placed an ATM at your location, set its correct position now.");
    TempVar[playerid][EditType] = EDIT_TYPE_ATM;
    SetPVarInt(playerid, "AtmID", id);
    EditDynamicObject(playerid, AtmInfo[id][AtmObject]);
    SaveATM(id);
    return 1;
}

stock ReloadATM(id)
{
    if(IsValidDynamicObject(AtmInfo[id][AtmObject]))
    {
        DestroyDynamicObject(AtmInfo[id][AtmObject]);
    }

    if(IsValidDynamic3DTextLabel(AtmInfo[id][AtmLabel]))
    {
        DestroyDynamic3DTextLabel(AtmInfo[id][AtmLabel]);
    }

    AtmInfo[id][AtmObject] = CreateDynamicObject(19324, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ], AtmInfo[id][AtmRX], AtmInfo[id][AtmRY], AtmInfo[id][AtmRZ], .worldid = AtmInfo[id][AtmWorld], .interiorid = AtmInfo[id][AtmInterior]);
    AtmInfo[id][AtmLabel] = CreateDynamic3DTextLabel("ATM\n{C3C3C3}Type '{FFFFFF}/atm{C3C3C3}' to interact.", 0x00FF00FF, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ] + 0.7, 10.0, .worldid = AtmInfo[id][AtmWorld], .interiorid = AtmInfo[id][AtmInterior], .testlos = 0);
}

CMD:gotoatm(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/gotoatm [AtmID]");

        if(id < 0 || !AtmInfo[id][AtmID] || id > MAX_ATMS)
            return SendErrorMessage(playerid, "Invalid AtmID specified.");
        
        SetInterior(playerid, AtmInfo[id][AtmInterior]);
        SetVirtualWorld(playerid, AtmInfo[id][AtmWorld]);

        if(AtmInfo[id][AtmInterior] != 0 || AtmInfo[id][AtmWorld] != 0)
        {
            TogglePlayerWait(playerid);
        }

        SetPlayerPosEx(playerid, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ]+5);
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:deleteatm(playerid, params[])
{
    new string[128];
    if(IsAdminLevel(playerid, 4))
    {
        for (new i = 0; i < MAX_ATMS; i++)
        {
            if (AtmInfo[i][AtmID] && IsPlayerInRangeOfPoint(playerid, 5.0, AtmInfo[i][AtmX], AtmInfo[i][AtmY], AtmInfo[i][AtmZ]) && AtmInfo[i][AtmWorld] == GetPlayerVirtualWorld(playerid) && AtmInfo[i][AtmInterior] == GetPlayerInterior(playerid))
            {
                format(string, sizeof string, "%s %s has removed ATM %d.", GetAdminRank(playerid), GetMasterName(playerid), playerid, i);
                SendAdminCommand(string, 1);
                DeleteATM(i);
                return 1;
            }
        } 
        SendErrorMessage(playerid, "There are no ATMs near you.");
        return 1;
    }
	return 1;
}

CMD:editatm(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id, type;
        if(sscanf(params, "dd", id, type))
            return SendUsageMessage(playerid, "/editatm [AtmID] [Type]"), SendClientMessage(playerid, -1, "Types: 1. Get, 2. Move, 3. Amount");
        
        if(id < 0 || !AtmInfo[id][AtmID] || id > MAX_ATMS)
            return SendErrorMessage(playerid, "Invalid AtmID specified.");
        
        switch(type)
        {
            case 1:
            {
                GetPlayerPos(playerid, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ]);
                GetPlayerFacingAngle(playerid, AtmInfo[id][AtmRZ]);
                AtmInfo[id][AtmWorld] = GetPlayerVirtualWorld(playerid);
                AtmInfo[id][AtmInterior] = GetPlayerInterior(playerid);
                ReloadATM(playerid);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* ATM was moved to your location.");
            }
            case 2:
            {
                SetPVarInt(playerid, "AtmID", id);
                TempVar[playerid][EditType] = EDIT_TYPE_ATM;
                EditDynamicObject(playerid, AtmInfo[id][AtmObject]);
            }
            case 3:
            {
                SetPVarInt(playerid, "AtmID", id);
                Dialog_Show(playerid, ATM_Amount, DIALOG_STYLE_INPUT, "Edit ATM Amount", "Input an amount above 0.", "Edit", "Exit");
            }
        }

        return 1;
    }
	return 1;
}

Dialog:ATM_Amount(playerid, response, listitem, inputtext[])
{
    if(response && Player[playerid][AdminLevel] >= 4)
    {
        if(isnull(inputtext))
            return Dialog_Show(playerid, ATM_Amount, DIALOG_STYLE_INPUT, "Edit ATM Amount", "Input an amount above 0.", "Edit", "Exit");
        
        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, ATM_Amount, DIALOG_STYLE_INPUT, "Edit ATM Amount", "Input an amount above 0.", "Edit", "Exit");

        new amount = strval(inputtext), id = GetPVarInt(playerid, "AtmID");
        if(amount < 0)
            return Dialog_Show(playerid, ATM_Amount, DIALOG_STYLE_INPUT, "Edit ATM Amount", "Input an amount above 0.", "Edit", "Exit");
        
        AtmInfo[id][AtmMoney] = amount;

    }
    return 1;
}

stock ShowATM(playerid)
{
    new string[128];
    format(string, sizeof string, "You currently have $%s in your bank account\nEnter a value below to withdraw.", FormatNumber(PlayerInfo[playerid][pBank]));
    Dialog_Show(playerid, ATM_Withdraw, DIALOG_STYLE_INPUT, "ATM", string, "Withdraw", "Exit");
    return 1;
}

CMD:atm(playerid, params[])
{
    for(new i; i < MAX_ATMS; i++)
    {
        if (AtmInfo[i][AtmID] && IsPlayerInRangeOfPoint(playerid, 5.0, AtmInfo[i][AtmX], AtmInfo[i][AtmY], AtmInfo[i][AtmZ]) && AtmInfo[i][AtmWorld] == GetPlayerVirtualWorld(playerid) && AtmInfo[i][AtmInterior] == GetPlayerInterior(playerid))
        {
            ShowATM(playerid);
        }
    }
    return 1;
}

Dialog:ATM_Withdraw(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(isnull(inputtext))
            return ShowATM(playerid);
        
        new amount = strval(inputtext), id = GetPVarInt(playerid, "AtmID");
        if(amount < 0 || amount > PlayerInfo[playerid][pBank])
            return ShowATM(playerid), SendErrorMessage(playerid, "Valid amount must be above 0 or below $%s.", FormatNumber(PlayerInfo[playerid][pBank]));
        
        if(amount > 1000)
            return ShowATM(playerid), SendErrorMessage(playerid, "You cannot take out more than $1,000 from an ATM.");

        if(amount > AtmInfo[id][AtmMoney])
            return ShowATM(playerid), SendErrorMessage(playerid, "This ATM does not have enough money to cover this transaction.");

        new string[256];
        AtmInfo[id][AtmMoney] = amount;
        GiveMoney(playerid, amount);
        PlayerInfo[playerid][pBank] -= amount;
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Bank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pBank], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
    }
    return 1;
}

stock RamRaidVehicle(vehicle)
{
    new vmodel = GetVehicleModel(vehicle);
    if(vmodel == 413 || vmodel == 414 || vmodel == 440 || vmodel == 456 || vmodel == 459 || vmodel == 482 || vmodel == 498 || vmodel == 499 || vmodel == 609)
    {
        return 1;
    }
    return 0;
}

CMD:ramraid(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 0 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionRamRaid] == 0)
        return SendErrorMessage(playerid, "You do not have access to this.");

    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicle = GetPlayerVehicleID(playerid);
        if(RamRaidVehicle(vehicle))
        {
            for(new i; i < MAX_ATMS; i++)
            {
                if (AtmInfo[i][AtmID] && IsPlayerInRangeOfPoint(playerid, 20.0, AtmInfo[i][AtmX], AtmInfo[i][AtmY], AtmInfo[i][AtmZ]) && AtmInfo[i][AtmWorld] == GetPlayerVirtualWorld(playerid) && AtmInfo[i][AtmInterior] == GetPlayerInterior(playerid))
                {
                    new string[128];
                    foreach(new pd: Player)
                    {
                        if(PlayerInfo[pd][pFaction] && FactionInfo[PlayerInfo[pd][pFaction]][FactionPoliceCall] == 1)
                        {
                            SendClientMessageEx(pd, COLOR_LIGHTRED, "[Alarm] There is an ATM robbery taking place at %s.", ReturnLocation(playerid));
                        }
                    }
                    format(string, sizeof string, "%s (%d) is committing an ATM raid at %s.", GetUserName(playerid), playerid, ReturnLocation(playerid));
                    SendAdminWarning(1, string);
                    SendServerMessage(playerid, "Please wait here for 2 minutes.");
                    SetTimerEx("RamRaidTimer", 120000, false, "dd", playerid, i);
                }
            }
        }
        else SendErrorMessage(playerid, "You need to be in a van of some sort.");
    }
    else SendErrorMessage(playerid, "You need to be in a van of some sort.");
    return 1;
}

function RamRaidTimer(playerid, id)
{
    if (AtmInfo[id][AtmID] && IsPlayerInRangeOfPoint(playerid, 20.0, AtmInfo[id][AtmX], AtmInfo[id][AtmY], AtmInfo[id][AtmZ]) && AtmInfo[id][AtmWorld] == GetPlayerVirtualWorld(playerid) && AtmInfo[id][AtmInterior] == GetPlayerInterior(playerid))
    {
        FactionInfo[PlayerInfo[playerid][pFaction]][RamRaid] = 86400;

        if(AtmInfo[id][AtmMoney] < 1)
            return SendErrorMessage(playerid, "You gained nothing from this Ram Raid.");

        GiveMoney(playerid, AtmInfo[id][AtmMoney]);
        SendClientMessageEx(playerid, COLOR_YELLOW, "[RAM RAID] You have gained $%s from this raid.", FormatNumber(AtmInfo[id][AtmMoney]));
        AtmInfo[id][AtmMoney] = 0;
    }
    return 1;
}