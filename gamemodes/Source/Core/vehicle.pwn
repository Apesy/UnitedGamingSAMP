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

#define MAX_VEHICLE_INVENTORY 10

enum vehInventoryEnum
{
    InventoryID,
    InventoryType,
    InventoryWeaponID,
    InventoryAmount,
    InventoryWeight,
    InventorySerial
};
new VehInventoryInfo[MAX_VEHICLE_INVENTORY][MAX_DYN_VEH][vehInventoryEnum];

function LoadVehicleInventory(vehicleid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `Vehicle_Inventory` WHERE `VehicleID` = %d LIMIT %d", VehicleInfo[vehicleid][vID], MAX_VEHICLE_INVENTORY);
    mysql_tquery(g_SQL, query, "OnLoadVehicleInventory", "d", vehicleid);
}

function OnLoadVehicleInventory(vehicleid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", VehInventoryInfo[i][vehicleid][InventoryID]);
            cache_get_value_int(i, "Type", VehInventoryInfo[i][vehicleid][InventoryType]);
            cache_get_value_int(i, "WeaponID", VehInventoryInfo[i][vehicleid][InventoryWeaponID]);
            cache_get_value_int(i, "Amount", VehInventoryInfo[i][vehicleid][InventoryAmount]);
            cache_get_value_int(i, "Weight", VehInventoryInfo[i][vehicleid][InventoryWeight]);
            cache_get_value_int(i, "Serial", VehInventoryInfo[i][vehicleid][InventorySerial]);
        }
    }
    return 1;
}

hook OnGameModeInit()
{
    for(new i; i < MAX_DYN_VEH; i++)
    {
        ResetVehicleVars(i);
    }
    return 1;
}

stock RemoveVehicleInventory(vehicleid, slot)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "DELETE FROM `Vehicle_Inventory` WHERE `ID` = %d", VehInventoryInfo[slot][vehicleid][InventoryID]);
    mysql_tquery(g_SQL, query, "OnRemoveVehicleInventory", "dd", vehicleid, slot);
}

function OnRemoveVehicleInventory(vehicleid, slot)
{
    VehInventoryInfo[slot][vehicleid][InventoryID] = 0;
    VehInventoryInfo[slot][vehicleid][InventoryWeaponID] = 0;
    VehInventoryInfo[slot][vehicleid][InventoryAmount] = 0;
    VehInventoryInfo[slot][vehicleid][InventoryType] = INV_NONE;
    return 1;
}

stock ResetVehicleInventory(vehicleid)
{
    for(new i; i < MAX_VEHICLE_INVENTORY; i++)
    {
        VehInventoryInfo[i][vehicleid][InventoryID] = 0;
        VehInventoryInfo[i][vehicleid][InventoryType] = 0;
        VehInventoryInfo[i][vehicleid][InventoryWeaponID] = 0;
        VehInventoryInfo[i][vehicleid][InventoryAmount] = 0;
        VehInventoryInfo[i][vehicleid][InventoryWeight] = 0;
        VehInventoryInfo[i][vehicleid][InventorySerial] = 0;
    }
}

stock AddVehicleInventory(vehicleid, type, amount, weaponid = 0, serial = 0)
{
    for(new i; i < MAX_VEHICLE_INVENTORY; i++)
    {
        if(VehInventoryInfo[i][vehicleid][InventoryType] == INV_NONE)
        {
            new query[128];
            mysql_format(g_SQL, query, sizeof query, "INSERT INTO `Vehicle_Inventory` (`Type`, `WeaponID`, `Amount`, `Serial`, `VehicleID`) VALUES (%d, %d, %d, %d, %d)", type, weaponid, amount, serial, VehicleInfo[vehicleid][vID]);
            mysql_tquery(g_SQL, query, "OnAddVehInventory", "dddddd", vehicleid, i, type, weaponid, amount, serial);
            return 1;
        }
    }
    return 0;
}

function OnAddVehInventory(vehicleid, slot, type, weaponid, amount, serial)
{
    VehInventoryInfo[slot][vehicleid][InventoryID] = cache_insert_id();
    VehInventoryInfo[slot][vehicleid][InventoryType] = type;
    VehInventoryInfo[slot][vehicleid][InventoryWeaponID] = weaponid;
    VehInventoryInfo[slot][vehicleid][InventoryAmount] = amount;
    VehInventoryInfo[slot][vehicleid][InventorySerial] = serial;
    return 1;
}

function PrintVehicleInventory(playerid, vehicleid)
{
    new result[128*(MAX_VEHICLE_INVENTORY+1)];
    format(result, sizeof result, "Name\t\tAmount");
    for(new i; i < MAX_VEHICLE_INVENTORY; i++)
    {
        if(VehInventoryInfo[i][vehicleid][InventoryType] != INV_NONE)
        {
            switch(VehInventoryInfo[i][vehicleid][InventoryType])
            {
                case INV_GUN:
                {
                    if(VehInventoryInfo[i][vehicleid][InventoryWeaponID] > 0)
                    {
                        if(VehInventoryInfo[i][vehicleid][InventoryAmount] > 0)
                        {
                            format(result, sizeof result, "%s\n%s\t\t%d bullets", result, GetServerWeaponName(VehInventoryInfo[i][vehicleid][InventoryWeaponID]), VehInventoryInfo[i][vehicleid][InventoryAmount]);
                        }
                        else
                        {
                            format(result, sizeof result, "%s\n%s\t\tEmpty", result, GetServerWeaponName(VehInventoryInfo[i][vehicleid][InventoryWeaponID]));
                        }
                    }
                    else
                    {
                        format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
                    }
                }
                case INV_WEED:
                {
                    if(VehInventoryInfo[i][vehicleid][InventoryAmount] > 0)
                    {
                        format(result, sizeof result, "%s\nWeed\t\t%d grams", result, VehInventoryInfo[i][vehicleid][InventoryAmount]);
                    }
                    else format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
                }
                case INV_WEED_SEED:
                {
                    if(VehInventoryInfo[i][vehicleid][InventoryAmount] > 0)
                    {
                        format(result, sizeof result, "%s\nWeed Seeds\t\t%d seeds", result, VehInventoryInfo[i][vehicleid][InventoryAmount]);
                    }
                    else format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
                }
                case INV_COCAINE:
                {
                    if(VehInventoryInfo[i][vehicleid][InventoryAmount] > 0)
                    {
                        format(result, sizeof result, "%s\nCocaine\t\t%d grams", result, VehInventoryInfo[i][vehicleid][InventoryAmount]);
                    }
                    else format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
                }
                case INV_RADIO:
                {
                    if(VehInventoryInfo[i][vehicleid][InventoryAmount] > 0)
                    {
                        format(result, sizeof result, "%s\nRadio\t\t%d", result, VehInventoryInfo[i][vehicleid][InventoryAmount]);
                    }
                    else format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
                }
                default: format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
            }
        }
        else format(result, sizeof result, "%s\nEmpty\t\tEmpty", result);
    }
    new title[32];
    SetPVarInt(playerid, "VehicleID", vehicleid);
    format(title, sizeof title, "%s Inventory", ReturnVehicleName(VehicleInfo[vehicleid][vScriptID]));
    TempVar[playerid][InventorySelectType] = 1;
    Dialog_Show(playerid, Vehicle_Inventory, DIALOG_STYLE_TABLIST_HEADERS, title, result, "Take", "Exit");
    return 1;
}

