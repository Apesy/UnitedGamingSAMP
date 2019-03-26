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

new AirbreakWarnings[MAX_PLAYERS], 
    SilentAimWarnings[MAX_PLAYERS], 
    ProAimWarnings[MAX_PLAYERS], 
    bool:IsPlayerDead[MAX_PLAYERS],
    AC_UpdateTime[MAX_PLAYERS];

new Float:LastX[MAX_PLAYERS],Float:LastY[MAX_PLAYERS],Float:LastZ[MAX_PLAYERS];

new bool:AntiMotorbike[MAX_PLAYERS], AntiMotorbikeCounter[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    AirbreakWarnings[playerid] = 0;
    SilentAimWarnings[playerid] = 0;
    ProAimWarnings[playerid] = 0;
    IsPlayerDead[playerid] = true;
    AntiMotorbike[playerid] = false;
    AntiMotorbikeCounter[playerid] = 0;
    LastX[playerid] = 0;
    LastY[playerid] = 0;
    LastZ[playerid] = 0;
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    IsPlayerDead[playerid] = false;
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    IsPlayerDead[playerid] = true;
    return 1;
}

hook OnPlayerUpdate(playerid)
{
    new ac_gtc = GetTickCount();

    // Anti bike abuse
	new Keys, ud, lr;
    GetPlayerKeys(playerid, Keys, ud, lr);
	
	if (ud == KEY_UP)
	{
		new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));
		if (modelid == 448 || modelid == 461 || modelid == 462 || modelid == 463 || modelid == 468 || modelid == 471 || modelid == 521 || modelid == 522 || modelid == 523 || modelid == 581 || modelid == 586)
		{
			if (AntiMotorbike[playerid] == false)
			{
				AntiMotorbike[playerid] = true;
				AntiMotorbikeCounter[playerid]++;
			}
		}
	}
	else if (ud != KEY_UP)
	{
		AntiMotorbike[playerid] = false;
	}

    if(GetPlayerTeam(playerid) == PLAYER_WOUNDED || GetPlayerTeam(playerid) == PLAYER_DEAD)
    {
        if(GetPlayerAnimationIndex(playerid) != 1151)
        {
            ApplyAnimation(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0);
        }
    }
    AC_UpdateTime[playerid] = ac_gtc;
    return 1;
}

