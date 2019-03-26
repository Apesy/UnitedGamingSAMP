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

#define MAX_WEED_PLANTS 500

enum DrugPlantsEnum
{
    weedID,
    weedGrowth,
    Float:weedX,
    Float:weedY,
    Float:weedZ,
    Float:weedA,
    weedWorld,
    weedInterior,
    weedAddedBy[MAX_PLAYER_NAME],
    weedAddedDate[32],
    weedType,

    weedObject,
    Text3D:weedLabel,
};
new WeedPlants[MAX_WEED_PLANTS][DrugPlantsEnum];

new bool:HeroinUsage[MAX_PLAYERS], HeroinUsageTime[MAX_PLAYERS], HeroinAddiction[MAX_PLAYERS];

function DeleteWeedPlant(id)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "DELETE FROM Weed_Plants WHERE ID = %d", WeedPlants[id][weedID]);
    mysql_tquery(g_SQL, query);

    WeedPlants[id][weedID] = 0;
    WeedPlants[id][weedGrowth] = -1;

    if(IsValidDynamicObject(WeedPlants[id][weedObject]))
    {
        DestroyDynamicObject(WeedPlants[id][weedObject]);
    }
    return 1;
}

stock GetNextWeedPlantID()
{
	for (new i = 0; i < MAX_WEED_PLANTS; i++)
	{
		if (!WeedPlants[i][weedID])
		{
			return i;
		}
	}
	return -1;
}

stock SaveWeeds()
{
    for(new i; i < MAX_WEED_PLANTS; i++)
    {
        if(WeedPlants[i][weedID])
        {
            SaveWeed(i);
        }
    }
}

stock SaveWeed(id)
{
    new query[256];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE Weed_Plants SET Growth = %i, X = %f, Y = %f, Z = %f, A = %f, World = %i, Interior = %i WHERE ID = %i",
	WeedPlants[id][weedGrowth],
	WeedPlants[id][weedX],
	WeedPlants[id][weedY],
	WeedPlants[id][weedZ],
	WeedPlants[id][weedA],
	WeedPlants[id][weedWorld],
	WeedPlants[id][weedInterior],
	WeedPlants[id][weedID]);
	mysql_tquery(g_SQL, query);
}

stock LoadWeeds()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM Weed_Plants");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "ID", WeedPlants[i][weedID]);
		
            cache_get_value_int(i, "Growth", WeedPlants[i][weedGrowth]);
            cache_get_value_float(i, "X", WeedPlants[i][weedX]);
            cache_get_value_float(i, "Y", WeedPlants[i][weedY]);
            cache_get_value_float(i, "Z", WeedPlants[i][weedZ]);
            cache_get_value_float(i, "A", WeedPlants[i][weedA]);
            cache_get_value_int(i, "World", WeedPlants[i][weedWorld]);
            cache_get_value_int(i, "Interior", WeedPlants[i][weedInterior]);

            ReloadWeedPlant(i);
        }
    }
    cache_delete(result); 
}

stock ReloadWeedPlant(id)
{
    new string[128];
    if(IsValidDynamicObject(WeedPlants[id][weedObject]))
    {
        DestroyDynamicObject(WeedPlants[id][weedObject]);
    }

    if(IsValidDynamic3DTextLabel(WeedPlants[id][weedLabel]))
    {
        DestroyDynamic3DTextLabel(WeedPlants[id][weedLabel]);
    }

    WeedPlants[id][weedObject] = CreateDynamicObject(19473, WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ], 0.0, 0.0, WeedPlants[id][weedA], WeedPlants[id][weedWorld], WeedPlants[id][weedInterior]);
    format(string, sizeof string, "[%s Plant]", GetPlantType(WeedPlants[id][weedType]));
    WeedPlants[id][weedLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ], 20.0);
}

