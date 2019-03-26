//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum hInfo
{
    HouseID,
    HouseOwnerID,
    HouseMarketPrice,
    Float:HouseExteriorX,
    Float:HouseExteriorY,
    Float:HouseExteriorZ,
    Float:HouseExteriorA,
    HouseExteriorInt,
    HouseExteriorVW,
    Float:HouseInteriorX,
    Float:HouseInteriorY,
    Float:HouseInteriorZ,
    Float:HouseInteriorA,
    HouseInteriorInt,
    HouseLocked,
    HouseCashBox,
    HouseWeapons[MAX_HOUSE_WEP],
    HouseWeaponsAmmo[MAX_HOUSE_WEP],
    HouseWeaponsSerial[MAX_HOUSE_WEP],
    Float:HousePlacePosX,
    Float:HousePlacePosY,
    Float:HousePlacePosZ,
    HouseBoombox,
    HouseRentFee,
    HouseRentable,
    HouseWired,
    HouseAddress,
    HouseCustomExterior
};
new HouseInfo[MAX_HOUSES][hInfo],
    Text3D:HouseLabel[MAX_HOUSES],
    HousePickup[MAX_HOUSES],
    Cache:hCache;

new bool:HouseBoomboxOn[MAX_HOUSES], HouseBoomboxURL[MAX_HOUSES][128];

stock SaveHouses()
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID])
        {
            SaveHouse(i);
        }
    }
}

stock SaveHouse(houseid)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE houses SET \
    OwnerID = %d,\
    MarketPrice = %d,\
    ExteriorX = %f,\
    ExteriorY = %f,\
    ExteriorZ = %f,\
    ExteriorA = %f,\
    ExteriorInt = %d,\
    ExteriorVW = %d,\
    InteriorX = %f,\
    InteriorY = %f,\
    InteriorZ = %f,\
    InteriorA = %f,\
    InteriorInt = %d,\
    Locked = %d,\
    CashBox = %d WHERE ID = %d", 
    HouseInfo[houseid][HouseOwnerID],
    HouseInfo[houseid][HouseMarketPrice],
    HouseInfo[houseid][HouseExteriorX],
    HouseInfo[houseid][HouseExteriorY],
    HouseInfo[houseid][HouseExteriorZ],
    HouseInfo[houseid][HouseExteriorA],
    HouseInfo[houseid][HouseExteriorInt],
    HouseInfo[houseid][HouseExteriorVW],
    HouseInfo[houseid][HouseInteriorX],
    HouseInfo[houseid][HouseInteriorY],
    HouseInfo[houseid][HouseInteriorZ],
    HouseInfo[houseid][HouseInteriorA],
    HouseInfo[houseid][HouseInteriorInt],
    HouseInfo[houseid][HouseLocked],
    HouseInfo[houseid][HouseCashBox],
    HouseInfo[houseid][HouseID]);
    mysql_tquery(g_SQL, query);

    for(new i; i < MAX_HOUSE_WEP; i++)
    {
        mysql_format(g_SQL, query, sizeof query, "UPDATE houses SET Weapons%d = %d, WeaponsAmmo%d = %d, WeaponsSerial%d = %d WHERE ID = %d", 
        i,
        HouseInfo[houseid][HouseWeapons][i],
        i,
        HouseInfo[houseid][HouseWeaponsAmmo][i],
        i,
        HouseInfo[houseid][HouseWeaponsSerial][i],
        HouseInfo[houseid][HouseID]);
        mysql_tquery(g_SQL, query);
    }

    mysql_format(g_SQL, query, sizeof query, "UPDATE houses SET \
    PlacePosX = %f,\
    PlacePosY = %f,\
    PlacePosZ = %f,\
    Boombox = %d,\
    RentFee = %d,\
    Rentable = %d,\
    Wired = %d,\
    Address = '%e',\
    CustomExterior = '%d' WHERE ID = %d", 
    HouseInfo[houseid][HousePlacePosX],
    HouseInfo[houseid][HousePlacePosY],
    HouseInfo[houseid][HousePlacePosZ],
    HouseInfo[houseid][HouseBoombox],
    HouseInfo[houseid][HouseRentFee],
    HouseInfo[houseid][HouseRentable],
    HouseInfo[houseid][HouseWired],
    HouseInfo[houseid][HouseAddress],
    HouseInfo[houseid][HouseCustomExterior],
    HouseInfo[houseid][HouseID]);
    mysql_tquery(g_SQL, query);
    return 1;
}

