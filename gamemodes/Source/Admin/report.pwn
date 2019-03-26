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

#define EXPIRE_MINUTES 5
#define COLOR_REPORT 0xFFFF91FF

enum rInfo
{
    bool:ReportExists,
    ReportDetails[128],
    ReportTime,
    ReportBy,
    ReportExpireTimer,
}
new ReportInfo[MAX_REPORTS][rInfo];

hook OnGameModeInit()
{
    for(new i; i < MAX_REPORTS; i++)
    {
        ResetReport(i);
    }
    return 1;
}

stock ResetReport(reportid)
{
    ReportInfo[reportid][ReportExists] = false;
    ReportInfo[reportid][ReportDetails][0] = 0;
    ReportInfo[reportid][ReportTime] = 0;
    ReportInfo[reportid][ReportBy] = INVALID_PLAYER_ID;
    ReportInfo[reportid][ReportExpireTimer] = 0;
}

stock ActiveReportWarning()
{
    new reportCount = 0, string[128];
    for(new i = 1; i < sizeof(ReportInfo); i++)
    {
        if(ReportInfo[i][ReportExists] == true)
        {
            reportCount++;
        }
    }
    if(reportCount >= 1)
    {
        format(string, sizeof string, "There %s %d active %s. See /reports.", (reportCount == 1) ? ("is") : ("are"), reportCount, (reportCount == 1) ? ("report") : ("reports"));
        SendAdminWarning(1, string);
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    new bool:reportActive, reports = 0;
	for(new i = 1; i < sizeof(ReportInfo); i++)
    {
        if(ReportInfo[i][ReportExists] == true && ReportInfo[i][ReportBy] == playerid)
        {
            reports++;
            reportActive = true;
            ResetReport(i);
        }
    }

	if(reportActive == true)
	{
        SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: %s (%s) has left the server with %d pending report(s).", GetUserName(playerid), GetMasterName(playerid), reports);
	}
	reportActive = false;
    return 1;
}

CMD:clearreports(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new reportCount = 0;
	
        for (new i = 0; i < sizeof(ReportInfo); i ++)
        {
            if(ReportInfo[i][ReportExists] == true)
            {
                reportCount++;
            }
        }
        if(reportCount)
        {
            Dialog_Show(playerid, DIALOG_CLEAR_REPORTS, DIALOG_STYLE_MSGBOX, "Clear Reports", "You are about to clear all reports!\nAre you sure about this?", "Confirm", "Cancel");
        }
        else return SendErrorMessage(playerid, "There are no active reports to clear.");
    }
    return 1;
}

Dialog:DIALOG_CLEAR_REPORTS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new reports, string[128];
        for (new i = 0; i < sizeof(ReportInfo); i ++)
        {
            if(ReportInfo[i][ReportExists] == true)
            {
                reports++;
                ResetReport(i);
            }
        }
        
        format(string, sizeof string, "%s %s has cleared %d %s.", GetAdminRank(playerid), GetUserName(playerid), reports, (reports > 1) ? ("reports") : ("report"));
        SendAdminCommandEx(COLOR_ORANGE, string, 1);
    }
    else return SendClientMessage(playerid, COLOR_LIGHTRED, "[SYSTEM] {FFFFFF}You cancelled the confirmation.");
    return 1;
}

CMD:dr(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/dr (disregard report) [report id]"); 
        
        if(ReportInfo[reportid][ReportExists] == false)
            return SendErrorMessage(playerid, "The report ID you specified doesn't exist.");
        
        SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: %s %s has disregarded report %d from %s (ID: %d).", GetAdminRank(playerid), GetMasterName(playerid), reportid, GetUserName(ReportInfo[reportid][ReportBy]), ReportInfo[reportid][ReportBy]);
        SendClientMessageEx(ReportInfo[reportid][ReportBy], COLOR_RED, "%s %s (%s) has disregarded your report.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid));

        ResetReport(reportid);
    }
    return 1;
}