CMD:gotoplant(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new weed;
        if(sscanf(params, "d", weed))
            return SendUsageMessage(playerid, "/gotoplant [PlantID]");

        if(weed < 0 || !WeedPlants[weed][weedID] || weed > MAX_WEED_PLANTS)
            return SendErrorMessage(playerid, "Invalid PlantID specified.");
        
        SetInterior(playerid, WeedPlants[weed][weedInterior]);
        SetVirtualWorld(playerid, WeedPlants[weed][weedWorld]);

        if(WeedPlants[weed][weedInterior] != 0 || WeedPlants[weed][weedWorld] != 0)
        {
            TogglePlayerWait(playerid);
        }

        SetPlayerPosEx(playerid, WeedPlants[weed][weedX], WeedPlants[weed][weedY], WeedPlants[weed][weedZ]);
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:seizeplant(playerid, params[])
{
    new string[128];
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 5.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
            {
                format(string, sizeof string, "%s %s has removed drug plant %d.", GetAdminRank(playerid), GetMasterName(playerid), playerid, i);
                SendAdminCommand(string, 1);
                DeleteWeedPlant(i);
                return 1;
            }
        } 
        SendErrorMessage(playerid, "There are no weed plants near you.");
        return 1;
    }
	if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionSeize] == 1)
    {
        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 5.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
            {
                format(string, sizeof string, "%s %s (%d) has seized drug plant %d.", GetPlayerRank(playerid), GetUserName(playerid), playerid, i);
                SendAdminWarning(1, string);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You have removed the nearest drug plant.");
                DeleteWeedPlant(i);
                return 1;
            }
        } 
        SendErrorMessage(playerid, "There are no drug plants near you.");
        return 1;
    }
    SendErrorMessage(playerid, "You are not a cop or on duty admin.");
	return 1;
}

CMD:moveplant(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 5.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
            {
                TempVar[playerid][EditType] = EDIT_TYPE_WEED;
                EditDynamicObject(playerid, WeedPlants[i][weedObject]);
                return 1;
            }
        } 
        SendErrorMessage(playerid, "There are no drug plants near you.");
        return 1;
    }
	return 1;
}

CMD:checkplant(playerid, params[])
{
	if(IsAdminLevel(playerid, 2))
    {
        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 5.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
            {
                SendClientMessageEx(playerid, COLOR_YELLOW, "This drug plant was added by %s (%s), ID is %i and its growth level is on %i, It is growing %s.", WeedPlants[i][weedAddedBy], WeedPlants[i][weedAddedDate], i, WeedPlants[i][weedGrowth], GetPlantType(i));
                return 1;
            }
        }
        
        SendErrorMessage(playerid, "There are no weed plants near you.");
    }
	return 1;
}

stock GetPlantType(plantID)
{
    new plantStr[32];
    switch(WeedPlants[plantID][weedType])
    {
        case 0:
        {
            plantStr = "Marjiana";
        }
        case 1:
        {
            plantStr = "Poppy";
        }
        default:
        {
            plantStr = "Unknown";
        }
    }
    return plantStr;
}

/*CMD:plantweed(playerid, params[])
{
    if(PlayerInfo[playerid][pWeedSeeds] >= 1)
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		    return SendErrorMessage(playerid, "You are need to be on foot while using this.");

		if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
		    return SendErrorMessage(playerid, "You need to crouch before performing this.");

        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (IsPlayerInRangeOfPoint(playerid, 3.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]))
            {
                SendErrorMessage(playerid, "You are too close another plant.");
                return 1;
            }
        }

        new id = GetNextWeedPlantID();
        if(id == -1)
            return SendErrorMessage(playerid, "No more plants may be placed, please inform an administrator.");
        
        new query[256], Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO Weed_Plants (AddedBy, AddedDate) VALUES ('%e', '%e')",
        WeedPlants[id][weedAddedBy],
        WeedPlants[id][weedAddedDate]);
        mysql_tquery(g_SQL, query, "OnPlantWeed", "ii", playerid, id);
    }
    return 1;
}*/

function OnPlantWeed(playerid, id, slot)
{
    new string[128];
    ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 0, 0, 0, 1);

    WeedPlants[id][weedID] = cache_insert_id();
    GetPlayerPos(playerid, WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ]);
    GetPlayerFacingAngle(playerid, WeedPlants[id][weedA]);
    WeedPlants[id][weedWorld] = GetPlayerVirtualWorld(playerid);
    WeedPlants[id][weedInterior] = GetPlayerInterior(playerid);
    WeedPlants[id][weedGrowth] = 15;
    WeedPlants[id][weedType] = 0;
    ReloadWeedPlant(id);
    SetDynamicObjectPos(WeedPlants[id][weedObject], WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ]-2.5);

    format(WeedPlants[id][weedAddedBy], MAX_PLAYER_NAME, "%s", GetUserName(playerid));
    format(WeedPlants[id][weedAddedDate], 32, "%s", GetDateTime());
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have planted a weed plant at your location.");
    format(string, sizeof string, "%s (%d) has placed a weed plant (Plant ID: %d) at %s.", GetUserName(playerid), playerid, id, ReturnLocation(playerid));
    SendAdminWarning(1, string);
    SaveWeed(id);

    
    RemoveInventory(playerid, slot);
    return 1;
}

