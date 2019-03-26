//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_PUMPS 100

enum gasPumpEnum
{
    PumpID,
    Float:PumpPosX,
    Float:PumpPosY,
    Float:PumpPosZ,
    Float:PumpPosRX,
    Float:PumpPosRY,
    Float:PumpPosRZ,
    PumpInterior,
    PumpVW,
    PumpBusiness,
    PumpPrice
};
new GasPump[MAX_PUMPS][gasPumpEnum],
    Text3D:GasPumpLabel[MAX_PUMPS],
    GasPumpObject[MAX_PUMPS],
    Cache:pumpCache;

stock LoadGasPumps()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `gas_pumps`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            pumpCache = cache_save();
            cache_get_value_int(i, "ID", GasPump[i+1][PumpID]);

            cache_get_value_float(i, "PosX", GasPump[i+1][PumpPosX]);
            cache_get_value_float(i, "PosY", GasPump[i+1][PumpPosY]);
            cache_get_value_float(i, "PosZ", GasPump[i+1][PumpPosZ]);
            cache_get_value_float(i, "PosRX", GasPump[i+1][PumpPosRX]);
            cache_get_value_float(i, "PosRY", GasPump[i+1][PumpPosRY]);
            cache_get_value_float(i, "PosRZ", GasPump[i+1][PumpPosRZ]);

            cache_get_value_int(i, "Interior", GasPump[i+1][PumpInterior]);
            cache_get_value_int(i, "VW", GasPump[i+1][PumpVW]);
            cache_get_value_int(i, "Business", GasPump[i+1][PumpBusiness]);
            cache_get_value_int(i, "Price", GasPump[i+1][PumpPrice]);

            if(GasPump[i+1][PumpPrice] == 0)
                GasPump[i+1][PumpPrice] = 25;

            UpdatePumpPickup(i+1);
            Iter_Add(GasPumps,i);
            cache_set_active(pumpCache);
        }
    }
    cache_delete(result); 
}

stock SavePumps()
{
    for(new i = 1; i < MAX_PUMPS; i++)
    {
        if(GasPump[i][PumpID])
        {
            SaveBusiness(i);
        }
    }
}

stock SavePump(pumpID)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE gas_pumps SET \
    PosX = %f,\
    PosY = %f,\
    PosZ = %f,\
    PosRX = %f,\
    PosRY = %f,\
    PosRZ = %f,\
    Interior = %d,\
    VW = %d,\
    Business = %d,\
    Price = %d WHERE ID = %d", 
    GasPump[pumpID][PumpPosX],
    GasPump[pumpID][PumpPosY],
    GasPump[pumpID][PumpPosZ],
    GasPump[pumpID][PumpPosRX],
    GasPump[pumpID][PumpPosRY],
    GasPump[pumpID][PumpPosRZ],
    GasPump[pumpID][PumpInterior],
    GasPump[pumpID][PumpVW],
    GasPump[pumpID][PumpBusiness],
    GasPump[pumpID][PumpPrice],
    GasPump[pumpID][PumpID]);
    mysql_tquery(g_SQL, query);
    return 1;
}

stock UpdatePumpPickup(pumpID)
{
    if(IsValidDynamicObject(GasPumpObject[pumpID]))
    {
        DestroyDynamicObject(GasPumpObject[pumpID]);
    }

    if(IsValidDynamic3DTextLabel(GasPumpLabel[pumpID]))
    {
        DestroyDynamic3DTextLabel(GasPumpLabel[pumpID]);
    }
    if(GasPump[pumpID][PumpID])
    {

        GasPumpObject[pumpID] = CreateDynamicObject(3465, GasPump[pumpID][PumpPosX],
            GasPump[pumpID][PumpPosY],
            GasPump[pumpID][PumpPosZ],
            GasPump[pumpID][PumpPosRX],
            GasPump[pumpID][PumpPosRY],
            GasPump[pumpID][PumpPosRZ], 
            GasPump[pumpID][PumpVW], 
            GasPump[pumpID][PumpInterior]);

        new string[128];
        format(string, sizeof string, "[Fuel Pump %d]\n\n{FFFFFF}Use {00FF00}/refuel{FFFFFF} to refuel your vehicle.", pumpID);
        GasPumpLabel[pumpID] = CreateDynamic3DTextLabel(string, COLOR_GREEN, GasPump[pumpID][PumpPosX],
            GasPump[pumpID][PumpPosY],
            GasPump[pumpID][PumpPosZ], 20.0,
            .testlos = 0,
            .worldid = GasPump[pumpID][PumpVW], 
            .interiorid = GasPump[pumpID][PumpInterior]);
    }
}

