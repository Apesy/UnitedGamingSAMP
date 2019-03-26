//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

new StaticTaxi[4];

hook OnGameModeInit()
{
    StaticTaxi[0] = CreateVehicle(420, -158.8055, 1081.5844, 19.4363, 0.0, 6, 6, -1);
    StaticTaxi[1] = CreateVehicle(420, -155.6255, 1081.5837, 19.4363, 0.0, 6, 6, -1);
    StaticTaxi[2] = CreateVehicle(420, -152.4255, 1081.5837, 19.4363, 0.0, 6, 6, -1);
    StaticTaxi[3] = CreateVehicle(420, -149.3255, 1081.5837, 19.4363, 0.0, 6, 6, -1);

    new str[32];
    for(new i; i < sizeof(StaticTaxi); i++)
    {
        format(str, sizeof str, "TAXI %d", i+1);
        SetVehicleNumberPlate(StaticTaxi[i], str);
        SetVehicleToRespawn(StaticTaxi[i]);
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger && PlayerInfo[playerid][pJob] != JOB_TAXIDRIVER)
    {
        for(new i; i < sizeof(StaticTaxi); i++)
        {
            if(StaticTaxi[i] == vehicleid)
            {
                ClearAnimations(playerid);
                return SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a taxi driver.");
            }
        }
    }
    return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        for(new i; i < sizeof(StaticTaxi); i++)
        {
            if(StaticTaxi[i] == GetPlayerVehicleID(playerid))
            {
                if(PlayerInfo[playerid][pJob] != JOB_TAXIDRIVER)
                {
                    SendErrorMessage(playerid, "You cannot enter this vehicle, you need to be a taxi driver.");
                    new Float:slx, Float:sly, Float:slz;
                    GetPlayerPos(playerid, slx, sly, slz);
                    SetPlayerPosEx(playerid, slx, sly, slz+1.3);
                    RemovePlayerFromVehicle(playerid);
                    SetTimerEx("OnTaxiVehNOPCheck", 2000, false, "dd", playerid, StaticTaxi[i]);
                }
                return 1;
            }
        }
    }
    return 1;
}

function OnTaxiVehNOPCheck(playerid, vehicleid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
			if(Player[playerid][AdminLevel] < 1 && PlayerInfo[playerid][pJob] != JOB_TAXIDRIVER)
			{
				new string[128];
				format(string, sizeof string, "%s (ID: %d) may be NOP hacking - inside static taxi whilst not a taxi driver.", GetUserName(playerid), playerid);
				SendAdminWarning(1, string);
				format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - inside static taxi whilst not a taxi driver.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Hack", string);
			}
        }
    }
    return 1;
}

stock IsATaxi(vehicleid)
{
    new vmodel = GetVehicleModel(vehicleid);
    if(vmodel == 420 || vmodel == 438)
    {
        return 1;
    }
    return 0;
}

CMD:taxihelp(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Taxi Help:{FFFFFF} Type a command for more information.");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /call 544");
    if(PlayerInfo[playerid][pJob] == JOB_TAXIDRIVER)
    {
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /taxiduty, /startmeter");
    }
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:taxiduty(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_TAXIDRIVER)
    {
        if(TempVar[playerid][JobDuty] == true)
        {
            TempVar[playerid][JobDuty] = false;
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are now off duty.");
        }
        else
        {
            new fare;
            if(sscanf(params, "d", fare))
                return SendUsageMessage(playerid, "/taxiduty [fare]");

            if(fare < 0 || fare > 100)
                return SendErrorMessage(playerid, "Invalid fare specified, fare needs to be above 0 and below 100.");

            if(!IsATaxi(GetPlayerVehicleID(playerid)))
                return SendErrorMessage(playerid, "You are not in a taxi vehicle.");

            TempVar[playerid][JobDuty] = true;
            TempVar[playerid][TaxiFarePrice] = fare;
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are now on duty.");
        }
    }
    else SendErrorMessage(playerid, "You are not a taxi driver. Use /findjob to find it.");
    return 1;
}

CMD:startmeter(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_TAXIDRIVER)
    {
        if(TempVar[playerid][JobDuty] == false)
            return SendClientMessage(playerid, COLOR_LIGHTBLUE, "You are off duty, you must be on duty to use this.");

        if(TempVar[playerid][TaxiFarePrice] < 1)
            TempVar[playerid][TaxiFarePrice] = 1;

        new count = 0;
        foreach(new i: Player)
        {
            if(GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && i != playerid)
            {
                count++;
                TempVar[i][TaxiDriverID] = playerid;
                TempVar[i][TaxiFare] = 1;
                SendClientMessageEx(i, COLOR_YELLOW, "Driver %s has started the meter.", GetRPName(playerid));
            }
        }
        if(count == 0)
        {
            SendErrorMessage(playerid, "There are no passengers inside your vehicle.");
        }
        else SendClientMessage(playerid, COLOR_LIGHTBLUE, "The meter has started.");
    }
    else SendErrorMessage(playerid, "You are not a taxi driver. Use /findjob to find it.");
    return 1;
}