stock LoadHouses()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `houses`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            hCache = cache_save();
            cache_get_value_int(i, "ID", HouseInfo[i][HouseID]);

            cache_get_value_int(i, "OwnerID", HouseInfo[i][HouseOwnerID]);
            cache_get_value_int(i, "MarketPrice", HouseInfo[i][HouseMarketPrice]);

            cache_get_value_float(i, "ExteriorX", HouseInfo[i][HouseExteriorX]);
            cache_get_value_float(i, "ExteriorY", HouseInfo[i][HouseExteriorY]);
            cache_get_value_float(i, "ExteriorZ", HouseInfo[i][HouseExteriorZ]);
            cache_get_value_float(i, "ExteriorA", HouseInfo[i][HouseExteriorA]);
            cache_get_value_int(i, "ExteriorInt", HouseInfo[i][HouseExteriorInt]);
            cache_get_value_int(i, "ExteriorVW", HouseInfo[i][HouseExteriorVW]);
            cache_get_value_float(i, "InteriorX", HouseInfo[i][HouseInteriorX]);
            cache_get_value_float(i, "InteriorY", HouseInfo[i][HouseInteriorY]);
            cache_get_value_float(i, "InteriorZ", HouseInfo[i][HouseInteriorZ]);
            cache_get_value_float(i, "InteriorA", HouseInfo[i][HouseInteriorA]);
            cache_get_value_int(i, "InteriorInt", HouseInfo[i][HouseInteriorInt]);
            cache_get_value_int(i, "Locked", HouseInfo[i][HouseLocked]);
            cache_get_value_int(i, "CashBox", HouseInfo[i][HouseCashBox]);

            // I rrly do not like this code, but having a loop made the compiler cry :(
            cache_get_value_int(i, "Weapons0", HouseInfo[i][HouseWeapons][0]);
            cache_get_value_int(i, "Weapons1", HouseInfo[i][HouseWeapons][1]);
            cache_get_value_int(i, "Weapons2", HouseInfo[i][HouseWeapons][2]);
            cache_get_value_int(i, "Weapons3", HouseInfo[i][HouseWeapons][3]);
            cache_get_value_int(i, "Weapons4", HouseInfo[i][HouseWeapons][4]);
            cache_get_value_int(i, "Weapons5", HouseInfo[i][HouseWeapons][5]);
            cache_get_value_int(i, "Weapons6", HouseInfo[i][HouseWeapons][6]);
            cache_get_value_int(i, "Weapons7", HouseInfo[i][HouseWeapons][7]);
            cache_get_value_int(i, "Weapons8", HouseInfo[i][HouseWeapons][8]);
            cache_get_value_int(i, "Weapons9", HouseInfo[i][HouseWeapons][9]);
            cache_get_value_int(i, "Weapons10", HouseInfo[i][HouseWeapons][10]);
            cache_get_value_int(i, "Weapons11", HouseInfo[i][HouseWeapons][11]);
            cache_get_value_int(i, "Weapons12", HouseInfo[i][HouseWeapons][12]);
            cache_get_value_int(i, "Weapons13", HouseInfo[i][HouseWeapons][13]);
            cache_get_value_int(i, "Weapons14", HouseInfo[i][HouseWeapons][14]);
            cache_get_value_int(i, "Weapons15", HouseInfo[i][HouseWeapons][15]);
            cache_get_value_int(i, "Weapons16", HouseInfo[i][HouseWeapons][16]);
            cache_get_value_int(i, "Weapons17", HouseInfo[i][HouseWeapons][17]);
            cache_get_value_int(i, "Weapons18", HouseInfo[i][HouseWeapons][18]);
            cache_get_value_int(i, "Weapons19", HouseInfo[i][HouseWeapons][19]);
            cache_get_value_int(i, "Weapons20", HouseInfo[i][HouseWeapons][20]);

            // I rrly do not like this code, but having a loop made the compiler cry :(
            cache_get_value_int(i, "WeaponsAmmo0", HouseInfo[i][HouseWeaponsAmmo][0]);
            cache_get_value_int(i, "WeaponsAmmo1", HouseInfo[i][HouseWeaponsAmmo][1]);
            cache_get_value_int(i, "WeaponsAmmo2", HouseInfo[i][HouseWeaponsAmmo][2]);
            cache_get_value_int(i, "WeaponsAmmo3", HouseInfo[i][HouseWeaponsAmmo][4]);
            cache_get_value_int(i, "WeaponsAmmo5", HouseInfo[i][HouseWeaponsAmmo][5]);
            cache_get_value_int(i, "WeaponsAmmo6", HouseInfo[i][HouseWeaponsAmmo][6]);
            cache_get_value_int(i, "WeaponsAmmo7", HouseInfo[i][HouseWeaponsAmmo][7]);
            cache_get_value_int(i, "WeaponsAmmo8", HouseInfo[i][HouseWeaponsAmmo][8]);
            cache_get_value_int(i, "WeaponsAmmo9", HouseInfo[i][HouseWeaponsAmmo][9]);
            cache_get_value_int(i, "WeaponsAmmo10", HouseInfo[i][HouseWeaponsAmmo][10]);
            cache_get_value_int(i, "WeaponsAmmo11", HouseInfo[i][HouseWeaponsAmmo][11]);
            cache_get_value_int(i, "WeaponsAmmo12", HouseInfo[i][HouseWeaponsAmmo][12]);
            cache_get_value_int(i, "WeaponsAmmo13", HouseInfo[i][HouseWeaponsAmmo][13]);
            cache_get_value_int(i, "WeaponsAmmo14", HouseInfo[i][HouseWeaponsAmmo][14]);
            cache_get_value_int(i, "WeaponsAmmo15", HouseInfo[i][HouseWeaponsAmmo][15]);
            cache_get_value_int(i, "WeaponsAmmo16", HouseInfo[i][HouseWeaponsAmmo][16]);
            cache_get_value_int(i, "WeaponsAmmo17", HouseInfo[i][HouseWeaponsAmmo][17]);
            cache_get_value_int(i, "WeaponsAmmo18", HouseInfo[i][HouseWeaponsAmmo][18]);
            cache_get_value_int(i, "WeaponsAmmo19", HouseInfo[i][HouseWeaponsAmmo][19]);
            cache_get_value_int(i, "WeaponsAmmo20", HouseInfo[i][HouseWeaponsAmmo][20]);
            
            cache_get_value_float(i, "PlacePosX", HouseInfo[i][HousePlacePosX]);
            cache_get_value_float(i, "PlacePosY", HouseInfo[i][HousePlacePosY]);
            cache_get_value_float(i, "PlacePosZ", HouseInfo[i][HousePlacePosZ]);

            cache_get_value_int(i, "Boombox", HouseInfo[i][HouseBoombox]);
            cache_get_value_int(i, "RentFee", HouseInfo[i][HouseRentFee]);
            cache_get_value_int(i, "Rentable", HouseInfo[i][HouseRentable]);
            cache_get_value_int(i, "Wired", HouseInfo[i][HouseWired]);
            cache_get_value(i, "Address", HouseInfo[i][HouseAddress], 128);
            cache_get_value_int(i, "CustomExterior", HouseInfo[i][HouseCustomExterior]);

            HouseInfo[i][HouseLocked] = 1;

            UpdateHousePickup(i);
            cache_set_active(hCache);
        }
    }
    cache_delete(result); 
}

