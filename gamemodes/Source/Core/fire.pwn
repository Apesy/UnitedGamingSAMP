//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_FIRES 100

enum fireEnum
{
 	fireIndex,
 	Float:fireX,
 	Float:fireY,
 	Float:fireZ,
 	Float:fireA,
};

new const randomFireSpawns[][fireEnum] =
{
    {0, 210.6243,1088.7800,16.8896,330.3871},
    {0, 212.1477,1091.5413,16.4277,243.2014},
    {0, 220.3697,1088.8010,16.0229,242.8723},
    {0, 220.3598,1086.0143,16.3686,51.7215},
    {0, 227.2232,1098.7351,14.2203,327.3145},
    {0, 224.8707,1097.1350,14.6111,57.3145},

    {1, 670.3571,1903.6543,5.4885,16.6746},
    {1, 416.4751,1183.0112,7.8937,103.0540},
    {1, 414.5381,1179.4286,7.8733,135.4608},

    {2, 416.4751,1183.0112,7.8937,103.0540},
    {2, 414.5381,1179.4286,7.8733,135.4608},
    {2, 410.4313,1182.9631,7.8917,10.9332},
    {2, 436.7625,1178.4677,7.8843,257.4271},

    {3, 487.8955,1132.6115,11.6941,287.9666},
    {3, 488.2645,1135.4456,11.1302,272.9264}
};

new gFires, gFireObjects[MAX_FIRES] = {INVALID_OBJECT_ID, ...}, Float:gFireHealth[MAX_FIRES];

/*task RandomFire[5400000]()
{
	new count, index, announced, rand = random(10);

	if(!IsFireActive())
	{
        foreach(new i : Player)
        {
            if(FactionInfo[PlayerInfo[i][pFaction]][FactionMedic] == 1)
            {
                count++;
            }
        }

	    if(count >= 3)
	    {
	        for(new i = 0; i < sizeof(randomFireSpawns); i ++)
	        {
	            if(randomFireSpawns[i][fireIndex] == rand)
	            {
	                if(!announced)
	                {
	                    foreach(new x : Player)
	                    {
	                        if(FactionInfo[PlayerInfo[x][pFaction]][FactionMedic] == 1)
	                        {
                                new zone[32];
                                GetLocation(randomFireSpawns[i][fireX], randomFireSpawns[i][fireY], randomFireSpawns[i][fireZ], zone, sizeof(zone));
	                            SendClientMessageEx(x, COLOR_MEDIC, "DISPATCH: A fire has been reported in %s.", zone);
							}
	                    }

						announced = 1;
					}

	                gFireObjects[index] = CreateDynamicObject(18691, randomFireSpawns[i][fireX], randomFireSpawns[i][fireY], randomFireSpawns[i][fireZ], 0.0, 0.0, randomFireSpawns[i][fireA], .streamdistance = 50.0);
	                gFireHealth[index++] = 50.0;
	            }
	        }

	        gFires = index;
	    }
	}
}*/

function IsFireActive()
{
	for(new i = 0; i < MAX_FIRES; i ++)
	{
	    if(IsValidDynamicObject(gFireObjects[i]))
	    {
	        return 1;
		}
	}
	return 0;
}

CMD:announcefire(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
	{
        if(!IsFireActive())
        {
            return SendClientMessage(playerid, COLOR_GREY, "There is currently no fire active.");
        }

        foreach(new i : Player)
        {
            if(FactionInfo[PlayerInfo[i][pFaction]][FactionMedic] == 1 || i == playerid)
            {
                SendClientMessageEx(i, COLOR_MEDIC, "DISPATCH: A fire has been reported in %s.", ReturnLocation(playerid));
            }
        }
    }
	return 1;
}

CMD:killfire(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
	{
        if(!IsFireActive())
        {
            return SendClientMessage(playerid, COLOR_GREY, "There is currently no fire active.");
        }

        for(new i = 0; i < MAX_FIRES; i ++)
        {
            DestroyDynamicObject(gFireObjects[i]);
            gFireObjects[i] = INVALID_OBJECT_ID;
            gFireHealth[i] = 0.0;
        }

        foreach(new i : Player)
        {
            if(FactionInfo[PlayerInfo[i][pFaction]][FactionMedic] == 1 || i == playerid)
            {
                SendClientMessageEx(i, COLOR_MEDIC, "** (( %s %s has killed the active fire. )) **", GetAdminRank(playerid), GetMasterName(playerid));
            }
        }
        gFires = 0;
    }
	return 1;
}

CMD:spawnfire(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new Float:px, Float:py, Float:pz;
        for(new x = 0; x < MAX_FIRES; x ++)
        {
            if(gFireObjects[x] == INVALID_OBJECT_ID)
            {
                GetPlayerPos(playerid, px, py, pz);

                gFireObjects[x] = CreateDynamicObject(18691, px, py, pz - 2.4, 0.0, 0.0, 0.0, .streamdistance = 50.0);
                gFireHealth[x] = 50.0;
                gFires++;

                return SendClientMessage(playerid, COLOR_GREY, "Fire created!");
            }
        }
        SendErrorMessage(playerid, "You can't create anymore fires. The limit is %i fires.", MAX_FIRES);
    }
    return 1;
}
