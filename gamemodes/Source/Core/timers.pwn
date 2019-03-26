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

new HelpmeCount[MAX_PLAYERS], HelpmeHourCount[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    HelpmeCount[playerid] = 0;
    HelpmeHourCount[playerid] = 0;
    return 1;
}

ptask UpdatePlayerTime[1000](playerid)
{
	if(PlayerInfo[playerid][pPrimaryWeapon] > 0 && GetPlayerWeapon(playerid) != PlayerInfo[playerid][pPrimaryWeapon])
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, SLOT_WEAPON))
		{
			if(PlayerInfo[playerid][pWeaponSX] == 0.0)
			{
				PlayerInfo[playerid][pWeaponBone] = 1;
				PlayerInfo[playerid][pWeaponX] = 0.139415;
				PlayerInfo[playerid][pWeaponY] = -0.167970;
				PlayerInfo[playerid][pWeaponZ] = 0.120848;
				PlayerInfo[playerid][pWeaponRX] = 0.000000;
				PlayerInfo[playerid][pWeaponRY] = 152.342666;
				PlayerInfo[playerid][pWeaponRZ] = 0.000000;
				PlayerInfo[playerid][pWeaponSX] = 1.0;
				PlayerInfo[playerid][pWeaponSY] = 1.0;
				PlayerInfo[playerid][pWeaponSZ] = 1.0;
			}

			SetPlayerAttachedObject(playerid, SLOT_WEAPON, GetWeaponsModel(PlayerInfo[playerid][pPrimaryWeapon]), PlayerInfo[playerid][pWeaponBone], 
			PlayerInfo[playerid][pWeaponX], PlayerInfo[playerid][pWeaponY], PlayerInfo[playerid][pWeaponZ], 
			PlayerInfo[playerid][pWeaponRX], PlayerInfo[playerid][pWeaponRY], PlayerInfo[playerid][pWeaponRZ], 
			PlayerInfo[playerid][pWeaponSX], PlayerInfo[playerid][pWeaponSY], PlayerInfo[playerid][pWeaponSZ]);
		}
	}
	SetPlayerTime(playerid, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
	UpdateTime();
}

stock UpdateTime()
{
	new string[32];
	format(string, sizeof string, "%02d:%02d", ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
	TextDrawSetString(ServerCurrentTime, string);
}

// Task Name: TenMinute()
// TickRate: 10 Min
task TenMinute[600000]()
{
	foreach(new i: Player)
	{
		if(Player[i][IsLoggedIn] == true)
		{
			if(PlayerInfo[i][pLevel] < 3)
			{
				switch(random(13))
				{
					case 0: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Use /helpme (or /ask) to ask a helper a script related question.");
					case 1: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you spot a rulebreaker, use /report (or /re) to report them.");
					case 2: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Do not PM on duty administrators, they are busy and you will get yourself kicked.");
					case 3: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Check out our UCP at: https://dc-rp.com/ and our forums at https://dc-rp.com/forum/");
					case 4: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Do not ask to be an administrator, doing so will decrease your chances of becoming one.");
					case 5: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Do not spam /report or /helpme, doing so will result on you being kicked.");
					case 6: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you find a bug, report it on our forums at dc-rp.com/forum");
					case 7: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you made a /report and it can't be handled now, take it to the forums.");
					case 8: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you want to change your spawn, use /setspawn.");
					case 9: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Use /findjob to find a job.");
					case 10: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}You can buy a house or business at any level, provided you have the cash upfront.");
					case 11: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}Use /factions to see current legal and illegal official factions.");
					case 12: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you purchase a namechange, you can use /namechange to then change your name.");
					//case 13: SendClientMessage(i, COLOR_LIGHTRED, "[SERVER]: {FFFFFF}If you purchase a phone number, you can use /phchange to then change your name.");
				}
			}
		}
	}
	return 1;
}

