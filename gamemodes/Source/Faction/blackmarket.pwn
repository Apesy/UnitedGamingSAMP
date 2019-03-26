//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/*
    United Gaming RP Illegal Distribution Markets (Black Markets)
    These markets will be used to import weapons and drugs.
    These markets will have a limited stock (yet to be determined), this stock will reset at midnight to its default value.
    These black markets must be assigned to a faction in order to be functional and can only be accessible to the faction members.
*/

#define MAX_BLACK_MARKETS 10

enum blackMarketEnum
{
    ID,
    FactionID,
    Stock,

    // Positions
    Float:bmPosX,
    Float:bmPosY,
    Float:bmPosZ,
    Interior,
    World,

    // Stock
    HasKnife,
    Has9mm,
    HasSDPistol,
    HasDeagle,
    HasShotgun,
    HasSawnoff,
    HasUzi,
    HasMP5,
    HasAK47,
    HasM4,
    HasTec9,
    HasRifle,
    HasSniper,

    Text3D:Label,
    Pickup
}
new BlackMarkets[MAX_BLACK_MARKETS][blackMarketEnum];

stock LoadBlackMarkets()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `BlackMarkets`");
    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "ID", BlackMarkets[i][ID]);
            cache_get_value_int(i, "FactionID", BlackMarkets[i][FactionID]);
            cache_get_value_int(i, "Stock", BlackMarkets[i][Stock]);

            // Positions
            cache_get_value_float(i, "PosX", BlackMarkets[i][bmPosX]);
            cache_get_value_float(i, "PosY", BlackMarkets[i][bmPosY]);
            cache_get_value_float(i, "PosZ", BlackMarkets[i][bmPosZ]);
            cache_get_value_int(i, "Interior", BlackMarkets[i][Interior]);
            cache_get_value_int(i, "World", BlackMarkets[i][World]);

            // Stock
            cache_get_value_int(i, "HasKnife", BlackMarkets[i][HasKnife]);
            cache_get_value_int(i, "Has9mm", BlackMarkets[i][Has9mm]);
            cache_get_value_int(i, "HasSDPistol", BlackMarkets[i][HasSDPistol]);
            cache_get_value_int(i, "HasDeagle", BlackMarkets[i][HasDeagle]);
            cache_get_value_int(i, "HasShotgun", BlackMarkets[i][HasShotgun]);
            cache_get_value_int(i, "HasSawnoff", BlackMarkets[i][HasSawnoff]);
            cache_get_value_int(i, "HasUzi", BlackMarkets[i][HasUzi]);
            cache_get_value_int(i, "HasMP5", BlackMarkets[i][HasMP5]);
            cache_get_value_int(i, "HasAK47", BlackMarkets[i][HasAK47]);
            cache_get_value_int(i, "HasM4", BlackMarkets[i][HasM4]);
            cache_get_value_int(i, "HasTec9", BlackMarkets[i][HasTec9]);
            cache_get_value_int(i, "HasRifle", BlackMarkets[i][HasRifle]);
            cache_get_value_int(i, "HasSniper", BlackMarkets[i][HasSniper]);
            UpdateBlackMarket(i);
        }
    }
    cache_delete(result);
}

stock SaveBlackMarkets()
{
    for(new i; i < MAX_BLACK_MARKETS; i++)
    {
        if(BlackMarkets[i][ID])
        {
            SaveBlackMarket(i);
        }
    }
}