CMD:plantpoppy(playerid, params[])
{
    if(PlayerInfo[playerid][pPoppySeeds] >= 1)
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		    return SendErrorMessage(playerid, "You are need to be on foot while using this.");

		if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
		    return SendErrorMessage(playerid, "You need to crouch before performing this.");

        for (new i = 0; i < MAX_WEED_PLANTS; i++)
        {
            if (IsPlayerInRangeOfPoint(playerid, 3.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]))
            {
                SendErrorMessage(playerid, "You are too close another plant.");
                return 1;
            }
        }

        new id = GetNextWeedPlantID();
        if(id == -1)
            return SendErrorMessage(playerid, "No more plants may be placed, please inform an administrator.");
        
        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO Weed_Plants (AddedBy, AddedDate) VALUES ('%e', '%e')",
        WeedPlants[id][weedAddedBy],
        WeedPlants[id][weedAddedDate]);
        mysql_tquery(g_SQL, query, "OnPlantPoppy", "ii", playerid, id);
    }
    return 1;
}

function OnPlantPoppy(playerid, id)
{
    new string[128];
    PlayerInfo[playerid][pPoppySeeds]--;
    ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 0, 0, 0, 1);

    WeedPlants[id][weedID] = cache_insert_id();
    GetPlayerPos(playerid, WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ]);
    GetPlayerFacingAngle(playerid, WeedPlants[id][weedA]);
    WeedPlants[id][weedWorld] = GetPlayerVirtualWorld(playerid);
    WeedPlants[id][weedInterior] = GetPlayerInterior(playerid);
    WeedPlants[id][weedGrowth] = 15;
    WeedPlants[id][weedType] = 1;
    ReloadWeedPlant(id);
    SetDynamicObjectPos(WeedPlants[id][weedObject], WeedPlants[id][weedX], WeedPlants[id][weedY], WeedPlants[id][weedZ]-2.5);

    format(WeedPlants[id][weedAddedBy], MAX_PLAYER_NAME, "%s", GetUserName(playerid));
    format(WeedPlants[id][weedAddedDate], 32, "%s", GetDateTime());
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have planted a poppy plant at your location.");
    format(string, sizeof string, "%s (%d) has placed a poppy plant (Plant ID: %d) at %s.", GetUserName(playerid), playerid, id, ReturnLocation(playerid));
    SendAdminWarning(1, string);
    SaveWeed(id);
    return 1;
}


CMD:buyseed(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 0 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionDrugRights] == 0)
        return SendErrorMessage(playerid, "You do not have access to this.");
    
    new type[32], seeds;
    if(sscanf(params, "s[32]d", type, seeds))
        return SendUsageMessage(playerid, "/buyseed [Type] [Amount]"), SendClientMessage(playerid, -1, "Types: Weed, Poppy");

    if(strcmp(type, "Weed", true) == 0)
    {
        SetPVarInt(playerid, "SeedType", 0);
    }
    else if(strcmp(type, "Poppy", true) == 0)
    {
        SetPVarInt(playerid, "SeedType", 1);
    }
    else SendErrorMessage(playerid, "Invalid Seed Type specified.");

    new seedprice = seeds * 2, string[128];
    for(new i; i < MAX_BIZ; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(BusinessInfo[i][BizType] == 10)
            {
                SetPVarInt(playerid, "SeedType", seeds);
                SetPVarInt(playerid, "SeedAmount", seeds);
                SetPVarInt(playerid, "SeedPrice", seedprice);
                format(string, sizeof string, "You are about to buy %s seeds for $%s\nDo you confirm?", FormatNumber(seeds), FormatNumber(seedprice));
                Dialog_Show(playerid, SeedsConfirm, DIALOG_STYLE_MSGBOX, "Buy Seeds", string, "Confirm", "Cancel");
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You are not near an illegal business.");
    return 1;
}

Dialog:SeedsConfirm(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new seedprice = GetPVarInt(playerid, "SeedPrice");
        if(PlayerInfo[playerid][pMoney] < seedprice)
            return SendErrorMessage(playerid, "You cannot afford this amount of seeds.");
        
        new string[256];
        TakeMoney(playerid, seedprice);
        PlayerInfo[playerid][pWeedSeeds] = GetPVarInt(playerid, "SeedAmount");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have purchased seeds.");
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `WeedSeeds` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pWeedSeeds], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
        DeletePVar(playerid, "SeedPrice");
        DeletePVar(playerid, "SeedAmount");
    }
    return 1;
}