// Task Name: VehicleUpdate()
// TickRate: 0.25 Sec
task VehicleUpdate[500]()
{
	new panelsx,doorsx,lightsx,tiresx;
	for (new p = 0; p < MAX_VEHICLES; p++)
	{
		if (Flasher[p] == 1)
		{
			if (FlasherState[p] == 1)
			{
				GetVehicleDamageStatus(p, panelsx, doorsx, lightsx, tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 4, tiresx);
				FlasherState[p] = 0;
			}
			else
			{
				GetVehicleDamageStatus(p, panelsx, doorsx, lightsx, tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 1, tiresx);
				FlasherState[p] = 1;
			}
		}
	}

	foreach(new i: Player)
	{
		if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
			new tdstring[128], vehicleid = GetPlayerVehicleID(i);
			if(!HasNoEngine(vehicleid))
			{
				format(tdstring, sizeof(tdstring), "_~g~Vehicle:~w~ %s~n~~g~_Speed:~w~ %d MPH~n~~g~_Fuel: ~w~%.2f", 
					ReturnVehicleName(vehicleid), GetPlayerSpeed(i, false), CoreVehicle[vehicleid][VehicleFuel]);
				PlayerTextDrawSetString(i, VehicleSpeedo[i], tdstring);
			}
			else
			{
				format(tdstring, sizeof(tdstring), "_~g~Vehicle:~w~ %s~n~~g~_Speed:~w~ %d MPH~n~~g~_Fuel: ~w~Unavailable", 
					ReturnVehicleName(vehicleid), GetPlayerSpeed(i, false));
				PlayerTextDrawSetString(i, VehicleSpeedo[i], tdstring);
			}
		}
	}
}

// Task Name: ServerHeartbeat()
// TickRate: 0.5 Sec
task ServerHeartbeat[500]()
{
	new hour;
	gettime(hour, ServerInfo[CurrentMinute], ServerInfo[CurrentSecond]);
	foreach(new i: Player)
	{
		if(Player[i][IsLoggedIn] == true)
		{
			if(TempVar[i][Spectating] != INVALID_PLAYER_ID)
			{
				new playerb = TempVar[i][Spectating];
				if(IsPlayerInAnyVehicle(playerb))
				{
					if(TempVar[i][SpecVehicle] == false)
					{
						TempVar[i][SpecVehicle] = true;
						PlayerSpectateVehicle(i, GetPlayerVehicleID(playerb));
					}
				}
				else
				{
					if(TempVar[i][SpecVehicle] == true)
					{
						TempVar[i][SpecVehicle] = false;
						PlayerSpectatePlayer(i, playerb);
					}
				}	
			}
		}
	}
}

function PlayerGetup(playerid)
{
	return ApplyAnimation(playerid,"PED","getup",4.0,0,0,0,0,0);
}

// Task Name: ThreeHour()
// TickRate: 3 Hour
task ThreeHour[10800000]()
{
	new number = random(100)+1;
	Lotto(number);
}


// Task Name: TwoHour()
// TickRate: 2 Hour
task TwoHour[7200000]()
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
	RandomWeather();
}

task WeaponDeliveryTimer[60000]()
{
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(FactionInfo[i][FactionDrugRights] == 1)
		{
			if(FactionInfo[i][WeaponDelivery] >= 1)
			{
				FactionInfo[i][WeaponDelivery]--;
				if(FactionInfo[i][WeaponDelivery] < 1)
				{
					FactionInfo[i][WeaponDelivery] = 0;
				}
			}
		}
	}
	return 1;
}

// Task Name: FactionRamRaidCountdown()
// TickRate: 1 Sec
task FactionRamRaidCountdown[5000]()
{
	for(new i; i < MAX_FACTIONS; i++)
	{
		if(FactionInfo[i][FactionRamRaid] == 1)
		{
			if(FactionInfo[i][RamRaid] >= 1)
			{
				FactionInfo[i][RamRaid] -= 5;
				if(FactionInfo[i][RamRaid] < 1)
				{
					SendFactionMessage(i, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} This faction may commit an ATM raid.");
					FactionInfo[i][RamRaid] = 0;
				}
			}
		}
	}
	return 1;
}

// Task Name: VehicleDamageUpdate()
// TickRate: 2 Sec
task VehicleDamageUpdate[2000]()
{
	for(new i; i < GetVehiclePoolSize(); i++)
	{
		if(!HasNoEngine(i))
		{
			if(CoreVehicle[i][VehicleEngine] == true)
			{
				for(new v; v < MAX_DYN_VEH; v++)
				{
					if(VehicleInfo[v][vOwnerID] != 0)
					{
						new Float:dist = GetVehicleDistanceFromPoint(v, VehicleInfo[v][vMileagePosX], VehicleInfo[v][vMileagePosY], VehicleInfo[v][vMileagePosZ]);
						VehicleInfo[v][vMileage] += floatround(dist);
						GetVehiclePos(v, VehicleInfo[v][vMileagePosX], VehicleInfo[v][vMileagePosY], VehicleInfo[v][vMileagePosZ]);
						return 1;
					}
				}
				new Float:veh_hp;
				GetVehicleHealth(i, veh_hp);
				if(veh_hp < 301)
				{
					foreach(new driver: Player)
					{
						if(GetPlayerVehicleID(driver) == i && GetPlayerVehicleSeat(driver) == 0)
						{
							PrintFooter(driver, "~w~Totalled", 2);
						}
					}
					SetVehicleHealth(i, 301);
					ToggleVehicleEngine(i, false);
				}
			}
		}
	}
	return 1;
}