CMD:editpump(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new pumpID, option[32], amount;
        if(sscanf(params, "ds[32]D", pumpID, option, amount))
        {
            SendUsageMessage(playerid, "/editpump [Pump ID] [Option] [Amount]");
            SendUsageMessage(playerid, "Options: Get, Position, Business, Price");
            return 1;
        }

        if(pumpID < 1 || pumpID > MAX_PUMPS)
            return SendErrorMessage(playerid, "Invalid Pump ID specified.");

        if(!GasPump[pumpID][PumpID])
            return SendErrorMessage(playerid, "That gas pump does not exist.");

        if(strcmp(option, "get", true) == 0)
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            GasPump[pumpID][PumpPosX] = x+1;
            GasPump[pumpID][PumpPosY] = y;
            GasPump[pumpID][PumpPosZ] = z;
            GasPump[pumpID][PumpPosRX] = 0;
            GasPump[pumpID][PumpPosRY] = 0;
            GasPump[pumpID][PumpPosRZ] = 0;
            UpdatePumpPickup(pumpID);
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d moved to your position.", pumpID);
            SavePump(pumpID);
        }
        else if(strcmp(option, "position", true) == 0)
        {
            EditDynamicObject(playerid, GasPumpObject[pumpID]);
            TempVar[playerid][EditType] = EDIT_TYPE_GAS_PUMP;
            SetPVarInt(playerid, "EditingGasPump", pumpID);
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d: Press {00FF00}~k~~PED_SPRINT~{FFFF00} to move your camera.", pumpID);
        }
        else if(strcmp(option, "business", true) == 0)
        {
            if(amount < 1 || amount > MAX_BIZ)
                return SendErrorMessage(playerid, "Please input a valid business (1-%d).", MAX_BIZ);

            GasPump[pumpID][PumpBusiness] = amount;
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d business set to %d.", pumpID, amount);
            SavePump(pumpID);
        }
        else if(strcmp(option, "price", true) == 0)
        {
            if(amount < 1 || amount > 100)
                return SendErrorMessage(playerid, "Please input a valid price (1-100).");

            GasPump[pumpID][PumpPrice] = amount;
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d price set to $%d.", pumpID, amount);
            SavePump(pumpID);
        }
        SendUsageMessage(playerid, "Options: Get, Position, Business, Price");
    }
    return 1;
}

CMD:duplicatepump(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new pumpID;
        if(sscanf(params, "d", pumpID))
        {
            SendUsageMessage(playerid, "/duplicatepump [Pump ID]");
            return 1;
        }

        if(!GasPump[pumpID][PumpID])
            return SendErrorMessage(playerid, "That business does not exist.");

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `gas_pumps` (`PosX`, `PosY`, `PosZ`) VALUES (%f, %f, %f)", GasPump[pumpID][PumpPosX], GasPump[pumpID][PumpPosY], GasPump[pumpID][PumpPosZ]);
        mysql_tquery(g_SQL, query, "OnDuplicateGasPump", "dd", playerid, pumpID);
    }
    return 1;
}

function OnDuplicateGasPump(playerid, pumpID)
{
    for(new i = 1; i < MAX_PUMPS; i++)
    {
        if(!GasPump[i][PumpID])
        {
            GasPump[i][PumpID] = cache_insert_id();
            GasPump[i][PumpPosX] = GasPump[pumpID][PumpPosX];
            GasPump[i][PumpPosY] = GasPump[pumpID][PumpPosY];
            GasPump[i][PumpPosZ] = GasPump[pumpID][PumpPosZ];
            GasPump[i][PumpPosRX] = GasPump[pumpID][PumpPosRX];
            GasPump[i][PumpPosRY] = GasPump[pumpID][PumpPosRY];
            GasPump[i][PumpPosRZ] = GasPump[pumpID][PumpPosRZ];
            GasPump[i][PumpPrice] = GasPump[pumpID][PumpPrice];
            GasPump[i][PumpBusiness] = GasPump[pumpID][PumpBusiness];
            SavePump(i);
            UpdatePumpPickup(i);

            EditDynamicObject(playerid, GasPumpObject[i]);
            TempVar[playerid][EditType] = EDIT_TYPE_GAS_PUMP;
            SetPVarInt(playerid, "EditingGasPump", i);
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d: Press {00FF00}~k~~PED_SPRINT~{FFFF00} to move your camera.", i);
            return 1;
        }
    }
    SendErrorMessage(playerid, "Cannot create gas pump, the pump limit (%d) has been reached.", MAX_PUMPS);
    return 1;
}