CMD:giveseed(playerid, params[])
{
    new target, amount;
    if(sscanf(params, "ud", target, amount))
        return SendUsageMessage(playerid, "/giveseed [PlayerID/PartOfName] [Amount]");

    if(amount < 1)
        return SendErrorMessage(playerid, "Amount must be above 0.");

    if(PlayerInfo[playerid][pWeedSeeds] > 0)
    {
        if(IsPlayerConnected(target))
        {
            if(IsPlayerNearPlayer(playerid, target, 10.0))
            {
                TempVar[target][SeedOffer] = playerid;
                TempVar[target][SeedAmount] = amount;
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have offered to give %s weed seeds, please wait for their confirmation.", GetRPName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "* %s has offered you seeds for your weed plants. Use \"/accept seeds\" to accept.", GetRPName(playerid));
            }
            else SendErrorMessage(playerid, "You are not near this player.");
        }
        else SendErrorMessage(playerid, "Player is not connected.");
    }
    else SendErrorMessage(playerid, "You have no seeds.");
    return 1;
}

stock HandleSeedAccept(playerid)
{
    new sellerid = TempVar[playerid][SeedOffer], string[128];
    if(IsPlayerConnected(sellerid))
    {
        if(!IsPlayerNearPlayer(playerid, sellerid, 10.0))
            return SendErrorMessage(playerid, "You need to be near the player who offered the seeds.");

        if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[sellerid][pLevel] <= 3 || TempVar[playerid][SeedAmount] >= 10)
        {
            format(string, sizeof(string), "%s (Level %d) has been given %s seeds by %s (Level %d).", GetUserName(playerid), PlayerInfo[playerid][pLevel], FormatNumber(TempVar[playerid][SeedAmount]), GetUserName(sellerid), PlayerInfo[sellerid][pLevel]);
            SendAdminWarning(1, string);
        }

        PlayerInfo[playerid][pWeedSeeds] += TempVar[playerid][SeedAmount];
        PlayerInfo[sellerid][pWeedSeeds] -= TempVar[playerid][SeedAmount];
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have accepted %s's seeds.", GetRPName(sellerid));
        SendClientMessageEx(sellerid, COLOR_LIGHTBLUE, "* %s has accepted your seeds.", GetRPName(playerid));
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `WeedSeeds` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pWeedSeeds], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `WeedSeeds` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[sellerid][pWeedSeeds], PlayerInfo[sellerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
    }
    return 1;
}

CMD:pickpoppy(playerid, params[])
{
    new string[128];
    for (new i = 0; i < MAX_WEED_PLANTS; i++)
    {
        if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 3.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
        {
            if(WeedPlants[i][weedType] != 1)
                return SendErrorMessage(playerid, "This is not a poppy plant.");

            if(WeedPlants[i][weedGrowth] != -1)
                return SendErrorMessage(playerid, "This plant is not ready, you may pick it in %d minute(s).", WeedPlants[i][weedGrowth]+1);

            SendAMe(playerid, "harvests the poppy plant.");
            new seedrand = random(4);
            new bool:lucky = false;
            if (seedrand == 1 || seedrand == 2)
            {
                PlayerInfo[playerid][pPoppySeeds]++;
                lucky = true;
            }

            new rand = random(10)+1;
            PlayerInfo[playerid][pOpium] += rand;
            if (lucky)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have gathered opium (%i) and you received 1 poppy seed.", rand);
            }
            else
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have gathered opium (%i).", rand);
            }
            if(PlayerInfo[playerid][pLevel] <= 3)
            {
                format(string, sizeof string, "%s (Level %d) has gathered the opium (%d) from plant %d.", GetUserName(playerid), PlayerInfo[playerid][pLevel], rand, i);
                SendAdminWarning(1, string);
            }
            DeleteWeedPlant(i);
            return 1;
        }
    }
    return 1;
}

