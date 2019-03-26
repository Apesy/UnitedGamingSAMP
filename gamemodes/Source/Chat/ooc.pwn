//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

function SendPrivateMessage(playerid, playerb, text[])
{
	new string[128];
	if(TempVar[playerid][AdminDuty] == true)
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "<< PM from {00FF00}%s{%06x} (ID: %d): %s", GetUserName(playerid), COLOR_PMRECEIVED >>> 8, playerid, text);
		
		if(TempVar[playerb][AdminDuty] == false)
		{
			SendClientMessageEx(playerid, COLOR_PMSENT, ">> PM sent to %s (ID: %d): %s", GetUserName(playerb), playerb, text);
		}	
		else SendClientMessageEx(playerid, COLOR_PMSENT, ">> PM sent to {00FF00}%s{%06x} (ID: %d): %s", GetUserName(playerb), COLOR_PMSENT >>> 8, playerb, text);
	}
	else
	{
		if(TempVar[playerb][AdminDuty] == true)
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "<< PM from %s (ID: %d): %s", GetUserName(playerid), playerid, text);
			SendClientMessageEx(playerid, COLOR_PMSENT, ">> PM sent to {00FF00}%s{%06x} (ID: %d): %s", GetUserName(playerb), COLOR_PMSENT >>> 8, playerb, text);
		}
		else
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "<< PM from %s (ID: %d): %s", GetUserName(playerid), playerid, text);
			SendClientMessageEx(playerid, COLOR_PMSENT, ">> PM sent to %s (ID: %d): %s", GetUserName(playerb), playerb, text);
		}
	}

	foreach (new i : Player)
    {
		if(playerid != i && playerb != i)
		{
			if (Player[i][IsLoggedIn] == true)
			{
				if (Player[i][AdminLevel] >= 2)
				{
					if (TempVar[i][WatchingPM] == playerb)
					{
						SendClientMessageEx(i, COLOR_YELLOW, "[PM] %s (%d) to %s (%d): %s", GetUserName(playerid), playerid, GetUserName(playerb), playerb, text);
					}
				}
			}
		}
    }

	format(string, sizeof string, "%s (%s) to %s (%s): %s", GetUserName(playerid), GetUserIP(playerid), GetUserName(playerb), GetUserIP(playerb), text);
	DBLog("PM", string);
	PM_Log(playerid, playerb, text);
}

CMD:pm(playerid, params[])
{
	new
		playerb,
		text[144]
	;
		
	if(sscanf(params, "us[144]", playerb, text))
		return SendUsageMessage(playerid, "/pm [playerid OR name] [text]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
	
	if(playerb == playerid)
		return SendErrorMessage(playerid, "You cannot PM yourself.");
	
	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(TempVar[playerb][PMDisabled] == true && Player[playerid][AdminLevel] < 1)
		return SendErrorMessage(playerid, "This person has disabled private messages.");

	if(BlockedPM[playerid][playerb] == true)
		return SendErrorMessage(playerid, "You have blocked this person.");

	if(BlockedPM[playerb][playerid] == true && Player[playerid][AdminLevel] < 1)
		return SendErrorMessage(playerid, "This person has blocked you.");

	if(Player[playerb][AdminLevel] >= 5 && Player[playerid][AdminLevel] < 1 && gettime() - TempVar[playerid][PMWarningTime] >= 60)
	{
		TempVar[playerid][PMWarningID] = playerb;
		format(TempVar[playerid][PMWarningMSG], 144, "%s", text);
		Dialog_Show(playerid, AdminPMWarning, DIALOG_STYLE_MSGBOX, "Management Warning", "Server Management is usually busy and you should not PM them with unimportant or meaningless messages.\n\
		Remember that PMing on duty administrators regarding admin work is against the rules can result in being kicked.\n\
		Are you sure you wish to send this PM?", "Yes", "No");
		return 1;
	}

	if(Player[playerb][AdminLevel] >= 4 && Player[playerid][AdminLevel] < 1 && gettime() - TempVar[playerid][PMWarningTime] >= 60)
	{
		TempVar[playerid][PMWarningID] = playerb;
		format(TempVar[playerid][PMWarningMSG], 144, "%s", text);
		Dialog_Show(playerid, AdminPMWarning, DIALOG_STYLE_MSGBOX, "Lead Administrator Warning", "Lead Administrators are usually busy and you should not PM them with unimportant or meaningless messages.\n\
		Remember that PMing on duty administrators regarding admin work is against the rules can result in being kicked.\n\
		Are you sure you wish to send this PM?", "Yes", "No");
		return 1;
	}

	if(Player[playerb][AdminLevel] >= 1 && Player[playerid][AdminLevel] < 1 && gettime() - TempVar[playerid][PMWarningTime] >= 60)
	{
		TempVar[playerid][PMWarningID] = playerb;
		format(TempVar[playerid][PMWarningMSG], 144, "%s", text);
		Dialog_Show(playerid, AdminPMWarning, DIALOG_STYLE_MSGBOX, "Administrator Warning", "Administrators are usually busy and you should use /report (/re) or /helpme instead.\n\
		Remember that PMing on duty administrators regarding admin work is against the rules can result in being kicked.\n\
		Are you sure you wish to send this PM?", "Yes", "No");
		return 1;
	}

	SendPrivateMessage(playerid, playerb, text);
	return 1;
}

Dialog:AdminPMWarning(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SendPrivateMessage(playerid, TempVar[playerid][PMWarningID], TempVar[playerid][PMWarningMSG]);
		TempVar[playerid][PMWarningTime] = gettime();
	}
	return 1;
}

