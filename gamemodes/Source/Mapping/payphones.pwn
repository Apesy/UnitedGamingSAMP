//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum payphoneEnum
{
    Float:PayphonePosX,
    Float:PayphonePosY,
    Float:PayphonePosZ,
    Float:PayphonePosA,
}
new Payphones[][payphoneEnum] = {
    {-180.99120, 1158.86914, 19.42180, 270.00000},
    {-105.26860, 1188.74329, 19.41850, 180.00000},
    {-823.98682, 1502.61951, 19.34880, 0.00000},
    {-1535.47107, 2610.37036, 55.52040, 0.00000}
};

new PayphoneObject[4], Text3D:PayphoneLabel[4];

stock GetSpecialNumber(playerid, number)
{
    switch(number)
    {
        case 911:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 911;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): 911 Emergency, what service do you require?");
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Police/Sheriffs, Paramedics/Fire or both?");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
        case 544:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 544;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Taxi Operator here, what is your current location? (Where you are currently at)");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
        case 555:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 555;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Mechanics here, what is your current location and what needs done?");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
        case 119:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 119;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Law Enforcement Non Emergency Landline, how can I help you?");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
        case 219:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 219;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Fire Department Non Emergency Landline, how can I help you?");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
        case 319:
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallLandline] = 319;
            SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Government Hotline, how can I help you?");
            TogglePlayerPhone(playerid, true);
            return 1;
        }
    }
    return 0;
}

stock InitPayphones()
{
    for(new i; i < sizeof(Payphones); i++)
    {
        PayphoneObject[i] = CreateDynamicObject(1216, Payphones[i][PayphonePosX], Payphones[i][PayphonePosY], Payphones[i][PayphonePosZ], 0, 0, Payphones[i][PayphonePosA]);
        PayphoneLabel[i] = CreateDynamic3DTextLabel("Payphone{FFFFFF}\n\nUse /payphone to use.", COLOR_GREEN, Payphones[i][PayphonePosX], Payphones[i][PayphonePosY], Payphones[i][PayphonePosZ], 20.0, .testlos = 0);
    }
}

stock IsPlayerNearPayphone(playerid)
{
    for(new i; i < sizeof(Payphones); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, Payphones[i][PayphonePosX], Payphones[i][PayphonePosY], Payphones[i][PayphonePosZ]))
        {
            return i;
        }
    }
    return -1;
}

stock PayphoneCall(playerid, number)
{
    if(TempVar[playerid][Mobile] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You are already in a call.");

    TempVar[playerid][UsingPayphone] = true;
    if(GetSpecialNumber(playerid, number) == 0)
    {
        TempVar[playerid][CallLandline] = 0;

        if(number == GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)))
            return SendErrorMessage(playerid, "You cannot call yourself.");

        if(PlayerInfo[playerid][pMoney] < 10)
            return SendErrorMessage(playerid, "You do not have enough money, you need $10.");

        foreach(new i: Player)
        {
            if(GetInventoryAmount(i, GetInventorySlot(playerid, INV_PHONE)) == number && number != 0)
            {
                if(Player[i][AdminLevel] >= 1 && TempVar[i][AdminDuty] == true)
                    return SendErrorMessage(playerid, "You cannot do this to on duty administrators.");

                if(TempVar[i][Spectating] != INVALID_PLAYER_ID)
                    return SendClientMessage(playerid, COLOR_YELLOW, "*** Phone is offline.");

                if(TempVar[i][Mobile] != INVALID_PLAYER_ID) 
                    return SendClientMessage(playerid, COLOR_YELLOW, "*** You just recieve a busy tone...");

                if(TempVar[i][Mobile] == INVALID_PLAYER_ID)
                {
                    TempVar[playerid][OnCall] = true;
                    TempVar[playerid][CallAnswer] = false;
                    TempVar[playerid][Mobile] = i;
                    TempVar[i][Mobile] = playerid;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "*** You are ringing %d... Please wait for an answer.", GetInventoryAmount(i, GetInventorySlot(i, INV_PHONE)));
                    SendClientMessageEx(i, COLOR_YELLOW, "*** Phone call from a payphone. Use /(p)ickup to answer.");
                    SendMe(i, "phone begins to ring.");
                    HandlePhoneRing(i);

                    TogglePlayerPhone(playerid, true);
                }
                return 1;
            }
        }
        SendClientMessage(playerid, COLOR_YELLOW, "*** You just recieve a busy tone...");
    }
    return 1;
}