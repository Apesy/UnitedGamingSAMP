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

new StaticBuses[3];
new Float:StaticBus[][4] = {
    {-0.8858,1214.3994,19.4546,270.0000},
    {-1.0971,1222.1824,19.4495,270.0000},
    {-1.3200,1229.0660,19.4525,270.0000}
};

new Float:BusStops[][4] = {
    {-85.75294, 1204.79346, 19.92315, 90.0},
    {-217.02414, 1204.72852, 19.92315, 90.0},
    {-306.09299, 1154.41187, 19.92320, 90.0},
    {-323.53165, 1079.30798, 19.92320, 180.0},
    {-281.98688, 1038.54138, 19.92320, 180.0},
    {-184.23779, 1044.46863, 19.92320, 0.0},
    {-152.80695, 1092.03845, 19.92320, 270.0},
    {-39.21990, 1092.04260, 19.92320, 270.0},
    {-22.58790, 1154.76453, 19.92320, 90.0}
};

new BusRoute[MAX_PLAYERS];

hook OnGameModeInit()
{
    for(new i; i < sizeof(StaticBus); i++)
    {
        new colour1 = random(255)+1, colour2 = random(255)+1, string[32];
        StaticBuses[i] = CreateVehicle(431, StaticBus[i][0], StaticBus[i][1], StaticBus[i][2], StaticBus[i][3], colour1, colour2, -1);
        format(string, sizeof string, "BUS %d", i+1);
        SetVehicleNumberPlate(StaticBuses[i], string);
        SetVehicleToRespawn(StaticBuses[i]);
    }

    for(new i; i < sizeof(BusStops); i++)
    {
        CreateDynamic3DTextLabel("Bus Stop", COLOR_GREEN, BusStops[i][0], BusStops[i][1], BusStops[i][2], 20.0, .testlos = 1, .worldid = 0, .interiorid = 0);
        CreateDynamicObject(1257, BusStops[i][0], BusStops[i][1], BusStops[i][2], 0.0, 0.0, BusStops[i][3], .worldid = 0, .interiorid = 0);
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    BusRoute[playerid] = -1;
    return 1;
}

CMD:bushelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_BUSDRIVER)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Bus Driver Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /startroute, /stoproute");
        SendClientMessageEx(playerid, COLOR_GRAD4, "Follow the checkpoints and collect passengers, you will be .");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:stoproute(playerid, params[])
{
    DisablePlayerCheckpoint(playerid);
    BusRoute[playerid] = -1;
    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, COLOR_LIGHTRED, "(INFO): You have cancelled the bus route.");
    return 1;
}

CMD:startroute(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_BUSDRIVER)
        return SendErrorMessage(playerid, "You are not a bus driver. (/findjob)");
    
    SendClientMessage(playerid, COLOR_YELLOW, "(INFO): Follow the checkpoints to complete the route.");
    BusRoute[playerid] = 0;
    SetPlayerCheckpoint(playerid, BusStops[0][0], BusStops[0][1], BusStops[0][2], 10.0);
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_BUS;
    return 1;
}

stock HandleBusRoute(playerid)
{
    DisablePlayerCheckpoint(playerid);
    new vehicleid = GetPlayerVehicleID(playerid);
    BusRoute[playerid]++;
    SendClientMessageEx(playerid, -1, "BusRoute[%d] = %d", playerid, BusRoute[playerid]);
    if(BusRoute[playerid] == 9)
    {
        for(new i; i < sizeof(StaticBuses); i++)
        {
            if(GetPlayerVehicleID(playerid) == StaticBuses[i])
            {
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_BUS;
                SetPlayerCheckpoint(playerid, StaticBus[i][0], StaticBus[i][1], StaticBus[i][2], 10.0);
            }
        }
    }
    else if(BusRoute[playerid] >= 10)
    {
        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_NONE;
        new jobPay = 25 + random(50);
        PlayerInfo[playerid][pPayCheque] += jobPay;
        SetVehicleToRespawn(vehicleid);
        SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): You have earned $%d for completing this route.", jobPay);
        BusRoute[playerid] = -1;
    }
    else
    {
        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_BUS;
        SetPlayerCheckpoint(playerid, BusStops[BusRoute[playerid]][0], BusStops[BusRoute[playerid]][1], BusStops[BusRoute[playerid]][2], 10.0);
    }
}