stock IsVehicleFalling(vehicleid, Float:changer = 1.0)
{
	new Float:x, Float:y, Float:z, Float:nz;
	GetVehiclePos(vehicleid, x, y, z);
	MapAndreas_FindZ_For2DCoord(x, y, nz);

	if ((nz + changer) < z)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

ptask AntiMotorbikeTimer[5000](playerid)
{
    if(Player[playerid][IsLoggedIn] == true)
    {
        new string[128];
        // Does not work.
        /*if(!IsPlayerInAnyVehicle(playerid) && GetPlayerInterior(playerid) > 0 && Player[playerid][AdminLevel] < 1)
        {
            new Float:x, Float:y, Float:z, Float:d;
            GetPlayerPos(playerid, x, y, z);
            d = floatsqroot((x-LastX[playerid] * x-LastX[playerid]) + (y-LastY[playerid] * y-LastY[playerid]));
            if(d < 10 && (LastZ[playerid] - z) > 5)
            {
                format(string, sizeof string, "%s (%d) may be falling whilst inside an interior.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
            LastX[playerid] = x;
            LastY[playerid] = y;
            LastZ[playerid] = z;
        }*/

        if(IsPlayerInAnyVehicle(playerid))
        {
            if (AntiMotorbikeCounter[playerid] > 7 && GetPlayerSpeed(playerid, false) > 50 && !IsVehicleFalling(GetPlayerVehicleID(playerid)))
            {
                format(string, sizeof string, "%s (%d) may be possibly tapping on a bike,", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
            else
            {
                AntiMotorbikeCounter[playerid] = 0;
            }
        }
    }
    return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    new ac_gtc = GetTickCount();
    new Float:ac_oX, Float:ac_oY, Float:ac_oZ, Float:ac_X, Float:ac_Y, Float:ac_Z;
    new string[128];
    GetPlayerLastShotVectors(playerid, ac_oX, ac_oY, ac_oZ, ac_X, ac_Y, ac_Z);
    if(hittype > BULLET_HIT_TYPE_NONE && !fX && !fY && !fZ)
    {
        SilentAimWarnings[playerid]++;
        if(SilentAimWarnings[playerid] >= 3)
        {
            if(Player[playerid][AdminLevel] < 1)
            {
                format(string, sizeof string, "%s (%d) may be possibly using aim bot.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
                if(TempVar[playerid][SuspectedAimbotter] == false)
                {
                    TempVar[playerid][SuspectedAimbotter] = true;
                }
            }
            SilentAimWarnings[playerid] = 0;
        }
    }
    else
    {
        SilentAimWarnings[playerid] = 0;
        if(hittype == BULLET_HIT_TYPE_PLAYER && hitid != INVALID_PLAYER_ID &&
        !IsPlayerDead[hitid] && ac_gtc < AC_UpdateTime[playerid] + 1500 && !IsPlayerInAnyVehicle(hitid) &&
        GetPlayerSurfingVehicleID(hitid) == INVALID_VEHICLE_ID && GetPlayerSurfingObjectID(hitid) == INVALID_OBJECT_ID)
        {
            if(!IsPlayerInRangeOfPoint(hitid, 8.0, ac_X, ac_Y, ac_Z))
            {
                if(ProAimWarnings[playerid] > 2)
                {
                    if(Player[playerid][AdminLevel] < 1)
                    {
                        format(string, sizeof string, "%s (%d) may be possibly using aim bot.", GetUserName(playerid), playerid);
                        SendAdminWarning(1, string);
                        if(TempVar[playerid][SuspectedAimbotter] == false)
                        {
                            TempVar[playerid][SuspectedAimbotter] = true;
                        }
                    }
                    ProAimWarnings[playerid] = 0;
                }
            }
            else ProAimWarnings[playerid] = 0;
        }
    }
    return 1;  
}

stock isSwimAnim(anim) 
{
	new animlib[32];
    new animname[32];
	GetAnimationName(anim,animlib, sizeof animlib, animname, sizeof animname);
	if(!strcmp(animlib,"SWIM", true)) 
    {
		return 1;
	}
	return 0;
}

stock FlyHacking(playerid)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    new anim = GetPlayerAnimationIndex(playerid);
    if(anim != 0 && isSwimAnim(anim)) 
    {
        if(Z >= 125.0 && (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)) 
        {
            return 1;
        }
    }
    return 0;
}

stock GetHealth(playerid)
{
	new Float:gHealth;
	GetPlayerHealth(playerid, gHealth);
	new newHealth = floatround(gHealth, floatround_round);
	return newHealth;
}

stock GetArmour(playerid)
{
	new Float:gArmour;
	GetPlayerHealth(playerid, gArmour);
	new newArmour = floatround(gArmour, floatround_round);
	return newArmour;
}

stock GetPlayerSpeed(playerid, bool:kmh)
{
	new Float:Vx, Float:Vy, Float:Vz;

	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), Vx, Vy, Vz);
	}
	else
	{
		GetPlayerVelocity(playerid, Vx, Vy, Vz);
	}

    new Float:rtn;

    rtn = floatsqroot(floatpower(Vx*100,2) + floatpower(Vy*100,2));
    rtn = floatsqroot(floatpower(rtn,2) + floatpower(Vz*100,2));

    if(kmh)
    {
    	return floatround(rtn * 1.61);
    }
    else
    {
    	return floatround(rtn);
    }
}

