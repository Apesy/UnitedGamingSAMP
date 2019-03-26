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

new bool:HHBeingChecked[MAX_PLAYERS char], HHCheckInterior[MAX_PLAYERS], HHCheckVW[MAX_PLAYERS], 
    Float:HHCheckHealth[MAX_PLAYERS], Float:HHCheckArmour[MAX_PLAYERS],
    Float:HHCheckX[MAX_PLAYERS], Float:HHCheckY[MAX_PLAYERS], Float:HHCheckZ[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    ResetHH(playerid);
    return 1;
}

stock ResetHH(playerid)
{
    HHBeingChecked{playerid} = false;
    HHCheckInterior[playerid] = 0;
    HHCheckVW[playerid] = 0;
    HHCheckHealth[playerid] = 0.0;
    HHCheckArmour[playerid] = 0.0;
    HHCheckX[playerid] = 0.0;
    HHCheckY[playerid] = 0.0;
    HHCheckZ[playerid] = 0.0;
}

CMD:admins(playerid, params[])
{
    new bool:adminsOnline = false, string[1024];
    if(Player[playerid][AdminLevel] < 1)
    {
        foreach(new i: Player)
        {
            if(Player[i][AdminLevel] >= 1 && TempVar[i][AdminHide] == false) adminsOnline = true;
        }

        if(adminsOnline == true)
        {
            foreach(new i: Player)
            {
                if(Player[i][AdminLevel] >= 1 && TempVar[i][AdminHide] == false)
                {
                    if(TempVar[i][AdminDuty] == true)
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {33AA33}[On Duty]\n", string, GetAdminRank(i), GetUserName(i), GetMasterName(i));
                    }
                    else
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {AA3333}[Off Duty]\n", string, GetAdminRank(i), GetUserName(i), GetMasterName(i));
                    }
                }
            }
        }
        else
        {
            format(string, sizeof string, "{FFFFFF}There are no administrators online.");
        }
    }
    else
    {
        foreach(new i: Player)
        {
            if(Player[i][AdminLevel] >= 1)
            {
                if(TempVar[i][AdminHide] == true)
                {
                    format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {AAAA33}[Hidden]\n", string, GetAdminRank(i), GetUserName(i), GetMasterName(i));
                }
                else
                {
                    if(TempVar[i][AdminDuty] == true)
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {33AA33}[On Duty]\n", string, GetAdminRank(i), GetUserName(i), GetMasterName(i));
                    }
                    else
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {AA3333}[Off Duty]\n", string, GetAdminRank(i), GetUserName(i), GetMasterName(i));
                    }
                }
            }
        }
    }
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Administration Team", string, "Okay", "");
    return 1;
}

CMD:aduty(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(TempVar[playerid][AdminDuty] == true)
        {
            SendAdminMessage(COLOR_RED, 1, "[ADMIN] {FFFF00}%s %s is off admin duty.", GetAdminRank(playerid), GetMasterName(playerid));
            TempVar[playerid][AdminDuty] = false;

            SetPlayerArmourEx(playerid, GetPVarFloat(playerid, "BeforeADutyArmour"));
            SetPlayerHealthEx(playerid, GetPVarFloat(playerid, "BeforeADutyHealth"));
        }
        else
        {
            new Float:health,Float:armour;
            GetPlayerHealth(playerid, health);
            GetPlayerArmour(playerid, armour);
            SetPVarFloat(playerid, "BeforeADutyHealth", health);
            SetPVarFloat(playerid, "BeforeADutyArmour", armour);
            SendAdminMessage(COLOR_RED, 1, "[ADMIN] {FFFF00}%s %s is on admin duty.", GetAdminRank(playerid), GetMasterName(playerid));
            TempVar[playerid][AdminDuty] = true;

            SetPlayerHealthEx(playerid, 999);
            SetPlayerArmour(playerid, 0);
        }
        SetPlayerTeamColour(playerid);
    }
    return 1;
}

CMD:gotoid(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/gotoid [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(GetPlayerState(targetid) == PLAYER_STATE_SPECTATING)
        {
            SendErrorMessage(playerid, "This player is currently spectating someone.");
            return 1;
        }

        if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
        {
            SendClientMessageEx(playerid, COLOR_YELLOW, "** You stopped spectating %s.", GetUserName(TempVar[playerid][Spectating]));
            TogglePlayerSpectating(playerid, false); 
        }

        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            SetVehiclePos(GetPlayerVehicleID(playerid), x, y - 1, z);
        
        else
            SetPlayerPosEx(playerid, x, y - 1, z);
            
        SetVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
        SetInterior(playerid, GetPlayerInterior(targetid)); 
        
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:respawn(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new target;
        if(sscanf(params, "u", target))
        {
            SendUsageMessage(playerid, "/respawn [Player ID]");
            return 1;
        }

        if(!IsPlayerConnected(target))
            return SendErrorMessage(playerid, "No such player is connected.");
        
        SendToSpawn(target);
        SendTeleportMessage(target);
        if(target != playerid)
        {
            new string[128];
            format(string, sizeof string, "%s was respawned by %s %s.", GetUserName(target), GetAdminRank(playerid), GetMasterName(playerid));
            SendAdminCommand(string, 1);
        }
    }
    return 1;
}

CMD:sendto(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new target;
        if(sscanf(params, "u", target))
        {
            SendUsageMessage(playerid, "/sendto [Player ID]");
            return 1;
        }

        new list[2048], counter = 0;
        for(new i; i < MAX_TELEPORTS; i++)
        {
            format(list, sizeof(list), "%s\n%s", list, TeleportInfo[i][teleName]);
            TeleportHolder[playerid][counter] = i;
            TempVar[playerid][TeleportID] = target;
            counter++;
        }

        if (!counter)
        {
            return SendErrorMessage(playerid, "No teleports have been added yet.");
        }

        Dialog_Show(playerid, AdminTeleportPlayer, DIALOG_STYLE_LIST, "Teleport", list, "Send", "Cancel");
    }
    return 1;
}

CMD:goto(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(isnull(params))
        {
            new list[2048], counter = 0;
            for(new i; i < MAX_TELEPORTS; i++)
            {
                format(list, sizeof(list), "%s\n%s", list, TeleportInfo[i][teleName]);
                TeleportHolder[playerid][counter] = i;
                counter++;
            }

            if (!counter)
            {
                return SendErrorMessage(playerid, "No teleports have been added yet.");
            }

            Dialog_Show(playerid, AdminTeleport, DIALOG_STYLE_LIST, "Teleport", list, "Goto", "Cancel");
            return 1;
        }

        if(IsNumeric(params))
            return SendErrorMessage(playerid, "You cannot type a number, use /gotoid instead.");

        new vehicleid = GetPlayerVehicleID(playerid);
        if(strcmp(params, "M1", true) == 0 || strcmp(params, "Mark1", true) == 0)
        {
            new idx = 0;
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                SetVehiclePos(vehicleid, MarkPos[playerid][idx][PosX],MarkPos[playerid][idx][PosY],MarkPos[playerid][idx][PosZ]);
                LinkVehicleToInterior(vehicleid, MarkPos[playerid][idx][Interior]);
                SetVehicleVirtualWorld(vehicleid, MarkPos[playerid][idx][VW]);
            }
            else
            {
                SetPlayerPosEx(playerid, MarkPos[playerid][idx][PosX],MarkPos[playerid][idx][PosY],MarkPos[playerid][idx][PosZ]);
            }
            SetInterior(playerid, MarkPos[playerid][idx][Interior]);
            SetVirtualWorld(playerid, MarkPos[playerid][idx][VW]);
            SendTeleportMessage(playerid);
        }
        else if(strcmp(params, "M2", true) == 0 || strcmp(params, "Mark2", true) == 0)
        {
            new idx = 1;
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                SetVehiclePos(vehicleid, MarkPos[playerid][idx][PosX],MarkPos[playerid][idx][PosY],MarkPos[playerid][idx][PosZ]);
                LinkVehicleToInterior(vehicleid, MarkPos[playerid][idx][Interior]);
                SetVehicleVirtualWorld(vehicleid, MarkPos[playerid][idx][VW]);
            }
            else
            {
                SetPlayerPosEx(playerid, MarkPos[playerid][idx][PosX],MarkPos[playerid][idx][PosY],MarkPos[playerid][idx][PosZ]);
            }
            SetInterior(playerid, MarkPos[playerid][idx][Interior]);
            SetVirtualWorld(playerid, MarkPos[playerid][idx][VW]);
            SendTeleportMessage(playerid);
        }

        for(new i; i < MAX_TELEPORTS; i++)
        {
            if(TeleportInfo[i][teleID] && strcmp(TeleportInfo[i][teleName], params, true) == 0)
            {
                if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                {
                    SetVehiclePos(vehicleid, TeleportInfo[i][teleX], TeleportInfo[i][teleY], TeleportInfo[i][teleZ]);
                    LinkVehicleToInterior(vehicleid, TeleportInfo[i][teleInterior]);
                    SetVehicleVirtualWorld(vehicleid, TeleportInfo[i][teleWorld]);
                }
                else
                {
                    SetPlayerPosEx(playerid, TeleportInfo[i][teleX], TeleportInfo[i][teleY], TeleportInfo[i][teleZ]);
                }
                SetInterior(playerid, TeleportInfo[i][teleInterior]);
                SetVirtualWorld(playerid, TeleportInfo[i][teleWorld]);
                SendTeleportMessage(playerid);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Cannot find teleport.");
    }
    return 1;
}

CMD:getip(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/getip [PlayerID/PartOfName]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 4)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SendClientMessageEx(playerid, COLOR_WHITE, "** IP of %s (ID: %d): %s", GetMasterName(targetid), targetid, GetUserIP(targetid));
    }
    return 1;
}

CMD:gethere(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/gethere [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(playerid))
            return SendErrorMessage(playerid, "No such player is connected.");

        if(targetid == playerid)
            return SendErrorMessage(playerid, "You cannot do this.");

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 4)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        // Send targetid to playerid's location
        new Float:x, Float:y, Float:z, vehicleid = GetPlayerVehicleID(targetid);
        GetPlayerPos(playerid, x, y, z);

        if(GetPlayerState(targetid) == PLAYER_STATE_DRIVER)
        {
            SetVehiclePos(vehicleid, x, y-1, z);
            LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
            SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
        }
        else
        {
            SetPlayerPosEx(targetid, x, y-1, z);
        }
        SetInterior(targetid, GetPlayerInterior(playerid));
        SetVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
        SendTeleportMessage(targetid);
    }
    return 1;
}

CMD:adminflush(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            foreach(new i: Player)
            {
                ClearChat(i, 35);
            }
            return 1;
        }

        ClearChat(targetid, 35);
    }
    return 1;
}
alias:adminflush("aflush", "aclearchat");

CMD:areaspeak(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new Float:range, text[128];
        if(sscanf(params, "fs[128]", range, text))
        {
            SendUsageMessage(playerid, "/areaspeak (/as) [Range] [message]");
            return 1;
        }

        if(TempVar[playerid][Muted] == true)
		    return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        if(strlen(text) > 70)
        {
            SendNearbyMessage(playerid, range, COLOR_GREY, "(( %s {00FF00}%s{%06x}: %.70s ... ))", GetAdminRank(playerid), GetMasterName(playerid), COLOR_GREY >>> 8, text);
            SendNearbyMessage(playerid, range, COLOR_GREY, "(( %s {00FF00}%s{%06x}: ... %s ))", GetAdminRank(playerid), GetMasterName(playerid), COLOR_GREY >>> 8, text[70]);
        }
        else
        {
            SendNearbyMessage(playerid, range, COLOR_GREY, "(( %s {00FF00}%s{%06x}: %s ))", GetAdminRank(playerid), GetMasterName(playerid), COLOR_GREY >>> 8, text);
        }
        new logString[256];
        format(logString, sizeof(logString), "[Area Shout] %s (IP: %s AccountID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], text);
        DBLog("AdminChat", logString);
    }
    return 1;
}
alias:areaspeak("adminshout", "areashout", "as");

CMD:a(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/a [message]");
            return 1;
        }

        if(TempVar[playerid][Muted] == true)
		    return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        foreach(new i: Player)
        {
            if(Player[i][AdminLevel] >= 1 && GetPVarInt(i, "AdminDisabled") == 0)
            {
                if(strlen(params) > 70)
                {
                    SendClientMessageEx(i, COLOR_YELLOW, "* [ADMIN] %s %s (%s): %.70s ...", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
                    SendClientMessageEx(i, COLOR_YELLOW, "* [ADMIN] %s %s (%s): ... %s", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params[70]);
                }
                else
                {
                    SendClientMessageEx(i, COLOR_YELLOW, "* [ADMIN] %s %s (%s): %s", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
                }
            }
        }
        new logString[256];
        format(logString, sizeof logString, "[%s %s] %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        SendDiscordMessage(DISCORD_ADMIN, logString);
        format(logString, sizeof(logString), "%s (IP: %s AccountID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], params);
        DBLog("AdminChat", logString);
    }
    return 1;
}

CMD:afkkick(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new seconds;
        if(sscanf(params, "d", seconds))
        {
            SendUsageMessage(playerid, "/afkkick [Seconds]");
            return 1;
        }

        new count = 0;
        foreach(new i: Player)
        {
            if(Player[i][AdminLevel] < 1 || Player[i][HelperLevel] < 1)
            {
                if(TempVar[i][AFKSeconds] >= seconds)
                {
                    count++;
                    InsertKickLog(i, GetMasterName(playerid), "AFK");
                    SendClientMessage(i, COLOR_RED, "You were kicked by an administrator for being AFK.");
                    DelayedKick(i);
                }
            }
        }
        if(count == 0)
            return SendErrorMessage(playerid, "No players available.");
        
        new insertLog[256];
        format(insertLog, sizeof insertLog, "%s %s has kicked %d player(s) for being AFK. (Seconds: %d)", GetAdminRank(playerid), GetMasterName(playerid), count, seconds);
        SendAdminCommand(insertLog, 1);
    }
    return 1;
}

stock InsertKickLog(playerid, adminName[], reason[])
{
    new insertLog[256];
    mysql_format(g_SQL, insertLog, sizeof(insertLog), "INSERT INTO kick_logs (`KickedDBID`, `KickedName`, `Reason`, `KickedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
    Player[playerid][ID], GetMasterName(playerid), reason, adminName, GetDateTime()); 
    mysql_tquery(g_SQL, insertLog);
}

CMD:skick(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, reason[128];
        if(sscanf(params, "us[128]", targetid, reason))
        {
            SendUsageMessage(playerid, "/skick [PlayerID/PartOfName] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        new insertLog[256];
        format(insertLog, sizeof insertLog, "%s was silently kicked by %s %s. Reason: %s", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid), reason);
        SendAdminCommand(insertLog, 1);
        format(insertLog, sizeof insertLog, "%s (IP: %s AccountID: %d) was silently kicked by %s (IP: %s AccountID: %d). Reason: %s", GetUserName(targetid), targetid, Player[targetid][ID], GetUserName(playerid), playerid, Player[playerid][ID]);
        DBLog("Kick", insertLog);
        ShowFlagsToAdmins(targetid);
        InsertKickLog(targetid, GetMasterName(playerid), reason);
        DelayedKick(targetid);
    }
    return 1;
}

CMD:kick(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, reason[128];
        if(sscanf(params, "us[128]", targetid, reason))
        {
            SendUsageMessage(playerid, "/kick [PlayerID/PartOfName] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        new insertLog[256];
        format(insertLog, sizeof insertLog, "%s was kicked by %s. Reason: %s", GetUserName(targetid), GetMasterName(playerid), reason);
        SendAdminCommand(insertLog);

        TogglePlayerControllable(targetid, false);

        ShowFlagsToAdmins(targetid);

        InsertKickLog(targetid, GetMasterName(playerid), reason);

        format(insertLog, sizeof(insertLog), "You have been kicked from the server.\n\nAdmin: %s\nDate: %s\n\nReason:\n%s", GetMasterName(playerid), GetDateTime(), reason);
	    Dialog_Show(targetid, Unused, DIALOG_STYLE_MSGBOX, "Kicked", insertLog, "Close", "");

        DelayedKick(targetid);
    }
    return 1;
}

CMD:ban(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, days, reason[128];
        if(sscanf(params, "uds[128]", targetid, days, reason))
        {
            SendUsageMessage(playerid, "/ban [PlayerID/PartOfName] [days(0=permanent)] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        ScriptBan(targetid, playerid, days, reason);
    }
    return 1;
}

CMD:sban(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, days, reason[128];
        if(sscanf(params, "uds[128]", targetid, days, reason))
        {
            SendUsageMessage(playerid, "/sban [PlayerID/PartOfName] [days(0=permanent)] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        ScriptBan(targetid, playerid, days, reason, 1);
    }
    return 1;
}

CMD:oban(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new username[MAX_PLAYER_NAME+1], days, reason[128];
        if(sscanf(params, "s[25]ds[128]", username, days, reason))
        {
            SendUsageMessage(playerid, "/oban [master account name] [days(0=permanent)] [reason]");
            return 1;
        }

        foreach(new i : Player)
        {
            if(!strcmp(GetMasterName(i), username))
            {
                SendErrorMessage(playerid, "%s is connected to the server with ID %i.", username, i);
                return 1;
            }
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "SELECT `id`, `AdminLevel`, `Username`, `StoredIP`, `StoredGPCI` FROM `players` WHERE `Username` = '%e' LIMIT 1", username);
        mysql_tquery(g_SQL, query, "OnUserOfflineBan", "sdds", username, playerid, days, reason);
    }
    return 1;
}

CMD:unban(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new username[MAX_PLAYER_NAME+1];
        if(sscanf(params, "s[25]", username))
        {
            SendUsageMessage(playerid, "/unban [master account name]");
            return 1;
        }

        format(TempVar[playerid][UnbanName], 128, "%s", username);
        new query[256];
        mysql_format(g_SQL, query, sizeof query, "SELECT `id` FROM `players` WHERE `username` = '%e' LIMIT 1", username);
        mysql_tquery(g_SQL, query, "Unban_GetAccountID", "d", playerid);
    }
    return 1;
}

function Unban_GetAccountID(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new accountID, query[256];
        cache_get_value_int(0, "id", accountID);
        mysql_format(g_SQL, query, sizeof query, "DELETE FROM bans WHERE `AccountID` = %d", accountID);// Do not LIMIT 1 as there could be more than 1 ban in place for the user.
        mysql_tquery(g_SQL, query, "Unban_Finalize", "d", playerid);
    }
    else SendErrorMessage(playerid, "Cannot find account.");
    return 1;
}

function Unban_Finalize(playerid)
{
    if(!mysql_errno(g_SQL))
    {
        new string[128], rows = cache_affected_rows();

        if(!rows) return SendErrorMessage(playerid, "No bans matching that criteria were found");
        format(string, sizeof(string), "%s %s has unbanned %s.", GetAdminRank(playerid), GetMasterName(playerid), TempVar[playerid][UnbanName]);
        SendAdminCommand(string, 1);
        SendClientMessageEx(playerid, COLOR_WHITE, "%d ban records removed.", rows);
    }
    else SendErrorMessage(playerid, "There was an issue removing that ban ...");
    return 1;
}

CMD:banip(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new ipAddr[128], reason[128];
        if(sscanf(params, "s[128]s[128]", ipAddr, reason))
        {
            SendUsageMessage(playerid, "/banip [IP Address (Ex. 192.168.0.1)] [Reason]");
            return 1;
        }

        SendClientMessage(playerid, COLOR_WHITE, "Attempting IP ban...");
        foreach(new i : Player)
        {
            if(strcmp(GetUserIP(i), ipAddr, true) == 0)
            {
                ScriptBan(i, playerid, 0, reason);
            }
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `bans` (`AccountID`, `Admin`, `UnbanTimestamp`, `Reason`, `IPAddress`) VALUES (0, '%e', 0, '%e', '%e')", GetMasterName(playerid), reason, ipAddr);
        mysql_tquery(g_SQL, query, "OnIPBan", "dss", playerid, ipAddr, reason);
    }
    return 1;
}

CMD:showpm(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(strcmp(params, "off", true) == 0 && TempVar[playerid][WatchingPM] != INVALID_PLAYER_ID)
        {
            SendServerMessage(playerid, "You have stopped watching %s's private messages.", GetUserName(TempVar[playerid][WatchingPM]));
            TempVar[playerid][WatchingPM] = INVALID_PLAYER_ID;
            return 1;
        }

        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/showpm [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");
        
        new string[144];
        TempVar[playerid][WatchingPM] = targetid;

        format(string, sizeof string, "%s %s is now watching %s's (%s) private messages.", GetAdminRank(playerid), GetMasterName(playerid), GetUserName(targetid), GetMasterName(playerid));
        SendAdminWarning(2, string);
    }
    return 1;
}

CMD:vehslap(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/vehslap [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        if(GetPlayerVehicleID(targetid))
        {
            new Float:x, Float:y, Float:z, vehid = GetPlayerVehicleID(playerid);
            GetVehiclePos(vehid, x, y, z);
            SetVehiclePos(vehid, x, y, z+5);
            PlayerPlaySound(targetid, 1130, x, y, z+5);
            if(targetid != playerid) 
            {
                new string[256];
                format(string, sizeof string, "%s was vehicle slapped by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
                SendAdminCommand(string, 1);
                SendClientMessageEx(targetid, COLOR_GREY, "%s was vehicle slapped by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
            }
        }
        else SendErrorMessage(playerid, "This player is not inside a vehicle.");
    }
    return 1;
}

CMD:slap(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, Float:height;
        if(sscanf(params, "uF(5.9)", targetid, height))
        {
            SendUsageMessage(playerid, "/slap [PlayerID/PartOfName] [Height(Optional)]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        SetPlayerPosEx(targetid, x, y, z+height);
        PlayerPlaySound(targetid, 1130, 0.0, 0.0, 0.0);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s was slapped by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
            SendAdminCommand(string, 1);
            SendClientMessageEx(targetid, COLOR_GREY, "%s was slapped by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        }
    }
    return 1;
}

CMD:sf(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid, string[128];
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/sf [PlayerID/PartOfName]");

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "This player is not connected or not logged in.");

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        TogglePlayerControllable(targetid, false);
        format(string, sizeof string, "%s was silent-frozen by %s.", GetUserName(targetid), GetMasterName(playerid));
        SendAdminWarning(2, string);
    }
    return 1;
}

CMD:freeze(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/freeze [PlayerID/PartOfName]");

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "This player is not connected or not logged in.");

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        TogglePlayerControllable(targetid, false);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s was frozen by %s.", GetUserName(targetid), GetUserName(playerid));
            SendAdminCommand(string, 1);
        }
        SendServerMessage(targetid, "You were frozen by %s", GetUserName(playerid));
    }
    return 1;
}

