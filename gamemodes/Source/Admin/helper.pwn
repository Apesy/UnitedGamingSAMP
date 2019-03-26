//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock AddHelperAcceptance(playerid)
{
    HelpmeCount[playerid]++;
    HelpmeHourCount[playerid]++;
    mysql_format(g_SQL, string, sizeof(string), "SELECT COUNT(*) FROM `HelperAcceptance` WHERE `ID` = %d AND `Date` = '%s'", Player[giveplayerid][ID], tdate);
    mysql_tquery(g_SQL, string, "OnCheckHelpmeCount", "iss", playerid, GetMasterName(giveplayerid), tdate);
}

function OnCheckHelpmeCount(playerid, giveplayername[], tdate[])
{
    new string[128], rows, tcount;
	cache_get_row_count(rows);

    cache_get_value_name_int(0, "COUNT(*)", tcount);

    if(tcount > 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s accepted {%06x}%d{%06x} help requests on %s.", giveplayername, COLOR_LIGHTRED >>> 8, tcount, COLOR_WHITE >>> 8, tdate);
    }
    else
    {
        format(string, sizeof(string), "{FFFFFF}%s did not accept any help requests on %s.", giveplayername, tdate);
    }
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Helper Activity", string, "Okay", "");
	return 1;
}

CMD:checkrequestcount(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 4)
	{
		new string[128], username[MAX_PLAYER_NAME+1], tdate[11];
		if(sscanf(params, "s["#MAX_PLAYER_NAME"]s[11]", username, tdate)) return SendUsageMessage(playerid, "/checkrequestcount [Master Name] [Date (DD-MM-YYYY)]");
		new giveplayerid = ReturnMasterUser(username);
		if(IsPlayerConnected(giveplayerid))
		{
			mysql_format(g_SQL, string, sizeof(string), "SELECT COUNT(*) FROM `HelperAcceptance` WHERE `ID` = %d AND `Date` = '%s'", Player[giveplayerid][ID], tdate);
			mysql_tquery(g_SQL, string, "OnCheckHelpmeCount", "iss", playerid, GetMasterName(giveplayerid), tdate);
		}
		else
		{
			mysql_format(g_SQL, string, sizeof string, "SELECT `id`, `username` FROM `players` WHERE `username` = '%e' LIMIT 1", username);
            mysql_tquery(g_SQL, string, "OnCheckHelpme_GetID", "d", playerid);
		}
    }
    return 1;
}

function OnCheckHelpme_GetID(playerid, tdate[])
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new accountID, username[MAX_PLAYER_NAME+1], query[256];
        cache_get_value_int(0, "id", accountID);
        cache_get_value(0, "username", username, sizeof username);
        mysql_format(g_SQL, query, sizeof(query), "SELECT COUNT(*) FROM `HelperAcceptance` WHERE `ID` = %d AND `Date` = '%s'", accountID, tdate);
        mysql_tquery(g_SQL, query, "OnCheckHelpmeCount", "iss", playerid, username, tdate);
    }
    else SendErrorMessage(playerid, "Cannot find account.");
    return 1;
}

stock SendHelperMessage(color, level, str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(Player[i][HelperLevel] >= level || Player[i][AdminLevel] >= 4)
			{
                SendClientMessage(i, color, string);
            }
		}
		return 1;
	}
	foreach (new i : Player) 
    {
        if(Player[i][HelperLevel] >= level || Player[i][AdminLevel] >= 4)
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

stock GetHelperRank(playerid)
{
    new rankStr[32];
    switch(Player[playerid][HelperLevel])
    {
        case 1: format(rankStr, sizeof(rankStr), "Community Helper");
        case 2: format(rankStr, sizeof(rankStr), "Lead Helper");
        default: format(rankStr, sizeof(rankStr), "Undefined Helper (%d)", Player[playerid][HelperLevel]);
    }
    return rankStr;
}

stock IsHelperLevel(playerid, level, bool:warning = true)
{
    if(Player[playerid][HelperLevel] >= level) return 1;
	if(warning == true) SendErrorMessage(playerid, "You're not authorised to use this.");
	return 0;
}

CMD:helpers(playerid, params[])
{
    new bool:helpersOnline = false, string[1024];
    foreach(new i: Player)
    {
        if(Player[i][HelperLevel] >= 1) helpersOnline = true;
    }

    if(helpersOnline == true)
    {
        if(Player[playerid][AdminLevel] >= 4)
        {
            foreach(new i: Player)
            {
                if(Player[i][HelperLevel] >= 1)
                {
                    if(TempVar[i][HelperDuty] == true)
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) (Requests this Hour: %d | Requests Today: %d) {33AA33}[On Duty]\n", string, GetHelperRank(i), GetUserName(i), GetMasterName(i), HelpmeCount[playerid], HelpmeHourCount[playerid]);
                    }
                    else
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) (Requests this Hour: %d | Requests Today: %d) {AA3333}[Off Duty]\n", string, GetHelperRank(i), GetUserName(i), GetMasterName(i), HelpmeCount[playerid], HelpmeHourCount[playerid]);
                    }
                }
            }
        }
        else
        {
            foreach(new i: Player)
            {
                if(Player[i][HelperLevel] >= 1)
                {
                    if(TempVar[i][HelperDuty] == true)
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {33AA33}[On Duty]\n", string, GetHelperRank(i), GetUserName(i), GetMasterName(i));
                    }
                    else
                    {
                        format(string, sizeof string, "%s{FFFFFF}%s %s (%s) {AA3333}[Off Duty]\n", string, GetHelperRank(i), GetUserName(i), GetMasterName(i));
                    }
                }
            }
        }
    }
    else
    {
        format(string, sizeof string, "{FFFFFF}There are no helpers online.");
    }
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Helper Team", string, "Okay", "");
    return 1;
}