stock IsPlayerRunning(playerid)
{
    if(!IsPlayerConnected(playerid) || IsPlayerInAnyVehicle(playerid)) return 0;
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if(keys & KEY_SPRINT && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK) return 1;
    if(GetPlayerAnimationIndex(playerid))
    {
        new animlib[32], animname[32];
        GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
        if(!strcmp(animlib, "PED"))
        {
			new const names[8][] = { "run_fat", "run_fatold", "run_old", "swat_run", "woman_run", "WOMAN_runbusy", "woman_runpanic", "WOMAN_runsexy" };
			for(new i; i < sizeof(names); i++)
			{
			    if(!strcmp(animname, names[i])) return 1;
			}
        }
    }
    return 0;
}

public OnPlayerFall(playerid, Float:damage)
{
    AddDamage(playerid, BODY_PART_LEFTLEG, 54, damage);
    OnPlayerProcessDamage(playerid, INVALID_PLAYER_ID, 54, damage, BODY_PART_LEFTLEG);
    return 1;
}

public OnPlayerRamPlayer(playerid, driverid, vehicleid, Float:damage)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(driverid))
    {
        PlayerInfo[playerid][pLastRam] = GetMasterName(driverid);
        PlayerInfo[playerid][pLastRamTime] = gettime();

        new string[256];
        format(string, sizeof string, "%s (IP: %s AccountID: %d) was rammed by %s (IP: %s AccountID: %d Vehicle: %s)", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(driverid), GetUserIP(driverid), Player[driverid][ID], ReturnVehicleName(vehicleid));
        DBLog("VehicleRam", string);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `LastRam` = '%e', `LastRamTime` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pLastRam], PlayerInfo[playerid][pLastRamTime], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
    }
    return 1;
}

/*public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new str[144],nme[MAX_PLAYER_NAME],wname[32];

        if(TempVar[playerid][SuspectedAimbotter] == false)
        {
            TempVar[playerid][SuspectedAimbotter] = true;
        }
        GetPlayerName(playerid,nme,sizeof(nme));
        GetWeaponName(weaponid,wname,sizeof(wname));
        if(warnings & WARNING_OUT_OF_RANGE_SHOT)
        {
            format(str,sizeof str,"%s (%d) fired a shot from a distance bigger than %s's range (Aimbot)", GetUserName(playerid), playerid, wname, BustAim::GetNormalWeaponRange(weaponid));
            SendAdminWarning(1, str);
        }
        if(warnings & WARNING_PROAIM_TELEPORT)
        {
            format(str,sizeof str,"%s (%d) may be possible shooting players using teleport (Aimbot)", GetUserName(playerid), playerid);
            SendAdminWarning(1, str);
        }
        if(warnings & WARNING_RANDOM_AIM)
        {
            format(str,sizeof str,"%s (%d) may be possibly using random aim (Aimbot)", GetUserName(playerid), playerid);
            SendAdminWarning(1, str);
        }
    }
    return 1;
}*/

stock CanCarsurfVehicle(vehicleid)
{
    new pveh = GetVehicleModel(vehicleid);
    if(pveh == 478 
        || pveh == 422
        || pveh == 543
        || pveh == 430
        || pveh == 446
        || pveh == 452
        || pveh == 453
        || pveh == 454
        || pveh == 472
        || pveh == 473
        || pveh == 484
        || pveh == 493
        || pveh == 595
        || pveh == 455)
    {
        return 1;
    }
	return 0;
}

