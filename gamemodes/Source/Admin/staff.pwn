//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock IsStaffMember(playerid, bool:warning=true)
{
    if(Player[playerid][AdminLevel] >= 1 || Player[playerid][HelperLevel] >= 1 || Player[playerid][Mapper] >= 1) return 1;
    if(warning) SendErrorMessage(playerid, "This command is restricted to staff members only.");
    return 0;
}

stock SendStaffMessage(color, const str[], {Float,_}:...)
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
            if(Player[i][AdminLevel] >= 1 || Player[i][HelperLevel] >= 1 || Player[i][Mapper] >= 1)
			{
                SendClientMessage(i, color, string);
            }
		}
		return 1;
	}
	foreach (new i : Player) 
    {
        if(Player[i][AdminLevel] >= 1 || Player[i][HelperLevel] >= 1 || Player[i][Mapper] >= 1)
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

stock GetStaffRank(playerid)
{
    new rankStr[32];
    if(Player[playerid][Mapper] >= 1)
    {
        rankStr = "Developer";
    }
    if(Player[playerid][HelperLevel] >= 1)
    {
        rankStr = GetHelperRank(playerid);
    }
    if(Player[playerid][AdminLevel] >= 1)
    {
        rankStr = GetAdminRank(playerid);
    }
    if(strlen(rankStr) < 1)
    {
        rankStr = "Undefined Staff";
    }
    return rankStr;
}

CMD:staff(playerid, params[])
{
    if(IsStaffMember(playerid))
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/staff [staff chat]");
            return 1;
        }

        if(TempVar[playerid][Muted] == true)
		    return SendErrorMessage(playerid, "You cannot speak, you are muted.");

        foreach(new i: Player)
        {
            if(IsStaffMember(i, false) && TempVar[i][StaffDisabled] == false)
            {
                if(strlen(params) > 70)
                {
                    SendClientMessageEx(i, COLOR_STAFF, "* [STAFF] %s %s (%s): %.70s ...", GetStaffRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
                    SendClientMessageEx(i, COLOR_STAFF, "* [STAFF] %s %s (%s): ... %s", GetStaffRank(playerid), GetUserName(playerid), GetMasterName(playerid), params[70]);
                }
                else
                {
                    SendClientMessageEx(i, COLOR_STAFF, "* [STAFF] %s %s (%s): %s", GetStaffRank(playerid), GetUserName(playerid), GetMasterName(playerid), params);
                }
            }
        }
        new logString[256];
        format(logString, sizeof logString, "%s %s: %s", GetStaffRank(playerid), GetMasterName(playerid), params);
        SendDiscordMessage(DISCORD_STAFF, logString);
    }
    return 1;
}