CMD:pickweed(playerid, params[])
{
    new string[128];
    for (new i = 0; i < MAX_WEED_PLANTS; i++)
    {
        if (WeedPlants[i][weedID] && IsPlayerInRangeOfPoint(playerid, 3.0, WeedPlants[i][weedX], WeedPlants[i][weedY], WeedPlants[i][weedZ]) && WeedPlants[i][weedWorld] == GetPlayerVirtualWorld(playerid) && WeedPlants[i][weedInterior] == GetPlayerInterior(playerid))
        {
            if(WeedPlants[i][weedType] != 0)
                return SendErrorMessage(playerid, "This is not a weed plant.");

            if(WeedPlants[i][weedGrowth] != -1)
                return SendErrorMessage(playerid, "This plant is not ready, you may pick it in %d minute(s).", WeedPlants[i][weedGrowth]+1);

            SendAMe(playerid, "cuts the cannabis bushes and harvests the leaves.");
            new seedrand = random(4);
            new bool:lucky = false;
            if (seedrand == 1 || seedrand == 2)
            {
                PlayerInfo[playerid][pWeedSeeds]++;
                lucky = true;
            }

            new rand = random(10)+1;
            if(AddInventory(playerid, INV_WEED, rand) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have gathered marijuana (%i).", rand);
                if(PlayerInfo[playerid][pLevel] <= 3)
                {
                    format(string, sizeof string, "%s (Level %d) has gathered the marijuana (%d) from plant %d.", GetUserName(playerid), PlayerInfo[playerid][pLevel], rand, i);
                    SendAdminWarning(1, string);
                }
                if(lucky == true)
                {
                    new randSeed = random(10)+2;
                    if(AddInventory(playerid, INV_WEED_SEED, randSeed) == 1)
                    {
                        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You were also lucky enough get %d weed seeds.", randSeed);
                    }
                }
                DeleteWeedPlant(i);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
            return 1;
        }
    }
    return 1;
}

CMD:givedrug(playerid, params[])
{
    new target, type[32], amount, string[128];
    if(sscanf(params, "uds[32]", target, amount, type))
    {
        SendUsageMessage(playerid, "/givedrug [PlayerID/PartOfName] [Amount] [Type]");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Types: Weed");
        return 1;
    }

    if(amount < 0)
        return SendErrorMessage(playerid, "The amount must be above 0.");

    if(IsPlayerConnected(target))
    {
        if(!IsPlayerNearPlayer(playerid, target, 5.0))
            return SendErrorMessage(playerid, "You are not near that player.");

        if(strcmp(type, "weed", true) == 0)
        {
            if(PlayerInfo[playerid][pWeed] < amount)
                return SendErrorMessage(playerid, "You do not have enough weed to cover this amount.");
            
            if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[target][pLevel] <= 3 || amount > 10)
            {
                format(string, sizeof string, "%s (Level %d) has given %s (Level %d) %d grams of weed.", GetUserName(playerid), PlayerInfo[playerid][pLevel], GetUserName(target), PlayerInfo[target][pLevel], amount);
                SendAdminWarning(1, string);
            }

            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have given %s %d grams of weed.", GetRPName(target), amount);
            SendClientMessageEx(target, COLOR_LIGHTBLUE, "* You were given %d grams of weed by %s.", amount, GetRPName(playerid));
            PlayerInfo[playerid][pWeed] -= amount;
            PlayerInfo[target][pWeed] += amount;
            format(string, sizeof string, "has given %s drugs.", GetRPName(target));
            SendAMe(playerid, string);
        }
    }
    return 1;
}

CMD:usedrug(playerid, params[])
{
    if(PlayerInfo[playerid][pHoldingInv] == INV_WEED)
    {
        PlayerInfo[playerid][pHoldingInvAmount]--;
        if(PlayerInfo[playerid][pHoldingInvAmount] > 0)
        {
            if(AddInventory(playerid, INV_WEED, PlayerInfo[playerid][pHoldingInvAmount]) == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Placed the rest of the weed back into your inventory.");
                StopHoldInventoryItem(playerid);
            }
        }
        TempVar[playerid][SmokingWeed] = true;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You are now smoking weed. You can use {00FF00}/passjoint{%06x} to pass it to someone else.", COLOR_LIGHTBLUE >>> 8);
        StopHoldInventoryItem(playerid);
    }
    else if(PlayerInfo[playerid][pHoldingInv] == INV_COCAINE)
    {
        PlayerInfo[playerid][pHoldingInv]--;
        if(PlayerInfo[playerid][pHoldingInv] > 0)
        {
            if(AddInventory(playerid, INV_WEED, PlayerInfo[playerid][pHoldingInv]) == 1)
            {
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Placed the rest of the weed back into your inventory.");
                StopHoldInventoryItem(playerid);
            }
        }
        
        if(HeroinUsage[playerid] == true)
            return SendErrorMessage(playerid, "You have already used heroin.");

        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* You have taken heroin, you now feel less pain.");
        HeroinUsage[playerid] = true;
        GameTextForPlayer(playerid, "~w~You are~n~~p~Stoned", 4000, 1);
        SetPlayerDrunkLevel(playerid, 500000);
        SetPlayerWeather(playerid, 16);
        HeroinUsageTime[playerid] = 0;
        HeroinAddiction[playerid] = 0;
        SetPlayerHealthEx(playerid, GetHealth(playerid)+10);
        StopHoldInventoryItem(playerid);
    }
    else SendErrorMessage(playerid, "You are not holding any drugs. (Take from /inventory if you have some)");
    return 1;
}

