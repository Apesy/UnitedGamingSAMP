//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

new Float:gPierFishingSpots[5][3] = {
    {-411.2474, 1163.6589, 2.9527},
    {-488.9666, 614.5171, 1.7813},
    {-1379.0583, 2111.1436, 42.2000},
    {-918.8876, 2663.3953, 42.1982},
    {-480.4763, 2187.6550, 41.8599}
};

new Text3D:gPierFishingLabel[5];

stock LoadFishingPier()
{
    for(new i; i < sizeof(gPierFishingSpots); i++)
    {
        gPierFishingLabel[i] = CreateDynamic3DTextLabel("[Fishing Pier]\n\n{FFFFFF}Use {FFFF00}/pierfish{FFFFFF} to start fishing.", COLOR_GREEN, gPierFishingSpots[i][0], gPierFishingSpots[i][1], gPierFishingSpots[i][2], 50.0, .testlos = 0);
    }
}

stock IsPlayerNearPier(playerid)
{
    for(new i; i < sizeof(gPierFishingSpots); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 50.0, gPierFishingSpots[i][0], gPierFishingSpots[i][1], gPierFishingSpots[i][2]))
        {
            return 1;
        }
    }
    return 0;
}

new Float:gFishingSpots[10][3] = {
    {-598.6028,627.2927,-0.2150},
    {-900.9739,894.7993,-0.1076},
    {-1109.1182,706.6029,-0.2226},
    {-553.1392,443.7374,-0.3745},
    {-501.1150,1138.1958,-0.3575},
    {-720.4893,1370.2416,-0.4085},
    {-584.3187,1584.7522,-0.3423},
    {174.8501, 589.0546, -0.3423},
    {628.1019, 527.4611, -0.3423},
    {944.6288, 646.7427, -0.3423}
};

stock IsABoat(playerid)
{
    new pveh = GetVehicleModel(GetPlayerVehicleID(playerid));
    if(pveh == 430 || pveh == 446 || pveh == 452 || pveh == 453 || pveh == 454 || pveh == 472 || pveh == 473 || pveh == 484 || pveh == 493 || pveh == 595)
    {
        return 1;
    }
	return 0;
}

CMD:pierfish(playerid, params[])
{
    if(PlayerInfo[playerid][pFish] > 50)
        return SendErrorMessage(playerid, "You have too many fish, /sell your fish at at a fish bait shop.");

    if(PlayerInfo[playerid][pFishBait] < 1)
        return SendErrorMessage(playerid, "You have no fish bait, buy some from a bait shop.");

    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You must not be inside a vehicle.");

    if(gettime() - TempVar[playerid][FishDelay] < 5)
        return SendErrorMessage(playerid, "You must wait %d seconds before using this.", 5 - (gettime() - TempVar[playerid][FishDelay]));

    if(IsPlayerNearPier(playerid))
    {
        TempVar[playerid][FishDelay] = gettime()+5;
        TogglePlayerControllable(playerid, false);
        PrintFooter(playerid,"~w~Reeling in ~g~fish~w~~n~please wait",5);
        SetTimerEx("PierFishingCatch", 5000, false, "i", playerid);
    }
    else SendErrorMessage(playerid, "You are not a pier, use /findpier to find one.");
    return 1;
}

CMD:findpier(playerid, params[])
{
    new rand = random(sizeof(gPierFishingSpots));
    DisablePlayerCheckpoint(playerid);
    SetPlayerCheckpoint(playerid, gPierFishingSpots[rand][0], gPierFishingSpots[rand][1], gPierFishingSpots[rand][2], 5.0);
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_PIER;
    return 1;
}

CMD:fish(playerid, params[])
{
    if(PlayerInfo[playerid][pFish] > 500)
        return SendErrorMessage(playerid, "You have too many fish, /sell your fish at at a fish bait shop.");

    if(PlayerInfo[playerid][pFishBait] < 1)
        return SendErrorMessage(playerid, "You have no fish bait, buy some from a bait shop.");

    if(gettime() - TempVar[playerid][FishDelay] < 6)
        return SendErrorMessage(playerid, "You must wait %d seconds before using this.", 6 - (gettime() - TempVar[playerid][FishDelay]));

    if(IsABoat(playerid))
    {
        TempVar[playerid][Fishing] = true;
        new num = random(sizeof(gFishingSpots));
        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FISHING;
        TempVar[playerid][FishCheckpointID] = num;
        SetPlayerCheckpoint(playerid, gFishingSpots[num][0], gFishingSpots[num][1], gFishingSpots[num][2], 40.0);
        SendClientMessage(playerid, COLOR_GREEN, "-> {FFFFFF}Proceed to the first fishing checkpoint.");
    }
    return 1;
}