CMD:ar(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/ar (accept report) [report id]"); 
        
        if(ReportInfo[reportid][ReportExists] == false)
            return SendErrorMessage(playerid, "The report ID you specified doesn't exist.");
            
        SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: %s %s has accepted report %d from %s (ID: %d).", GetAdminRank(playerid), GetMasterName(playerid), reportid, GetUserName(ReportInfo[reportid][ReportBy]), ReportInfo[reportid][ReportBy]);

        SendClientMessageEx(ReportInfo[reportid][ReportBy], COLOR_GREEN, "%s %s (%s) has accepted your report.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid));

        ResetReport(reportid);
    }
    return 1;
}

CMD:sth(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new reportid;
	
        if (sscanf(params, "d", reportid))
            return SendUsageMessage(playerid, "/sth (send to helpers) [report id]"); 
        
        if(ReportInfo[reportid][ReportExists] == false)
            return SendErrorMessage(playerid, "The report ID you specified doesn't exist.");
            
        SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: %s %s has sent report %d from %s (ID: %d) to community helpers.", GetAdminRank(playerid), GetMasterName(playerid), reportid, GetUserName(ReportInfo[reportid][ReportBy]), ReportInfo[reportid][ReportBy]);
        SendClientMessageEx(ReportInfo[reportid][ReportBy], COLOR_GREEN, "%s %s (%s) has sent your report to community helpers.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid));

        SendHelpme(ReportInfo[reportid][ReportBy], ReportInfo[reportid][ReportDetails]);

        ResetReport(reportid);
    }
    return 1;
}

CMD:reports(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new bool:count = false;
        SendClientMessage(playerid, COLOR_GREEN, "____________________ REPORTS _____________________");
        for(new i = MAX_REPORTS-1; i >= 0; i--)
        {
            if(ReportInfo[i][ReportExists] == true)
            {
                count = true;
                if(strlen(ReportInfo[i][ReportDetails]) > 70)
                {
                    SendClientMessageEx(playerid, COLOR_WHITE, "%s(%d) | RID: %d | Report: %.70s", GetUserName(ReportInfo[i][ReportBy]), ReportInfo[i][ReportBy], i, ReportInfo[i][ReportDetails]);
                    SendClientMessageEx(playerid, COLOR_WHITE, "...%s | Pending: %d Sec ago", ReportInfo[i][ReportDetails][70], gettime() - ReportInfo[i][ReportTime]);
                }
                else SendClientMessageEx(playerid, COLOR_WHITE, "%s(%d) | RID: %d | Report: %s | Pending: %d Sec ago", GetUserName(ReportInfo[i][ReportBy]), ReportInfo[i][ReportBy], i, ReportInfo[i][ReportDetails], gettime() - ReportInfo[i][ReportTime]);
            }
        }
        if(count == true)
        {
            SendClientMessage(playerid, COLOR_GREY, "* Use /ar or /dr to respond to a report.");
        }
        else
        {
            SendErrorMessage(playerid, "No active reports found.");
        }
        SendClientMessage(playerid, COLOR_GREEN, "___________________________________________________");
    }
    return 1;
}

CMD:report(playerid, params[])
{
    if(gettime() - TempVar[playerid][SentReport] < 10)
    {
        SendErrorMessage(playerid, "You already sent a report. Please wait %i more seconds.", 10 - (gettime() - TempVar[playerid][SentReport]));
        return 1;
    }

    if(Player[playerid][AdminLevel] >= 1 && Player[playerid][AdminLevel] < 4) 
		return SendErrorMessage(playerid, "You can't submit reports as an administrator.");

    if(isnull(params))
    {
        SendUsageMessage(playerid, "/(re)port [message]");
        return 1;
    }

    if(strlen(params) < 2)
        return SendErrorMessage(playerid, "Your report cannot be less than 2 characters long.");

    if(strlen(params) > 128)
        return SendErrorMessage(playerid, "Your report is too long, it must be less than 128 characters.");

    if(SendReport(playerid, params) != 0)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Your report was sent to all online administrators.");
    }
    return 1;
}
alias:report("re");

