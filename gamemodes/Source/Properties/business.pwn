//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum bInfo
{
    BizID,
    BizOwnerID,
    BizName[128],
    BizMarketPrice,
    Float:BizExteriorX,
    Float:BizExteriorY,
    Float:BizExteriorZ,
    Float:BizExteriorA,
    BizExteriorInt,
    BizExteriorVW,
    Float:BizInteriorX,
    Float:BizInteriorY,
    Float:BizInteriorZ,
    Float:BizInteriorA,
    BizInteriorInt,
    BizLocked,
    BizEntryFee,
    BizType,
    BizSafe,
    BizProducts,
    BizGovClosed,
    BizSlogan[128],
    BizTrashUsed,
    BizTrash,
    Float:BizTrashX,
    Float:BizTrashY,
    Float:BizTrashZ,
};
new BusinessInfo[MAX_BIZ][bInfo],
    Text3D:BusinessLabel[MAX_BIZ],
    BusinessPickup[MAX_BIZ],
    BusinessTrashObject[MAX_BIZ],
    Cache:bCache;

new BizBoomboxURL[MAX_BIZ][128];

stock ShowBizTypes(playerid)
{
    SendClientMessage(playerid, -1, "Business Types: 1. 24/7, 2. Advertisement, 3. Clothes/Attachments, 4. Gun Store");
    SendClientMessage(playerid, -1, "Business Types: 5. Bar/Club 6. Casino, 7. Gym, 8. Donut Store, 9. Bank");
    SendClientMessage(playerid, -1, "Business Types: 10. Shady, 11. Cluckin Bell, 12. Pizzastack");
    SendClientMessage(playerid, -1, "Business Types: 13. Burgershot, 14. Unused, 15. Unused");
    return SendClientMessage(playerid, -1, "Business Types: 16. Fishing Shop");
}

/* 
    Business Types: 1. 24/7, 2. Advertisement, 3. Clothes/Attachments, 4. Gun Store
    Business Types: 5. Bar/Club 6. Casino, 7. Gym, 8. Restaurant, 9. Bank

    Business Open: [Business %d]\n\n%s\nEntry Fee: $%d
    Business Closed: [Business %d]\n\n%s\n{FF0000}Locked

    Commands: /buybiz, /sellbiz, /sellmybiz, /bizcash, /lock
    Bar/Club Commands: /mic, /givemic
    Casino: /mic, /givemic
*/

stock GetBusinessType(businessid)
{
    new typeString[32];
    switch(BusinessInfo[businessid][BizType])
    {
        case 1: typeString = "General Store";
        case 2: typeString = "Advertisement Centre";
        case 3: typeString = "Clothing Store";
        case 4: typeString = "Gun Store";
        case 5: typeString = "Bar/Club";
        case 6: typeString = "Casino";
        case 7: typeString = "Gym";
        case 8: typeString = "Restaurant";
        case 9: typeString = "Bank";
        case 10: typeString = "Shady";
        case 11: typeString = "Furniture";
        /*case 12: typeString = "High-End Dealership";
        case 13: typeString = "Boat Dealership";
        case 14: typeString = "Industrial Dealership";
        case 15: typeString = "Flight Dealership";*/
        case 16: typeString = "Fishing Shop";
        default: typeString = "None";
    }
    return typeString;
}

stock PrintBusinessInfo(playerid, businessid)
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
    SendClientMessageEx(playerid, COLOR_WHITE, "*** %s ***", BusinessInfo[businessid][BizName]);
    SendClientMessageEx(playerid, COLOR_GRAD5, "Locked:[%s] Entry Fee:[$%s] Cash:[$%s]", (BusinessInfo[businessid][BizLocked] == 1 ? ("Locked") : ("Unlocked")), FormatNumber(BusinessInfo[businessid][BizEntryFee]), FormatNumber(BusinessInfo[businessid][BizSafe]));
    SendClientMessageEx(playerid, COLOR_GRAD4, "Products:[%s] Market Price:[$%s] Type:[%s]", FormatNumber(BusinessInfo[businessid][BizProducts]), FormatNumber(BusinessInfo[businessid][BizMarketPrice]), GetBusinessType(businessid));
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
}