ptask AntiCheat[3000](i)
{
    new string[128];
    // Ignore players that are not logged in as we don't want them triggering false positives.
    if(Player[i][IsLoggedIn] == true) 
    {        
        if(Player[i][AdminLevel] < 1)
        {
            if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
            {
                new animlib[30],animname[30];
     	        GetAnimationName(GetPlayerAnimationIndex(i) , animlib, sizeof(animlib), animname, sizeof(animname));
 	            if(strcmp(animlib, "PED", true) == 0 && strcmp(animname, "RUN_PLAYER", true) == 0 && GetPlayerSkin(i) != 0)
 	            {
 	                if(TempVar[i][CJRunWarning] < 1)
 	                {
					    TempVar[i][CJRunWarning] = 60;
					    format(string, sizeof(string), "%s (ID: %d) may be using CJ run cheats.", GetUserName(i), i);
                        SendAdminWarning(1, string);
                        InsertHackerLog(i, "CJ Run Cheats.");
                        format(string, sizeof string, "%s (IP: %s AccountID: %d) may be using CJ run cheats.", GetUserName(i), GetUserIP(i), Player[i][ID]);
                        DBLog("Hack", string);
                        return 1;
	                }
 	            }
                if(FlyHacking(i) == 1)
                {
                    TempVar[i][FlyHackingWarning] = 10;
                    format(string, sizeof(string), "%s (ID: %d) may be using flying cheats.", GetUserName(i), i);
                    SendAdminWarning(1, string);
                    InsertHackerLog(i, "Flying Cheats.");
                    format(string, sizeof string, "%s (IP: %s AccountID: %d) may be using flying cheats.", GetUserName(i), GetUserIP(i), Player[i][ID]);
                    DBLog("Hack", string);
                }
            }
        }

        if(Player[i][AdminLevel] < 1)
        {
            new surf = GetPlayerSurfingVehicleID(i);
            if(surf != INVALID_VEHICLE_ID && GetVehicleSpeed(surf) >= 25.0)
            {
                if(!CanCarsurfVehicle(surf))
                {
                    TempVar[i][CarSurf]++;
                    if(TempVar[i][CarSurf] >= 5)
                    {
                        format(string, sizeof string, "%s (%d) may be car surfing.", GetUserName(i), i);
                        SendAdminWarning(1, string);
                        format(string, sizeof string, "%s (IP: %s AccountID: %d) may be car surfing.", GetUserName(i), GetUserIP(i), Player[i][ID]);
                        DBLog("Abuse", string);
                        TempVar[i][CarSurf] = 0;
                    }
                }
            }
        }

        if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK 
            && Player[i][AdminLevel] < 1)
		{
            if(TempVar[i][BeingKicked] == false)
            {
                InsertHackerLog(i, "Unauthorised Modifications (Jetpack Spawning)");
                SystemBan(i, "Unauthorised Modifications (Jetpack Spawning)");
            }
		}

        if(GetPlayerState(i) == PLAYER_STATE_ONFOOT && Player[i][AdminLevel] < 1)
		{
			switch(GetPlayerAnimationIndex(i))
			{
			    case 958, 1538, 1539, 1543:
			    {
			        new
			            Float:z,
			            Float:vx,
			            Float:vy,
			            Float:vz;

					GetPlayerPos(i, z, z, z);
                    GetPlayerVelocity(i, vx, vy, vz);

                    if((z > 20.0) && (0.9 <= floatsqroot((vx * vx) + (vy * vy) + (vz * vz)) <= 1.9))
                    {
                        if(TempVar[i][BeingKicked] == false)
                        {
                            InsertHackerLog(i, "Unauthorised Modifications (Flying Cheats)");
                            SystemBan(i, "Unauthorised Modifications (Flying Cheats)");
                        }
                        return 1;
					}
				}
			}
		}
    }
    return 1;
}

function InsertHackerLog(playerid, action[])
{
    new string[256];
    mysql_format(g_SQL, string, sizeof string, "INSERT INTO `hacker_log` (`AccountID`, `Username`, `Action`, `Timestamp`) VALUES (%d, '%e', '%e', %d)", Player[playerid][ID], GetMasterName(playerid), action, gettime());
    mysql_tquery(g_SQL, string);
    return 1;
}

function NoSpamFix(playerid)
{
	TempVar[playerid][SpamWarns] = 0;
	return 1;
}

function ExecuteMoneyAction(playerid)
{
    // Check if their ping is below 300 to prevent paki-net from throwing false positives.
    if(TempVar[playerid][BeingKicked] == false && GetPlayerPing(playerid) < 300)
    {
        InsertHackerLog(playerid, "Unauthorised Modifications (Money Spawning)");
        SystemBan(playerid, "Unauthorised Modifications (Money Spawning)");
    }
    return 1;
}

