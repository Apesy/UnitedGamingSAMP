//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_RADIOS 1000000

enum chanEnum
{
    ChanID,
    ChanFaction,
    ChanPassword
}
new RadioChan[MAX_RADIOS][chanEnum],
    Cache:rCache;

stock LoadRadioChan()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `Radio`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            rCache = cache_save();
            cache_get_value_int(i, "ID", RadioChan[i][ChanID]);

            cache_get_value_int(i, "Faction", RadioChan[i][ChanFaction]);
            cache_get_value_int(i, "Password", RadioChan[i][ChanPassword]);

            cache_set_active(rCache);
        }
    }
    cache_delete(result); 
}

stock SaveChannel(radio)
{
    mysql_format(g_SQL, query, sizeof query, "UPDATE `Radio` SET `Faction` = %d, `Password` = '%e' WHERE `ID` = %d", 
        RadioChan[i][ChanFaction], RadioChan[i][ChanPassword], RadioChan[i][ChanID]);
    mysql_tquery(g_SQL, query);
    return 1;
}

stock SendRadioMessage(playerid, params[])
{
    foreach(new i : Player)
    {
        if(GetInventory(i, INV_RADIO) && PlayerInfo[i][pRadioChan] == PlayerInfo[playerid][pRadioChan])
        {
            if(strlen(params) > 70)
            {
                SendClientMessageEx(i, COLOR_RADIO, "** [Ch: %d] %s: %.70s ... **", PlayerInfo[i][pRadioChan], GetRPName(playerid), params);
                SendClientMessageEx(i, COLOR_RADIO, "** [Ch: %d] %s: ... %s **", PlayerInfo[i][pRadioChan], GetRPName(playerid), params[70]);
            }
            else SendClientMessageEx(i, COLOR_RADIO, "** [Ch: %d] %s: %s **", PlayerInfo[i][pRadioChan], GetRPName(playerid), params);
        }
    }
    IC_Log(playerid, params);
    return 1;
}

CMD:setchannel(playerid, params[])
{
	new channel;
	
	if(sscanf(params, "i", channel))
		return SendUsageMessage(playerid, "/setchannel [channel]"); 
		
	if(!GetInventory(playerid, INV_RADIO))
		return SendErrorMessage(playerid, "You don't have a radio."); 
		
	if(channel < 1 || channel > MAX_RADIOS)
		return SendErrorMessage(playerid, "You specified an invalid channel. (1-%d)", MAX_RADIOS); 
	
    // I should make these channels dynamically be set in-game, that will require its own system though.
	if(channel == 91191 || channel == 91192 || channel == 91193) // BCSD Channels
	{
		if(PlayerInfo[playerid][pFaction] != 1)
			return SendErrorMessage(playerid, "You're not authorized to use this channel."); 
	}

    if(channel == 92191 || channel == 92192 || channel == 92193) // BCFD Channels
	{
		if(PlayerInfo[playerid][pFaction] != 2)
			return SendErrorMessage(playerid, "You're not authorized to use this channel."); 
	}

    if(channel == 93191 || channel == 93192 || channel == 93193) // GOV Channels
	{
		if(PlayerInfo[playerid][pFaction] != 3)
			return SendErrorMessage(playerid, "You're not authorized to use this channel."); 
	}
	
	PlayerInfo[playerid][pRadioChan] = channel;
	
	SendClientMessageEx(playerid, COLOR_RADIO, "You're now listening to channel %i.", channel);
    new string[256];
	mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `RadioChan` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pRadioChan], PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
	return 1;
}

CMD:radiohelp(playerid, params[])
{
    if(GetInventory(playerid, INV_RADIO))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Radio Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD1, "Commands: /radio (/r), /setchannel.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    else SendErrorMessage(playerid, "You don't have a radio, you one at a 24/7."); 
    return 1;
}

CMD:radiolow(playerid, params[])
{
    if(GetInventory(playerid, INV_RADIO))
    {
        new
            channel,
            string[128]
        ;

        channel = PlayerInfo[playerid][pRadioChan]; 

        if(!channel)
            return SendErrorMessage(playerid, "Your local radio channel isn't set, use /setchannel.");
            
        if(isnull(params))
            return SendUsageMessage(playerid, "/r [text], /rlow [text]");
            
        if(strfind(params, "lol", true) != -1 || strfind(params, "lmfao", true) != -1 || strfind(params, "noob", true) != -1
            || strfind(params, "n00b", true) != -1 || strfind(params, "1337", true) != -1 || strfind(params, "brb", true) != -1
            || strfind(params, "btw", true) != -1  || strfind(params, "g2g", true) != -1 || strfind(params, "gtg", true) != -1
            || strfind(params, "pce", true) != -1  || strfind(params, "omg", true) != -1 || strfind(params, "gr8", true) != -1)
        {
            ExecuteAcronymAction(playerid, params);
        }

        SendRadioMessage(playerid, params);
        
        new accentStr[64];
        if(strlen(PlayerInfo[playerid][pAccent]) > 0)
        {
            format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
        }

        if(strlen(params) > 70)
        {
            format(string, sizeof string, "%s says quietly%s (Radio): %.70s ...", GetRPName(playerid), params);
            LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
            format(string, sizeof string, "%s says quietly%s (Radio): ... %s", GetRPName(playerid), params[70]);
            LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        }
        else
        {
            format(string, sizeof string, "%s says quietly%s (Radio): %s", GetRPName(playerid), params);
            LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        }
    }
    return 1;
}
alias:radiolow("rlow");

CMD:radio(playerid, params[])
{
    if(GetInventory(playerid, INV_RADIO))
    {
        new
            channel,
            string[128]
        ;

        channel = PlayerInfo[playerid][pRadioChan]; 

        if(!channel)
            return SendErrorMessage(playerid, "Your local radio channel isn't set, use /setchannel.");
            
        if(isnull(params))
            return SendUsageMessage(playerid, "/r [text], /rlow [text]");
            
        if(strfind(params, "lol", true) != -1 || strfind(params, "lmfao", true) != -1 || strfind(params, "noob", true) != -1
            || strfind(params, "n00b", true) != -1 || strfind(params, "1337", true) != -1 || strfind(params, "brb", true) != -1
            || strfind(params, "btw", true) != -1  || strfind(params, "g2g", true) != -1 || strfind(params, "gtg", true) != -1
            || strfind(params, "pce", true) != -1  || strfind(params, "omg", true) != -1 || strfind(params, "gr8", true) != -1)
        {
            ExecuteAcronymAction(playerid, params);
        }

        SendRadioMessage(playerid, params);
        
        if(strlen(params) > 70)
        {
            format(string, sizeof string, "%s says (Radio): %.70s ...", GetRPName(playerid), params);
            LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
            format(string, sizeof string, "%s says (Radio): ... %s", GetRPName(playerid), params[70]);
            LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        }
        else
        {
            format(string, sizeof string, "%s says (Radio): %s", GetRPName(playerid), params);
            LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        }
    }
    else SendErrorMessage(playerid, "You do not own a radio, purchase one from a 24/7.");
    return 1;
}
alias:radio("r");