stock UpdateBusinessPickup(bizid)
{
    if(IsValidDynamicPickup(BusinessPickup[bizid])) DestroyDynamicPickup(BusinessPickup[bizid]);
    if(IsValidDynamic3DTextLabel(BusinessLabel[bizid])) DestroyDynamic3DTextLabel(BusinessLabel[bizid]);

    new string[128];
    if(BusinessInfo[bizid][BizOwnerID] > 0)
    {
        if(BusinessInfo[bizid][BizLocked] == 0)
        {
            format(string, sizeof string, "%s\n{00FF00}Open", BusinessInfo[bizid][BizName]);
        }
        else
        {
            format(string, sizeof string, "%s\n{FF0000}Closed", BusinessInfo[bizid][BizName]);
        }
    }
    else format(string, sizeof string, "%s\n$%s\n{%06x}For Sale.", BusinessInfo[bizid][BizName], FormatNumber(BusinessInfo[bizid][BizMarketPrice]), COLOR_BIZ >>> 8);

    if(BusinessInfo[bizid][BizType] == 16 || BusinessInfo[bizid][BizType] == 9)
    {
        format(string, sizeof string, "%s\n{00FF00}Always Open", BusinessInfo[bizid][BizName]);
        switch(BusinessInfo[bizid][BizType])
        {
            case 9: BusinessPickup[bizid] = CreateDynamicPickup(1274, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
            default: BusinessPickup[bizid] = CreateDynamicPickup(1272, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
        } 
    }
    else if(BusinessInfo[bizid][BizType] == 10)
    {
        format(string, sizeof string, "%s\n{00FFFF}Unknown", BusinessInfo[bizid][BizName]);
        BusinessPickup[bizid] = CreateDynamicPickup(1272, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
    }
    else
    {
        if(BusinessInfo[bizid][BizOwnerID] > 0)
        {
            switch(BusinessInfo[bizid][BizType])
            {
                case 3: BusinessPickup[bizid] = CreateDynamicPickup(1275, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
                default: BusinessPickup[bizid] = CreateDynamicPickup(1272, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
            } 
        }
        else BusinessPickup[bizid] = CreateDynamicPickup(19522, 1, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ], BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);
    }

    BusinessLabel[bizid] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, BusinessInfo[bizid][BizExteriorX], BusinessInfo[bizid][BizExteriorY], BusinessInfo[bizid][BizExteriorZ]+1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[bizid][BizExteriorVW], BusinessInfo[bizid][BizExteriorInt]);

}

stock LoadBusinesses()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `business`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            bCache = cache_save();
            cache_get_value_int(i, "ID", BusinessInfo[i][BizID]);

            cache_get_value_int(i, "OwnerID", BusinessInfo[i][BizOwnerID]);
            cache_get_value(i, "Name", BusinessInfo[i][BizName]);
            cache_get_value_int(i, "MarketPrice", BusinessInfo[i][BizMarketPrice]);
            cache_get_value_float(i, "ExteriorX", BusinessInfo[i][BizExteriorX]);
            cache_get_value_float(i, "ExteriorY", BusinessInfo[i][BizExteriorY]);
            cache_get_value_float(i, "ExteriorZ", BusinessInfo[i][BizExteriorZ]);
            cache_get_value_float(i, "ExteriorA", BusinessInfo[i][BizExteriorA]);
            cache_get_value_int(i, "ExteriorInt", BusinessInfo[i][BizExteriorInt]);
            cache_get_value_int(i, "ExteriorVW", BusinessInfo[i][BizExteriorVW]);
            cache_get_value_float(i, "InteriorX", BusinessInfo[i][BizInteriorX]);
            cache_get_value_float(i, "InteriorY", BusinessInfo[i][BizInteriorY]);
            cache_get_value_float(i, "InteriorZ", BusinessInfo[i][BizInteriorZ]);
            cache_get_value_float(i, "InteriorA", BusinessInfo[i][BizInteriorA]);
            cache_get_value_int(i, "InteriorInt", BusinessInfo[i][BizInteriorInt]);
            cache_get_value_int(i, "Locked", BusinessInfo[i][BizLocked]);
            cache_get_value_int(i, "EntryFee", BusinessInfo[i][BizEntryFee]);
            cache_get_value_int(i, "Type", BusinessInfo[i][BizType]);
            cache_get_value_int(i, "Safe", BusinessInfo[i][BizSafe]);
            cache_get_value_int(i, "Products", BusinessInfo[i][BizProducts]);
            cache_get_value_int(i, "GovClosed", BusinessInfo[i][BizGovClosed]);
            cache_get_value(i, "Slogan", BusinessInfo[i][BizSlogan]);

            if(BusinessInfo[i][BizType] == 16 || BusinessInfo[i][BizType] == 9 || BusinessInfo[i][BizType] == 10)
                BusinessInfo[i][BizLocked] = 0;

            UpdateBusinessPickup(i);
            cache_set_active(bCache);
        }
    }
    cache_delete(result); 
}