function ExecuteJetpackAction(playerid)
{
    if(TempVar[playerid][BeingKicked] == false)
    {
        InsertHackerLog(playerid, "Unauthorised Modifications (Jetpack Spawning)");
        SystemBan(playerid, "Unauthorised Modifications (Jetpack Spawning)");
    }
    return 1;
}

public OnPlayerJetpackCheat(playerid)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        ExecuteJetpackAction(playerid);
    }
    return 1;
}

public OnPlayerFakeConnect(playerid)
{
    // Does not work
    /*if(!gAnticheat) return 1;

    new string[128];
    format(string, sizeof(string), "%s (%d) may be possibly fake connecting.", GetUserName(playerid), playerid);
    SendAdminWarning(1, string);*/
    return 1;
}

public OnPlayerCashCheat(playerid, oldcash, newcash, amount)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        format(string, sizeof(string), "%s (%d) may be using money cheats, spawned $%s.", GetUserName(playerid), playerid, FormatNumber(amount));
        SendAdminWarning(1, string);
    }
	return 1;
}

public OnPlayerFakeKill(playerid, spoofedid, spoofedreason, faketype)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        if(faketype == 2 && TempVar[playerid][BeingKicked] == false)
        {
            format(string, sizeof string, "%s was autokicked. Reason: Fake Kill Spam.", GetUserName(playerid), playerid);
            SendAdminCommand(string);
            InsertKickLog(playerid, "SYSTEM", "Fake Kill Spam.");
            DelayedKick(playerid);
            return 1;
        }
        format(string, sizeof string, "%s (%d) may be using fake kill cheats. SpoofedID: %s, Spoffed Wep: %s.", GetUserName(playerid), playerid, GetUserName(spoofedid), GetServerWeaponName(spoofedreason));
        SendAdminWarning(1, string);
    }
	return 1;
}

public OnPlayerSpamChat(playerid)
{
    if(!gAnticheat) return 1;

	if(Player[playerid][AdminLevel] < 1)
	{
		new string[128];
		if(TempVar[playerid][SpamWarns] < 3)
		{
			TempVar[playerid][SpamWarns]++;
			format(string, sizeof string, "%s (%d) may be spamming chat.", GetUserName(playerid), playerid);
			SendAdminWarning(1, string);
			SetTimerEx("NoSpamFix", 15*1000, false, "d", playerid);
		}
		else
		{
            if(TempVar[playerid][BeingKicked] == false)
            {
                format(string, sizeof string, "%s was autokicked. Reason: Spamming.", GetUserName(playerid));
                SendAdminCommand(string);
                InsertKickLog(playerid, "SYSTEM", "Spamming.");
                DelayedKick(playerid);
            }
		}
	}
	return 1;
}

