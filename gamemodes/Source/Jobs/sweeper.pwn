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

new bool:SprayMode[MAX_VEHICLES],
	bool:LightMode[MAX_VEHICLES],
	Spray[2][MAX_VEHICLES],
	Light[2][MAX_VEHICLES];

#define SPRAY_1_X 0.7
#define SPRAY_2_X -0.7
#define SPRAY_Y 1.6
#define SPRAY_Z -2.2
 
#define LIGHT_1_X 0.4
#define LIGHT_2_X -0.4
#define LIGHT_Y 0.45
#define LIGHT_Z 1.3

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleModel(vehicleid) == 574)
	{
		if(newkeys & KEY_SUBMISSION)
		{
			if(SprayMode[vehicleid])
			{
				SprayMode[vehicleid] = false;
				for(new i; i < 2; i++)
				{
					DestroyDynamicObject(Spray[i][vehicleid]);
				}
			}
			else
			{
				SprayMode[vehicleid] = true;
				Spray[0][vehicleid] = CreateDynamicObject(18710, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				Spray[1][vehicleid] = CreateDynamicObject(18710, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(Spray[0][vehicleid], vehicleid, SPRAY_1_X, SPRAY_Y, SPRAY_Z, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(Spray[1][vehicleid], vehicleid, SPRAY_2_X, SPRAY_Y, SPRAY_Z, 0.0, 0.0, 0.0);
			}
		}
		if(newkeys & KEY_CROUCH)
		{
			if(LightMode[vehicleid])
			{
				LightMode[vehicleid] = false;
				for(new i; i < 2; i++)
				{
					DestroyDynamicObject(Light[i][vehicleid]);
				}
			}
			else
			{
				LightMode[vehicleid] = true;
				Light[0][vehicleid] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				Light[1][vehicleid] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(Light[0][vehicleid], vehicleid, LIGHT_1_X, LIGHT_Y, LIGHT_Z, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(Light[1][vehicleid], vehicleid, LIGHT_2_X, LIGHT_Y, LIGHT_Z, 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
	SprayMode[vehicleid] = false;
	LightMode[vehicleid] = false;

	for(new i; i < 2; i++)
	{
		DestroyDynamicObject(Spray[i][vehicleid]);
		DestroyDynamicObject(Light[i][vehicleid]);
	}
	return 1;
}

new SweeperPos[MAX_PLAYERS], CurrentRound[MAX_PLAYERS];

enum e_SweeperRounds {
	swpType,
	swpID,
	Float:swpX,
	Float:swpY,
	Float:swpZ
};

new g_SweeperRounds[][e_SweeperRounds] = {
	// Round 0
	{0, 0, -69.38, 1162.75, 19.31},
	{0, 1, -68.0, 1118.94, 19.31},
	{0, 2, -168.59, 1101.04, 19.32},
	{0, 3, -252.33, 1100.94, 19.32},
	{0, 4, -272.62, 1177.33, 19.31},
	{0, 5, -79.64, 1196.01, 19.30},
	{0, 6, -77.07, 1160.63, 19.46},
	
	// Round 1
	{1, 0, -69.38, 1162.75, 19.31},
	{1, 1, -4.63, 1145.78, 19.31},
	{1, 2, 2.34, 1101.13, 19.31},
	{1, 3, -17.96, 1041.66, 19.31},
	{1, 4, -62.64, 1045.48, 19.31},
	{1, 5, -77.07, 1160.63, 19.46},
	
	// Round 2
	{2, 0, -69.38, 1162.75, 19.31},
	{2, 1, -63.05, 1181.73, 19.27},
	{2, 2, -20.38, 1195.80, 18.93},
	{2, 3, 94.70, 1195.55, 18.04},
	{2, 4, 107.04, 1197.83, 18.03},
	{2, 5, 92.35, 1200.70, 18.36},
	{2, 6, -49.55, 1201.21, 18.93},
	{2, 7, -77.07, 1160.63, 19.46},
	
	// Round 3
	{3, 0, -69.38, 1162.75, 19.31},
	{3, 1, -63.05, 1181.73, 19.27},
	{3, 2, -94.63, 1200.84, 19.31},
	{3, 3, -117.42, 1165.72, 19.31},
	{3, 4, -171.88, 1150.76, 19.32},
	{3, 5, -188.08, 1181.94, 19.31},
	{3, 6, -192.94, 1191.12, 19.30},
	{3, 7, -197.96, 1120.88, 19.32},
	{3, 8, -125.49, 1095.81, 19.31},
	{3, 9, -63.22, 1123.47, 19.31},
	{3, 10, -77.07, 1160.63, 19.46}
};

enum e_SweeperVehicles {
	swpvehHolder,
	swpvehEnum,
	swpvehModel,
	Float:swpvehX,
	Float:swpvehY,
	Float:swpvehZ,
	Float:swpvehA,
	swpvehColor1,
	swpvehColor2
};

new Float:g_SweeperVehicles[][e_SweeperVehicles] =
{
	{-1, -1, 574, -94.71, 1163.43, 19.46, 180.0, 250, 250},
	{-1, -1, 574, -91.63, 1163.46, 19.46, 180.0, 250, 250},
	{-1, -1, 574, -85.92, 1163.62, 19.46, 180.0, 250, 250},
	{-1, -1, 574, -82.92, 1163.61, 19.46, 180.0, 250, 250}
};

hook OnPlayerConnect(playerid)
{
	SweeperPos[playerid] = -1;
	CurrentRound[playerid] = -1;
	return 1;
}

stock LoadSweeperVehicles()
{
	new counter = 0;
	for (new i = 0; i < sizeof(g_SweeperVehicles); i++)
	{
		g_SweeperVehicles[i][swpvehHolder] = CreateVehicle(g_SweeperVehicles[i][swpvehModel], g_SweeperVehicles[i][swpvehX], g_SweeperVehicles[i][swpvehY], g_SweeperVehicles[i][swpvehZ], g_SweeperVehicles[i][swpvehA], g_SweeperVehicles[i][swpvehColor1], g_SweeperVehicles[i][swpvehColor2], -1);
		counter++;
		
		new plate[32];
		format(plate, sizeof(plate), "SWEEP %i", counter);
		SetVehicleNumberPlate(g_SweeperVehicles[i][swpvehHolder], plate);
		SetVehicleToRespawn(g_SweeperVehicles[i][swpvehHolder]);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger && PlayerInfo[playerid][pJob] != JOB_SWEEPER)
    {
        for(new i; i < sizeof(g_SweeperVehicles); i++)
        {
            if(g_SweeperVehicles[i][swpvehHolder] == vehicleid)
            {
                ClearAnimations(playerid);
                return SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a street sweeper.");
            }
        }
    }
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        for(new i; i < sizeof(g_SweeperVehicles); i++)
        {
            if(g_SweeperVehicles[i][swpvehHolder] == GetPlayerVehicleID(playerid))
            {
                if(PlayerInfo[playerid][pJob] != JOB_SWEEPER)
                {
                    SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a street sweeper.");
                    new Float:slx, Float:sly, Float:slz;
                    GetPlayerPos(playerid, slx, sly, slz);
                    SetPlayerPosEx(playerid, slx, sly, slz+1.3);
                    RemovePlayerFromVehicle(playerid);
                    SetTimerEx("OnSweeperVehNOPCheck", 2000, false, "dd", playerid, g_SweeperVehicles[i][swpvehHolder]);
                }
                return 1;
            }
        }
    }
    return 1;
}

function OnSweeperVehNOPCheck(playerid, vehicleid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
			if(Player[playerid][AdminLevel] < 1 && PlayerInfo[playerid][pJob] != JOB_SWEEPER)
			{
				new string[128];
				format(string, sizeof string, "%s (ID: %d) may be NOP hacking - inside street sweeper whilst not a sweeper.", GetUserName(playerid), playerid);
				SendAdminWarning(1, string);
				format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - inside street sweeper whilst not a sweeper.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Hack", string);
			}
        }
    }
    return 1;
}

stock IsPlayerInSweeper(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
		{
			return 1;
		}
	}
	return 0;
}

CMD:sweeperhelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_SWEEPER)
    {
		SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Sweeper Help:{FFFFFF} Type a command for more information.");
		SendClientMessageEx(playerid, COLOR_GRAD4, "Commands: /startsweep");
		SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:startsweep(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_SWEEPER)
        return SendErrorMessage(playerid, "You are not a street sweeper (/findjob).");

    if(!IsPlayerInSweeper(playerid))
        return SendErrorMessage(playerid, "You are not in a street sweeper.");
	
	if(IsPlayerInRangeOfPoint(playerid, 200.0, g_SweeperRounds[0][swpX], g_SweeperRounds[0][swpY], g_SweeperRounds[0][swpZ]))
	{	
		DisablePlayerCheckpoint(playerid);
		if (CurrentRound[playerid] == -1)
		{
			new rand = Random(0, 3);
			CurrentRound[playerid] = rand;
			for (new i = 0; i < sizeof(g_SweeperRounds); i++)
			{
				if (g_SweeperRounds[i][swpType] == CurrentRound[playerid] && g_SweeperRounds[i][swpID] == 0)
				{
					SweeperPos[playerid] = i;
					TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_SWEEP;
					SetPlayerCheckpoint(playerid, g_SweeperRounds[i][swpX], g_SweeperRounds[i][swpY], g_SweeperRounds[i][swpZ], 3.0);
					PrintFooter(playerid, "A checkpoint has appeared. Clean all the way to its direction to get a new objective.");
					break;
				}
			}
		}
		else
		{
			if (SweeperPos[playerid] == -1)
			{
				for (new i = 0; i < sizeof(g_SweeperRounds); i++)
				{
					if (g_SweeperRounds[i][swpType] == CurrentRound[playerid] && g_SweeperRounds[i][swpID] == 0)
					{
						SweeperPos[playerid] = i;
						TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_SWEEP;
						SetPlayerCheckpoint(playerid, g_SweeperRounds[i][swpX], g_SweeperRounds[i][swpY], g_SweeperRounds[i][swpZ], 3.0);
						PrintFooter(playerid, "A checkpoint has appeared. Clean all the way to its direction to get a new objective.");
						break;
					}
				}
			}
			else
			{
				SetPlayerCheckpoint(playerid, g_SweeperRounds[SweeperPos[playerid]][swpX], g_SweeperRounds[SweeperPos[playerid]][swpY], g_SweeperRounds[SweeperPos[playerid]][swpZ], 3.0);
				PrintFooter(playerid, "You are resuming your previous route, clean all the way to the checkpoint.");
			}
		}
	}
	else SendErrorMessage(playerid, "You need to be in range of the sweeper centre.");
    return 1;
}

stock HandleSweeperCheckpoint(playerid)
{
	if (PlayerInfo[playerid][pJob] == JOB_SWEEPER && SweeperPos[playerid] >= 0)
	{
		if (!IsPlayerInSweeper(playerid))
			return SendErrorMessage(playerid, "You must be in the correct model type.");

		PlayerPlaySound(playerid, 1056, 0, 0, 0);
		DisablePlayerCheckpoint(playerid);
		new next = SweeperPos[playerid] + 1;
		if (next >= sizeof(g_SweeperRounds) || g_SweeperRounds[next][swpID] == 0)
		{
			new rand = random(50)+25, string[128], vehicleid = GetPlayerVehicleID(playerid);
			PlayerInfo[playerid][pPayCheque] += rand;
			format(string, sizeof string, "~w~You have completed this job~n~~g~$%d~w~ was added to your payday.", rand);
			PrintFooter(playerid, string);
			RemovePlayerFromVehicle(playerid);
			RespawnVehicle(vehicleid);
			TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_NONE;
			SweeperPos[playerid] = -1;
			CurrentRound[playerid] = -1;
			return 1;
		}
		else
		{
			SweeperPos[playerid] = next;
			TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_SWEEP;
			SetPlayerCheckpoint(playerid, g_SweeperRounds[next][swpX], g_SweeperRounds[next][swpY], g_SweeperRounds[next][swpZ], 3.0);
		}
	}
	return 1;
}
