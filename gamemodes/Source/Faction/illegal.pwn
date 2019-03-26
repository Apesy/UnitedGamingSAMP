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

#define MAX_GRAFFITI 50

new playerGraffitiTimer[MAX_PLAYERS]; 

enum graffitiEnum
{
    GraffitiID,
    GraffitiText[128],
    GraffitiPlacedBy[MAX_PLAYER_NAME],
    GraffitiPlaceTime,
    Float:GraffitiX,
    Float:GraffitiY,
    Float:GraffitiZ,
    Float:GraffitiA,
}
new GraffitiInfo[MAX_GRAFFITI][graffitiEnum],
    Cache:graffitiCache,
    GraffitiObject[MAX_GRAFFITI];

hook OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "GraffitiID", -1);
    if(playerGraffitiTimer[playerid])
    {
        KillTimer(playerGraffitiTimer[playerid]);
    }
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    DeletePVar(playerid, "GraffitiID");
    KillTimer(playerGraffitiTimer[playerid]);
    return 1;
}

stock LoadGraffiti()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `graffiti`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            graffitiCache = cache_save();
            cache_get_value_int(i, "ID", GraffitiInfo[i][GraffitiID]);
            cache_get_value(i, "Text", GraffitiInfo[i][GraffitiText]);
            cache_get_value(i, "PlacedBy", GraffitiInfo[i][GraffitiPlacedBy]);
            cache_get_value_int(i, "PlaceTime", GraffitiInfo[i][GraffitiPlaceTime]);

            cache_get_value_float(i, "X", GraffitiInfo[i][GraffitiX]);
            cache_get_value_float(i, "Y", GraffitiInfo[i][GraffitiY]);
            cache_get_value_float(i, "Z", GraffitiInfo[i][GraffitiZ]);
            cache_get_value_float(i, "A", GraffitiInfo[i][GraffitiA]);
            
            UpdateGraffiti(i);
            cache_set_active(graffitiCache);
        }
    }
    cache_delete(result); 
}

stock SaveGraffitis()
{
    for(new i; i < sizeof(GraffitiInfo); i++)
    {
        if(GraffitiInfo[i][GraffitiID])
        {
            SaveGraffiti(i);
        }
    }
}

stock SaveGraffiti(graffiti)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `graffiti` SET \
    Text = '%e',\
    PlacedBy = '%e',\
    PlaceTime = %d,\
    X = %f,\
    Y = %f,\
    Z = %f,\
    A = %f WHERE ID = %d", 
    GraffitiInfo[graffiti][GraffitiText],
    GraffitiInfo[graffiti][GraffitiPlacedBy],
    GraffitiInfo[graffiti][GraffitiPlaceTime],
    GraffitiInfo[graffiti][GraffitiX], 
    GraffitiInfo[graffiti][GraffitiY], 
    GraffitiInfo[graffiti][GraffitiZ],
    GraffitiInfo[graffiti][GraffitiA],
    GraffitiInfo[graffiti][GraffitiID]);
    mysql_tquery(g_SQL, query);
}

stock UpdateGraffiti(graffiti) 
{
    if(IsValidDynamicObject(GraffitiObject[graffiti]))
    {
        DestroyDynamicObject(GraffitiObject[graffiti]);
    }

    if(GraffitiInfo[graffiti][GraffitiID])
    {
        GraffitiObject[graffiti] = CreateDynamicObject(18666, GraffitiInfo[graffiti][GraffitiX], GraffitiInfo[graffiti][GraffitiY], GraffitiInfo[graffiti][GraffitiZ], 0.0, 0.0, GraffitiInfo[graffiti][GraffitiA], .worldid = 0, .interiorid = 0);
        new string[128];
        format(string, sizeof string, "%s", GraffitiInfo[graffiti][GraffitiText]);
        if(strlen(GraffitiInfo[graffiti][GraffitiText]) > 0)
        {
            strreplace(string, "(n)", "\n");
            strreplace(string, "(r)", "{FF0000}");
            strreplace(string, "(g)", "{00FF00}");
            strreplace(string, "(b)", "{0000FF}");
            strreplace(string, "(y)", "{FFFF00}");
            strreplace(string, "(p)", "{FF00FF}");
            strreplace(string, "(lb)", "{00FFFF}");
            strreplace(string, "(w)", "{FFFFFF}");

            SetDynamicObjectMaterialText(GraffitiObject[graffiti], 0, string, OBJECT_MATERIAL_SIZE_256x256, "Comic Sans MS", 27, 1, 0xFFFFFFFF, 0, 1);
        }
    }
}