function UpdateHousePickup(i)
{
    if(IsValidDynamic3DTextLabel(HouseLabel[i]))
    {
        DestroyDynamic3DTextLabel(HouseLabel[i]);
    }

    if(IsValidDynamicPickup(HousePickup[i]))
    {
        DestroyDynamicPickup(HousePickup[i]);
    }

    if(HouseInfo[i][HouseID] > 0)
    {
        new string[256];
        if(HouseInfo[i][HouseOwnerID] == 0)
        {
            format(string, sizeof(string), "[House]\n\n{00FF00}FOR SALE{FFFFFF}\nPrice: $%s\nType /buyhouse to purchase.", FormatNumber(HouseInfo[i][HouseMarketPrice]), COLOR_HOUSE >>> 8);
        }
        else 
        {
            format(string, sizeof(string), "[House]\n\n{FFFFFF}Owner: %s\nLocked: %s", GetDatabaseName(HouseInfo[i][HouseOwnerID]), (HouseInfo[i][HouseLocked] == 1 ? ("Locked") : ("Unlocked")));
        }
        HouseLabel[i] = CreateDynamic3DTextLabel(string, COLOR_HOUSE, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]+1, 10.0, .testlos = 0, .worldid = HouseInfo[i][HouseExteriorVW], .interiorid = HouseInfo[i][HouseExteriorInt]);

        if(HouseInfo[i][HouseOwnerID] == 0)
        {
            HousePickup[i] = CreateDynamicPickup(1273, 1, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ], .worldid = HouseInfo[i][HouseExteriorVW], .interiorid = HouseInfo[i][HouseExteriorInt]);
        }
        else 
        {
            HousePickup[i] = CreateDynamicPickup(1272, 1, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ], .worldid = HouseInfo[i][HouseExteriorVW], .interiorid = HouseInfo[i][HouseExteriorInt]);
        }
    }
    return 1;
}

stock DoesPlayerOwnHouse(playerid, houseid)
{
    if(HouseInfo[houseid][HouseOwnerID] == PlayerInfo[playerid][pCharacterID])
    {
        return 1;
    }
    return 0;
}

stock GetPlayerHouses(playerid)
{
    new houses = 0;
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseOwnerID] == PlayerInfo[playerid][pCharacterID])
        {
            houses++;
        }
    }
    return houses;
}

CMD:househelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "House Help:{FFFFFF} Type a command for more information.");
    if(GetPlayerHouses(playerid) > 0)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "Commands: /buyhouse, /sellhouse, /rentroom, /unrent, /ringbell");
        SendClientMessage(playerid, COLOR_GRAD4, "Commands: /sellmyhouse, /setrent, /tenants, /houselocker");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD5, "Commands: /buyhouse, /rentroom, /unrent, /ringbell");
    }
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:houselocker(playerid, params[])
{
    if(GetPlayerHouses(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a house.");
    
    new option[32];
    if(sscanf(params, "s[32]", option))
    {
        SendUsageMessage(playerid, "/houselocker [Store/Take]");
        return 1;
    }

    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this house.");

            if(strcmp(option, "store", true) == 0)
            {
                TempVar[playerid][TakingFromHouse] = i;
                Dialog_Show(playerid, House_StoreMain, DIALOG_STYLE_LIST, "Store Menu", "Money\nWeapon", "Continue", "Cancel");
                return 1;
            }
            if(strcmp(option, "take", true) == 0)
            {
                TempVar[playerid][TakingFromHouse] = i;
                Dialog_Show(playerid, House_TakeMain, DIALOG_STYLE_LIST, "Take Menu", "Money\nWeapon", "Continue", "Cancel");
                return 1;
            }
            else SendUsageMessage(playerid, "/houselocker [Store/Take]");
            return 1;
        }
    }
    return 1;
}

Dialog:House_StoreMain(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: Dialog_Show(playerid, House_StoreMoney, DIALOG_STYLE_INPUT, "Store Money", "Type in the amount to store.", "Store", "Cancel");
            case 1:
            {
                new i = TempVar[playerid][TakingFromHouse];
                if(GetPlayerWeapon(playerid) >= 2 
                    && GetPlayerWeapon(playerid) != 19
                    && GetPlayerWeapon(playerid) != 20
                    && GetPlayerWeapon(playerid) != 21
                    && GetPlayerWeapon(playerid) != 19
                    && GetPlayerWeapon(playerid) != 35
                    && GetPlayerWeapon(playerid) != 36
                    && GetPlayerWeapon(playerid) != 37
                    && GetPlayerWeapon(playerid) != 38
                    && GetPlayerWeapon(playerid) != 39
                    && GetPlayerWeapon(playerid) != 44
                    && GetPlayerWeapon(playerid) != 45
                    && GetPlayerWeapon(playerid) != 46)
                {
                    new weaponid = GetPlayerWeapon(playerid);
                    for(new w; w < 21; w++)
                    {
                        if(HouseInfo[i][HouseWeapons][w] == 0)
                        {
                            HouseInfo[i][HouseWeapons][w] = weaponid;
                            HouseInfo[i][HouseWeaponsAmmo][w] = GetPlayerAmmo(playerid);
                            RemovePlayerGun(playerid, weaponid);
                            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have stored your %s in your house.", GetServerWeaponName(weaponid));
                            return 1;
                        }
                    }
                    SendErrorMessage(playerid, "You do not have enough space left to store weapons.");
                }
                else SendErrorMessage(playerid, "You need to be holding a valid weapon.");
            }
        }
    }
    return 1;
}

Dialog:House_TakeMain(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: 
            {
                new string[128];
                format(string, sizeof string, "Type in the amount to take.\nYou have $%s stored.", FormatNumber(HouseInfo[TempVar[playerid][TakingFromHouse]][HouseCashBox]));
                Dialog_Show(playerid, House_TakeMoney, DIALOG_STYLE_INPUT, "Take Money", "Type in the amount to take.\nYou have $%s stored.", "Take", "Cancel");
            }
            case 1: ShowWeaponTakeDialog(playerid, TempVar[playerid][TakingFromHouse]);
        }
    }
    return 1;
}

stock ShowWeaponTakeDialog(playerid, i)
{
    new weaponString[128*22];
    strcat(weaponString, "Weapon\t\tAmmo\n");
    for(new w; w < 21; w++)
    {
        if(HouseInfo[i][HouseWeapons][w] >= 2)
        {
            new string[128];
            format(string, sizeof string, "%s\t\t%d ammo\n", GetServerWeaponName(HouseInfo[i][HouseWeapons][w]), HouseInfo[i][HouseWeaponsAmmo][w]);
            strcat(weaponString, string);
        }
        else strcat(weaponString, "Empty Slot\t\t0 ammo\n");
    }
    Dialog_Show(playerid, House_TakeWeapon, DIALOG_STYLE_TABLIST_HEADERS, "Take Weapon", weaponString, "Take", "Cancel");
}