CMD:unfreeze(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/unfreeze [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        TogglePlayerControllable(targetid, true);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s was unfrozen by %s.", GetUserName(targetid), GetUserName(playerid));
            SendAdminCommand(string, 1);
        }
        SendServerMessage(targetid, "You were unfrozen by %s", GetUserName(playerid));
    }
    return 1;
}

CMD:setjob(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, jobid;
        if(sscanf(params, "ud", targetid, jobid))
        {
            SendUsageMessage(playerid, "/setjob [PlayerID/PartOfName] [jobid]");
            SendClientMessage(playerid, -1, "NOTE: See forums for custom skins, see SAMP Wiki for Default skins.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        PlayerInfo[targetid][pJob] = jobid;
        if(targetid != playerid) 
        {
            new string[128];
            format(string, sizeof string, "%s's job was set to %s by %s.", GetUserName(targetid), GetJobName(jobid), GetUserName(playerid));
            SendAdminCommand(string, 2);
        }
        SendServerMessage(targetid, "Your job was set to %s by %s.", GetJobName(jobid), GetMasterName(playerid));
    }
    return 1;
}

CMD:setskin(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, skin;
        if(sscanf(params, "ud", targetid, skin))
        {
            SendUsageMessage(playerid, "/setskin [PlayerID/PartOfName] [skinid]");
            SendClientMessage(playerid, -1, "NOTE: See forums for custom skins, see SAMP Wiki for Default skins.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SetSkin(targetid, skin);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's skin was set to %d by %s.", GetUserName(targetid), skin, GetUserName(playerid));
            SendAdminCommand(string, 2);
        }
        SendServerMessage(targetid, "Your skin was set by %s.", GetUserName(playerid));
    }
    return 1;
}

CMD:sethealth(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, Float:health;
        if(sscanf(params, "uf", targetid, health))
        {
            SendUsageMessage(playerid, "/sethealth [PlayerID/PartOfName] [health(0-100)]");
            return 1;
        }


        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        if(health > 100 && Player[targetid][AdminLevel] < 1)
            return SendErrorMessage(playerid, "Cannot set health above 100.");

        if(health > 0)
        {
            SetPlayerHealthEx(targetid, health);
        }
        else
        {
            StopAnim(targetid);
			if(IsPlayerInAnyVehicle(targetid))
			{
				new Float:slx, Float:sly, Float:slz, vid = GetPlayerVehicleID(playerid);
				GetPlayerPos(targetid, slx, sly, slz);
				SetPlayerPosEx(targetid, slx, sly, slz+1.3);
				RemovePlayerFromVehicle(targetid);
				SetTimerEx("OnDeathNOPCheck", 2000, false, "dd", targetid, vid);
			}
			
			new string[256];
            OnPlayerWounded(targetid, playerid, 0);
			format(string, sizeof(string), "%s (IP: %s AccountID: %d) has brutally wounded %s (IP: %s AccountID: %d) with /sethealth.", GetUserName(targetid), GetUserIP(targetid), Player[targetid][ID], GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
			DBLog("Wounded", string);
        }

        //Reset weapon skills
        SetPlayerSkillLevel(targetid, WEAPONSKILL_AK47, 999);
        SetPlayerSkillLevel(targetid, WEAPONSKILL_DESERT_EAGLE, 999);
        SetPlayerSkillLevel(targetid, WEAPONSKILL_SHOTGUN, 999);
        SetPlayerSkillLevel(targetid, WEAPONSKILL_M4, 999);
        SetPlayerSkillLevel(targetid, WEAPONSKILL_MP5, 999);
        SetPlayerSkillLevel(targetid, WEAPONSKILL_SPAS12_SHOTGUN, 999);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's health was set to %f by %s.", GetUserName(targetid), health, GetUserName(playerid));
            SendAdminCommand(string, 2);
        }
        SendServerMessage(targetid, "Your health was set by %s.", GetUserName(playerid));
    }
    return 1;
}

CMD:setarmour(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, Float:armour;
        if(sscanf(params, "uf", targetid, armour))
        {
            SendUsageMessage(playerid, "/setarmour [PlayerID/PartOfName] [armour(0-100)]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SetPlayerArmourEx(targetid, armour);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's armour was set to %f by %s.", GetUserName(targetid), armour, GetUserName(playerid));
            SendAdminCommand(string, 2);
        }
        SendServerMessage(targetid, "Your armour was set by %s.", GetUserName(playerid));
    }
    return 1;
}

CMD:flip(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(TempVar[playerid][AdminDuty] == false && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You need to be on admin duty.");

        new vehicleid;
        if(sscanf(params, "d", vehicleid))
        {
            SendUsageMessage(playerid, "/flip [Vehicle ID] - Use /dl to get the Vehicle ID.");
            return 1;
        }

        if(IsValidVehicle(vehicleid))
        {
            new Float:vrot;
            GetVehicleZAngle(vehicleid, vrot);
            SetVehicleZAngle(vehicleid, vrot);
            SendClientMessageEx(playerid, COLOR_YELLOW, "> {FFFFFF}Vehicle %d flipped!", vehicleid);
        }
        else SendErrorMessage(playerid, "Invalid vehicle specified.");
    }
    return 1;
}

CMD:arepair(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(TempVar[playerid][AdminDuty] == false && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You need to be on admin duty.");

        new vehicleid;
        if(sscanf(params, "d", vehicleid))
        {
            SendUsageMessage(playerid, "/arepair [Vehicle ID] - Use /dl to get the Vehicle ID.");
            return 1;
        }

        if(IsValidVehicle(vehicleid))
        {
            RepairVehicle(vehicleid);
            SendClientMessageEx(playerid, COLOR_YELLOW, "> {FFFFFF}Vehicle %d fixed!", vehicleid);
        }
        else SendErrorMessage(playerid, "Invalid vehicle specified.");
    }
    return 1;
}

CMD:arefuel(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(TempVar[playerid][AdminDuty] == false && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You need to be on admin duty.");

        new vehicleid;
        if(sscanf(params, "d", vehicleid))
        {
            SendUsageMessage(playerid, "/arefuel [Vehicle ID] - Use /dl to get the Vehicle ID.");
            return 1;
        }

        if(IsValidVehicle(vehicleid))
        {
            CoreVehicle[vehicleid][VehicleFuel] = 100;
            SendClientMessageEx(playerid, COLOR_YELLOW, "> {FFFFFF}Vehicle %d refueled!", vehicleid);
        }
        else SendErrorMessage(playerid, "Invalid vehicle specified.");
    }
    return 1;
}

CMD:asetfuel(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(TempVar[playerid][AdminDuty] == false && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You need to be on admin duty.");

        new vehicleid, Float:fuel;
        if(sscanf(params, "df", vehicleid, fuel))
        {
            SendUsageMessage(playerid, "/asetfuel [Vehicle ID] [Fuel] - Use /dl to get the Vehicle ID.");
            return 1;
        }

        if(IsValidVehicle(vehicleid))
        {
            if(fuel > 100)
            {
                fuel = 100;
            }
            if(fuel < 0)
            {
                fuel = 0;
            }
            CoreVehicle[vehicleid][VehicleFuel] = fuel;
            SendClientMessageEx(playerid, COLOR_YELLOW, "> {FFFFFF}Vehicle %d fuel set to %.1f!", vehicleid, fuel);
        }
        else SendErrorMessage(playerid, "Invalid vehicle specified.");
    }
    return 1;
}

CMD:setint(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, interior;
        if(sscanf(params, "ud", targetid, interior))
        {
            SendUsageMessage(playerid, "/setint [PlayerID/PartOfName] [interior]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SetInterior(targetid, interior);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's interior was set to %d by %s.", GetUserName(targetid), interior, GetUserName(playerid));
            SendAdminCommand(string, 1);
        }
    }
    return 1;
}

CMD:setgender(playerid, params[])
{
    if(IsAdminLevel(playerid, 1, false) || IsHelperLevel(playerid, 1, false))
    {
        new targetid, gender;
        if(sscanf(params, "ud", targetid, gender))
        {
            SendUsageMessage(playerid, "/setgender [PlayerID/PartOfName] [Gender (0 = Male/1 = Female)]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(gender < 0 || gender > 1)
            return SendErrorMessage(playerid, "Valid genders are 0 (Male) and 1 (Female).");

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        new string[256], genderStr[7];
        if(gender)
        {
            genderStr = "female";
        }
        else
        {
            genderStr = "male";
        }
        if(Player[targetid][AdminLevel] < 1)
        {
            format(string, sizeof string, "[Helper] %s's gender was set to %s by %s.", GetUserName(targetid), genderStr, GetMasterName(playerid));
            SendHelperMessage(1, COLOR_LIGHTRED, string);
        }
        else
        {
            format(string, sizeof string, "%s's gender was set to %s by %s.", GetUserName(targetid), genderStr, GetMasterName(playerid));
            SendAdminCommand(string, 1);
        }
        if(targetid != playerid)
        {
            SendServerMessage(targetid, "Your gender was set to %s by %s.", gender, GetMasterName(playerid));
        }
    }
    else SendErrorMessage(playerid, "You are not authorised to use this command.");
    return 1;
}

CMD:setintvw(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, interior, vw;
        if(sscanf(params, "udd", targetid, interior, vw))
        {
            SendUsageMessage(playerid, "/setintvw [PlayerID/PartOfName] [interior] [virtual world]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SetVirtualWorld(targetid, vw);
        SetInterior(targetid, interior);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's virtual world and interior was set to %d & %d by %s.", GetUserName(targetid), vw, interior, GetUserName(playerid));
            SendAdminCommand(string, 1);
        }
    }
    return 1;
}

CMD:setvw(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, vw;
        if(sscanf(params, "ud", targetid, vw))
        {
            SendUsageMessage(playerid, "/setvw [PlayerID/PartOfName] [virtual world]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        SetVirtualWorld(targetid, vw);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s's virtual world was set to %d by %s.", GetUserName(targetid), vw, GetUserName(playerid));
            SendAdminCommand(string, 1);
        }
    }
    return 1;
}

CMD:unjail(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/unjail [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        ReleaseFromAdminJail(targetid);
        new string[256];
        format(string, sizeof string, "%s was released from admin jail by %s.", GetUserName(targetid), GetUserName(playerid));
        SendAdminCommand(string, 1);
    }
    return 1;
}

CMD:punjail(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/punjail [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        PlayerInfo[targetid][pJailTime] = 1;
        new string[256];
        format(string, sizeof string, "%s was released from police jail by %s.", GetUserName(targetid), GetUserName(playerid));
        SendAdminCommand(string, 1);
    }
    return 1;
}

CMD:mute(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, string[128];
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/mute [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(TempVar[targetid][Muted] == true)
        {
            SendErrorMessage(playerid, "This player is already muted. Use /unmute to unmute them.");
            return 1;
        }

        TempVar[targetid][Muted] = true;
        format(string, sizeof string, "%s was muted by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 1);
        SendClientMessageEx(targetid, COLOR_LIGHTRED, "You were muted by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
    }
    return 1;
}

CMD:unmute(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, string[128];
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/unmute [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(TempVar[targetid][Muted] == false)
        {
            SendErrorMessage(playerid, "This player is not muted. Use /mute to mute them.");
            return 1;
        }

        TempVar[targetid][Muted] = false;
        format(string, sizeof string, "%s was unmuted by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 1);
        SendClientMessageEx(playerid, COLOR_LIGHTRED, "You were unmuted by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
    }
    return 1;
}

CMD:mark(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new idx = 0;
        GetPlayerPos(playerid, MarkPos[playerid][idx][PosX], MarkPos[playerid][idx][PosY], MarkPos[playerid][idx][PosZ]);
        GetPlayerFacingAngle(playerid, MarkPos[playerid][idx][PosA]);
        MarkPos[playerid][idx][Interior] = GetPlayerInterior(playerid);
        MarkPos[playerid][idx][VW] = GetPlayerVirtualWorld(playerid);
        SendClientMessageEx(playerid, COLOR_YELLOW, "> Set \"/goto mark1\" position: %f, %f, %f [Interior: %d, VW: %d]",
            MarkPos[playerid][idx][PosX], MarkPos[playerid][idx][PosY], MarkPos[playerid][idx][PosZ],
            MarkPos[playerid][idx][Interior], MarkPos[playerid][idx][VW]);
    }
    return 1;
}

CMD:mark2(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new idx = 1;
        GetPlayerPos(playerid, MarkPos[playerid][idx][PosX], MarkPos[playerid][idx][PosY], MarkPos[playerid][idx][PosZ]);
        GetPlayerFacingAngle(playerid, MarkPos[playerid][idx][PosA]);
        MarkPos[playerid][idx][Interior] = GetPlayerInterior(playerid);
        MarkPos[playerid][idx][VW] = GetPlayerVirtualWorld(playerid);
        SendClientMessageEx(playerid, COLOR_YELLOW, "> Set \"/goto mark2\" position: %f, %f, %f [Interior: %d, VW: %d]",
            MarkPos[playerid][idx][PosX], MarkPos[playerid][idx][PosY], MarkPos[playerid][idx][PosZ],
            MarkPos[playerid][idx][Interior], MarkPos[playerid][idx][VW]);
    }
    return 1;
}

stock RespawnNearbyVehicles(iPlayerID, Float: fRadius) 
{
	new
		Float: fPlayerPos[3];

    GetPlayerPos(iPlayerID, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2]);
    for(new i = 1; i < MAX_VEHICLES; i++)
	{
		if(GetVehicleModel(i) && GetVehicleDistanceFromPoint(i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2]) <= fRadius && !IsVehicleOccupied(i))
		{
			RespawnVehicle(i);
		}
	}
	return 1;
}

CMD:respawncars(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
	{
		new str[128], radius;
		if(sscanf(params, "d", radius))
            return SendUsageMessage(playerid, "/respawncars [radius]");

		if(radius < 1 || radius > 50)
			return SendErrorMessage(playerid, "Radius must be between 1 and 50!");

		RespawnNearbyVehicles(playerid, radius);
        format(str, sizeof(str), "%s %s has respawned all vehicles within a radius of %d.", GetAdminRank(playerid), GetMasterName(playerid), radius);
        SendAdminCommand(str, 1);
	}
	return 1;
}

CMD:respawncar(playerid, params[])
{		
    if(IsAdminLevel(playerid, 1))
    {
        new vehicleid, str[128];
        
        if(sscanf(params, "d", vehicleid))
            return SendUsageMessage(playerid, "/respawncar [vehicleid]");
            
        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");
            
        RespawnVehicle(vehicleid);
        
        foreach(new i : Player)
        {
            if(GetPlayerVehicleID(i) == vehicleid)
            {
                SendClientMessageEx(i, COLOR_LIGHTRED, "[SYSTEM] The vehicle you're in was respawned by %s %s.", GetAdminRank(playerid), GetUserName(playerid));
            }
        }
        
        format(str, sizeof(str), "%s %s respawned vehicle ID %d.", GetAdminRank(playerid), GetUserName(playerid), vehicleid);
        SendAdminCommand(str, 1);
    }
	return 1;
}

CMD:goincar(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new vehicleid, seatid;
        
        if(sscanf(params, "dd", vehicleid, seatid))
        {
            SendUsageMessage(playerid, "/goincar [VehicleID] [SeatID] - Use /dl for the VehicleID.");
            SendClientMessage(playerid, -1, "Valid SeatID: 0. Driver, 1. Front Passenger");
            SendClientMessage(playerid, -1, "Valid SeatID: 2. Back-Left Passenger, 3. Back-Right Passenger");
            return 1;
        }

        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");

        if(seatid < 0 || seatid > 3)
            return SendErrorMessage(playerid, "Invalid SeatID. (0-3 are valid)");
            
        foreach(new i: Player)
        {
            if(GetPlayerVehicleSeat(i) == seatid && GetPlayerVehicleID(i) == vehicleid)
            {
                RemovePlayerFromVehicle(i);
                break;
            }
        }

        new Float:pos[3];
        GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
        SetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
        PutPlayerInVehicle(playerid, vehicleid, seatid);
        SetVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
        SendTeleportMessage(playerid);
    }
    return 1;
}
alias:goincar("goinveh");

