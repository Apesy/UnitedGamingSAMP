//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_DEALERS 50

enum vehiclePrices
{
    Model,
    Price
}

new RichDealership[][] = 
{
    {402, 220000}, //Buffalo
    {411, 630000}, //Infernus
    {415, 390000}, //Cheetah
    {429, 240000}, //Banshee
    {451, 405000}, //Turismo
    {475, 90000}, //Sabre
    {477, 191000}, //ZR-350
    {480, 240000}, //Comet
    {496, 160000}, //Blista Compact
    {506, 245000}, //Super GT
    {541, 875000}, //Bullet
    {558, 96000}, //Uranus
    {559, 200000}, //Jester
    {560, 280000}, //Sultan
    {562, 215000}, //Elegy
    {565, 126000}, //Flash
    {587, 121000}, //Euros
    {589, 114000}, //Club
    {602, 115000}, //Alpha
    {603, 215000} //Phoenix
};

new VehicleDealership[][] = 
{
    {440, 11000}, // Rumpo
    {543, 11000}, // Sadler
    {422, 15000}, // Bobcat
    {478, 8500}, // Walton
    {413, 13000}, // Pony
    {445, 34000}, // Admiral
    {401, 20000}, // Bravura
    {518, 22000}, // Buccaneer
    {527, 19000}, // Cadrona
    {542, 17000}, // Clover
    {507, 27000}, // Elegant
    {585, 20000}, // Emperor
    {419, 17500}, // Esperanto
    {526, 24000}, // Fortune
    {466, 25000}, // Glendale
    {492, 26000}, // Greenwood
    {474, 20000}, // Hermes
    {546, 18000}, // Intruder
    {517, 26000}, // Majestic
    {410, 19000}, // Manana
    {551, 32000}, // Merit
    {516, 17500}, // Nebula
    {467, 15500}, // Oceanic
    {426, 35000}, // Premier
    {436, 16000}, // Previon
    {547, 15500}, // Primo
    {405, 34500}, // Sentinel
    {580, 37000}, // Stafford
    {550, 30500}, // Sunrise
    {549, 14000}, // Tampa
    {540, 22000}, // Vincent
    {491, 19000}, // Virgo
    {529, 13000}, // Willard
    {421, 45000}, // Washington
    {479, 12500}, // Regina
    {458, 25000}, // Solair
    {404, 11000}, // Perenniel
    {561, 34500}, // Stratum
    {418, 14000}, // Moonbeam
    {500, 40000}, // Mesa
    {400, 35000}, // Landstalker
    {579, 65000}, // Huntley
    {566, 35500}, // Tahoma
    {576, 24000}, // Tornado
    {412, 23000}, // Voodoo
    {567, 29000}, // Savanna
    {534, 27000}, // Remington
    {536, 24500}, // Blade
    {508, 45000}, // Journey
    {483, 34500}, // Camper
    {575, 22000} // Broadway
};

new BikeDealership[][] = 
{
    {481, 100}, //BMX
    {509, 155}, //Bike
    {510, 190}, //Mountain Bike
    {462, 2000}, //Faggio
    {461, 95000}, //PCJ-600
    {463, 12000}, //Freeway
    {468, 10000}, //Sanchez
    {521, 105000}, //FCR-900
    {581, 110000}, //BF-400
    {586, 10000}, //Wayfarer
    {471, 9500} //Quad
};

new BoatDealership[][] = 
{
    {446, 16000}, //Squallo
    {452, 22000}, //Speeder
    {453, 2000}, //Reefer
    {454, 17500}, //Tropic
    {473, 500}, //Dinghy
    {484, 9000}, //Marquis
    {493, 40000} //Jetmax
};

new IndustrialDealership[][] = 
{
    {414, 25000}, //Mule
    {423, 105000}, //Mr.Whoopie
    {456, 35000}, //Yankee
    {498, 25000}, //Boxville
    {499, 20000}, //Benson
    {524, 125000}, //Cement Truck
    {552, 60000}, //Utility Van
    {578, 175000}, //DFT-30
    {588, 90000} //Hot-dog
};