/*hook OnPlayerEnterCheckpoint(playerid)
{
    if(TempVar[playerid][FishCheckpoint] == true)
    {
        if(IsABoat(playerid))
        {
            GameTextForPlayer(playerid,"~w~Reeling in ~g~fish~w~~n~please wait",5000,3);
            SetTimerEx("FishingCatch", 5000, false, "i", playerid);
        }
    }
}*/

function PierFishingCatch(playerid)
{
    if(IsPlayerNearPier(playerid))
    {
        if(PlayerInfo[playerid][pFish] >= 100)
        {
            SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You can sell your fish at the fish bait shop.");
        }
        else
        {
            new chance = random(16);
            switch(chance)
            {
                case 0, 1, 2:
                {
                    new randSlot = random(2)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Minnow! It takes up %d slots.", randSlot);
                }
                case 3, 4, 5:
                {
                    new randSlot = random(4)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Trout! It takes up %d slots.", randSlot);
                }
                case 6, 7, 8:
                {
                    new randSlot = random(8)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Cod! It takes up %d slots.", randSlot);
                }
                case 9, 10, 11:
                {
                    new randSlot = random(16)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Carp! It takes up %d slots.", randSlot);
                }
                case 12, 13, 14:
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught nothing! Bad luck.");
                }
                case 15:
                {
                    new randMoney = random(10)+10;
                    GiveMoney(playerid, randMoney);
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a bag containing some money! You found $%d.", randMoney);
                }
            }
            PlayerInfo[playerid][pFishBait]--;
            if(PlayerInfo[playerid][pFishBait] < 0)
            {
                TempVar[playerid][Fishing] = false;
                SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You ran out of fish bait.");
                SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You can sell your fish at the fish bait shop.");
            }
        }
        TogglePlayerControllable(playerid, true);
        return 1;
    }
    else SendErrorMessage(playerid, "You failed to catch any fish because you were 50 meters away from the fishing spot.");
    TogglePlayerControllable(playerid, true);
    return 1;
}

function FishingCatch(playerid)
{
    DisablePlayerCheckpoint(playerid);
    new num = TempVar[playerid][FishCheckpointID];
    if(IsPlayerInRangeOfPoint(playerid, 40, gFishingSpots[num][0], gFishingSpots[num][1], gFishingSpots[num][2]))
    {
        if(PlayerInfo[playerid][pFish] >= 200)
        {
            TempVar[playerid][Fishing] = false;
            SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You can now return the boat, you can sell your fish at the fish bait shop.");
        }
        else
        {
            new chance = random(11);
            switch(chance)
            {
                case 0, 1:
                {
                    new randSlot = random(2)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Minnow! It takes up %d slots.", randSlot);
                }
                case 2, 3:
                {
                    new randSlot = random(4)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Trout! It takes up %d slots.", randSlot);
                }
                case 4, 5:
                {
                    new randSlot = random(8)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Cod! It takes up %d slots.", randSlot);
                }
                case 6, 7:
                {
                    new randSlot = random(16)+2;
                    PlayerInfo[playerid][pFish] += randSlot;
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a Carp! It takes up %d slots.", randSlot);
                }
                case 8, 9:
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught nothing! Bad luck.");
                }
                case 10:
                {
                    new randMoney = random(15)+15;
                    GiveMoney(playerid, randMoney);
                    SendClientMessageEx(playerid, COLOR_GREEN, "-> {FFFF00}You caught a bag containing some money! You found $%d.", randMoney);
                }
            }
            PlayerInfo[playerid][pFishBait]--;
            if(PlayerInfo[playerid][pFishBait] < 0)
            {
                TempVar[playerid][Fishing] = false;
                SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You ran out of fish bait.");
                SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You can now return the boat, you can sell your fish at the fish bait shop.");
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "-> {FFFFFF}Proceed to the next fishing checkpoint.");
                new rand = random(sizeof(gFishingSpots));
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FISHING;
                TempVar[playerid][FishCheckpointID] = rand;
                SetPlayerCheckpoint(playerid, gFishingSpots[rand][0], gFishingSpots[rand][1], gFishingSpots[rand][2], 40.0);
            }
        }
        return 1;
    }
    SendErrorMessage(playerid, "You failed to catch any fish because you were 40 meters away from the fishing spot.");
    new rand = random(sizeof(gFishingSpots));
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FISHING;
    TempVar[playerid][FishCheckpointID] = rand;
    SetPlayerCheckpoint(playerid, gFishingSpots[num][0], gFishingSpots[num][1], gFishingSpots[num][2], 40.0);
    return 1;
}