CMD:gotocar(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new vehicleid;
        
        if(sscanf(params, "d", vehicleid))
            return SendUsageMessage(playerid, "/gotocar [vehicleid]");
            
        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");
            
        new Float:pos[3];
        GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
        SetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
        SetVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
        SendTeleportMessage(playerid);
    }
    return 1;
}
alias:gotocar("gotoveh");

CMD:getcar(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new 
            vehicleid,
            Float:x,
            Float:y,
            Float:z,
            str[128]
        ;
	
        
        if(sscanf(params, "d", vehicleid))
            return SendUsageMessage(playerid, "/getcar [vehicleid]");
            
        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");
            
        GetPlayerPos(playerid, x, y, z);
	
        SetVehiclePos(vehicleid, x, y, z);
        LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid)); 
        
        format(str, sizeof(str), "%s teleported vehicle ID %i to their location.", GetUserName(playerid), vehicleid);
        SendAdminCommand(str, 1);
        
        foreach(new i : Player)
        {
            if(!IsPlayerInAnyVehicle(i))
                continue;
                
            if(GetPlayerVehicleID(i) == vehicleid)
            {
                SendClientMessageEx(i, COLOR_LIGHTRED, "[SYSTEM] The vehicle you were in (%i) was teleported.", vehicleid); 
            }
        }
    }
    return 1;
}

CMD:listmasks(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Masked Players:");
        foreach(new i: Player)
        {
            if(TempVar[i][Masked] == true)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s MaskID: %d", i, GetUserName(playerid), PlayerInfo[playerid][pMaskID]);
            }
        }
    }
    return 1;
}

CMD:taxidrivers(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Taxi Drivers Online:");
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pJob] == JOB_TAXIDRIVER)
            {
                if(TempVar[i][JobDuty] == true)
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "[ID: %d]: %s", i, GetUserName(i));
                }
                else SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s", i, GetUserName(i));
            }
        }
    }
    return 1;
}

CMD:aimbotters(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Suspected Aimbotters Online:");
        foreach(new i: Player)
        {
            if(TempVar[i][SuspectedAimbotter] == true)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s (%s)", i, GetUserName(i), GetMasterName(i));
            }
        }
    }
    return 1;
}

CMD:leaders(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Faction Leaders Online:");
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pFaction] >= 1 && PlayerInfo[i][pFactionRank] == 1)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s %s (%s)", i, GetPlayerRank(i), GetUserName(i), GetFactionName(PlayerInfo[i][pFaction]));
            }
        }
    }
    return 1;
}

CMD:richlist(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Rich Players:");
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pMoney] >= 10000 || PlayerInfo[i][pBank] >= 10000)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s - In Hand: $%s | In Bank: $%s.", i, GetUserName(i), FormatNumber(PlayerInfo[i][pMoney]), FormatNumber(PlayerInfo[i][pBank]));
            }
        }
    }
    return 1;
}

CMD:idle(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Idle Players:");
        foreach(new i: Player)
        {
            if(TempVar[i][IdleTime] >= 2*60 && TempVar[i][AFKSeconds] <= 1) // This checks if the user has been standing still for a while but not paused.
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s (%s)", i, GetUserName(i), TimeConvert(TempVar[i][IdleTime]));
            }
        }
    }
    return 1;
}

CMD:afk(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "AFK Players:");
        foreach(new i: Player)
        {
            if(TempVar[i][AFKSeconds] >= 2) // This checks if the user is paused, check if the user is paused for more than 2 seconds to prevent false positives.
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s (%s)", i, GetUserName(i), TimeConvert(TempVar[i][AFKSeconds]));
            }
        }
    }
    return 1;
}

CMD:speclist(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new bool:found = false;
        SendClientMessage(playerid, COLOR_WHITE, "Spectating Administrators:");
        foreach(new i: Player)
        {
            if(TempVar[i][Spectating] != INVALID_PLAYER_ID && GetPlayerState(i) == PLAYER_STATE_SPECTATING)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s %s is spectating %s.", i, GetAdminRank(i), GetMasterName(i), GetUserName(TempVar[i][Spectating]));
                found = true;
            }
        }
        if(!found)
        {
            return SendErrorMessage(playerid, "There is nobody being spectated by anyone.");
        }
    }
    return 1;
}

CMD:sendtoid(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new playerb, targetid;

        if(sscanf(params, "uu", playerb, targetid))
        {
            SendUsageMessage(playerid, "/sendtoid [player id or name] [target id or name]");
            return 1;
        }

        if (!IsPlayerConnected(playerb) || !IsPlayerConnected(targetid))
        {
            SendErrorMessage(playerid, "One of the players you specified is not connected.");
            return 1;
        }

        if(!Player[playerb][IsLoggedIn] || !Player[targetid][IsLoggedIn])
        {
            SendErrorMessage(playerid, "One of the players you specified is not logged in.");
            return 1;
        }

        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        SetPlayerPosEx(playerb, x, y, z);

        SetInterior(playerb, GetPlayerInterior(targetid));
        SetVirtualWorld(playerb, GetPlayerVirtualWorld(targetid));
        SendTeleportMessage(playerid);

        new str[128];
        format(str, sizeof(str), "%s was teleported to %s by %s.", GetUserName(playerb), GetUserName(targetid), GetUserName(playerid));
        SendAdminCommand(str, 1);
    }
    return 1;
}

CMD:lastdmg(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/lastdmg [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        SendClientMessageEx(playerid, -1, "%s was last shot by %s on %s.", GetUserName(targetid), PlayerInfo[targetid][pLastShot], date(PlayerInfo[targetid][pLastShotTime]));
        SendClientMessageEx(playerid, -1, "%s was last rammed by %s on %s.", GetUserName(targetid), PlayerInfo[targetid][pLastRam], date(PlayerInfo[targetid][pLastRamTime]));
    }
    return 1;
}

CMD:afrisk(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/afrisk [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        FriskPlayer(playerid, targetid);
    }
    return 1;
}

CMD:forcesa(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new playerb;
        if(sscanf(params, "u", playerb))
            return SendUsageMessage(playerid, "/forcesa (force stop anim) [playerid OR name]"); 

        if(!IsPlayerConnected(playerb))
            return SendErrorMessage(playerid, "The player you specified isn't connected."); 

        if(!Player[playerb][IsLoggedIn])
            return SendErrorMessage(playerid, "The player you specified isn't logged in."); 

        StopAnim(playerb);
    }
	return 1;
}

CMD:revive(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new playerb, string[128];
        if(sscanf(params, "u", playerb))
            return SendUsageMessage(playerid, "/revive [playerid OR name]"); 

        if(!IsPlayerConnected(playerb))
            return SendErrorMessage(playerid, "The player you specified isn't connected."); 

        if(!Player[playerb][IsLoggedIn])
            return SendErrorMessage(playerid, "The player you specified isn't logged in."); 

        if(GetPlayerTeam(playerb) == PLAYER_ALIVE)
            return SendErrorMessage(playerid, "That player isn't dead or brutally wounded.");

        format(string, sizeof string, "%s was revived by %s %s.", GetUserName(playerb), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 1);
        if(playerb != playerid)
        {
            SendServerMessage(playerid, "You were revived by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
        }

        SetPlayerHealthEx(playerb, 99); 
        SetPlayerTeam(playerb, PLAYER_ALIVE);

        TogglePlayerControllable(playerb, 1); 

        SetPlayerChatBubble(playerb, "(( Revived ))", COLOR_WHITE, 21.0, 3000); 
        StopAnim(playerb);
        TempVar[playerb][OnPlayerDeathTriggered] = false;
        TempVar[playerb][AcceptedDeath] = false;

        SetPlayerSkillLevel(playerb, WEAPONSKILL_PISTOL, 998);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_MICRO_UZI, 998);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_SAWNOFF_SHOTGUN, 998);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_AK47, 999);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_DESERT_EAGLE, 999);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_SHOTGUN, 999);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_M4, 999);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_MP5, 999);
        SetPlayerSkillLevel(playerb, WEAPONSKILL_SPAS12_SHOTGUN, 999);
        ClearDamages(playerb);    
    }
	return 1;
}

function OnGMX(playerid)
{
    SendClientMessageToAllEx(COLOR_WHITE, "SERVER: %s has initialised a server restart. Please rejoin the server.", GetMasterName(playerid));
    SendRconCommand("password GameModeExitNoEntryNow");
    SendRconCommand("hostname [0.3.DL] United Gaming Roleplay [Restarting]");
    foreach(new i: Player)
    {
        PrintFooter(i, "Server Restart - Please reconnect to the server.", 3);
        TogglePlayerControllable(i, false);
    }
    SaveAllData();
    for(new i; i < MAX_DYN_VEH; i++)
    {
        ResetVehicleVars(i);
    }
    for(new i; i < MAX_VEHICLES; i++)
    {
        DestroyVehicle(i);
    }
    DestroyAllDynamicObjects();
    DestroyAllDynamic3DTextLabels();
    DestroyAllDynamicCPs();
    DestroyAllDynamicMapIcons();
    DestroyAllDynamicRaceCPs();
    DestroyAllDynamicAreas();
    SetTimer("InitGamemodeExit", 1000, false);
    return 1;
}

CMD:gmx(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new seconds;
        if(sscanf(params, "d", seconds))
            return SendUsageMessage(playerid, "/gmx [Seconds before restart]");
        
        SendClientMessageToAllEx(COLOR_WHITE, "SERVER: The server will be going down in %d seconds for a restart.", seconds);
        foreach(new i: Player)
        {
            GameTextForPlayer(i, "~y~Server Restart Alert", 5000, 6);
        }
        SetTimerEx("OnGMX", seconds*1000, false, "d", playerid);
    }
    return 1;
}

CMD:noooc(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new
            str[128]
        ;
            
        if(ServerInfo[OOCEnabled] == false)
        {   
            format(str, sizeof(str), "Global OOC has been enabled by %s.", GetMasterName(playerid));
            ServerInfo[OOCEnabled] = true;
        }
        else
        {
            format(str, sizeof(str), "Global OOC has been disabled by %s.", GetMasterName(playerid));
            ServerInfo[OOCEnabled] = false;
        }
        SendAdminCommand(str);
    }
    return 1;
}

