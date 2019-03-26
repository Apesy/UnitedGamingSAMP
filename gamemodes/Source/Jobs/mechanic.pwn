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

new playerResprayTimer[MAX_PLAYERS];

CMD:mechanichelp(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Trucker Help:{FFFFFF} Type a command for more information.");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /call 555");
    if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
    {
        SendClientMessageEx(playerid, COLOR_GRAD4, "Commands: /repair, /respray, /tow");
    }
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

new RepairTime[MAX_PLAYERS], 
    RepairTimer[MAX_PLAYERS], 
    RepairVehicleID[MAX_PLAYERS],
    RepairTarget[MAX_PLAYERS];

CMD:repair(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "You are not a mechanic.");

    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You cannot be inside any vehicle.");

    new targetid;
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/repair [PlayerID/PartOfName]");

    if(targetid == playerid)
        return SendErrorMessage(playerid, "You cannot offer it to yourself.");

    if(!IsPlayerNearPlayer(playerid, targetid, 6.0))
        return SendErrorMessage(playerid, "You are too far away from this player.");

    if(!IsPlayerInAnyVehicle(targetid))
        return SendErrorMessage(playerid, "This player is not in their vehicle.");

    new i = GetPlayerVehicleID(targetid);
    if(HasNoEngine(GetVehicleModel(i)))
        return SendErrorMessage(playerid, "You cannot repair this type of vehicle.");

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
    if(engine == 1)
        return SendErrorMessage(playerid, "The vehicle engine must be off in order to repair it!");
    
    if(bonnet != 1)
        return SendErrorMessage(playerid, "The vehicle hood must be open.");

    new string[160+MAX_PLAYER_NAME];
    SendServerMessage(playerid, "You have sent %s a repair offer, please wait for their response.", GetRPName(targetid));
    format(string, sizeof string, "Mechanic %s wants to repair your vehicle.\n\
    Click \"Accept\" if you want the repair.\n\
    Click \"Deny\" if you don't want the repair.", GetRPName(playerid));
    Dialog_Show(targetid, RepairOffer, DIALOG_STYLE_MSGBOX, "Repair Offer", string, "Accept", "Deny");
    SetPVarInt(targetid, "MechanicID", playerid);
    RepairVehicleID[playerid] = i;
    return 1;
}

Dialog:RepairOffer(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new mechid = GetPVarInt(playerid, "MechanicID");
        if(mechid != INVALID_PLAYER_ID)
        {
            MechanicRepair(mechid, playerid);
        }
        else SendErrorMessage(playerid, "The offering mechanic went offline.");
    }
    return 1;
}


stock MechanicRepair(playerid, targetid)
{
    new vehicleid = RepairVehicleID[playerid];
    SendServerMessage(playerid, "%s has accepted your repair offer, repairing %s...", GetRPName(targetid), ReturnVehicleName(vehicleid));
    SendServerMessage(targetid, "You have accepted %s's repair offer, repairing %s...", GetRPName(playerid), ReturnVehicleName(vehicleid));
    TogglePlayerControllable(playerid, false);
    RepairTime[playerid] = 10;
    RepairTarget[playerid] = targetid;
    RepairTimer[playerid] = SetTimerEx("OnMechanicRepair", 1000, true, "d", playerid);
    return 1;
}

function OnMechanicRepair(playerid)
{
    new string[128];
    if(IsPlayerNearPlayer(playerid, RepairTarget[playerid], 6.0))
    {
        if(RepairTime[playerid] >= 1)
        {
            RepairTime[playerid]--;
            format(string, sizeof string, "~g~Repairing~n~~w~%d", RepairTime[playerid]);
            PrintFooter(playerid, string, 1);
        }
        else
        {
            KillTimer(RepairTimer[playerid]);
            RepairVehicle(RepairVehicleID[playerid]);
            TogglePlayerControllable(playerid, true);
            ToggleVehicleHood(RepairVehicleID[playerid], true);
            format(string, sizeof string, "You have repaired the ~g~%s~w~.", ReturnVehicleName(RepairVehicleID[playerid]));
            PrintFooter(playerid, string, 1);
            format(string, sizeof string, "Your ~g~%s~w~ has been repaired.", ReturnVehicleName(RepairVehicleID[playerid]));
            PrintFooter(RepairTarget[playerid], string, 1);
        }
    }
    else
    {
        SendErrorMessage(playerid,"You were out of range of the vehicle driver.");
        KillTimer(RepairTimer[playerid]);
    }
    return 1;
}

