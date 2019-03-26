//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:ann(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
		if(isnull(params))
		{
			SendUsageMessage(playerid, "/ann [Global Announcement]");
			return 1;
		}

		if(TempVar[playerid][Muted] == true)
			return SendErrorMessage(playerid, "You cannot speak, you are muted.");
		
		SendAnnouncement(GetMasterName(playerid), params);
    }
    return 1;
}

stock SendAnnouncement(announcer[], text[])
{
	foreach(new i: Player)
	{
		if(IsStaffMember(i, false))
		{
			if(strlen(text) > 70)
			{
				SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: %s: %.70s ...", announcer, text);
				SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: %s: ... %s", announcer, text[70]);
			}
			else SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: %s: %s", announcer, text);
		}
		else
		{
			if(strlen(text) > 70)
			{
				SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: %.70s ...", text);
				SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: ... %s", text[70]);
			}
			else SendClientMessageEx(i, COLOR_ANNOUNCE, "[Announcement]: %s", text);
		}
	}
}

CMD:doorshout(playerid, params[])
{
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/doorshout (/ds) [shout]");
        return 1;
    }

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	new Float:chatRange = 40.0, str[MAX_PLAYER_NAME+10+70+1];

	if(strlen(params) > 70)
    {
        format(str, sizeof(str), "%s shouts (Door): %.70s", GetRPName(playerid), params);
        LocalChat(playerid, chatRange, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
    
        format(str, sizeof(str), "%s shouts (Door): ... %s", GetRPName(playerid), params[70]);
        LocalChat(playerid, chatRange, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
    }
    else
    {
        format(str, sizeof(str), "%s shouts (Door): %s", GetRPName(playerid), params);
        LocalChat(playerid, chatRange, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
    }

    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

			foreach(new p: Player)
			{
				if(IsPlayerInRangeOfPoint(p, chatRange, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
				{
					if(GetPlayerInterior(p) != HouseInfo[i][HouseInteriorInt])
						continue;
							
					if(GetPlayerVirtualWorld(p) != i)
						continue;

					if(strlen(params) > 70)
					{
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): %.70s ...", GetRPName(playerid), params);
					
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): ... %s", GetRPName(playerid), params[70]);
					}
					else
					{
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): %s", GetRPName(playerid), params);
					}
				}
			}
            return 1;
        }
    }

	for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
				continue;

			foreach(new p: Player)
			{
				if(IsPlayerInRangeOfPoint(p, chatRange, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
				{
					if(GetPlayerInterior(p) != BusinessInfo[i][BizInteriorInt])
						continue;
							
					if(GetPlayerVirtualWorld(p) != i)
						continue;

					if(strlen(params) > 70)
					{
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): %.70s ...", GetRPName(playerid), params);
					
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): ... %s", GetRPName(playerid), params[70]);
					}
					else
					{
						SendClientMessageEx(p, COLOR_FADE1, "%s shouts (Door): %s", GetRPName(playerid), params);
					}
				}
			}
            return 1;
        }
    }
    return 1;
}

CMD:b(playerid, params[])
{
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/b [local ooc message]");
        return 1;
    }

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
	{
		SendBMessage(playerid, params, 40.0);
	}
    else SendBMessage(playerid, params);
    return 1;
}

stock LocalChat(playerid, Float:radi, string[], color1, color2, color3, color4,bool:ignoreme=false)
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
		if(ignoreme == true && i == playerid) continue;
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
			SendClientMessage(i, color1, string);
		}
		else if (((checkPos[0] < radi/8) && (checkPos[0] > -radi/8)) && ((checkPos[1] < radi/8) && (checkPos[1] > -radi/8)) && ((checkPos[2] < radi/8) && (checkPos[2] > -radi/8)))
		{
			SendClientMessage(i, color2, string);
		}
		else if (((checkPos[0] < radi/4) && (checkPos[0] > -radi/4)) && ((checkPos[1] < radi/4) && (checkPos[1] > -radi/4)) && ((checkPos[2] < radi/4) && (checkPos[2] > -radi/4)))
		{
			SendClientMessage(i, color3, string);
		}
		else if (((checkPos[0] < radi/2) && (checkPos[0] > -radi/2)) && ((checkPos[1] < radi/2) && (checkPos[1] > -radi/2)) && ((checkPos[2] < radi/2) && (checkPos[2] > -radi/2)))
		{
			SendClientMessage(i, color4, string);
		}	
	}
	return 1;
}