stock SaveBusinesses()
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID])
        {
            SaveBusiness(i);
        }
    }
}

stock SaveBusiness(businessid)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE business SET \
    OwnerID = %d,\
    Name = '%e',\
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
    EntryFee = %d,\
    Type = %d,\
    Safe = %d,\
    Products = %d,\
    GovClosed = %d,\
    Slogan = '%e' WHERE ID = %d", 
    BusinessInfo[businessid][BizOwnerID],
    BusinessInfo[businessid][BizName],
    BusinessInfo[businessid][BizMarketPrice],
    BusinessInfo[businessid][BizExteriorX],
    BusinessInfo[businessid][BizExteriorY],
    BusinessInfo[businessid][BizExteriorZ],
    BusinessInfo[businessid][BizExteriorA],
    BusinessInfo[businessid][BizExteriorInt],
    BusinessInfo[businessid][BizExteriorVW],
    BusinessInfo[businessid][BizInteriorX],
    BusinessInfo[businessid][BizInteriorY],
    BusinessInfo[businessid][BizInteriorZ],
    BusinessInfo[businessid][BizInteriorA],
    BusinessInfo[businessid][BizInteriorInt],
    BusinessInfo[businessid][BizLocked],
    BusinessInfo[businessid][BizEntryFee],
    BusinessInfo[businessid][BizType],
    BusinessInfo[businessid][BizSafe],
    BusinessInfo[businessid][BizProducts],
    BusinessInfo[businessid][BizGovClosed],
    BusinessInfo[businessid][BizSlogan],
    BusinessInfo[businessid][BizID]);
    mysql_tquery(g_SQL, query);
    return 1;
}

CMD:buybiz(playerid, params[])
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
				continue;

            if(BusinessInfo[i][BizOwnerID] != 0)
                return SendErrorMessage(playerid, "This business is not for sale.");

            if(BusinessInfo[i][BizType] == 16 || BusinessInfo[i][BizType] == 9)
                return SendErrorMessage(playerid, "This business is not for sale.");

            if(PlayerInfo[playerid][pMoney] < BusinessInfo[i][BizMarketPrice])
                return SendErrorMessage(playerid, "You cannot afford this business.");

            if(GetPlayerBiz(playerid) > 3)
                return SendErrorMessage(playerid, "You already have 3 businesses.");

            TempVar[playerid][BuyingBiz] = i;

            new string[128];
            format(string, sizeof string, "You are about to purchase this business for $%s\nAre you absolutly sure?", FormatNumber(BusinessInfo[i][BizMarketPrice]));
            Dialog_Show(playerid, Dialog_PurchaseBiz, DIALOG_STYLE_MSGBOX, "Purchase Confirmation", string, "Confirm", "Cancel");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a business.");
    return 1;
}