Dialog:Vehicle_Inventory(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = listitem, vid = GetPVarInt(playerid, "VehicleID");
        if(VehInventoryInfo[i][vid][InventoryType] != INV_NONE)
        {
            switch(VehInventoryInfo[i][vid][InventoryType])
            {
                case INV_GUN:
                {
                    if(VehInventoryInfo[i][vid][InventoryWeaponID] > 0 && VehInventoryInfo[i][vid][InventoryAmount] > 0)
                    {
                        if(IsWeaponRestricted(playerid))
                            return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                        GivePlayerGun(playerid, VehInventoryInfo[i][vid][InventoryWeaponID], VehInventoryInfo[i][vid][InventoryAmount], VehInventoryInfo[i][vid][InventorySerial]);
                        RemoveVehicleInventory(vid, i);
                    }
                    else SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED:
                {
                    if(VehInventoryInfo[i][vid][InventoryAmount] > 0)
                    {
                        
                    }
                    else SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED_SEED:
                {
                    if(VehInventoryInfo[i][vid][InventoryAmount] > 0)
                    {
                        
                    }
                    else SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_COCAINE:
                {
                    if(VehInventoryInfo[i][vid][InventoryAmount] > 0)
                    {
                        
                    }
                    else SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
            }
        }
    }
    return 1;
}

new FooterTimer[MAX_PLAYERS], KeyActionTimer[MAX_PLAYERS];

stock PrintFooter(playerid, text[], time = 7)
{
	if (FooterTimer[playerid])
	{
        KillTimer(FooterTimer[playerid]);
		HideFooter(playerid);
	}
	
    FooterTimer[playerid] = SetTimerEx("HideFooter", time*1000, false, "d", playerid);
	
	PlayerTextDrawSetString(playerid, Footer[playerid], text);
	PlayerTextDrawShow(playerid, Footer[playerid]);
	return 1;
}

function HideFooter(playerid)
{
    KillTimer(FooterTimer[playerid]);
    PlayerTextDrawHide(playerid, Footer[playerid]);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(FooterTimer[playerid])
    {
        KillTimer(FooterTimer[playerid]);
    }
    return 1;
}

new RepairShop[MAX_PLAYERS], RepairID[MAX_PLAYERS];
hook OnPlayerConnect(playerid)
{
    KillTimer(FooterTimer[playerid]);
    KeyActionTimer[playerid] = 0;
    RepairShop[playerid] = -1;
    return 1;
}

stock Float:GetVehicleSpeed(vehicleid)
{
    // http://forum.sa-mp.com/showpost.php?p=2646780&postcount=22
    new Float: vx, Float: vy, Float: vz, Float: vel;
    vel = GetVehicleVelocity(vehicleid, vx, vy, vz);
    vel = (floatsqroot(((vx*vx)+(vy*vy))+(vz*vz))* 181.5);
    return vel;
}

stock GenerateRandomVehiclePlate()
{
	new plate[32];
	for(new i = 0; i < 7; i++)
	{
		new type = random(2);

		switch(type)
		{
			case 0:
			{
				new number[8];
				format(number, sizeof(number), "%i", random(10));
				strins(plate, number, i);
			}

			case 1:
			{
				new letter = random(26);
				switch(letter)
				{
					case 0: strins(plate, "A", i);
					case 1: strins(plate, "B", i);
					case 2: strins(plate, "C", i);
					case 3: strins(plate, "D", i);
					case 4: strins(plate, "E", i);
					case 5: strins(plate, "F", i);
					case 6: strins(plate, "G", i);
					case 7: strins(plate, "H", i);
					case 8: strins(plate, "I", i);
					case 9: strins(plate, "J", i);
					case 10: strins(plate, "K", i);
					case 11: strins(plate, "L", i);
					case 12: strins(plate, "M", i);
					case 13: strins(plate, "N", i);
					case 14: strins(plate, "O", i);
					case 15: strins(plate, "P", i);
					case 16: strins(plate, "Q", i);
					case 17: strins(plate, "R", i);
					case 18: strins(plate, "S", i);
					case 19: strins(plate, "T", i);
					case 20: strins(plate, "U", i);
					case 21: strins(plate, "V", i);
					case 22: strins(plate, "W", i);
					case 23: strins(plate, "X", i);
					case 24: strins(plate, "Y", i);
					case 25: strins(plate, "Z", i);
				}
			}
		}
	}
	return plate;
}

stock VehicleHasDoors(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475, 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536, 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

stock IsAnAircraft(vehicleid)
{
    new vmodel = GetVehicleModel(vehicleid);
    if(vmodel == 460 
        || vmodel == 476
        || vmodel == 511
        || vmodel == 512
        || vmodel == 513
        || vmodel == 519
        || vmodel == 520
        || vmodel == 553
        || vmodel == 577
        || vmodel == 592
        || vmodel == 593)
    {
        return 1;
    }
    return 0;
}

stock LoadVehicles()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `vehicles` WHERE FactionID > 0");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            vCache = cache_save();
            VehicleInfo[i][vExists] = true; 
            cache_get_value_int(i, "ID", VehicleInfo[i][vID]);
            
            cache_get_value_int(i, "OwnerID", VehicleInfo[i][vOwnerID]);
            cache_get_value_int(i, "FactionID", VehicleInfo[i][vFactionID]);
            
            cache_get_value_int(i, "Model", VehicleInfo[i][vModel]);
            
            cache_get_value_int(i, "Colour1", VehicleInfo[i][vColour1]);
            cache_get_value_int(i, "Colour2", VehicleInfo[i][vColour2]);
            
            cache_get_value_float(i, "PosX", VehicleInfo[i][vPos][0]);
            cache_get_value_float(i, "PosY", VehicleInfo[i][vPos][1]);
            cache_get_value_float(i, "PosZ", VehicleInfo[i][vPos][2]);
            cache_get_value_float(i, "PosA", VehicleInfo[i][vPos][3]);
            
            cache_get_value_int(i, "Interior", VehicleInfo[i][vInterior]);
            cache_get_value_int(i, "VW", VehicleInfo[i][vVW]);
            
            cache_get_value(i, "Plates", VehicleInfo[i][vPlates], 32);
            cache_get_value_int(i, "Locked", VehicleInfo[i][vLocked]);
            
            cache_get_value_int(i, "Impounded", VehicleInfo[i][vImpounded]);
            
            cache_get_value_float(i, "ImpoundPosX", VehicleInfo[i][vImpoundPos][0]);
            cache_get_value_float(i, "ImpoundPosY", VehicleInfo[i][vImpoundPos][1]);
            cache_get_value_float(i, "ImpoundPosZ", VehicleInfo[i][vImpoundPos][2]);
            cache_get_value_float(i, "ImpoundPosA", VehicleInfo[i][vImpoundPos][3]);
            
            cache_get_value_float(i, "Fuel", VehicleInfo[i][vFuel]);
            cache_get_value_int(i, "Sirens", VehicleInfo[i][vSirens]);

            cache_get_value(i, "FineReason", VehicleInfo[i][vFineReason], 32);
            cache_get_value_int(i, "FineAmount", VehicleInfo[i][vFineAmount]);
            cache_get_value_int(i, "FineOfficerID", VehicleInfo[i][vFineOfficerID]);
            cache_get_value_int(i, "FineFactionID", VehicleInfo[i][vFineFactionID]);
            cache_get_value_int(i, "FineTime", VehicleInfo[i][vFineTime]);
            cache_get_value_int(i, "DMVVehicle", VehicleInfo[i][vDMVVehicle]);
            cache_get_value_int(i, "Value", VehicleInfo[i][vValue]);
            cache_get_value_int(i, "Mileage", VehicleInfo[i][vMileage]);
            cache_get_value_float(i, "MileageX", VehicleInfo[i][vMileagePosX]);
            cache_get_value_float(i, "MileageY", VehicleInfo[i][vMileagePosY]);
            cache_get_value_float(i, "MileageZ", VehicleInfo[i][vMileagePosZ]);

            /*new gRack[32];
            for(new g; g < 4; g++)
            {
                format(gRack, sizeof gRack, "GunRack%d", g+1);
                cache_get_value_name_int(0, gRack, VehicleInfo[i][vGunRack][g]);
                format(gRack, sizeof gRack, "GunRackAmmo%d", g+1);
                cache_get_value_name_int(0, gRack, VehicleInfo[i][vGunRackAmmo][g]);
            }*/

            VehicleInfo[i][vScriptID] = CreateVehicle(VehicleInfo[i][vModel],
            VehicleInfo[i][vPos][0],
            VehicleInfo[i][vPos][1],
            VehicleInfo[i][vPos][2]+1,
            VehicleInfo[i][vPos][3],
            VehicleInfo[i][vColour1],
            VehicleInfo[i][vColour2],
            -1,
            VehicleInfo[i][vSirens]);

            VehicleInfo[i][vFuel] = 100.0;

            UpdateVehiclePosition(i);
            ToggleVehicleLocked(VehicleInfo[i][vScriptID], false);
            ToggleVehicleEngine(VehicleInfo[i][vScriptID], false);
            ToggleVehicleLights(VehicleInfo[i][vScriptID], false);
            cache_set_active(vCache);
        }
    }
    cache_delete(result); 
    return 1;
}

function OnCreateDynamicVehicle(vehicleid, ownerid, factionid, model, colour1, colour2, Float:x, Float:y, Float:z, Float:a, int, vw)
{
    VehicleInfo[vehicleid][vExists] = true; 
    VehicleInfo[vehicleid][vID] = cache_insert_id();
    
    VehicleInfo[vehicleid][vOwnerID] = ownerid;
    VehicleInfo[vehicleid][vFactionID] = factionid;
    VehicleInfo[vehicleid][vModel] = model;
    VehicleInfo[vehicleid][vColour1] = colour1;
    VehicleInfo[vehicleid][vColour2] = colour2;
    VehicleInfo[vehicleid][vPaintJob] = 0;
    VehicleInfo[vehicleid][vPos][0] = x;
    VehicleInfo[vehicleid][vPos][1] = y;
    VehicleInfo[vehicleid][vPos][2] = z;
    VehicleInfo[vehicleid][vPos][3] = a;
    VehicleInfo[vehicleid][vInterior] = 0;
    VehicleInfo[vehicleid][vVW] = 0;
    VehicleInfo[vehicleid][vFuel] = 100;
    VehicleInfo[vehicleid][vSirens] = 0;

    format(VehicleInfo[vehicleid][vPlates], 32, "%s", GenerateRandomVehiclePlate());

    VehicleInfo[vehicleid][vScriptID] = CreateVehicle(VehicleInfo[vehicleid][vModel],
    VehicleInfo[vehicleid][vPos][0],
    VehicleInfo[vehicleid][vPos][1],
    VehicleInfo[vehicleid][vPos][2],
    VehicleInfo[vehicleid][vPos][3],
    VehicleInfo[vehicleid][vColour1],
    VehicleInfo[vehicleid][vColour2],
    -1,
    VehicleInfo[vehicleid][vSirens]);
    
    SetVehicleNumberPlate(VehicleInfo[vehicleid][vScriptID], VehicleInfo[vehicleid][vPlates]);
    SetVehicleToRespawn(VehicleInfo[vehicleid][vScriptID]);

    if(ownerid > 0)
    {
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pCharacterID] == ownerid)
            {
                PlayerInfo[i][pSpawnedVehicle] = VehicleInfo[vehicleid][vScriptID];
            }
        }
    }
    UpdateVehiclePosition(vehicleid);

    ToggleVehicleLocked(VehicleInfo[vehicleid][vScriptID], true);
    ToggleVehicleEngine(VehicleInfo[vehicleid][vScriptID], false);
    ToggleVehicleLights(VehicleInfo[vehicleid][vScriptID], false);
    return 1;
}

