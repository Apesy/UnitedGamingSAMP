//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock SystemBan(playerid, reason[])
{
    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO ban_logs (`BannedDBID`, `BannedName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
    Player[playerid][ID], GetMasterName(playerid), reason, "SYSTEM", GetDateTime()); 
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "INSERT INTO `bans` (`AccountID`, `Admin`, `UnbanTimestamp`, `Reason`, `IPAddress`) VALUES (%d, '%e', %d, '%e', '%e')", Player[playerid][ID], "SYSTEM", 0, reason, GetUserIP(playerid));
    mysql_tquery(g_SQL, query, "OnSystemUserBan", "dds", playerid, 0, reason);
}

stock ScriptBan(playerid, adminid, days, reason[], silent = 0)
{
    TempVar[playerid][BeingKicked] = true;
    new query[256], adminName[32];
    adminName = GetMasterName(adminid);

    new insertLog[256];
    mysql_format(g_SQL, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`BannedDBID`, `BannedName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
    Player[playerid][ID], GetMasterName(playerid), reason, GetMasterName(adminid), GetDateTime()); 
    mysql_tquery(g_SQL, insertLog);

    mysql_format(g_SQL, query, sizeof query, "INSERT INTO `bans` (`AccountID`, `Admin`, `UnbanTimestamp`, `Reason`, `IPAddress`) VALUES (%d, '%e', %d, '%e', '%e')", Player[playerid][ID], adminName, (days == 0) ? (days) : (gettime()+(days*86400)), reason, GetUserIP(playerid));
    mysql_tquery(g_SQL, query, "OnUserBan", "dsdsd", playerid, adminName, days, reason, silent);
}

function OnSystemUserBan(playerid, days, reason[])
{
    new string[256];
    ShowFlagsToAdmins(playerid);
    format(string, sizeof(string), "%s was autobanned. Reason: %s", GetUserName(playerid), reason);
    SendAdminCommand(string);
    ShowBanMessage(playerid, "Autoban", reason, gettime());
    DelayedKick(playerid);
    return 1;
}

function OnUserBan(playerid, adminName[], days, reason[], silent)
{
    new string[256];
    ShowFlagsToAdmins(playerid);
    if(silent)
    {
        format(string, sizeof(string), "%s was silent banned by %s. Reason: %s", GetUserName(playerid), adminName, reason);
        SendAdminWarning(1, string);
    }
    else
    {
        format(string, sizeof(string), "%s was banned by %s. Reason: %s", GetUserName(playerid), adminName, reason);
        SendAdminCommand(string);
    }
    if(days)
    {
        ShowBanMessage(playerid, adminName, reason, gettime(), gettime()+(days*86400));
    }
    else ShowBanMessage(playerid, adminName, reason, gettime());
    DelayedKick(playerid);
    return 1;
}

function OnUserOfflineBan(username[], adminid, days, reason[])
{
    if(cache_num_rows() > 0)
    {
        new accountID, iAdmin, storedIP[128], storedGPCI[41], string[256];
        cache_get_value_int(0, "id", accountID);
        cache_get_value_int(0, "AdminLevel", iAdmin);

        cache_get_value_name(0, "StoredIP", storedIP, sizeof(storedIP));
        cache_get_value_name(0, "StoredGPCI", storedGPCI, sizeof(storedGPCI));

        if(iAdmin >= 1 && Player[adminid][AdminLevel] < 5)
        {
            SendClientMessage(adminid, COLOR_LIGHTRED, "You are not allowed to do this to another administrator.");
            return 1;
        }

        mysql_format(g_SQL, string, sizeof string, "INSERT INTO `bans` (`AccountID`, `Admin`, `UnbanTimestamp`, `Reason`, `IPAddress`, `BanDate`, `Serial`) VALUES (%d, '%e', %d, '%e', '%e', %d, '%e')", 
            accountID, GetMasterName(adminid), (days == 0) ? (days) : (gettime()+(days*86400)), reason, storedIP, gettime(), storedGPCI);
        mysql_tquery(g_SQL, string, "OnFinalizeOfflineBan", "sdds", username, accountID, adminid, reason);
    }
    else
    {
        SendClientMessageEx(adminid, COLOR_LIGHTRED, ">>> {FFFF00}Username {%06x}\"%s\"{FFFF00} was not found.", username, COLOR_LIGHTRED >>> 8);
    }
    return 1;
}

function OnFinalizeOfflineBan(username[], dbid, playerid, reason)
{
    new string[256];
    mysql_format(g_SQL, string, sizeof(string), "INSERT INTO ban_logs (`BannedDBID`, `BannedName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
    dbid, username, reason, GetMasterName(playerid), GetDateTime()); 
    mysql_tquery(g_SQL, string);
    
    format(string, sizeof(string), "%s was offline banned by %s. Reason: %s", username, GetMasterName(playerid), reason);
    SendAdminWarning(1, string);
    return 1;
}

function OnIPBan(playerid, ipAddr[], reason[])
{
    new string[256];
    format(string, sizeof(string), "IP %s was banned by %s. Reason: %s", ipAddr, GetMasterName(playerid), reason);
    SendAdminWarning(1, string);
    return 1;
}

stock ShowBanMessage(playerid, adminName[], reason[], time, expire = 0)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "You have been banned due to violations of the rules.");
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "You can appeal your ban at https://dc-rp.com/");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Administrator: %s", adminName);
    if(strlen(reason) > 70)
    {
        SendClientMessageEx(playerid, COLOR_GRAD4, "Reason: %.70s ...", reason);
        SendClientMessageEx(playerid, COLOR_GRAD4, "Reason: ... %.70s", reason[70]);
    }
    else SendClientMessageEx(playerid, COLOR_GRAD4, "Reason: %s", reason);
    SendClientMessageEx(playerid, COLOR_GRAD3, "Date/Time: %s", date(time));
    if(expire)
    {
        SendClientMessageEx(playerid, COLOR_GRAD2, "Ban Lifted: %s", date(expire));
    }
    else SendClientMessageEx(playerid, COLOR_GRAD2, "Ban Lifted: Never.");
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________________________");
}