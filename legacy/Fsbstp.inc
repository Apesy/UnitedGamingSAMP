/* By RogueDrifter 2018/2/27
This include fixes the SA-MP bug which occurs when you try to jack another player as he teleports.
That results into the other player getting teleported silently (without any reads on the server end).
Also fixes the problem of jacking a paused player.
-=-==-=-=

This include gives you full control reading that 'silent' action through functions, callbacks and restrictions. 
-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=

Callbacks:
--=-=-=-=-=
OnPlayerJackTeleporter(playerid, teleporterid, vehicleid);
----------
playerid = Jacked player
teleporterid = jacker
vehicleid = vehicle used in the process.
-=-=-=-=-=-=-=-=-=

Functions:
-=-=-=-=-=
IsPlayerJackedTping(playerid);
IsPlayerJackingTper(playerid);
IsVehicleJackedTping(vehicleid);
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
*/

#if defined _FSBJACKERS_INCLUDED_
	#endinput
#endif

#define _FSBJACKERS_INCLUDED_

#include <a_samp>

#if !defined FILTERSCRIPT 

#define FSB_MAX_PRORES 2500

enum FSB_PLAYER_DATA
{
	bool:FsbJacked,
	bool:FsbJacking,
	bool:FsbFakeTp,

	FsbJtwo,
	FsbUTicks
};

enum FSB_VEHICLE_DATA
{
	FsbVOwner,

	bool:FsbPJack
};

new 
	FSB_Player[MAX_PLAYERS][FSB_PLAYER_DATA],
	FSB_Vehicle[MAX_VEHICLES][FSB_VEHICLE_DATA],
	FSB_ResetVs;

#if !defined IsValidVehicle
	native IsValidVehicle(vehicleid); 
#endif

forward FSB_ProtectionHandle(handleid, caseid);
forward FSB_VehiclesReset();

forward FSB_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
forward FSB_SetPlayerInterior(playerid, interiorid);
forward FSB_LinkVehicleToInterior(vehicleid, interiorid);

#if defined FSB_OnPlayerInteriorChange
	forward FSB_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
#endif

#if defined FSB_OnPlayerStateChange
	forward FSB_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

#if defined FSB_OnPlayerDisconnect
	forward FSB_OnPlayerDisconnect(playerid, reason);
#endif

#if defined FSB_OnPlayerEnterVehicle
	forward FSB_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif

#if defined FSB_OnPlayerUpdate
	forward FSB_OnPlayerUpdate(playerid);
#endif

#if defined FSB_OnGameModeInit
	forward FSB_OnGameModeInit();
#endif

#if defined FSB_OnGameModeExit
	forward FSB_OnGameModeExit();
#endif

#if defined FSB_OnPlayerSpawn
	forward FSB_OnPlayerSpawn(playerid);
#endif

#if defined OnPlayerJackTeleporter
	forward OnPlayerJackTeleporter(playerid, teleporterid, vehicleid);
#endif

//Hooked callbacks:
public OnGameModeInit()
{
	print("     [[--|| FSBJackers V3.0 ||--]]     ");
    print("     [[--|| Fixed samp bug (jackers) by RogueDrifter V3.0 ||--]]      ");
    print("     [[--|| Successfully Loaded! ||--]]      ");
    FSB_ResetVs = SetTimer("FSB_VehiclesReset", 1000, true);

		#if defined FSB_OnGameModeInit
	return FSB_OnGameModeInit();
		#else
	return 1;
		#endif
}

public OnGameModeExit()
{
	print("     [[--|| FSBJackers V3.0 ||--]]     ");
    print("     [[--|| Fixed samp bug (jackers) by RogueDrifter V3.0 ||--]]      ");
    print("     [[--|| Successfully Unloaded! ||--]]      ");
    KillTimer(FSB_ResetVs);

		#if defined FSB_OnGameModeExit
	return FSB_OnGameModeExit();
		#else
	return 1;
		#endif
}

public OnPlayerUpdate(playerid)
{
	FSB_Player[playerid][FsbUTicks] = GetTickCount();

		#if defined FSB_OnPlayerUpdate
	return FSB_OnPlayerUpdate(playerid);
		#else
	return 1;
		#endif
}

