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

enum helpmeInfo
{
    bool:RequestExists,
    RequestDetails[128],
    RequestTime,
    RequestBy
}
new RequestInfo[MAX_REPORTS][helpmeInfo];

hook OnPlayerDisconnect(playerid, reason)
{
    new bool:reportActive = false;
	for(new i = 1; i < sizeof(RequestInfo); i++)
    {
        if(RequestInfo[i][RequestExists] == true && RequestInfo[i][RequestBy] == playerid)
        {
			reportActive = true;
            RequestInfo[i][RequestExists] = false;
        }
    }

	if(reportActive == true)
	{
		SendHelperMessage(COLOR_LIGHTBLUE, 1, "[Helper] %s has left the server with a pending request. It has been cancelled.", GetMasterName(playerid));
	}
    return 1;
}

stock GetHelperAcceptanceCount(playerid, thour, tdate[])
{
	new string[128];
	mysql_format(g_SQL, string, sizeof(string), "SELECT COUNT(*) FROM `HelperAcceptance` WHERE `ID` = %d AND `Date` = '%e'", Player[playerid][ID], tdate);
	mysql_tquery(g_SQL, string, "OnGetReportCount", "i", playerid);
    mysql_format(g_SQL, string, sizeof(string), "SELECT COUNT(*) FROM `HelperAcceptance` WHERE `ID` = %d AND `Date` = '%e' AND `Hour` = %d", Player[playerid][ID], tdate, thour);
	mysql_tquery(g_SQL, string, "OnGetReportHourCount", "i", playerid);
}

function OnGetReportCount(playerid)
{
    new rows;
	cache_get_row_count(rows);
    if(rows > 0)
    {
        cache_get_value_name_int(0, "COUNT(*)", HelpmeCount[playerid]);
    }
    else HelpmeCount[playerid] = 0;
    return 1;
}

function OnGetReportHourCount(playerid)
{
    new rows;
	cache_get_row_count(rows);
    if(rows > 0)
    {
        cache_get_value_name_int(0, "COUNT(*)", HelpmeHourCount[playerid]);
    }
    else HelpmeCount[playerid] = 0;
    return 1;
}

CMD:clearrequests(playerid, params[])
{
    if(IsHelperLevel(playerid, 2, false) || IsAdminLevel(playerid, 4, false))
    {
        new reportCount = 0;
	
        for (new i = 0; i < sizeof(RequestInfo); i ++)
        {
            if(RequestInfo[i][RequestExists] == true)
            {
                reportCount++;
            }
        }
        if(reportCount)
        {
            Dialog_Show(playerid, DIALOG_CLEAR_HELPME, DIALOG_STYLE_MSGBOX, "Clear Requests", "You are about to clear all help requests!\nAre you sure about this?", "Confirm", "Cancel");
        }
        else return SendErrorMessage(playerid, "There are no active requests to clear.");
    }
    return 1;
}

Dialog:DIALOG_CLEAR_HELPME(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new reports;
        for (new i = 0; i < sizeof(RequestInfo); i ++)
        {
            if(RequestInfo[i][RequestExists] == true)
            {
                reports++;
                RequestInfo[i][RequestExists] = false;
            }
        }
        
        SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has cleared %d %s.", GetHelperRank(playerid), GetUserName(playerid), reports, (reports > 1) ? ("requests") : ("request"));
    }
    else return SendClientMessage(playerid, COLOR_LIGHTRED, "[SYSTEM] {FFFFFF}You cancelled the confirmation.");
    return 1;
}

CMD:denyhelp(playerid, params[])
{
    if(IsHelperLevel(playerid, 1, false) || IsAdminLevel(playerid, 4, false))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/denyhelp (/dhm) [request id]"); 
        
        if(RequestInfo[reportid][RequestExists] == false)
            return SendErrorMessage(playerid, "The request ID you specified doesn't exist.");
            
        SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has disregarded request %d.", GetStaffRank(playerid), GetUserName(playerid), reportid);
        SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTBLUE, "%s %s (%d) has trashed your request. (Request ID: %d)", GetStaffRank(playerid), GetUserName(playerid), playerid, reportid);
        RequestInfo[reportid][RequestExists] = false;
        RequestInfo[reportid][RequestBy] = INVALID_PLAYER_ID; 
    }
    return 1;
}
alias:denyhelp("dhm");