enum dealerEnum
{
    DealerID,
    DealerName[32],
    DealerType,
    DealerPrice,
    DealerOwnerID,
    Float:DealerPosX,
    Float:DealerPosY,
    Float:DealerPosZ,
    Float:DealerSpawnX,
    Float:DealerSpawnY,
    Float:DealerSpawnZ,
    Float:DealerSpawnA,

    Text3D:DealerLabel,
    DealerPickup
};
new DealershipInfo[MAX_DEALERS][dealerEnum],
    Cache:dealerCache;

stock LoadDealership()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `dealership`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            dealerCache = cache_save();
            cache_get_value_int(i, "ID", DealershipInfo[i+1][DealerID]);

            cache_get_value(i, "Name", DealershipInfo[i+1][DealerName], 32);
            cache_get_value_int(i, "Type", DealershipInfo[i+1][DealerType]);
            cache_get_value_int(i, "Price", DealershipInfo[i+1][DealerPrice]);
            cache_get_value_int(i, "OwnerID", DealershipInfo[i+1][DealerOwnerID]);
            cache_get_value_float(i, "PosX", DealershipInfo[i+1][DealerPosX]);
            cache_get_value_float(i, "PosY", DealershipInfo[i+1][DealerPosY]);
            cache_get_value_float(i, "PosZ", DealershipInfo[i+1][DealerPosZ]);
            cache_get_value_float(i, "SpawnX", DealershipInfo[i+1][DealerSpawnX]);
            cache_get_value_float(i, "SpawnY", DealershipInfo[i+1][DealerSpawnY]);
            cache_get_value_float(i, "SpawnZ", DealershipInfo[i+1][DealerSpawnZ]);
            cache_get_value_float(i, "SpawnA", DealershipInfo[i+1][DealerSpawnA]);

            UpdateDealerPickup(i+1);
            Iter_Add(Dealerships,i+1);
            cache_set_active(dealerCache);
        }
    }
    cache_delete(result); 
}

stock SaveDealerships()
{
    for(new i; i < MAX_DEALERS; i++)
    {
        if(DealershipInfo[i][DealerID])
        {
            SaveDealership(i);
        }
    }
}

stock SaveDealership(dealerid)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "UPDATE dealership SET \
    Name = '%e',\
    Type = %d,\
    Price = %d,\
    OwnerID = %d,\
    PosX = %f,\
    PosY = %f,\
    PosZ = %f,\
    SpawnX = %f,\
    SpawnY = %f,\
    SpawnZ = %f,\
    SpawnA = %f WHERE ID = %d", 
    DealershipInfo[dealerid][DealerName],
    DealershipInfo[dealerid][DealerType],
    DealershipInfo[dealerid][DealerPrice],
    DealershipInfo[dealerid][DealerOwnerID],
    DealershipInfo[dealerid][DealerPosX],
    DealershipInfo[dealerid][DealerPosY],
    DealershipInfo[dealerid][DealerPosZ],
    DealershipInfo[dealerid][DealerSpawnX],
    DealershipInfo[dealerid][DealerSpawnY],
    DealershipInfo[dealerid][DealerSpawnZ],
    DealershipInfo[dealerid][DealerSpawnA],
    DealershipInfo[dealerid][DealerID]);
    mysql_tquery(g_SQL, query);
}