CMD:graffitihelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Graffiti Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /creategraffiti, /graffitiid, /deletegraffiti, /cleargraffiti.");
        SendClientMessageEx(playerid, COLOR_GRAD4, "Commands: /checkgraffiti, /editgraffiti.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:creategraffiti(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new query[256], Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `graffiti` (`X`, `Y`, `Z`) VALUES (%f, %f, %f)", x, y, z);
        mysql_tquery(g_SQL, query, "OnCreateGraffiti", "d", playerid);
    }
    return 1;
}

CMD:graffitiid(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        for(new i; i < MAX_GRAFFITI; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, GraffitiInfo[i][GraffitiX], GraffitiInfo[i][GraffitiY], GraffitiInfo[i][GraffitiZ]))
            {
                SendClientMessageEx(playerid, -1, "Graffiti ID: %d", i);
            }
        }
    }
    return 1;
}

CMD:deletegraffiti(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new graffiti;
        if(sscanf(params, "d", graffiti))
            return SendUsageMessage(playerid, "/deletegraffiti [Graffiti ID]");
        
        if(graffiti < 0 || graffiti > MAX_GRAFFITI)
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        if(!GraffitiInfo[graffiti][GraffitiID])
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        GraffitiInfo[graffiti][GraffitiID] = 0;
        GraffitiInfo[graffiti][GraffitiText][0] = 0;
        GraffitiInfo[graffiti][GraffitiPlacedBy][0] = 0;
        GraffitiInfo[graffiti][GraffitiPlaceTime] = 0;
        GraffitiInfo[graffiti][GraffitiX] = 0.0;
        GraffitiInfo[graffiti][GraffitiY] = 0.0;
        GraffitiInfo[graffiti][GraffitiZ] = 0.0;
        DestroyDynamicObject(GraffitiObject[graffiti]);
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Graffiti %d deleted.", graffiti);
        new query[128];
        mysql_format(g_SQL, query, sizeof query, "DELETE FROM `graffiti` WHERE ID = %d", GraffitiInfo[graffiti][GraffitiID]);
        mysql_tquery(g_SQL, query);
    }
    return 1;
}

CMD:cleargraffiti(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new graffiti;
        if(sscanf(params, "d", graffiti))
            return SendUsageMessage(playerid, "/cleargraffiti [Graffiti ID]");
        
        if(graffiti < 0 || graffiti > MAX_GRAFFITI)
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        if(!GraffitiInfo[graffiti][GraffitiID])
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        GraffitiInfo[graffiti][GraffitiText][0] = 0;
        UpdateGraffiti(graffiti);
    }
    return 1;
}

CMD:checkgraffiti(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new graffiti;
        if(sscanf(params, "d", graffiti))
            return SendUsageMessage(playerid, "/checkgraffiti [Graffiti ID]");
        
        if(graffiti < 0 || graffiti > MAX_GRAFFITI)
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        if(!GraffitiInfo[graffiti][GraffitiID])
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        SendClientMessage(playerid, -1, "Graffiti Info:");
        if(strlen(GraffitiInfo[graffiti][GraffitiText]) > 70)
        {
            SendClientMessageEx(playerid, COLOR_GRAD5, "Text: %.70s ...", GraffitiInfo[graffiti][GraffitiText]);
            SendClientMessageEx(playerid, COLOR_GRAD5, "Text: ... %.70s", GraffitiInfo[graffiti][GraffitiText][70]);
        }
        else SendClientMessageEx(playerid, COLOR_GRAD5, "Text: %s", GraffitiInfo[graffiti][GraffitiText]);
        SendClientMessageEx(playerid, COLOR_GRAD4, "Placed By: %s", GraffitiInfo[graffiti][GraffitiPlacedBy]);
        SendClientMessageEx(playerid, COLOR_GRAD3, "Placed When: %s", date(GraffitiInfo[graffiti][GraffitiPlaceTime]));
    }
    return 1;
}