CMD:accepthelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 1, false))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/accepthelp (/ahm) [helpme id]"); 
        
        if(RequestInfo[reportid][RequestExists] == false)
            return SendErrorMessage(playerid, "The helpme ID you specified doesn't exist.");
            
        SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has accepted helpme %d.", GetStaffRank(playerid), GetUserName(playerid), reportid);
        SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTBLUE, "%s %s (%d) has responded to your support request. (Request ID: %d)", GetStaffRank(playerid), GetUserName(playerid), playerid, reportid);
        if(strlen(RequestInfo[reportid][RequestDetails]) > 70)
        {
            SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTRED, "Request: {FFFFFF}%.70s ...", RequestInfo[reportid][RequestDetails]);
            SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTRED, "Request: {FFFFFF}... %s", RequestInfo[reportid][RequestDetails][70]);
        }
        else SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTRED, "Request: {FFFFFF}%s", RequestInfo[reportid][RequestDetails]);

        //Player[playerid][AcceptedHelp]++;
        HelpmeCount[playerid]++;
        HelpmeHourCount[playerid]++;

        //mysql_format(g_SQL, string, sizeof string, "INSERT INTO `HelperAcceptance`", {Float, _:...})

        RequestInfo[reportid][RequestDetails][0] = 0;
        RequestInfo[reportid][RequestExists] = false;
        RequestInfo[reportid][RequestBy] = INVALID_PLAYER_ID; 
    }
    return 1;
}
alias:accepthelp("ahm");

CMD:sta(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 1, false))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/sta (send to admins) [helpme id]"); 
        
        if(RequestInfo[reportid][RequestExists] == false)
            return SendErrorMessage(playerid, "The helpme ID you specified doesn't exist.");
            

        if(SendReport(RequestInfo[reportid][RequestBy], RequestInfo[reportid][RequestDetails]) != 0)
        {
            SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has send request %d to server administrators.", GetStaffRank(playerid), GetUserName(playerid), reportid);
            SendClientMessageEx(RequestInfo[reportid][RequestBy], COLOR_LIGHTBLUE, "%s %s (%d) has referred your support request to administrators, please wait.", GetStaffRank(playerid), GetUserName(playerid), playerid);
            RequestInfo[reportid][RequestDetails][0] = 0;
            RequestInfo[reportid][RequestExists] = false;
            RequestInfo[reportid][RequestBy] = INVALID_PLAYER_ID; 
        }
        else SendErrorMessage(playerid, "The admins are overwhelmed with reports right now, send the requester to the forums.");

    }
    return 1;
}

CMD:requests(playerid, params[])
{
    if(IsAdminLevel(playerid, 4, false) || IsHelperLevel(playerid, 1, false))
    {
        new bool:count = false;
        SendClientMessage(playerid, COLOR_GREEN, "____________________ HELP REQUESTS _____________________");
        for(new i = MAX_REPORTS-1; i >= 0; i--)
        {
            if(RequestInfo[i][RequestExists] == true)
            {
                count = true;
                if(strlen(RequestInfo[i][RequestDetails]) > 70)
                {
                    SendClientMessageEx(playerid, COLOR_WHITE, "%s (ID: %d) | RID: %d | Request: %.70s", GetUserName(RequestInfo[i][RequestBy]), RequestInfo[i][RequestBy], i, RequestInfo[i][RequestDetails]);
                    SendClientMessageEx(playerid, COLOR_WHITE, "... %s | Pending: %d Sec ago", RequestInfo[i][RequestDetails][70], gettime() - RequestInfo[i][RequestTime]);
                }
                else SendClientMessageEx(playerid, COLOR_WHITE, "%s (ID: %d) | RID: %d | Request: %s | Pending: %d Sec ago", GetUserName(RequestInfo[i][RequestBy]), RequestInfo[i][RequestBy], i, RequestInfo[i][RequestDetails], gettime() - RequestInfo[i][RequestTime]);
            }
        }
        if(count == true)
        {
            SendClientMessage(playerid, COLOR_GREY, "* Use /accepthelp, /denyhelp or /hmabuse to respond to a request.");
        }
        else
        {
            SendErrorMessage(playerid, "No active help requests found.");
        }
        SendClientMessage(playerid, COLOR_GREEN, "_________________________________________________________");
    }
    return 1;
}

Dialog:SendHelpme(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(isnull(inputtext))
        {
            Dialog_Show(playerid, SendHelpme, DIALOG_STYLE_INPUT, "Help Request", "Please type in the box below what you need help with.", "Send", "Cancel");
            return 1;
        }

        if(strlen(inputtext) < 5)
        {
            Dialog_Show(playerid, SendHelpme, DIALOG_STYLE_INPUT, "Help Request", "ERROR: Your request cannot be less than 5 characters long.\n\
            Please type in the box below what you need help with.", "Send", "Cancel");
            return 1;
        }

        if(strlen(inputtext) > 128)
        {
            Dialog_Show(playerid, SendHelpme, DIALOG_STYLE_INPUT, "Help Request", "ERROR: Your request is too long, it must be less than 128 characters.\n\
            Please type in the box below what you need help with.", "Send", "Cancel");
            return 1;
        }

        SendHelpme(playerid, inputtext);
        SendServerMessage(playerid, "Your request was sent to all online helpers.");
    }
    return 1;
}