CMD:backup(playerid, params[])
{
	if(IsAdminLevel(playerid, 1))
	{
        if(isnull(params))
            return SendUsageMessage(playerid, "/backup [players, factions, houses, biz, mapping, entrances, gates, jails, all]"); 
            
        new 
            str[128];
            
        if(!strcmp(params, "players", true))
        {
            foreach(new i : Player)
            {		
                UpdatePlayerData(i);
            }
            
            format(str, sizeof(str), "%s backed up player data (%i players).", GetMasterName(playerid), GetPlayerPoolSize());
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "factions", true))
        {
            SaveFactions();
            format(str, sizeof(str), "%s backed up all factions.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "houses", true))
        {
            SaveHouses();
            format(str, sizeof(str), "%s backed up all houses.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "graffiti", true))
        {
            SaveGraffitis();
            format(str, sizeof(str), "%s backed up all graffitis.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "complex", true))
        {
            SaveComplexes();
            format(str, sizeof(str), "%s backed up all houses.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "biz", true))
        {
            SaveBusinesses();
            format(str, sizeof(str), "%s backed up all businesses.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "mapping", true))
        {
            SaveMappings();
            format(str, sizeof(str), "%s backed up all mappings.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "entrances", true))
        {
            SaveEntrances();
            format(str, sizeof(str), "%s backed up all entrances.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "gates", true))
        {
            SaveGates();
            format(str, sizeof(str), "%s backed up all gates.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "jails", true))
        {
            SaveJails();
            format(str, sizeof(str), "%s backed up all jails.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "dealerships", true))
        {
            SaveDealerships();
            format(str, sizeof(str), "%s backed up all dealerships.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else if(!strcmp(params, "all", true))
        {
            foreach(new i : Player)
            {				
                UpdatePlayerData(i);
            }
            
            SaveAllData();

            format(str, sizeof(str), "%s has backed up server data.", GetMasterName(playerid));
            SendAdminCommand(str, 3); 
        }
        else return SendErrorMessage(playerid, "Invalid Paramater.");	
    }
	return 1;
}

stock SaveAllData()
{
    SaveFactions();
    SaveBusinesses();
    SaveHouses();
    SaveComplexes();
    SaveMappings();
    SaveEntrances();
    SaveGates();
    SaveJails();
    SaveDealerships();
    SaveGraffitis();
    SaveWeeds();
    SaveATMs();
    SaveLabels();
    SaveTruckerData();
    SaveFactionWeapons();
    SaveBlackMarkets();
    //SaveWarehouses();
}

CMD:gotoxyz(playerid, params[])
{
	new Float:gotoPos[3], int;
	if(Player[playerid][AdminLevel] >= 5)
    {
        if(sscanf(params, "fffd", gotoPos[0], gotoPos[1], gotoPos[2], int)) return SendUsageMessage(playerid, "/gotoxyz (X) (Y) (Z) (Int)");
        SetPlayerPosEx(playerid, gotoPos[0], gotoPos[1], gotoPos[2]);
        SetInterior(playerid, int);
    }
    return 1;
}

CMD:gotopos(playerid, params[])
{
	if(IsAdminLevel(playerid, 3))
    {
        new
            Float:x,
            Float:y,
            Float:z,
            interior
        ; 
        
        if(sscanf(params, "fffi", x, y, z, interior))
            return SendUsageMessage(playerid, "/gotopoint [x] [y] [z] [interior id]"); 
            
        SetPlayerPosEx(playerid, x, y, z);
        SetInterior(playerid, interior);
        
        SendTeleportMessage(playerid);
    }
	return 1;
}

CMD:accountname(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new giveplayerid, name[MAX_PLAYER_NAME];
        if(sscanf(params, "us["#MAX_PLAYER_NAME"]", giveplayerid, name))
        {
            SendUsageMessage(playerid, "/accountname [PlayerID/PartOfName] [Accountname]");
            return 1;
        }

        if(strlen(name) > MAX_PLAYER_NAME)
            return SendErrorMessage(playerid, "You can't select a name that's above %d characters.", MAX_PLAYER_NAME);

        new query[128], tmpName[32];
        mysql_escape_string(name, tmpName, sizeof(tmpName));
        if(strcmp(name, tmpName, false) == 0)
        {
            SetPVarString(playerid, "OnSetName", tmpName);

            mysql_format(g_SQL, query, sizeof(query), "UPDATE `players` SET `username` = '%e' WHERE `id`= %d LIMIT 1", tmpName, Player[playerid][ID]);
            mysql_tquery(g_SQL, query, "OnSetName", "ii", playerid, giveplayerid);
        }
        else return SendErrorMessage(playerid, "Invalid characters!");
    }
    return 1;
}

CMD:setname(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new giveplayerid, name[MAX_PLAYER_NAME];
        if(sscanf(params, "us[24]", giveplayerid, name))
        {
            SendUsageMessage(playerid, "/setname [PlayerID/PartOfName] [New_Name]");
            return 1;
        }

        if(Player[giveplayerid][AdminLevel] >= 1 && giveplayerid != playerid)
        {
            if(Player[playerid][AdminLevel] < 5)
            {
                SendErrorMessage(playerid, "You are not allowed to do this.");
                return 1;
            }
        }

        if(!IsRPName(name))
            return SendErrorMessage(playerid, "You cannot choose a Non-RP name");

        if(strlen(name) > MAX_PLAYER_NAME)
            return SendErrorMessage(playerid, "You can't select a name that's above %d characters.", MAX_PLAYER_NAME);

        new query[128], tmpName[32];
        mysql_escape_string(name, tmpName, sizeof(tmpName));
        if(strcmp(name, tmpName, false) == 0)
        {
            SetPVarString(giveplayerid, "OnSetName", tmpName);
            mysql_format(g_SQL, query, sizeof(query), "SELECT `Name` FROM `characters` WHERE `Name` = '%e' LIMIT 1", tmpName);
            mysql_tquery(g_SQL, query, "OnAdminSetNameCheck", "ii", playerid, giveplayerid);
        }
        else return SendErrorMessage(playerid, "Invalid characters!");
    }
    return 1;
}

function OnAdminSetNameCheck(playerid, giveplayerid)
{
    if(cache_num_rows() == 0)
    {
        new query[256], tmpName[MAX_PLAYER_NAME+1];
        GetPVarString(playerid, "OnSetName", tmpName, sizeof tmpName);
        mysql_format(g_SQL, query, sizeof(query), "UPDATE `characters` SET `Name` = '%e' WHERE `CharacterID`= '%d'  LIMIT 1", tmpName, PlayerInfo[giveplayerid][pCharacterID]);
        mysql_tquery(g_SQL, query, "OnSetName", "ii", playerid, giveplayerid);
    }
    else SendErrorMessage(playerid, "That name is currently taken.");
    return 1;
}

CMD:setaccname(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new giveplayerid, name[MAX_PLAYER_NAME];
        if(sscanf(params, "us[24]", giveplayerid, name))
        {
            SendUsageMessage(playerid, "/setaccname [PlayerID/PartOfName] [New_Name]");
            return 1;
        }

        if(Player[giveplayerid][AdminLevel] >= 1 && giveplayerid != playerid)
        {
            if(Player[playerid][AdminLevel] < 5)
            {
                SendErrorMessage(playerid, "You are not allowed to do this.");
                return 1;
            }
        }

        if(strlen(name) > MAX_PLAYER_NAME)
            return SendErrorMessage(playerid, "You can't select a name that's above %d characters.", MAX_PLAYER_NAME);

        new query[128], tmpName[32];
        mysql_escape_string(name, tmpName, sizeof(tmpName));
        if(strcmp(name, tmpName, false) == 0)
        {
            SetPVarString(playerid, "OnSetName", tmpName);

            mysql_format(g_SQL, query, sizeof(query), "UPDATE `players` SET `username` = '%e' WHERE `id`= '%d' LIMIT 1", tmpName, Player[giveplayerid][ID]);
            mysql_tquery(g_SQL, query, "OnSetAccountName", "ii", playerid, giveplayerid);
        }
        else return SendErrorMessage(playerid, "Invalid characters!");
    }
    return 1;
}

CMD:amask(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/amask [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        new str[128];
        if(PlayerInfo[targetid][pMask] == 0)
        {
            PlayerInfo[targetid][pMask] = 1;
            format(str, sizeof(str), "%s has given %s the ability to use /mask.", GetMasterName(playerid), GetUserName(targetid));
        }
        else
        {
            PlayerInfo[targetid][pMask] = 0;
            format(str, sizeof(str), "%s has removed %s's ability to use /mask.", GetMasterName(playerid), GetUserName(targetid));
        }
        SendAdminCommand(str, 2); 
    }
    return 1;
}

stock RemoveWeaponFromRegistry(serial)
{
    new query[256];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `WeaponRegistry` WHERE `WeaponRegistry`.`Serial` = %d", serial);
	mysql_tquery(g_SQL, query);
}

stock AddWeaponToRegistry(playerid, info[], serial[], weaponname[])
{
	new query[256];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO WeaponRegistry (Player, Info, Serial, WeaponName, Date) VALUES ('%e', '%e', '%e', '%e', NOW())", GetUserName(playerid), info, serial, weaponname);
	mysql_tquery(g_SQL, query);
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(IsAdminLevel(playerid, 3))
    {
        new playerb, weaponid, ammo, legal = 0, str[128];
        
        if(sscanf(params, "uiiI(0)", playerb, weaponid, ammo, legal))
        {
            SendUsageMessage(playerid, "/givegun [playerid OR name] [weaponid] [ammo] [legal 0/1 (default 0)]");
            SendClientMessage(playerid, COLOR_GRAD6, "1. Brass Knuckles, 2. Golf Club, 3. Nightstick, 4. Knife, 5. Baseball Bat"); 
            SendClientMessage(playerid, COLOR_GRAD5, "6. Shovel, 7. Pool Cue, 8. Katana, 9. Chainsaw, 10. Purple Dildo, 11. Dildo"); 
            SendClientMessage(playerid, COLOR_GRAD4, "12. Vibrator, 13. Silver Vibrator, 14. Flowers, 15. Cane, 17. Tear Gas, 22. 9mm"); 
            SendClientMessage(playerid, COLOR_GRAD3, "23. Silenced, 24. Deagle, 25. Shotgun, 26. Sawn Off, 27. Spas 12, 28. Uzi, 29. Mp5"); 
            SendClientMessage(playerid, COLOR_GRAD2, "30. Ak47, 31. M4, 32. Tec, 33. Country, 34. Sniper, 41. Spraycan, 42. Extinguisher"); 
            SendClientMessage(playerid, COLOR_GRAD1, "43. Camera, 44. Parachute"); 
            SendServerMessage(playerid, "These weapons save to the players account."); 
            return 1;
        }
        
        if (!IsPlayerConnected(playerb))
            return SendErrorMessage(playerid, "A player you specified isn't connected to the server."); 
            
        if (Player[playerb][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "A player you specified isn't logged in."); 
            
        if(weaponid < 1 || weaponid > 46)
            return SendErrorMessage(playerid, "You have specified an invalid weaponid.");

        if(weaponid == 16 || weaponid == 18 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39 || weaponid == 45)
            return SendErrorMessage(playerid, "You cannot give an unauthorised weapon.");
            
        if(ammo < 1 || ammo > 9999)
            return SendErrorMessage(playerid, "You specified invalid ammo amount (1-9999 is valid).");
        
        new serial = 0, valstring[128];
        if(legal != 0)
        {
            serial = Random(10000, 999999999);
            valstr(valstring, serial);
            AddWeaponToRegistry(playerb, "Admin Given", valstring, GetServerWeaponName(weaponid));
        }
        AddInventory(playerb, INV_GUN, ammo, weaponid, serial);
        
        format(str, sizeof(str), "%s %s gave %s a %s with %d ammo. (Serial: %d)", GetAdminRank(playerid), GetMasterName(playerid), GetUserName(playerb), GetServerWeaponName(weaponid), ammo, serial);
        SendAdminCommand(str, 3);
        if(Player[playerb][AdminLevel] <  3)
        {
            SendServerMessage(playerb, "You were given a \"%s\" and %d ammo. (Serial: %d)", GetServerWeaponName(weaponid), ammo, serial);
        }
    }	
	return 1;
}

CMD:la(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/la [lead admin chat]");
            return 1;
        }

        if(strlen(params) > 70)
        {
            SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s %s: %.70s ...", GetAdminRank(playerid), GetMasterName(playerid), params);
            SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s %s: ... %s", GetAdminRank(playerid), GetMasterName(playerid), params[70]);
        }
        else
        {
            SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s %s: %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        }
        new logString[256];
        format(logString, sizeof logString, "[%s %s] %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        SendDiscordMessage(DISCORD_LEAD, logString);
        format(logString, sizeof(logString), "%s (IP: %s AccountID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], params);
        DBLog("LeadAdminChat", logString);
    }
    return 1;
}

CMD:createfveh(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new model, colour1, colour2, factionid;
    
        if(sscanf(params, "iiiiI(0)", factionid, model, colour1, colour2))
        {
            SendUsageMessage(playerid, "/createfveh [FactionID] [modelid] [colour 1] [colour 2]");
            return 1;
        }

        if(factionid < 1 || factionid > MAX_FACTIONS)
            return SendErrorMessage(playerid, "You have specified an invalid FactionID.");

        if(model < 400 || model > 611)
            return SendErrorMessage(playerid, "You have specified an invalid modelid.");

        if(colour1 < 0 || colour2 < 0 || colour1 > 255 || colour2 > 255)
            return SendErrorMessage(playerid, "You cannot give an invalid colour (0-255). See /colours.");
            
        GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
        
        CreateDynamicVehicle(model, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, colour1, colour2, 0, factionid, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    }	
    return 1;
}

CMD:veh(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new model, colour1, colour2, siren, str[128];
        
        if(sscanf(params, "iiiI(0)", model, colour1, colour2, siren))
        {
            SendUsageMessage(playerid, "/veh [modelid] [colour 1] [colour 2] [optional siren (0=default/off)]");
            return 1;
        }
            
        if(model < 400 || model > 611)
            return SendErrorMessage(playerid, "You have specified an invalid modelid.");

        if(colour1 < 0 || colour2 < 0 || colour1 > 255 || colour2 > 255)
            return SendErrorMessage(playerid, "You cannot give an invalid colour (0-255).");
            
        GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
        
        for(new i; i < sizeof(AdminVehicle); i++)
        {
            if(!IsValidVehicle(AdminVehicle[i]))
            {
                AdminVehicle[i] = CreateVehicle(model, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, colour1, colour2, -1);

                if(AdminVehicle[i] != INVALID_VEHICLE_ID)
                {
                    SetVehicleVirtualWorld(AdminVehicle[i], GetPlayerVirtualWorld(playerid));
	                LinkVehicleToInterior(AdminVehicle[i], GetPlayerInterior(playerid));
                    SetVehicleNumberPlate(AdminVehicle[i], "ADMIN");
                    SetVehicleToRespawn(AdminVehicle[i]);

                    format(str, sizeof(str), "%s has spawned a %s.", GetMasterName(playerid), ReturnVehicleModelName(model));
                    SendAdminCommand(str, 4);
                    CoreVehicle[AdminVehicle[i]][IsAdminVehicle] = true;
                    CoreVehicle[AdminVehicle[i]][VehicleFuel] = 100;
                    PutPlayerInVehicle(playerid, AdminVehicle[i], 0);
                }
                else SendErrorMessage(playerid, "Cannot spawn vehicle.");
                return 1;
            }
        }
        SendErrorMessage(playerid, "Cannot spawn vehicle.");
    }	
    return 1;
}

CMD:destroyallveh(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
    {
        new str[128];
    
        for(new i; i < sizeof(AdminVehicle); i++)
        {
            if(AdminVehicle[i] != INVALID_VEHICLE_ID)
            {
                CoreVehicle[AdminVehicle[i]][IsAdminVehicle] = false;
                DestroyVehicle(AdminVehicle[i]);
                AdminVehicle[i] = INVALID_VEHICLE_ID;
            }
        }
        format(str, sizeof(str), "%s has despawned all admin spawned vehicles.", GetMasterName(playerid));
        SendAdminCommand(str, 4);
    }
	return 1;
}

CMD:destroyveh(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
    {
        if(!IsPlayerInAnyVehicle(playerid))
            return SendErrorMessage(playerid, "You must be inside an admin spawned (/veh) vehicle.");
    
        new vehicleid = GetPlayerVehicleID(playerid), str[128];
        for(new i; i < sizeof(AdminVehicle); i++)
        {
            if(AdminVehicle[i] == vehicleid)
            {
                CoreVehicle[AdminVehicle[i]][IsAdminVehicle] = true;
                AdminVehicle[i] = INVALID_VEHICLE_ID;
                format(str, sizeof(str), "%s despawned admin veh %s (%d).", GetMasterName(playerid), ReturnVehicleName(vehicleid), vehicleid);
                SendAdminCommand(str, 4);
                DestroyVehicle(vehicleid);
                return 1;
            }
        }
        SendErrorMessage(playerid, "You must be inside an admin spawned (/veh) vehicle.");
    }
	return 1;
}

CMD:despawnveh(playerid, params[])
{
	if(IsAdminLevel(playerid, 1))
    {
        new vid;
        if(sscanf(params, "d", vid))
            return SendUsageMessage(playerid, "/despawnveh [vehicleid] - Use /dl for vehicleid.");
        
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == vid)
            {
                if(VehicleInfo[i][vFactionID] > 0)
                {
                    RespawnVehicle(VehicleInfo[i][vScriptID]);
                }
                else
                {
                    SaveVehicle(i);
                    foreach(new p: Player)
                    {
                        if(GetPlayerVehicleID(playerid) == vid)
                        {
                            RemovePlayerFromVehicle(p);
                        }
                        if(PlayerInfo[p][pSpawnedVehicle] == vid)
                        {
                            PlayerInfo[p][pSpawnedVehicle] = INVALID_VEHICLE_ID;
                        }
                    }
                    ResetVehicleVars(i);
                    DestroyVehicle(vid);
                }
                SendServerMessage(playerid, "Despawned vehicle %d.", vid);
                return 1;
            }
        }
        for(new i; i < sizeof(AdminVehicle); i++)
        {
            if(AdminVehicle[i] == vid)
            {
                CoreVehicle[AdminVehicle[i]][IsAdminVehicle] = false;
                DestroyVehicle(AdminVehicle[i]);
                AdminVehicle[i] = INVALID_VEHICLE_ID;
                SendServerMessage(playerid, "Despawned vehicle %d.", vid);
                return 1;
            }
        }
        for(new i; i < sizeof(RentalCars); i++)
        {
            if(RentalVehicle[i] == vid)
            {
                RespawnVehicle(vid);
                VehicleRented[vid] = INVALID_PLAYER_ID;
                SendServerMessage(playerid, "Despawned vehicle %d.", vid);
                return 1;
            }
        }
        if(IsValidVehicle(vid))
        {
            RespawnVehicle(vid);
            SendServerMessage(playerid, "Despawned vehicle %d.", vid);
            return 1;
        }
        SendErrorMessage(playerid, "Cannot despawn vehicle %d.", vid);
        return 1;
    }
	return 1;
}

CMD:destroydynveh(playerid, params[])
{
	if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/destroydynveh [vehicleid] - Use /vehid for vehicleid.");
        
        if(!VehicleInfo[i][vID])
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");
        
        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `vehicles` WHERE `ID` = %d LIMIT 1", VehicleInfo[i][vID]);
        mysql_tquery(g_SQL, query, "OnDestroyVeh", "ii", playerid, i);
        return 1;
    }
	return 1;
}

function OnDestroyVeh(playerid, carid)
{
    new str[128];
    ResetVehicleVars(carid);
    format(str, sizeof(str), "%s despawned dynamic veh %s (%d).", GetMasterName(playerid), ReturnVehicleName(VehicleInfo[carid][vScriptID]), carid);
    SendAdminCommand(str, 4);
    DestroyVehicle(VehicleInfo[carid][vScriptID]);
    return 1;
}

CMD:blowup(playerid, params[])
{
	new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendUsageMessage(playerid, "/blowup [player id or name]");
	if((Player[giveplayerid][AdminLevel] >= Player[playerid][AdminLevel]) && giveplayerid != playerid) return SendErrorMessage(playerid, "You cannot use this command on the same/greater level admin than you!");
    if(IsAdminLevel(playerid, 4))
    {
        if(IsPlayerConnected(giveplayerid))
        {
            format(string, sizeof(string), "%s has blown up %s.", GetMasterName(playerid), GetUserName(giveplayerid));
            SendAdminCommand(string, 4);
            new Float:boomx, Float:boomy, Float:boomz;
            GetPlayerPos(giveplayerid,boomx, boomy, boomz);
            CreateExplosion(boomx, boomy , boomz, 7, 1);
        }
        else SendErrorMessage(playerid, "Invalid player specified.");
    }
	return 1;
}

CMD:giveveh(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new model, colour1, colour2, giveid, str[128];
        
        if(sscanf(params, "uiii", giveid, model, colour1, colour2))
        {
            SendUsageMessage(playerid, "/giveveh [player id or name] [modelid] [colour 1] [colour 2]");
            SendServerMessage(playerid, "Make sure the player has no spawned vehicles first (make sure they're parked)!");
            return 1;
        }
            
        if(model < 400 || model > 611)
            return SendErrorMessage(playerid, "You have specified an invalid modelid.");

        if(colour1 < 0 || colour2 < 0 || colour1 > 255 || colour2 > 255)
            return SendErrorMessage(playerid, "You cannot give an invalid colour (0-255). See /colours.");

        if(GetPlayerInterior(playerid) != 0)
            return SendErrorMessage(playerid, "You must be outside. '/setint' yourself.");

        if(GetPlayerVirtualWorld(playerid) != 0)
            return SendErrorMessage(playerid, "You must be outside. '/setvw' yourself.");

        if(GetPlayerVirtualWorld(playerid) != 0)
            return SendErrorMessage(playerid, "You must set your virtual world to 0. '/setvw' yourself.");

        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vOwnerID] == PlayerInfo[giveid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
                return SendErrorMessage(playerid, "This player must park their currently spawned vehicles.");
        }

        GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
        
        SendServerMessage(playerid, "Giving vehicle...");
        for(new i; i < MAX_PVEH; i++)
        {
            if(!PlayerInfo[giveid][pOwnedVehicle][i])
            {
                CreateDynamicVehicle(model, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2], 0, colour1, colour2, PlayerInfo[giveid][pCharacterID], 0);
                format(str, sizeof(str), "%s has given a %s to %s.", GetMasterName(playerid), GetUserName(giveid), ReturnVehicleModelName(model), GetUserName(playerid));
                SendAdminWarning(4, str);
                SendServerMessage(playerid, "You received a vehicle from %s in slot %i.", GetMasterName(playerid), i);
                return 1;
            }
        }
    }	
    return 1;
}

function OnGiveVehicle(playerid, adminid, vehicleid)
{
    PlayerInfo[playerid][pOwnedVehicle][TempVar[playerid][GiveVehID]] = cache_insert_id();
    VehicleInfo[vehicleid][vOwnerID] = PlayerInfo[playerid][pCharacterID];

    new str[128];
    format(str, sizeof(str), "%s has given a %s to %s. (DatabaseID: %d)", GetMasterName(adminid), ReturnVehicleModelName(VehicleInfo[vehicleid][vModel]), GetUserName(playerid), PlayerInfo[playerid][pOwnedVehicle][TempVar[playerid][GiveVehID]]);
    SendAdminCommand(str, 4);
    SendServerMessage(playerid, "You received a vehicle from %s in slot %i.", GetMasterName(adminid), TempVar[playerid][GiveVehID]);
    TempVar[playerid][GiveVehID] = 0;
}

CMD:removehandcuff(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
	{
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/handcuff [playerid or name]");

        if(GetPlayerSpecialAction(targetid) != SPECIAL_ACTION_CUFFED)
            return SendErrorMessage(playerid, "That player is not handcuffed/tied up.");

        RemovePlayerAttachedObject(targetid, SLOT_HANDCUFF);
        SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);
        TempVar[targetid][Handcuffed] = false;
    }
    return 1;
}

CMD:check(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
	{
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/check [playerid or name]");

        ShowStats(targetid, playerid);
    }
    return 1;
}

CMD:rac(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
	{
        for(new v = 1; v < MAX_VEHICLES; v++)
		{
			new bool:despawn = true;
			foreach(new i : Player)
     		{
     			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == v)
     			{
     				despawn = false;
     			}
     		}

	        if(despawn == true)
	        {
			    RespawnVehicle(v);
		    }
	    }
        SendClientMessageToAllEx(COLOR_WHITE, "SERVER: %s %s has respawned all vehicles.", GetAdminRank(playerid), GetMasterName(playerid));
    }
    return 1;
}

function RespawnVehicle(vehicleid)
{
    for(new v; v < MAX_DYN_VEH; v++)
    {
        if(VehicleInfo[v][vScriptID] == vehicleid)
        {
            VehicleInfo[v][vEngine] = false;
            VehicleInfo[v][vLights] = false;
            VehicleInfo[v][vHood] = false;
            VehicleInfo[v][vAlarm] = false;
            break;
        }
    }
    CoreVehicle[vehicleid][VehicleEngine] = false;
    Flasher[vehicleid] = 0;
    SetVehicleToRespawn(vehicleid);
}

CMD:showmaster(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/showmaster [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        SendClientMessageEx(playerid, -1, "%s master name: %s.", GetUserName(targetid), GetMasterName(targetid));
    }
    return 1;
}

CMD:x(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
	{
	    new Float:x, Float:y, Float:z, Float:npos;
		if(sscanf(params, "f", npos)) return SendUsageMessage(playerid, "/x [Axis]");
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPosEx(playerid, x+npos, y, z);
		return 1;
	}
    return 1;
}

CMD:y(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
	{
	    new Float:x, Float:y, Float:z, Float:npos;
		if(sscanf(params, "f", npos)) return SendUsageMessage(playerid, "/y [Axis]");
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPosEx(playerid, x, y+npos, z);
		return 1;
	}
    return 1;
}

CMD:z(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
	{
	    new Float:x, Float:y, Float:z, Float:npos;
		if(sscanf(params, "f", npos)) return SendUsageMessage(playerid, "/z [Axis]");
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPosEx(playerid, x, y, z+npos);
	}
    return 1;
}

CMD:up(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPosEx(playerid, x, y, z+2);
    }
    return 1;
}

CMD:down(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPosEx(playerid, x, y, z-2);
    }
    return 1;
}

CMD:left(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPosEx(playerid, x, y+2, z);
    }
    return 1;
}

CMD:right(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPosEx(playerid, x, y-2, z);
    }
    return 1;
}

CMD:setdonate(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new targetid, level;
        if(sscanf(params, "ud", targetid, level))
        {
            SendUsageMessage(playerid, "/setdonate [PlayerID/PartOfName] [donator level]");
            SendClientMessage(playerid, -1, "0. None, 1. Bronze, 2. Silver, 3. Gold");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(level < 0 || level > 3)
            return SendErrorMessage(playerid, "You cannot use this level. 0-3 is the correct levels.");

        Player[targetid][DonateLevel] = level;
        Player[targetid][DonateExpire] = gettime()+(30*86400);
        if(targetid != playerid) 
        {
            new string[256];
            format(string, sizeof string, "%s has set %s's donate level to %d.", GetMasterName(targetid), GetMasterName(playerid), level);
            SendAdminCommand(string, 5);
        }
        SendServerMessage(targetid, "Your donate level was set to %s by %s.", GetDonateRank(level), GetMasterName(playerid));
        if(level != 0)
        {
            SendServerMessage(targetid, "It is set to expire on %s.", date(Player[targetid][DonateExpire]));
        }
    }
    return 1;
}

CMD:makeadmin(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new targetid, level;
        if(sscanf(params, "ud", targetid, level))
        {
            SendUsageMessage(playerid, "/makeadmin [PlayerID/PartOfName] [admin level]");
            SendClientMessage(playerid, -1, "NOTE: See forums for custom skins, see SAMP Wiki for Default skins.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(level < 0 || level > 6)
            return SendErrorMessage(playerid, "You cannot use this level. 0-6 is the correct levels.");

        Player[targetid][AdminLevel] = level;
        SetPVarInt(targetid, "AdminLevel", level);
        if(level == 0)
        {
            TempVar[playerid][AdminDuty] = false;
            SetPlayerTeamColour(playerid);
        }
        if(targetid != playerid) 
        {
            new string[85];
            format(string, sizeof string, "%s has set %s's admin level to %d.", GetMasterName(playerid), GetMasterName(targetid), level);
            SendAdminCommand(string, 5);
        }
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Your admin level was set to %d by %s.", level, GetMasterName(playerid));
    }
    return 1;
}

CMD:setmoney(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new targetid, level;
        if(sscanf(params, "ud", targetid, level))
        {
            SendUsageMessage(playerid, "/setmoney [PlayerID/PartOfName] [amount]");
            SendClientMessage(playerid, -1, "NOTE: Abuse of this will result in being removed.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(level < 0)
            return SendErrorMessage(playerid, "You cannot set less than 0.");

        PlayerInfo[targetid][pMoney] = level;
        new string[256];
        if(targetid != playerid) 
        {
            SendServerMessage(targetid, "Your money was set to $%s by %s.", FormatNumber(level), GetMasterName(playerid));
        }
        format(string, sizeof string, "%s has set %s's money to $%s.", GetUserName(playerid), GetMasterName(targetid), FormatNumber(level));
        SendAdminCommand(string, 4);
        format(string, sizeof(string), "%s (IP: %s AccountID: %d) has set %s's money to $%s.", GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(targetid), FormatNumber(level));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:givemoney(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new targetid, level;
        if(sscanf(params, "ud", targetid, level))
        {
            SendUsageMessage(playerid, "/givemoney [PlayerID/PartOfName] [amount]");
            SendClientMessage(playerid, -1, "NOTE: Abuse of this will result in being removed.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(level < 1)
            return SendErrorMessage(playerid, "You cannot give less than 1.");

        GiveMoney(targetid, level);
        new string[256];
        if(targetid != playerid) 
        {
            SendServerMessage(targetid, "You were given $%s by %s.", FormatNumber(level), GetMasterName(playerid));
        }
        format(string, sizeof string, "%s was given $%s by %s.", GetUserName(targetid), FormatNumber(level), GetMasterName(playerid));
        SendAdminCommand(string, 4);
        format(string, sizeof(string), "%s (IP: %s AccountID: %d) has given %s $%s.", GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(targetid), FormatNumber(level));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:takemoney(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, level;
        if(sscanf(params, "ud", targetid, level))
        {
            SendUsageMessage(playerid, "/takemoney [PlayerID/PartOfName] [amount]");
            SendClientMessage(playerid, -1, "NOTE: Abuse of this will result in being removed.");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(level < 1)
            return SendErrorMessage(playerid, "You cannot take less than 1.");

        TakeMoney(targetid, level);
        new string[256];
        if(targetid != playerid) 
        {
            SendServerMessage(targetid, "You have $%s taken from %s.", FormatNumber(level), GetMasterName(targetid));
        }
        format(string, sizeof string, "%s had $%s taken by %s.", GetUserName(targetid), FormatNumber(level), GetMasterName(playerid));
        SendAdminCommand(string, 4);
        format(string, sizeof(string), "%s (IP: %s AccountID: %d) has taken $%s from %s.", GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID], FormatNumber(level), GetUserName(targetid));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:actionlog(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/actionlog [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        new string[128];
        format(string, sizeof string, "Action Log (%s)", GetUserName(targetid));
        TempVar[playerid][LookupID] = targetid;
        Dialog_Show(playerid, Dialog_ActionLog_Main, DIALOG_STYLE_LIST, string, "Recent Commands\nIC Messages\nOOC Messages\nPrivate messages", "View", "Close");
    }
    return 1;
}

#define MAX_RECENT_CMD 100
Dialog:Dialog_ActionLog_Main(playerid, response, listitem, inputtext[])
{
	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128], caption[128];
        format(caption, sizeof caption, "Action Log (%s)", GetUserName(TempVar[playerid][LookupID]));
		switch(listitem)
        {
            case 0:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT `ID`, `Command` FROM cmd_log WHERE AccountID = %d ORDER BY `ID` DESC LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
                mysql_tquery(g_SQL, string, "OnGetRecentCMD", "d", playerid);
            }
            case 1:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ic_log WHERE AccountID = %d ORDER BY `ID` DESC LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
                mysql_tquery(g_SQL, string, "OnGetRecentIC", "d", playerid);
            }
            case 2:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ooc_log WHERE AccountID = %d ORDER BY `ID` DESC LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
                mysql_tquery(g_SQL, string, "OnGetRecentOOC", "d", playerid);
            }
            case 3:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM pm_log WHERE AccountID = %d ORDER BY `ID` DESC LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
                mysql_tquery(g_SQL, string, "OnGetRecentPM", "d", playerid);
            }
        }
	}
	return 1;
}

new RecentCMDList[MAX_PLAYERS][MAX_RECENT_CMD];

stock OPC_ResetRecentCMD(playerid)
{
    for(new i; i < MAX_RECENT_CMD; i++)
    {
        RecentCMDList[playerid][i] = 0;
    }
}

// PM Chat Get
function OnGetRecentPM(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128*(MAX_RECENT_CMD+1)];
    if(rows > 0)
    {
        format(string, sizeof(string), "Date & Time\t\tReciever\t\tMessage\n");
        for(new i; i < rows; i++)
        {
            new message[144], Reciever[MAX_PLAYER_NAME], timestamp;
            cache_get_value_int(i, "ID", RecentCMDList[playerid][i]);
            cache_get_value(i, "Reciever", Reciever, sizeof(Reciever));
            cache_get_value(i, "Message", message, sizeof(message));
            cache_get_value_int(i, "Timestamp", timestamp);
            if(strlen(message) > 70)
            {
                format(string, sizeof(string), "%s%s\t\t%s\t\t%.70s...\n", string, date(timestamp,0), Reciever, message);
            }
            else
            {
                format(string, sizeof(string), "%s%s\t\t%s\t\t%s\n", string, date(timestamp,0), Reciever, message);
            }
        }
        Dialog_Show(playerid, Dialog_RecentPMList, DIALOG_STYLE_TABLIST_HEADERS, "Recent PM Chat", string, "Select", "Close");
    }
    else 
    {
        format(string, sizeof string, "No recent commands on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
        Dialog_Show(playerid, Dialog_RecentPMList, DIALOG_STYLE_MSGBOX, "Recent Commands", string, "Select", "Close");
    }
    return 1;
}

Dialog:Dialog_RecentPMList(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "SELECT * FROM pm_log WHERE ID = %d LIMIT 1", RecentCMDList[playerid][listitem]);
        mysql_tquery(g_SQL, string, "OnReturnRecentPM", "d", playerid);
	}
	return 1;
}

function OnReturnRecentPM(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128];
    if(rows > 0)
    {
        new Command[64], params[128], recieve[MAX_PLAYER_NAME], Timestamp;
        cache_get_value(0, "UserName", Command, sizeof(Command));
        cache_get_value(0, "Message", params, sizeof(params));
        cache_get_value(0, "Reciever", recieve, sizeof(recieve));
        cache_get_value_int(0, "Timestamp", Timestamp);
        format(string, sizeof(string), "[%s]\n%s to %s\n%s\n", date(Timestamp), Command, recieve, params);
        Dialog_Show(playerid, Dialog_IC_Show, DIALOG_STYLE_MSGBOX, "PM Chat", string, "Back", "");
        return 1;
    }
    SendErrorMessage(playerid, "Something went wrong during OnReturnRecentPM(%d)", playerid);
    return 1;
}

Dialog:Dialog_PM_Show(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "SELECT * FROM PM_log WHERE AccountID = %d LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
        mysql_tquery(g_SQL, string, "OnGetRecentPM", "d", playerid);
	}
	return 1;
}

// OOC Chat Get
function OnGetRecentOOC(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128*MAX_RECENT_CMD];
    if(rows > 0)
    {
        format(string, sizeof(string), "Date & Time\t\tMessage\n");
        for(new i; i < rows; i++)
        {
            new Command[144], timestamp;
            cache_get_value_int(i, "ID", RecentCMDList[playerid][i]);
            cache_get_value_int(i, "Timestamp", timestamp);
            cache_get_value(i, "Message", Command, sizeof(Command));
            if(strlen(Command) > 70)
            {
                format(string, sizeof(string), "%s%s\t\t%.70s...\n", string, date(timestamp, 0), Command);
            }
            else
            {
                format(string, sizeof(string), "%s%s\t\t%s\n", string, date(timestamp, 0), Command);
            }
        }
        Dialog_Show(playerid, Dialog_RecentOOCList, DIALOG_STYLE_TABLIST_HEADERS, "Recent OOC Chat", string, "Select", "Close");
    }
    else 
    {
        format(string, sizeof string, "No recent commands on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
        Dialog_Show(playerid, Dialog_RecentOOCList, DIALOG_STYLE_MSGBOX, "Recent Commands", string, "Select", "Close");
    }
    return 1;
}

Dialog:Dialog_RecentOOCList(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        if(listitem < MAX_RECENT_CMD)
        {
            new string[128];
            mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ooc_log WHERE ID = %d LIMIT 1", RecentCMDList[playerid][listitem]);
            mysql_tquery(g_SQL, string, "OnReturnRecentOOC", "d", playerid);
        }
	}
	return 1;
}

function OnReturnRecentOOC(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128];
    if(rows > 0)
    {
        new Command[64], params[128], Timestamp;
        cache_get_value(0, "UserName", Command, sizeof(Command));
        cache_get_value(0, "Message", params, sizeof(params));
        cache_get_value_int(0, "Timestamp", Timestamp);
        format(string, sizeof(string), "[%s]\n%s: %s\n", date(Timestamp), Command, params);
        Dialog_Show(playerid, Dialog_IC_Show, DIALOG_STYLE_MSGBOX, "OOC Chat", string, "Back", "");
        return 1;
    }
    SendErrorMessage(playerid, "Something went wrong during OnReturnRecentOOC(%d)", playerid);
    return 1;
}

Dialog:Dialog_OOC_Show(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ooc_log WHERE AccountID = %d LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
        mysql_tquery(g_SQL, string, "OnGetRecentOOC", "d", playerid);
	}
	return 1;
}

// IC Chat Get
function OnGetRecentIC(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128*MAX_RECENT_CMD];
    if(rows > 0)
    {
        format(string, sizeof(string), "Date & Time\t\tMessage\n");
        for(new i; i < rows; i++)
        {
            new Command[144], timestamp;
            cache_get_value_int(i, "ID", RecentCMDList[playerid][i]);
            cache_get_value_int(i, "Timestamp", timestamp);
            cache_get_value(i, "Message", Command, sizeof(Command));
            if(strlen(Command) > 70)
            {
                format(string, sizeof(string), "%s%s\t\t%.70s...\n", string, date(timestamp, 0), Command);
            }
            else
            {
                format(string, sizeof(string), "%s%s\t\t%s\n", string, date(timestamp, 0), Command);
            }
        }
        Dialog_Show(playerid, Dialog_RecentICList, DIALOG_STYLE_TABLIST_HEADERS, "Recent IC Chat", string, "Select", "Close");
    }
    else 
    {
        format(string, sizeof string, "No recent commands on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
        Dialog_Show(playerid, Dialog_RecentICList, DIALOG_STYLE_MSGBOX, "Recent Commands", string, "Select", "Close");
    }
    return 1;
}

Dialog:Dialog_RecentICList(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        if(listitem < MAX_RECENT_CMD)
        {
            new string[128];
            mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ic_log WHERE ID = %d LIMIT 1", RecentCMDList[playerid][listitem]);
            mysql_tquery(g_SQL, string, "OnReturnRecentIC", "d", playerid);
        }
	}
	return 1;
}

