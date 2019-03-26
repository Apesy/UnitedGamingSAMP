//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock SendGlobalOOC(color, const str[], {Float,_}:...)
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
			if(TempVar[i][DisabledOOC] == false)
			{
				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player) 
	{
		if(TempVar[i][DisabledOOC] == false)
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendTeleportMessage(playerid)
{
	SendClientMessage(playerid, COLOR_GREEN, "[SERVER]: {AFAFAF}You have been teleported.");
}