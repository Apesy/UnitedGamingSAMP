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

new VehicleTrash[MAX_VEHICLES];
new HasTrash[MAX_PLAYERS];
new TrashVehicle[3];

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 16768, 187.4141, 1188.3594, 19.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 1522, 174.5000, 1176.6563, 13.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 1522, 172.0078, 1178.3750, 13.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 16767, 187.4141, 1188.3594, 19.7500, 0.25);
    HasTrash[playerid] = 0;
}

hook OnGameModeInit()
{
    for(new i; i < MAX_VEHICLES; i++)
    {
        VehicleTrash[i] = 0;
    }

    CreateDynamicObject(4100, 173.25046, 1159.03015, 15.08559,   0.00000, 0.00000, -60.54000);
    CreateDynamicObject(4100, 183.72803, 1162.39941, 15.08559,   0.00000, 0.00000, 12.72001);
    CreateDynamicObject(4100, 191.70113, 1173.52576, 15.08559,   0.00000, 0.00000, 16.26001);
    CreateDynamicObject(4100, 199.94684, 1184.47595, 15.08559,   0.00000, 0.00000, 10.50000);
    CreateDynamicObject(4100, 197.57294, 1192.30078, 15.08559,   0.00000, 0.00000, 117.84001);
    CreateDynamicObject(4100, 184.33875, 1195.44446, 15.08559,   0.00000, 0.00000, 135.12007);
    CreateDynamicObject(4100, 170.64912, 1195.61890, 15.08559,   0.00000, 0.00000, 143.64008);
    CreateDynamicObject(4100, 156.96646, 1194.79395, 15.08559,   0.00000, 0.00000, 143.64008);
    CreateDynamicObject(4100, 149.80659, 1187.27734, 15.08559,   0.00000, 0.00000, 225.42001);
    CreateDynamicObject(4100, 152.56541, 1174.37695, 15.08559,   0.00000, 0.00000, 257.58011);
    CreateDynamicObject(18248, 177.28558, 1185.81396, 21.72811,   0.00000, 0.00000, 185.88039);
    CreateDynamicObject(18249, 168.13742, 1188.82397, 17.41185,   0.00000, 0.00000, -90.60001);
    CreateDynamicObject(3626, 180.64478, 1163.87109, 15.19669,   0.00000, 0.00000, 231.54012);
    CreateDynamicObject(18862, 189.97810, 1188.12280, 17.03252,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(4100, 152.56541, 1174.37695, 17.91004,   0.00000, 0.00000, 257.58011);
    CreateDynamicObject(4100, 149.80659, 1187.27734, 17.86549,   0.00000, 0.00000, 225.42001);
    CreateDynamicObject(4100, 156.96646, 1194.79395, 17.79760,   0.00000, 0.00000, 143.64008);
    CreateDynamicObject(4100, 170.64909, 1195.61890, 17.75260,   0.00000, 0.00000, 143.64011);
    CreateDynamicObject(4100, 184.33870, 1195.44446, 17.68900,   0.00000, 0.00000, 135.12010);
    CreateDynamicObject(4100, 197.57291, 1192.30078, 17.63060,   0.00000, 0.00000, 117.84000);
    CreateDynamicObject(4100, 199.94679, 1184.47595, 17.56290,   0.00000, 0.00000, 10.50000);
    CreateDynamicObject(4100, 191.70110, 1173.52576, 17.51470,   0.00000, 0.00000, 16.26000);
    CreateDynamicObject(4100, 183.72803, 1162.39941, 17.46768,   0.00000, 0.00000, 12.72001);
    CreateDynamicObject(4100, 173.25046, 1159.03015, 17.40433,   0.00000, 0.00000, -60.54000);

    TrashVehicle[0] = AddStaticVehicleEx(408, 156.6657, 1180.1381, 15.6610, 178.6969, -1, -1, 100);
    TrashVehicle[1] = AddStaticVehicleEx(408, 160.7099, 1180.0640, 15.3580, 178.6969, -1, -1, 100);
    TrashVehicle[2] = AddStaticVehicleEx(408, 164.8552, 1179.8828, 15.2600, 178.6969, -1, -1, 100);

    CreateDynamic3DTextLabel("Trash Unload\n{FFFFFF}/dumptrash", 0xFFFF00FF, 183.4043,1174.4602,15.2950, 20.0);

    new string[32];
    for(new i; i < sizeof(TrashVehicle); i++)
    {
        format(string, sizeof string, "TRASH %d", i+1);
        SetVehicleNumberPlate(TrashVehicle[i], string);
        SetVehicleToRespawn(TrashVehicle[i]);
    }
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger && PlayerInfo[playerid][pJob] != JOB_TRASH)
    {
        for(new i; i < sizeof(TrashVehicle); i++)
        {
            if(TrashVehicle[i] == vehicleid)
            {
                ClearAnimations(playerid);
                return SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a trash collector.");
            }
        }
    }
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        for(new i; i < sizeof(TrashVehicle); i++)
        {
            if(TrashVehicle[i] == GetPlayerVehicleID(playerid))
            {
                if(PlayerInfo[playerid][pJob] != JOB_TRASH)
                {
                    SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a trash collector.");
                    new Float:slx, Float:sly, Float:slz;
                    GetPlayerPos(playerid, slx, sly, slz);
                    SetPlayerPosEx(playerid, slx, sly, slz+1.3);
                    RemovePlayerFromVehicle(playerid);
                    SetTimerEx("OnTrashVehNOPCheck", 2000, false, "dd", playerid, TrashVehicle[i]);
                }
                return 1;
            }
        }
    }
    return 1;
}