public OnPlayerGunCheat(playerid, weaponid, ammo, hacktype)
{
    if(!gAnticheat) return 1;

	if(Player[playerid][AdminLevel] < 1)
	{
		new string[128], logstring[256];
		switch(hacktype)
		{
			case 1:
			{
				InsertHackerLog(playerid, "Spawning Weapons.");
                format(string, sizeof string, "%s (ID: %d) may be possibily weapon hacking. Spawned %s with %d ammo.", GetUserName(playerid), playerid, GetServerWeaponName(weaponid), ammo);
                SendAdminWarning(1, string);
				format(logstring, sizeof logstring, "%s (IP %s AccountID: %d) may be possibily weapon hacking. Spawned %s with %d ammo.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetServerWeaponName(weaponid), ammo);

				if(TempVar[playerid][BeingKicked] == false)
				{
					format(string, sizeof string, "Unauthorised Modifcations (Spawned %s).", GetServerWeaponName(weaponid));
					SystemBan(playerid, string);
				}
			}
			case 2:
			{
				InsertHackerLog(playerid, "Ammo Cheats.");
				format(logstring, sizeof logstring, "%s (IP %s AccountID: %d) may be possibly ammo cheats.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                if(TempVar[playerid][BeingKicked] == false)
                {
                    SystemBan(playerid, "Unauthorised Modifcations (Ammo Spawn).");
                }
			}
			case 3:
			{
				InsertHackerLog(playerid, "Frozen Ammo Cheats.");
				format(logstring, sizeof logstring, "%s (IP %s AccountID: %d) may be possibly frozen ammo cheats.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                SendAdminWarning(1, string);
                /*if(TempVar[playerid][BeingKicked] == false)
                {
                    SystemBan(playerid, "Unauthorised Modifcations (Infinite Ammo).");
                }*/
			}
			case 4:
			{
				InsertHackerLog(playerid, "Rapid Fire Cheats.");
				format(logstring, sizeof logstring, "%s (IP %s AccountID: %d) may be possibly rapid fire cheats.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                if(TempVar[playerid][BeingKicked] == false)
                {
                    SystemBan(playerid, "Unauthorised Modifcations (Rapid Fire).");
                }
			}
		}
		DBLog("Hack", logstring);
	}
	return 1;
}

public OnPlayerBreakAir(playerid, breaktype)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new cheatStr[32];
        if(breaktype == 1)
        {
            format(cheatStr, sizeof cheatStr, "Unauthorised Modifcations (Airbreak)");
        }
        else
        {
            format(cheatStr, sizeof cheatStr, "Unauthorised Modifcations (Teleport)");
        }
        AirbreakWarnings[playerid]++;
        if(AirbreakWarnings[playerid] >= 3)
        {
            if(TempVar[playerid][BeingKicked] == false)
            {
                SystemBan(playerid, cheatStr);
                return 1;
            }
        }
        new string[128], logstring[256];
        InsertHackerLog(playerid, cheatStr);
        format(string, sizeof string, "%s (%d) may be possibly using %s.", GetUserName(playerid), playerid, cheatStr);
        format(logstring, sizeof logstring, "%s (IP %s AccountID: %d) may be possibly using %s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], cheatStr);
        SendAdminWarning(1, string);
        DBLog("Hack", logstring);
    }
	return 1;
}

stock GetPlayerPacketloss(playerid,&Float:packetloss)
{
	// Returns the packetloss percentage of the given playerid - Made by Fusez

	if(!IsPlayerConnected(playerid)) return 0;

	new nstats[400+1], nstats_loss[20], start, end;
	GetPlayerNetworkStats(playerid, nstats, sizeof(nstats));

	start = strfind(nstats,"packetloss",true);
	end = strfind(nstats,"%",true,start);

	strmid(nstats_loss, nstats, start+12, end, sizeof(nstats_loss));
	packetloss = floatstr(nstats_loss);
	return 1;
}

public OnPlayerLagout(playerid, lagtype, ping) 
{
    if(IsPlayerNPC(playerid)) return 1;
    if(!gAnticheat) return 1;
    if(TempVar[playerid][BeingKicked] == true) return 1;

    new string[128], Float:packetloss;
	GetPlayerPacketloss(playerid, packetloss);
	format(string, sizeof string, "%s was autokicked. Reason: Desynced (Ping: %d, Packet Loss: %.2f).", GetUserName(playerid), ping, packetloss);
	SendAdminCommand(string);
	InsertKickLog(playerid, "SYSTEM", "Desynced.");
	DelayedKick(playerid);
    return 1; 
}

public OnPlayerCarTroll(playerid, vehicleid, trolledid, trolltype) 
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        if(TempVar[playerid][CarTrollCheck] < 5)
        {
            TempVar[playerid][CarTrollCheck]++;
            switch(trolltype)
            {
                case 1: format(string, sizeof string, "%s (%d) may be teleporting between vehicles.", GetUserName(playerid), playerid);
                case 2: format(string, sizeof string, "%s (%d) may be attempting to control another players vehicle illegally.", GetUserName(playerid), playerid);
                case 3: format(string, sizeof string, "%s (%d) may be fast eject/teleporting inside drivers.", GetUserName(playerid), playerid);
                case 4: format(string, sizeof string, "%s (%d) may be teleporting inside a vehicle illegally.", GetUserName(playerid), playerid);
                case 5: format(string, sizeof string, "%s (%d) may be remote car jacking a vehicle.", GetUserName(playerid), playerid);
                case 6: format(string, sizeof string, "%s (%d) may be remote ejecting a player.", GetUserName(playerid), playerid);
                default: format(string, sizeof string, "%s (%d) may be using vehicle trolling cheats.", GetUserName(playerid), playerid);
            }
            SendAdminWarning(1, string);
        }
        else
        {
            if(TempVar[playerid][BeingKicked] == false)
            {
                SystemBan(playerid, "Unauthorised Modifcations (Vehicle Troll)");
            }
        }
    }
    return 1; 
}

public OnPlayerSpamCars(playerid, number)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        if(TempVar[playerid][SpamCarCheck] < 5)
        {
            TempVar[playerid][SpamCarCheck]++;
            format(string, sizeof string, "%s (%d) may be spamming vehicles.", GetUserName(playerid), playerid);
            SendAdminWarning(1, string);
        }
        else
        {
            if(TempVar[playerid][BeingKicked] == false)
            {
                SystemBan(playerid, "Unauthorised Modifcations (Vehicle Spam)");
            }
        }
    }
	return 1;
}

