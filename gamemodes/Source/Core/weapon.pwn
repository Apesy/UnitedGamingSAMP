//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock IsPrimaryWeapon(weaponid)
{
	if(weaponid == 25 || weaponid == 26 || weaponid == 29 || weaponid == 30 
	|| weaponid == 31 || weaponid == 33)
	{
		return 1;
	}
	return 0;
}

stock IsSecondaryWeapon(weaponid)
{
	if(weaponid == 22 || weaponid == 23 || weaponid == 24 || weaponid == 28 
	|| weaponid == 32)
	{
		return 1;
	}
	return 0;
}

stock IsMeleeWeapon(weaponid)
{
	if(weaponid == 2 || weaponid == 3 || weaponid == 4 || weaponid == 5 
	|| weaponid == 6 || weaponid == 7 || weaponid == 8 || weaponid == 11
	|| weaponid == 12 || weaponid == 13)
	{
		return 1;
	}
	return 0;
}

stock GetServerWeaponName(weaponid)
{
    new weaponName[32];
    if(weaponid == 0) 
    {
        weaponName = "None";
        return weaponName;
    }
    GetWeaponName(weaponid, weaponName, sizeof(weaponName));
    return weaponName;
}

stock GetWeaponIDSlot(weaponid)
{
	new slotID; 
	switch(weaponid)
	{
		case 1 .. 10: slotID = 0;
		case 11 .. 18, 41, 43: slotID = 1;
		case 22 .. 24: slotID = 2;
		case 25, 27 .. 34: slotID = 3;
	}
	return slotID;
}

stock GetWeaponSlot(weaponid)
{
	new slot;
	switch(weaponid){
		case 0, 1: slot = 0; // No weapon
		case 2 .. 9: slot = 1; // Melee
		case 22 .. 24: slot = 2; // Handguns
		case 25 .. 27: slot = 3; // Shotguns
		case 28, 29, 32: slot = 4; // Sub-Machineguns
		case 30, 31: slot = 5; // Machineguns
		case 33, 34: slot = 6; // Rifles
		case 35 .. 38: slot = 7; // Heavy Weapons
		case 16, 18, 39: slot = 8; // Projectiles
		case 42, 43: slot = 9; // Special 1
		case 14: slot = 10; // Gifts
		case 44 .. 46: slot = 11; // Special 2
		case 40: slot = 12; // Detonators
		default: slot = -1; // No slot
	}
	return slot;
}

stock GetWeaponsModel(weaponid)
{
    new WeaponModels[] =
    {
        0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
        325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
        353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
        367, 368, 368, 371
    };
    return WeaponModels[weaponid];
}

stock PlayerHasWeapons(playerid)
{
	new countWeapons = 0;
	
	for(new i = 0; i < 4; i ++)
	{
		if(PlayerInfo[playerid][pWeapon][i] != 0)
			countWeapons++;
	}
	if(countWeapons == 0)
		return 0;
		
	if(countWeapons > 0)
		return 1;
		
	return 1;
}

stock PlayerHasWeapon(playerid, weaponid)
{
	if(PlayerInfo[playerid][pWeapon][GetWeaponIDSlot(weaponid)] != weaponid)
		return 0;

	return 1;
}

stock RemovePlayerGun(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;
	
	new saveweapon[13], saveammo[13];
	for(new slot = 0; slot < 13; slot++)
	{
		GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
	}
	ResetPlayerWeapons(playerid);
	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
		{
			PlayerInfo[playerid][pWeapon][slot] = 0;
			PlayerInfo[playerid][pAmmo][slot] = 0;
			PlayerInfo[playerid][pSerial][slot] = 0;
			continue;
		}
		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	GivePlayerWeapon(playerid, 0, 1);
}

function RemovePlayerWeapon(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;
	new saveweapon[13], saveammo[13];
	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
	ResetPlayerWeapons(playerid);
	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;
		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	if(PlayerInfo[playerid][pPrimaryWeapon] == weaponid && IsPlayerAttachedObjectSlotUsed(playerid, SLOT_WEAPON))
	{
		RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
	}
	if(PlayerInfo[playerid][pPrimaryWeapon]) PlayerInfo[playerid][pPrimaryWeapon] = 0;

	GivePlayerWeapon(playerid, 0, 1);
}

stock TakePlayerGuns(playerid)
{
	ResetPlayerWeapons(playerid);

	for(new i = 0; i < 4; i++) if(PlayerInfo[playerid][pAmmo][i])
	{
		PlayerInfo[playerid][pWeapon][i] = 0;
		PlayerInfo[playerid][pAmmo][i] = 0;
		PlayerInfo[playerid][pSerial][i] = 0;
	}

	PlayerInfo[playerid][pPrimaryWeapon] = 0;
	PlayerInfo[playerid][pSecondaryWeapon] = 0;
	PlayerInfo[playerid][pMeleeWeapon] = 0;
	PlayerInfo[playerid][pOtherWeapon] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_WEAPON))
	{
		RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
	}
}

stock GivePlayerGun(playerid, weaponid, ammo, serial, bool:notify=true)
{
	new idx = GetWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerid][pWeapon][idx])
	{
		RemovePlayerWeapon(playerid, PlayerInfo[playerid][pWeapon][idx]);
	}
	
	GivePlayerWeapon(playerid, weaponid, ammo); 
	
	PlayerInfo[playerid][pWeapon][idx] = weaponid;
	PlayerInfo[playerid][pAmmo][idx] = ammo;
	PlayerInfo[playerid][pSerial][idx] = serial;
	
	if(IsPrimaryWeapon(weaponid) && ammo >= 1)
	{
		if(notify)
		{
			SendClientMessageEx(playerid, COLOR_GREEN, "Primary Weapon: {FFFFFF}You will now spawn with a %s", GetServerWeaponName(weaponid));
		}
		PlayerInfo[playerid][pPrimaryWeapon] = weaponid;
		PlayerInfo[playerid][pPrimaryAmmo] = ammo;
		return 1;
	}
	if(IsSecondaryWeapon(weaponid) && ammo >= 1)
	{
		if(notify)
		{
			SendClientMessageEx(playerid, COLOR_GREEN, "Secondary Weapon: {FFFFFF}You will now spawn with a %s", GetServerWeaponName(weaponid));
		}
		PlayerInfo[playerid][pSecondaryWeapon] = weaponid;
		PlayerInfo[playerid][pSecondaryAmmo] = ammo;
		return 1;
	}
	if(IsMeleeWeapon(weaponid))
	{
		PlayerInfo[playerid][pMeleeWeapon] = weaponid;
		return 1;
	}
	PlayerInfo[playerid][pOtherWeapon] = weaponid;
	return 1;
}

stock WeaponDataSlot(weaponid)
{
	new slot;
	
	switch (weaponid)
	{
		case 1: slot = 0;
		case 2 .. 9: slot = 1; 
		case 10 .. 15: slot = 10; 
		case 16 .. 18: slot = 8;
		case 41, 43: slot = 9; 
		case 22,23,24: slot = 2;
		case 25: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6; 
	}
	return slot;
}