CMD:helpme(playerid, params[])
{
    if((Player[playerid][AdminLevel] >= 1 || Player[playerid][HelperLevel] >= 1 || Player[playerid][Mapper] >= 1) && Player[playerid][AdminLevel] < 4)
    {
        SendErrorMessage(playerid, "You cannot send /helpme's as a staff member, use /staff instead.");
        return 1;
    }

    if(gettime()-TempVar[playerid][SentHelpme] < 1)
    {
        SendErrorMessage(playerid, "You already sent a request. Please wait %i more seconds.", gettime() - TempVar[playerid][SentHelpme]);
        return 1;
    }

    if(Player[playerid][HelpmeMutes] >= 4)
    {
        SendErrorMessage(playerid, "You are permanently banned from using /helpme. Post a Ban Appeal on the forums.");
        return 1;
    }

    if(Player[playerid][HelpmeMuted] > 0)
    {
        SendErrorMessage(playerid, "You are currently blocked from using /helpme.");
        return 1;
    }

    if(isnull(params))
    {
        Dialog_Show(playerid, SendHelpme, DIALOG_STYLE_INPUT, "Help Request", "Please type in the box below what you need help with.", "Send", "Cancel");
        return 1;
    }

    if(strlen(params) < 5)
    {
        SendErrorMessage(playerid, "Your request cannot be less than 5 characters long.");
        return 1;
    }

    if(strlen(params) > 128)
    {
        SendErrorMessage(playerid, "Your request is too long, it must be less than 128 characters.");
        return 1;
    }

    SendHelpme(playerid, params);
    SendServerMessage(playerid, "Your request was sent to all online helpers.");
    return 1;
}
alias:helpme("ask", "request", "requesthelp", "newbie", "newb");