stock CreateDynamicVehicle(model, Float:x, Float:y, Float:z, Float:rotation, colour1, colour2, ownerid=0, factionid=0, int=0, vw=0)
{
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(!VehicleInfo[i][vID])
        {
            new query[512];
            mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `vehicles` (OwnerID, FactionID, Model, Colour1, Colour2, PosX, PosY, PosZ, PosA)\
            VALUES (%d, %d, %d, %d, %d, %f, %f, %f, %f)", ownerid, factionid, model, colour1, colour2, x, y, z, rotation);
            mysql_tquery(g_SQL, query, "OnCreateDynamicVehicle", "ddddddffffdd", i, ownerid, factionid, model, colour1, colour2, x, y, z, rotation, int, vw);
            return i;
        }
    }
    return -1;
}

stock ResetVehicleVars(vehicleid)
{
    VehicleInfo[vehicleid][vID] = 0;
    VehicleInfo[vehicleid][vExists] = false;
    VehicleInfo[vehicleid][vOwnerID] = 0;
    VehicleInfo[vehicleid][vFactionID] = 0;
    VehicleInfo[vehicleid][vModel] = 0;
    VehicleInfo[vehicleid][vColour1] = 0;
    VehicleInfo[vehicleid][vColour2] = 0;
    VehicleInfo[vehicleid][vPaintJob] = 0;
    for(new p; p < 4; p++)
    {
        VehicleInfo[vehicleid][vPos][p] = 0;
    }
    VehicleInfo[vehicleid][vInterior] = 0;
    VehicleInfo[vehicleid][vVW] = 0;
    VehicleInfo[vehicleid][vLocked] = 0;
    VehicleInfo[vehicleid][vImpounded] = 0;
    for(new p; p < 4; p++)
    {
        VehicleInfo[vehicleid][vImpoundPos][p] = 0;
    }
    for(new p; p < 5; p++)
    {
        VehicleInfo[vehicleid][vLastDrivers][p] = 0;
    }
    VehicleInfo[vehicleid][vEngine] = false;
    VehicleInfo[vehicleid][vLights] = false;
    VehicleInfo[vehicleid][vHood] = false;
    VehicleInfo[vehicleid][vAlarm] = false;
    VehicleInfo[vehicleid][vTrunk] = false;
    VehicleInfo[vehicleid][vFuel] = 100;
    VehicleInfo[vehicleid][vWindows] = 0;
    VehicleInfo[vehicleid][vWindowFrontLeft] = false;
    VehicleInfo[vehicleid][vWindowFrontRight] = false;
    VehicleInfo[vehicleid][vWindowBackLeft] = false;
    VehicleInfo[vehicleid][vWindowBackRight] = false;
    ResetVehicleInventory(vehicleid);
    return 1;
}

stock ToggleVehicleAlarm(vehicleid, alarmstate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarmstate, doors, bonnet, boot, objective);
    if(alarmstate)
    {
        CoreVehicle[vehicleid][VehicleAlarm] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleAlarm] = false;
    }
	return 1;
}

stock ToggleVehicleLights(vehicleid, lightstate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lightstate, alarm, doors, bonnet, boot, objective);
    if(lightstate)
    {
        CoreVehicle[vehicleid][VehicleLights] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleLights] = false;
    }
	return 1;
}

stock ToggleVehicleEngine(vehicleid, enginestate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, enginestate, lights, alarm, doors, bonnet, boot, objective);
    if(enginestate)
    {
        CoreVehicle[vehicleid][VehicleEngine] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleEngine] = false;
    }
	return 1;
}

stock ToggleVehicleHood(vehicleid, hoodstate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, hoodstate, boot, objective);
    if(hoodstate)
    {
        CoreVehicle[vehicleid][VehicleHood] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleHood] = false;
    }
	return 1;
}

stock ToggleVehicleTrunk(vehicleid, trunkstate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, trunkstate, objective);
    if(trunkstate)
    {
        CoreVehicle[vehicleid][VehicleTrunk] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleTrunk] = false;
    }
	return 1;
}

stock ToggleVehicleLocked(vehicleid, lockstate)
{
    if(!IsValidVehicle(vehicleid)) return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, lockstate, bonnet, boot, objective);
    if(lockstate)
    {
        CoreVehicle[vehicleid][VehicleLocked] = true;
    }
    else
    {
        CoreVehicle[vehicleid][VehicleLocked] = false;
    }
	return 1;
}

function AddMileage(vehicleid)
{
    if(VehicleInfo[vehicleid][vOwnerID] != 0)
    {
        new Float:dist = GetVehicleDistanceFromPoint(VehicleInfo[vehicleid][vScriptID], VehicleInfo[vehicleid][vMileagePosX], VehicleInfo[vehicleid][vMileagePosY], VehicleInfo[vehicleid][vMileagePosZ]);
        VehicleInfo[vehicleid][vMileage] += floatround(dist);
        GetVehiclePos(vehicleid,VehicleInfo[vehicleid][vMileagePosX], VehicleInfo[vehicleid][vMileagePosY], VehicleInfo[vehicleid][vMileagePosZ]);
        SaveVehicle(vehicleid);
        return 1;
    }
    return 0;
}

stock IsAGeneralBike(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 448, 461, 462, 463, 468, 471, 481, 509, 510, 521, 522, 523, 581, 586: return 1;
    }
    return 0;
}

stock IsABike(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 481, 509, 510: return 1;
    }
    return 0;
}

stock HasNoEngine(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}

stock Try_Engine(playerid, vehicleid)
{
    for(new i; i < sizeof(DMVVehicles); i++)
    {
        if(DMVVehicles[i] == vehicleid)
        {
            SendClientMessage(playerid, COLOR_RED, "You need to be in a driving exam to use this.");
            return 1;
        }
    }

    for(new i; i < sizeof(RentalVehicle); i++)
    {
        if(RentalVehicle[i] == vehicleid)
        {
            if(VehicleRented[vehicleid] == INVALID_PLAYER_ID)
            {
                PrintFooter(playerid, "~w~You must rent this vehicle using ~g~/rentvehicle~w~ in order to start it.");
                return 1;
            }
            if(VehicleRented[vehicleid] != playerid && VehicleRented[vehicleid] != INVALID_PLAYER_ID)
            {
                SendClientMessage(playerid, COLOR_RED, "You are not renting this vehicle.");
                return 1;
            }
        }
    }

    if(CoreVehicle[vehicleid][VehicleFuel] < 1.0)
        return SendClientMessage(playerid, COLOR_RED, "Vehicle is out of fuel!");

    new Float:veh_hp;
    GetVehicleHealth(vehicleid, veh_hp);
    if(veh_hp <= 301 && TempVar[playerid][AdminDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "Vehicle is is too damaged, get a mechanic to repair it.");

    if(TempVar[playerid][RefuelVehicle] == true)
        return SendErrorMessage(playerid, "You are currently refueling your vehicle.");
    
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0 && PlayerInfo[playerid][pFaction] != VehicleInfo[i][vFactionID] && !TempVar[playerid][AdminDuty])
                return SendErrorMessage(playerid, "You don't have the keys to this vehicle.");

            break;
        }
    }

    new str[128];
    if(!CoreVehicle[vehicleid][VehicleEngine])
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "-> {FFFF00}Starting Engine...");
        SetTimerEx("EngineOn", 1000, false, "dd", playerid, vehicleid);
        format(str, sizeof(str), "attempts to turn on the engine of the %s.", ReturnVehicleName(vehicleid));
        pc_cmd_ame(playerid, str);
    }
    else
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "-> {FFFF00}Engine turned off.");
        ToggleVehicleEngine(GetPlayerVehicleID(playerid), false); CoreVehicle[vehicleid][VehicleEngine] = false;
        format(str, sizeof(str), "turns off the engine of the %s.", ReturnVehicleName(vehicleid));
        SendMe(playerid, str);
    }
    return 1;
}

CMD:engine(playerid, params[])
{
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You aren't in the driver's seat of a vehicle."); 
		
    new vehicleid = GetPlayerVehicleID(playerid);
	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "This vehicle doesn't have a engine."); 

    if(KeyActionTimer[playerid] > 0)
        return SendErrorMessage(playerid, "You have already toggled an engine recently, please wait %d seconds.", KeyActionTimer[playerid]);

    Try_Engine(playerid, vehicleid);
    KeyActionTimer[playerid] = 2;
    return 1;
}

function EngineOn(playerid, vehicleid)
{
    new Float:health, str[128];
    GetVehicleHealth(vehicleid, health);

    if(health >= 400 && health < 650)
    {
        new rand = random(2);
        if(rand == 0)
            return SendClientMessage(playerid, COLOR_LIGHTRED, "-> {FFFF00}Vehicle Engine failed to start, try again.");
    }

    if(health < 400) return SendClientMessage(playerid, COLOR_LIGHTRED, "-> {FFFF00}Vehicle Engine is too damaged, cannot start.");

    SendClientMessage(playerid, COLOR_LIGHTRED, "-> {FFFF00}Engine started.");
    ToggleVehicleEngine(vehicleid, true); 
    CoreVehicle[vehicleid][VehicleEngine] = true;
    format(str, sizeof(str), "turns on the engine of the %s.", ReturnVehicleName(vehicleid));
    SendMe(playerid, str);
    return 1;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player)
    {
		if(IsPlayerInVehicle(i, vehicleid)) return true; 
	}
	return false;
}