stock SendAMe(playerid, emote[])
{
	new str[128], time = strlen(emote)*100;
	if(time < 10000)
	{
		time = 10000;
	}
	format (str, sizeof(str), "* %s %s", GetRPName(playerid), emote);
	SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, time);
}

stock SendMe(playerid, emote[], Float:range = 20.0)
{
	if(strlen(emote) > 86)
	{
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %s %.86s", GetRPName(playerid), emote); 
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* ...%s (( %s ))", emote[86], GetRPName(playerid));
	}
	else SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %s %s", GetRPName(playerid), emote);
}

CMD:aooc(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
		if(isnull(params))
		{
			SendUsageMessage(playerid, "/(ao)oc [global ooc message]");
			return 1;
		}

		if(TempVar[playerid][Muted] == true)
			return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        if(strlen(params) > 70)
        {
            SendClientMessageToAllEx(COLOR_ORANGE, "(( %s %s (%s): %.70s ... ))", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
            SendClientMessageToAllEx(COLOR_ORANGE, "(( %s %s (%s): ... %s ))", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params[70]);
        }
        else SendClientMessageToAllEx(COLOR_ORANGE, "(( %s %s (%s): %s ))", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
		OOC_Log(playerid, params);
    }
    return 1;
}
alias:aooc("ao");

CMD:ooc(playerid, params[])
{
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/(o)oc [global ooc message]");
        return 1;
    }

    if(ServerInfo[OOCEnabled] == false && Player[playerid][AdminLevel] < 1)
    {
        SendErrorMessage(playerid, "Global OOC chat is not enabled.");
        return 1;
    }

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(gettime() - TempVar[playerid][LastGlobal] < 3)
		return SendErrorMessage(playerid, "You can only speak in this channel every 3 seconds. Please wait %i more seconds.", 3 - (gettime() - TempVar[playerid][LastGlobal]));

    if(strlen(params) > 70)
    {
        SendGlobalOOC(COLOR_OOC, "(( %s (%s): %.70s ... ))", GetUserName(playerid), GetMasterName(playerid), params);
        SendGlobalOOC(COLOR_OOC, "(( %s (%s): ... %s ))", GetUserName(playerid), GetMasterName(playerid), params[70]);
    }
    else SendGlobalOOC(COLOR_OOC, "(( %s (%s): %s ))", GetUserName(playerid), GetMasterName(playerid), params);
	OOC_Log(playerid, params);

	if(Player[playerid][AdminLevel] < 1)
	{
		TempVar[playerid][LastGlobal] = gettime();
	}
    return 1
}
alias:ooc("o");

CMD:blow(playerid, params[])
{
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/blow [low ooc message]");
        return 1;
    }

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
	{
		SendBMessage(playerid, params, 20.0);
	}
    else SendBMessage(playerid, params, 10.0);
    return 1;
}