Dialog:House_TakeWeapon(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new houseid = TempVar[playerid][TakingFromHouse];
        for(new w; w < 21; w++)
        {
            if(listitem == w)
            {
                if(HouseInfo[houseid][HouseWeapons][w] >= 2)
                {
                    if(IsWeaponRestricted(playerid))
                        return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                    GivePlayerGun(playerid, HouseInfo[houseid][HouseWeapons][w], HouseInfo[houseid][HouseWeaponsAmmo][w], HouseInfo[houseid][HouseWeaponsSerial][w], false);
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have taken a %s from your house.", GetServerWeaponName(HouseInfo[houseid][HouseWeapons][w]));
                    HouseInfo[houseid][HouseWeapons][w] = 0;
                    HouseInfo[houseid][HouseWeaponsAmmo][w] = 0;
                }
                else ShowWeaponTakeDialog(playerid, houseid);
                return 1;
            }
        }
    }
    return 1;
}

Dialog:House_TakeMoney(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new houseid = TempVar[playerid][TakingFromHouse], string[128];
        if(IsNumeric(inputtext))
        {
            new amount = strval(inputtext);
            if(amount > HouseInfo[houseid][HouseCashBox])
            {
                format(string, sizeof string, "Type in the amount to take.\nERROR: You do not have that much money stored.\nYou have $%s stored.", FormatNumber(HouseInfo[TempVar[playerid][TakingFromHouse]][HouseCashBox]));
                Dialog_Show(playerid, House_TakeMoney, DIALOG_STYLE_INPUT, "Take Money", string, "Take", "Cancel");
                return 1;
            }

            if(amount < 1)
            {
                format(string, sizeof string, "Type in the amount to take.\nERROR: You must put in at least $1.\nYou have $%s stored.", FormatNumber(HouseInfo[TempVar[playerid][TakingFromHouse]][HouseCashBox]));
                Dialog_Show(playerid, House_TakeMoney, DIALOG_STYLE_INPUT, "Take Money", string, "Take", "Cancel");
                return 1;
            }
            
            GiveMoney(playerid, amount);
            HouseInfo[houseid][HouseCashBox] -= amount;
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have taken $%s from your house. Total: $%s", FormatNumber(amount), FormatNumber(HouseInfo[houseid][HouseCashBox]));
            return 1;
        }
        else
        {
            format(string, sizeof string, "Type in the amount to take.\nERROR: You must type in a valid number.\nYou have $%s stored.", FormatNumber(HouseInfo[TempVar[playerid][TakingFromHouse]][HouseCashBox]));
            Dialog_Show(playerid, House_TakeMoney, DIALOG_STYLE_INPUT, "Take Money", string, "Take", "Cancel");
            return 1;
        }
    }
    return 1;
}

Dialog:House_StoreMoney(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new houseid = TempVar[playerid][TakingFromHouse];
        if(IsNumeric(inputtext))
        {
            new amount = strval(inputtext);
            if(amount > PlayerInfo[playerid][pMoney])
                return Dialog_Show(playerid, House_StoreMoney, DIALOG_STYLE_INPUT, "Store Money", "Type in the amount to store.\nERROR: You do not have that much money.", "Store", "Cancel");

            if(amount < 1)
                return Dialog_Show(playerid, House_StoreMoney, DIALOG_STYLE_INPUT, "Store Money", "Type in the amount to store.\nERROR: You must put in at least $1.", "Store", "Cancel");
            
            TakeMoney(playerid, amount);
            HouseInfo[houseid][HouseCashBox] += amount;
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have stored $%s in your house. Total: $%s", FormatNumber(amount), FormatNumber(HouseInfo[houseid][HouseCashBox]));
            return 1;
        }
        else Dialog_Show(playerid, House_StoreMoney, DIALOG_STYLE_INPUT, "Store Money", "Type in the amount to store.\nERROR: You must type in a valid number.", "Store", "Cancel");
    }
    return 1;
}

CMD:sellhouse(playerid, params[])
{
    if(GetPlayerHouses(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a house.");
    
    new targetid, price;
    if(sscanf(params, "ud", targetid, price))
    {
        SendUsageMessage(playerid, "/sellhouse [PlayerID / Name] [Price]");
        return 1;
    }

    if(price < 1)
        return SendErrorMessage(playerid, "The price must be $1 or higher.");

    if(PlayerInfo[targetid][pMoney] < price)
        return SendErrorMessage(playerid, "This player does not have enough.");

    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this house.");

            TempVar[targetid][BuyingHouse] = i;
            TempVar[targetid][HousePrice] = price;

            foreach(new s: Player)
            {
                if(TempVar[s][SellingID] == playerid)
                {
                    TempVar[s][SellingID] = INVALID_PLAYER_ID;
                }
            }

            TempVar[targetid][SellingID] = playerid;
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** You have offered %s your house for $%s.", GetRPName(targetid), FormatNumber(price));
            SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "** %s wants to sell their house for $%s. Type \"/accept house\" to accept.", GetRPName(targetid), FormatNumber(price));
            return 1;
        }
    }
    return 1;
}

stock HandleHouseAccept(playerid)
{
    new string[128], houseid = TempVar[playerid][BuyingHouse], sellerid = TempVar[playerid][SellingID];
    if(HouseInfo[houseid][HouseOwnerID] != PlayerInfo[sellerid][pCharacterID])
        return SendErrorMessage(playerid, "This player does not own the house.");

    GiveMoney(sellerid, TempVar[playerid][HousePrice]);
    TakeMoney(playerid, TempVar[playerid][HousePrice]);
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[sellerid][pMoney], PlayerInfo[sellerid][pCharacterID]);
    mysql_tquery(g_SQL, string);

    HouseInfo[houseid][HouseOwnerID] = PlayerInfo[playerid][pCharacterID];
    SaveHouse(houseid);

    format(string, sizeof(string), "~w~You have sold your house! ~n~~g~+$%d", TempVar[playerid][HousePrice]);
    PrintFooter(sellerid, string);
    format(string, sizeof(string), "~y~Congratulations!~n~~w~You're now the owner of this house! ~n~~g~-$%d", TempVar[playerid][HousePrice]);
    PrintFooter(playerid, string);

    if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[sellerid][pLevel] <= 3 || TempVar[playerid][HousePrice] >= 10000)
    {
        format(string, sizeof(string), "%s (%d) has sold their house to %s (%s) in %s for $%s.", GetUserName(sellerid), sellerid, GetUserName(playerid), playerid, ReturnLocation(playerid), FormatNumber(TempVar[playerid][HousePrice]));
        SendAdminWarning(1, string);
    }

    format(string, sizeof(string), "%s (%s) has sold their house to %s (%s) in %s for $%s.", GetUserName(sellerid), GetUserIP(sellerid), GetUserName(playerid), GetUserIP(playerid), ReturnLocation(playerid), FormatNumber(TempVar[playerid][HousePrice]));
    DBLog("Transaction", string);
    return 1;
}