ptask PlayerSecondUpdate[1000](i)
{
	if(Player[i][IsLoggedIn] == true)
	{
		if(Player[i][HelpmeMuted] > 0)
		{
			Player[i][HelpmeMuted]--;
			if(Player[i][HelpmeMuted] < 1)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "* You can now use /helpme again, do not abuse it in future.");
			}
		}
		if(TempVar[i][KillTime] > 0)
		{
			TempVar[i][KillTime]--;
		}
		if(TempVar[i][CJRunWarning] > 0)
		{
			TempVar[i][CJRunWarning]--;
		}
		if(TempVar[i][FlyHackingWarning] > 0)
		{
			TempVar[i][FlyHackingWarning]--;
		}
		if(GetPlayerSkin(i) == 0 && Player[i][AdminLevel] < 1)
		{
			if(PlayerInfo[i][pSkin])
			{
				SetPlayerSkin(i, PlayerInfo[i][pSkin]);
			}
		}

		new string[128];

		if(IsPlayerInRangeOfPoint(i, 2.0, TempVar[i][PlayerPosX], TempVar[i][PlayerPosY], TempVar[i][PlayerPosZ]))
		{
			if(Player[i][PassedTutorial] != 0)
			{
				TempVar[i][IdleTime]++;
				if(TempVar[i][IdleTime] >= MAX_AFK*60 && !IsStaffMember(i, false))
				{
					format(string, sizeof string, "%s was autokicked. Reason: Idle for %d minutes.", GetUserName(i), MAX_AFK);
					SendAdminCommand(string);
					DelayedKick(i);
					return 1;
				}
				if(TempVar[i][IdleTime] >= ((MAX_AFK*60)/2) && !IsStaffMember(i, false) && TempVar[i][IdleWarn] == false) 
				{
					TempVar[i][IdleWarn] = true;
					format(string, sizeof string, "%s (ID: %d) may be possibly idling.", GetUserName(i), i);
					SendAdminWarning(1, string);
					format(string, sizeof string, "%s (IP: %s AccountID: %d) may be possibly idling.", GetUserName(i), i, Player[i][ID]);
					DBLog("Idle", string);
				}
			}
		}
		GetPlayerPos(i, TempVar[i][PlayerPosX], TempVar[i][PlayerPosY], TempVar[i][PlayerPosZ]);
		if(TempVar[i][TaxiFare] >= 1 && GetPlayerState(i) == PLAYER_STATE_PASSENGER)
		{
			TempVar[i][TaxiFare] += TempVar[TempVar[i][TaxiDriverID]][TaxiFarePrice];
			format(string, sizeof string, "Taxi Fare: ~g~$%s", FormatNumber(TempVar[i][TaxiFare]));
			PrintFooter(i, string, 1);
		}

		if(GetPlayerScore(i) != PlayerInfo[i][pLevel])
		{
			SetPlayerScore(i, PlayerInfo[i][pLevel]);
		}
		if(Player[i][DonateLevel] >= 1 && gettime() >= Player[i][DonateExpire])
		{
			Player[i][DonateLevel] = 0;
			Player[i][DonateExpire] = 0;
			SendServerMessage(i, "Your donator rank has expired.");
			format(string, sizeof string, "The donator status of %s (ID: %d) expired.", GetUserName(i), i);
			SendAdminCommand(string, 5);
			format(string, sizeof string, "The donator status of %s (IP: %s AccountID: %d) expired.", GetUserName(i), GetUserIP(i), Player[i][ID]);
			WriteLog("Logs/donate.log", string);
		}
		if(LoopAnim[i]) 
		{
			TextDrawShowForPlayer(i, AnimText);
		} 
		else 
		{
			TextDrawHideForPlayer(i, AnimText);
		}
		TempVar[i][AFKSeconds]++;
		PlayerInfo[i][pConnectedTime]++;
		if(Player[i][Ajailed] >= 1)
		{
			Player[i][AjailTime]--;
			if(Player[i][AjailTime] < 1)
			{
				Player[i][Ajailed] = 0;
				ReleaseFromAdminJail(i);
				format(string, sizeof string, "%s (%s) was released from admin jail.", GetUserName(i), GetMasterName(i));
				SendAdminWarning(1, string);
			}
		}
		if(PlayerInfo[i][pJailed] >= 1)
		{
			PlayerInfo[i][pJailTime]--;
			if(PlayerInfo[i][pJailTime] < 1)
			{
				ReleaseFromPoliceJail(i);
			}
		}
		if(TempVar[i][AFKSeconds] >= MAX_AFK*60 && !IsStaffMember(i, false))
		{
			format(string, sizeof string, "%s was autokicked. Reason: AFK (Max time: %d Minutes)", GetUserName(i), MAX_AFK);
			SendAdminCommand(string);
			TempVar[i][AFKSeconds] = 0;
			DelayedKick(i);
			return 1;
		}
	}
	return 1;
}