public OnPlayerDisconnect(playerid, reason)
{
	FSB_Player[playerid][FsbJtwo] 	  = INVALID_PLAYER_ID;

	FSB_Player[playerid][FsbJacked]   = false;
	FSB_Player[playerid][FsbJacking]  = false;
	FSB_Player[playerid][FsbFakeTp]   = false;

		#if defined FSB_OnPlayerDisconnect
	return FSB_OnPlayerDisconnect(playerid, reason);
		#else
	return 1;
		#endif
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2)
	{
		FSB_Player[playerid][FsbJtwo] = INVALID_PLAYER_ID;
		new FSB_Veh = GetPlayerVehicleID(playerid);
		
		if(FSB_Vehicle[FSB_Veh][FsbVOwner] != INVALID_PLAYER_ID && FSB_pPaused(FSB_Vehicle[FSB_Veh][FsbVOwner]))
		{
			new Float:FSB_X, Float:FSB_Y, Float:FSB_Z;
			GetPlayerPos(FSB_Vehicle[FSB_Veh][FsbVOwner], FSB_X, FSB_Y, FSB_Z);
			SetPlayerPos(FSB_Vehicle[FSB_Veh][FsbVOwner], FSB_X, FSB_Y, FSB_Z+2);
		}
	}

		#if defined FSB_OnPlayerStateChange
	return FSB_OnPlayerStateChange(playerid, newstate, oldstate);
		#else
	return 1;
		#endif
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger && FSB_Vehicle[vehicleid][FsbVOwner] != INVALID_PLAYER_ID)
	{
		FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo] = playerid;

		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES*2, false, "ii", FSB_Vehicle[vehicleid][FsbVOwner], 1);
	}

		#if defined FSB_OnPlayerEnterVehicle
	return FSB_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
		#else
	return 1;
		#endif
}

public OnPlayerSpawn(playerid)
{
	FSB_Player[playerid][FsbJtwo] = INVALID_PLAYER_ID;

		#if defined FSB_OnPlayerSpawn
	return FSB_OnPlayerSpawn(playerid);
		#else
	return 1;
		#endif
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !FSB_Player[playerid][FsbFakeTp] && FSB_Player[playerid][FsbJtwo] != INVALID_PLAYER_ID)
	{
		new FSB_VID = GetPlayerVehicleID(playerid);

		#if defined OnPlayerJackTeleporter
		OnPlayerJackTeleporter(FSB_Player[playerid][FsbJtwo], playerid, FSB_VID);
		#endif

		FSB_Player[playerid][FsbJacked]  = true;
		FSB_Player[FSB_Player[playerid][FsbJtwo]][FsbJacking] = true;
		FSB_Vehicle[FSB_VID][FsbPJack] = true;
			
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", FSB_Player[playerid][FsbJtwo], 3);
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", playerid, 4);
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", FSB_VID, 5);

		ClearAnimations(FSB_Player[playerid][FsbJtwo], 1);
		}

		#if defined FSB_OnPlayerInteriorChange
	return FSB_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
		#else
	return 1;
		#endif
}

//Hooked functions:
public FSB_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
{
	if(FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo] != INVALID_PLAYER_ID)
	{
		#if defined OnPlayerJackTeleporter
		OnPlayerJackTeleporter(FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo], FSB_Vehicle[vehicleid][FsbVOwner], vehicleid);
		#endif

		FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJacked]  = true;
		FSB_Player[FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo]][FsbJacking] = true;
		FSB_Vehicle[vehicleid][FsbPJack] = true;
			
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo], 3);
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", FSB_Vehicle[vehicleid][FsbVOwner], 4);
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", vehicleid, 5);

		ClearAnimations(FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbJtwo], 1);
		}

	return SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
}

public FSB_LinkVehicleToInterior(vehicleid, interiorid)
{
	if(FSB_Vehicle[vehicleid][FsbVOwner] != INVALID_PLAYER_ID && !FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbFakeTp])
	{
		FSB_Player[FSB_Vehicle[vehicleid][FsbVOwner]][FsbFakeTp] = true;
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", FSB_Vehicle[vehicleid][FsbVOwner], 2);
	}

	return LinkVehicleToInterior(vehicleid, interiorid);
}

public FSB_SetPlayerInterior(playerid, interiorid)
{
	if(!FSB_Player[playerid][FsbFakeTp])
	{
		FSB_Player[playerid][FsbFakeTp] = true;
		SetTimerEx("FSB_ProtectionHandle", FSB_MAX_PRORES, false, "ii", playerid, 2);
	}

	return SetPlayerInterior(playerid, interiorid);
}

