//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:leavegun(playerid, params[])
{
	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
		return SendErrorMessage(playerid, "You need to crouch before performing this.");

	new 
		weaponid, 
		idx,
		id, 
		Float:x,
		Float:y,
		Float:z,
		str[128]
	;
	
	weaponid = GetPlayerWeapon(playerid);
	
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "You are not holding a valid weapon, please scroll one.");
		
	if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "You don't have that weapon."); 
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
		{
			idx = i;
			break;
		}
	}
	
	id = GetWeaponIDSlot(weaponid); 
	GetPlayerPos(playerid, x, y, z); 
	
	WeaponDropInfo[idx][eWeaponDropped] = true;
	WeaponDropInfo[idx][eWeaponDroppedBy] = PlayerInfo[playerid][pCharacterID]; 
	
	WeaponDropInfo[idx][eWeaponWepID] = weaponid;
	WeaponDropInfo[idx][eWeaponWepAmmo] = PlayerInfo[playerid][pAmmo][id];
	
	WeaponDropInfo[idx][eWeaponPos][0] = x;
	WeaponDropInfo[idx][eWeaponPos][1] = y;
	WeaponDropInfo[idx][eWeaponPos][2] = z;
	
	WeaponDropInfo[idx][eWeaponInterior] = GetPlayerInterior(playerid);
	WeaponDropInfo[idx][eWeaponWorld] = GetPlayerVirtualWorld(playerid); 

	WeaponDropInfo[idx][eWeaponSerial] = PlayerInfo[playerid][pSerial][id];
	
	RemovePlayerWeapon(playerid, weaponid);
	PlayerInfo[playerid][pWeapon][id] = 0;
	PlayerInfo[playerid][pAmmo][id] = 0;
	PlayerInfo[playerid][pSerial][id] = 0; 
	
	WeaponDropInfo[idx][eWeaponObject] = CreateDynamicObject(
		GetWeaponsModel(weaponid),
		x,
		y,
		z - 1,
		80.0,
		0.0,
		0.0,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)); 
	
	if(WeaponDropInfo[idx][eWeaponSerial] > 0)
	{
		format(str, sizeof str, "%s\nSerial: %d\n((/grabgun))", GetServerWeaponName(weaponid), WeaponDropInfo[idx][eWeaponSerial]);
	}
	else format(str, sizeof str, "%s\n((/grabgun))", GetServerWeaponName(weaponid));

	WeaponDropInfo[idx][eWeaponLabel] = CreateDynamic3DTextLabel(str, 0x00FF00FF, x, y, z-0.5, 3.0, .testlos = 1, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid));
		
	WeaponDropInfo[idx][eWeaponTimer] = SetTimerEx("OnPlayerLeaveWeapon", 600000, false, "i", idx); 
	SendServerMessage(playerid, "Your weapon will disappear in 10 minutes if it isn't picked up.");
	format(str, sizeof(str), "drops a %s.", GetServerWeaponName(weaponid));
	callcmd::ame(playerid, str);
	return 1;
}
alias:leavegun("lg");

CMD:grabgun(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 2)
		return SendErrorMessage(playerid, "You need to be level 2 in order to use this.");

	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
		return SendErrorMessage(playerid, "You need to crouch before performing this.");

	new
		bool:foundWeapon = false,
		id,
		str[128]
	;

	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue; 
	
		if(IsPlayerInRangeOfPoint(playerid, 3.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				foundWeapon = true;
				id = i;
			}							
		}
	}
	
	if(foundWeapon)
	{
		if(IsWeaponRestricted(playerid))
			return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

		GivePlayerGun(playerid, WeaponDropInfo[id][eWeaponWepID], WeaponDropInfo[id][eWeaponWepAmmo], WeaponDropInfo[id][eWeaponSerial], false);
		
		format(str, sizeof(str), "picks up a %s.", GetServerWeaponName(WeaponDropInfo[id][eWeaponWepID]));
        callcmd::ame(playerid, str);
		
		WeaponDropInfo[id][eWeaponDropped] = false; 
		WeaponDropInfo[id][eWeaponDroppedBy] = 0;
		WeaponDropInfo[id][eWeaponSerial] = 0;
		
		WeaponDropInfo[id][eWeaponWepID] = 0; WeaponDropInfo[id][eWeaponWepAmmo] = 0; 
		
		KillTimer(WeaponDropInfo[id][eWeaponTimer]); 
		DestroyDynamicObject(WeaponDropInfo[id][eWeaponObject]); 
		DestroyDynamic3DTextLabel(WeaponDropInfo[id][eWeaponLabel]); 
	}
	else return SendServerMessage(playerid, "You aren't near a dropped weapon.");
	return 1;
}
alias:grabgun("gg");

CMD:dropinfo(playerid, params[])
{
	if(IsAdminLevel(playerid, 1))
    {
        for(new i = 0; i < sizeof(WeaponDropInfo); i++)
        {
            if(!WeaponDropInfo[i][eWeaponDropped])
                continue;
        
            if(IsPlayerInRangeOfPoint(playerid, 5.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
            {
                if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
                {
                    SendServerMessage(playerid, "This is a %s with %d ammo dropped by %s (Serial: %d).", GetServerWeaponName(WeaponDropInfo[i][eWeaponWepID]), WeaponDropInfo[i][eWeaponWepAmmo], GetDatabaseName(WeaponDropInfo[i][eWeaponDroppedBy]), WeaponDropInfo[i][eWeaponSerial]);
                }
            }
            return 1;
        }
        
        SendServerMessage(playerid, "You aren't near a dropped gun.");    
    }
	return 1;
}

function OnPlayerLeaveWeapon(index)
{
	new query[128];
	WeaponDropInfo[index][eWeaponDropped] = false;
	WeaponDropInfo[index][eWeaponDroppedBy] = 0;
	
	WeaponDropInfo[index][eWeaponWepAmmo] = 0;
	WeaponDropInfo[index][eWeaponWepID] = 0;
	WeaponDropInfo[index][eWeaponSerial] = 0;
	
	for(new i = 0; i < 3; i++)
	{
		WeaponDropInfo[index][eWeaponPos][i] = 0.0;
	}
	
	if(IsValidDynamicObject(WeaponDropInfo[index][eWeaponObject]))
	{
		DestroyDynamicObject(WeaponDropInfo[index][eWeaponObject]);
	}

	if(IsValidDynamic3DTextLabel(WeaponDropInfo[index][eWeaponLabel]))
	{
		DestroyDynamic3DTextLabel(WeaponDropInfo[index][eWeaponLabel]);
	}

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM WeaponRegistry WHERE Serial = '%d'", WeaponDropInfo[index][eWeaponSerial]);
	mysql_tquery(g_SQL, query);
	return 1;
}