task CheckAnnouncement[1000]()
{
	mysql_tquery(g_SQL, "SELECT * FROM `ig_announcement` LIMIT 1", "OnCheckAnnouncement");
	return 1;
}

function OnCheckAnnouncement()
{
	if(cache_num_rows() >= 1)
	{
		new id, user_id, type, message[128];
		cache_get_value_int(0, "ID", id);
		cache_get_value_int(0, "UserID", user_id);
		cache_get_value(0, "Message", message, sizeof message);
		cache_get_value_int(0, "Type", type);

		switch(type)
		{
			case 0: // /aooc
			{
				if(strlen(message) > 70)
				{
					SendClientMessageToAllEx(COLOR_ORANGE, "(( %s (UCP): %.70s ... ))", GetDatabaseMasterName(user_id), message);
					SendClientMessageToAllEx(COLOR_ORANGE, "(( %s (UCP): ... %s ))", GetDatabaseMasterName(user_id), message[70]);
				}
				else SendClientMessageToAllEx(COLOR_ORANGE, "(( %s (UCP): %s ))", GetDatabaseMasterName(user_id), message);
			}
			case 1: // /ann
			{
				SendAnnouncement(GetDatabaseMasterName(user_id), message);
			}
			case 2: // /ooc
			{
				if(strlen(message) > 70)
				{
					SendGlobalOOC(COLOR_OOC, "(( %s (UCP): %.70s ... ))", GetDatabaseMasterName(user_id), message);
					SendGlobalOOC(COLOR_OOC, "(( %s (UCP): ... %s ))", GetDatabaseMasterName(user_id), message[70]);
				}
				else SendGlobalOOC(COLOR_OOC, "(( %s (UCP): %s ))", GetDatabaseMasterName(user_id), message);
			}
		}
		new query[128];
		mysql_format(g_SQL, query, sizeof query, "DELETE FROM `ig_announcement` WHERE `ID` = %d LIMIT 1", id);
		mysql_tquery(g_SQL, query);
	}
	return 1;
}

// Task Name: OneSecond()
// TickRate: 1 Sec
task OneSecond[1000]()
{
	if(ServerInfo[CurrentSecond] >= 59)
	{
		if(ServerInfo[CurrentMinute] >= 59)
		{
			// This check prevents the payday from being called twice.
			if(ServerInfo[PayDayPassed] == false)
			{
				foreach(new i: Player)
				{
    				HelpmeHourCount[i] = 0;
				}
				ServerInfo[PayDayPassed] = true;
				ServerInfo[CurrentHour]++;
				SendClientMessageToAllEx(-1, "The time is now %s.", ConvertTo12Hour(ServerInfo[CurrentHour]));
				if(ServerInfo[CurrentHour] >= 24)
				{
					BlackMarketStock();
					ServerInfo[CurrentHour] = 0;
					foreach(new i: Player)
					{
						HelpmeCount[i] = 0;
					}
					ServerInfo[ServerUptime]++;
				}

				new bool:vehicleSafe[MAX_DYN_VEH] = false;
				for(new i; i < MAX_DYN_VEH; i++)
				{
					if(VehicleInfo[i][vOwnerID] > 0)
					{
						foreach(new p: Player)
						{
							if(PlayerInfo[p][pCharacterID] == VehicleInfo[i][vOwnerID] || GetPlayerVehicleID(p) == VehicleInfo[i][vScriptID])
							{
								vehicleSafe[i] = true;
							}
						}
					}
					if(VehicleInfo[i][vFactionID] > 0)
					{
						vehicleSafe[i] = true;
					}
				}
				PayDay();
				for(new i; i < MAX_DYN_VEH; i++)
				{
					if(vehicleSafe[i] == false)
					{
						SaveVehicle(i);
                        ResetVehicleVars(i);
                        DestroyVehicle(VehicleInfo[i][vScriptID]);
					}
				}
			}
			//ServerInfo[CurrentHour]++;
			if(ServerInfo[CurrentHour] > 23)
			{
				//ServerInfo[CurrentHour] = 0;
			}
		}
	}
	UpdateTime();
	return 1;
}