Dialog:Dialog_PurchaseBiz(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], bizid = TempVar[playerid][BuyingBiz];
        if(BusinessInfo[bizid][BizOwnerID] != 0)
            return SendErrorMessage(playerid, "This business is not for sale.");

        TakeMoney(playerid, BusinessInfo[bizid][BizMarketPrice]);
        PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);

        BusinessInfo[bizid][BizOwnerID] = PlayerInfo[playerid][pCharacterID];
        UpdateBusinessPickup(bizid);
        SaveBusiness(bizid);

        format(string, sizeof(string), "~y~Congratulations!~n~~w~You're now the owner of this business! ~n~~g~-$%d", BusinessInfo[bizid][BizMarketPrice]);
        PrintFooter(playerid, string);

        format(string, sizeof(string), "%s (ID: %d) has purchased a business in %s for $%s.", GetUserName(playerid), playerid, ReturnLocation(playerid), FormatNumber(BusinessInfo[bizid][BizMarketPrice]));
        SendAdminWarning(1, string);
        format(string, sizeof(string), "%s (IP: %s AccountID: %d) has purchased a business in %s for $%s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], ReturnLocation(playerid), FormatNumber(BusinessInfo[bizid][BizMarketPrice]));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:sellbiz(playerid, params[])
{
    if(GetPlayerBiz(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a business.");
    
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
				continue;

            if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this business.");

            TempVar[playerid][SellingHouse] = i;

            new string[128];
            format(string, sizeof string, "You are about to sell this business for $%s\nAre you absolutly sure?", FormatNumber(BusinessInfo[i][BizMarketPrice]));
            Dialog_Show(playerid, Dialog_SellBiz, DIALOG_STYLE_MSGBOX, "Selling Confirmation", string, "Confirm", "Cancel");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be outside a business.");
    return 1;
}

Dialog:Dialog_SellBiz(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], bizid = TempVar[playerid][SellingHouse];
        if(BusinessInfo[bizid][BizOwnerID] == 0)
            return SendErrorMessage(playerid, "This business is already sold.");

        GiveMoney(playerid, BusinessInfo[bizid][BizMarketPrice]);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);

        BusinessInfo[bizid][BizOwnerID] = 0;
        SaveBusiness(bizid);

        format(string, sizeof(string), "~w~You have sold your business! ~n~~g~+$%d", BusinessInfo[bizid][BizMarketPrice]);
		PrintFooter(playerid, string);

        format(string, sizeof(string), "%s (%d) has sold their business in %s for $%s.", GetUserName(playerid), playerid, ReturnLocation(playerid), FormatNumber(BusinessInfo[bizid][BizMarketPrice]));
        SendAdminWarning(1, string);
        format(string, sizeof(string), "%s (%s) has sold their business in %s for $%s.", GetUserName(playerid), GetUserIP(playerid), ReturnLocation(playerid), FormatNumber(BusinessInfo[bizid][BizMarketPrice]));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:bizfee(playerid, params[])
{
    if(GetPlayerBiz(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a business.");

    new price;
    if(sscanf(params, "d", price))
    {
        SendUsageMessage(playerid, "/bizfee [Entrance Fee]");
        return 1;
    }
    
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this business.");

            if(price < 1 || price > 100)
                return SendErrorMessage(playerid, "Minimum Fee is 1 and Maximum Fee is 100.");

            BusinessInfo[i][BizEntryFee] = price;
            SendClientMessageEx(playerid, COLOR_YELLOW, "You have set the rent to $%s.", FormatNumber(BusinessInfo[i][BizEntryFee]));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be inside a business.");
    return 1;
}

CMD:bizwithdraw(playerid, params[])
{
    if(GetPlayerBiz(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a business.");

    new amount;
    if(sscanf(params, "d", amount))
    {
        SendUsageMessage(playerid, "/bizwithdraw [Amount]");
        return 1;
    }
    
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this business.");

            if(amount < 1 || amount > BusinessInfo[i][BizSafe])
                return SendErrorMessage(playerid, "Minimum withdrawal is $1 and withdrawal is $%s.", BusinessInfo[i][BizSafe]);

            BusinessInfo[i][BizSafe] -= amount;
            GiveMoney(playerid, amount);
            SendClientMessageEx(playerid, COLOR_YELLOW, "You withdrawn $%s from your business.", FormatNumber(amount));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be inside a business.");
    return 1;
}

CMD:bizdeposit(playerid, params[])
{
    if(GetPlayerBiz(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a business.");

    new amount;
    if(sscanf(params, "d", amount))
    {
        SendUsageMessage(playerid, "/bizdeposit [Amount]");
        return 1;
    }
    
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this business.");

            if(amount < 1 || amount > PlayerInfo[i][pMoney])
                return SendErrorMessage(playerid, "Minimum deposit is $1 and max is $%s.", PlayerInfo[i][pMoney]);

            BusinessInfo[i][BizSafe] += amount;
            TakeMoney(playerid, amount);
            SendClientMessageEx(playerid, COLOR_YELLOW, "You deposited $%s into your business.", FormatNumber(amount));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be inside a business.");
    return 1;
}

CMD:bizinfo(playerid, params[])
{
    if(GetPlayerBiz(playerid) == 0)
        return SendErrorMessage(playerid, "You do not own a business.");
    
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "You do not own this business.");

            PrintBusinessInfo(playerid, i);
            return 1;
        }
    }
    SendErrorMessage(playerid, "You must be inside a business.");
    return 1;
}

CMD:businesshelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Business Help:{FFFFFF} Type a command for more information.");
    SendClientMessage(playerid, COLOR_GRAD5, "Commands: /buybiz, /bizinfo, /bizfee, /bizdeposit, /bizwithdraw, /sellbiz");
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:abizhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Admin Business Help:{FFFFFF} Type a command for more information.");
        if(Player[playerid][AdminLevel] >= 1)
        {
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /gotobiz, /goinbiz");
        }
        if(Player[playerid][AdminLevel] >= 4)
        {
            SendClientMessage(playerid, COLOR_GRAD4, "Commands: /createbiz, /deletebiz, /editbiz");
            SendClientMessage(playerid, COLOR_GRAD3, "Commands: /bizstats, /asellbiz");
        }
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:bizid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ])
                || IsPlayerInRangeOfPoint(playerid, 5.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
            {
                SendClientMessageEx(playerid, -1, "Business ID: %d", i);
            }
        }
    }
    return 1;
}

CMD:asellbiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/asellbiz [Business ID]");

        if(i < 0 || i > MAX_BIZ)
            return SendErrorMessage(playerid, "Invalid Business ID specified.");

        if(!BusinessInfo[i][BizID])
            return SendErrorMessage(playerid, "Cannot find specified business.");

        foreach(new target: Player)
        {
            if(PlayerInfo[target][pCharacterID] == BusinessInfo[i][BizOwnerID])
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Your business (%s) was sold by an administrator.", BusinessInfo[i][BizName]);
                break;
            }
        }
        new string[128];
        format(string, sizeof string, "%s %s has sold business %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
        SendAdminCommand(string, 4);
        WriteLog("Logs/editbusiness.log", string);
        BusinessInfo[i][BizOwnerID] = 0;
        UpdateHousePickup(i);
        return 1;
    }
    return 1;
}