stock SaveBlackMarket(bmid)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `BlackMarkets` SET `FactionID` = %d, `Stock` = %d WHERE `ID` = %d", 
        BlackMarkets[bmid][FactionID], BlackMarkets[bmid][Stock], BlackMarkets[bmid][ID]);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "UPDATE `BlackMarkets` SET `PosX` = %f, `PosY` = %f, `PosZ` = %f WHERE `ID` = %d", 
        BlackMarkets[bmid][bmPosX], BlackMarkets[bmid][bmPosY], BlackMarkets[bmid][bmPosZ], BlackMarkets[bmid][ID]);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "UPDATE `BlackMarkets` SET `Interior` = %d, `World` = %d WHERE `ID` = %d", 
        BlackMarkets[bmid][Interior], BlackMarkets[bmid][World], BlackMarkets[bmid][ID]);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "UPDATE `BlackMarkets` SET `HasKnife` = %d,`Has9mm` = %d, `HasSDPistol` = %d, `HasDeagle` = %d, `HasShotgun` = %d, `HasSawnoff` = %d, `HasUzi` = %d WHERE `ID` = %d", 
        BlackMarkets[bmid][HasKnife], BlackMarkets[bmid][Has9mm], BlackMarkets[bmid][HasSDPistol], BlackMarkets[bmid][HasDeagle], BlackMarkets[bmid][HasShotgun], BlackMarkets[bmid][HasSawnoff], BlackMarkets[bmid][HasUzi], BlackMarkets[bmid][ID]);
    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "UPDATE `BlackMarkets` SET `HasMP5` = %d, `HasAK47` = %d, `HasM4` = %d, `HasTec9` = %d, `HasRifle` = %d, `HasSniper` = %d WHERE `ID` = %d", 
        BlackMarkets[bmid][HasMP5], BlackMarkets[bmid][HasAK47], BlackMarkets[bmid][HasM4], BlackMarkets[bmid][HasTec9], BlackMarkets[bmid][HasRifle], BlackMarkets[bmid][HasSniper], BlackMarkets[bmid][ID]);
    mysql_tquery(g_SQL, query);
}

stock UpdateBlackMarket(bmid)
{
    if(IsValidDynamic3DTextLabel(BlackMarkets[bmid][Label]))
        DestroyDynamic3DTextLabel(BlackMarkets[bmid][Label]);

    if(IsValidDynamicPickup(BlackMarkets[bmid][Pickup]))
        DestroyDynamicPickup(BlackMarkets[bmid][Pickup]);
    
    BlackMarkets[bmid][Label] = CreateDynamic3DTextLabel("Black Market", COLOR_YELLOW, BlackMarkets[bmid][bmPosX], BlackMarkets[bmid][bmPosY], BlackMarkets[bmid][bmPosZ], 20.0, .worldid = BlackMarkets[bmid][World], .interiorid = BlackMarkets[bmid][Interior]);
    BlackMarkets[bmid][Pickup] = CreateDynamicPickup(3014, 1, BlackMarkets[bmid][bmPosX], BlackMarkets[bmid][bmPosY], BlackMarkets[bmid][bmPosZ], .worldid = BlackMarkets[bmid][World], .interiorid = BlackMarkets[bmid][Interior]);
}

stock NearestBlackMarket(playerid)
{
    for(new bmid; bmid < MAX_BLACK_MARKETS; bmid++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, BlackMarkets[bmid][bmPosX], BlackMarkets[bmid][bmPosY], BlackMarkets[bmid][bmPosZ])
            && GetPlayerInterior(playerid) == BlackMarkets[bmid][Interior]
            && GetPlayerVirtualWorld(playerid) == BlackMarkets[bmid][World])
        {
            return bmid;
        }
    }
    return -1;
}