CMD:editgraffiti(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new graffiti;
        if(sscanf(params, "d", graffiti))
            return SendUsageMessage(playerid, "/editgraffiti [Graffiti ID]");
        
        if(graffiti < 0 || graffiti > MAX_GRAFFITI)
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        if(!GraffitiInfo[graffiti][GraffitiID])
            return SendErrorMessage(playerid, "Invalid Graffiti specified.");

        SetPVarInt(playerid, "GraffitiID", graffiti);
        TempVar[playerid][EditType] = EDIT_TYPE_GRAFFITI;
        EditDynamicObject(playerid, GraffitiObject[graffiti]);
    }
    return 1;
}

function OnCreateGraffiti(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i; i < sizeof(GraffitiInfo); i++)
    {
        if(!GraffitiInfo[i][GraffitiID])
        {
            GraffitiInfo[i][GraffitiID] = cache_insert_id();
            GraffitiInfo[i][GraffitiX] = x;
            GraffitiInfo[i][GraffitiY] = y;
            GraffitiInfo[i][GraffitiZ] = z;
            GraffitiInfo[i][GraffitiText][0] = 0;
            GraffitiInfo[i][GraffitiPlacedBy][0] = 0;
            GraffitiInfo[i][GraffitiPlaceTime] = 0;

            UpdateGraffiti(i);
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Created graffiti with ID %d (DatabaseID: %d).", i, GraffitiInfo[i][GraffitiID]);
            EditDynamicObject(playerid, GraffitiObject[i]);
            SetPVarInt(playerid, "GraffitiID", i);
            TempVar[playerid][EditType] = EDIT_TYPE_GRAFFITI;
            break;
        }
    }
    return 1;
}

CMD:graffiti(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 0 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionTag] == 0)
        return SendErrorMessage(playerid, "You do not have access to this.");

    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
        return SendErrorMessage(playerid, "You need to be outside.");

    for(new i; i < sizeof(GraffitiInfo); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, GraffitiInfo[i][GraffitiX], GraffitiInfo[i][GraffitiY], GraffitiInfo[i][GraffitiZ]))
        {
            SetPVarInt(playerid, "GraffitiID", i);
            Dialog_Show(playerid, Graffiti, DIALOG_STYLE_INPUT, "Graffiti", "{FFFFFF}Type in a message for the graffiti.\n\n\
            BBCode:\n\
            {AFAFAF}(n) New Line\n\
            {AFAFAF}(r) {FF0000}Red{FFFFFF}\n\
            {AFAFAF}(g) {00FF00}Green{FFFFFF}\n\
            {AFAFAF}(b) {0000FF}Blue{FFFFFF}\n\
            {AFAFAF}(y) {FFFF00}Yellow{FFFFFF}\n\
            {AFAFAF}(p) {FF00FF}Pink{FFFFFF}\n\
            {AFAFAF}(lb) {00FFFF}Lightblue{FFFFFF}\n\
            {AFAFAF}(w) {FFFFFF}White", "Write", "Exit");
        }
    }
    return 1;
}