public OnVehicleModEx(playerid, vehicleid, componentid, illegal)
{
	if(illegal)
	{
		if(TempVar[playerid][BeingKicked] == false)
		{
			SystemBan(playerid, "Unauthorised Modifcations (Vehicle Modding).");
		}
	}
	return 1;
}


public OnPlayerCarSwing(playerid, vehicleid)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        format(string, sizeof(string), "%s (%d) may be possibly using car swing cheats. (Vehicle: %d)", GetUserName(playerid), playerid, vehicleid);
        SendAdminWarning(1, string);
    }
	return 1;
}

public OnPlayerParticleSpam(playerid, vehicleid)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        format(string, sizeof(string), "%s (%d) may be possibly using car particle spam cheats. (Vehicle: %d)", GetUserName(playerid), playerid, vehicleid);
        SendAdminWarning(1, string);
    }
	return 1;
}

public OnPlayerBugAttempt(playerid, bugcode)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        switch(bugcode)
        {
            case 0: 
            {
                InsertHackerLog(playerid, "AFK Ghost.");
                format(string, sizeof(string), "%s (%d) may be possibly using AFK ghost cheats.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
            case 1: 
            {
                InsertHackerLog(playerid, "NPC Spoof.");
                format(string, sizeof(string), "%s (%d) may be possibly using NPC spoof cheats.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
            case 2: 
            {
                InsertHackerLog(playerid, "Fake Spawn.");
                format(string, sizeof(string), "%s (%d) may be possibly using fake spawn cheats.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
            /*case 3: // Does not work
            {
                InsertHackerLog(playerid, "Fake Connect.");
                format(string, sizeof(string), "%s (%d) may be possibly using fake connect cheats.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }*/
            case 4: 
            {
                InsertHackerLog(playerid, "CJ Run.");
                format(string, sizeof(string), "%s (%d) may be possibly using CJ run cheats.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
            }
        }
    }
	return 1;
}

public OnPlayerSpeedCheat(playerid, speedtype)
{
    if(!gAnticheat) return 1;

    if(Player[playerid][AdminLevel] < 1)
    {
        new string[128];
        format(string, sizeof string, "%s (ID: %d) is possibly speedhacking, speed: %.1f km/h.", GetUserName(playerid), playerid, GetVehicleSpeed(GetPlayerVehicleID(playerid)));
        SendAdminWarning(1, string);
        format(string, sizeof string, "%s (IP: %s AccountID: %d) is possibly speedhacking, speed: %.1f km/h.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetVehicleSpeed(GetPlayerVehicleID(playerid)));
        DBLog("Hack", string);
        InsertHackerLog(playerid, "Possible Speed Hacking.");
    }
	return 1;
}