stock SaveVehicles()
{
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vID])
        {
            SaveVehicle(i);
        }
    }
    return 1;
}

stock SaveVehicle(vehicleid)
{
    new string[1024];
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `vehicles` SET \
        `OwnerID` = %d,\
        `FactionID` = %d,\
        `Model` = %d,\
        `Colour1` = %d,\
        `Colour2` = %d,\
        `PaintJob` = %d,\
        `PosX` = %f,\
        `PosY` = %f,\
        `PosZ` = %f,\
        `PosA` = %f,\
        `Interior` = %d,\
        `VW` = %d,\
        `Impounded` = %d,\
        `ImpoundPosX` = %f,\
        `ImpoundPosY` = %f,\
        `ImpoundPosZ` = %f,\
        `ImpoundPosA` = %f,\
        `LastDriver1` = %d,\
        `LastDriver2` = %d,\
        `LastDriver3` = %d,\
        `LastDriver4` = %d,\
        `LastDriver5` = %d,\
        `Fuel` = %f, \
        `Sirens` = %d,\
        `Plates` = '%e',\
        `FineReason` = '%e',\
        `FineAmount` = %d, \
        `FineOfficerID` = %d, \
        `FineFactionID` = %d, \
        `FineTime` = %d, \
        `DMVVehicle` = %d, \
        `Value` = %d, \
        `Mileage` = %d, \
        `MileageX` = %f, \
        `MileageY` = %f, \
        `MileageZ` = %f \
        WHERE `ID` = %d LIMIT 1", 
        VehicleInfo[vehicleid][vOwnerID],
        VehicleInfo[vehicleid][vFactionID],
        VehicleInfo[vehicleid][vModel],
        VehicleInfo[vehicleid][vColour1],
        VehicleInfo[vehicleid][vColour2],
        VehicleInfo[vehicleid][vPaintJob],
        VehicleInfo[vehicleid][vPos][0],
        VehicleInfo[vehicleid][vPos][1],
        VehicleInfo[vehicleid][vPos][2],
        VehicleInfo[vehicleid][vPos][3],
        VehicleInfo[vehicleid][vInterior],
        VehicleInfo[vehicleid][vVW],
        VehicleInfo[vehicleid][vImpounded],
        VehicleInfo[vehicleid][vImpoundPos][0],
        VehicleInfo[vehicleid][vImpoundPos][1],
        VehicleInfo[vehicleid][vImpoundPos][2],
        VehicleInfo[vehicleid][vImpoundPos][3],
        VehicleInfo[vehicleid][vLastDrivers][0],
        VehicleInfo[vehicleid][vLastDrivers][1],
        VehicleInfo[vehicleid][vLastDrivers][2],
        VehicleInfo[vehicleid][vLastDrivers][3],
        VehicleInfo[vehicleid][vLastDrivers][4],
        VehicleInfo[vehicleid][vFuel],
        VehicleInfo[vehicleid][vSirens],
        VehicleInfo[vehicleid][vPlates],
        VehicleInfo[vehicleid][vFineReason],
        VehicleInfo[vehicleid][vFineAmount],
        VehicleInfo[vehicleid][vFineOfficerID],
        VehicleInfo[vehicleid][vFineFactionID],
        VehicleInfo[vehicleid][vFineTime],
        VehicleInfo[vehicleid][vDMVVehicle],
        VehicleInfo[vehicleid][vValue],
        VehicleInfo[vehicleid][vMileage],
        VehicleInfo[vehicleid][vMileagePosX],
        VehicleInfo[vehicleid][vMileagePosY],
        VehicleInfo[vehicleid][vMileagePosZ],
        VehicleInfo[vehicleid][vID]
    );
    mysql_tquery(g_SQL, string);
    return 1;
}

stock VehicleOwner(vehicleid)
{
    foreach(new i: Player)
    {
        if(VehicleInfo[vehicleid][vOwnerID] == PlayerInfo[i][pCharacterID] 
            && VehicleInfo[vehicleid][vFactionID] == 0 
            && VehicleInfo[vehicleid][vScriptID] > 0)
        {
            return i;
        }
    }
    return INVALID_PLAYER_ID;
}