CMD:paintjob(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "You are not a mechanic.");
    
    new vehicle = GetVehicleID(GetClosestVehicle(playerid));
	if (!IsValidVehicleID(vehicle))
	{
		return SendErrorMessage(playerid, "There are no vehicles near you to color.");
	}
    if (IsPlayerInAnyVehicle(playerid))
	{
		return SendErrorMessage(playerid, "You cannot do this while inside a vehicle.");
	}
	new paintjob, confirmStr[24];
	if (sscanf(params, "is[24]", paintjob, confirmStr) || strcmp(confirmStr, "confirm", true))
	{
		SendUsageMessage(playerid, "The vehicle to be recolored is a %s (ID %i), confirm if this is correct.", ReturnVehicleName(VehicleInfo[vehicle][vScriptID]), VehicleInfo[vehicle][vScriptID]);
        SendUsageMessage(playerid, "Make sure that there is a driver inside the vehicle.");
		return SendUsageMessage(playerid, "/respray [Colour 1] [Colour 2] [Confirm] - See /colours for a list of vehicle colours.");
	}

    if (paintjob < 0 || paintjob > 3)
		return SendErrorMessage(playerid, "Paintjob ID needs to be between 0 (0, 1, 2 valid) and 3 (remove).");
    
    if(VehicleInfo[vehicle][vFactionID] > 0)
        return SendErrorMessage(playerid, "You cannot do this to faction vehicles.");

    if(GetVehicleDriver(VehicleInfo[vehicle][vScriptID]) == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Make sure the vehicle is occupied.");
    
    if(PlayerHasWeapon(playerid, 41))
    {
        GetPlayerWeaponData(playerid, 9, TempVar[playerid][BeforeSprayWep], TempVar[playerid][BeforeSprayAmmo]);
        TempVar[playerid][BeforeSpraySerial] = PlayerInfo[playerid][pSerial][9];
    }

    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Spray at the vehicle using your spray can.");
    SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: Using this spray can as a weapon will result in admin punishment.");
    TempVar[playerid][IsSprayingVehicle] = true;
    TempVar[playerid][SprayingVehicle] = vehicle;
    TempVar[playerid][SprayingVehicleCounter] = 10;
    TempVar[playerid][SprayingVehiclePaintjob] = paintjob;
    TempVar[playerid][SprayingVehicleColour1] = 0;
    TempVar[playerid][SprayingVehicleColour2] = 0;
    GivePlayerGun(playerid, 41, 99999, 0, false);
    return 1;
}

CMD:respray(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "You are not a mechanic.");
    
    new vehicle = GetVehicleID(GetClosestVehicle(playerid));
	if (!IsValidVehicleID(vehicle))
	{
		return SendErrorMessage(playerid, "There are no vehicles near you to color.");
	}
    if (IsPlayerInAnyVehicle(playerid))
	{
		return SendErrorMessage(playerid, "You cannot do this while inside a vehicle.");
	}
	new color1, color2, confirmStr[24];
	if (sscanf(params, "iis[24]", color1, color2, confirmStr) || strcmp(confirmStr, "confirm", true))
	{
		SendUsageMessage(playerid, "The vehicle to be recolored is a %s (ID %i), confirm if this is correct.", ReturnVehicleName(VehicleInfo[vehicle][vScriptID]), VehicleInfo[vehicle][vScriptID]);
        SendUsageMessage(playerid, "Make sure that there is a driver inside the vehicle.");
		return SendUsageMessage(playerid, "/respray [Colour 1] [Colour 2] [Confirm] - See /colours for a list of vehicle colours.");
	}

    if (0 > color1 > 255 || 0 > color2 > 255)
		return SendErrorMessage(playerid, "Colours need to be between 0 and 255.");
    
    if(VehicleInfo[vehicle][vFactionID] > 0)
        return SendErrorMessage(playerid, "You cannot do this to faction vehicles.");

    if(GetVehicleDriver(VehicleInfo[vehicle][vScriptID]) == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Make sure the vehicle is occupied.");
    
    if(PlayerHasWeapon(playerid, 41))
    {
        GetPlayerWeaponData(playerid, 9, TempVar[playerid][BeforeSprayWep], TempVar[playerid][BeforeSprayAmmo]);
        PlayerInfo[playerid][pSerial] = TempVar[playerid][BeforeSpraySerial];
    }

    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Spray at the vehicle using your spray can.");
    SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: Using this spray can as a weapon will result in admin punishment.");
    TempVar[playerid][IsSprayingVehicle] = true;
    TempVar[playerid][SprayingVehicle] = vehicle;
    TempVar[playerid][SprayingVehicleCounter] = 10;
    TempVar[playerid][SprayingVehicleColour1] = color1;
    TempVar[playerid][SprayingVehicleColour2] = color2;
    GivePlayerGun(playerid, 41, 99999, 0, false);
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(TempVar[playerid][IsSprayingVehicle] == true)
    {
        if(PRESSED( KEY_FIRE ) && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && TempVar[playerid][SprayingVehicle] != -1)
        {
            if(IsPlayerNearVehicle(playerid, VehicleInfo[TempVar[playerid][SprayingVehicle]][vScriptID], 5))
            {
                playerResprayTimer[playerid] = SetTimerEx("OnPlayerResprayVehicle", 1000, true, "ii", playerid, TempVar[playerid][SprayingVehicle]);
            }
        }
        
        if(RELEASED( KEY_FIRE ) && GetPlayerWeapon(playerid) == WEAPON_SPRAYCAN && TempVar[playerid][SprayingVehicle] != -1)
        {
            KillTimer( playerResprayTimer[playerid] ); 
            TempVar[playerid][SprayingVehicle] = -1;
            TempVar[playerid][IsSprayingVehicle] = false;
            RemovePlayerWeapon(playerid, 41);
            if(TempVar[playerid][BeforeSprayWep] > 0)
            {
                GivePlayerGun(playerid, TempVar[playerid][BeforeSprayWep], TempVar[playerid][BeforeSprayAmmo], TempVar[playerid][BeforeSpraySerial], false);
            }
            PrintFooter(playerid, "~w~Spraying ~n~~r~Stopped", 3); 
        }
    }
    return 1;
}