// Task Name: OneMinute()
// TickRate: 1 Min
task OneMinute[60000]()
{
	for(new i; i < MAX_WEED_PLANTS; i++)
	{
		if (WeedPlants[i][weedID] && WeedPlants[i][weedGrowth] != -1)
		{
			new Float:speed = 0.005;
			WeedPlants[i][weedGrowth]--;
			switch(WeedPlants[i][weedGrowth])
			{
				case 0:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-1.8, speed);
					}
				}
				case 1:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-1.85, speed);
					}
				}
				case 2:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-1.9, speed);
					}
				}
				case 3:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-1.95, speed);
					}
				}
				case 4:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.0, speed);
					}
				}
				case 5:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.05, speed);
					}
				}
				case 6:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.1, speed);
					}
				}
				case 7:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.15, speed);
					}
				}
				case 8:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.2, speed);
					}
				}
				case 9:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.25, speed);
					}
				}
				case 10:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.3, speed);
					}
				}
				case 11:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.35, speed);
					}
				}
				case 12:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.4, speed);
					}
				}
				case 13:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.45, speed);
					}
				}
				case 14:
				{
					if (IsValidDynamicObject(WeedPlants[i][weedObject]))
					{
						MoveDynamicObject(WeedPlants[i][weedObject], WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]-2.5, speed);
					}
				}
			}
			SaveWeed(i);
		}
	}
	for(new i; i < GetVehiclePoolSize(); i++)
	{
		if(!IsValidVehicle(i))
			continue;

		if(HasNoEngine(i))
			continue;		

		if(CoreVehicle[i][VehicleEngine] == true)
		{
			new Float:veh_hp;
			GetVehicleHealth(i, veh_hp);
			if(veh_hp <= 390)
			{
				new rand = random(4);
				if(rand == 1)
				{
					foreach(new driver: Player)
					{
						if(GetPlayerVehicleID(driver) == i && GetPlayerVehicleSeat(driver) == 0)
						{
							PrintFooter(driver, "~w~Engine Stalled", 2);
							SendClientMessage(driver, COLOR_LIGHTRED, "** The engine has stalled, you can attempt to restart the engine using \"/engine\"");
						}
					}
					ToggleVehicleEngine(i, false);
				}
			}

			if(CoreVehicle[i][IsAdminVehicle] == false)
			{
				if(CoreVehicle[i][VehicleFuel] >= 1.0)
				{
					if(GetVehicleSpeed(i) < 20)
					{
						CoreVehicle[i][VehicleFuel] -= 0.5;
					}
					else 
					{
						CoreVehicle[i][VehicleFuel] -= 1.0;
					}
					switch(CoreVehicle[i][VehicleFuel])
					{
						case 15, 10, 5:
						{
							foreach(new driver: Player)
							{
								if(GetPlayerVehicleID(driver) == i && GetPlayerVehicleSeat(driver) == 0)
								{
									SendClientMessage(driver, COLOR_LIGHTRED, "** This vehicle is running low on fuel. Visit the nearest gas station to fill up. (/refuel)");
								}
							}
						}
					}
				}
				else
				{
					SendClientMessage(GetVehicleDriver(i), COLOR_LIGHTRED, "*** Vehicle has ran out of fuel.");
					ToggleVehicleEngine(i, false);
				}
			}

		}
	}
	foreach(new i: Player)
	{
		if(Player[i][IsLoggedIn] == true)
		{
			TempVar[i][RecentKills] = 0;
			SetPlayerTime(i, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
		}
	}
	UpdateTime();
}