CMD:bizstats(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new bizid;
        if(sscanf(params, "d", bizid))
            return SendUsageMessage(playerid, "/bizstats [Business ID]");

        if(bizid < 0 || bizid > MAX_BIZ)
            return SendErrorMessage(playerid, "Invalid Business ID specified.");

        if(!BusinessInfo[bizid][BizID])
            return SendErrorMessage(playerid, "Cannot find specified business.");
        
        PrintBusinessInfo(playerid, bizid);
    }
    return 1;
}

CMD:editbiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new string[128], choice[32], i, amount;
        if(sscanf(params, "ds[32]D", i, choice, amount))
        {
            SendUsageMessage(playerid, "/editbiz [bizid] [name] [(Optional)amount]");
            SendClientMessage(playerid, COLOR_GRAD5, "Available Names: Exterior, Interior, Price, InsideInt, OutsideInt");
            SendClientMessage(playerid, COLOR_GRAD4, "Available Names: Cash, Products, Type, Name");
            //SendClientMessage(playerid, COLOR_GRAD4, "Available Names: TrashAmount, TrashGet, EditTrash");
            return 1;
        }

        if(strcmp(choice, "interior", true) == 0)
        {
            new Float:pos[4];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerFacingAngle(playerid, pos[3]);
            format(string, sizeof(string), "%s has changed business %d's interior. (B: %f, %f, %f, %f | A: %f, %f, %f, %f)", GetMasterName(playerid), i, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ], BusinessInfo[i][BizInteriorA], pos[0], pos[1], pos[2], pos[3]);
            WriteLog("Logs/editbusiness.log", string);

            BusinessInfo[i][BizInteriorX] = pos[0];
            BusinessInfo[i][BizInteriorY] = pos[1];
            BusinessInfo[i][BizInteriorZ] = pos[2];
            BusinessInfo[i][BizInteriorA] = pos[3];
            BusinessInfo[i][BizInteriorInt] = GetPlayerInterior(playerid);
            SaveBusiness(i);
            UpdateBusinessPickup(i);
            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the interior of business %d.", i);
        }
        else if(strcmp(choice, "exterior", true) == 0)
        {
            new Float:pos[4];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerFacingAngle(playerid, pos[3]);
            format(string, sizeof(string), "%s has changed business %d's exterior. (B: %f, %f, %f, %f | A: %f, %f, %f, %f)", GetMasterName(playerid), i, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ], BusinessInfo[i][BizExteriorA], pos[0], pos[1], pos[2], pos[3]);
            WriteLog("Logs/editbusiness.log", string);

            BusinessInfo[i][BizExteriorX] = pos[0];
            BusinessInfo[i][BizExteriorY] = pos[1];
            BusinessInfo[i][BizExteriorZ] = pos[2];
            BusinessInfo[i][BizExteriorA] = pos[3];
            BusinessInfo[i][BizExteriorInt] = GetPlayerInterior(playerid);
            SaveBusiness(i);
            UpdateBusinessPickup(i);
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the exterior of business %d.", i);
        }
        else if(strcmp(choice, "price", true) == 0)
        {
            format(string, sizeof(string), "%s has changed business %d's price to $%s (B: $%s).", GetMasterName(playerid), i, FormatNumber(amount), FormatNumber(BusinessInfo[i][BizSafe]));
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizMarketPrice] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the price of business %d to $%s.", i, FormatNumber(amount));
            SaveBusiness(i);
            UpdateBusinessPickup(i);
        }
        else if(strcmp(choice, "outsideint", true) == 0)
        {
            format(string, sizeof(string), "%s has changed business %d's outside interior to %d (B: %d).", GetMasterName(playerid), i, amount, BusinessInfo[i][BizExteriorInt]);
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizExteriorInt] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the outside interior of business %d to %d.", i, amount);
            SaveBusiness(i);
            UpdateBusinessPickup(i);
        }
        else if(strcmp(choice, "insideint", true) == 0)
        {
            format(string, sizeof(string), "%s has changed business %d's inside interior to %d (B: %d).", GetMasterName(playerid), i, amount, BusinessInfo[i][BizInteriorInt]);
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizInteriorInt] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the inside interior of business %d to %d.", i, amount);
            SaveBusiness(i);
        }
        else if(strcmp(choice, "cash", true) == 0)
        {
            format(string, sizeof(string), "%s has changed business %d's cash amount to $%s (B: $%s).", GetMasterName(playerid), i, FormatNumber(amount), FormatNumber(BusinessInfo[i][BizSafe]));
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizSafe] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the cash amount of business %d to $%s.", i, FormatNumber(amount));
            SaveBusiness(i);
        }
        else if(strcmp(choice, "products", true) == 0)
        {
            format(string, sizeof(string), "%s has changed business %d's products amount to $%s (B: %s).", GetMasterName(playerid), i, FormatNumber(amount), FormatNumber(BusinessInfo[i][BizProducts]));
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizProducts] = amount;
            SendClientMessageEx(playerid, COLOR_YELLOW, "You have changed the products amount of business %d to %s.", i, FormatNumber(amount));
            SaveBusiness(i);
        }
        else if(strcmp(choice, "type", true) == 0)
        {
            if(amount == 0)
                return ShowBizTypes(playerid);
            
            format(string, sizeof(string), "%s has changed business %d's type amount to %d (B: %s).", GetMasterName(playerid), i, FormatNumber(amount), GetBusinessType(i));
            WriteLog("Logs/editbusiness.log", string);
            BusinessInfo[i][BizType] = amount;
            SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the products amount of business %d to %s.", i, GetBusinessType(i));
            SaveBusiness(i);
        }
        else if(strcmp(choice, "name", true) == 0)
        {
            TempVar[playerid][EditingBizName] = i;
            Dialog_Show(playerid, EditBiz_Name, DIALOG_STYLE_INPUT, "Business Name", "Set the name for this business.", "Okay", "Cancel");
            return 1;
        }
    }
    return 1;
}

