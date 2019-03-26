//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock ClearDamages(playerid)
{
	for(new i = 0; i < 100; i++)
	{
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0; 
		
		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;
		
		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0; 
	}
	
	return 1;
}

stock CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount)
{
	new
		id,
		Float:armor
	;
	
	TotalPlayerDamages[playerid] ++; 
	
	for(new i = 0; i < 100; i++)
	{
		if(!DamageInfo[playerid][i][eDamageTaken])
		{
			id = i;
			break;
		}
	}
	
	GetPlayerArmour(playerid, armor);
	
	if(armor > 1 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = 1;
		
	else DamageInfo[playerid][id][eDamageArmor] = 0;
	
	DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round); 
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;
	
	DamageInfo[playerid][id][eDamageBodypart] = bodypart; 
	DamageInfo[playerid][id][eDamageTime] = gettime();
	
	DamageInfo[playerid][id][eDamageBy] = PlayerInfo[issuerid][pCharacterID]; 
	return 1; 
}

stock ShowPlayerDamages(damageid, playerid, adminView)
{
	new
		caption[33],
		str[355], 
		longstr[1200]
	; 
	
	format(caption, sizeof(caption), "%s", ReturnName(damageid));
	
	if (TotalPlayerDamages[damageid] < 1)
		return Dialog_Show(playerid, DIALOG_NOTHING, DIALOG_STYLE_LIST, caption, "There aren't any damages to show.", "<<", ""); 

	switch(adminView)
	{
		case 0:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				format(str, sizeof(str), "%d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_NOTHING, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
		case 1:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				format(str, sizeof(str), "{FF6346}(%s){FFFFFF} %d dmg from %s to %s (Kevlarhit: %d) %d s ago\n", GetDatabaseName(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_NOTHING, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
	}
	return 1;
}