CMD:vehicle(playerid, params[])
{
    new option[32], value[128];
    if (sscanf(params, "s[32]S()[128]", option, value))
    {
        SendUsageMessage(playerid, "/(v)ehicle [option]");
        SendClientMessage(playerid, COLOR_GRAD1, "OPTIONS: buy, sell, upgrade, park (despawn), get (spawn), factionize, Lights");
        SendClientMessage(playerid, COLOR_GRAD2, "OPTIONS: putwep, inventory");
        SendClientMessage(playerid, COLOR_GRAD3, "OPTIONS: lock, hood, trunk, find, stats, scrap (destroy)");
        return 1;
    }
    if(strcmp(params, "buy", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
                return SendErrorMessage(playerid, "You already have a vehicle spawned, despawn it first.");
        }

        new dealerid = IsPlayerNearDealer(playerid);
        if(dealerid > 0)
        {
            ShowVehicleMenu(playerid, dealerid);
        }
        else SendErrorMessage(playerid, "You are not near a dealership. Use /findvehdealer to find one.");
    }
    else if(strcmp(params, "sell", true) == 0)
    {
        // Sell Vehicle to player.
        new vehicle = GetPlayerVehicleID(playerid), targetid, price;

        if(!IsPlayerInAnyVehicle(playerid))
            return SendErrorMessage(playerid, "You are not in any vehicle.");
        
        new scriptID;
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == vehicle)
            {
                scriptID = i;
                break;
            }
        }

        if(VehicleInfo[scriptID][vOwnerID] != PlayerInfo[playerid][pCharacterID])
            return SendErrorMessage(playerid, "You don't own this vehicle.");
        
        if(sscanf(value, "ud", targetid, price))
            return SendUsageMessage(playerid, "/(v)ehicle Sell [PlayerID/PartOfName] [Price]");
        
        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "The specified player is not connected.");

        if(targetid == playerid)
			return SendErrorMessage(playerid, "You can't use this command on yourself.");

        if(!IsPlayerNearPlayer(playerid, targetid, 10.0))
            return SendErrorMessage(playerid, "You are not near the player.");

        if(price < 1)
            return SendErrorMessage(playerid, "The price can't be below $1.");

        TempVar[targetid][CarOffer] = playerid;
        TempVar[targetid][CarPrice] = price;
        TempVar[targetid][CarSell] = scriptID;

        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have offered %s to buy your %s for %s.", GetRPName(targetid), ReturnVehicleModelName(VehicleInfo[scriptID][vModel]), FormatNumber(price));
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* %s wants to sell you their %s for {00FF00}$%s{%06x} - use \"/accept vehicle\" to accept.", GetRPName(playerid), ReturnVehicleModelName(VehicleInfo[scriptID][vModel]), FormatNumber(price), COLOR_LIGHTBLUE >>> 8);
    }
    else if(strcmp(params, "upgrade", true) == 0)
    {
        pc_cmd_tuning(playerid, "\0");
    }
    else if(strcmp(params, "factionize", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
            {
                if(!PlayerInfo[playerid][pFaction]) return SendErrorMessage(playerid, "You aren't in any faction.");
                
                if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][FactionAlterRank])
                    return SendErrorMessage(playerid, "You don't have permission in your faction to add faction vehicles.");

                if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                    return SendErrorMessage(playerid, "You aren't driving a vehicle.");
                
                if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You don't own this vehicle."); 

                if(VehicleInfo[i][vFactionID] != 0)
                    return SendErrorMessage(playerid, "This vehicle is already factionized to the %s.", GetFactionName(VehicleInfo[i][vFactionID]));
                    
                VehicleInfo[i][vFactionID] = PlayerInfo[playerid][pFaction];
                SendServerMessage(playerid, "You factionized your vehicle for the %s.", GetFactionName(VehicleInfo[i][vFactionID]));
                
                SaveVehicle(i);
                return 1;
            }
        }
    }
    else if(strcmp(params, "unfaction", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
            {
                if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                    return SendErrorMessage(playerid, "You aren't driving a vehicle.");
                    
                if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You don't own this vehicle."); 
                    
                SendServerMessage(playerid, "You removed the faction affiliation from your vehicle from the %s.", GetFactionName(VehicleInfo[i][vFactionID]));
                VehicleInfo[i][vFactionID] = 0;
                
                SaveVehicle(i);
                return 1;
            }
        }
    }
    else if(strcmp(params, "park", true) == 0 || strcmp(params, "despawn", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
                {
                    if(VehicleInfo[i][vFactionID] > 0) return SendErrorMessage(playerid, "You cannot despawn faction vehicles.");
                    if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID])
                    {
                        new iVeh = GetPlayerVehicleID(playerid), string[128];
                        format(string, sizeof string, "parks their %s.", ReturnVehicleName(GetPlayerVehicleID(playerid)));
                        SendMe(playerid, string);
                        GetVehiclePos(iVeh, VehicleInfo[i][vPos][0], VehicleInfo[i][vPos][1], VehicleInfo[i][vPos][2]);
                        GetVehicleZAngle(iVeh, VehicleInfo[i][vPos][3]);
                        VehicleInfo[i][vInterior] = GetPlayerInterior(playerid);
                        VehicleInfo[i][vVW] = GetVehicleVirtualWorld(iVeh);
                        VehicleInfo[i][vFuel] = CoreVehicle[iVeh][VehicleFuel];
                        SendClientMessageEx(playerid, COLOR_YELLOW, "> You have parked your {00AA00}%s{FFFF00} which will spawn in this spot from now on.", ReturnVehicleName(GetPlayerVehicleID(playerid)));

                        SaveVehicle(i);
                        RemovePlayerFromVehicle(playerid);
                        ResetVehicleVars(i);
                        DestroyVehicle(iVeh);
                        PlayerInfo[playerid][pSpawnedVehicle] = 0;
                    }
                    else SendErrorMessage(playerid, "You cannot despawn someone else's car.");
                    return 1;
                }
            }
        }
        else SendErrorMessage(playerid, "You must be inside your vehicle.");
    }
    else if(strcmp(params, "stats", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
                {
                    if(VehicleInfo[i][vFactionID] > 0) return SendErrorMessage(playerid, "You cannot see faction vehicle stats.");
                    if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID])
                    {
                        ShowVehicleStats(playerid, i);
                    }
                    else SendErrorMessage(playerid, "You cannot see the stats of someone else's car.");
                    return 1;
                }
            }
        }
        else SendErrorMessage(playerid, "You must be inside your vehicle.");
    }
    else if(strcmp(params, "find", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
            {
                foreach(new p: Player)
                {
                    if(GetPlayerVehicleID(p) == VehicleInfo[i][vScriptID] && GetPlayerVehicleSeat(p) == 0)
                    {
                        SendErrorMessage(playerid, "Your vehicle is currently being driven.");
                        return 1;
                    }
                }

                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_VEH;
                DisablePlayerCheckpoint(playerid);
                new Float:x, Float:y, Float:z;
                GetVehiclePos(VehicleInfo[i][vScriptID], x, y, z);
                SetPlayerCheckpoint(playerid, x, y, z, 5);
                SendClientMessage(playerid, COLOR_PINK, "Your vehicle has been marked on the map.");
                return 1;
            }
        }
        SendErrorMessage(playerid, "You do not have a vehicle spawned.");
    }
    else if(strcmp(params, "get", true) == 0 || strcmp(params, "spawn", true) == 0 || strcmp(params, "list", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
                return SendErrorMessage(playerid, "You already have a vehicle spawned, despawn it first.");
        }

        // Spawn vehicle
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `vehicles` WHERE OwnerID = %i", PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, query, "Vehicle_OnSpawnList", "i", playerid);
    }
    else if(strcmp(params, "lights", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vid = GetPlayerVehicleID(playerid);
            if(CoreVehicle[vid][VehicleLights] == false)
            {
                ToggleVehicleLights(vid, true);
                PrintFooter(playerid, "~w~Lights~n~~g~On", 1);
            }
            else
            {
                ToggleVehicleLights(vid, false);
                PrintFooter(playerid, "~w~Lights~n~~r~Off", 1);
            }
        }
        return 1;
    }
    else if(strcmp(params, "hood", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid) || IsPlayerNearVehicle(playerid, VehicleInfo[i][vScriptID], 3.0))
                {
                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleLocked] == true)
                        return SendErrorMessage(playerid, "This vehicle is locked, please unlock it.");

                    if(VehicleInfo[i][vFactionID] >= 1 && PlayerInfo[playerid][pFaction] != VehicleInfo[i][vFactionID])
                        return SendErrorMessage(playerid, "This vehicle hood is faction restricted.");
                    
                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleHood] == false)
                    {
                        ToggleVehicleHood(VehicleInfo[i][vScriptID], true);
                        PrintFooter(playerid, "~w~Hood~n~~g~Opened", 1);
                    }
                    else
                    {
                        ToggleVehicleHood(VehicleInfo[i][vScriptID], false);
                        PrintFooter(playerid, "~w~Hood~n~~r~Closed", 1);
                    }
                    return 1;
                }
            }
        }
    }
    else if(strcmp(params, "trunk", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
                {
                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleLocked] == true)
                        return SendErrorMessage(playerid, "This vehicle is locked, please unlock it.");
                    
                    if(VehicleInfo[i][vFactionID] >= 1 && PlayerInfo[playerid][pFaction] != VehicleInfo[i][vFactionID])
                        return SendErrorMessage(playerid, "This vehicle trunk is faction restricted.");

                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleTrunk] == false)
                    {
                        ToggleVehicleTrunk(VehicleInfo[i][vScriptID], true);
                        PrintFooter(playerid, "~w~Trunk~n~~g~Opened", 1);
                    }
                    else
                    {
                        ToggleVehicleTrunk(VehicleInfo[i][vScriptID], false);
                        PrintFooter(playerid, "~w~Trunk~n~~r~Closed", 1);
                    }
                    return 1;
                }
            }
        }
        else
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(IsPlayerNearVehicle(playerid, VehicleInfo[i][vScriptID], 3.0))
                {
                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleLocked] == true)
                        return SendErrorMessage(playerid, "This vehicle is locked, please unlock it.");
                    
                    if(VehicleInfo[i][vFactionID] >= 1 && PlayerInfo[playerid][pFaction] != VehicleInfo[i][vFactionID])
                        return SendErrorMessage(playerid, "This vehicle trunk is faction restricted.");

                    if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleTrunk] == false)
                    {
                        ToggleVehicleTrunk(VehicleInfo[i][vScriptID], true);
                        PrintFooter(playerid, "~w~Trunk~n~~g~Opened", 1);
                    }
                    else
                    {
                        ToggleVehicleTrunk(VehicleInfo[i][vScriptID], false);
                        PrintFooter(playerid, "~w~Trunk~n~~r~Closed", 1);
                    }
                    return 1;
                }
            }
        }
    }
    else if(strcmp(params, "putwep", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
            return SendErrorMessage(playerid, "You must be outside your vehicle.");

        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(IsPlayerNearVehicle(playerid, VehicleInfo[i][vScriptID], 3.0))
            {
                if(CoreVehicle[VehicleInfo[i][vScriptID]][VehicleTrunk] == false)
                    return SendErrorMessage(playerid, "This vehicle trunk is closed, please open it.");
                
                if(GetPlayerWeapon(playerid) > 2 && GetPlayerWeapon(playerid) < 46)
                {
                    new weaponID = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
                    if(weaponID > 1 && ammo > 0)
                    {
                        if(AddVehicleInventory(i, INV_GUN, ammo, weaponID) == 1)
                        {
                            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** You have placed your %s into your %s's inventory.", GetServerWeaponName(weaponID), ReturnVehicleName(VehicleInfo[i][vScriptID]));
                            RemovePlayerWeapon(playerid, weaponID);
                        }
                        else SendErrorMessage(playerid, "Storage is at maxium capacity.");
                    }
                    else SendErrorMessage(playerid, "You do not have a weapon to put in your inventory.");
                }

                return 1;
            }
        }
    }
    else if(strcmp(params, "inventory", true) == 0 || strcmp(params, "inv", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(IsPlayerNearVehicle(playerid, VehicleInfo[i][vScriptID], 3.0) && CoreVehicle[VehicleInfo[i][vScriptID]][VehicleTrunk] == true)
            {                
                PrintVehicleInventory(playerid, i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "No vehicle with an open trunk is nearby.");
    }
    else if(strcmp(params, "lock", true) == 0)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
                {
                    if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                        return SendErrorMessage(playerid, "You do not own this vehicle.");

                    if(CoreVehicle[i][VehicleLocked] == true)
                    {
                        CoreVehicle[i][VehicleLocked] = false;
                        ToggleVehicleLocked(VehicleInfo[i][vScriptID], 0);
                        PrintFooter(playerid, "~w~Vehicle~n~~g~Unlocked", 1);
                    }
                    else
                    {
                        CoreVehicle[i][VehicleLocked] = true;
                        ToggleVehicleLocked(VehicleInfo[i][vScriptID], 1);
                        PrintFooter(playerid, "~w~Vehicle~n~~g~Locked", 1);
                    }
                    return 1;
                }
            }
        }
        else
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(IsPlayerNearVehicle(playerid, VehicleInfo[i][vScriptID], 3.0))
                {
                    if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                        return SendErrorMessage(playerid, "You do not own this vehicle.");

                    if(CoreVehicle[i][VehicleLocked] == true)
                    {
                        CoreVehicle[i][VehicleLocked] = false;
                        ToggleVehicleLocked(VehicleInfo[i][vScriptID], 0);
                        PrintFooter(playerid, "~w~Vehicle~n~~g~Unlocked", 1);
                    }
                    else
                    {
                        CoreVehicle[i][VehicleLocked] = true;
                        ToggleVehicleLocked(VehicleInfo[i][vScriptID], 1);
                        PrintFooter(playerid, "~w~Vehicle~n~~g~Locked", 1);
                    }
                    return 1;
                }
            }
        }
        if(RentingVehicle{playerid} != -1)
        {
            for(new i; i < GetVehiclePoolSize(); i++)
            {
                if(RentingVehicle{playerid} == i)
                {
                    if(i == GetPlayerVehicleID(playerid) || IsPlayerNearVehicle(playerid, i, 3.0))
                    {
                        if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                            return SendErrorMessage(playerid, "You do not rent this vehicle.");

                        if(CoreVehicle[i][VehicleLocked] == true)
                        {
                            CoreVehicle[i][VehicleLocked] = false;
                            ToggleVehicleLocked(i, 0);
                            PrintFooter(playerid, "~w~Vehicle~n~~g~Unlocked", 1);
                        }
                        else
                        {
                            CoreVehicle[i][VehicleLocked] = true;
                            ToggleVehicleLocked(i, 1);
                            PrintFooter(playerid, "~w~Vehicle~n~~g~Locked", 1);
                        }
                    }
                }
            }
        }
    }
    else if(strcmp(params, "scrap", true) == 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
            {
                if(VehicleInfo[i][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You do not own this vehicle.");
                
                new string[512];
                SetPVarInt(playerid, "ScrapID", i);
                format(string, sizeof string, "{FF0000}WARNING: {FFFFFF}You are about to scrap your vehicle.\n\
                Press 'Confirm' to confirm this action.\n\
                Administrators will not refund for misuse of this command.\n\n\
                You will recive $%s (75 percent of value) for scrapping this vehicle.", FormatNumber(percent(VehicleInfo[i][vValue], 75)));
                Dialog_Show(playerid, VehicleScrap, DIALOG_STYLE_MSGBOX, "Vehicle Scrap", string, "Confirm", "Cancel");
            }
        }
    }
    return 1;
}
alias:vehicle("v");