//Inner callbacks:
public FSB_ProtectionHandle(handleid, caseid)
{ 
	switch(caseid)
	{
		case 1:
		{
			FSB_Player[handleid][FsbJtwo] 		= INVALID_PLAYER_ID;
		}
		case 2:
		{
			FSB_Player[handleid][FsbFakeTp] 	= false;
		}
		case 3:
		{
			FSB_Player[handleid][FsbJacking]	= false;
		}
		case 4:
		{
			FSB_Player[handleid][FsbJacked] 	= false;
		}
		case 5:
		{
			FSB_Vehicle[handleid][FsbPJack] 	= false;
		}
	}

	return 1;
}

public FSB_VehiclesReset()
{
    static const tmp2[MAX_VEHICLES] = {INVALID_PLAYER_ID,...}; 
    memcpy(FSB_Vehicle[MAX_VEHICLES-1][FsbVOwner], tmp2, 0, MAX_VEHICLES * 4); 

    for(new i, j = GetPlayerPoolSize(); i <= j; i++) 
    { 
        if(!IsPlayerConnected(i)) continue; 
        if(GetPlayerState(i)== PLAYER_STATE_DRIVER) 
        FSB_Vehicle[GetPlayerVehicleID(i)][FsbVOwner]=  i ; 
    } 
    
    return 1;
}

//Provided functions:
stock IsPlayerJackingTper(playerid) 	return FSB_Player[playerid][FsbJacking];
stock IsPlayerJackedTping(playerid) 	return FSB_Player[playerid][FsbJacked] ;
stock IsVehicleJackedTping(vehicleid) 	return FSB_Vehicle[vehicleid][FsbPJack];

//Inner functions:
static FSB_pPaused(playerid) 			return (GetTickCount() > (FSB_Player[playerid][FsbUTicks]+1500)) ? true : false;

//Hookings:
#if defined _ALS_SetVehiclePos
  #undef SetVehiclePos
#else
    #define _ALS_SetVehiclePos
#endif

#define SetVehiclePos FSB_SetVehiclePos

#if defined _ALS_SetPlayerInterior
  #undef SetPlayerInterior
#else
    #define _ALS_SetPlayerInterior
#endif

#define SetPlayerInterior FSB_SetPlayerInterior

#if defined _ALS_LinkVehicleToInterior
  #undef LinkVehicleToInterior
#else
    #define _ALS_LinkVehicleToInterior
#endif

#define LinkVehicleToInterior FSB_LinkVehicleToInterior

#if defined _ALS_OnPlayerInteriorChange
  #undef OnPlayerInteriorChange
#else
    #define _ALS_OnPlayerInteriorChange
#endif

#define OnPlayerInteriorChange FSB_OnPlayerInteriorChange

#if defined _ALS_OnPlayerDisconnect
  #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect FSB_OnPlayerDisconnect

#if defined _ALS_OnPlayerEnterVehicle
  #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif

#define OnPlayerEnterVehicle FSB_OnPlayerEnterVehicle

#if defined _ALS_OnPlayerUpdate
  #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate FSB_OnPlayerUpdate

#if defined _ALS_OnGameModeExit
  #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif

#define OnGameModeExit FSB_OnGameModeExit

#if defined _ALS_OnPlayerStateChange
  #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange FSB_OnPlayerStateChange

#if defined _ALS_OnGameModeInit
  #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif

#define OnGameModeInit FSB_OnGameModeInit

#if defined _ALS_OnPlayerSpawn
  #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif

#define OnPlayerSpawn FSB_OnPlayerSpawn

#else //Link filterscripts to the gamemode remotely:

stock FSB_FSetVehiclePos(vehicleid, Float:x, Float:y, Float:z)
	return CallRemoteFunction("FSB_SetVehiclePos", "ifff", vehicleid, Float:x, Float:y, Float:z);

stock FSB_FSetPlayerInterior(playerid, interiorid)
	return CallRemoteFunction("FSB_SetPlayerInterior", "ii", playerid, interiorid);

stock FSB_FLinkVehicleToInterior(vehicleid, interiorid)
	return CallRemoteFunction("FSB_LinkVehicleToInterior", "ii", vehicleid, interiorid);

#if defined _ALS_SetVehiclePos
  #undef SetVehiclePos
#else
    #define _ALS_SetVehiclePos
#endif

#define SetVehiclePos FSB_FSetVehiclePos

#if defined _ALS_SetPlayerInterior
  #undef SetPlayerInterior
#else
    #define _ALS_SetPlayerInterior
#endif

#define SetPlayerInterior FSB_FSetPlayerInterior

#if defined _ALS_LinkVehicleToInterior
  #undef LinkVehicleToInterior
#else
    #define _ALS_LinkVehicleToInterior
#endif

#define LinkVehicleToInterior FSB_FLinkVehicleToInterior

#endif