function OnReturnRecentIC(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128];
    if(rows > 0)
    {
        new Command[64], params[256], Timestamp;
        cache_get_value(0, "UserName", Command, sizeof(Command));
        cache_get_value(0, "Message", params, sizeof(params));
        cache_get_value_int(0, "Timestamp", Timestamp);
        format(string, sizeof(string), "[%s]\n%s: %s\n", date(Timestamp), Command, params);
        Dialog_Show(playerid, Dialog_IC_Show, DIALOG_STYLE_MSGBOX, "IC Chat", string, "Back", "");
        return 1;
    }
    SendErrorMessage(playerid, "Something went wrong during OnReturnRecentIC(%d)", playerid);
    return 1;
}

Dialog:Dialog_IC_Show(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ic_log WHERE AccountID = %d LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
        mysql_tquery(g_SQL, string, "OnGetRecentIC", "d", playerid);
	}
	return 1;
}

function OnGetRecentCMD(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128*MAX_RECENT_CMD];
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            new Command[64];
            cache_get_value_int(i, "ID", RecentCMDList[playerid][i]);
            cache_get_value(i, "Command", Command, sizeof(Command));
            format(string, sizeof(string), "%s/%s\n", string, Command);
        }
        Dialog_Show(playerid, Dialog_RecentCmdList, DIALOG_STYLE_LIST, "Recent Commands", string, "Select", "Close");
    }
    else 
    {
        format(string, sizeof string, "No recent commands on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
        Dialog_Show(playerid, Dialog_RecentCmdList, DIALOG_STYLE_MSGBOX, "Recent Commands", string, "Select", "Close");
    }
    return 1;
}

Dialog:Dialog_RecentCmdList(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        if(listitem < MAX_RECENT_CMD)
        {
            new string[128];
            mysql_format(g_SQL, string, sizeof string, "SELECT * FROM cmd_log WHERE ID = %d LIMIT 1", RecentCMDList[playerid][listitem]);
            mysql_tquery(g_SQL, string, "OnReturnRecentCommand", "d", playerid);
        }
	}
	return 1;
}

function OnReturnRecentCommand(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows(), string[128];
    if(rows > 0)
    {
        new Command[64], params[128], Timestamp;
        cache_get_value(0, "Command", Command, sizeof(Command));
        cache_get_value(0, "Params", params, sizeof(params));
        cache_get_value_int(0, "Timestamp", Timestamp);
        format(string, sizeof(string), "[%s]\n/%s %s\n", date(Timestamp), Command, params);
        Dialog_Show(playerid, Dialog_CMD_Show, DIALOG_STYLE_MSGBOX, "Command", string, "Back", "");
        return 1;
    }
    SendErrorMessage(playerid, "Something went wrong during OnReturnRecentCommand(%d)", playerid);
    return 1;
}

Dialog:Dialog_CMD_Show(playerid, response, listitem, inputtext[])
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "SELECT `ID`, `Command` FROM cmd_log WHERE AccountID = %d LIMIT %d", Player[TempVar[playerid][LookupID]][ID], MAX_RECENT_CMD);
        mysql_tquery(g_SQL, string, "OnGetRecentCMD", "d", playerid);
	}
	return 1;
}

CMD:arecord(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/arecord [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        new string[128];
        format(string, sizeof string, "Admin Record (%s)", GetUserName(targetid));
        TempVar[playerid][LookupID] = targetid;
        Dialog_Show(playerid, Dialog_AdminRecord_Main, DIALOG_STYLE_LIST, string, "Kicks\nAdmin Jails\nBans", "View", "Close");
    }
    return 1;
}

Dialog:Dialog_AdminRecord_Main(playerid, response, listitem, inputtext[])
{
	if (response && Player[playerid][AdminLevel] >= 1)
	{
        new string[128], caption[128];
        format(caption, sizeof caption, "Admin Record (%s)", GetUserName(TempVar[playerid][LookupID]));
		switch(listitem)
        {
            case 0:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM kick_logs WHERE KickedDBID = %d", Player[TempVar[playerid][LookupID]][ID]);
                mysql_tquery(g_SQL, string, "OnGetKicks", "d", playerid);
            }
            case 1:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ajail_logs WHERE JailedDBID = %d", Player[TempVar[playerid][LookupID]][ID]);
                mysql_tquery(g_SQL, string, "OnGetJails", "d", playerid);
            }
            case 2:
            {
                mysql_format(g_SQL, string, sizeof string, "SELECT * FROM ban_logs WHERE BannedDBID = %d", Player[TempVar[playerid][LookupID]][ID]);
                mysql_tquery(g_SQL, string, "OnGetBans", "d", playerid);
            }
        }
	}
	return 1;
}