Dialog:VehicleScrap(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new queryBuffer[256], vehicleid = GetPVarInt(playerid, "ScrapID");
        GiveMoney(playerid, percent(VehicleInfo[vehicleid][vValue], 75));
        SendClientMessageEx(playerid, COLOR_YELLOW, "You have scrapped your vehicle and recieved $%s.", FormatNumber(percent(VehicleInfo[vehicleid][vValue], 75)));
        DestroyVehicle(VehicleInfo[vehicleid][vScriptID]);
        ResetVehicleVars(vehicleid);
        mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "DELETE FROM vehicles WHERE ID = %i LIMIT 1", VehicleInfo[vehicleid][vID]);
	    mysql_tquery(g_SQL, queryBuffer);
    }
    return 1;
}

stock ShowVehicleStats(playerid, vehicleid)
{
    if(VehicleInfo[vehicleid][vID])
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "___________________ %s ___________________", ReturnVehicleModelName(VehicleInfo[vehicleid][vModel]));
        SendClientMessageEx(playerid, COLOR_GRAD5, "Colour 1:[%d], Colour 2:[%d], Plates:[%s]", 
            VehicleInfo[vehicleid][vColour1], VehicleInfo[vehicleid][vColour2], VehicleInfo[vehicleid][vPlates]);
        if(Player[playerid][AdminLevel] >= 1)
        {
            SendClientMessageEx(playerid, COLOR_GRAD4, "Admin: Script ID:[%d], Database ID:[%d], Owner ID:[%d], Faction ID:[%d]", 
            vehicleid, VehicleInfo[vehicleid][vID], VehicleInfo[vehicleid][vOwnerID], VehicleInfo[vehicleid][vFactionID]);
        }
        
    }
    return 1;
}

function Vehicle_OnSpawnList(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new str[131*MAX_PVEH];
        format(str, sizeof(str), "Vehicle\t\tLocation\n");
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", tempVehDBID[playerid][i]);
            cache_get_value_int(i, "Model", tempVehModel[playerid][i]);
            cache_get_value_int(i, "Colour1", tempVehColour1[playerid][i]);
            cache_get_value_int(i, "Colour2", tempVehColour2[playerid][i]);
            cache_get_value_int(i, "PaintJob", tempVehPaintJob[playerid][i]);
            cache_get_value_float(i, "PosX", tempVehPosX[playerid][i]);
            cache_get_value_float(i, "PosY", tempVehPosY[playerid][i]);
            cache_get_value_float(i, "PosZ", tempVehPosZ[playerid][i]);
            cache_get_value_float(i, "PosA", tempVehPosA[playerid][i]);
            cache_get_value_float(i, "Fuel", tempVehFuel[playerid][i]);
            format(str, sizeof(str), "%s%s\t\t%s\n", str, ReturnVehicleModelName(tempVehModel[playerid][i]));
        }
        Dialog_Show(playerid, PVEHICLE_SPAWN, DIALOG_STYLE_TABLIST_HEADERS, "Spawn Vehicle", str, "Spawn", "Cancel");
    }
    else SendErrorMessage(playerid, "You do not own any vehicles.");
    return 1;
}

Dialog:PVEHICLE_SPAWN(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
                return SendErrorMessage(playerid, "Please despawn your current vehicle first.");
        }

        for(new vehicleid; vehicleid < MAX_DYN_VEH; vehicleid++)
        {
            SpawnPlayerVehicle(playerid, tempVehDBID[playerid][listitem]);
            return 1;
        }
    }
    return 1;
}

stock SpawnPlayerVehicle(playerid, dbid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM vehicles WHERE ID = %d LIMIT 1", dbid);
    mysql_tquery(g_SQL, query, "OnUserSpawnVehicle", "d", playerid);
}

function OnUserSpawnVehicle(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(!VehicleInfo[i][vID])
            {
                VehicleInfo[i][vExists] = true; 
                cache_get_value_int(0, "ID", VehicleInfo[i][vID]);
                
                cache_get_value_int(0, "OwnerID", VehicleInfo[i][vOwnerID]);
                cache_get_value_int(0, "FactionID", VehicleInfo[i][vFactionID]);
                
                cache_get_value_int(0, "Model", VehicleInfo[i][vModel]);
                
                cache_get_value_int(0, "Colour1", VehicleInfo[i][vColour1]);
                cache_get_value_int(0, "Colour2", VehicleInfo[i][vColour2]);
                

                cache_get_value_float(0, "PosX", VehicleInfo[i][vPos][0]);
                cache_get_value_float(0, "PosY", VehicleInfo[i][vPos][1]);
                cache_get_value_float(0, "PosZ", VehicleInfo[i][vPos][2]);
                cache_get_value_float(0, "PosA", VehicleInfo[i][vPos][3]);
                
                cache_get_value_int(0, "Interior", VehicleInfo[i][vInterior]);
                cache_get_value_int(0, "VW", VehicleInfo[i][vVW]);
                
                cache_get_value(0, "Plates", VehicleInfo[i][vPlates], 32);
                cache_get_value_int(0, "Locked", VehicleInfo[i][vLocked]);
                
                cache_get_value_int(0, "Impounded", VehicleInfo[i][vImpounded]);
                
                cache_get_value_float(0, "ImpoundPosX", VehicleInfo[i][vImpoundPos][0]);
                cache_get_value_float(0, "ImpoundPosY", VehicleInfo[i][vImpoundPos][1]);
                cache_get_value_float(0, "ImpoundPosZ", VehicleInfo[i][vImpoundPos][2]);
                cache_get_value_float(0, "ImpoundPosA", VehicleInfo[i][vImpoundPos][3]);
                
                cache_get_value_float(0, "Fuel", VehicleInfo[i][vFuel]);
                cache_get_value_int(0, "Sirens", VehicleInfo[i][vSirens]);

                cache_get_value(0, "FineReason", VehicleInfo[i][vFineReason], 32);
                cache_get_value_int(0, "FineAmount", VehicleInfo[i][vFineAmount]);
                cache_get_value_int(0, "FineFactionID", VehicleInfo[i][vFineFactionID]);
                cache_get_value_int(0, "FineOfficerID", VehicleInfo[i][vFineOfficerID]);

                VehicleInfo[i][vScriptID] = CreateVehicle(VehicleInfo[i][vModel],
                VehicleInfo[i][vPos][0],
                VehicleInfo[i][vPos][1],
                VehicleInfo[i][vPos][2],
                VehicleInfo[i][vPos][3],
                VehicleInfo[i][vColour1],
                VehicleInfo[i][vColour2],
                -1,
                VehicleInfo[i][vSirens]);
                

                UpdateVehiclePosition(i);

                if(VehicleInfo[i][vImpounded] > 0)
                {
                    SendServerMessage(playerid, "Your vehicle is currently impounded.");
                }
                else 
                {
                    SendClientMessage(playerid, COLOR_PINK, "Your vehicle has been marked on the map.");
                    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_VEH;
                    DisablePlayerCheckpoint(playerid);
                    SetPlayerCheckpoint(playerid, VehicleInfo[i][vPos][0], VehicleInfo[i][vPos][1], VehicleInfo[i][vPos][2], 5);
                }
                PlayerInfo[playerid][pSpawnedVehicle] = VehicleInfo[i][vScriptID];

                ToggleVehicleLocked(VehicleInfo[i][vScriptID], true);
                ToggleVehicleEngine(VehicleInfo[i][vScriptID], false);
                ToggleVehicleLights(VehicleInfo[i][vScriptID], false);
                LoadVehicleInventory(i);

                CoreVehicle[VehicleInfo[i][vScriptID]][VehicleFuel] = VehicleInfo[i][vFuel];
                return 1;
            }
        }
    }
    return 1;
}