CMD:hc(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 1, false))
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/hc [message]");
            return 1;
        }

        if(TempVar[playerid][Muted] == true)
		    return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        foreach(new i: Player)
        {
            if(Player[i][HelperLevel] >= 1 || Player[i][AdminLevel] >= 4)
            {
                if(TempVar[i][HelperDisabled] == false)
                {
                    if(strlen(params) > 70)
                    {
                        SendClientMessageEx(i, COLOR_LIGHTBLUE, "* [HELPER] %s (%s): %.70s ...", GetUserName(playerid), GetMasterName(playerid), params);
                        SendClientMessageEx(i, COLOR_LIGHTBLUE, "* [HELPER] %s (%s): ... %s", GetUserName(playerid), GetMasterName(playerid), params[70]);
                    }
                    else
                    {
                        SendClientMessageEx(i, COLOR_LIGHTBLUE, "* [HELPER] %s (%s): %s", GetUserName(playerid), GetMasterName(playerid), params);
                    }
                }
            }
        }
        new logString[256];
        format(logString, sizeof logString, "[%s %s] %s", GetStaffRank(playerid), GetMasterName(playerid), params);
        DCC_SendChannelMessage(g_HelperChat, logString);
        format(logString, sizeof(logString), "%s (IP: %s AccountID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], params);
        DBLog("HelperChat", logString);
    }
    else SendErrorMessage(playerid, "You cannot use this command.");
    return 1;
}

CMD:makehelper(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 2, false))
    {
        new giveplayerid, level;
        if(sscanf(params, "ud", giveplayerid, level))
            return SendUsageMessage(playerid, "/makehelper [playerid or name] [level]");

        if(!IsPlayerConnected(giveplayerid))
            return SendErrorMessage(playerid, "The player you specified isn't connected."); 

        if(!Player[giveplayerid][IsLoggedIn])
            return SendErrorMessage(playerid, "The player you specified isn't logged in."); 

        SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has made %s a level %d helper.", GetHelperRank(playerid), GetMasterName(playerid), GetMasterName(giveplayerid), level);
        SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, "* Your helper rank has been set to %d by %s %s.", level, GetHelperRank(playerid), GetMasterName(playerid));
        if(level == 0 && TempVar[giveplayerid][HelperDuty] == true)
        {
            TempVar[playerid][HelperDuty] = false;
            SetPlayerTeamColour(playerid);
        }
        Player[giveplayerid][HelperLevel] = level;
    }
    return 1;
}

CMD:firehelper(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false))
    {
        new giveplayerid;
        if(sscanf(params, "u", giveplayerid))
            return SendUsageMessage(playerid, "/firehelper [playerid or name]");

        if(!IsPlayerConnected(giveplayerid))
            return SendErrorMessage(playerid, "The player you specified isn't connected."); 

        if(!Player[giveplayerid][IsLoggedIn])
            return SendErrorMessage(playerid, "The player you specified isn't logged in."); 

        SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has removed %s from the helper team.", GetHelperRank(playerid), GetMasterName(playerid), GetMasterName(giveplayerid));
        SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, "* Your helper rank has been removed by %s %s.", GetHelperRank(playerid), GetMasterName(playerid));
        if(TempVar[giveplayerid][HelperDuty] == true)
        {
            TempVar[giveplayerid][HelperDuty] = false;
            SetPlayerTeamColour(playerid);
        }
        Player[giveplayerid][HelperLevel] = 0;
    }
    return 1;
}

CMD:hduty(playerid, params[])
{
    if(IsHelperLevel(playerid, 1))
    {
        if(TempVar[playerid][HelperDuty] == true)
        { 
            SendHelperMessage(COLOR_RED, 1, "[HELPER] {FFFF00}%s is off duty.", GetUserName(playerid));
            TempVar[playerid][HelperDuty] = false;
        }
        else
        {
            SendHelperMessage(COLOR_RED, 1, "[HELPER] {FFFF00}%s is on duty.", GetUserName(playerid));
            TempVar[playerid][HelperDuty] = true;
        }
        SetPlayerTeamColour(playerid);
    }
    return 1;
}

CMD:hhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 1, false))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Helper Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Help Requests: /requests, /accepthelp (accept), /denyhelp (disregard), /sta (send to admins)");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Community Helper: /hduty, /hc (helper chat), /st (staff chat), /hmabuse, /hunmute, /setgender");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    else SendErrorMessage(playerid, "You do not have access to this command.");
    return 1;
}