stock UpdateDealerPickup(dealerid)
{
    if(IsValidDynamic3DTextLabel(DealershipInfo[dealerid][DealerLabel]))
    {
        DestroyDynamic3DTextLabel(DealershipInfo[dealerid][DealerLabel]);
    }

    if(IsValidDynamicPickup(DealershipInfo[dealerid][DealerPickup]))
    {
        DestroyDynamicPickup(DealershipInfo[dealerid][DealerPickup]);
    }

    if(DealershipInfo[dealerid][DealerID])
    {
        new string[128];
        format(string, sizeof string, "[{FFFF00}Dealership %d{%06x}]\n\n{FFFF00}%s{%06x}\nUse {FFFF00}\"/v buy\"{%06x} to purchase a vehicle.", dealerid, COLOR_GREEN >>> 8, DealershipInfo[dealerid][DealerName], COLOR_GREEN >>> 8, COLOR_GREEN >>> 8);
        DealershipInfo[dealerid][DealerLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, DealershipInfo[dealerid][DealerPosX], DealershipInfo[dealerid][DealerPosY], DealershipInfo[dealerid][DealerPosZ], 20.0, .testlos = 0);

        DealershipInfo[dealerid][DealerPickup] = CreateDynamicPickup(1239, 1, DealershipInfo[dealerid][DealerPosX], DealershipInfo[dealerid][DealerPosY], DealershipInfo[dealerid][DealerPosZ]);
    }
}

CMD:dealerhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Vehicle Dealership Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /createdealer, /deletedealer, /editdealer.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:createdealer(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new type, price, name[32];
        if(sscanf(params, "dds[32]", type, price, name))
        {
            SendUsageMessage(playerid, "/createdealer [Type] [Price] [Name (Max 32. Chars)]");
            SendClientMessage(playerid, -1, "TYPE: 1. Sports, 2. Regular, 3. Bike, 4. Boat, 5. Industrial");
            return 1;
        }

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `dealership` (`Name`, `Type`, `Price`) VALUES ('%e', %d, %d)", name, type, price);
        mysql_tquery(g_SQL, query, "OnCreateDealership", "ddds", playerid, type, price, name);
    }
    return 1;
}

CMD:deletedealer(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new dealerid;
        if(sscanf(params, "d", dealerid))
            return SendUsageMessage(playerid, "/createdealer [Dealer ID]");

        if(!DealershipInfo[dealerid][DealerID])
            return SendErrorMessage(playerid, "That dealership does not exist!");

        new query[256];
        mysql_format(g_SQL, query, sizeof query, "DELETE FROM `dealership` WHERE `dealership`.`ID` = %d LIMIT 1", DealershipInfo[dealerid][DealerID]);
        mysql_tquery(g_SQL, query);
        ResetDealership(dealerid);
    }
    return 1;
}

CMD:editdealer(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new dealerid, option[32];
        if(sscanf(params, "ds[32]", dealerid, option))
        {
            SendUsageMessage(playerid, "/editdealer [Dealer ID] [Option]");
            SendClientMessage(playerid, -1, "Options: Buypos, Spawnpos, Type");
            return 1;
        }

        if(dealerid > MAX_DEALERS)
            return SendErrorMessage(playerid, "Invalid dealership specified, max is %d.", MAX_DEALERS);

        if(!DealershipInfo[dealerid][DealerID])
            return SendErrorMessage(playerid, "That dealership does not exist!");
        
        if(strcmp(option, "buypos", true) == 0)
        {
            GetPlayerPos(playerid, DealershipInfo[dealerid][DealerPosX], DealershipInfo[dealerid][DealerPosY], DealershipInfo[dealerid][DealerPosZ]);
            UpdateDealerPickup(dealerid);
        }
        else if(strcmp(option, "spawnpos", true) == 0)
        {
            GetPlayerPos(playerid, DealershipInfo[dealerid][DealerSpawnX], DealershipInfo[dealerid][DealerSpawnY], DealershipInfo[dealerid][DealerSpawnZ]);
        }
        else if(strcmp(option, "type", true) == 0)
        {
            SetPVarInt(playerid, "EditingDealer", dealerid);
            Dialog_Show(playerid, DealerType, DIALOG_STYLE_LIST, "Dealer Type", "Sports\nRegular\nBike\nBoat\nIndustrial", "Select", "Exit");
        }
        SaveDealership(dealerid);
    }
    return 1;
}