Dialog:EditBiz_Name(playerid, response, listitem, inputtext[])
{
    new string[128];
    if(response && TempVar[playerid][EditingBizName] != 0)
    {
        new i = TempVar[playerid][EditingBizName];
        format(string, sizeof(string), "%s has changed business %d's name to %s (B: %s).", GetMasterName(playerid), i, inputtext, BusinessInfo[i][BizName]);
        WriteLog("Logs/editbusiness.log", string);
        format(BusinessInfo[i][BizName], 128, "%s", inputtext);
        SendClientMessageEx( playerid, COLOR_YELLOW, "You have changed the name of business %d to %s.", i, inputtext);
        SaveBusiness(i);
        UpdateBusinessPickup(i);
        return 1;
    }
    return 1;
}

CMD:deletebiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/deletebiz [Business ID]");

        if(i < 0 || i > MAX_BIZ)
            return SendErrorMessage(playerid, "Invalid Business ID specified.");

        if(!BusinessInfo[i][BizID])
            return SendErrorMessage(playerid, "Cannot find specified business.");

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "DELETE FROM business WHERE ID = %d LIMIT 1", BusinessInfo[i][BizID]);
        mysql_tquery(g_SQL, query, "OnDeleteBusiness", "dd", playerid, i);
    }
    return 1;
}

