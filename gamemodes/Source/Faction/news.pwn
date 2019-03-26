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

stock SendNewsMessage(colour, const str[], {Float,_}:...)
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

		foreach(new i: Player)
        {
            if(TempVar[i][NewsDisabled] == false)
            {
                SendClientMessage(i, colour, string);
            }
        }
		return 1; 
	}
    foreach(new i: Player)
    {
        if(TempVar[i][NewsDisabled] == false)
        {
            SendClientMessage(i, colour, str);
        }
    }
    return 1;
}

CMD:live(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionNews] == 1)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(TempVar[playerid][TalkingLive] == true)
    {
        foreach(new i: Player)
        {
            if(TempVar[i][TalkingLive] == true)
            {
                TempVar[i][TalkingLive] = false;
                SendClientMessage(i, COLOR_LIGHTBLUE, "* You are now off air.");
            }
        }
        return 1;
    }

    new targetid, string[128];
	if(sscanf(params, "u", targetid))
		return SendUsageMessage(playerid, "/live [PlayerID/PartOfName]");

    if(!IsPlayerConnected(targetid))
        return SendErrorMessage(playerid, "No such player is connected.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player.");

    SetPVarInt(targetid, "LiveOfferer", playerid);
    format(string, sizeof string, "%s has offered you to go live on air.", GetRPName(playerid));
    Dialog_Show(targetid, LiveOffer, DIALOG_STYLE_MSGBOX, "Live Offer", string, "Accept", "Decline");
    return 1;
}

Dialog:LiveOffer(playerid, response, listitem, inputtext[])
{
    if(IsPlayerConnected(GetPVarInt(playerid, "LiveOfferer")))
    {
        if(response)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have accepted %s's offer, anything you say will be broadcast live.", GetRPName(GetPVarInt(playerid, "LiveOfferer")));
            SendClientMessage(playerid, COLOR_WHITE, "TIP: Use 'T' or 'F6' to talk live.");

            SendClientMessageEx(GetPVarInt(playerid, "LiveOfferer"), COLOR_LIGHTBLUE, "* %s has accepted your offer, anything you say will be broadcast live.", GetRPName(playerid));
            SendClientMessage(GetPVarInt(playerid, "LiveOfferer"), COLOR_WHITE, "TIP: Use 'T' or 'F6' to talk live.");

            foreach(new i: Player)
            {
                if(TempVar[i][NewsDisabled] == false)
                {
                    SendClientMessageEx(i, 0x77BFA0FF, "[News] %s is about to broadcast live with %s. (/tognews to disable)", GetRPName(GetPVarInt(playerid, "LiveOfferer")), GetRPName(playerid));
                }
                else
                {
                    SendClientMessageEx(i, 0x77BFA0FF, "[News] %s is about to broadcast live with %s. (/tognews to enable)", GetRPName(GetPVarInt(playerid, "LiveOfferer")), GetRPName(playerid));
                }
            }

            TempVar[playerid][TalkingLive] = true;
            TempVar[GetPVarInt(playerid, "LiveOfferer")][TalkingLive] = true;
        }
        else
        {
            SendClientMessageEx(GetPVarInt(playerid, "LiveOfferer"), COLOR_LIGHTRED, "* %s has rejected your live offer.", GetRPName(playerid));
        }
    }
    else SendErrorMessage(playerid, "The live offerer disconnected.");
    DeletePVar(playerid, "LiveOfferer");
}

CMD:news(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionNews] == 1)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/news [text]");
    
    foreach(new i: Player)
    {
        if(TempVar[i][NewsDisabled] == false)
        {
            if(strlen(params) > 70)
            {
                SendClientMessageEx(i, 0x77BFA0FF, "[News] %s: %.70s ...", GetRPName(playerid), params);
                SendClientMessageEx(i, 0x77BFA0FF, "[News] %s: ... %s", GetRPName(playerid), params[70]);
            }
            else SendClientMessageEx(i, 0x77BFA0FF, "[News] %s: %s", GetRPName(playerid), params);
        }
    }
    return 1;
}