Dialog:DealerType(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new dealerid = GetPVarInt(playerid, "EditingDealer");
        DealershipInfo[dealerid][DealerType] = listitem+1;
        SendClientMessageEx(playerid, COLOR_YELLOW, "* Dealership type set to %d.", listitem+1);
        SendClientMessage(playerid, -1, "TYPES: 1. Sports, 2. Regular, 3. Bike, 4. Boat, 5. Industrial");
        SaveDealership(dealerid);
    }
    return 1;
}

stock ResetDealership(dealerid)
{
    DealershipInfo[dealerid][DealerName][0] = 0;
    DealershipInfo[dealerid][DealerType] = 0;
    DealershipInfo[dealerid][DealerPrice] = 0;
    DealershipInfo[dealerid][DealerOwnerID] = 0;
    DealershipInfo[dealerid][DealerPosX] = 0.0;
    DealershipInfo[dealerid][DealerPosY] = 0.0;
    DealershipInfo[dealerid][DealerPosZ] = 0.0;
    DealershipInfo[dealerid][DealerSpawnX] = 0.0;
    DealershipInfo[dealerid][DealerSpawnY] = 0.0;
    DealershipInfo[dealerid][DealerSpawnZ] = 0.0;
    DealershipInfo[dealerid][DealerSpawnA] = 0.0;
    DealershipInfo[dealerid][DealerID] = 0;

    if(IsValidDynamic3DTextLabel(DealershipInfo[dealerid][DealerLabel]))
    {
        DestroyDynamic3DTextLabel(DealershipInfo[dealerid][DealerLabel]);
    }

    if(IsValidDynamicPickup(DealershipInfo[dealerid][DealerPickup]))
    {
        DestroyDynamicPickup(DealershipInfo[dealerid][DealerPickup]);
    }
}

function OnCreateDealership(playerid, type, price, name[])
{
    new string[128], Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 1; i < MAX_DEALERS; i++)
    {
        if(!DealershipInfo[i][DealerID])
        {
            DealershipInfo[i][DealerID] = cache_insert_id();
            DealershipInfo[i][DealerType] = type;
            DealershipInfo[i][DealerPrice] = price;
            format(DealershipInfo[i][DealerName], 32, "%s", name);

            DealershipInfo[i][DealerPosX] = x;
            DealershipInfo[i][DealerPosY] = y;
            DealershipInfo[i][DealerPosZ] = z;

            UpdateDealerPickup(i);

            format(string, sizeof string, "%s %s has created a dealership at %s. (DealerID: %d)", GetAdminRank(playerid), GetMasterName(playerid), ReturnLocation(playerid), i);
            SendAdminCommand(string, 4);
            SendClientMessageEx(playerid, COLOR_RED, "WARNING: {FFFFFF}Make sure you use \"/editdealer %d Spawn\" to set the vehicle spawn.", i);
            return 1;
        }
    }
    return 1;
}

CMD:findvehdealer(playerid, params[])
{
    for(new i; i < MAX_DEALERS; i++)
    {
        if(DealershipInfo[i][DealerID])
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, DealershipInfo[i][DealerPosX], DealershipInfo[i][DealerPosY], DealershipInfo[i][DealerPosZ], 5.0);
            SendClientMessage(playerid, COLOR_PINK, "A dealership has been marked on your map.");
            TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_DEALER;
            return 1;
        }
    }
    SendErrorMessage(playerid, "Cannot find dealership, please post a bug report.");
    return 1;
}

stock IsPlayerNearDealer(playerid)
{
    for(new i; i < MAX_DEALERS; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 20.0, DealershipInfo[i][DealerPosX], DealershipInfo[i][DealerPosY], DealershipInfo[i][DealerPosZ]))
        {
           return i; 
        }
    }
    return 0;
}

