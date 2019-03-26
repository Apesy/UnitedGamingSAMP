//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock GetDonateRank(playerid)
{
    new donateRank[32];
    switch(Player[playerid][DonateLevel])
    {
        case 1: donateRank = "Bronze Donator";
        case 2: donateRank = "Silver Donator";
        case 3: donateRank = "Gold Donator";
        default: donateRank = "Unknown Donator";
    }
    if(Player[playerid][AdminLevel] >= 1)
    {
        donateRank = GetAdminRank(playerid);
    }
    return donateRank;
}

CMD:dc(playerid, params[])
{
    if(Player[playerid][DonateLevel] >= 1 || Player[playerid][AdminLevel] >= 1)
	{
		if(Player[playerid][Ajailed] == 1)
			return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

		if(isnull(params))
			return SendUsageMessage(playerid, "/dc [donator chat]");

		foreach(new i : Player)
		{		
			if(Player[i][DonateLevel] >= 1 || Player[i][AdminLevel] >= 1)
			{
				if(strlen(params) > 70)
				{
					SendClientMessageEx(i, COLOR_DEPT, "[Donator] %s %s: %.70s ...", GetDonateRank(playerid), GetMasterName(playerid), params);
					SendClientMessageEx(i, COLOR_DEPT, "[Donator] %s %s: ... %s", GetDonateRank(playerid), GetMasterName(playerid), params[70]);
				}
				else SendClientMessageEx(i, COLOR_DEPT, "[Donator] %s %s: %s", GetDonateRank(playerid), GetMasterName(playerid), params);
			}
		}
	}
	else SendErrorMessage(playerid, "You aren't a donator.");
    return 1;
}

CMD:donatorcolour(playerid, params[])
{
	if(Player[playerid][DonateLevel] >= 1)
	{
		if(TempVar[playerid][DonatorTag] == false)
		{
			SendClientMessage(playerid, -1, "Tag Colour enabled.");
			TempVar[playerid][DonatorTag] = true;
		}
		else
		{
			SendClientMessage(playerid, -1, "Tag Colour disabled.");
			TempVar[playerid][DonatorTag] = false;
		}
		SetPlayerTeamColour(playerid);
	}
	else SendErrorMessage(playerid, "You aren't a donator.");
    return 1;
}