CMD:blackmarket(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1)
        return SendErrorMessage(playerid, "You are not in a faction.");

    new bmid = NearestBlackMarket(playerid);
    if(bmid == -1)
        return SendErrorMessage(playerid, "You are not near your factions black market.");

    if(factionid != BlackMarkets[bmid][FactionID])
        return SendErrorMessage(playerid, "This black market does not belong to your faction.");

    if(BlackMarkets[bmid][Stock] < 1)
        return SendErrorMessage(playerid, "This black market has no more stock left, come back tommorow.");

    if(IsWeaponRestricted(playerid))
        return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

    new ammo, weapon[32];
    if(sscanf(params, "s[32]d", weapon, ammo))
    {
        SendUsageMessage(playerid, "/blackmarket [Weapon] [Ammo]");
        if(BlackMarkets[bmid][HasKnife] == 1)
            SendClientMessage(playerid, -1, "Knife - 1 Stock");
        
        if(BlackMarkets[bmid][Has9mm] == 1)
            SendClientMessage(playerid, -1, "9mm - 2 Stock per ammo.");
        
        if(BlackMarkets[bmid][HasSDPistol] == 1)
            SendClientMessage(playerid, -1, "Deagle - 2 Stock per ammo.");

        if(BlackMarkets[bmid][HasDeagle] == 1)
            SendClientMessage(playerid, -1, "Deagle - 5 Stock per ammo.");

        if(BlackMarkets[bmid][HasShotgun] == 1)
            SendClientMessage(playerid, -1, "Shotgun - 6 Stock per ammo.");

        if(BlackMarkets[bmid][HasSawnoff] == 1)
            SendClientMessage(playerid, -1, "Sawnoff Shotgun - 6 Stock per ammo.");

        if(BlackMarkets[bmid][HasUzi] == 1)
            SendClientMessage(playerid, -1, "Uzi - 5 Stock per ammo.");
        
        if(BlackMarkets[bmid][HasMP5] == 1)
            SendClientMessage(playerid, -1, "MP5 - 6 Stock per ammo.");
        
        if(BlackMarkets[bmid][HasAK47] == 1)
            SendClientMessage(playerid, -1, "AK47 - 10 Stock per ammo.");

        if(BlackMarkets[bmid][HasM4] == 1)
            SendClientMessage(playerid, -1, "M4 - 20 Stock per ammo.");
        
        if(BlackMarkets[bmid][HasTec9] == 1)
            SendClientMessage(playerid, -1, "Tec9 - 7 Stock per ammo.");
        
        if(BlackMarkets[bmid][HasRifle] == 1)
            SendClientMessage(playerid, -1, "Country Rifle - 15 Stock per ammo.");

        if(BlackMarkets[bmid][HasSniper] == 1)
            SendClientMessage(playerid, -1, "Sniper Rifle - 30 Stock per ammo.");
        return 1;
    }

    if(strcmp(weapon, "knife", true) == 0)
    {
        if(BlackMarkets[bmid][HasKnife] == 0)
            return SendErrorMessage(playerid, "This black market does not have have knives.");

        if(BlackMarkets[bmid][Stock] - 1 < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        BlackMarkets[bmid][Stock]--;

        GivePlayerGun(playerid, WEAPON_KNIFE, 1, 0);
        SendServerMessage(playerid, "Recieved Knife.");
    }
    if(strcmp(weapon, "9mm", true) == 0)
    {
        if(BlackMarkets[bmid][Has9mm] == 0)
            return SendErrorMessage(playerid, "This black market does not have have 9mm's.");

        if(BlackMarkets[bmid][Stock] - (ammo*2) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 100)
            return SendErrorMessage(playerid, "You can only take a max of 100 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*2);


        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 22))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 22, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved 9mm.");
    }
    if(strcmp(weapon, "sdpistol", true) == 0)
    {
        if(BlackMarkets[bmid][HasSDPistol] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Silenced Pistols's.");

        if(BlackMarkets[bmid][Stock] - (ammo*2) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 100)
            return SendErrorMessage(playerid, "You can only take a max of 100 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*2);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 23))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 23, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Silenced Pistol.");
    }
    if(strcmp(weapon, "deagle", true) == 0)
    {
        if(BlackMarkets[bmid][HasDeagle] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Deagles's.");

        if(BlackMarkets[bmid][Stock] - (ammo*5) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 100)
            return SendErrorMessage(playerid, "You can only take a max of 100 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*5);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 24))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 24, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Deagle.");
    }
    if(strcmp(weapon, "shotgun", true) == 0)
    {
        if(BlackMarkets[bmid][HasShotgun] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Shotguns's.");

        if(BlackMarkets[bmid][Stock] - (ammo*4) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 100)
            return SendErrorMessage(playerid, "You can only take a max of 100 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*4);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 25))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 25, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Shotgun.");
    }
    if(strcmp(weapon, "sawnoff", true) == 0)
    {
        if(BlackMarkets[bmid][HasSawnoff] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Sawnoff Shotguns's.");

        if(BlackMarkets[bmid][Stock] - (ammo*6) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 100)
            return SendErrorMessage(playerid, "You can only take a max of 100 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*6);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 26))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 26, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Sawnoff Shotgun.");
    }
    if(strcmp(weapon, "uzi", true) == 0)
    {
        if(BlackMarkets[bmid][HasUzi] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Uzi's.");

        if(BlackMarkets[bmid][Stock] - (ammo*5) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 500)
            return SendErrorMessage(playerid, "You can only take a max of 500 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*5);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 28))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 28, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Uzi.");
    }
    if(strcmp(weapon, "mp5", true) == 0)
    {
        if(BlackMarkets[bmid][HasMP5] == 0)
            return SendErrorMessage(playerid, "This black market does not have have MP5's.");

        if(BlackMarkets[bmid][Stock] - (ammo*6) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");

        if(ammo > 500)
            return SendErrorMessage(playerid, "You can only take a max of 500 ammo.");
        
        BlackMarkets[bmid][Stock] =- (ammo*6);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 29))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 29, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved MP5.");
    }
    if(strcmp(weapon, "ak47", true) == 0)
    {
        if(BlackMarkets[bmid][HasAK47] == 0)
            return SendErrorMessage(playerid, "This black market does not have have AK-47's.");

        if(BlackMarkets[bmid][Stock] - (ammo*10) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 500)
            return SendErrorMessage(playerid, "You can only take a max of 500 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*10);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 30))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 30, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved AK-47.");
    }
    if(strcmp(weapon, "m4", true) == 0)
    {
        if(BlackMarkets[bmid][HasM4] == 0)
            return SendErrorMessage(playerid, "This black market does not have have M4's.");

        if(BlackMarkets[bmid][Stock] - (ammo*20) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 500)
            return SendErrorMessage(playerid, "You can only take a max of 500 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*20);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 31))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 31, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved M4.");
    }
    if(strcmp(weapon, "tec9", true) == 0)
    {
        if(BlackMarkets[bmid][HasTec9] == 0)
            return SendErrorMessage(playerid, "This black market does not have have TEC-9's.");

        if(BlackMarkets[bmid][Stock] - (ammo*7) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 500)
            return SendErrorMessage(playerid, "You can only take a max of 500 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*7);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 32))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 32, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved TEC-9.");
    }
    if(strcmp(weapon, "rifle", true) == 0)
    {
        if(BlackMarkets[bmid][HasRifle] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Country Rifles's.");

        if(BlackMarkets[bmid][Stock] - (ammo*15) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 50)
            return SendErrorMessage(playerid, "You can only take a max of 50 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*15);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 33))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 33, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Country Rifle.");
    }
    if(strcmp(weapon, "sniper", true) == 0)
    {
        if(BlackMarkets[bmid][HasSniper] == 0)
            return SendErrorMessage(playerid, "This black market does not have have Sniper Rifles's.");

        if(BlackMarkets[bmid][Stock] - (ammo*30) < 0)
            return SendErrorMessage(playerid, "This black market does not have enough stock.");
        
        if(ammo > 10)
            return SendErrorMessage(playerid, "You can only take a max of 10 ammo.");

        BlackMarkets[bmid][Stock] =- (ammo*30);

        new wepAmmo = ammo;
        if(PlayerHasWeapon(playerid, 34))
        {
            wepAmmo = wepAmmo + GetPlayerAmmo(playerid);
        }
        GivePlayerGun(playerid, 34, wepAmmo, 0);
        SendServerMessage(playerid, "Recieved Sniper.");
    }
    return 1;
}

stock BlackMarketStock()
{
    new bool:sent[MAX_FACTIONS] = false;
    for(new i; i < MAX_BLACK_MARKETS; i++)
    {
        if(BlackMarkets[i][ID] && BlackMarkets[i][FactionID])
        {
            if(sent[BlackMarkets[i][FactionID]] == false)
            {
                sent[BlackMarkets[i][FactionID]] = true;
                SendFactionMessage(BlackMarkets[i][FactionID], COLOR_CYAN, "** Black Market has been restocked.");
            }
            BlackMarkets[i][Stock] += 200;
        }
    }
}

CMD:createblackmarket(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new factionID;
        if(sscanf(params, "d", factionID))
            return SendUsageMessage(playerid, "/createblackmarket [FactionID]");

        new Float:x, Float:y, Float:z, query[256];
        GetPlayerPos(playerid, x, y, z);
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `BlackMarkets` (`FactionID`, `PosX`, `PosY`, `PosZ`, `Interior`, `World`) VALUES (%d, %f, %f, %f, %d, %d)", 
            factionID,
            x, 
            y, 
            z,
            GetPlayerInterior(playerid),
            GetPlayerVirtualWorld(playerid));
        mysql_tquery(g_SQL, query, "OnCreateBM", "ddfff", playerid, factionID, x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    }
    return 1;
}

function OnCreateBM(playerid, factionID, Float:x, Float:y, Float:z, int, vw)
{
    for(new i; i < MAX_BLACK_MARKETS; i++)
    {
        if(!BlackMarkets[i][ID])
        {
            BlackMarkets[i][ID] = cache_insert_id();
            BlackMarkets[i][FactionID] = factionID;
            BlackMarkets[i][Stock] = 50;
            BlackMarkets[i][bmPosX] = x;
            BlackMarkets[i][bmPosY] = y;
            BlackMarkets[i][bmPosZ] = z;
            BlackMarkets[i][Interior] = int;
            BlackMarkets[i][World] = vw;
            SendServerMessage(playerid, "Created black market %d for faction %d. Make sure you \"/editblackmarket %d\".", i, factionID, i);
            UpdateBlackMarket(i);
            SaveBlackMarket(i);
            return 1;
        }
    }
    return 1;
}

new EditingBM[MAX_PLAYERS];
CMD:editblackmarket(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new bmid;
        if(sscanf(params, "d", bmid))
            return SendUsageMessage(playerid, "/editblackmarket [Black Market ID]");
        
        EditingBM[playerid] = bmid;
        ShowBMEdit(playerid);
    }
    return 1;
}

stock ShowBMEdit(playerid)
{
    Dialog_Show(playerid, BMEdit, DIALOG_STYLE_LIST, "Edit Black Market", "Location\n\
        Faction\n\
        Stock\n\
        Knife\n\
        9mm\n\
        Silenced Pistol\n\
        Deagle\n\
        Shotgun\n\
        Sawnoff\n\
        Uzi\n\
        MP5\n\
        AK47\n\
        M4\n\
        Tec9\n\
        Country Rifle\n\
        Sniper", "Edit", "Close");
    return 1;
}

Dialog:BMEdit(playerid, response, listitem, inputtext[])
{
    if(response && Player[playerid][AdminLevel] >= 4)
    {
        new bmid = EditingBM[playerid];
        switch(listitem)
        {
            case 0:
            {
                GetPlayerPos(playerid, BlackMarkets[bmid][bmPosX], BlackMarkets[bmid][bmPosY], BlackMarkets[bmid][bmPosZ]);
                BlackMarkets[bmid][Interior] = GetPlayerInterior(playerid);
                BlackMarkets[bmid][World] = GetPlayerVirtualWorld(playerid);
                SendServerMessage(playerid, "Black Market %d position changed.", bmid);
                UpdateBlackMarket(bmid);
                SaveBlackMarket(bmid);
            }
            case 1:
            {
                Dialog_Show(playerid, BMEditFaction, DIALOG_STYLE_INPUT, "Black Market Faction", "Set the black market's faction ID.", "Continue", "Back");
            }
            case 2:
            {
                Dialog_Show(playerid, BMEditStock, DIALOG_STYLE_INPUT, "Black Market stock", "Set the black market's stock amount.", "Continue", "Back");
            }
            case 3:
            {
                if(BlackMarkets[bmid][HasKnife] == 0)
                {
                    BlackMarkets[bmid][HasKnife] = 1;
                    SendServerMessage(playerid, "Given knife to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasKnife] = 0;
                    SendServerMessage(playerid, "Removed knife from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 4:
            {
                if(BlackMarkets[bmid][Has9mm] == 0)
                {
                    BlackMarkets[bmid][Has9mm] = 1;
                    SendServerMessage(playerid, "Given 9mm to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][Has9mm] = 0;
                    SendServerMessage(playerid, "Removed 9mm from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 5:
            {
                if(BlackMarkets[bmid][HasSDPistol] == 0)
                {
                    BlackMarkets[bmid][HasSDPistol] = 1;
                    SendServerMessage(playerid, "Given Silenced Pistol to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasSDPistol] = 0;
                    SendServerMessage(playerid, "Removed Silenced Pistol from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 6:
            {
                if(BlackMarkets[bmid][HasDeagle] == 0)
                {
                    BlackMarkets[bmid][HasDeagle] = 1;
                    SendServerMessage(playerid, "Given Deagle to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasDeagle] = 0;
                    SendServerMessage(playerid, "Removed Deagle from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 7:
            {
                if(BlackMarkets[bmid][HasShotgun] == 0)
                {
                    BlackMarkets[bmid][HasShotgun] = 1;
                    SendServerMessage(playerid, "Given Shotgun to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasShotgun] = 0;
                    SendServerMessage(playerid, "Removed Shotgun from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 8:
            {
                if(BlackMarkets[bmid][HasSawnoff] == 0)
                {
                    BlackMarkets[bmid][HasSawnoff] = 1;
                    SendServerMessage(playerid, "Given Sawnoff to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasSawnoff] = 0;
                    SendServerMessage(playerid, "Removed Sawnoff from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 9:
            {
                if(BlackMarkets[bmid][HasUzi] == 0)
                {
                    BlackMarkets[bmid][HasUzi] = 1;
                    SendServerMessage(playerid, "Given Uzi to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasUzi] = 0;
                    SendServerMessage(playerid, "Removed Uzi from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 10:
            {
                if(BlackMarkets[bmid][HasAK47] == 0)
                {
                    BlackMarkets[bmid][HasAK47] = 1;
                    SendServerMessage(playerid, "Given AK-47 to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasAK47] = 0;
                    SendServerMessage(playerid, "Removed AK-47 from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 11:
            {
                if(BlackMarkets[bmid][HasM4] == 0)
                {
                    BlackMarkets[bmid][HasM4] = 1;
                    SendServerMessage(playerid, "Given M4 to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasM4] = 0;
                    SendServerMessage(playerid, "Removed M4 from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 12:
            {
                if(BlackMarkets[bmid][HasTec9] == 0)
                {
                    BlackMarkets[bmid][HasTec9] = 1;
                    SendServerMessage(playerid, "Given TEC-9 to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasTec9] = 0;
                    SendServerMessage(playerid, "Removed TEC-9 from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 13:
            {
                if(BlackMarkets[bmid][HasRifle] == 0)
                {
                    BlackMarkets[bmid][HasRifle] = 1;
                    SendServerMessage(playerid, "Given Country Rifle to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasRifle] = 0;
                    SendServerMessage(playerid, "Removed Country Rifle from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
            case 14:
            {
                if(BlackMarkets[bmid][HasSniper] == 0)
                {
                    BlackMarkets[bmid][HasSniper] = 1;
                    SendServerMessage(playerid, "Given Sniper to Black Market %d.", bmid);
                }
                else
                {
                    BlackMarkets[bmid][HasSniper] = 0;
                    SendServerMessage(playerid, "Removed Sniper from Black Market %d.", bmid);
                }
                SaveBlackMarket(bmid);
            }
        }
    }
    return 1;
}

Dialog:BMEditFaction(playerid, response, listitem, inputtext[])
{
    new bmid = EditingBM[playerid];
    if(!response)
        return ShowBMEdit(playerid);
    
    if(isnull(inputtext) || !IsNumeric(inputtext))
        return Dialog_Show(playerid, BMEditFaction, DIALOG_STYLE_INPUT, "Black Market Faction", "ERROR: Make sure you input a valid number.\n\
        Set the black market's faction ID.", "Continue", "Back");
    
    new fid = strval(inputtext);
    if(fid < 1 || fid > MAX_FACTIONS)
        return Dialog_Show(playerid, BMEditFaction, DIALOG_STYLE_INPUT, "Black Market Faction", "ERROR: Make sure you input a faction. See /factions.\n\
        Set the black market's faction ID.", "Continue", "Back");
    
    BlackMarkets[bmid][FactionID] = fid;
    SendServerMessage(playerid, "Black market %d's faction set to %d.", bmid, fid);
    SaveBlackMarket(bmid);
    return 1;
}

Dialog:BMEditStock(playerid, response, listitem, inputtext[])
{
    new bmid = EditingBM[playerid];
    if(!response)
        return ShowBMEdit(playerid);
    
    if(isnull(inputtext) || !IsNumeric(inputtext))
        return Dialog_Show(playerid, BMEditStock, DIALOG_STYLE_INPUT, "Black Market stock", "ERROR: Make sure you input a valid number.\n\
        Set the black market's stock amount.", "Continue", "Back");
    
    new bmStock = strval(inputtext);
    if(bmStock < 1 || bmStock > 50)
        return Dialog_Show(playerid, BMEditStock, DIALOG_STYLE_INPUT, "Black Market stock", "ERROR: Cannot go below 0 or above 50.\n\
        Set the black market's stock amount.", "Continue", "Back");
    
    BlackMarkets[bmid][Stock] = bmStock;
    SendServerMessage(playerid, "Black market %d's stock set to %d.", bmid, bmStock);
    SaveBlackMarket(bmid);
    return 1;
}

CMD:blackmarketid(playerid, params[])
{
    new id = NearestBlackMarket(playerid);
    if(id != -1)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________ Black Market ID %d ______________", id);
        SendClientMessageEx(playerid, COLOR_GRAD5, "FactionID:[%d] Stock:[%d] Knife:[%s] 9mm:[%s] SDPistol:[%s]",
            BlackMarkets[id][FactionID], BlackMarkets[id][Stock], BinToStr(BlackMarkets[id][HasKnife]), BinToStr(BlackMarkets[id][HasSDPistol]));
        SendClientMessageEx(playerid, COLOR_GRAD4, "Deagle:[%s] Shotgun:[%s] Sawnoff:[%s] Uzi:[%s] AK47:[%s]",
            BinToStr(BlackMarkets[id][HasDeagle]), BinToStr(BlackMarkets[id][HasShotgun]), BinToStr(BlackMarkets[id][HasSawnoff]), BinToStr(BlackMarkets[id][HasUzi]), BinToStr(BlackMarkets[id][HasAK47]));
        SendClientMessageEx(playerid, COLOR_GRAD3, "M4:[%s] Tec9:[%s] Rifle:[%s] Sniper:[%s]",
            BinToStr(BlackMarkets[id][HasM4]), BinToStr(BlackMarkets[id][HasTec9]), BinToStr(BlackMarkets[id][HasRifle]), BinToStr(BlackMarkets[id][HasSniper]));
    }
    return 1;
}