function OnDeleteBusiness(playerid, bizid)
{
    new string[128];
    BusinessInfo[bizid][BizID] = 0;
    BusinessInfo[bizid][BizExteriorX] = 0.0;
    BusinessInfo[bizid][BizExteriorY] = 0.0;
    BusinessInfo[bizid][BizExteriorZ] = 0.0;
    BusinessInfo[bizid][BizExteriorA] = 0.0;
    BusinessInfo[bizid][BizInteriorX] = 0.0;
    BusinessInfo[bizid][BizInteriorY] = 0.0;
    BusinessInfo[bizid][BizInteriorZ] = 0.0;
    BusinessInfo[bizid][BizInteriorA] = 0.0;
    UpdateBusinessPickup(bizid);
    format(string, sizeof string, "%s %s has deleted business %d.", GetAdminRank(playerid), GetMasterName(playerid), bizid);
    SendAdminCommand(string, 4);
    format(string, sizeof(string), "%s %s has deleted business %d.", GetAdminRank(playerid), GetMasterName(playerid), bizid);
    WriteLog("Logs/editbusiness.log", string);
    return 1;
}

CMD:createbiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(!BusinessInfo[i][BizID])
            {
                new Float:x, Float:y, Float:z, Float:angle, query[256];
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, angle);
                mysql_format(g_SQL, query, sizeof(query), "INSERT INTO business (ExteriorX, ExteriorY, ExteriorZ, ExteriorA) VALUES(%f, %f, %f, %f)", x, y, z, angle);
                mysql_tquery(g_SQL, query, "OnCreateBiz", "iiffff", playerid, i, x, y, z, angle);
                return 1;
            }
        }
        SendErrorMessage(playerid, "The maximum number of businesses has been reached.");
    }
    return 1;
}

CMD:gotobiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/gotobiz [Business ID]");

        if(i < 0 || i > MAX_BIZ)
            return SendErrorMessage(playerid, "Invalid Business ID specified.");

        if(!BusinessInfo[i][BizID])
            return SendErrorMessage(playerid, "Cannot find specified business.");

        SetPlayerPosEx(playerid, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]);
        SetPlayerFacingAngle(playerid, BusinessInfo[i][BizExteriorA]);
        SetVirtualWorld(playerid, BusinessInfo[i][BizExteriorVW]);
        SetInterior(playerid, BusinessInfo[i][BizExteriorInt]);
        SendTeleportMessage(playerid);
    }
    return 1;
}

CMD:goinbiz(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/goinbiz [Business ID]");

        if(i < 0 || i > MAX_BIZ)
            return SendErrorMessage(playerid, "Invalid Business ID specified.");

        if(!BusinessInfo[i][BizID])
            return SendErrorMessage(playerid, "Cannot find specified business.");

        SetPlayerPosEx(playerid, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]);
        SetPlayerFacingAngle(playerid, BusinessInfo[i][BizInteriorA]);
        SetVirtualWorld(playerid, i);
        SetInterior(playerid, BusinessInfo[i][BizInteriorInt]);
        TogglePlayerWait(playerid);
        SendTeleportMessage(playerid);
    }
    return 1;
}