function OnTrashVehNOPCheck(playerid, vehicleid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
			if(Player[playerid][AdminLevel] < 1 && PlayerInfo[playerid][pJob] != JOB_TRASH)
			{
				new string[128];
				format(string, sizeof string, "%s (ID: %d) may be NOP hacking - inside trash master whilst not a trash collector.", GetUserName(playerid), playerid);
				SendAdminWarning(1, string);
				format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - inside trash master whilst not a trash collector.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Hack", string);
			}
        }
    }
    return 1;
}

stock IsATrashmaster(vehicleid)
{
    new vmodel = GetVehicleModel(vehicleid);
    if(vmodel == 408)
    {
        return 1;
    }
    return 0;
}

CMD:trashhelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_TRASH)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Trash Collector Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Go to the Trash Collector Job place and then enter a Trash Master.");
        SendClientMessageEx(playerid, COLOR_GRAD4, "Once you are in a Trash Master, go around the Town and look for Garbage Bins");
        SendClientMessageEx(playerid, COLOR_GRAD3, "If a garbage bin has a capacity of 1 or more, you can type /collecttrash which ...");
        SendClientMessageEx(playerid, COLOR_GRAD2, "... you will then place the trash in the trash master.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:collecttrash(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_TRASH)
    {
        new id = Garbage_Nearest(playerid), string[128];
        if(id == -1)
            return SendErrorMessage(playerid, "You are not near a garbage bin.");
        
        new amount = GetTrashAmount(id);
        if(amount >= 1)
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC))
                RemovePlayerAttachedObject(playerid, SLOT_MISC);
            
            SetPlayerAttachedObject(playerid,SLOT_MISC,1265,5,0.189999,-0.144999,0.198999,0.000000,-115.699989,91.299980,1.000000,1.000000,1.000000);
            HasTrash[playerid] = amount;
            format(string, sizeof(string), "Garbage Bin\n{FFFFFF}Capacity: 0/%d", MAX_TRASH_INVENTORY);
            UpdateDynamic3DTextLabelText(GarbageData[id][garbageText3D], COLOR_DEPT, string);
            ResetTrashInventory(id);
        }
    }
    else SendErrorMessage(playerid, "You are not a trash collector (/findjob).");
    return 1;
}

CMD:puttrash(playerid, params[])
{
    if(HasTrash[playerid] >= 1)
    {
        for(new i; i < sizeof(TrashVehicle); i++)
        {
            if(IsPlayerNearVehicle(playerid, TrashVehicle[i], 10.0))
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_MISC))
                    RemovePlayerAttachedObject(playerid, SLOT_MISC);
                
                VehicleTrash[TrashVehicle[i]] = HasTrash[playerid];
                HasTrash[playerid] = 0;

                if(VehicleTrash[TrashVehicle[i]] >= 100)
                {
                    SendServerMessage(playerid, "The trash master is now full up, go back to the trash dump to unload it (/dumptrash).");
                    DisablePlayerCheckpoint(playerid);
                    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND;
                    SetPlayerCheckpoint(playerid, 183.4043,1174.4602,15.2950, 10.0);
                }
                else SendServerMessage(playerid, "You should find more trash cans to collect or go back to the trash dump (/dumptrash).");
                return 1;
            }
        }
        SendErrorMessage(playerid, "You are not near a trash master.");
    }
    return 1;
}

CMD:dumptrash(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 183.4043,1174.4602,15.2950))
    {
        for(new i; i < sizeof(TrashVehicle); i++)
        {
            if(GetPlayerVehicleID(playerid) == TrashVehicle[i])
            {
                if(VehicleTrash[TrashVehicle[i]] < 1)
                    return SendErrorMessage(playerid, "The trash master is empty, go collect some trash.");

                TogglePlayerControllable(playerid, true);
                SetTimerEx("UnloadTrash", 5000, false, "dd", playerid, TrashVehicle[i]);
                PrintFooter(playerid, "Unloading Trash...", 5);
                return 1;
            }
        }
    }
    return 1;
}

function UnloadTrash(playerid, vehicleid)
{
    new amount = random(15)+10+VehicleTrash[vehicleid];
    PlayerInfo[playerid][pPayCheque] += amount;
    SendActionMessage(playerid, "You have earned $%d for completing this run. You will recieve it on next PayDay.", amount);
    return 1;
}