/*
    Anti Vehicle TP
    Filterscript originally created by Berbras on SA-MP forums.
    Converted into include by Seanny for use on United Gaming Roleplay.
*/

#include <a_samp>

#define USE_Y_TIMER
#tryinclude <YSI\y_timers>

#if !defined task
	#undef USE_Y_TIMER
#endif

#if !defined MAX_VEHICLE_DISTANCE_TO_TRAILER
    #define MAX_VEHICLE_DISTANCE_TO_TRAILER	50
#endif

#if !defined MAX_VEHICLE_DISTANCE_CHANGE
    #define MAX_VEHICLE_DISTANCE_CHANGE	50
#endif

// Check if IsValidVehicle exists, if not then define it.
#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

hook OnGameModeInit()
{
	#if !defined USE_Y_TIMER
	SetTimer("AVT_OccupiedVehicleUpdate", 1000, true);
	#endif
	
	return 1;
}

new Float:RealVehiclePositions[MAX_VEHICLES][3];
new LastPullingVehicle[MAX_VEHICLES];

stock AVT_IsVehicleOccupied(vehicleid)
{
    for(new i; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerInVehicle(i,vehicleid))
        {
            return 1;
        }
    }
	return 0;
}

#if defined USE_Y_TIMER
task AVT_OccupiedVehicleUpdate[1000]()
#else
forward AVT_OccupiedVehicleUpdate();
public AVT_OccupiedVehicleUpdate()
#endif
{
	for(new i; i < GetVehiclePoolSize(); i++)
	{
		if(AVT_IsVehicleOccupied(i))
		{
			GetVehiclePos(i, RealVehiclePositions[i][0], RealVehiclePositions[i][1], RealVehiclePositions[i][2]);
		}
	}
	return 1;
}

stock AVT_AttachTrailerToVehicle(trailerid,vehicleid)
{
	LastPullingVehicle[trailerid] = vehicleid;
	return AttachTrailerToVehicle(trailerid, vehicleid);
}
#if defined _ALS_AttachTrailerToVehicle
	#undef AttachTrailerToVehicle
#else
	#define _ALS_AttachTrailerToVehicle
#endif
#define AttachTrailerToVehicle AVT_AttachTrailerToVehicle

stock AVT_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	return SetVehiclePos(vehicleid, x, y, z);
}
#if defined _ALS_SetVehiclePos
	#undef SetVehiclePos
#else
	#define _ALS_SetVehiclePos
#endif
#define SetVehiclePos AVT_SetVehiclePos

#if defined AVT_OnVehicleSpawn
	forward AVT_OnVehicleSpawn(vehicleid);
#endif

public OnVehicleSpawn(vehicleid)
{
    GetVehiclePos(vehicleid, RealVehiclePositions[vehicleid][0], RealVehiclePositions[vehicleid][1], RealVehiclePositions[vehicleid][2]);
    #if defined AVT_OnVehicleSpawn
	return AVT_OnVehicleSpawn(vehicleid);
	#else
	return 1;
	#endif
}
#if defined _ALS_OnVehicleSpawn
	#undef OnVehicleSpawn
#else
	#define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn AVT_OnVehicleSpawn

#if defined AVT_OnUnoccupiedVehicleUpdate
	forward AVT_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
#endif

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	new Float:x,Float:y,Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	if(RealVehiclePositions[vehicleid][0] == 0.0 && RealVehiclePositions[vehicleid][1] == 0.0 && RealVehiclePositions[vehicleid][2] == 0.0)//Perhaps the gamemode is just started and there are no last positions
	{
		RealVehiclePositions[vehicleid][0] = x;
		RealVehiclePositions[vehicleid][1] = y;
		RealVehiclePositions[vehicleid][2] = z;
		return 1;
	}
	if(AVT_IsTrailer(vehicleid)) // If the vehicle is a trailer.
	{
		if(IsValidVehicle(LastPullingVehicle[vehicleid])) //If the pulling vehicle(truck) is still a valid vehicle(it exists)
		{
			new Float:distance = GetVehicleDistanceFromPoint(LastPullingVehicle[vehicleid], x,y,z);
			if(distance <= MAX_VEHICLE_DISTANCE_TO_TRAILER) //If the distance is smallen then defined, we assume that the trailer was lost and someone might still be trying to re-attach it
			{
				RealVehiclePositions[vehicleid][0] = x;
				RealVehiclePositions[vehicleid][1] = y;
				RealVehiclePositions[vehicleid][2] = z;
				return 1;
			}
		}
	}
	new Float:distance = GetVehicleDistanceFromPoint(vehicleid,RealVehiclePositions[vehicleid][0],RealVehiclePositions[vehicleid][1],RealVehiclePositions[vehicleid][2]);
	if(distance > MAX_VEHICLE_DISTANCE_CHANGE) //If the vehicle is further from its' last set position than 50, we set it back.
	{
        new userName[MAX_PLAYER_NAME+1];
        GetPlayerName(playerid, userName, sizeof(userName));
		SetVehiclePos(vehicleid,RealVehiclePositions[vehicleid][0],RealVehiclePositions[vehicleid][1],RealVehiclePositions[vehicleid][2]);
		return 1;
	}
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	#if defined AVT_OnUnoccupiedVehicleUpdate
	return AVT_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, new_x, new_y, new_z, vel_x, vel_y, vel_z);
	#else
	return 1;
	#endif
}
#if defined _ALS_OnUnoccupiedVehicleUpdate
	#undef OnUnoccupiedVehicleUpdate
#else
	#define _ALS_OnUnoccupiedVehicleUpdate
#endif
#define OnUnoccupiedVehicleUpdate AVT_OnUnoccupiedVehicleUpdate

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	// For accuracy we set the real position when a vehicle becomes unoncucupied
	new Float:x,Float:y,Float:z;
	GetVehiclePos(vehicleid,x,y,z);
	RealVehiclePositions[vehicleid][0] = x;
	RealVehiclePositions[vehicleid][1] = y;
	RealVehiclePositions[vehicleid][2] = z;
	return 1;
}
#if defined _ALS_OnPlayerExitVehicle
	#undef OnPlayerExitVehicle
#else
	#define _ALS_OnPlayerExitVehicle
#endif
#define OnPlayerExitVehicle AVT_OnPlayerExitVehicle

public OnPlayerDisconnect(playerid, reason)
{
	if(GetPlayerVehicleID(playerid) > 0)
	{
	    //For accuracy aswell
        new Float:x,Float:y,Float:z,vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid,x,y,z);
		RealVehiclePositions[vehicleid][0] = x;
		RealVehiclePositions[vehicleid][1] = y;
		RealVehiclePositions[vehicleid][2] = z;
	}
	#if defined AVT_OnPlayerDisconnect
	return AVT_OnPlayerDisconnect(playerid, reason);
	#else
	return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect AVT_OnPlayerDisconnect

// Forwards
forward AVT_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
forward AVT_OnPlayerDisconnect(playerid, reason);
forward AVT_OnPlayerExitVehicle();
forward AVT_OnVehicleSpawn(vehicleid);

// Internal Stock Functions
stock AVT_IsTrailer(vehicleid)
{
	new model = GetVehicleModel(vehicleid);
	switch(model)
	{
		case 435,450,584,591,611,610: return true;
		default: return false;
	}
	return false;

}