CMD:vehid(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        for(new i; i < sizeof(AdminVehicle); i++)
		{
			if(GetPlayerVehicleID(playerid) == AdminVehicle[i])
			{
				SendServerMessage(playerid, "Vehicle ID is %d", AdminVehicle[i]);
				return 1;
			}
		}
        for(new vehicleid; vehicleid < MAX_DYN_VEH; vehicleid++)
        {
            if(VehicleInfo[vehicleid][vScriptID] == GetPlayerVehicleID(playerid))
            {
                SendServerMessage(playerid, "Vehicle ID is %d", vehicleid);
                return 1;
            }
        }
    }
    else
    {
        if(Player[playerid][AdminLevel] >= 1)
        {
            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessageEx(playerid, COLOR_WHITE, "Nearest vehicles (ignoring /veh spawned)...");
            for(new vehicleid; vehicleid < MAX_DYN_VEH; vehicleid++)
            {
                new Float:x, Float:y, Float:z;
                GetVehiclePos(VehicleInfo[vehicleid][vScriptID], x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
                {
                    SendClientMessageEx(playerid, COLOR_GRAD5, "ID: %d, Model: %s", vehicleid, ReturnVehicleModelName(VehicleInfo[vehicleid][vModel]));
                }
            }
            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        }
    }
    return 1;
}

CMD:editveh(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new vehicleid, oneString[60], secString[90];
        if (sscanf(params, "ds[60]S()[90]", vehicleid, oneString, secString))
        {
            SendUsageMessage(playerid, "/editfaction [vehicle id(see /vehid)] [option]");
		    SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Siren, FactionID, Owner, Colour1, Colour2, PaintJob");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Position, Fuel, ModelID, DMV, Plate, Interior, VW");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Mileage");
            return 1;
        }

        if(strcmp(oneString, "Siren",true) == 0)
        {
            if(VehicleInfo[vehicleid][vSirens] == 0)
            {
                VehicleInfo[vehicleid][vSirens] = 1;
                SendClientMessageEx(playerid, COLOR_LIGHTRED, ">>> {FFFF00}Vehicle will now have a siren.");
            }
            else
            {
                VehicleInfo[vehicleid][vSirens] = 0;
                SendClientMessageEx(playerid, COLOR_LIGHTRED, ">>> {FFFF00}Vehicle will no longer have a siren.");
            }
            UpdateVehiclePosition(vehicleid);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "FactionID",true) == 0)
        {
            new factionid;
            
            if(sscanf(secString, "d", factionid))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Faction ID]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] See /factions for all factions.");
                return 1;
            }
            
            if(factionid > MAX_FACTIONS || factionid < 0)
                return SendErrorMessage(playerid, "Valid Factions are from 0 (no faction) to %d.",MAX_FACTIONS); 
                
            VehicleInfo[vehicleid][vFactionID] = factionid; 

            SendServerMessage(playerid, "You set vehicle %d's faction to %d.", vehicleid, factionid);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "Owner",true) == 0)
        {
            new targetid;
            
            if(sscanf(secString, "u", targetid))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Player ID or Name]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] Setting this will reset the FactionID (remove its faction affiliation).");
                return 1;
            }
                
            if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
            {
                SendErrorMessage(playerid, "This player is not connected or not logged in.");
                return 1;
            }
            
            VehicleInfo[vehicleid][vOwnerID] = PlayerInfo[targetid][pCharacterID];

            SendServerMessage(playerid, "You set vehicle %d's owner to %s.", vehicleid, GetUserName(targetid));
            if(targetid != playerid)
            {
                SendServerMessage(targetid, "%s %s has given you ownership of a vehicle.", GetAdminRank(playerid), GetMasterName(playerid));
            }
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "Colour1",true) == 0)
        {
            new colour;
            
            if(sscanf(secString, "d", colour))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Colour ID]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] See /colours for all available colours.");
                return 1;
            }
            
            VehicleInfo[vehicleid][vColour1] = colour;

            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's colour 1 to #%d.", vehicleid, colour);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "Colour2",true) == 0)
        {
            new colour;
            
            if(sscanf(secString, "d", colour))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Colour ID]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] See /colours for all available colours.");
                return 1;
            }
            
            VehicleInfo[vehicleid][vColour2] = colour;

            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's colour 2 to #%d.", vehicleid, colour);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "paintjob",true) == 0)
        {
            new colour;
            
            if(sscanf(secString, "d", colour))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [PaintJob]");
                return 1;
            }
            
            if(colour < 0 || colour > 3)
            {
                SendErrorMessage(playerid, "Invalid paintjob, valid is from 0 to 3");
                return 1;
            }

            VehicleInfo[vehicleid][vPaintJob] = colour;

            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's paint job to %d.", vehicleid, colour);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "position",true) == 0)
        {
            if(GetPlayerVehicleID(playerid) != VehicleInfo[vehicleid][vScriptID])
                return SendErrorMessage(playerid, "You must be inside the vehicle you wish to edit.");

            GetVehiclePos(VehicleInfo[vehicleid][vScriptID], VehicleInfo[vehicleid][vPos][0], VehicleInfo[vehicleid][vPos][1], VehicleInfo[vehicleid][vPos][2]);
            GetVehicleZAngle(VehicleInfo[vehicleid][vScriptID], VehicleInfo[vehicleid][vPos][3]);
            VehicleInfo[vehicleid][vInterior] = GetPlayerInterior(playerid);
            VehicleInfo[vehicleid][vVW] = GetVehicleVirtualWorld(VehicleInfo[vehicleid][vScriptID]);
            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's position.", vehicleid);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "fuel", true) == 0)
        {
            new Float:fuel;
            
            if(sscanf(secString, "f", fuel))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [PaintJob]");
                return 1;
            }
            
            if(fuel < 0 || fuel > 100)
            {
                SendErrorMessage(playerid, "Invalid fuel level, valid is from 0 to 100.");
                return 1;
            }

            VehicleInfo[vehicleid][vFuel] = fuel;

            SendServerMessage(playerid, "You set vehicle %d's fuel to %f.", vehicleid, fuel);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "modelid", true) == 0)
        {
            new modelid;
            
            if(sscanf(secString, "d", modelid))
                return SendUsageMessage(playerid, "/editveh MpdelID Option [Faction ID]");
            
            if(modelid < 400 || modelid > 611)
                return SendErrorMessage(playerid, "You have specified an invalid modelid.");
                
            VehicleInfo[vehicleid][vModel] = modelid; 

            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's model to %d.", vehicleid, modelid);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "plate", true) == 0)
        {
            new szPlate[32];
            
            if(sscanf(secString, "s[32]", szPlate))
                return SendUsageMessage(playerid, "/editveh MpdelID Option [Faction ID]");
            
            if(strlen(szPlate) < 1 || strlen(szPlate) >= 30)
                return SendErrorMessage(playerid, "The plate is either too long or too short.");
                
            format(VehicleInfo[vehicleid][vPlates], 32, "%s", szPlate);

            UpdateVehiclePosition(vehicleid);

            SendServerMessage(playerid, "You set vehicle %d's plate to \"%s\".", vehicleid, szPlate);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "value",true) == 0)
        {
            new value;
            
            if(sscanf(secString, "d", value))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Value]");
                return 1;
            }
            
            if(value < 0)
                return SendErrorMessage(playerid, "Value cannot be below 0.");
                
            VehicleInfo[vehicleid][vValue] = value; 

            SendServerMessage(playerid, "You set vehicle %d's value to $%s.", vehicleid, FormatNumber(value));
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "Interior",true) == 0)
        {
            new value;
            
            if(sscanf(secString, "d", value))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Interior]");
                return 1;
            }
            
            if(value < 0)
                return SendErrorMessage(playerid, "Value cannot be below 0.");
                
            VehicleInfo[vehicleid][vInterior] = value;
            LinkVehicleToInterior(VehicleInfo[vehicleid][vScriptID], value);

            SendServerMessage(playerid, "You set vehicle %d's value to %d.", vehicleid, value);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "VW",true) == 0)
        {
            new value;
            
            if(sscanf(secString, "d", value))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [VW]");
                return 1;
            }
            
            if(value < 0)
                return SendErrorMessage(playerid, "Value cannot be below 0.");
                
            VehicleInfo[vehicleid][vVW] = value;
            SetVehicleVirtualWorld(VehicleInfo[vehicleid][vScriptID], value);

            SendServerMessage(playerid, "You set vehicle %d's virtual world to %d.", vehicleid, value);
            SaveVehicle(vehicleid);
        }
        else if(strcmp(oneString, "mileage",true) == 0)
        {
            new value;
            
            if(sscanf(secString, "d", value))
            {
                SendUsageMessage(playerid, "/editveh VehicleID Option [Mileage]");
                return 1;
            }
            
            if(value < 0)
                return SendErrorMessage(playerid, "Value cannot be below 0.");
                
            VehicleInfo[vehicleid][vMileage] = value;

            SendServerMessage(playerid, "You set vehicle %d's mileage to %d.", vehicleid, value);
            SaveVehicle(vehicleid);
        }
    }
    return 1;
}

stock UpdateVehiclePosition(i)
{
    if(IsValidVehicle(VehicleInfo[i][vScriptID]))
    {
        DestroyVehicle(VehicleInfo[i][vScriptID]);
    }
    VehicleInfo[i][vScriptID] = CreateVehicle(VehicleInfo[i][vModel],VehicleInfo[i][vPos][0], VehicleInfo[i][vPos][1], VehicleInfo[i][vPos][2], VehicleInfo[i][vPos][3], VehicleInfo[i][vColour1], VehicleInfo[i][vColour2], -1, VehicleInfo[i][vSirens]);
    ChangeVehiclePaintjob(VehicleInfo[i][vScriptID], VehicleInfo[i][vPaintJob]);

    if(VehicleInfo[i][vInterior] != 0)
    {
        LinkVehicleToInterior(VehicleInfo[i][vScriptID], VehicleInfo[i][vInterior]); 
    }

    if(VehicleInfo[i][vVW] != 0)
    {
        SetVehicleVirtualWorld(VehicleInfo[i][vScriptID], VehicleInfo[i][vVW]);
    }
    
    if(!isnull(VehicleInfo[i][vPlates]))
    {
        SetVehicleNumberPlate(VehicleInfo[i][vScriptID], VehicleInfo[i][vPlates]);
    }
    else SetVehicleNumberPlate(VehicleInfo[i][vScriptID], " ");

    if(!VehicleInfo[i][vValue])
    {
        VehicleInfo[i][vValue] = 1;
    }

    SetVehicleToRespawn(VehicleInfo[i][vScriptID]); 
    
    if(VehicleInfo[i][vImpounded] == 1)
    {
        SetVehiclePos(VehicleInfo[i][vScriptID], VehicleInfo[i][vImpoundPos][0], VehicleInfo[i][vImpoundPos][1], VehicleInfo[i][vImpoundPos][2]);
        SetVehicleZAngle(VehicleInfo[i][vScriptID], VehicleInfo[i][vImpoundPos][3]); 
    }
}

