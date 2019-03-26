//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:melow(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/melow [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	SendMe(playerid, params, 6.0);
	return 1; 
}

CMD:attempt(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/attempt [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new Float:range = 20.0;

	new rand = random(2), chance[32];
	if(rand == 0)
	{
		chance = " and succeeded";
	}
	else
	{
		chance = ", but failed";
	}

	if(strlen(params) > 70)
	{
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %s attempts to %.70s ...", GetRPName(playerid), params); 
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* ... %s %s. (( %s ))", params[70], GetRPName(playerid), params);
	}
	else SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %s %s%s.", GetRPName(playerid), params, chance);
	return 1; 
}

CMD:me(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/me [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	SendMe(playerid, params, 20.0);
	return 1; 
}

CMD:dolow(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/dolow [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new Float:range = 6.0;

	if(strlen(params) > 86)
	{
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %.86s ... (( %s ))", params, GetRPName(playerid)); 
		SendNearbyMessage(playerid, range, COLOR_PURPLE, "* ... %s (( %s ))", params[86], GetRPName(playerid));
	}
	else SendNearbyMessage(playerid, range, COLOR_PURPLE, "* %s (( %s ))", params, GetRPName(playerid));
	return 1; 
}

CMD:do(playerid, params[])
{
	if (isnull(params)) 
		return SendUsageMessage(playerid, "/do [emote]");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	if(strlen(params) > 86)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.86s ... (( %s ))", params, GetRPName(playerid)); 
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* ... %s (( %s ))", params[86], GetRPName(playerid));
	}
	else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, GetRPName(playerid));
	return 1; 
}

CMD:ame(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/ame [emote]");

	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		return SendErrorMessage(playerid, "You can't do this when you are injured/dead.");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	SendAMe(playerid, params);
	
	SendClientMessageEx(playerid, COLOR_PURPLE, "> %s %s", GetRPName(playerid), params);
	return 1;
}

CMD:ado(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/ado [emote]");

	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		return SendErrorMessage(playerid, "You can't do this when you are injured/dead.");

	if(TempVar[playerid][Muted] == true)
		return SendErrorMessage(playerid, "You cannot speak, you are muted.");

	new str[128], time = strlen(params)*100;
	if(time < 10000)
	{
		time = 10000;
	}
	format (str, sizeof(str), "* %s (( %s ))", params, GetRPName(playerid));
	SetPlayerChatBubble(playerid, str, COLOR_PURPLE, 20.0, time);
	
	SendClientMessageEx(playerid, COLOR_PURPLE, "> %s (( %s ))", params, GetRPName(playerid));
	return 1;
}