Dialog:ConfirmPurchase(playerid, response, listitem, inputtext[])
{
    if(response && TempVar[playerid][ConfirmVehicle] >= 400)
    {
        if(PlayerInfo[playerid][pMoney] < TempVar[playerid][ConfirmVehiclePrice])
        {
            SendErrorMessage(playerid, "You cannot afford this vehicle. You need an extra $%s.", FormatNumber(TempVar[playerid][ConfirmVehiclePrice]-PlayerInfo[playerid][pMoney]));
            ShowVehicleMenu(playerid, TempVar[playerid][ConfirmVehicleDealer]);
            return 1;
        }

        SendServerMessage(playerid, "Giving vehicle...");

        new dealerid = TempVar[playerid][ConfirmVehicleDealer], vehid;
        for(new i; i < MAX_PVEH; i++)
        {
            if(!PlayerInfo[playerid][pOwnedVehicle][i])
            {
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_VEH;
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, DealershipInfo[dealerid][DealerSpawnX], DealershipInfo[dealerid][DealerSpawnY], DealershipInfo[dealerid][DealerSpawnZ], 10.0);
                vehid = CreateDynamicVehicle(TempVar[playerid][ConfirmVehicle], DealershipInfo[dealerid][DealerSpawnX], DealershipInfo[dealerid][DealerSpawnY], DealershipInfo[dealerid][DealerSpawnZ], DealershipInfo[dealerid][DealerSpawnA], 1, 1, PlayerInfo[playerid][pCharacterID], 0);
                TakeMoney(playerid, TempVar[playerid][ConfirmVehiclePrice]);
                VehicleInfo[vehid][vValue] = TempVar[playerid][ConfirmVehiclePrice];
                return 1;
            }
        }
    }
    return 1;
}

Dialog:RichDealership(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], model = RichDealership[listitem][0], price = RichDealership[listitem][1];
        TempVar[playerid][ConfirmVehicle] = model;
        TempVar[playerid][ConfirmVehiclePrice] = price;
        format(string, sizeof string, "{FFFF00}Vehicle:\t\t{FFFFFF}%s\n\
        {FFFF00}Value:\t\t{FFFFFF}$%s\n\nAre you sure you wish to purchase this?", ReturnVehicleModelName(model), FormatNumber(price));
        Dialog_Show(playerid, ConfirmPurchase, DIALOG_STYLE_MSGBOX, "Vehicle Purchase", string, "Confirm", "Exit");
    }
    return 1;
}

Dialog:RegularDealership(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], model = VehicleDealership[listitem][0], price = VehicleDealership[listitem][1];
        TempVar[playerid][ConfirmVehicle] = model;
        TempVar[playerid][ConfirmVehiclePrice] = price;
        format(string, sizeof string, "{FFFF00}Vehicle:\t\t{FFFFFF}%s\n\
        {FFFF00}Value:\t\t{FFFFFF}$%s\n\nAre you sure you wish to purchase this?", ReturnVehicleModelName(model), FormatNumber(price));
        Dialog_Show(playerid, ConfirmPurchase, DIALOG_STYLE_MSGBOX, "Vehicle Purchase", string, "Confirm", "Exit");
    }
    return 1;
}

Dialog:BikeDealership(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], model = BikeDealership[listitem][0], price = BikeDealership[listitem][1];
        TempVar[playerid][ConfirmVehicle] = model;
        TempVar[playerid][ConfirmVehiclePrice] = price;
        format(string, sizeof string, "{FFFF00}Vehicle:\t\t{FFFFFF}%s\n\
        {FFFF00}Value:\t\t{FFFFFF}$%s\n\nAre you sure you wish to purchase this?", ReturnVehicleModelName(model), FormatNumber(price));
        Dialog_Show(playerid, ConfirmPurchase, DIALOG_STYLE_MSGBOX, "Vehicle Purchase", string, "Confirm", "Exit");
    }
    return 1;
}