CMD:setrent(playerid, params[])
{
    if(GetPlayerHouses(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a house.");

    new price;
    if(sscanf(params, "d", price))
    {
        SendUsageMessage(playerid, "/setrent [Rent Fee]");
        return 1;
    }
    
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this house.");

            if(price < 1 || price > 100)
                return SendErrorMessage(playerid, "Minimum Rent is 1 and Maximum Rent is 100.");

            HouseInfo[i][HouseRentFee] = price;
            SendClientMessageEx(playerid, COLOR_YELLOW, "You have set the rent to $%s/hour.", FormatNumber(HouseInfo[i][HouseRentFee]));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be inside a house.");
    return 1;
}

CMD:sellmyhouse(playerid, params[])
{
    if(GetPlayerHouses(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a house.");
    
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this house.");

            TempVar[playerid][SellingHouse] = i;

            new string[128];
            format(string, sizeof string, "You are about to sell this house for $%s\nAre you absolutly sure?", FormatNumber(HouseInfo[i][HouseMarketPrice]));
            Dialog_Show(playerid, Dialog_SellHouse, DIALOG_STYLE_MSGBOX, "Selling Confirmation", string, "Confirm", "Cancel");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house.");
    return 1;
}

Dialog:Dialog_SellHouse(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], houseid = TempVar[playerid][SellingHouse];
        if(HouseInfo[houseid][HouseOwnerID] == 0)
            return SendErrorMessage(playerid, "This house is already sold.");

        GiveMoney(playerid, HouseInfo[houseid][HouseMarketPrice]);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);

        HouseInfo[houseid][HouseOwnerID] = 0;
        SaveHouse(houseid);

        format(string, sizeof(string), "~w~You have sold your house! ~n~~g~+$%d", HouseInfo[houseid][HouseMarketPrice]);
		PrintFooter(playerid, string);

        format(string, sizeof(string), "%s (%d) has sold their house in %s for $%s.", GetUserName(playerid), playerid, ReturnLocation(playerid), FormatNumber(HouseInfo[houseid][HouseMarketPrice]));
        SendAdminWarning(1, string);
        format(string, sizeof(string), "%s (%s) has sold their house in %s for $%s.", GetUserName(playerid), GetUserIP(playerid), ReturnLocation(playerid), FormatNumber(HouseInfo[houseid][HouseMarketPrice]));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:tenants(playerid, params[])
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
                continue;
                    
            if(GetPlayerVirtualWorld(playerid) != i)
                continue;

            if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this house.");

            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessageEx(playerid, COLOR_WHITE, "Listing all online tenants (excluding owner)...");
            foreach(new p: Player)
            {
                if(PlayerInfo[p][pRenting] == HouseInfo[i][HouseID])
                {
                    SendClientMessageEx(p, COLOR_GRAD5, "(ID: %d) %s", p, GetUserName(p));
                }
            }
            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
            return 1;
        }
    }
    return 1;
}

CMD:knock(playerid, params[])
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            foreach(new p: Player)
            {
                if(IsPlayerInRangeOfPoint(i, 50.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
                {
                    if(GetPlayerInterior(i) == HouseInfo[i][HouseInteriorInt] && GetPlayerVirtualWorld(i) == i)
                    {
                        SendClientMessage(i, COLOR_PURPLE, "* KNOCK ON DOOR! (( House Door ))");
                    }
                }
            }
            SendClientMessage(playerid, COLOR_PURPLE, "* KNOCK ON DOOR! (( House Door ))");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house.");
    return 1;
}

CMD:ringbell(playerid, params[])
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            foreach(new p: Player)
            {
                if(IsPlayerInRangeOfPoint(i, 50.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
                {
                    if(GetPlayerInterior(i) == HouseInfo[i][HouseInteriorInt] && GetPlayerVirtualWorld(i) == i)
                    {
                        SendClientMessage(i, COLOR_PURPLE, "* DOOR BELL RINGS! (( House Door ))");
                        GameTextForPlayer(i, "~r~Door bell rings!", 2000, 3);
                    }
                }
            }
            SendClientMessage(playerid, COLOR_PURPLE, "* DOOR BELL RINGS! (( House Door ))");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house.");
    return 1;
}

CMD:unrent(playerid, params[])
{
    if(PlayerInfo[playerid][pRenting] == 0)
        return SendErrorMessage(playerid, "You are not renting from anywhere.");

    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            PlayerInfo[playerid][pRenting] = 0;
            SendClientMessageEx(playerid, COLOR_YELLOW, "You are no longer renting from here. You will no longer spawn here.");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house.");
    return 1;
}

CMD:rentroom(playerid, params[])
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            if(HouseInfo[i][HouseOwnerID] == 0)
                return SendErrorMessage(playerid, "This house cannot be rented as it has no owner.");

            if(HouseInfo[i][HouseRentable] == 0)
                return SendErrorMessage(playerid, "This house cannot be rented.");

            if(PlayerInfo[playerid][pMoney] < HouseInfo[i][HouseRentFee])
                return SendErrorMessage(playerid, "You cannot afford to rent from here.");

            PlayerInfo[playerid][pRenting] = HouseInfo[i][HouseID];
            SendClientMessageEx(playerid, COLOR_YELLOW, "You will now spawn from here for $%s/hour. Make sure to use \"/setspawn house\" to spawn here.", FormatNumber(HouseInfo[i][HouseRentFee]));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house and close to its door.");
    return 1;
}

CMD:buyhouse(playerid, params[])
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            if(HouseInfo[i][HouseOwnerID] != 0)
                return SendErrorMessage(playerid, "This house is not for sale.");

            if(PlayerInfo[playerid][pMoney] < HouseInfo[i][HouseMarketPrice])
                return SendErrorMessage(playerid, "You cannot afford this house.");

            if(GetPlayerHouses(playerid) > 3)
                return SendErrorMessage(playerid, "You already have 3 houses.");

            TempVar[playerid][BuyingHouse] = i;

            new string[128];
            format(string, sizeof string, "You are about to purchase this house for $%s\nAre you absolutly sure?", FormatNumber(HouseInfo[i][HouseMarketPrice]));
            Dialog_Show(playerid, Dialog_PurchaseHouse, DIALOG_STYLE_MSGBOX, "Purchase Confirmation", string, "Confirm", "Cancel");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a house.");
    return 1;
}