function OnGetKicks(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows();
    new string[128*20];
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            new KickedName[32], DateTime[128], Admin[32], Reason[128];
            cache_get_value(i, "KickedBy", Admin, 32);
            cache_get_value(i, "KickedName", KickedName, 32);
            cache_get_value(i, "Reason", Reason, 128);
            cache_get_value(i, "Date", DateTime, 128);
            
            format(string, sizeof string, "%s[%s] %s was kicked by %s, Reason: %s\n", string, DateTime, KickedName, Admin, Reason);
        }
    }
    else format(string, sizeof string, "No kicks on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
    Dialog_Show(playerid, Dialog_AdminRecord_Kicks, DIALOG_STYLE_MSGBOX, "Admin Record - Kicks", string, "Close", "");
    return 1;
}

function OnGetJails(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows();
    new string[128*20];
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            new KickedName[32], DateTime[128], Admin[32], Reason[128];
            cache_get_value(i, "JailedBy", Admin, 32);
            cache_get_value(i, "JailedName", KickedName, 32);
            cache_get_value(i, "Reason", Reason, 128);
            cache_get_value(i, "Date", DateTime, 128);
            
            format(string, sizeof string, "%s[%s] %s was admin jailed by %s, Reason: %s\n", string, DateTime, KickedName, Admin, Reason);
        }
    }
    else format(string, sizeof string, "No admin jails on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
    Dialog_Show(playerid, Dialog_AdminRecord_Kicks, DIALOG_STYLE_MSGBOX, "Admin Record - Admin Jails", string, "Close", "");
    return 1;
}

function OnGetBans(playerid)
{
    if(!IsPlayerConnected(TempVar[playerid][LookupID]))
        return SendErrorMessage(playerid, "Player logged off");

    new rows = cache_num_rows();
    new string[128*20];
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            new KickedName[32], DateTime[128], Admin[32], Reason[128];
            cache_get_value(i, "BannedBy", Admin, 32);
            cache_get_value(i, "BannedName", KickedName, 32);
            cache_get_value(i, "Reason", Reason, 128);
            cache_get_value(i, "Date", DateTime, 128);
            
            format(string, sizeof string, "%s[%s] %s was banned by %s, Reason: %s\n", string, DateTime, KickedName, Admin, Reason);
        }
    }
    else format(string, sizeof string, "No previous bans on record for %s.\n", GetUserName(TempVar[playerid][LookupID]));
    Dialog_Show(playerid, Dialog_AdminRecord_Kicks, DIALOG_STYLE_MSGBOX, "Admin Record - Bans", string, "Close", "");
    return 1;
}

CMD:kills(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/kills [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        new query[128];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM kills WHERE CharacterID = %d LIMIT 20", PlayerInfo[targetid][pCharacterID]);
        mysql_tquery(g_SQL, query, "OnGetKills", "dd", playerid, targetid);
    }
    return 1;
}

function OnGetKills(playerid, targetid)
{
    new rows = cache_num_rows();

    if(rows > 0)
    {
        new string[129*21], str[128], killerID, timeStamp, dbID;
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", killerID);
            cache_get_value_int(i, "KillerID", killerID);
            cache_get_value_int(i, "Timestamp", timeStamp);
            format(str, sizeof(str), "[#%d] Killed by %s (%s)\n", dbID, GetDatabaseName(killerID), date(timeStamp));
            strcat(string, str);
        }
        new caption[128];
        format(caption, sizeof caption, "Last 20 Kills (%s)", GetUserName(targetid));
        strcat(string, "Click Close to exit.");
        Dialog_Show(playerid, Dialog_Kills, DIALOG_STYLE_MSGBOX, caption, string, "Close", "");
    }
    else SendErrorMessage(playerid, "This player does not appear to have been killed before.");
    return 1;
}

CMD:attacks(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
        {
            SendUsageMessage(playerid, "/attacks [PlayerID/PartOfName]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        new query[128];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM attack_logs WHERE CharacterID = %d ORDER BY `ID` DESC LIMIT 20", PlayerInfo[targetid][pCharacterID]);
        mysql_tquery(g_SQL, query, "OnGetAttacks", "dd", playerid, targetid);
    }
    return 1;
}

function OnGetAttacks(playerid, targetid)
{
    new rows = cache_num_rows();

    if(rows > 0)
    {
        new string[129*20], str[128], timeStamp, attackerID, attackerName[32], maskID;
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "Date", timeStamp);
            cache_get_value_int(i, "AttackerID", attackerID);
            cache_get_value(i, "AttackerName", attackerName, sizeof attackerName);
            cache_get_value_int(i, "MaskID", maskID);
            format(str, sizeof(str), "[%s] Attacker: %s [DBID: #%d] MaskID: [Mask_%d]\n", date(timeStamp), attackerName, attackerID, maskID);
            strcat(string, str);
        }
        new caption[128];
        format(caption, sizeof caption, "Last 20 Attacks (%s)", GetUserName(targetid));
        Dialog_Show(playerid, Dialog_Kills, DIALOG_STYLE_MSGBOX, caption, string, "Close", "");
    }
    else SendErrorMessage(playerid, "This player does not appear to have been killed before.");
    return 1;
}

stock DisplayNotes(playerid, targetid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `admin_notes` WHERE `AccountID` = %d ORDER BY `Timestamp` LIMIT 15", Player[targetid][ID]);
	mysql_tquery(g_SQL, query, "OnDisplayNotes", "ii", playerid, targetid);
	return 1;
}

function OnDisplayNotes(playerid, targetid)
{
	new rows = cache_num_rows();
	new resultline[2000], 
		header[128], 
		iNoteID,
		iTimestamp,
		szAdmin[MAX_PLAYER_NAME + 1],
		szMessage[128 + 1];
	format(header, sizeof(header), "{FF6347}Admin Notes for{BFC0C2} %s", GetMasterName(targetid));
	if(rows > 0)
	{
        format(resultline, sizeof(resultline),"ID\t\tNote\n");
		for(new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", iNoteID);
		    cache_get_value_name_int(i, "Timestamp", iTimestamp);
		    cache_get_value_name(i, "Admin", szAdmin);
		    cache_get_value_name(i, "Message", szMessage);
			format(resultline, sizeof(resultline),"%s{FF6347}%d\t\t%s\n",resultline, iNoteID, szMessage);
		}
	    Dialog_Show(playerid, NoteList, DIALOG_STYLE_MSGBOX, header, resultline, "Delete", "Close");
	}
	if(rows == 0)
	{
		format(resultline, sizeof(resultline),"{FF6347}No notes on this account");
        Dialog_Show(playerid, NoteList, DIALOG_STYLE_MSGBOX, header, resultline, "Delete", "Close");
	}
	cache_unset_active();
	return 1;
}

Dialog:NoteList(playerid, response, listitem, inputtext[])
{
	if (response && Player[playerid][AdminLevel] >= 4)
	{
		Dialog_Show(playerid, NoteDelete, DIALOG_STYLE_INPUT, "Delete Note", "Which note would you like to delete?\nThis refers to the ID as seen in previous dialog.", "Delete Flag", "Close");
	}
	return 1;
}

Dialog:NoteDelete(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		if(isnull(inputtext) || !IsNumeric(inputtext))
		{
			Dialog_Show(playerid, NoteDelete, DIALOG_STYLE_INPUT, "Delete Note", "Which note would you like to delete?\nThis refers to the ID as seen in previous dialog.", "Delete Flag", "Close");
			return 1;	
		}

		new string[128], iNote = strval(inputtext);
		SetPVarInt(playerid, "NoteDeleteID", iNote);
		format(string, sizeof(string), "Are you sure you want to delete this note?\nYou are about to delete note ID %d from the database.", iNote);
		Dialog_Show(playerid, NoteDeleteConfirm, DIALOG_STYLE_MSGBOX, "Delete Note: Confirmation", string, "Confirm", "Back");
	}
	return 1;
}

Dialog:NoteDeleteConfirm(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new iNote = GetPVarInt(playerid, "NoteDeleteID"), query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `admin_notes` WHERE `ID` = %d", iNote);
		mysql_tquery(g_SQL, query, "OnDeleteNote", "ii", playerid, iNote);
	}
	return 1;
}

function OnDeleteNote(playerid, noteid)
{
	new string[128];
	format(string, sizeof(string), "%s %s has removed NoteID #%d.", GetAdminRank(playerid), GetMasterName(playerid), noteid);
	SendAdminCommand(string, 1);
	return 1;
}

CMD:viewnotes(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 1)
	{
		new giveplayerid;
	    if(sscanf(params, "u", giveplayerid)) return SendUsageMessage(playerid, "/viewnotes [PlayerID/PartOfName]");
	    if(IsPlayerConnected(giveplayerid))
	    {
			DisplayNotes(playerid, giveplayerid);
		}
	}
	else
	{
		SendErrorMessage(playerid, "You are not authorized to use that command.");
	}
	return 1;
}

CMD:oaddnote(playerid, params[])
{
	if (Player[playerid][AdminLevel] >= 1)
	{
		new query[256], giveplayerid, name[MAX_PLAYER_NAME], reason[64];
		if(sscanf(params, "s[24]s[64]", name, reason)) return SendUsageMessage(playerid, "/oaddnote [AccountName] [Reason]");

		giveplayerid = ReturnUser(name);
		if(IsPlayerConnected(giveplayerid))
		{
			SendClientMessage(playerid, COLOR_WHITE, "The person is online, adding note...");
			AddAdminNote(giveplayerid, playerid, reason);
		}
		else
		{
			SendClientMessage(playerid, COLOR_WHITE, "Adding note...");
			SetPVarString(playerid, "OnAddFlag", name);
			SetPVarString(playerid, "OnAddFlagReason", reason);

			mysql_format(g_SQL, query, sizeof(query), "SELECT `id` FROM `users` WHERE `name`='%e' LIMIT 1", name);
			mysql_tquery(g_SQL, query, "OnAdminNoteFindAccount", "i", playerid);
		}
	}
	else SendErrorMessage(playerid, "Invalid player specified.");
	return 1;
}

function OnAdminNoteFindAccount(playerid)
{
	if(cache_num_rows() > 0)
	{
		new sqlID, note[129], query[256];
		cache_get_value_name_int(0, "id", sqlID);

    	GetPVarString(playerid, "OnAddFlagReason", note, sizeof(note));

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `admin_notes` (`AccountID`, `Timestamp` ,`Admin` ,`Message`) VALUES (%d,%d,'%e','%e')", sqlID, gettime(), GetMasterName(playerid), note);
		mysql_tquery(g_SQL, query, "OnAddOfflineAdminNote", "i", playerid);
	}
	else SendErrorMessage(playerid, "No such account found!");
	return 1;
}

CMD:addnote(playerid, params[])
{
	if (Player[playerid][AdminLevel] >= 1)
	{
		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendUsageMessage(playerid, "/addnote [PlayerID/PartOfName]");

		if(IsPlayerConnected(giveplayerid))
		{
            TempVar[playerid][AddNoteID] = giveplayerid;
            Dialog_Show(playerid, AdminNote_Reason, DIALOG_STYLE_INPUT, "Administrative Note", "Write down the note you wish to keep on record.\n\
            Administrative Notes can only be seen by server administrators.", "Continue", "Close");
			//AddAdminNote(giveplayerid, playerid, reason);
			return 1;
		}
	}
	else SendErrorMessage(playerid, "Invalid player specified.");
	return 1;
}

Dialog:AdminNote_Reason(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        AddAdminNote(TempVar[playerid][AddNoteID], playerid, inputtext);
    }
    return 1;
}

function OnAddOfflineAdminNote(playerid)
{
	new string[144], userName[MAX_PLAYER_NAME + 1], pNote[129];

	GetPVarString(playerid, "OnAddFlag", userName, sizeof(userName));
	GetPVarString(playerid, "OnAddFlagReason", pNote, sizeof(pNote));
	format(string, sizeof(string), "%s %s has added an admin note to %s.", GetAdminRank(playerid), GetMasterName(playerid), userName);
	SendAdminCommand(string, 1);
	format(string, sizeof(string), "%s", pNote);
	SendAdminCommand(string, 1);
	return 1;
}

stock AddAdminNote(playerid, adminid, note[])
{
	new query[300];
	format(TempVar[adminid][TempNote], 128, "%s", note);
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `admin_notes` (`AccountID` ,`Timestamp` ,`Admin` ,`Message`) VALUES (%d,%d,'%e','%e')", Player[playerid][ID], gettime(), GetMasterName(adminid), note);
	mysql_tquery(g_SQL, query, "OnAddAdminNote", "iis", playerid, adminid, note);
}

function OnAddAdminNote(playerid, adminid, note[])
{
	new string[144];
	format(string, sizeof(string), "%s %s has added an admin note to %s.", GetAdminRank(adminid), GetMasterName(adminid), GetMasterName(playerid));
	SendAdminCommand(string, 1);
	format(string, sizeof(string), "%s", note);
	SendAdminCommand(string, 1);
	return 1;
}

CMD:setweather(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new weatherid;
        if(sscanf(params, "i", weatherid))
            return SendUsageMessage(playerid, "/setweather [weatherid]");

        ServerInfo[GlobalWeather] = weatherid;
        foreach(new i: Player)
        {
            if(!GetPlayerInterior(i))
            {
                SetPlayerWeather(i, weatherid);        
            }
        }
        SendClientMessageEx(playerid, COLOR_WHITE, "Weather changed to %i.", weatherid);
    }
	return 1;
}

CMD:setmotd(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/setmotd [Message of the day]");

        new string[128], query[256];
        format(ServerInfo[PlayerMOTD], 128, "%s", params);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `PlayerMOTD` = '%e'", params);
        mysql_tquery(g_SQL, query);

        format(string, sizeof(string), "%s %s has set the player MOTD to: %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        SendAdminCommand(string, 4);
    }
    return 1;
}

CMD:adminmotd(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/adminmotd [Message of the day]");

        new string[128], query[256];
        format(ServerInfo[AdminMOTD], 128, "%s", params);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `AdminMOTD` = '%e'", params);
        mysql_tquery(g_SQL, query);

        format(string, sizeof(string), "%s %s has set the admin MOTD to: %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        SendAdminCommand(string, 4);
    }
    return 1;
}

CMD:ahide(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new string[128];
        if(TempVar[playerid][AdminHide] == true)
        {
            TempVar[playerid][AdminHide] = false;
            format(string, sizeof(string), "%s %s (%s) is no longer hidden from /admins.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
            SendAdminCommand(string, 1);
            return 1;
        }
        TempVar[playerid][AdminHide] = true;
        format(string, sizeof(string), "%s %s (%s) is now hidden from /admins.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
        SendAdminCommand(string, 1);
    }
    return 1;
}

CMD:helpermotd(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/helpermotd [Message of the day]");

        new string[128], query[256];
        format(ServerInfo[HelperMOTD], 128, "%s", params);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `HelperMOTD` = '%e'", params);
        mysql_tquery(g_SQL, query);

        format(string, sizeof(string), "%s %s has set the helper MOTD to: %s", GetAdminRank(playerid), GetMasterName(playerid), params);
        SendAdminCommand(string, 4);
    }
    return 1;
}

CMD:reset(playerid, params[])
{
	if(IsAdminLevel(playerid, 1))
    {
	    new targetid, string[128];
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/reset [playerid]");

        if(!IsPlayerConnected(targetid) || Player[playerid][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "The player specified is not online or not logged in.");

        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(targetid, X, Y, Z);
        SetPlayerPos(targetid, X, Y, Z);
        
        SetPlayerInterior(targetid, GetPlayerInterior(targetid));
        SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(targetid));
        SetPlayerSkin(targetid, GetPlayerSkin(targetid));

        TempVar[targetid][Muted] = false;

        TogglePlayerSpectating(targetid, false);
        TogglePlayerControllable(targetid, true);
        
        format(string, sizeof string, "%s's was reset by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 1);
        PrintFooter(targetid, "~w~RESET.");
    }
	return 1;
}

CMD:clearinv(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
    {
	    new targetid, string[128];
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/clearinv [playerid]");

        if(!IsPlayerConnected(targetid) || Player[playerid][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "The player specified is not online or not logged in.");

        for(new i; i < MAX_INVENTORY; i++)
        {
            RemoveInventory(targetid, i);
        }
        format(string, sizeof string, "%s's inventory was cleared by by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 2);
    }
	return 1;
}

CMD:disarm(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
    {
	    new targetid, string[128];
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/disarm [playerid]");

        if(!IsPlayerConnected(targetid) || Player[playerid][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "The player specified is not online or not logged in.");

        TakePlayerGuns(targetid);
        format(string, sizeof string, "%s was disarmed by %s %s.", GetUserName(targetid), GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 2);
    }
	return 1;
}

CMD:jetpack(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
	{
        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK)
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
            PrintFooter(playerid, "~g~Jetpack", 3);
            SendClientMessage(playerid, -1, "Make sure you despawn it by retyping this command!");
        }
        else
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPosEx(playerid, x, y, z+0.1);
            PrintFooter(playerid, "~g~Jetpack Removed", 3);
        }
    }
	return 1;
}

CMD:aexcusefine(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new fineid, query[128];
        if(sscanf(params, "d", fineid))
        {
            SendUsageMessage(playerid, "/aexcusefine [FineID] - See /fines [playerid]");
            return 1;
        }
        
        mysql_format(g_SQL, query, sizeof(query), "UPDATE `fines` SET `Active` = 0 WHERE `ID` = %d LIMIT 1", fineid);
        mysql_tquery(g_SQL, query, "OnAdminExcuseFine", "ii", playerid, fineid);
    }
    return 1;
}

function OnAdminExcuseFine(playerid, fineid)
{
    new string[128];
    format(string, sizeof string, "%s %s has excused fine #%s.", GetPlayerRank(playerid), GetUserName(playerid), FormatNumber(fineid));
    SendAdminCommand(string, 3);
    return 1;
}

CMD:payday(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pConnectedTime] < 900)
            {
                PlayerInfo[i][pConnectedTime] = 900;
            }
        }
        PayDay();
    }
    return 1;
}

CMD:soundtest(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new soundid;
        if(sscanf(params, "d", soundid))
        {
            SendUsageMessage(playerid, "/soundtest [soundid]");
            return 1;
        }

        PlayerPlaySound(playerid, soundid, 0, 0, 0);
    }
    return 1;
}

CMD:afix(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            RepairVehicle(GetPlayerVehicleID(playerid));
            SendClientMessage(playerid, -1, "Repaired Vehicle.");
        }
        else SendErrorMessage(playerid, "You need to be in a vehicle.");
    }
    return 1;
}

CMD:anos(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
            SendClientMessage(playerid, -1, "NOS added.");
        }
        else SendErrorMessage(playerid, "You need to be in a vehicle.");
    }
    return 1;
}