Dialog:BoatDealership(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], model = BoatDealership[listitem][0], price = BoatDealership[listitem][1];
        TempVar[playerid][ConfirmVehicle] = model;
        TempVar[playerid][ConfirmVehiclePrice] = price;
        format(string, sizeof string, "{FFFF00}Vehicle:\t\t{FFFFFF}%s\n\
        {FFFF00}Value:\t\t{FFFFFF}$%s\n\nAre you sure you wish to purchase this?", ReturnVehicleModelName(model), FormatNumber(price));
        Dialog_Show(playerid, ConfirmPurchase, DIALOG_STYLE_MSGBOX, "Vehicle Purchase", string, "Confirm", "Exit");
    }
    return 1;
}

Dialog:IndustrialDealership(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128], model = IndustrialDealership[listitem][0], price = IndustrialDealership[listitem][1];
        TempVar[playerid][ConfirmVehicle] = model;
        TempVar[playerid][ConfirmVehiclePrice] = price;
        format(string, sizeof string, "{FFFF00}Vehicle:\t\t{FFFFFF}%s\n\
        {FFFF00}Value:\t\t{FFFFFF}$%s\n\nAre you sure you wish to purchase this?", ReturnVehicleModelName(model), FormatNumber(price));
        Dialog_Show(playerid, ConfirmPurchase, DIALOG_STYLE_MSGBOX, "Vehicle Purchase", string, "Confirm", "Exit");
    }
    return 1;
}

stock ShowVehicleMenu(playerid, dealerid)
{
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
        {
            return SendErrorMessage(playerid, "You must park your current vehicle.");
        }
    }

    TempVar[playerid][ConfirmVehicleDealer] = dealerid;

    new string[2048];
    switch(DealershipInfo[dealerid][DealerType])
    {
        case 1: // Sports Dealership
        {
            format(string, sizeof string, "Vehicle\t\tPrice\n");
            for(new i; i < sizeof(RichDealership); i++)
            {
                format(string, sizeof string, "%s%s\t\t$%s\n", string, ReturnVehicleModelName(RichDealership[i][0]), FormatNumber(RichDealership[i][1]));
            }
            Dialog_Show(playerid, RichDealership, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", string, "Purchase", "Exit");
        }
        case 2: // Regular Dealership
        {
            format(string, sizeof string, "Vehicle\tPrice\n");
            for(new i; i < sizeof(VehicleDealership); i++)
            {
                format(string, sizeof string, "%s%s\t$%s\n", string, ReturnVehicleModelName(VehicleDealership[i][0]), FormatNumber(VehicleDealership[i][1]));
            }
            Dialog_Show(playerid, RegularDealership, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", string, "Purchase", "Exit");
        }
        case 3: // Bike
        {
            format(string, sizeof string, "Vehicle\t\tPrice\n");
            for(new i; i < sizeof(BikeDealership); i++)
            {
                format(string, sizeof string, "%s%s\t\t$%s\n", string, ReturnVehicleModelName(BikeDealership[i][0]), FormatNumber(BikeDealership[i][1]));
            }
            Dialog_Show(playerid, BikeDealership, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", string, "Purchase", "Exit");
        }
        case 4: // Boat
        {
            format(string, sizeof string, "Vehicle\t\tPrice\n");
            for(new i; i < sizeof(BoatDealership); i++)
            {
                format(string, sizeof string, "%s%s\t\t$%s\n", string, ReturnVehicleModelName(BoatDealership[i][0]), FormatNumber(BoatDealership[i][1]));
            }
            Dialog_Show(playerid, BoatDealership, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", string, "Purchase", "Exit");
        }
        case 5: // Industrial
        {
            format(string, sizeof string, "Vehicle\t\tPrice\n");
            for(new i; i < sizeof(BoatDealership); i++)
            {
                format(string, sizeof string, "%s%s\t\t$%s\n", string, ReturnVehicleModelName(IndustrialDealership[i][0]), FormatNumber(IndustrialDealership[i][1]));
            }
            Dialog_Show(playerid, IndustrialDealership, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", string, "Purchase", "Exit");
        }
        default: SendErrorMessage(playerid, "This dealership is bugged / has not been setup. Please notify an administrator!");
    }
    return 1;
}