function OnPlayerSpraying(playerid)
{
	new sprayCounter, sprayingGraffiti; 
	new counter[60], graffitiText[128], string[256];
		
	sprayCounter = GetPVarInt( playerid, "GraffitiLength" ); 
	sprayingGraffiti = GetPVarInt( playerid, "GraffitiID" );
	
	GetPVarString(playerid, "GraffitiTag", graffitiText, sizeof graffitiText);

	if(IsPlayerInRangeOfPoint(playerid, 5.0, GraffitiInfo[sprayingGraffiti][GraffitiX], GraffitiInfo[sprayingGraffiti][GraffitiY], GraffitiInfo[sprayingGraffiti][GraffitiZ]))
	{
		sprayCounter--;
		SetPVarInt(playerid, "GraffitiLength", sprayCounter);
		
		format(counter, sizeof counter, "~w~Spraying~n~~r~%d", sprayCounter); 
		PrintFooter(playerid, counter, 1); 
		
		if(sprayCounter <= 0)
		{
            format(string, sizeof string, "%s (ID: %d) has tagged in %s: %s", GetUserName(playerid), playerid, ReturnLocation(playerid), graffitiText);
            SendAdminWarning(1, string);
            format(GraffitiInfo[sprayingGraffiti][GraffitiText], 128, "%s", graffitiText);
			UpdateGraffiti(sprayingGraffiti);
			PrintFooter(playerid, "~g~Sprayed", 2);
			DeletePVar(playerid, "GraffitiID");
            DeletePVar(playerid, "GraffitiTag");
            DeletePVar(playerid, "GraffitiLength");
			KillTimer(playerGraffitiTimer[playerid]); 
		}
	}
	else
	{		
		DeletePVar(playerid, "GraffitiID");
        DeletePVar(playerid, "GraffitiTag");
        DeletePVar(playerid, "GraffitiLength");
		KillTimer(playerGraffitiTimer[playerid]); 
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new graffitiText[128];
    GetPVarString(playerid, "GraffitiTag", graffitiText, sizeof graffitiText);
    if(strlen(graffitiText) > 0)
    {
        if(PRESSED( KEY_FIRE ) && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && GetPVarInt(playerid, "GraffitiID") != -1)
        {
            new 
                bool: nearGraffiti;
                
            for(new i; i < sizeof(GraffitiInfo); i++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 5.0, GraffitiInfo[i][GraffitiX], GraffitiInfo[i][GraffitiY], GraffitiInfo[i][GraffitiZ]))
                {
                    nearGraffiti = true; 
                    
                    SetPVarInt(playerid, "GraffitiID", i); 
                    SetPVarInt(playerid, "GraffitiLength", 10);
                }
            }
            if(nearGraffiti)
            {
                playerGraffitiTimer [ playerid ] = SetTimerEx("OnPlayerSpraying", 1000, true, "i", playerid);
            }
        }
        
        if(RELEASED( KEY_FIRE ) && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && GetPVarInt(playerid, "GraffitiID") != -1)
        {
            KillTimer( playerGraffitiTimer[playerid] ); 
            DeletePVar(playerid, "GraffitiID");
            DeletePVar(playerid, "GraffitiTag");
            DeletePVar(playerid, "GraffitiLength");
            PrintFooter(playerid, "~w~Spraying ~n~~r~Stopped", 3); 
        }
    }
    return 1;
}

Dialog:Graffiti(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(strlen(inputtext) > 60 || strlen(inputtext) < 2)
            return pc_cmd_graffiti(playerid, ""); 

        SetPVarInt(playerid, "GraffitiLength", strlen(inputtext)); 
        SetPVarString(playerid, "GraffitiTag", inputtext);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You set your graffiti tag. You can now spray at the graffiti.");
        SendClientMessageEx(playerid, COLOR_WHITE, "Tag: %s", inputtext);
    }
    DeletePVar(playerid, "GraffitiID");
    return 1;
}

enum CutWireEnum
{
    Name[32],
    Float:PosX,
    Float:PosY,
    Float:PosZ
};

new CutWireInfo[][CutWireEnum] = {
    {"Arco Del Oeste Sub Station",776.5112,2031.0469,6.7109},
    {"Arco Del Oeste Sub Station",770.8169,2031.2334,6.7109},
    {"Arco Del Oeste Sub Station",756.2721,2031.1583,6.7109},
    {"Arco Del Oeste Sub Station",750.8658,2031.6725,6.7109}
};

new WireRecentlyCut[4], WireCutTime[MAX_PLAYERS], WireCutTimer[MAX_PLAYERS];

