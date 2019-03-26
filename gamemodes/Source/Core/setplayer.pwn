//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

// native SetSkin(playerid, skinid)
stock SetSkin(playerid, skinid)
{
    PlayerInfo[playerid][pSkin] = skinid;
	new sid = GetPlayerVehicleSeat(playerid);
	if(IsPlayerInAnyVehicle(playerid) && sid != 128)
	{
		new vid = GetPlayerVehicleID(playerid);
		RemovePlayerFromVehicle(playerid);
		SetPlayerSkin(playerid, skinid);
		PutPlayerInVehicle(playerid, vid, sid);
	}
    else 
	{
		SetPlayerSkin(playerid, skinid);
	}
	UpdateSpectator(playerid);
}

// native SetInterior(playerid, int)
stock SetInterior(playerid, int)
{
    Player[playerid][Interior] = int;
    SetPlayerInterior(playerid, int);
	UpdateSpectator(playerid);
}

// native SetVirtualWorld(playerid, worldid)
stock SetVirtualWorld(playerid, worldid)
{
    Player[playerid][VirtualWorld] = worldid;
    SetPlayerVirtualWorld(playerid, worldid);
	UpdateSpectator(playerid);
}

stock SetPlayerPosFindZEx(playerid, Float:x, Float:y, Float:z)
{
	SetPlayerPosFindZ(playerid, x, y, z);
	UpdateSpectator(playerid);
}

stock SetPlayerHealthEx(playerid, Float:health)
{
	new Float:newhp = health;
	if(newhp < 0)
	{
		newhp = 0;
	}
	if(newhp > 100)
	{
		newhp = 100;
	}
	SetPlayerHealth(playerid, newhp);
}

stock SetPlayerArmourEx(playerid, Float:armour)
{
	new Float:newarm = armour;
	if(newarm < 0)
	{
		newarm = 0;
	}
	SetPlayerArmour(playerid, newarm);
}

// native SetPlayerPosEx(playerid, x, y, z)
stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z)
{
    SetPlayerPos(playerid, x, y, z);
    UpdateSpectator(playerid);
    return 1;
}

// Update Spectator camera, to help prevent the camera issue.
stock UpdateSpectator(playerid)
{
    foreach(new i : Player)
	{
		if(TempVar[i][Spectating] == playerid)
		{
			if(IsPlayerConnected(playerid))
			{
				TogglePlayerSpectating(i, 1);
				SetPlayerInterior(i,GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid));

				if(IsPlayerInAnyVehicle(playerid))
				{
					PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
				}
				else
				{
					PlayerSpectatePlayer(i, playerid);
				}
			}
			else
			{
				pc_cmd_spec(i, "off");
			}
		}
	}
}

stock SetMoney(playerid, amount)
{
	PlayerInfo[playerid][pMoney] = amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
}

stock GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][pMoney] += amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
}

stock TakeMoney(playerid, amount)
{
	PlayerInfo[playerid][pMoney] -= amount;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
}

stock GetPlayeridByName(name[])
{
	foreach (new i : Player)
	{
		if (IsPlayerConnected(i) && Player[i][IsLoggedIn] == true)
		{
			if (!strcmp(name, GetUserName(i)))
			{
				return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}