function OnCreateBiz(playerid, idx, Float:x, Float:y, Float:z, Float:angle)
{	
    BusinessInfo[idx][BizID] = cache_insert_id();
    BusinessInfo[idx][BizExteriorX] = x;
    BusinessInfo[idx][BizExteriorY] = y;
    BusinessInfo[idx][BizExteriorZ] = z;
    BusinessInfo[idx][BizExteriorA] = angle;
    UpdateBusinessPickup(idx);

    new string[128];
    format(string, sizeof string, "%s %s has created a new business with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), idx);
    SendAdminCommand(string, 4);
    format(string, sizeof(string), "%s %s has created a new business with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), idx);
    WriteLog("Logs/editbusiness.log", string);
    return 1;
}

stock Biz_HandleEnter(playerid)
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
				continue;

            if(IsPlayerInAnyVehicle(playerid))
                return SendErrorMessage(playerid, "You need to leave your vehicle.");

            if(BusinessInfo[i][BizOwnerID] == 0 && BusinessInfo[i][BizType] != 16 && BusinessInfo[i][BizType] != 9 && TempVar[playerid][AdminDuty] == false)
                return PrintFooter(playerid, "~r~Locked", 5);
 
            if(BusinessInfo[i][BizLocked] == 1 && TempVar[playerid][AdminDuty] == false)
                return PrintFooter(playerid, "~r~Locked", 5);

            if(BusinessInfo[i][BizType] == 10)
            {
                if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionDrugRights] == 1)    
                {
                    PrintFooter(playerid, "~w~Use ~g~/buyseed ~w~to purchase seeds.", 5);
                    SendClientMessage(playerid, -1, "Use /buyseed here to purchase drug plant seeds.");
                }
                else PrintFooter(playerid, "~r~Locked", 5);
                return 1;
            }

            if(BusinessInfo[i][BizEntryFee] >= 1 && PlayerInfo[playerid][pCharacterID] != BusinessInfo[i][BizOwnerID])
            {
                if(PlayerInfo[playerid][pMoney] < BusinessInfo[i][BizEntryFee])
                    return SendErrorMessage(playerid, "You do not have enough money to enter this establishment.");
                
                TakeMoney(playerid, BusinessInfo[i][BizEntryFee]);
                BusinessInfo[i][BizSafe] += BusinessInfo[i][BizEntryFee];
            }

            SetPlayerPosEx(playerid, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]);
            SetPlayerFacingAngle(playerid, BusinessInfo[i][BizInteriorA]);
            SetVirtualWorld(playerid, i);
            SetInterior(playerid, BusinessInfo[i][BizInteriorInt]);
            TogglePlayerWait(playerid);
            if(strlen(BizBoomboxURL[i]) > 0)
            {
                PlayAudioStreamForPlayer(playerid, BizBoomboxURL[i]);
            }
            PrintFooter(playerid, "~w~Type /exit to get out", 5);

            SendClientMessageEx(playerid,COLOR_GREEN, "|_______________ {FFFFFF}%s{%06x} _______________|", BusinessInfo[i][BizName], COLOR_GREEN >>> 8);
            switch(BusinessInfo[i][BizType])
            {
                case 1: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /buy");
                case 2: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /ad, /cad, /ads");
                case 3: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /buy, /buyaccessories");
                case 4: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /buy");
                case 5: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /buy");
                //case 6: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /slotmachine");
                //case 7: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: ** Just roleplay **");
                case 8, 11, 12, 13: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /buyfood");
                case 9: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /withdraw, /deposit");
                case 16: SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /sellfish, /buybait");
            }
            if(PlayerInfo[playerid][pCharacterID] == BusinessInfo[i][BizOwnerID])
            {
                SendClientMessageEx(playerid, COLOR_WHITE, "Available Commands: /bizinfo, /bizfee, /bizdeposit, /bizwithdraw, /sellbiz");
            }
            return 1;
        }
    }
    return 1;
}

stock Biz_HandleExit(playerid)
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            SetPlayerPosEx(playerid, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]);
            SetPlayerFacingAngle(playerid, BusinessInfo[i][BizExteriorA]);
            SetVirtualWorld(playerid, BusinessInfo[i][BizExteriorVW]);
            SetInterior(playerid, BusinessInfo[i][BizExteriorInt]);
            StopAudioStreamForPlayer(playerid);
            TogglePlayerWait(playerid);
            /*if(BusinessInfo[playerid][BizExteriorInt] != 0)
            {
            }*/
            return 1;
        }
    }
    return 1;
}

stock IsPlayerOutsideBiz(playerid)
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 5.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
				continue;

            return i;
        }
    }
    return -1;
}

stock IsPlayerInsideBiz(playerid)
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 50.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != i)
				continue;

            return i;
        }
    }
    return -1;
}

stock GetPlayerBiz(playerid)
{
    new business = 0;
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizOwnerID] == PlayerInfo[playerid][pCharacterID])
        {
            business++;
        }
    }
    return business;
}


stock GetBizOwnerID(i)
{
    if(BusinessInfo[i][BizID])
    {
        if(BusinessInfo[i][BizOwnerID])
        {
            return BusinessInfo[i][BizOwnerID];
        }
    }
    return 0;
}