new WireHouseSeconds[MAX_PLAYERS], WireHouseTimer[MAX_PLAYERS];

ptask DrugTimer[1000](playerid)
{
    if(HeroinUsage[playerid] == true)
    {
        SetPlayerDrunkLevel(playerid, 0);
        SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);
        HeroinUsageTime[playerid]++;
        if(HeroinUsageTime[playerid] >= 600)
        {
            HeroinUsage[playerid] = false;
            HeroinUsageTime[playerid] = 0;
            HeroinAddiction[playerid] = 1800;
        }
    }
    if(HeroinAddiction[playerid] >= 1)
    {
        HeroinAddiction[playerid]--;
        SetPlayerHealthEx(playerid, GetHealth(playerid)-0.5);
    }
}

CMD:wirehouse(playerid, params[])
{
    if(PlayerInfo[playerid][pWires] < 5)
        return SendErrorMessage(playerid, "You do not have enough wires, you need 5 wires.");

    new houseid = IsPlayerInsideHouse(playerid);
    if(houseid != -1)
    {
        if(HouseInfo[houseid][HouseOwnerID] == PlayerInfo[playerid][pCharacterID])
        {
            WireHouseSeconds[playerid] = 60;
            WireHouseTimer[playerid] = SetTimerEx("OnPlayerWireHouse", 1000, true, "dd", playerid, houseid);
        }
        else SendErrorMessage(playerid, "You do not own this house.");
    }
    else SendErrorMessage(playerid, "You are not inside your house.");
    return 1;
}

function OnPlayerWireHouse(playerid, houseid)
{
    if(IsPlayerInsideHouse(playerid) != houseid)
        return SendErrorMessage(playerid, "You left your house whilst wiring, operation cancelled."), KillTimer(WireHouseTimer[playerid]);

    new string[128];
    WireHouseSeconds[playerid]--;

    if(WireHouseSeconds[playerid] < 1)
    {
        KillTimer(WireHouseTimer[playerid]);
        HouseInfo[playerid][HouseWired] = 1;
        PlayerInfo[playerid][pWires] -= 5;
        PrintFooter(playerid, "~w~House has been sucessfully ~g~wired~w~.");
        return 1;
    }
    format(string, sizeof string, "~r~Wiring house: ~w~%d seconds left.", WireHouseSeconds[playerid]);
    PrintFooter(playerid, string, 1);
    return 1;
}

CMD:passjoint(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/passjoint [PlayerID/PartOfName]");

    if(!IsPlayerConnected(targetid))
        return SendErrorMessage(playerid, "That player is not connected.");
    
    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You are not near that player.");

    if(TempVar[playerid][SmokingWeed] == true)
    {
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have passed your joint to %s.", GetRPName(targetid));
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "* %s has passed a joint to you.", GetRPName(playerid));
        TempVar[playerid][SmokingWeed] = false;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        TempVar[targetid][SmokingWeed] = true;
        SetPlayerSpecialAction(targetid, SPECIAL_ACTION_SMOKE_CIGGY);
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(TempVar[playerid][SmokingWeed] == true)
    {
        if (newkeys & KEY_FIRE)
        {
            new drunkLevel = GetPlayerDrunkLevel(playerid);
            if(drunkLevel < 5000)
            {
                SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+1000);
            }
        }
        if ((oldkeys & KEY_SECONDARY_ATTACK) && !(newkeys & KEY_SECONDARY_ATTACK))
        {
            TempVar[playerid][SmokingWeed] = false;
        }
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    KillTimer(WireHouseTimer[playerid]);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    HeroinUsage[playerid] = false;
    HeroinUsageTime[playerid] = 0;
    WireHouseSeconds[playerid] = 0;
    KillTimer(WireHouseTimer[playerid]);
    return 1;
}