CMD:cw(playerid, params[])
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/cw [IC Message]");
	
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vid = GetPlayerVehicleID(playerid);
		foreach(new i: Player)
		{
			if(GetPlayerVehicleID(i) == vid)
			{
				if(strlen(params) > 70)
				{
					SendClientMessageEx(i, COLOR_YELLOW, "[VEHICLE]: %s says: %.70s", GetRPName(playerid), params);
					SendClientMessageEx(i, COLOR_YELLOW, "[VEHICLE]: %s says: ... %s", GetRPName(playerid), params[70]);
				}
				else SendClientMessageEx(i, COLOR_YELLOW, "[VEHICLE]: %s says: %s", GetRPName(playerid), params);
			}
		}
	}
	else SendErrorMessage(playerid, "You need to be in a vehicle to use this.");
	return 1;
}

CMD:local(playerid, params[])
{
	if(GetPlayerTeam(playerid) == PLAYER_DEAD || GetPlayerTeam(playerid) == PLAYER_WOUNDED)
		return SendErrorMessage(playerid, "You can't when you are brutally wounded/dead.");
	
	if(isnull(params))
		return SendUsageMessage(playerid, "/(l)ocal [text]");
		
	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new
		str[128]
	;

	if(strfind(params, "lol", true) != -1 || strfind(params, "lmfao", true) != -1 || strfind(params, "noob", true) != -1
		|| strfind(params, "n00b", true) != -1 || strfind(params, "1337", true) != -1 || strfind(params, "brb", true) != -1
		|| strfind(params, "btw", true) != -1  || strfind(params, "g2g", true) != -1 || strfind(params, "gtg", true) != -1
		|| strfind(params, "pce", true) != -1  || strfind(params, "omg", true) != -1 || strfind(params, "gr8", true) != -1)
	{
		ExecuteAcronymAction(playerid, params);
	}

	new accentStr[64];
	if(strlen(PlayerInfo[playerid][pAccent]) > 0)
	{
		format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
	}

	if(strlen(params) > 81)
	{
		format(str, sizeof(str), "%s says%s: %.81s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	
		format(str, sizeof(str), "%s says%s: ... %s", GetRPName(playerid), accentStr, params[81]);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
	else
	{
		format(str, sizeof(str), "%s says%s: %s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
	SetPlayerChatBubble(playerid, params, COLOR_FADE1, 10.0, strlen(params)*100);

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && TempVar[playerid][Handcuffed] == false && LoopAnim[playerid] == false)
	{
		new randStyle = random(9);
		switch(randStyle)
		{
			case 1: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkA", params);
			case 2: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkB", params);
			case 3: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkC", params);
			case 4: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkD", params);
			case 5: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkE", params);
			case 6: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkF", params);
			case 7: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkG", params);
			case 8: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkH", params);
			default: ApplyChatAnimation(playerid, "PED", "IDLE_CHAT", params);
		}
	}
	IC_Log(playerid, params);
	return 1;
}
alias:local("l");

CMD:talk(playerid, params[])
{
	if(GetPlayerTeam(playerid) == PLAYER_DEAD || GetPlayerTeam(playerid) == PLAYER_WOUNDED)
		return SendErrorMessage(playerid, "You can't when you are brutally wounded/dead.");
	
	if(isnull(params))
		return SendUsageMessage(playerid, "/(t)alk [text]");
		
	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new
		str[128]
	;

	if(strfind(params, "lol", true) != -1 || strfind(params, "lmfao", true) != -1 || strfind(params, "noob", true) != -1
		|| strfind(params, "n00b", true) != -1 || strfind(params, "1337", true) != -1 || strfind(params, "brb", true) != -1
		|| strfind(params, "btw", true) != -1  || strfind(params, "g2g", true) != -1 || strfind(params, "gtg", true) != -1
		|| strfind(params, "pce", true) != -1  || strfind(params, "omg", true) != -1 || strfind(params, "gr8", true) != -1)
	{
		ExecuteAcronymAction(playerid, params);
	}

	new accentStr[64];
	if(strlen(PlayerInfo[playerid][pAccent]) > 0)
	{
		format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
	}

	if(strlen(params) > 81)
	{
		format(str, sizeof(str), "%s says%s: %.81s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	
		format(str, sizeof(str), "%s says%s: ... %s", GetRPName(playerid), accentStr, params[81]);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
	else
	{
		format(str, sizeof(str), "%s says%s: %s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
	SetPlayerChatBubble(playerid, params, COLOR_FADE1, 10.0, strlen(params)*100);
	IC_Log(playerid, params);
	return 1;
}
alias:talk("t");

CMD:low(playerid, params[])
{
	if(GetPlayerTeam(playerid) == PLAYER_DEAD)
		return SendErrorMessage(playerid, "You can't when you aren't alive.");
	
	if(isnull(params))
		return SendUsageMessage(playerid, "/low [text]");
		
	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new
		str[128],
		Float:chatRange = 6.0
	;

	if(strfind(params, "lol", true) != -1 || strfind(params, "lmfao", true) != -1 || strfind(params, "noob", true) != -1
		|| strfind(params, "n00b", true) != -1 || strfind(params, "1337", true) != -1 || strfind(params, "brb", true) != -1
		|| strfind(params, "btw", true) != -1  || strfind(params, "g2g", true) != -1 || strfind(params, "gtg", true) != -1
		|| strfind(params, "pce", true) != -1  || strfind(params, "omg", true) != -1 || strfind(params, "gr8", true) != -1)
	{
		ExecuteAcronymAction(playerid, params);
	}

	new accentStr[64];
    if(strlen(PlayerInfo[playerid][pAccent]) > 0)
    {
        format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
    }

	if(strlen(params) > 81)
	{
		format(str, sizeof(str), "%s says quietly%s: %.81s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, chatRange, str, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	
		format(str, sizeof(str), "%s says quietly%s: ... %s", GetRPName(playerid), accentStr, params[81]);
		LocalChat(playerid, chatRange, str, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{
		format(str, sizeof(str), "%s says quietly%s: %s", GetRPName(playerid), accentStr, params);
		LocalChat(playerid, chatRange, str, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	format (str, sizeof(str), "(Quiet) %s", params);
	SetPlayerChatBubble(playerid, str, COLOR_WHITE, chatRange, strlen(params)*100);
	IC_Log(playerid, params);
	return 1;
}

CMD:whisper(playerid, params[])
{
	if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	new
		playerb,
		text[144];

	if(sscanf(params, "us[144]", playerb, text))
		return SendUsageMessage(playerid, "/(w)hisper [playerid OR name] [text]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(playerb == playerid)
		return SendErrorMessage(playerid, "You cannot whisper to yourself.");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}You aren't close enough to %s.", GetRPName(playerb));
		return 0;
	}

	new string[128];
	if(strfind(text, "lol", true) != -1 || strfind(text, "lmfao", true) != -1 || strfind(text, "noob", true) != -1
		|| strfind(text, "n00b", true) != -1 || strfind(text, "1337", true) != -1 || strfind(text, "brb", true) != -1
		|| strfind(text, "btw", true) != -1  || strfind(text, "g2g", true) != -1 || strfind(text, "gtg", true) != -1
		|| strfind(text, "pce", true) != -1  || strfind(text, "omg", true) != -1 || strfind(text, "gr8", true) != -1)
	{
		ExecuteAcronymAction(playerid, text);
	}

	SendClientMessageEx(playerb, COLOR_YELLOW, "Whisper from %s: %s", GetRPName(playerid), text);
	SendClientMessageEx(playerid, COLOR_YELLOW, "Whisper to %s: %s", GetRPName(playerb), text);

	format(string, sizeof string, "whispers to %s.", GetRPName(playerb));
	SendAMe(playerid, string);
	return 1;
}
alias:whisper("w");

CMD:blockpm(playerid, params[])
{
	if(Player[playerid][AdminLevel] >= 1 || Player[playerid][HelperLevel] >= 1 || Player[playerid][DonateLevel] >= 1)
	{
		new targetid;
		if(sscanf(params, "u", targetid))
			return SendUsageMessage(playerid, "/pm [PlayerID/PartOfName]");

		if(IsPlayerConnected(targetid))
		{
			if(Player[targetid][AdminLevel] < 1)
				return SendErrorMessage(playerid, "You cannot block administrators.");

			BlockedPM[playerid][targetid] = !BlockedPM[playerid][targetid];
			if(BlockedPM[playerid][targetid] == true)
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "You have blocked /pm's from %s.", GetUserName(targetid));
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_DEPT, "You have enabled /pm's from %s.", GetUserName(targetid));
			}
		}
	}
	else SendErrorMessage(playerid, "This feature is restricted to donators and staff.");
	return 1;
}

CMD:shout(playerid, params[])
{
    new str[128];
	if (isnull(params))
		return SendUsageMessage(playerid, "/shout [text]"); 
		
	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		return SendErrorMessage(playerid, "You can't do this when you are injured/dead.");
	
	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new bool:scream = false;
	for( new i, j = strlen( params )-1; i < j; i ++ )
    {
        if( ( 'A' <= params[ i ] <= 'Z' ) && ( 'A' <= params[ i+1 ] <= 'Z' ) )
            scream = true;
    }

	if(scream)
	{
		if(strlen(params) > 83)
		{
			format(str, sizeof(str), "%s screams: %.83s", GetRPName(playerid), params);
			LocalChat(playerid, 30.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		
			format(str, sizeof(str), "%s screams: ... %s", GetRPName(playerid), params[83]);
			LocalChat(playerid, 30.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		}
		else
		{
			format(str, sizeof(str), "%s screams: %s", GetRPName(playerid), params);
			LocalChat(playerid, 30.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		}
	}
	else
	{
		if(strlen(params) > 84)
		{
			format(str, sizeof(str), "%s shouts: %.84s", GetRPName(playerid), params);
			LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		
			format(str, sizeof(str), "%s shouts: ... %s", GetRPName(playerid), params[84]);
			LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		}
		else
		{
			format(str, sizeof(str), "%s shouts: %s", GetRPName(playerid), params);
			LocalChat(playerid, 20.0, str, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3);
		}
	}

	format (str, sizeof(str), "(Shouts) %s", params);
	SetPlayerChatBubble(playerid, str, COLOR_WHITE, 20.0, strlen(params)*100);
	return 1;
}
alias:shout("s");

CMD:my(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/my [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx; 
	
	format(playerName, sizeof(playerName), "%s", GetRPName(playerid)); 
	idx = strlen(playerName);
	
	if(playerName[idx-1] == 's' || playerName[idx-1] == 's')
	{
		hasEnding = true; 
	}
	
	new Float:chatRange = 20.0;
	if(hasEnding == true)
	{
		if(strlen(params) > 86)
		{
			SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s' %.86s", GetRPName(playerid), params); 
			SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s' ...%s", GetRPName(playerid), params[86]);
		}
		else SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s' %s", GetRPName(playerid), params);
	}
	else
	{
		if(strlen(params) > 86)
		{
			SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s's %.86s", GetRPName(playerid), params); 
			SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s's ...%s", GetRPName(playerid), params[86]);
		}
		else SendNearbyMessage(playerid, chatRange, COLOR_PURPLE, "* %s's %s", GetRPName(playerid), params);
	}
	return 1; 
}

CMD:amy(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/amy [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		return SendErrorMessage(playerid, "You can't do this when you are injured/dead.");

	new str[128], playerName[MAX_PLAYER_NAME], bool:hasEnding = false, idx; 
	
	format(playerName, sizeof(playerName), "%s", GetRPName(playerid)); 
	idx = strlen(playerName);
	
	if(playerName[idx-1] == 's' || playerName[idx-1] == 's')
	{
		hasEnding = true; 
	}
	
	if(hasEnding == true)
	{
		format (str, sizeof(str), "* %s' %s", GetRPName(playerid), params);
		SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 4000);
		
		SendClientMessageEx(playerid, COLOR_PURPLE, "> %s' %s", GetRPName(playerid), params);
	}
	else
	{
		format (str, sizeof(str), "* %s's %s", GetRPName(playerid), params);
		SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, 4000);
		
		SendClientMessageEx(playerid, COLOR_PURPLE, "> %s's %s", GetRPName(playerid), params);
	}
	return 1;
}