Dialog:Dialog_PurchaseHouse(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], houseid = TempVar[playerid][BuyingHouse];
        if(HouseInfo[houseid][HouseOwnerID] != 0)
            return SendErrorMessage(playerid, "This house is not for sale.");

        TakeMoney(playerid, HouseInfo[houseid][HouseMarketPrice]);
        PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);

        HouseInfo[houseid][HouseOwnerID] = PlayerInfo[playerid][pCharacterID];
        UpdateHousePickup(houseid);
        SaveHouse(houseid);

        format(string, sizeof(string), "~y~Congratulations!~n~~w~You're now the owner of this house! ~n~~g~-$%d", HouseInfo[houseid][HouseMarketPrice]);
		PrintFooter(playerid, string);

        format(string, sizeof(string), "%s (ID: %d) has purchased a house in %s for $%s.", GetUserName(playerid), playerid, ReturnLocation(playerid), FormatNumber(HouseInfo[houseid][HouseMarketPrice]));
        SendAdminWarning(1, string);
        format(string, sizeof(string), "%s (IP: %s AccountID: %d) has purchased a house in %s for $%s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], ReturnLocation(playerid), FormatNumber(HouseInfo[houseid][HouseMarketPrice]));
        DBLog("Transaction", string);
    }
    return 1;
}

function OnCreateHouse(playerid, idx, Float:x, Float:y, Float:z, Float:angle)
{	
    HouseInfo[idx][HouseID] = cache_insert_id();
    HouseInfo[idx][HouseExteriorX] = x;
    HouseInfo[idx][HouseExteriorY] = y;
    HouseInfo[idx][HouseExteriorZ] = z;
    HouseInfo[idx][HouseExteriorA] = angle;
    HouseInfo[idx][HouseExteriorInt] = GetPlayerInterior(playerid);
    HouseInfo[idx][HouseExteriorVW] = GetPlayerVirtualWorld(playerid);
    UpdateHousePickup(idx);

    new string[128];
    format(string, sizeof string, "%s %s has created a new house with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), idx);
    SendAdminCommand(string, 4);
    format(string, sizeof(string), "%s %s has created a new house with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), idx);
    DBLog("EditHouse", string);
    return 1;
}

CMD:houseid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for(new i; i < MAX_HOUSES; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ])
                || IsPlayerInRangeOfPoint(playerid, 5.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
            {
                SendClientMessageEx(playerid, -1, "House ID: %d", i);
            }
        }
    }
    return 1;
}