CMD:cutwire(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 0 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionRamRaid] == 0)
        return SendErrorMessage(playerid, "You do not have access to this.");

    for(new i; i < sizeof(CutWireInfo); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, CutWireInfo[i][PosX], CutWireInfo[i][PosY], CutWireInfo[i][PosZ]))
        {
            if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                return SendErrorMessage(playerid, "You must be crouched to do this.");

            if(WireRecentlyCut[i] >= 1)
                return SendErrorMessage(playerid, "The wire was recently cut. Please try again at the in a few hours.");

            new string[128];
            WireCutTime[playerid] = 120;
            SendClientMessage(playerid, COLOR_YELLOW, "You are now cutting the wire, please wait here for 2 minutes.");
            format(string, sizeof string, "%s (%d) is attempting to cut wires at %s.", GetUserName(playerid), playerid, ReturnLocation(playerid));
            SendAdminWarning(1, string);
            WireCutTimer[playerid] = SetTimerEx("OnCutWire", 1000, true, "dd", playerid, i);
            return 1;
        }
    }
    SendErrorMessage(playerid, "You need to be closer to a wire cutting point.");
    return 1;
}

function OnCutWire(playerid, i)
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, CutWireInfo[i][PosX], CutWireInfo[i][PosY], CutWireInfo[i][PosZ]) && GetPlayerInterior(playerid) == 0)
    {
        new string[128];
        WireCutTime[playerid]--;
        format(string, sizeof string, "~r~%d ~w~seconds remaining.", WireCutTime[playerid]);
        PrintFooter(playerid, string, 1);
        if(WireCutTime[playerid] < 1)
        {
            if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                return SendErrorMessage(playerid, "You were not crouched during this action, you failed."), KillTimer(WireCutTimer[playerid]);

            new rand = random(4)+1;            
            PlayerInfo[playerid][pWires] += rand;
            format(string, sizeof string, "You gained ~g~%d~w~ pieces of wire from this operation.", rand);
            PrintFooter(playerid, string);
            WireRecentlyCut[i] = 7200;
            KillTimer(WireCutTimer[playerid]);
        }
    }
    else SendErrorMessage(playerid, "You left the wire cutting point."), KillTimer(WireCutTimer[playerid]);
    return 1;
}

task WireTimer[2000]()
{
    for(new i; i < sizeof(CutWireInfo); i++)
    {
        if(WireRecentlyCut[i] > 0)
        {
            WireRecentlyCut[i] -= 2;
        }
    }
}

CMD:givewire(playerid, params[])
{
    new target, amount, string[128];
    if(sscanf(params, "ud", target, amount))
    {
        SendUsageMessage(playerid, "/givewire [PlayerID/PartOfName] [Amount]");
        return 1;
    }

    if(amount < 0)
        return SendErrorMessage(playerid, "The amount must be above 0.");

    if(IsPlayerConnected(target))
    {
        if(!IsPlayerNearPlayer(playerid, target, 5.0))
            return SendErrorMessage(playerid, "You are not near that player.");

        if(PlayerInfo[playerid][pWires] < amount)
            return SendErrorMessage(playerid, "You do not have enough wires to cover this amount.");
        
        if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[target][pLevel] <= 3 || amount > 10)
        {
            format(string, sizeof string, "%s (Level %d, ID %d) has given %s (Level %d, ID %d) %d wires.", GetUserName(playerid), PlayerInfo[playerid][pLevel], playerid, GetUserName(target), PlayerInfo[target][pLevel], target, amount);
            SendAdminWarning(1, string);
        }

        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have given %s %d wires.", GetRPName(target), amount);
        SendClientMessageEx(target, COLOR_LIGHTBLUE, "* You were given %d wires by %s.", amount, GetRPName(playerid));
        PlayerInfo[playerid][pWires] -= amount;
        PlayerInfo[target][pWires] += amount;
        format(string, sizeof string, "has given %s wires.", GetRPName(target));
        SendAMe(playerid, string);
    }
    return 1;
}