stock SendBMessage(playerid, params[], Float:radi = 20.0)
{
	if (Player[playerid][IsLoggedIn] == false)
		return 0;

	new
		Float:currentPos[3], 
		Float:oldPos[3],
		Float:checkPos[3]
	;
		
	GetPlayerPos(playerid, oldPos[0], oldPos[1], oldPos[2]); 
	foreach (new i : Player)
	{
		if (Player[i][IsLoggedIn] == false) continue; 
		
		GetPlayerPos(i, currentPos[0], currentPos[1], currentPos[2]); 
		for (new p = 0; p < 3; p++)
		{
			checkPos[p] = (oldPos[p] - currentPos[p]);  
		}
		
		if (GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
			continue;
			
		if (((checkPos[0] < radi/16) && (checkPos[0] > -radi/16)) && ((checkPos[1] < radi/16) && (checkPos[1] > -radi/16)) && ((checkPos[2] < radi/16) && (checkPos[2] > -radi/16)))
		{
			if(TempVar[playerid][AdminDuty] == true && Player[playerid][AdminLevel] >= 1)
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: %.76s ... ))", playerid, GetMasterName(playerid), COLOR_GREY >>> 8, params);
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: ... %s ))", playerid, GetMasterName(playerid), COLOR_GREY >>> 8, params[76]);
				}
				else SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: %s ))", playerid, GetMasterName(playerid), COLOR_GREY >>> 8, params);
			}
			else
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: %.76s ... ))", playerid, GetUserName(playerid), params);
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: ... %s ))", playerid, GetUserName(playerid), params[76]);
				}
				else SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: %s ))", playerid, GetUserName(playerid), params);
			}
		}
		else if (((checkPos[0] < radi/8) && (checkPos[0] > -radi/8)) && ((checkPos[1] < radi/8) && (checkPos[1] > -radi/8)) && ((checkPos[2] < radi/8) && (checkPos[2] > -radi/8)))
		{
			if(TempVar[playerid][AdminDuty] == true && Player[playerid][AdminLevel] >= 1)
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: %.76s ... ))", playerid, GetUserName(playerid), 0x8C8C8CFF >>> 8, params);
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: ... %s ))", playerid, GetUserName(playerid), 0x8C8C8CFF >>> 8, params[76]);
				}
				else SendClientMessageEx(i, COLOR_GREY, "(( [%d] {00FF00}%s{%06x}: %s ))", playerid, GetUserName(playerid), 0x8C8C8CFF >>> 8, params);
			}
			else
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: %.76s ... ))", playerid, GetUserName(playerid), params);
					SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: ... %s ))", playerid, GetUserName(playerid), params[76]);
				}
				else SendClientMessageEx(i, COLOR_GREY, "(( [%d] %s: %s ))", playerid, GetUserName(playerid), params);
			}
		}
		else if (((checkPos[0] < radi/4) && (checkPos[0] > -radi/4)) && ((checkPos[1] < radi/4) && (checkPos[1] > -radi/4)) && ((checkPos[2] < radi/4) && (checkPos[2] > -radi/4)))
		{
			if(TempVar[playerid][AdminDuty] == true && Player[playerid][AdminLevel] >= 1)
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] {00FF00}%s{%06x}: %.76s ... ))", playerid, GetUserName(playerid), 0x696969FF >>> 8, params);
					SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] {00FF00}%s{%06x}: ... %s ))", playerid, GetUserName(playerid), 0x696969FF >>> 8, params[76]);
				}
				else SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] {00FF00}%s{%06x}: %s ))", playerid, GetUserName(playerid), 0x696969FF >>> 8, params);
			}
			else
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] %s: %.76s ... ))", playerid, GetUserName(playerid), params);
					SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] %s: ... %s ))", playerid, GetUserName(playerid), params[76]);
				}
				else SendClientMessageEx(i, 0x8C8C8CFF, "(( [%d] %s: %s ))", playerid, GetUserName(playerid), params);
			}
		}
		else if (((checkPos[0] < radi/2) && (checkPos[0] > -radi/2)) && ((checkPos[1] < radi/2) && (checkPos[1] > -radi/2)) && ((checkPos[2] < radi/2) && (checkPos[2] > -radi/2)))
		{
			if(TempVar[playerid][AdminDuty] == true && Player[playerid][AdminLevel] >= 1)
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, 0x696969FF, "(( [%d] {00FF00}%s{%06x}: %.76s ... ))", playerid, GetUserName(playerid), 0x545454FF >>> 8, params);
					SendClientMessageEx(i, 0x696969FF, "(( [%d] {00FF00}%s{%06x}: ... %s ))", playerid, GetUserName(playerid), 0x545454FF >>> 8, params[76]);
				}
				else SendClientMessageEx(i, 0x696969FF, "(( [%d] {00FF00}%s{%06x}: %s ))", playerid, GetUserName(playerid), 0x545454FF >>> 8, params);
			}
			else
			{
				if(strlen(params) > 76)
				{
					SendClientMessageEx(i, 0x696969FF, "(( [%d] %s: %.76s ... ))", playerid, GetUserName(playerid), params);
					SendClientMessageEx(i, 0x696969FF, "(( [%d] %s: ... %s ))", playerid, GetUserName(playerid), params[76]);
				}
				else SendClientMessageEx(i, 0x696969FF, "(( [%d] %s: %s ))", playerid, GetUserName(playerid), params);
			}
		}	
	}
	OOC_Log(playerid, params);
	return 1;
}

CMD:cb(playerid, params[])
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/cb [OOC Message]");
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vid = GetPlayerVehicleID(playerid);
		foreach(new i: Player)
		{
			if(GetPlayerVehicleID(i) == vid)
			{
				if(strlen(params) > 70)
				{
					SendClientMessageEx(playerid, COLOR_YELLOW, "(( [%d] %s: %.70s ))", playerid, GetUserName(playerid), params);
					SendClientMessageEx(playerid, COLOR_YELLOW, "(( [%d] %s: ... %s ))", playerid, params[70]);
				}
				else SendClientMessageEx(playerid, COLOR_YELLOW, "(( [%d] %s: %s ))", playerid, GetUserName(playerid), params);
			}
		}
	}
	else SendErrorMessage(playerid, "You need to be in a vehicle to use this.");
	return 1;
}