CMD:hmabuse(playerid, params[])
{
    if(Player[playerid][HelperLevel] >= 1 || Player[playerid][AdminLevel] >= 4)
    {
        new targetID;
        if(sscanf(params, "u", targetID))
            return SendUsageMessage(playerid, "/hmabuse [PlayerID/PartOfName]");

        if(IsPlayerConnected(targetID))
        {
            if(Player[targetID][AdminLevel] > 0 || Player[targetID][HelperLevel] > 0)
                return SendErrorMessage(playerid, "You cannot do this to staff members.");

            if(Player[targetID][HelpmeMuted] == 0)
            {
                new logString[256];
                if(Player[playerid][HelpmeMutes] == 0)
                {
                    Player[playerid][HelpmeMutes] = 1;
                    SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has warned %s for abusing /helpme.", GetStaffRank(playerid), GetMasterName(playerid), GetUserName(targetID));

                    Dialog_Show(targetID, HelpmeWarning, DIALOG_STYLE_MSGBOX, "Abuse Warning", "You have recieved a warning from a staff member about abusing /helpme.\n\
                    Future abuse could result in losing access to /helpme altogether.\n\
                    Next time you abuse this feature will result in a 60 minute mute.", "Understood", "");

                    format(logString, sizeof logString, "%s (IP: %s AccountID: %s) was warned by %s %s (IP: %s AccountID: %s) for abusing /helpme.", GetUserName(targetID), GetUserIP(targetID), Player[targetID][ID],
                        GetStaffRank(playerid), GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                    DBLog("HMWarn", logString);
                }
                else if(Player[playerid][HelpmeMutes] == 1)
                {
                    Player[playerid][HelpmeMutes] = 2;
                    Player[playerid][HelpmeMuted] = 60*60;
                    SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has blocked %s for abusing /helpme.", GetStaffRank(playerid), GetMasterName(playerid), GetUserName(targetID));

                    Dialog_Show(targetID, HelpmeWarning, DIALOG_STYLE_MSGBOX, "Abuse Warning", "You have been blocked from using /helpme for 60 minutes due to abuse.\n\
                    Future abuse will result in you losing access to the feature altogether.", "Understood", "");

                    format(logString, sizeof logString, "%s (IP: %s AccountID: %s) was blocked for 60 min by %s %s (IP: %s AccountID: %s) for abusing /helpme.", GetUserName(targetID), GetUserIP(targetID), Player[targetID][ID],
                        GetStaffRank(playerid), GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                    DBLog("HMWarn", logString);
                }
                else if(Player[playerid][HelpmeMutes] == 2)
                {
                    Player[playerid][HelpmeMutes] = 3;
                    Player[playerid][HelpmeMuted] = 120*60;
                    SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has blocked %s for abusing /helpme.", GetStaffRank(playerid), GetMasterName(playerid), GetUserName(targetID));

                    Dialog_Show(targetID, HelpmeWarning, DIALOG_STYLE_MSGBOX, "Abuse Warning", "You have been blocked from using /helpme for 120 minutes due to abuse.\n\
                    Future abuse will result in you losing access to the feature altogether.", "Understood", "");

                    format(logString, sizeof logString, "%s (IP: %s AccountID: %s) was blocked for 120 min by %s %s (IP: %s AccountID: %s) for abusing /helpme.", GetUserName(targetID), GetUserIP(targetID), Player[targetID][ID],
                        GetStaffRank(playerid), GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                    DBLog("HMWarn", logString);
                }
                else if(Player[playerid][HelpmeMutes] == 3)
                {
                    Player[playerid][HelpmeMutes] = 4;
                    SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has permanently blocked %s for abusing /helpme.", GetStaffRank(playerid), GetMasterName(playerid), GetUserName(targetID));

                    Dialog_Show(targetID, HelpmeWarning, DIALOG_STYLE_MSGBOX, "Abuse Warning", "You have been permanently blocked from using /helpme.\n\
                    In order to be able to use /helpme again, you must post a Ban Appeal on the forums.", "Understood", "");

                    format(logString, sizeof logString, "%s (IP: %s AccountID: %s) was permanently blocked by %s %s (IP: %s AccountID: %s) for abusing /helpme.", GetUserName(targetID), GetUserIP(targetID), Player[targetID][ID],
                        GetStaffRank(playerid), GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                    DBLog("HMWarn", logString);
                }
            }
            else SendErrorMessage(playerid, "This player is already blocked from /helpme.");
        }
    }
    return 1;
}

CMD:hmunmute(playerid, params[])
{
    if(Player[playerid][HelperLevel] >= 1 || Player[playerid][AdminLevel] >= 4)
    {
        new targetID;
        if(sscanf(params, "u", targetID))
            return SendUsageMessage(playerid, "/hmunmute [PlayerID/PartOfName]");

        if(IsPlayerConnected(targetID))
        {
            if(Player[targetID][HelpmeMutes] >= 2)
            {
                new logString[256];
                Player[targetID][HelpmeMutes]--;
                Player[targetID][HelpmeMuted] = 0;

                SendHelperMessage(COLOR_LIGHTRED, 1, "[Helper] %s %s has unblocked %s from /helpme.", GetStaffRank(playerid), GetMasterName(playerid), GetUserName(targetID));
                SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "You have been unblocked from /helpme.");

                format(logString, sizeof logString, "%s (IP: %s AccountID: %s) was unblocked from /helpme %s %s (IP: %s AccountID: %s).", GetUserName(targetID), GetUserIP(targetID), Player[targetID][ID],
                    GetStaffRank(playerid), GetMasterName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                DBLog("HMWarn", logString);
            }
            else SendErrorMessage(playerid, "This player is not blocked from /helpme.");
        }
    }
    return 1;
}

CMD:cancelrequest(playerid, params[])
{
    new bool:helpme;
    for(new i = 1; i < sizeof(RequestInfo); i++)
    {
        if(RequestInfo[i][RequestExists] == true && RequestInfo[i][RequestBy] == playerid)
        {
            helpme = true;
            RequestInfo[i][RequestExists] = false;
        }
    }
    if(helpme)
    {
        TempVar[playerid][SentHelpme] = 0;
        SendClientMessage(playerid, COLOR_YELLOW, "[SYSTEM] {FFFFFF}Your request(s) have been withdrawn.");
    }
    else
    {
        SendErrorMessage(playerid, "You do not have any active requests.");
    }
    return 1;
}

stock SendHelpme(playerid, helpme[])
{
    for(new i = 1; i < sizeof(RequestInfo); i++)
    {
        if(RequestInfo[i][RequestExists] == false)
        {
            RequestInfo[i][RequestExists] = true;
            RequestInfo[i][RequestTime] = gettime();
            RequestInfo[i][RequestBy] = playerid;
            format(RequestInfo[i][RequestDetails], 128, "%s", helpme);

            if(strlen(helpme) > 70)
            {
                SendHelperMessage(COLOR_LIGHTRED, 1, "[REQUEST: %d] {%06x}%s (%d): %.70s", i, COLOR_LIGHTBLUE >>> 8, GetUserName(playerid), playerid, helpme);
                SendHelperMessage(COLOR_LIGHTRED, 1, "[REQUEST: %d] {%06x}...%s", i, COLOR_LIGHTBLUE >>> 8, helpme[70]);
            }
            else SendHelperMessage(COLOR_LIGHTRED, 1, "[REQUEST: %d] {%06x}%s (%d): %s", i, COLOR_LIGHTBLUE >>> 8, GetUserName(playerid), playerid, helpme);

            TempVar[playerid][SentHelpme] = gettime();
            return 1;
        }
    }
    SendErrorMessage(playerid, "Your request cannot be handled at the moment, please try again later.");
    return 1;
}