//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#include <YSI\y_hooks.inc>

new gRocks, gGold, gIron;
new gCrudeOil, gPetrol, gDiesel;
new gAviationFuel, gChemicals, gMalt;
new gDrinks, gFruit, gWood;

new gPetrolCooldown, gDieselCooldown;

new bool:gEconomyReady = false;

#define MAX_CRUDE 100

new Float:MinerPos[][3] =
{
    {492.5857,783.6715,-22.0901},
    {465.4447,867.4714,-27.8070},
    {681.2389,924.4998,-40.7957},
    {694.2362,905.5909,-39.1207},
    {697.1213,887.3551,-38.6504}
};
new bool:MinerUsed[5] = false;
new MinerBomb[5];
new MinerRock[5];

#define Econ_File "Economy.ini"

hook OnGameModeInit()
{
    gPetrolCooldown = 0;
    gDieselCooldown = 0;

    if(!fexist(Econ_File))
    {
        printf("[WARNING] %s does not exist, continuing without.", Econ_File);
    }
	else
	{
        INI_ParseFile(Econ_File, "OnLoadEconomy", .bPassTag = true);
	}

    for(new i; i < sizeof(MinerPos); i++)
    {
        CreateDynamic3DTextLabel("Mining Spot\n{FFFFFF}((/minerock))", COLOR_YELLOW, MinerPos[i][0], MinerPos[i][1], MinerPos[i][2], 20.0, .worldid = 0, .interiorid = 0);
    }
    gEconomyReady = true;
    return 1;
}

hook OnGameModeExit()
{
    
    return 1;
}

function OnLoadEconomy(tag[], name[], value[])
{
    if (strcmp(tag, "Economy") == 0)
    {
        INI_Int("Rocks", gRocks);
        INI_Int("Gold", gGold);
        INI_Int("Iron", gIron);
        INI_Int("CrudeOil", gCrudeOil);
        INI_Int("Petrol", gPetrol);
        INI_Int("Diesel", gDiesel);
        INI_Int("AviationFuel", gAviationFuel);
        INI_Int("Chemicals", gChemicals);
        INI_Int("Malt", gMalt);
        INI_Int("Drinks", gDrinks);
        INI_Int("Fruit", gFruit);
        INI_Int("Wood", gWood);
    }
    return 1;
}


task OnEconomyUpdate[1000]()
{
    if(gEconomyReady == true)
    {
        if(gPetrolCooldown >= 1)
        {
            gPetrolCooldown--;
        }
        if(gDieselCooldown >= 1)
        {
            gDieselCooldown--;
        }
        if(gCrudeOil < MAX_CRUDE)
        {
            gCrudeOil++;
        }
        if(gCrudeOil >= 10 && gPetrolCooldown < 1)
        {
            gPetrol += 10;
            gPetrolCooldown = 60;
        }
        if(gDiesel >= 10 && gDieselCooldown < 1)
        {
            gDiesel += 10;
            gDieselCooldown = 60;
        }
    }
    return 1;
}

CMD:minestats(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessage(playerid, COLOR_GREEN, "______________________ Economy Stats ______________________");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Rocks:[%d] Gold:[%d] Iron:[%d] Crude (raw) Oil:[%d/%d] Petrol:[%d] Diesel:[%d]", gRocks, gGold, gIron, gCrudeOil, MAX_CRUDE, gPetrol, gDiesel);
        SendClientMessageEx(playerid, COLOR_GRAD4, "Aviation Fuel:[%d] Chemicals:[%d] Malt:[%d] Drinks:[%d] Fruit:[%d] Wood:[%d]", gAviationFuel, gChemicals, gMalt, gDrinks, gFruit, gWood);
        SendClientMessage(playerid, COLOR_WHITE, "Use '/econstats' to set each of these individual stats.");
    }
    return 1;
}

