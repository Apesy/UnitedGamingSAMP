//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_DAMAGE_COUNTS 30

enum damageCounterEnum
{
    damageTime,
    damageBodypart,
    damageWeaponID,
    Float:damageAmount
};
new DamageCounter[MAX_PLAYERS][MAX_DAMAGE_COUNTS][damageCounterEnum];

GetBodyPartName(bodypart, male = 1, small = 0)
{
	new name[15] = "None";
	
	if (small)
	{
		name = "none";
	}
	
	switch (bodypart)
	{
		case BODY_PART_CHEST:
		{
			if (small)
			{
				name = "chest";
			}
			else
			{
				name = "Chest";
			}
		}
		case BODY_PART_GROIN:
		{
			if (male)
			{
				if (small)
				{
					name = "groin";
				}
				else
				{
					name = "Groin";
				}
			}
			else
			{
				if (small)
				{
					name = "vagina";
				}
				else
				{
					name = "Vagina";
				}
			}
		}
		case BODY_PART_LEFTARM:
		{
			if (small)
			{
				name = "left arm";
			}
			else
			{
				name = "Left arm";
			}
		}
		case BODY_PART_RIGHTARM:
		{
			if (small)
			{
				name = "right arm";
			}
			else
			{
				name = "Right arm";
			}
		}
		case BODY_PART_LEFTLEG:
		{
			if (small)
			{
				name = "left leg";
			}
			else
			{
				name = "Left leg";
			}
		}
		case BODY_PART_RIGHTLEG:
		{
			if (small)
			{
				name = "right leg";
			}
			else
			{
				name = "Right leg";
			}
		}
		case BODY_PART_HEAD:
		{
			if (small)
			{
				name = "head";
			}
			else
			{
				name = "Head";
			}
		}
	}
	
	return name;
}

stock ShowDamages(playerid, targetid)
{
	new string[2048], weaponid;
    format(string, sizeof string, "Weapon\tBodypart\tDamage\n");
	
    for(new i; i < MAX_DAMAGE_COUNTS; i++)
    {
        weaponid = DamageCounter[targetid][i][damageWeaponID];
        if(DamageCounter[targetid][i][damageTime] > 0 && DamageCounter[targetid][i][damageTime] + 900 > gettime() && weaponid >= 0 && weaponid <= 48)
        {
            format(string, sizeof(string), "%s%s\t%s\t%.1f\n", string, GetDeathReason(weaponid), GetBodyPartName(DamageCounter[targetid][i][damageBodypart]), DamageCounter[targetid][i][damageAmount]);
        }
    }

	Dialog_Show(playerid, NonExistant, DIALOG_STYLE_MSGBOX, "Injuries", string, "Close", "");
	return 1;
}

stock AddDamage(playerid, bodypart, weaponid, Float:damage)
{
	for (new i = MAX_DAMAGE_COUNTS - 2; i >= 0; i--)
	{
		DamageCounter[playerid][i + 1][damageBodypart] = DamageCounter[playerid][i][damageBodypart];
		DamageCounter[playerid][i + 1][damageWeaponID] = DamageCounter[playerid][i][damageWeaponID];
		DamageCounter[playerid][i + 1][damageTime] = DamageCounter[playerid][i][damageTime];
		DamageCounter[playerid][i + 1][damageAmount] = DamageCounter[playerid][i][damageAmount];
	}

	DamageCounter[playerid][0][damageBodypart] = bodypart;
	DamageCounter[playerid][0][damageAmount] = damage;
	DamageCounter[playerid][0][damageWeaponID] = weaponid;
	DamageCounter[playerid][0][damageTime] = gettime();
	return 1;
}

ResetDamages(playerid)
{
	for (new i = 0; i < MAX_DAMAGE_COUNTS; i++)
	{
		DamageCounter[playerid][i][damageTime] = 0;
		DamageCounter[playerid][i][damageBodypart] = 0;
		DamageCounter[playerid][i][damageWeaponID] = 0;
		DamageCounter[playerid][i][damageAmount] = 0;
	}
	return 1;
}

CMD:injuries(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid))
        return ShowDamages(playerid, playerid);

    if(!IsPlayerNearPlayer(playerid, targetid, 20.0))
        return SendErrorMessage(playerid, "You are not near that player");
    
    ShowDamages(playerid, targetid);
    return 1;
}
alias:injuries("damages", "wounds");