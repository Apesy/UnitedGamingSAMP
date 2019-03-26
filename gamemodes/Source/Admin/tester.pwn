//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
#define COLOR_TESTER 0x089DCEFF //0xF19CBBFF

CMD:testerhelp(playerid, params[])
{
    if(Player[playerid][BetaTester] >= 1 || Player[playerid][AdminLevel] >= 5)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_WHITE, "Beta Tester Help: Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /st (staff chat), /bt (tester chat), /appcheck");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    else SendErrorMessage(playerid, "You are not a beta tester.");
    return 1;
}

stock SendTesterMessage(color, level, const str[], {Float,_}:...)
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
            if(Player[i][BetaTester] >= level || Player[i][AdminLevel] >= 5)
			{
                SendClientMessage(i, color, string);
            }
		}
		return 1;
	}
	foreach (new i : Player)
    {
        if(Player[i][BetaTester] >= level || Player[i][AdminLevel] >= 5)
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

CMD:testers(playerid, params[])
{
    new bool:testersOnline = false, string[1024];
    foreach(new i: Player)
    {
        if(Player[i][BetaTester] >= 1) testersOnline = true;
    }

    if(testersOnline == true)
    {
        foreach(new i: Player)
        {
            if(Player[i][BetaTester] >= 1)
            {
                format(string, sizeof string, "%s{FFFFFF}%s (%s)\n", string, GetUserName(i), GetMasterName(i));
            }
        }
    }
    else
    {
        format(string, sizeof string, "{FFFFFF}There are no beta testers online.");
    }
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Beta Testing Team", string, "Okay", "");
    return 1;
}

CMD:bt(playerid, params[])
{
    if(Player[playerid][BetaTester] >= 1 || Player[playerid][AdminLevel] >= 5)
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/bt [beta tester chat]");
            return 1;
        }

        if(TempVar[playerid][Muted] == true)
		    return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        if(strlen(params) > 70)
        {
            SendTesterMessage(COLOR_TESTER, 1, "* [TESTER] %s (%s): %.70s ...", GetUserName(playerid), GetMasterName(playerid), params);
            SendTesterMessage(COLOR_TESTER, 1, "* [TESTER] %s (%s): ... %s", GetUserName(playerid), GetMasterName(playerid), params[70]);
        }
        else
        {
            SendTesterMessage(COLOR_TESTER, 1, "* [TESTER] %s (%s): %s", GetUserName(playerid), GetMasterName(playerid), params);
        }
        new logString[256];
        format(logString, sizeof(logString), "%s (IP: %s AccountID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], params);
        WriteLog("Logs/Betatesterchat.log", logString);
    }
    return 1;
}

CMD:settester(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new targetID;
        if(sscanf(params, "u", targetID))
            return SendUsageMessage(playerid, "/settester [PlayerID/PartOfName]");

        if(!IsPlayerConnected(targetID))
            return SendErrorMessage(playerid, "Invalid PlayerID/PartOfName specified.");

        if(Player[targetID][BetaTester] == 0)
        {
            Player[targetID][BetaTester] = 1;
            SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been made a beta tester by %s.", GetMasterName(playerid));
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have made %s a beta tester.", GetMasterName(targetID));
        }
        else
        {
            Player[targetID][BetaTester] = 0;
            SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been removed as a beta tester by %s.", GetMasterName(playerid));
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have removed %s as a beta tester.", GetMasterName(targetID));
        }
        UpdatePlayerData(targetID);
    }
    return 1;
}