CMD:minerock(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER)
        return SendErrorMessage(playerid, "You are not a miner. (/findjob to find it)");
    
    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You need to exit your vehicle.");
    
    if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
        return SendErrorMessage(playerid, "You need to be outside to use this command.");

    for(new i; i < sizeof(MinerPos); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, MinerPos[i][0], MinerPos[i][1], MinerPos[i][2]))
        {
            if(MinerUsed[i] == true)
                return SendErrorMessage(playerid, "This spot is already being used. GET AWAY FROM IT!");

            if(IsValidDynamicObject(MinerRock[i]))
                return SendErrorMessage(playerid, "There is already a rock to be collected, go grab it.");

            new Float:posX, Float:posY, Float:posZ;
            GetPlayerPos(playerid, posX, posY, posZ);
            ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
            MinerUsed[i] = true;
            MinerBomb[i] = CreateDynamicObject(1654, posX, posY, posZ-0.7, 0.0, 0.0, 0.0, .worldid = 0, .interiorid = 0);
            ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
            SetTimerEx("OnBlowupRocks", 10000, false, "ddfff", playerid, i, posX, posY, posZ);
            SendServerMessage(playerid, "Dynamite has been placed, get away from it before it explodes.");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You need to be near a mining spot in the quarry.");
    return 1;
}

function OnBlowupRocks(playerid, i, Float:posX, Float:posY, Float:posZ)
{
    MinerUsed[i] = false;
    CreateExplosion(posX, posY, posZ, 0, 5.0);
    MinerRock[i] = CreateDynamicObject(2936, posX, posY, posZ-0.5, 0, 0, 0, .worldid = 0, .interiorid = 0);
}

CMD:grabrock(playerid, params[])
{
    for(new i; i < sizeof(MinerPos); i++)
    {
        new Float:posX, Float:posY, Float:posZ;
        GetDynamicObjectPos(MinerRock[i], posX, posY, posZ);
        if(IsPlayerInRangeOfPoint(playerid, 3.0, posX, posY, posZ))
        {
            if(MinerUsed[i] == true)
                return SendErrorMessage(playerid, "This spot is already being used. {%06x}GET AWAY FROM IT!", COLOR_LIGHTRED >>> 8);

            if(!IsValidDynamicObject(MinerRock[i]))
                return SendErrorMessage(playerid, "There is no rock to be collected.");

            ApplyAnimationEx(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
            SetTimerEx("CarryRock", 1000, false, "dd", playerid, i);
            ApplyAnimationEx(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
        }
    }
    return 1;
}

function CarryRock(playerid, i)
{
    if(IsValidDynamicObject(MinerRock[i]))
        DestroyDynamicObject(MinerRock[i]);

    ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid,9,2936,5,0.247000,0.374000,0.088999,0.000000,-77.099960,-70.699996,1.000000,1.000000,1.000000);
    SetPlayerCheckpoint(playerid, 618.5256,891.1608,-37.1285, 5.0);
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_MINER;
}

stock HandleMinerDelivery(playerid)
{
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_NONE;
    DisablePlayerCheckpoint(playerid);
    RemovePlayerAttachedObject(playerid, SLOT_MISC);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, SLOT_MISC);

    new rand = random(50)+30;
    ClearAnimations(playerid);
    SendActionMessage(playerid, "$%d was added to your pay cheque for completing the job.", rand);
    PlayerInfo[playerid][pPayCheque] += rand;
}

CMD:minerhelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_MINER)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Miner Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "You must go to the quarry and then go to the mining spots and type '/minerock'.");
        SendClientMessageEx(playerid, COLOR_GRAD4, "A block of dynamite is then placed which will then explode in 10 seconds.");
        SendClientMessageEx(playerid, COLOR_GRAD3, "After 10 seconds, there is an explosion in which a rock then falls from the mine.");
        SendClientMessageEx(playerid, COLOR_GRAD2, "You must then grab the rock using '/grabrock' and then deliver it to the platform.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}