CMD:setstat(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, statid, amount;
        if(sscanf(params, "udd", targetid, statid, amount))
        {
            SendUsageMessage(playerid, "/setstat [PlayerID/PartOfName] [StatID] [Amount]");
            SendClientMessage(playerid, COLOR_GRAD5, "1. Level, 2. Skin, 3. Expierience, 4. Hours, 5. Money");
            SendClientMessage(playerid, COLOR_GRAD4, "6. Bank, 7. PayCheque, 8. PhoneNo, 9. PhoneCredits, 10. Radio");
            SendClientMessage(playerid, COLOR_GRAD3, "11. RadioSlot, 12. Fish, 13. FishBait, 14. DrivingLicense");
            SendClientMessage(playerid, COLOR_GRAD3, "15. FlyingLicense, 16. PrisonTimes, 17. JailTimes, 18. Job");
            SendClientMessage(playerid, COLOR_GRAD3, "19. Spawn, 20. Gender, 21. RadioChan, 22. WeedSeeds, 23. Weed");
            SendClientMessage(playerid, COLOR_GRAD3, "24. Heroin, 25. PoppySeeds, 26. Opium, 27. Origin");
            return 1;
        }

        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "Player is not connected.");

        new string[256];
        switch(statid)
        {
            case 1:
            {
                PlayerInfo[targetid][pLevel] = amount;
                SetPlayerScore(targetid, amount);
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Level` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) level set to %d", GetUserName(targetid), targetid, amount);
            }
            case 2:
            {
                PlayerInfo[targetid][pSkin] = amount;
                SetPlayerSkin(targetid, amount);
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Skin` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) skin set to %d", GetUserName(targetid), targetid, amount);
            }
            case 3:
            {
                PlayerInfo[targetid][pExpierience] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Expierience` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) expierience set to %d", GetUserName(targetid), targetid, amount);
            }
            case 4:
            {
                PlayerInfo[targetid][pHours] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Hours` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) hours set to %d", GetUserName(targetid), targetid, amount);
            }
            case 5:
            {
                PlayerInfo[targetid][pMoney] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                ResetPlayerMoney(playerid);
                GivePlayerMoney(playerid, amount);
                format(string, sizeof string, "%s(%d) money set to %d", GetUserName(targetid), targetid, amount);
            }
            case 6:
            {
                PlayerInfo[targetid][pBank] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Bank` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) bank set to %d", GetUserName(targetid), targetid, amount);
            }
            case 7:
            {
                PlayerInfo[targetid][pPayCheque] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PayCheque` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) PayCheque set to %d", GetUserName(targetid), targetid, amount);
            }
            case 8:
            {
                PlayerInfo[targetid][pPhoneNo] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PhoneNo` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) PhoneNo set to %d", GetUserName(targetid), targetid, amount);
            }
            case 9:
            {
                PlayerInfo[targetid][pPhoneType] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PhoneType` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) PhoneCredits set to %d", GetUserName(targetid), targetid, amount);
            }
            case 10:
            {
                if(amount >= 1)
                {
                    AddInventory(targetid, INV_RADIO, 1);
                }
                else
                {
                    for(new i; i < MAX_INVENTORY; i++)
                    {
                        if(InventoryInfo[i][playerid][InventoryID] > 0 && InventoryInfo[i][playerid][InventoryType] == INV_RADIO)
                        {
                            RemoveInventory(playerid, i);
                        }
                    }
                }
                format(string, sizeof string, "%s(%d) radio set to %d", GetUserName(targetid), targetid, amount);
            }
            case 11:
            {
                PlayerInfo[targetid][pRadioSlot] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `RadioSlot` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) RadioSlot set to %d", GetUserName(targetid), targetid, amount);
            }
            case 12:
            {
                PlayerInfo[targetid][pFish] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Fish` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Fish set to %d", GetUserName(targetid), targetid, amount);
            }
            case 13:
            {
                PlayerInfo[targetid][pFishBait] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `FishBait` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) FishBait set to %d", GetUserName(targetid), targetid, amount);
            }
            case 14:
            {
                //PlayerInfo[targetid][pDrivingLicense] = amount;
                if(amount >= 1)
                {
                    AddInventory(targetid, INV_DRV_LIC, 1);
                }
                else
                {
                    for(new i; i < MAX_INVENTORY; i++)
                    {
                        if(InventoryInfo[i][playerid][InventoryID] > 0 && InventoryInfo[i][playerid][InventoryType] == INV_DRV_LIC)
                        {
                            RemoveInventory(playerid, i);
                        }
                    }
                }
                format(string, sizeof string, "%s(%d) DrivingLicense set to %d", GetUserName(targetid), targetid, amount);
            }
            case 15:
            {
                PlayerInfo[targetid][pFlyingLicense] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `FlyingLicense` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) FlyingLicense set to %d", GetUserName(targetid), targetid, amount);
            }
            case 16:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pPrisonTimes] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PrisonTimes` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) PrisonTimes set to %d", GetUserName(targetid), targetid, amount);
            }
            case 17:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pJailTimes] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `JailTimes` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) JailTimes set to %d", GetUserName(targetid), targetid, amount);
            }
            case 18:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pJob] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Job` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Job set to %d", GetUserName(targetid), targetid, amount);
            }
            case 19:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pSpawn] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Spawn` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Spawn set to %d", GetUserName(targetid), targetid, amount);
            }
            case 20:
            {
                if(amount < 0 || amount > 1)
                    return SendErrorMessage(playerid, "Valid amount is from 0 to 1.");

                PlayerInfo[targetid][pGender] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Gender` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Gender set to %d", GetUserName(targetid), targetid, amount);
            }
            case 21:
            {
                if(amount < 1 || amount > 1000000)
		            return SendErrorMessage(playerid, "You specified an invalid channel. (1-1000000)"); 

                PlayerInfo[targetid][pRadioChan] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `RadioChan` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) RadioChan set to %d", GetUserName(targetid), targetid, PlayerInfo[targetid][pRadioSlot], amount);
            }
            case 22:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pWeedSeeds] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `WeedSeeds` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) WeedSeeds set to %d", GetUserName(targetid), targetid, amount);
            }
            case 23:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pWeed] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Weed` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Weed set to %d", GetUserName(targetid), targetid, amount);
            }
            case 24:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pHeroin] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Heroin` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Heroin set to %d", GetUserName(targetid), targetid, amount);
            }
            case 25:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pPoppySeeds] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PoppySeeds` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) PoppySeeds set to %d", GetUserName(targetid), targetid, amount);
            }
            case 26:
            {
                if(amount < 0)
                    return SendErrorMessage(playerid, "Valid amount is 0 or above.");

                PlayerInfo[targetid][pOpium] = amount;
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Opium` = %d WHERE `CharacterID` = %d LIMIT 1", amount, PlayerInfo[targetid][pCharacterID]);
                mysql_tquery(g_SQL, string);
                format(string, sizeof string, "%s(%d) Opium set to %d", GetUserName(targetid), targetid, amount);
            }
            case 27:
            {
                SetPVarInt(playerid, "SetStatID", targetid);
                Dialog_Show(playerid, SetStatOrigin, DIALOG_STYLE_INPUT, "Set Origin", "Set the origin.\n\nExample:\nFort Carson, Bone County.", "Continue", "Cancel");
            }
            default: format(string, sizeof string, "Invalid StatID", GetUserName(targetid), targetid, amount);
        }
        SendClientMessage(playerid, COLOR_GREY, string);
    }
    return 1;
}

Dialog:SetStatOrigin(playerid, response, listitem, inputtext[])
{
    new targetid = GetPVarInt(playerid, "SetStatID");
    if(isnull(inputtext))
        return Dialog_Show(playerid, SetStatOrigin, DIALOG_STYLE_INPUT, "Set Origin", "Set the origin.\n\nExample:\nFort Carson, Bone County.", "Continue", "Cancel");
    
    if(strlen(inputtext) > 128)
        return Dialog_Show(playerid, SetStatOrigin, DIALOG_STYLE_INPUT, "Set Origin", "Set the origin.\n\nExample:\nFort Carson, Bone County.", "Continue", "Cancel");
    
    if(IsPlayerConnected(targetid))
    {
        new string[256];
        format(PlayerInfo[targetid][pOrigin], 128, inputtext);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Origin` = '%e' WHERE `CharacterID` = %d LIMIT 1", inputtext, PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
    }
    DeletePVar(playerid, "SetStatID");
    return 1;
}

CMD:vehname(playerid, params[]) 
{
	if(IsAdminLevel(playerid, 2))
    {
		if(isnull(params)) return SendUsageMessage(playerid, "/vehname [Vehicle Name/Part of Name]");
		if(!params[2]) return SendErrorMessage(playerid, "Search keyword too short.");

		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Search:");
		new string[1024];
		for(new v; v < sizeof(g_arrVehicleNames); v++) 
        {
			if(strfind(g_arrVehicleNames[v], params, true) != -1) 
            {
				if(isnull(string)) format(string, sizeof(string), "%s (ID %d)", g_arrVehicleNames[v], v+400);
				else format(string, sizeof(string), "%s | %s (ID %d)", string, g_arrVehicleNames[v], v+400);
			}
		}

		if(!string[0]) SendErrorMessage(playerid, "No results found.");
		else if(string[127]) SendErrorMessage(playerid, "Too many results found.");
		else SendClientMessageEx(playerid, COLOR_WHITE, string);

	}
	return 1;
}

CMD:mstats(playerid, params[]) 
{
	if(IsAdminLevel(playerid, 3))
    {
	    new stats[256];
		mysql_stat(stats, sizeof(stats), g_SQL);
		SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
		SendClientMessageEx(playerid, COLOR_GREY, stats);
		SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
	}
	return 1;
}

CMD:tod(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new h, string[128];
        if(sscanf(params, "d", h))
            return SendUsageMessage(playerid, "/tod [Hour]");

        if(h < 0 || h > 23) return SendErrorMessage(playerid, "Cannot go under 0 or above 23.");

        new time[3];
        gettime(time[0], time[1], time[2]);
        ServerInfo[CurrentHour] = h;
        ServerInfo[CurrentMinute] = time[1];
        ServerInfo[CurrentSecond] = time[2];
        SetWorldTime(ServerInfo[CurrentHour]);

        format(string, sizeof string, "%s %s has set the time to %d:%d:%d.", GetAdminRank(playerid), GetMasterName(playerid), h, time[1], time[2]);
        SendAdminCommand(string);
        UpdateTime();
    }
    return 1;
}

CMD:seedriver(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new vehicleid;
        
        if(sscanf(params, "d", vehicleid))
        {
            SendUsageMessage(playerid, "/seedriver [VehicleID] - Use /dl for the VehicleID.");
            return 1;
        }

        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "You specified an invalid vehicle.");

            
        foreach(new i: Player)
        {
            if(GetPlayerVehicleSeat(i) == 0 && GetPlayerVehicleID(i) == vehicleid)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "%s driver: %s (ID: %d)", ReturnVehicleName(vehicleid), GetUserName(i), i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "This vehicle has no driver.");
    }
    return 1;
}

CMD:olistadmins(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        mysql_tquery(g_SQL, "SELECT * FROM `players` WHERE `AdminLevel` >= 1", "OnListAdmins", "d", playerid);
    }
    return 1;
}

function OnListAdmins(playerid)
{
    new rows = cache_num_rows();
    if(rows)
    {
        new username[MAX_PLAYER_NAME+1], admin_level;
        SendClientMessage(playerid, -1, "Listing all online and offline server administrators...");
        for(new i; i < rows; i++)
        {
            cache_get_value(i, "username", username, sizeof username);
            cache_get_value_int(i, "AdminLevel", admin_level);

            SendClientMessageEx(playerid, COLOR_GREY, "* %s %s.", GetAdminRank(admin_level), username);
        }
    }
    return 1;
}

/*Dialog:CK_Confirm(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(TempVar[playerid][Relogging])
            return SendClientMessage(playerid, COLOR_LIGHTRED, "This player already in the middle of relogging.");
                
        new
            Float:x,
            Float:y,
            Float:z
        ;
        
        SendClientMessageEx(playerid, COLOR_LIGHTRED, "Your character has been disabled, you have been automatically logged out.");
        PlayerInfo[playerid][pDisabled] = 1;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerTeam(playerid, PLAYER_ALIVE);
        
        TempVar[playerid][Relogging] = true;
        
        TempVar[playerid][RelogID] = Create3DTextLabel("(( CK IN PROGRESS ))", COLOR_WHITE, x, y, z, 20.0, GetPlayerVirtualWorld(playerid), 1);
        Attach3DTextLabelToPlayer(TempVar[playerid][RelogID], playerid, 0.0, 0.0, 0.1);
        TogglePlayerControllable(playerid, 0);
        
        TempVar[targetid][RelogTimer] = SetTimerEx("OnPlayerForceRelog", 1000, true, "i", playerid, GetPVarInt(playerid, "CKAdmin")); 
    }
    return 1;
}

CMD:ck(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/ck [PlayerID/PartOfName]");
        
        if(IsPlayerConnected(targetid))
        {
            if(Player[targetid][AdminLevel] >= 1 && targetid != playerid)
            {
                if(Player[playerid][AdminLevel] < 5)
                {
                    SendErrorMessage(playerid, "You are not allowed to do this.");
                    return 1;
                }
            }

            SetPVarInt(targetid, "CKAdmin", playerid);
            Dialog_Show(targetid, CK_Confirm, DIALOG_STYLE_MSGBOX, "CK Confirmation", "An administrator has asked if you want to CK your character\n\
            Do you confirm this?\n\n\
            {FF0000}WARNING:{FFFFFF} This action is irreversible and cannot be undone. Only Server Management can undo this action.", "Confirm", "Cancel");
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have sent %s a CK confirmation", GetUserName(targetid));
        }
        return 1;
    }
    return 1;
}*/