CMD:cancelreport(playerid,  params[])
{
    new bool:report;
    for(new i = 1; i < sizeof(ReportInfo); i++)
    {
        if(ReportInfo[i][ReportExists] == true && ReportInfo[i][ReportBy] == playerid)
        {
            report = true;
            ReportInfo[i][ReportExists] = false;
        }
    }
    if(report)
    {
        TempVar[playerid][SentReport] = 0;
        SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: %s (ID: %d) has withdrawn their report (%d).", GetUserName(ReportInfo[reportid][ReportBy]), ReportInfo[reportid][ReportBy], reportid);
        SendClientMessage(playerid, COLOR_YELLOW, "[SYSTEM] {FFFFFF}Your report(s) have been withdrawn.");
    }
    else
    {
        SendErrorMessage(playerid, "You do not have any active reports.");
    }
    return 1;
}

function ReportExpiry(reportid)
{
    if(ReportInfo[reportid][ReportExists] == true)
    {
        if(IsPlayerConnected(ReportInfo[reportid][ReportBy]))
        {
            SendAdminMessage(COLOR_ORANGE, 1, "[REPORT]: Report %d by %s (%s) has expired.", reportid, GetUserName(ReportInfo[reportid][ReportBy]), GetMasterName(ReportInfo[reportid][ReportBy]));
            SendClientMessage(ReportInfo[reportid][ReportBy], COLOR_WHITE, "Your report has expired, please go to \"https://dc-rp.com/\" if the issue still needs to be resolved.");
        }
        ResetReport(reportid);
    }
    return 1;
}

stock SendReport(playerid, report[])
{
    if(strfind(report, "refund", true) != -1)
    {
        SendErrorMessage(playerid, "Refunds cannot be handled via the report system.");
        return 0;
    }

    for(new i = 1; i < sizeof(ReportInfo); i++)
    {
        if(ReportInfo[i][ReportExists] == false)
        {
            ReportInfo[i][ReportExists] = true;
            ReportInfo[i][ReportTime] = gettime();
            ReportInfo[i][ReportBy] = playerid;
            format(ReportInfo[i][ReportDetails], 128, "%s", report);
            ReportInfo[i][ReportExpireTimer] = SetTimerEx("ReportExpiry", (1000*60)*EXPIRE_MINUTES, false, "d", i);

            if(strlen(report) > 70)
            {
                SendAdminMessage(COLOR_REPORT, 1, "[Report: %d] %s(%d) reported: %.70s ...", i, GetUserName(playerid), playerid, report);
                SendAdminMessage(COLOR_REPORT, 1, "[Report: %d] ... %s", i, report[70]);
            }
            else SendAdminMessage(COLOR_REPORT, 1, "[Report: %d] %s(%d) reported: %s", i, GetUserName(playerid), playerid, report);
            
            new logString[256];
            format(logString, sizeof logString, "[Report: %d] %s(%d) reported: %s", i, GetUserName(playerid), playerid, report);
            WriteLog("Logs/Report.log", logString);
    
            if(strfind(report, "hax", true) != -1 || strfind(report, "hack", true) != -1 || strfind(report, "cheat", true) != -1)
            {
                new string[37+1];
                format(string, sizeof(string), "~y~~h~Hacker Report~n~~w~See RID %d", i);
                foreach(new p : Player)
                {
                    if(Player[p][AdminLevel] >= 1) 
                    {
                        PrintFooter(p, string, 4);
                    }
                }
            }

            TempVar[playerid][SentReport] = gettime();
            return 1;
        }
    }
    SendErrorMessage(playerid, "Your report cannot be handled at the moment, please send it on the forums.");
    return 0;
}