function OnPlayerResprayVehicle(playerid, vehicle)
{
    new sprayCounter, counter[60];

	sprayCounter = TempVar[playerid][SprayingVehicleCounter];

	if(IsPlayerNearVehicle(playerid, VehicleInfo[vehicle][vScriptID], 5))
	{
		sprayCounter--;
		TempVar[playerid][SprayingVehicleCounter] = sprayCounter;
		
		format(counter, sizeof counter, "~w~Spraying~n~~r~%d", sprayCounter);
		PrintFooter(playerid, counter, 1);
		
		if(sprayCounter <= 0)
		{
            if(TempVar[playerid][IsSprayingVehicle] == true)
//            if(TempVar[playerid][SprayingVehiclePaintjob] != -1)
			{
                VehicleInfo[vehicle][vColour1] = TempVar[playerid][SprayingVehicleColour1];
                VehicleInfo[vehicle][vColour2] = TempVar[playerid][SprayingVehicleColour2];
                ChangeVehicleColor(VehicleInfo[vehicle][vScriptID], VehicleInfo[vehicle][vColour1], VehicleInfo[vehicle][vColour2]);
            }
            if(TempVar[playerid][SprayingVehiclePaintjob] != -1)
          //else
            {
                ChangeVehiclePaintjob(VehicleInfo[vehicle][vScriptID], TempVar[playerid][SprayingVehiclePaintjob]);
            }
            SaveVehicle(vehicle);
			KillTimer( playerResprayTimer[playerid] );
            TempVar[playerid][SprayingVehicle] = -1;
            TempVar[playerid][SprayingVehiclePaintjob] = -1;
            TempVar[playerid][SprayingVehicleColour1] = 0;
            TempVar[playerid][SprayingVehicleColour2] = 0;
            TempVar[playerid][IsSprayingVehicle] = false;
            RemovePlayerWeapon(playerid, 41);
            if(TempVar[playerid][BeforeSprayWep] > 0)
            {
                GivePlayerGun(playerid, TempVar[playerid][BeforeSprayWep], TempVar[playerid][BeforeSprayAmmo], TempVar[playerid][BeforeSpraySerial], false);
            }
			PrintFooter(playerid, "~g~Sprayed", 2);
		}
	}
	else
	{
		KillTimer(playerResprayTimer[playerid]);
        TempVar[playerid][SprayingVehicle] = -1;
        TempVar[playerid][IsSprayingVehicle] = false;
        RemovePlayerWeapon(playerid, 41);
        if(TempVar[playerid][BeforeSprayWep] > 0)
        {
            GivePlayerGun(playerid, TempVar[playerid][BeforeSprayWep], TempVar[playerid][BeforeSprayAmmo], TempVar[playerid][BeforeSpraySerial], false);
        }
        PrintFooter(playerid, "~w~Spraying ~n~~r~Stopped", 3); 
	}
}

hook OnPlayerConnect(playerid)
{
    if(playerResprayTimer[playerid])
    {
        KillTimer(playerResprayTimer[playerid]);
    }
    KillTimer(RepairTimer[playerid]);
    RepairTime[playerid] = 0;
    RepairVehicleID[playerid] = INVALID_VEHICLE_ID;
    RepairTarget[playerid] = INVALID_PLAYER_ID;
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    KillTimer(playerResprayTimer[playerid]);
    KillTimer(RepairTimer[playerid]);
    return 1;
}