new colourString[128*26];

CMD:colours(playerid, params[])
{
    new colour[7];
    new colours = 0;

    colourString[0] = 0;
    for(new i = 1; i < sizeof(VehicleColoursTableRGBA); i++)
    {
        colours = colours + 1;
        valstr(colour, (VehicleColoursTableRGBA[i] >>> 8));
        format(colourString, sizeof colourString, "%s{%06x}#%03i{FFFFFF}", colourString, VehicleColoursTableRGBA[i] >>> 8, i);
        if(colours > 9)
        {
            format(colourString, sizeof colourString, "%s\n", colourString);
            colours = 0;
        }
        else
        {
            format(colourString, sizeof colourString, "%s, ", colourString);
        }
    }
    Dialog_Show(playerid, ColourList, DIALOG_STYLE_MSGBOX, "Vehicle Colours", colourString, "Okay", "");
    return 1;
}

function BMXVehicleNOPCheck(playerid, vehicleid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
            if(Player[playerid][AdminLevel] < 1)
            {
                new string[128];
                format(string, sizeof string, "%s (ID: %d) may be NOP hacking - entered a BMX without permission.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
                format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - entered a BMX without permission.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                DBLog("Hack", string);
                InsertHackerLog(playerid, "Suspected NOP Hacking - Entered a BMX without permission");
                return 1;
            }
        }
    }
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
    {
        SetPlayerArmedWeapon(playerid, 0);
        for(new i; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vScriptID] == vehicleid)
            {
                if(VehicleInfo[i][vFactionID] > 0 && PlayerInfo[playerid][pFaction] != VehicleInfo[i][vFactionID])
                {
                    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
                    {
                        SendServerMessage(playerid, "You have entered a faction restricted vehicle whilst on admin duty.");
                    }
                    else
                    {
                        new Float:slx, Float:sly, Float:slz;
                        GetPlayerPos(playerid, slx, sly, slz);
                        SetPlayerPosEx(playerid, slx, sly, slz+1.3);
                        RemovePlayerFromVehicle(playerid);
                        SetTimerEx("FactionVehicleNOPCheck", 2000, false, "dd", playerid, vehicleid);
                        return SendErrorMessage(playerid, "This is a faction restricted vehicle. You cannot enter it.");
                    }
                }
            }
        }
    }
    if(IsAnAircraft(vehicleid))
    {
        SendClientMessage(playerid, -1, "Use /atc to talk on Air Traffic Control.");
    }
    return 1;
}

function FactionVehicleNOPCheck(playerid, vehicleid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
            if(Player[playerid][AdminLevel] < 1)
            {
                new string[128];
                format(string, sizeof string, "%s (ID: %d) may be NOP hacking - entered a faction vehicle.", GetUserName(playerid), playerid);
                SendAdminWarning(1, string);
                format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - entered a faction vehicle.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                DBLog("Hack", string);
                InsertHackerLog(playerid, "Suspected NOP Hacking - Entered a faction vehicle");
            }
        }
    }
    return 1;
}

stock GetClosestVehicle(playerid, Float:maxrange = 6.0)
{
	new Float:x, Float:y, Float:z;
	for (new Float:range = 1.0; range <= maxrange; range += 0.3)
	{
		for (new i = 1; i < MAX_VEHICLES; i++)
		{
			if (!IsValidVehicle(i) || !IsVehicleStreamedIn(i, playerid))
			{
				continue;
			}
			else
			{
				GetVehiclePos(i, x, y, z);

				if (IsPlayerInRangeOfPoint(playerid, range, x, y, z))
				{
					return i;
				}
			}
		}
	}
	return INVALID_VEHICLE_ID;
}

stock GetVehicleID(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	{
	    return -1;
	}
	else
	{
		for (new i = 0; i < MAX_DYN_VEH; i ++)
		{
	    	if (VehicleInfo[i][vID] && VehicleInfo[i][vScriptID] == vehicleid)
		    {
		        return i;
			}
		}
	}
	return -1;
}

stock IsValidVehicleID(id)
{
	return (id >= 0 && id < MAX_DYN_VEH) && VehicleInfo[id][vID];
}

stock GetVehicleDriver(vid)
{
    foreach(new i: Player)
    {
        if(GetPlayerVehicleID(i) == vid && GetPlayerVehicleSeat(i) == 0) return i;
    }
    return INVALID_PLAYER_ID;
}

stock ToggleVehicleSiren(vehicleid, bool:siren, type = 0)
{
    if (siren == true)
    {
        if (IsValidDynamicObject(CoreVehicle[vehicleid][SirenObject]))
        {
            DestroyDynamicObject(CoreVehicle[vehicleid][SirenObject]);
        }
        
        static
            Float:fSize[3],
            Float:fSeat[3];
        
        switch(type)
        {
            case 1:
            {
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

                CoreVehicle[vehicleid][SirenObject] = CreateDynamicObject(19620, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);
                AttachDynamicObjectToVehicle(CoreVehicle[vehicleid][SirenObject], vehicleid, 0.0, fSeat[1], fSize[2] / 1.85, 0.0, 0.0, 0.0);
                
                CoreVehicle[vehicleid][SirenStatus] = 1;
            }
            case 2:
            {
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

                CoreVehicle[vehicleid][SirenObject] = CreateDynamicObject(19294, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);
                AttachDynamicObjectToVehicle(CoreVehicle[vehicleid][SirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
                
                CoreVehicle[vehicleid][SirenStatus] = 1;
            }
            default:
            {
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

                CoreVehicle[vehicleid][SirenObject] = CreateDynamicObject(18646, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);
                AttachDynamicObjectToVehicle(CoreVehicle[vehicleid][SirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
                
                CoreVehicle[vehicleid][SirenStatus] = 1;
            }
        }
    }
    else
    {
        if (IsValidDynamicObject(CoreVehicle[vehicleid][SirenObject]))
        {
            AttachDynamicObjectToVehicle(CoreVehicle[vehicleid][SirenObject], INVALID_VEHICLE_ID, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
            DestroyDynamicObject(CoreVehicle[vehicleid][SirenObject]);
        }
        CoreVehicle[vehicleid][SirenStatus] = 0;
    }
}

CMD:tuning(playerid, params[])
{
    for(new p = 0; p < sizeof(SprayShop); p++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, SprayShop[p][0], SprayShop[p][1], SprayShop[p][2]))
        {
            RepairShop[playerid] = p;
            Dialog_Show(playerid, TuningMenu, DIALOG_STYLE_TABLIST_HEADERS, "Tuning Menu", "Exterior and Engine Repair\t$750\n\
            Exterior Repair\t$500\n\
            Engine Repair\t$250\n\
            Vehicle Upgrades\t-", "Select", "Exit");
            return 1;
        }
    }
    return 1;
}

Dialog:TuningMenu(playerid, response, listitem, inputtext[])
{
    new p = RepairShop[playerid];
    if(response && p != -1)
    {
        switch(listitem)
        {
            case 0:
            {
                new iVeh = GetPlayerVehicleID(playerid);
                for(new i; i < MAX_DYN_VEH; i++)
                {
                    if(VehicleInfo[i][vScriptID] == iVeh)
                    {
                        GetVehiclePos(iVeh, SprayShop[p][0], SprayShop[p][1], SprayShop[p][2]);
                        GetVehicleZAngle(iVeh, SprayShop[p][3]);
                        VehicleInfo[i][vInterior] = 0;
                        VehicleInfo[i][vVW] = 0;
                        VehicleInfo[i][vFuel] = 100;
                        RepairID[playerid] = VehicleInfo[i][vID];
                        SendClientMessageEx(playerid, COLOR_YELLOW, "> You have sent your {00AA00}%s{FFFF00} in for repairs, it will be repaired in 1 minute.", ReturnVehicleName(iVeh));

                        SaveVehicle(i);
                        RemovePlayerFromVehicle(playerid);
                        ResetVehicleVars(i);
                        DestroyVehicle(iVeh);
                        PlayerInfo[playerid][pSpawnedVehicle] = 0;
                        SetTimerEx("OnVehicleRepair", 60000, false, "d", playerid);
                        return 1;
                    }
                }
            }
        }
    }
    return 1;
}

function OnVehicleRepair(playerid)
{
    // TODO: Respawn player vehicle here when the repair timer has been completed.
    //SendClientMessageEx(playerid, COLOR_YELLOW, "> Your {00AA00}%s{FFFF00} has been repaired and is waiting at the repair centre.", ReturnVehicleName(iVeh));
    return 1;
}