CMD:pumphelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Gas Pump Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /createpump, /editpump, /duplicatepump.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:createpump(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new business, price;
        if(sscanf(params, "dd", business, price))
        {
            SendUsageMessage(playerid, "/createpump [Business ID] [Price]");
            return 1;
        }

        if(!BusinessInfo[business][BizID])
            return SendErrorMessage(playerid, "That business does not exist.");

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `gas_pumps` (`Business`, `Price`) VALUES (%d, %d)", business, price);
        mysql_tquery(g_SQL, query, "OnCreateGasPump", "ddd", playerid, business, price);
    }
    return 1;
}

function OnCreateGasPump(playerid, business, price)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 1; i < MAX_PUMPS; i++)
    {
        if(!GasPump[i][PumpID])
        {
            GasPump[i][PumpID] = cache_insert_id();
            GasPump[i][PumpPosX] = x;
            GasPump[i][PumpPosY] = y;
            GasPump[i][PumpPosZ] = z;
            GasPump[i][PumpPrice] = price;
            GasPump[i][PumpBusiness] = business;
            SavePump(i);
            UpdatePumpPickup(i);

            EditDynamicObject(playerid, GasPumpObject[i]);
            TempVar[playerid][EditType] = EDIT_TYPE_GAS_PUMP;
            SetPVarInt(playerid, "EditingGasPump", i);
            SendClientMessageEx(playerid, COLOR_YELLOW, "Gas Pump %d: Press {00FF00}~k~~PED_SPRINT~{FFFF00} to move your camera.", i);
            return 1;
        }
    }
    return 1;
}

CMD:refuel(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(HasNoEngine(GetPlayerVehicleID(playerid)))
		    return SendErrorMessage(playerid, "This vehicle cannot be refueled.");

        new vehicleID = GetPlayerVehicleID(playerid);

        if(CoreVehicle[vehicleID][VehicleFuel] >= 100)
            return SendErrorMessage(playerid, "This vehicle is at maximum capacity.");

        if(CoreVehicle[vehicleID][VehicleEngine] == true)
            return SendErrorMessage(playerid, "Turn off your vehicle engine using \"/engine\".");

        for(new i; i < MAX_PUMPS; i++)
        {
            if(GasPump[i][PumpID] > 0 && IsPlayerInRangeOfPoint(playerid, 10.0, GasPump[i][PumpPosX], GasPump[i][PumpPosY], GasPump[i][PumpPosZ]))
            {
                SetPVarInt(playerid, "PumpID", i);
                SendClientMessageEx(playerid, COLOR_WHITE, "Refueling your vehicle, please wait.");
                TempVar[playerid][RefuelVehicle] = true;
                SetTimerEx("OnRefuelVehicle", 10000, false, "dd", playerid, vehicleID);
                return 1;
            }
        }
    }
    return 1;
}

function OnRefuelVehicle(playerid, vehicleid)
{
    new pumpid = GetPVarInt(playerid, "PumpID");
    if(GasPump[pumpid][PumpPrice] >= 1)
    {
        TakeMoney(playerid, GasPump[pumpid][PumpPrice]);
        if(GasPump[pumpid][PumpBusiness] >= 1)
        {
            BusinessInfo[GasPump[pumpid][PumpBusiness]][BizSafe] += GasPump[pumpid][PumpPrice];
        }
    }
    CoreVehicle[vehicleid][VehicleFuel] = 100.0;
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == vehicleid)
        {
            VehicleInfo[i][vFuel] = 100.0;
        }
    }
    TempVar[playerid][RefuelVehicle] = false;
    SendClientMessage(playerid, COLOR_WHITE, "Vehicle has been refueled, you can now /engine.");
    DeletePVar(playerid, "PumpID");
    return 1;
}