CMD:edithouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new string[128], choice[32], i, amount;
        if(sscanf(params, "ds[32]D", i, choice, amount))
        {
            SendUsageMessage(playerid, "/edithouse [houseid] [name] [(Optional)amount]");
            SendClientMessage(playerid, COLOR_GRAD5, "Available Names: Exterior, Interior, Price, InsideInt, OutsideInt");
            SendClientMessage(playerid, COLOR_GRAD4, "Available Names: Boombox, Cashbox, CustomExterior");
            return 1;
        }

        if(strcmp(choice, "interior", true) == 0)
        {
            new Float:pos[4];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerFacingAngle(playerid, pos[3]);
            format(string, sizeof(string), "%s has changed house %d's interior. (B: %f, %f, %f, %f | A: %f, %f, %f, %f)", GetMasterName(playerid), i, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ], HouseInfo[i][HouseExteriorA], pos[0], pos[1], pos[2], pos[3]);
            DBLog("EditHouse", string);

            HouseInfo[i][HouseInteriorX] = pos[0];
            HouseInfo[i][HouseInteriorY] = pos[1];
            HouseInfo[i][HouseInteriorZ] = pos[2];
            HouseInfo[i][HouseInteriorA] = pos[3];
            HouseInfo[i][HouseInteriorInt] = GetPlayerInterior(playerid);
            SaveHouse(i);
            UpdateHousePickup(i);
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the interior of house %d.", i);
            return 1;
        }
        else if(strcmp(choice, "exterior", true) == 0)
        {
            new Float:pos[4];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerFacingAngle(playerid, pos[3]);
            format(string, sizeof(string), "%s has changed house %d's exterior. (B: %f, %f, %f, %f | A: %f, %f, %f, %f)", GetMasterName(playerid), i, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ], HouseInfo[i][HouseInteriorA], pos[0], pos[1], pos[2], pos[3]);
            DBLog("EditHouse", string);

            HouseInfo[i][HouseExteriorX] = pos[0];
            HouseInfo[i][HouseExteriorY] = pos[1];
            HouseInfo[i][HouseExteriorZ] = pos[2];
            HouseInfo[i][HouseExteriorA] = pos[3];
            HouseInfo[i][HouseExteriorInt] = GetPlayerInterior(playerid);
            HouseInfo[i][HouseExteriorVW] = GetPlayerVirtualWorld(playerid);
            SaveHouse(i);
            UpdateHousePickup(i);
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the exterior of house %d.", i);
            return 1;
        }
        else if(strcmp(choice, "price", true) == 0)
        {
            format(string, sizeof(string), "%s has changed house %d's price to $%d (B: $%d).", GetMasterName(playerid), i, amount, HouseInfo[i][HouseMarketPrice]);
            DBLog("EditHouse", string);
            HouseInfo[i][HouseMarketPrice] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the price of house %d to $%d.", i, amount);
            SaveHouse(i);
            UpdateHousePickup(i);
            return 1;
        }
        else if(strcmp(choice, "insideint", true) == 0)
        {
            if(!amount)
                return SendUsageMessage(playerid, "/edithouse HouseID InsideInt [Interior]");

            format(string, sizeof(string), "%s has changed house %d's inside interior to %d (B: %d).", GetMasterName(playerid), i, amount, HouseInfo[i][HouseInteriorInt]);
            DBLog("EditHouse", string);
            HouseInfo[i][HouseInteriorInt] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the inside int of house %d to %d.", i, amount);
            SaveHouse(i);
            return 1;
        }
        else if(strcmp(choice, "outsideint", true) == 0)
        {
            if(!amount)
                return SendUsageMessage(playerid, "/edithouse HouseID InsideInt [Interior]");

            format(string, sizeof(string), "%s has changed house %d's outside interior to %d (B: %d).", GetMasterName(playerid), i, amount, HouseInfo[i][HouseExteriorInt]);
            DBLog("EditHouse", string);
            HouseInfo[i][HouseExteriorInt] = amount;
            SetInterior(playerid, amount);
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the outside int of house %d to %d.", i, amount);
            SaveHouse(i);
            UpdateHousePickup(i);
            return 1;
        }
        else if(strcmp(choice, "boombox", true) == 0)
        {
            if(HouseInfo[i][HouseBoombox] == 1)
            {
                HouseInfo[i][HouseBoombox] = 0;
                SendClientMessageEx( playerid, COLOR_YELLOW, "You have removed house %d's boombox.", i);
                format(string, sizeof(string), "%s has removed house %d's boombox.", GetMasterName(playerid), i);
            }
            else
            {
                HouseInfo[i][HouseBoombox] = 1;
                SendClientMessageEx( playerid, COLOR_YELLOW, "You have given house %d a boombox.", i);
                format(string, sizeof(string), "%s has given house %d a boombox.", GetMasterName(playerid), i);
            }
            DBLog("EditHouse", string);
            SaveHouse(i);
            return 1;
        }
        else if(strcmp(choice, "cashbox", true) == 0)
        {
            format(string, sizeof(string), "%s has changed house %d's cashbox amount to $%s (B: $%s).", GetMasterName(playerid), i, FormatNumber(amount), FormatNumber(HouseInfo[i][HouseCashBox]));
            DBLog("EditHouse", string);
            HouseInfo[i][HouseCashBox] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the cashbox amount of house %d to $%s.", i, FormatNumber(amount));
            SaveHouse(i);
            return 1;
        }
        else if(strcmp(choice, "CustomExterior", true) == 0)
        {
            if(HouseInfo[i][HouseCustomExterior] == 1)
            {
                HouseInfo[i][HouseCustomExterior] = 0;
                SendClientMessageEx( playerid, COLOR_YELLOW, "House %d's exterior set as Custom (player will be frozen until objects load).", i);
                format(string, sizeof(string), "%s has set house %d's custom exterior to TRUE.", GetMasterName(playerid), i);
            }
            else
            {
                HouseInfo[i][HouseCustomExterior] = 1;
                SendClientMessageEx( playerid, COLOR_YELLOW, "House %d's exterior set as normal (player will be not frozen).", i);
                format(string, sizeof(string), "%s has set house %d's custom exterior to FALSE.", GetMasterName(playerid), i);
            }
            DBLog("EditHouse", string);
            SaveHouse(i);
            return 1;
        }
    }
    return 1;
}

CMD:createhouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for(new i; i < MAX_HOUSES; i++)
        {
            if(!HouseInfo[i][HouseID])
            {
                new Float:x, Float:y, Float:z, Float:angle, query[256];
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, angle);
                mysql_format(g_SQL, query, sizeof(query), "INSERT INTO houses (ExteriorX, ExteriorY, ExteriorZ, ExteriorA) VALUES(%f, %f, %f, %f)", x, y, z, angle);
                mysql_tquery(g_SQL, query, "OnCreateHouse", "iiffff", playerid, i, x, y, z, angle);
                return 1;
            }
        }
        SendErrorMessage(playerid, "The maximum number of houses has been reached.");
    }
    return 1;
}

CMD:deletehouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/deletehouse [House ID]");

        if(i < 0 || i > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        if(HouseInfo[i][HouseID] > 0)
        {
            new string[256];
            mysql_format(g_SQL, string, sizeof string, "DELETE FROM houses WHERE ID = %d LIMIT 1", HouseInfo[i][HouseID]);
            mysql_tquery(g_SQL, string);

            HouseInfo[i][HouseID] = 0;
            HouseInfo[i][HouseExteriorX] = 0.0;
            HouseInfo[i][HouseExteriorY] = 0.0;
            HouseInfo[i][HouseExteriorZ] = 0.0;
            HouseInfo[i][HouseExteriorA] = 0.0;
            HouseInfo[i][HouseInteriorX] = 0.0;
            HouseInfo[i][HouseInteriorY] = 0.0;
            HouseInfo[i][HouseInteriorZ] = 0.0;
            HouseInfo[i][HouseInteriorA] = 0.0;
            UpdateHousePickup(i);
            format(string, sizeof string, "%s %s has deleted house %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
            SendAdminCommand(string, 4);
            format(string, sizeof(string), "%s %s has deleted house %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
            DBLog("EditHouse", string);
            return 1;
        }
        SendErrorMessage(playerid, "Cannot find specified house.");
    }
    return 1;
}

CMD:asellhouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/asellhouse [House ID]");

        if(i < 0 || i > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        if(HouseInfo[i][HouseID] > 0)
        {
            new targetid = HouseInfo[i][HouseOwnerID], string[128];
            HouseInfo[i][HouseOwnerID] = 0;
            SaveHouse(i);
            SendClientMessageEx(playerid, COLOR_HOUSE, "** You have sold house %d.", i);
            foreach(new p: Player)
            {
                if(PlayerInfo[p][pCharacterID] == targetid)
                {
                    SendClientMessageEx(p, COLOR_HOUSE, "** Your house (HouseID %d) was sold by an administrator.", i);
                    break;
                }
            }
            format(string, sizeof string, "%s %s has set house %d for sale.", GetAdminRank(playerid), GetMasterName(playerid), i);
            SendAdminCommand(string, 4);
            format(string, sizeof(string), "%s %s has set house %d for sale.", GetAdminRank(playerid), GetMasterName(playerid), i);
            DBLog("EditHouse", string);
            UpdateHousePickup(i);
            return 1;
        }
        SendErrorMessage(playerid, "Cannot find specified house.");
    }
    return 1;
}

