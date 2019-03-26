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

#define MAX_RENTALS 7
#define RENTAL_FEE 100

enum rentalEnum
{
	Model,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosA
};
new RentalCars[MAX_RENTALS][rentalEnum] =
{
    {492, -1534.4932, 2626.5442, 55.5252, 0.0000},
	{492, -1531.2932, 2626.5442, 55.5252, 0.0000},
	{492, -1528.2932, 2626.5442, 55.5252, 0.0000},
    {543, -162.8375, 1011.5045, 19.5425, 0.0000},
    {543, -165.9375, 1011.5045, 19.5425, 0.0000},
    {543, -147.4587, 1110.2260, 19.5356, 270.0000},
    {543, -147.4587, 1113.2260, 19.5356, 270.0000}
};

new RentalVehicle[MAX_RENTALS], VehicleRented[MAX_VEHICLES];
new RentingVehicle[MAX_PLAYERS char];

hook OnPlayerConnect(playerid)
{
    RentingVehicle{playerid} = -1;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    for(new i; i < GetVehiclePoolSize(); i++)
    {
        if(VehicleRented[i] == playerid)
        {
            VehicleRented[i] = INVALID_PLAYER_ID;
            RespawnVehicle(i);
        }
    }
    return 1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
    for(new i; i < sizeof(RentalCars); i++)
    {
        if(RentalVehicle[i] == vehicleid)
        {
            if(IsPlayerConnected(VehicleRented[vehicleid]))
            {
                SendClientMessageEx(VehicleRented[vehicleid], COLOR_LIGHTRED, "Your rental vehicle was destroyed.");
            }
            VehicleRented[vehicleid] = INVALID_PLAYER_ID;
        }
    }
    return 1;
}

stock LoadRentalVehicles()
{
    new count = 0, colour1, colour2, plate[32];
    for(new i; i < sizeof(RentalCars); i++)
    {
        if(RentalCars[i][Model] == 420)
        {
            colour1 = 6;
            colour2 = 6;
        }
        else
        {
            colour1 = random(200)+1;
            colour2 = random(200)+1;
        }
        RentalVehicle[i] = CreateVehicle(RentalCars[i][Model], RentalCars[i][PosX], RentalCars[i][PosY], RentalCars[i][PosZ], RentalCars[i][PosA], colour1, colour2, -1);
        VehicleRented[RentalVehicle[i]] = INVALID_PLAYER_ID;
        format(plate, sizeof plate, "RENT %d", count+1);
        SetVehicleNumberPlate(RentalVehicle[i], plate);
        SetVehicleToRespawn(RentalVehicle[i]);
        count++;
    }
}

stock IsARental(vehicleid)
{
    for(new i; i < sizeof(RentalCars); i++)
    {
        if(RentalVehicle[i] == vehicleid)
        {
            return 1;
        }
    }
    return 0;
}

stock GetRentalVehicleID(vehicleid)
{
    for(new i; i < sizeof(RentalCars); i++)
    {
        if(RentalVehicle[i] == vehicleid)
        {
            return i;
        }
    }
    return -1;
}

CMD:rentvehicle(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(!IsARental(vehicleid))
        return SendErrorMessage(playerid, "You cannot rent this vehicle.");

    if(VehicleRented[vehicleid] == playerid)
        return SendErrorMessage(playerid, "You are already renting this vehicle.");

    if(VehicleRented[vehicleid] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You cannot rent this vehicle, someone is already renting it.");

    if(PlayerInfo[playerid][pMoney] < RENTAL_FEE)
        return SendErrorMessage(playerid, "You cannot afford to rent this vehicle, you need $%d.", RENTAL_FEE);

    Dialog_Show(playerid, RentVehicle, DIALOG_STYLE_MSGBOX, "Rent Vehicle", "Are you sure you want to rent this vehicle for $100?", "Yes", "No");
    return 1;
}

CMD:unrentvehicle(playerid, params[])
{
    for(new i; i < GetVehiclePoolSize(); i++)
    {
        if(VehicleRented[i] == playerid && i == GetPlayerVehicleID(playerid))
        {
            VehicleRented[i] = INVALID_VEHICLE_ID;
            RentingVehicle{playerid} = -1;
            PrintFooter(playerid, "Vehicle has been unrented.");
            ToggleVehicleEngine(i, VEHICLE_PARAMS_OFF);
            return 1;
        }
    }
    SendErrorMessage(playerid, "You need to be inside the rental vehicle you are renting.");
    return 1;
}

Dialog:RentVehicle(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        TakeMoney(playerid, RENTAL_FEE);
        VehicleRented[vehicleid] = playerid;
        RentingVehicle{playerid} = vehicleid;
        PrintFooter(playerid, "Vehicle has been rented for ~r~$100~w~. Use ~g~/engine~w~ to start the engine.");
    }
    return 1;
}

CMD:rented(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_WHITE, "Rented Vehicles:");
        for(new i; i < sizeof(RentalCars); i++)
        {
            if(VehicleRented[RentalVehicle[i]] != INVALID_PLAYER_ID)
            {
                SendClientMessageEx(playerid, COLOR_GREY, "[Vehicle ID: %d]: %s rented by %s", RentalVehicle[i], ReturnVehicleName(RentalVehicle[i]), GetUserName(VehicleRented[RentalVehicle[i]]));
            }
        }
    }
    return 1;
}