CMD:fishhelp(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Fishing Help:{FFFFFF} Type a command for more information.");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /fish, /stopfish, /sellfish, /fishinfo");
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:fishinfo(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_WHITE, "Current Fish: You currently have %s fish.", FormatNumber(PlayerInfo[playerid][pFish]));
    return 1;
}

CMD:buybait(playerid, params[])
{
    if(TempVar[playerid][Fishing] == true)
        return SendErrorMessage(playerid, "You are still fishing, /stopfish to be able to use this.");
    
    new amount;
    if(sscanf(params, "d", amount))
        return SendUsageMessage(playerid, "/buybait [Amount] - $10/amount.");

    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 50.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
                continue;
            
            if(GetPlayerVirtualWorld(playerid) != i)
                continue;

            if(BusinessInfo[i][BizType] == 16)
            {
                new fishPrice = amount*5;
                if(PlayerInfo[playerid][pMoney] > fishPrice)
                {
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought %s fish bait for $%s.", FormatNumber(amount), FormatNumber(fishPrice));
                    PlayerInfo[playerid][pMoney] -= fishPrice;
                    //BusinessInfo[i][BizSafe] += fishPrice; //It'll be extremly unprofitable, so I'm keepin it disabled.
                    PlayerInfo[playerid][pFishBait] += amount;
                    new string[128];
                    format(string, sizeof string, "%s (IP: %s AccountID: %d) has bought %s fish bait for $%s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], FormatNumber(amount), FormatNumber(fishPrice));
                    DBLog("Transaction", string);
                }
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You need to be inside a fish shop.");
    return 1;
}

CMD:sellfish(playerid, params[])
{
    if(TempVar[playerid][Fishing] == true)
        return SendErrorMessage(playerid, "You are still fishing, /stopfish to be able to use this.");
    
    new fishPrice = (PlayerInfo[playerid][pFish]/2) + ((PlayerInfo[playerid][pFish]/2)*2) + random(10)+1;
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 50.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
                continue;
            
            if(GetPlayerVirtualWorld(playerid) != i)
                continue;

            if(BusinessInfo[i][BizType] == 16)
            {
                if(PlayerInfo[playerid][pFish] > 0)
                {
                    PlayerInfo[playerid][pFish] = 0;
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have sold your fish for $%s.", FormatNumber(fishPrice));
                    PlayerInfo[playerid][pMoney] += fishPrice;
                    BusinessInfo[i][BizSafe] -= fishPrice;
                    new string[128];
                    format(string, sizeof string, "%s (IP: %s AccountID: %d) has sold their fish for $%s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], FormatNumber(fishPrice));
                    DBLog("Transaction", string);
                }
                else SendErrorMessage(playerid, "You do not have any fish to sell.");
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You need to be inside a fish shop.");
    return 1;
}

CMD:stopfish(playerid, params[])
{
    if(TempVar[playerid][CheckpointType] == CHECKPOINT_TYPE_FISHING)
    {
        TempVar[playerid][Fishing] = false;
        TempVar[playerid][CheckpointType] = 0;
        TempVar[playerid][FishCheckpointID] = 0;
        SendClientMessage(playerid, COLOR_GREEN, "-> {FFFF00}You can now return the boat, you can sell your fish at the fish bait shot.");
        DisablePlayerCheckpoint(playerid);
    }
    return 1;
}