CMD:housestats(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/housestats [House ID]");

        if(i < 0 || i > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        if(HouseInfo[i][HouseID] > 0)
        {
            HouseStats(playerid, i);
            return 1;
        }
        SendErrorMessage(playerid, "Cannot find specified house.");
    }
    return 1;
}

stock HouseStats(playerid, houseid)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Owner:[%s] Market Price:[$%s] Locked:[%s] House ID:[%d]", 
        GetDatabaseName(HouseInfo[houseid][HouseOwnerID]), FormatNumber(HouseInfo[houseid][HouseMarketPrice]), (HouseInfo[houseid][HouseLocked] != 1) ? ("No") : ("Yes"), houseid);
    SendClientMessageEx(playerid, COLOR_GRAD4, "Cashbox:[%s] Boombox:[%s] Rentable:[%s] Rent Fee:[$%s]", 
        HouseInfo[houseid][HouseCashBox], (HouseInfo[houseid][HouseBoombox] != 1) ? ("No") : ("Yes"), (HouseInfo[houseid][HouseRentable] != 1) ? ("No") : ("Yes"), FormatNumber(HouseInfo[houseid][HouseRentFee]));
    SendClientMessageEx(playerid, COLOR_GRAD3, "Wired:[%s] Custom Exterior:[%s]", 
        (HouseInfo[houseid][HouseWired] != 1) ? ("No") : ("Yes"), (HouseInfo[houseid][HouseCustomExterior] != 1) ? ("No") : ("Yes"));
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
}

CMD:gotohouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/gotohouse [House ID]");

        if(i < 0 || i > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        if(HouseInfo[i][HouseID] > 0)
        {
            SetPlayerPosEx(playerid, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]);
            SetPlayerFacingAngle(playerid, HouseInfo[i][HouseExteriorA]);
            SetVirtualWorld(playerid, HouseInfo[i][HouseExteriorVW]);
            SetInterior(playerid, HouseInfo[i][HouseExteriorInt]);
            SendTeleportMessage(playerid);
            return 1;
        }
        SendErrorMessage(playerid, "Cannot find specified house.");
    }
    return 1;
}

stock SendToHouse(playerid, i)
{
    if(HouseInfo[i][HouseID] > 0)
    {
        SetPlayerPosEx(playerid, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]);
        SetPlayerFacingAngle(playerid, HouseInfo[i][HouseInteriorA]);
        SetVirtualWorld(playerid, i);
        SetInterior(playerid, HouseInfo[i][HouseInteriorInt]);
        TogglePlayerWait(playerid);
        return 1;
    }
    SendErrorMessage(playerid, "Cannot find specified house.");
    return 1;
}

CMD:goinhouse(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new houseid;
        if(sscanf(params, "d", houseid))
            return SendUsageMessage(playerid, "/goinhouse [House ID]");

        if(houseid < 0 || houseid > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        SendToHouse(playerid, houseid);
    }
    return 1;
}

CMD:atenants(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/atenants [House ID]");

        if(i < 0 || i > MAX_HOUSES)
            return SendErrorMessage(playerid, "Invalid HouseID specified.");

        if(HouseInfo[i][HouseID] > 0)
        {
            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessageEx(playerid, COLOR_WHITE, "Listing all online tenants (excluding owner)...");
            foreach(new p: Player)
            {
                if(PlayerInfo[p][pRenting] == HouseInfo[i][HouseID])
                {
                    SendClientMessageEx(p, COLOR_GRAD5, "(ID: %d) %s", p, GetUserName(p));
                }
            }
            SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
            return 1;
        }
        SendErrorMessage(playerid, "Cannot find specified house.");
    }
    return 1;
}

CMD:ahousehelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Admin House Help:{FFFFFF} Type a command for more information.");
        if(Player[playerid][AdminLevel] >= 1)
        {
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /gotohouse, /goinhouse, /atenants");
        }
        if(Player[playerid][AdminLevel] >= 4)
        {
            SendClientMessage(playerid, COLOR_GRAD4, "Commands: /createhouse, /deletehouse, /edithouse");
            SendClientMessage(playerid, COLOR_GRAD3, "Commands: /housestats, /asellhouse");
        }
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

stock House_HandleEnter(playerid)
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
				continue;

            if(HouseInfo[i][HouseLocked] == 1 && TempVar[playerid][AdminDuty] == false)
                return PrintFooter(playerid, "~r~Locked", 5);

            SetPlayerPosEx(playerid, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]);
            SetPlayerFacingAngle(playerid, HouseInfo[i][HouseInteriorA]);
            SetVirtualWorld(playerid, i);
            SetInterior(playerid, HouseInfo[i][HouseInteriorInt]);
            TogglePlayerWait(playerid);
            PrintFooter(playerid, "~w~Type /exit to get out", 5);

            if(HouseBoomboxOn[i] == true)
            {
                if(strlen(HouseBoomboxURL[i]) > 0)
                {
                    PlayAudioStreamForPlayer(playerid, HouseBoomboxURL[i]);
                    SendClientMessage(playerid, COLOR_WHITE, "[TIP]: Use \"/setstation off\" if you want to turn off the radio.");
                }
            }
            return 1;
        }
    }
    return 1;
}

stock House_HandleExit(playerid)
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
				continue;

			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            SetPlayerPosEx(playerid, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]);
            SetPlayerFacingAngle(playerid, HouseInfo[i][HouseExteriorA]);
            SetVirtualWorld(playerid, HouseInfo[i][HouseExteriorVW]);
            SetInterior(playerid, HouseInfo[i][HouseExteriorInt]);
            StopAudioStreamForPlayer(playerid);
            if(HouseInfo[i][HouseExteriorInt] != 0 || HouseInfo[i][HouseCustomExterior] != 0)
            {
                TogglePlayerWait(playerid);
            }
            return 1;
        }
    }
    return 1;
}

stock IsPlayerInsideHouse(playerid)
{
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0 && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            return i;
        }
    }
    return -1;
}

stock GetHouseOwnerID(i)
{
    if(HouseInfo[i][HouseID] > 0)
    {
        return HouseInfo[i][HouseOwnerID];
    }
    return 0;
}