function OnPlayerForceRelog(playerid, adminid)
{	
	Delete3DTextLabel(TempVar[playerid][RelogID]);
	KillTimer(TempVar[playerid][RelogTimer]); 
	
	TempVar[playerid][Relogging] = false;
	
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0); 
	
	Player[playerid][IsLoggedIn] = false;
	PlayerInfo[playerid][pCharacterID] = 0;
	
	SetPlayerName(playerid, Player[playerid][Name]);
	
	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "* %s (%s) was forcefully logged out by an administrator.", GetUserName(playerid), GetMasterName(playerid));
	TogglePlayerSpectating(playerid, true);
	SetPlayerLoginCamera(playerid);
	TextDrawHideForPlayer(playerid, ServerCurrentTime);

	new string[128];
	mysql_format(g_SQL, string, sizeof string, "UPDATE `players` SET `IsLoggedIn` = 0 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
    mysql_tquery(g_SQL, string);
	format(string, sizeof(string), "%s (IP: %s ID: %d) was relogged by %s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetMasterName(adminid));
	DBLog("Relog", string);
	return 1;
}

CMD:asetparamcar(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new vehicleid, param[32];
        if(sscanf(params, "ds[32]", vehicleid, param))
        {
            SendUsageMessage(playerid, "/asetparamcar [VehicleID (/dl)] [Paramater]");
            SendClientMessage(playerid, -1, "Paramaters: Engine, Lights, Alarm, Lock, Hood, Trunk, Arrow.");
            return 1;
        }
        
        new engine, lights, alarm, doors, bonnet, boot, objective;
        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
        if(strcmp(param, "engine", true) == 0)
        {
            if(engine == VEHICLE_PARAMS_ON)
            {
                engine = VEHICLE_PARAMS_OFF;
            }
            else
            {
                engine = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleEngine(vehicleid, engine);
            SendClientMessage(playerid, -1, "Engine toggled.");
        }
        else if(strcmp(param, "lights", true) == 0)
        {
            if(lights == VEHICLE_PARAMS_ON)
            {
                lights = VEHICLE_PARAMS_OFF;
            }
            else
            {
                lights = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleLights(vehicleid, lights);
            SendClientMessage(playerid, -1, "Lights toggled.");
        }
        else if(strcmp(param, "alarm", true) == 0)
        {
            if(alarm == VEHICLE_PARAMS_ON)
            {
                alarm = VEHICLE_PARAMS_OFF;
            }
            else
            {
                alarm = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleAlarm(vehicleid, alarm);
            SendClientMessage(playerid, -1, "Alarm toggled.");
        }
        else if(strcmp(param, "lock", true) == 0)
        {
            if(doors == VEHICLE_PARAMS_ON)
            {
                doors = VEHICLE_PARAMS_OFF;
            }
            else
            {
                doors = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleLocked(vehicleid, doors);
            SendClientMessage(playerid, -1, "Lock toggled.");
        }
        else if(strcmp(param, "hood", true) == 0)
        {
            if(bonnet == VEHICLE_PARAMS_ON)
            {
                bonnet = VEHICLE_PARAMS_OFF;
            }
            else
            {
                bonnet = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleHood(vehicleid, bonnet);
            SendClientMessage(playerid, -1, "Hood toggled.");
        }
        else if(strcmp(param, "trunk", true) == 0)
        {
            if(boot == VEHICLE_PARAMS_ON)
            {
                boot = VEHICLE_PARAMS_OFF;
            }
            else
            {
                boot = VEHICLE_PARAMS_ON;
            }
            ToggleVehicleTrunk(vehicleid, boot);
            SendClientMessage(playerid, -1, "Trunk toggled.");
        }
        else if(strcmp(param, "arrow", true) == 0)
        {
            if(objective == VEHICLE_PARAMS_ON)
            {
                objective = VEHICLE_PARAMS_OFF;
            }
            else
            {
                objective = VEHICLE_PARAMS_ON;
            }
            SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            SendClientMessage(playerid, -1, "Arrow toggled.");
        }
        else SendErrorMessage(playerid, "Invalid paramater.");
    }
    return 1;
}

CMD:gotoo(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new object;
        if(sscanf(params, "d", object))
        {
            SendUsageMessage(playerid, "/gotoo [ObjectID]");
            return 1;
        }

        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(object, x, y, z);
        SetPlayerPosEx(playerid, x, y, z);
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:testcar(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new vehicleid;
        if(sscanf(params, "d", vehicleid))
        {
            SendUsageMessage(playerid, "/testcar [VehicleID]");
            return 1;
        }

        ShowVehicleStats(playerid, vehicleid);
    }
    return 1;
}

CMD:editserver(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        Dialog_Show(playerid, EditServer, DIALOG_STYLE_LIST, "Edit Server", "Change Server Name\nChange Server Abbreviation\nChange Server Revision\nChange Server URL\nSet Server Password", "Select", "Exit");
    }
    return 1;
}

Dialog:EditServer(playerid, response, listitem, inputtext[])
{
    if(response && Player[playerid][AdminLevel] >= 5)
    {
        switch(listitem)
        {
            case 0:
			{
				Dialog_Show(playerid, EditServer_Name, DIALOG_STYLE_INPUT, "Edit Server", "You are about to change the server name.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerName]);
			}
			case 1:
			{
				Dialog_Show(playerid, EditServer_ShortName, DIALOG_STYLE_INPUT, "Change Short Name", "You are about to change the server short name.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerShortName]);
			}
			case 2:
			{
				Dialog_Show(playerid, EditServer_Revision, DIALOG_STYLE_INPUT, "Version/Revision", "You are about to change the server version or revision.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerRevision]);
			}
			case 3:
			{
				Dialog_Show(playerid, EditServer_URL, DIALOG_STYLE_INPUT, "Website URL", "You are about to change the server website URL.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerWebsite]);
			}
            case 4:
			{
				Dialog_Show(playerid, EditServer_Password, DIALOG_STYLE_INPUT, "Website Password", "You are about to change the server password URL.\nCurrent: %s\n\nWhat would you like to change it to?\n\nUse 'none' to remove it.", "Change", "Back", ServerInfo[ServerPassword]);
			}
        }
    }
    return 1;
}

Dialog:EditServer_Password(playerid, response, listitem, inputtext[])
{
    if(Player[playerid][AdminLevel] >= 5)
    {
        if(response)
        {
            new str[128], query[256];
            if(isnull(inputtext))
            {
                SendErrorMessage(playerid, "You must write something.");
                Dialog_Show(playerid, EditServer_Password, DIALOG_STYLE_INPUT, "Website Password", "You are about to change the server password URL.\nCurrent: %s\n\nWhat would you like to change it to?\n\nUse 'none' to remove it.", "Change", "Back", ServerInfo[ServerPassword]);
                return 1;
            }

            if(strcmp(inputtext, "none", true) == 0 || strcmp(inputtext, "none", true) == 0
                || strcmp(inputtext, "remove", true) == 0 || strcmp(inputtext, "unset", true) == 0 || strcmp(inputtext, "0", true) == 0)
            {
                SendRconCommand("password 0");
                ServerInfo[ServerPassword][0] = 0;

                mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerPassword` = '\0'");
                mysql_tquery(g_SQL, query);

                SendClientMessageEx(playerid, COLOR_YELLOW, "You have removed the server password.");
                return pc_cmd_editserver(playerid, inputtext);
            }
            else
            {
                format(ServerInfo[ServerPassword], 128, "%s", inputtext);
                format(str, sizeof(str), "password %s", ServerInfo[ServerWebsite]);
                SendRconCommand(str);
            }

            mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerPassword` = '%e'", inputtext);
            mysql_tquery(g_SQL, query);

            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the password to %s.", ServerInfo[ServerPassword]);
            return pc_cmd_editserver(playerid, inputtext);
        }
    }
    return 1;
}

Dialog:EditServer_URL(playerid, response, listitem, inputtext[])
{
    if(Player[playerid][AdminLevel] >= 5)
    {
        if(response)
        {
            new str[128], query[256];
            if(isnull(inputtext))
            {
                SendErrorMessage(playerid, "You must write something.");
                Dialog_Show(playerid, EditServer_URL, DIALOG_STYLE_INPUT, "Website URL", "You are about to change the server website URL.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerWebsite]);
                return 1;
            }

            format(ServerInfo[ServerWebsite], 128, "%s", inputtext);
            format(str, sizeof(str), "weburl %s", ServerInfo[ServerWebsite]);
            SendRconCommand(str);
            
            mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerWebsite` = '%e'", inputtext);
            mysql_tquery(g_SQL, query);

            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the website to %s.", ServerInfo[ServerName]);
            return pc_cmd_editserver(playerid, inputtext);
        }
    }
    return 1;
}

Dialog:EditServer_ShortName(playerid, response, listitem, inputtext[])
{
    if(Player[playerid][AdminLevel] >= 5)
    {
        if(response)
        {
            new str[128], query[256];
            if(isnull(inputtext))
            {
                SendErrorMessage(playerid, "You must write something.");
                Dialog_Show(playerid, EditServer_ShortName, DIALOG_STYLE_INPUT, "Change Short Name", "You are about to change the server short name.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerShortName]);
                return 1;
            }

            format(ServerInfo[ServerShortName], 128, "%s", inputtext);
            format(str, sizeof(str), "%s %s", ServerInfo[ServerShortName], ServerInfo[ServerRevision]);
            SetGameModeText(str);
            
            mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerShortName` = '%e'", inputtext);
            mysql_tquery(g_SQL, query);

            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the abbreviation to %s.", ServerInfo[ServerName]);
            return pc_cmd_editserver(playerid, inputtext);
        }
    }
    return 1;
}

Dialog:EditServer_Name(playerid, response, listitem, inputtext[])
{
    if(Player[playerid][AdminLevel] >= 5)
    {
        if(response)
        {
            new str[128], query[256];
            if(isnull(inputtext))
            {
                SendErrorMessage(playerid, "You must write something.");
                Dialog_Show(playerid, EditServer_Name, DIALOG_STYLE_INPUT, "Edit Server", "You are about to change the server name.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerName]);
                return 1;
            }

            format(ServerInfo[ServerName], 128, "%s", inputtext);
            format(str, sizeof(str), "hostname %s", ServerInfo[ServerName]);
            SendRconCommand(str);
            
            mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerName` = '%e'", inputtext);
            mysql_tquery(g_SQL, query);

            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the name to %s.", ServerInfo[ServerName]);
        }
        return pc_cmd_editserver(playerid, inputtext);
    }
    return 1;
}

Dialog:EditServer_Revision(playerid, response, listitem, inputtext[])
{
    if(Player[playerid][AdminLevel] >= 5)
    {
        if(response)
        {
            new str[128], query[256];
            if(isnull(inputtext))
            {
                SendErrorMessage(playerid, "You must write something.");
                Dialog_Show(playerid, EditServer_Revision, DIALOG_STYLE_INPUT, "Version/Revision", "You are about to change the server version or revision.\nCurrent: %s\n\nWhat would you like to change it to?", "Change", "Back", ServerInfo[ServerRevision]);
                return 1;
            }

            format(ServerInfo[ServerRevision], 128, "%s", inputtext);
            format(str, sizeof(str), "%s %s", ServerInfo[ServerShortName], ServerInfo[ServerRevision]);
            SetGameModeText(str);
            
            mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `ServerRevision` = '%e'", inputtext);
            mysql_tquery(g_SQL, query);

            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the revision to %s.", ServerInfo[ServerRevision]);
            return pc_cmd_editserver(playerid, inputtext);
        }
    }
    return 1;
}

CMD:tickrate(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
	{
        SendServerMessage(playerid, "Tickrate is %i.", GetServerTickRate());
    }
	return 1;
}

CMD:anticheat(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
	{
        if(gAnticheat)
        {
            gAnticheat = false;
            SendServerMessage(playerid, "Anti-Cheat is off.");
        }
        else
        {
            gAnticheat = true;
            SendServerMessage(playerid, "Anti-Cheat is on.");
        }
    }
	return 1;
}

CMD:pinfo(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/pinfo [playerid]");

        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "The player specified is disconnected.");

        SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) - (Name: %s) - (Master Name: %s) - (Ping: %i) - (Packet Loss: %.1f%c)", targetid, GetUserName(targetid), GetMasterName(targetid), GetPlayerPing(targetid), NetStats_PacketLossPercent(targetid), '%');
    }
	return 1;
}

CMD:hhcheck(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/hhcheck [playerid]");

        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "The player specified is disconnected.");

        if(HHBeingChecked{targetid} == true)
            return SendErrorMessage(playerid, "This player is already being checked.");
        
        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 4)
            return SendErrorMessage(playerid, "You are not allowed to do this.");

        HHBeingChecked{targetid} = true;
        HHCheckInterior[targetid] = GetPlayerInterior(targetid);
        HHCheckVW[targetid] = GetPlayerVirtualWorld(targetid);
        GetPlayerHealth(targetid, HHCheckHealth[targetid]);
        GetPlayerArmour(targetid, HHCheckArmour[targetid]);
        GetPlayerPos(targetid, HHCheckX[targetid], HHCheckY[targetid], HHCheckZ[targetid]);

        SetPlayerInterior(targetid, 7);
        SetPlayerVirtualWorld(targetid, playerid+65534); //Make sure the player is in a VW of their own.
        SetPlayerPosEx(targetid, 290.7393,-135.4273,1004.0625);
        SetPlayerHealthEx(targetid, 99);
        SetPlayerArmour(targetid, 0);
        SetTimerEx("HHCheck", 250, false, "dd", targetid, playerid);
    }
	return 1;
}

function HHCheck(playerid, adminid)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    CreateExplosionForPlayer(playerid, X, Y, Z, 0, 10.0);
    SetTimerEx("HHAftercheck", 250, false, "dd", playerid, adminid);
    return 1;
}

function HHAftercheck(playerid, adminid)
{
    new Float:health, string[128];
    GetPlayerHealth(playerid, Float:health);

    SendClientMessage(adminid, COLOR_GREEN, "____________________________________________________________");
    SendClientMessageEx(adminid, COLOR_GREY, "Health Cheat Check performed on %s (ID: %d, Master: %s)", GetUserName(playerid), playerid, GetMasterName(playerid));
    if(health >= HHCheckHealth[playerid])
    {
        SendClientMessageEx(adminid, COLOR_WHITE, "Result: {FF0000}POSITIVE{FFFFFF} (most likely health cheating).");
    }
    else SendClientMessageEx(adminid, COLOR_WHITE, "Result: {00FF00}NEGATIVE{FFFFFF} (not health hacking).");
    SendClientMessage(adminid, COLOR_GREEN, "____________________________________________________________");

    SetPlayerInterior(playerid, HHCheckInterior[playerid]);
    SetPlayerVirtualWorld(playerid, HHCheckVW[playerid]);
    SetPlayerPosEx(playerid, HHCheckX[playerid], HHCheckY[playerid], HHCheckZ[playerid]);
    SetPlayerHealthEx(playerid, HHCheckHealth[playerid]);
    SetPlayerArmour(playerid, HHCheckArmour[playerid]);
    
    format(string, sizeof string, "%s (%d) was checked for health cheats by %s %s (%d).", GetUserName(playerid), playerid, GetAdminRank(adminid), GetMasterName(adminid), adminid);
    SendAdminWarning(1, string);
    SendServerMessage(playerid, "An administrator has performed a health cheat check on you.");
    ResetHH(playerid);
    return 1;
}

CMD:healall(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new string[128];
        foreach(new i: Player) 
        {
            if(Player[i][IsLoggedIn])
            {
                SetPlayerHealthEx(i, 100);
            }
        }
        format(string, sizeof string, "%s %s has healed all online players.", GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string, 1);
    }
    return 1;
}

CMD:checkhp(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/checkhp [playerid]");

        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "The player specified is disconnected.");

        new Float:health, Float:armour;
        GetPlayerHealth(targetid, health);
        GetPlayerArmour(targetid, armour);

        new pState[32];
        switch(GetPlayerTeam(targetid))
        {
            case PLAYER_ALIVE: pState = "Alive";
            case PLAYER_WOUNDED: pState = "Brutally Wounded";
            case PLAYER_DEAD: pState = "Deceased";
        }

        SendClientMessageEx(playerid, COLOR_GREY, "(%s): State: %s, health: %.1f, Armour: %.1f", GetUserName(targetid), pState, health, armour);
    }
	return 1;
}

CMD:weaponban(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new target;
        if(sscanf(params, "ud", target))
            return SendUsageMessage(playerid, "/weaponban [PlayerID/PartOfName]");

        new string[128];
        if(Player[target][WeaponBan] == 0)
        {
            Player[target][WeaponBan] = 1;
            format(string, sizeof string, "%s (%s) was issued a weapon ban by %s.", GetUserName(target), GetMasterName(target), GetMasterName(playerid));
            SendAdminCommand(string, 1);
            SendClientMessageEx(target, COLOR_LIGHTRED, "You were banned from obtaining weapons by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
            SendClientMessage(target, COLOR_LIGHTRED, "You will need to post a ban appeal in order to regain this functionality.");
        }
        else
        {
            Player[target][WeaponBan] = 0;
            format(string, sizeof string, "%s (%s) had their weapon ban lifted by %s.", GetUserName(target), GetMasterName(target), GetMasterName(playerid));
            SendAdminCommand(string, 1);
            SendClientMessageEx(target, COLOR_LIGHTRED, "Your weapons ban was lifted by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
        }
    }
    return 1;
}

CMD:booc(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/booc [OOC Chat]");
        
        if(strlen(params) > 70)
        {
            SendGlobalOOC(COLOR_OOC, "(( %.70s ... ))", params);
            SendGlobalOOC(COLOR_OOC, "(( ... %s ))", params[70]);
        }
        else SendGlobalOOC(COLOR_OOC, "(( %s ))", params);
    }
    return 1;
}

CMD:xgoto(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new Float:x, Float:y, Float:z;
		if(sscanf(params, "p<,>fff", x, y, z)) 
            return SendUsageMessage(playerid, "/xgoto [X] [Y] [Z]");
        
        if(IsPlayerInAnyVehicle(playerid))
        {
            SetVehiclePos(GetPlayerVehicleID(playerid), x,y,z);
        }
        else
        {
            SetPlayerPosEx(playerid, x, y, z);
        }
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:auntow(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/auntow [VehicleID] - VehicleID is the vehicle that is towing");
        
        if(!IsNumeric(params))
            return SendErrorMessage(playerid, "You must input a valid number.");
        
        new vehicleid = strval(params);
        if(!IsValidVehicle(vehicleid))
            return SendErrorMessage(playerid, "That vehicle does not exist.");
        
        DetachTrailerFromVehicle(vehicleid);
        new string[128];
        format(string, sizeof string, "%s %s has detached the trailer from vehicle %d.", GetAdminRank(playerid), GetMasterName(playerid), vehicleid);
        SendAdminCommand(string, 1);
    }
    return 1;
}

// Admin Command List
CMD:ahelp(playerid, params[])
{
	if(IsAdminLevel(playerid, 1))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Administrator Help:{FFFFFF} Type a command for more information.");
        if(Player[playerid][AdminLevel] >= 1)
        {
            SendClientMessage(playerid, COLOR_ORANGE, "Reports:{FFFFFF} /reports, /ar (accept), /dr (disregard), /sth (send to helpers)");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /aduty, /gotoid, /goto, /gethere, /a (admin chat), /kick, /(o)ban, /(o)ajail, /slap, /freeze, /unfreeze, /aooc");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /unjail, /setint, /setvw, /spec, /(un)mute, /mark(2), /respawncar, /gotocar, /getcar, /listmasks, /afk, /dropinfo");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /dropinfo, /revive, /sendtoid, /lastdmg, /afkkick, /removehandcuff, /ajailed, /up, /down, /left, /right, /hq");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /showmaster, /setskin, /kills, /attacks, /arecord, /goincar, /arepair, /flip, /seedriver, /actionlog, /viewnotes");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /addnote, /oaddnote, /asetparamcar, /blockpm, /backup, /setintvw, /seizeplant, /skick, /sban, /sjail, /hhcheck");
            SendClientMessage(playerid, 0x800080FF, "Trial Admin:{FFFFFF} /checkhp, /arefuel, /asetfuel, /rented, /weaponban, /auntow, /respawn, /reset, /richlist");
        }
        if(Player[playerid][AdminLevel] >= 2)
        {
            SendClientMessage(playerid, 0x06A106FF, "General Admin:{FFFFFF} /setjob, /amask, /setweather, /disarm, /jetpack, /leaders, /respawncars, /vehname, /x, /y, /z, /disablechar");
            SendClientMessage(playerid, 0x06A106FF, "General Admin:{FFFFFF} /sf, /gotoo, /soundtest, /pinfo, /ahide, /gotoplant, /checkplant, /gotoatm, /gotojail, /check, /testcar");
        }
        if(Player[playerid][AdminLevel] >= 3)
        {
            SendClientMessage(playerid, 0xFFAA65FF, "Senior Admin:{FFFFFF} /gotopos, /gotobiz, /gotohouse, /gotofaction, /setname, /aexcusefine, /interiors, /mstats, /noooc, /healall");
            SendClientMessage(playerid, 0xFFAA65FF, "Senior Admin:{FFFFFF} /givegun, /givemoney, /setmoney, /giveveh, /announcefire, /killfire, /spawnfire, /gotofactionduty");
            SendClientMessage(playerid, 0xFFAA65FF, "Senior Admin:{FFFFFF} /disbandroadblocks, /disbandspikes");
        }
        if(Player[playerid][AdminLevel] >= 4)
        {
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /la (lead admin+ chat), /afactionhelp, /ahousehelp, /adminmotd, /helpermotd, /abizhelp, /makehelper, /firehelper");
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /clearreports, /veh, /destroyveh, /blowup, /setpfaction, /makexmrcat, /makexmrstation, /rac, /setstat, /sethealth");
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /setarmour, /destroyallveh, /destroydynveh, /tickrate, /setmotd, /setdeveloper, /mappinghelp, /giveaccessory, /tod");
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /ann, /pumphelp, /labelhelp, /editveh, /createblackmarket, /editblackmarket, /speclist, /atmhelp, /minestats, /gatehelp");
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /blackmarketid, /removesceneall, /graffitihelp, /createjail, /editjail, /edittrucker, /complexhelp, /dealerhelp, /xgoto");
            SendClientMessage(playerid, 0xFF0000FF, "Lead Admin:{FFFFFF} /entrancehelp, /creategarbage, /destroygarbage, /editgarbage");
        }
        if(Player[playerid][AdminLevel] >= 5)
        {
            SendClientMessage(playerid, 0xCC0000FF, "Server Manager:{FFFFFF} /makeadmin, /payday, /gmx, /gotoxyz, /setdonate, /afix, /anos, /speclist, /editserver, /booc, /startlotto, /teleports");
            SendClientMessage(playerid, 0xCC0000FF, "Server Manager:{FFFFFF} /addtp, /deletetp");
        }
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
	return 1;
}

stock ShowFlagsToAdmins(playerid)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "SELECT Message FROM admin_notes WHERE AccountID = %d ORDER BY `Timestamp` DESC LIMIT 1", Player[playerid][ID]);
    mysql_tquery(g_SQL, query, "ShowFlagsGet", "d", playerid);
    return 1;
}

function ShowFlagsGet(playerid)
{
    if(cache_num_rows() > 0)
    {
        new string[256], flag[128];
        cache_get_value(0, "Message", flag, sizeof(flag));

        format(string, sizeof string, "%s (%s) has an active admin note: %s", GetUserName(playerid), GetMasterName(playerid), flag);
        SendAdminWarning(1, string);
    }
    return 1;
}