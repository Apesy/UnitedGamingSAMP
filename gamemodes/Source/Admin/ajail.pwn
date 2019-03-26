//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock ReleaseFromAdminJail(playerid)
{
    SetVirtualWorld(playerid, 0); 
    SetInterior(playerid, 0);
	SetPlayerPosEx(playerid, -152.2196,1088.0068,19.7422);
    Player[playerid][Ajailed] = 0;
    Player[playerid][AjailTime] = 0;
    Player[playerid][AjailReason][0] = 0;
    SendClientMessage(playerid, COLOR_GREY, "You were released from admin jail.");
}

stock ReleaseFromPoliceJail(playerid)
{
    SetVirtualWorld(playerid, 0); 
    SetInterior(playerid, 0);
	SetPlayerPosEx(playerid, -152.2196,1088.0068,19.7422);
    PlayerInfo[playerid][pJailed] = 0;
    PlayerInfo[playerid][pJailTime] = 0;
    SendClientMessage(playerid, COLOR_GREY, "You were released from jail.");
}

CMD:sjail(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, minutes, reason[128];
        if(sscanf(params, "uds[128]", targetid, minutes, reason))
        {
            SendUsageMessage(playerid, "/sjail [PlayerID/PartOfName] [minutes] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not allowed to do this.");

        ShowFlagsToAdmins(targetid);

        TakePlayerGuns(targetid);
        Player[targetid][Ajailed] = 1;
        Player[targetid][AjailTime] = minutes*60;
        format(Player[targetid][AjailReason], 128, "%s", reason);
        format(Player[targetid][AjailedBy], MAX_PLAYER_NAME+1, "%s", GetMasterName(playerid));
        PlayerInfo[targetid][pJailed] = 0;
        PlayerInfo[targetid][pJailTime] = 0;
        PlayerInfo[targetid][pFactionDuty] = 0;
        SetPlayerTeamColour(targetid);
        SetInterior(targetid, 6);
        SetVirtualWorld(targetid, targetid+100);
        SetPlayerPosEx(targetid, 264.8460, 77.6047, 1001.2493);
        TogglePlayerWait(targetid);
        PrintFooter(targetid, "~w~You were ~r~Admin Jailed", 5);

        new insertLog[256];
        
        format(insertLog, sizeof insertLog, "%s was silently jailed by %s. Reason: %s", GetUserName(targetid), GetMasterName(playerid), reason);
        SendAdminCommand(insertLog, 1);
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "You were admin jailed for %d minutes.", minutes);
        mysql_format(g_SQL, insertLog, sizeof(insertLog), "INSERT INTO ajail_logs (`JailedDBID`, `JailedName`, `Reason`, `JailedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
        Player[targetid][ID], GetMasterName(targetid), reason, GetMasterName(playerid), GetDateTime()); 
        mysql_tquery(g_SQL, insertLog);
    }
    return 1;
}

CMD:ajail(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new targetid, minutes, reason[128];
        if(sscanf(params, "uds[128]", targetid, minutes, reason))
        {
            SendUsageMessage(playerid, "/ajail [PlayerID/PartOfName] [minutes] [reason]");
            return 1;
        }

        if(Player[targetid][AdminLevel] >= 1 && targetid != playerid && Player[playerid][AdminLevel] < 5)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not allowed to do this.");

        ShowFlagsToAdmins(targetid);

        TakePlayerGuns(targetid);
        Player[targetid][Ajailed] = 1;
        Player[targetid][AjailTime] = minutes*60;
        format(Player[targetid][AjailReason], 128, "%s", reason);
        format(Player[targetid][AjailedBy], MAX_PLAYER_NAME+1, "%s", GetMasterName(playerid));
        PlayerInfo[targetid][pJailed] = 0;
        PlayerInfo[targetid][pJailTime] = 0;
        PlayerInfo[targetid][pFactionDuty] = 0;
        SetPlayerTeamColour(targetid);
        SetInterior(targetid, 6);
        SetVirtualWorld(targetid, targetid+100);
        SetPlayerPosEx(targetid, 264.8460, 77.6047, 1001.2493);
        TogglePlayerWait(targetid);
        PrintFooter(targetid, "~w~You were ~r~Admin Jailed", 5);

        new insertLog[256];
        
        format(insertLog, sizeof insertLog, "%s was admin jailed by %s. Reason: %s", GetUserName(targetid), GetMasterName(playerid), reason);
        SendAdminCommand(insertLog);
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "You were admin jailed by %s %s for %d minutes.", GetAdminRank(playerid), GetMasterName(playerid), minutes);
        mysql_format(g_SQL, insertLog, sizeof(insertLog), "INSERT INTO ajail_logs (`JailedDBID`, `JailedName`, `Reason`, `JailedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
        Player[targetid][ID], GetMasterName(targetid), reason, GetMasterName(playerid), GetDateTime()); 
        mysql_tquery(g_SQL, insertLog);
    }
    return 1;
}

CMD:oajail(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new username[MAX_PLAYER_NAME+1], days, reason[128];
        if(sscanf(params, "s[25]ds[128]", username, days, reason))
        {
            SendUsageMessage(playerid, "/oajail [master account name] [minutes] [reason]");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `OfflineJailed` = 1, `OJailTime` = %d, `OJailReason` = '%e' WHERE `Username` = '%e' LIMIT 1", days, reason, username);
        mysql_tquery(g_SQL, query, "OnUserOfflineJail", "sdds", username, playerid, days, reason);
    }
    return 1;
}

function OnUserOfflineJail(username[], playerid, minutes, reason[])
{
    if(cache_num_rows() > 0)
    {
        new iAdmin;
        cache_get_value_int(0, "AdminLevel", iAdmin);

        if(iAdmin >= 1)
        {
            if(Player[playerid][AdminLevel] < 5)
            {
                SendClientMessage(playerid, COLOR_LIGHTRED, "You are not allowed to do this.");
                return 1;
            }
        }

        new string[256];
        format(string, sizeof string, "%s was offline jailed by %s for %d min. Reason: %s", username, GetUserName(playerid), minutes, reason);
        SendAdminCommand(string, 1);
    }
    else
    {
        SendErrorMessage(playerid, "Username \"%s\" was not found.", username);
    }
    return 1;
}

CMD:ajailed(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Admin Jailed Players:");
        foreach(new i: Player)
        {
            if(Player[i][AjailTime] >= 1)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d]: %s, Reason: %s, Admin: %s (%s left)", i, GetUserName(i), Player[i][AjailReason], Player[i][AjailedBy], TimeConvert(Player[i][AjailTime]));
            }
        }
    }
    return 1;
}