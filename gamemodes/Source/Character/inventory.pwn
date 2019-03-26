//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

// Min capacity: 30
#include <YSI\y_hooks>

#define MAX_INVENTORY 30

enum itemEnum
{
    ItemName[128],
    ItemType,
    ItemModelID,
    ItemWeaponID,
    ItemWeight
};

new GlobalInventory[][itemEnum] =
{
    // Essentials
    {"Driving License", INV_DRV_LIC, 1581, 0, 1},
    {"Firearms License", INV_WEP_LIC, 1581, 0, 1},
    {"Flying License", INV_FLY_LIC, 1581, 0, 1},
    {"First Aid Kit", INV_MED_KIT, 11736, 0, 1},
    {"Armour", INV_ARMOUR, 1242, 0, 1},

    // Drugs
    {"Weed", INV_WEED, 1578, 0, 1},
    {"Cocaine", INV_COCAINE, 1575, 0, 1},

    // Weapons
    {"Golf Club", INV_GUN, 333, WEAPON_GOLFCLUB, 3},
    {"Nightstick", INV_GUN, 334, WEAPON_NITESTICK, 3},
	{"Knife", INV_GUN, 335, WEAPON_KNIFE, 3},
    {"Baseball Bat", INV_GUN, 336, WEAPON_BAT, 5},
	{"Shovel", INV_GUN, 337, WEAPON_SHOVEL, 4},
	{"Katana", INV_GUN, 339, WEAPON_KATANA, 6},
	{"Colt 45", INV_GUN, 346, WEAPON_COLT45, 10},
	{"Desert Eagle", INV_GUN, 348, WEAPON_DEAGLE, 12},
	{"Shotgun", INV_GUN, 349, WEAPON_SHOTGUN, 20},
	{"Micro SMG", INV_GUN, 352, WEAPON_UZI, 15},
	{"MP5", INV_GUN, 353, WEAPON_MP5, 14},
	{"AK-47", INV_GUN, 355, WEAPON_AK47, 20},
	{"M4", INV_GUN, 356, WEAPON_M4, 20},
	{"Tec-9", INV_GUN, 372, WEAPON_TEC9, 15},
	{"Rifle", INV_GUN, 357, WEAPON_RIFLE, 20},
	{"Sniper", INV_GUN, 358, WEAPON_SNIPER, 20},

    // Other
    {"Phone", INV_PHONE, 18874, 0, 1},
    {"Radio", INV_RADIO, 19942, 0, 1},
    {"Fish", INV_FISH, 19630, 0, 1},
    {"Pizza", INV_PIZZA, 1582, 0, 1},
    {"Boombox", INV_BOOMBOX, 2226, 0, 25},
    {"Sprunk", INV_SPRUNK, 2601, 0, 1},
    {"Cigarette", INV_CIG, 19896, 0, 1}
};

enum playerInventoryEnum
{
    InventoryID,
    InventoryType,
    InventoryWeaponID,
    InventoryAmount,
    InventoryWeight,
    InventorySerial
};
new InventoryInfo[MAX_INVENTORY][MAX_PLAYERS][playerInventoryEnum];

function LoadPlayerInventory(playerid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `Player_Inventory` WHERE `CharacterID` = %d LIMIT %d", PlayerInfo[playerid][pCharacterID], MAX_INVENTORY);
    mysql_tquery(g_SQL, query, "OnLoadInventory", "d", playerid);
}

hook OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][pHoldingInv] = INV_NONE;
    PlayerInfo[playerid][pHoldingInvAmount] = 0;
    for(new i; i < MAX_INVENTORY; i++)
    {
        InventoryInfo[i][playerid][InventoryType] = INV_NONE;
        InventoryInfo[i][playerid][InventoryWeaponID] = 0;
        InventoryInfo[i][playerid][InventoryAmount] = 0;
        InventoryInfo[i][playerid][InventorySerial] = 0;
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(reason != 0)
    {
        PlayerInfo[playerid][pHoldingInv] = INV_NONE;
        PlayerInfo[playerid][pHoldingInvAmount] = 0;
    }
    return 1;
}

function OnLoadInventory(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", InventoryInfo[i][playerid][InventoryID]);
            cache_get_value_int(i, "Type", InventoryInfo[i][playerid][InventoryType]);
            cache_get_value_int(i, "WeaponID", InventoryInfo[i][playerid][InventoryWeaponID]);
            cache_get_value_int(i, "Amount", InventoryInfo[i][playerid][InventoryAmount]);
            cache_get_value_int(i, "Weight", InventoryInfo[i][playerid][InventoryWeight]);
            cache_get_value_int(i, "Serial", InventoryInfo[i][playerid][InventorySerial]);
        }
    }
    if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
    {
        HoldInventoryItem(playerid, PlayerInfo[playerid][pHoldingInv], PlayerInfo[playerid][pHoldingInvAmount]);
    }
    return 1;
}

stock AddInventory(playerid, type, amount, weaponid = 0, serial = 0)
{
    for(new i; i < MAX_INVENTORY; i++)
    {
        if(InventoryInfo[i][playerid][InventoryType] == INV_NONE)
        {
            new query[128];
            mysql_format(g_SQL, query, sizeof query, "INSERT INTO `Player_Inventory` (`Type`, `WeaponID`, `Amount`, `Serial`, `CharacterID`) VALUES (%d, %d, %d, %d, %d)", type, weaponid, amount, serial, PlayerInfo[playerid][pCharacterID]);
            mysql_tquery(g_SQL, query, "OnAddInventory", "dddddd", playerid, i, type, weaponid, amount, serial);
            return 1;
        }
    }
    return 0;
}

function OnAddInventory(playerid, slot, type, weaponid, amount, serial)
{
    InventoryInfo[slot][playerid][InventoryID] = cache_insert_id();
    InventoryInfo[slot][playerid][InventoryType] = type;
    InventoryInfo[slot][playerid][InventoryWeaponID] = weaponid;
    InventoryInfo[slot][playerid][InventoryAmount] = amount;
    InventoryInfo[slot][playerid][InventorySerial] = serial;
    return 1;
}

stock GetItemName(type, weaponid = 0)
{
    new name[128];
    for(new g; g < sizeof(GlobalInventory); g++)
    {
        if(weaponid > 0)
        {
            if(GlobalInventory[g][ItemType] == type && GlobalInventory[g][ItemWeaponID] == weaponid)
            {
                format(name, sizeof name, "%s", GlobalInventory[g][ItemName]);
                break;
            }
        }
        else
        {
            if(GlobalInventory[g][ItemType] == type)
            {
                format(name, sizeof name, "%s", GlobalInventory[g][ItemName]);
                break;
            }
        }
    }
    return name;
}

function GetInventory(playerid, type)
{
    for(new i; i < MAX_INVENTORY; i++)
    {
        if(InventoryInfo[i][playerid][InventoryID] > 0
            && InventoryInfo[i][playerid][InventoryType] == type
            && InventoryInfo[i][playerid][InventoryAmount] > 0)
        {
            return 1;
        }
    }
    return 0;
}

function GetInventoryAmount(playerid, slot)
{
    for(new i; i < MAX_INVENTORY; i++)
    {
        if(slot == i && InventoryInfo[i][playerid][InventoryID] > 0
            && InventoryInfo[i][playerid][InventoryType] != INV_NONE
            && InventoryInfo[i][playerid][InventoryAmount] > 0)
        {
            return InventoryInfo[i][playerid][InventoryAmount];
        }
    }
    return 0;
}

function GetInventorySlot(playerid, type)
{
    for(new i; i < MAX_INVENTORY; i++)
    {
        if(InventoryInfo[i][playerid][InventoryID] > 0
            && InventoryInfo[i][playerid][InventoryType] == type
            && InventoryInfo[i][playerid][InventoryAmount] > 0)
        {
            return i;
        }
    }
    return -1;
}

function PrintInventory(playerid, targetid)
{
    if(IsPlayerConnected(targetid))
    {
        new result[128*MAX_INVENTORY];
        SetPVarInt(playerid, "TakeInvID", targetid);
        result = "Name\tAmount";
        for(new i; i < MAX_INVENTORY; i++)
        {
            if(InventoryInfo[i][targetid][InventoryID] > 0
                && InventoryInfo[i][targetid][InventoryType] != INV_NONE)
            {
                if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                {
                    format(result, sizeof result, "%s\n%s\t%d", result, GetItemName(InventoryInfo[i][targetid][InventoryType], InventoryInfo[i][targetid][InventoryWeaponID]), InventoryInfo[i][targetid][InventoryAmount]);
                }
                else format(result, sizeof result, "%s\n%s\tEmpty", result, GetItemName(InventoryInfo[i][targetid][InventoryType], InventoryInfo[i][targetid][InventoryWeaponID]));
            }
            else format(result, sizeof result, "%s\nEmpty\tEmpty", result);
        }
        TempVar[playerid][InventorySelectType] = 0;
        Dialog_Show(playerid, Player_Inventory, DIALOG_STYLE_TABLIST_HEADERS, "Player Inventory", result, "Take", "Exit");
    }
    return 1;
}

stock RemoveInventory(playerid, slot)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "DELETE FROM `Player_Inventory` WHERE `ID` = %d", InventoryInfo[slot][playerid][InventoryID]);
    mysql_tquery(g_SQL, query, "OnRemoveInventory", "dd", playerid, slot);
}

function OnRemoveInventory(playerid, slot)
{
    InventoryInfo[slot][playerid][InventoryID] = 0;
    InventoryInfo[slot][playerid][InventoryWeaponID] = 0;
    InventoryInfo[slot][playerid][InventoryAmount] = 0;
    InventoryInfo[slot][playerid][InventoryType] = INV_NONE;
    return 1;
}

stock HoldInventoryItem(playerid, type, amount)
{
    switch(type)
    {
        case INV_CIG:
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
            PlayerInfo[playerid][pHoldingInv] = INV_CIG;
            PlayerInfo[playerid][pHoldingInvAmount] = amount;
        }
        case INV_WEED:
        {
            SetPlayerAttachedObject(playerid, SLOT_INV_ITEM, 1578, 5);
            PlayerInfo[playerid][pHoldingInv] = INV_WEED;
            PlayerInfo[playerid][pHoldingInvAmount] = amount;
        }
        case INV_COCAINE:
        {
            SetPlayerAttachedObject(playerid, SLOT_INV_ITEM, 1578, 5);
            PlayerInfo[playerid][pHoldingInv] = INV_COCAINE;
            PlayerInfo[playerid][pHoldingInvAmount] = amount;
        }
        case INV_BOOMBOX:
        {
            SetPlayerAttachedObject(playerid,SLOT_INV_ITEM,2226,5,0.413999,0.000000,0.000000,0.000000,-92.699981,0.000000,1.000000,1.000000,1.000000);
            PlayerInfo[playerid][pHoldingInv] = INV_BOOMBOX;
            PlayerInfo[playerid][pHoldingInvAmount] = amount;
        }
        case INV_RADIO:
        {
            SetPlayerAttachedObject(playerid, SLOT_INV_ITEM, 19942, 5);
            PlayerInfo[playerid][pHoldingInv] = INV_RADIO;
            PlayerInfo[playerid][pHoldingInvAmount] = amount;
        }
    }
}

stock StopHoldInventoryItem(playerid)
{
    PlayerInfo[playerid][pHoldingInv] = 0;
    PlayerInfo[playerid][pHoldingInvAmount] = 0;
    if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_INV_ITEM))
    {
        RemovePlayerAttachedObject(playerid, SLOT_INV_ITEM);
    }
    return 1;
}

Dialog:Player_Inventory(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = listitem, targetid = GetPVarInt(playerid, "TakeInvID");
        if(InventoryInfo[i][targetid][InventoryID] && InventoryInfo[i][targetid][InventoryAmount] > 0 && InventoryInfo[i][targetid][InventoryType] != INV_NONE)
        {
            switch(InventoryInfo[i][targetid][InventoryType])
            {
                case INV_GUN:
                {
                    if(InventoryInfo[i][targetid][InventoryWeaponID] > 0 && InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(IsWeaponRestricted(playerid))
                            return SendErrorMessage(playerid, "You are currently restricted from using weapons.");
                        
                        PlayerInfo[playerid][pHoldingInvAmount] = InventoryInfo[i][targetid][InventoryAmount];
                        GivePlayerGun(targetid, InventoryInfo[i][targetid][InventoryWeaponID], InventoryInfo[i][targetid][InventoryAmount], InventoryInfo[i][targetid][InventorySerial]);

                        if(IsPlayerInAnyVehicle(playerid))
                        {
                            SetPlayerArmedWeapon(playerid, 0);
                        }
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_WEED, InventoryInfo[i][targetid][InventoryAmount]);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED_SEED:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
                            return SendErrorMessage(playerid, "You are need to be on foot while using this.");

                        if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            return SendErrorMessage(playerid, "You need to crouch before performing this.");

                        for (new weed = 0; weed < sizeof(WeedPlants); weed++)
                        {
                            if (IsPlayerInRangeOfPoint(playerid, 3.0, WeedPlants[weed][weedX], WeedPlants[weed][weedY], WeedPlants[weed][weedZ]))
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
                        mysql_tquery(g_SQL, query, "OnPlantWeed", "ii", playerid, id, i);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_COCAINE:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(playerid, INV_COCAINE, InventoryInfo[i][targetid][InventoryAmount]);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_BOOMBOX:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(playerid, INV_BOOMBOX, 1);
                        SendServerMessage(playerid, "You are now holding the boombox. Use /boomboxhelp to see available commands.");
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_RADIO:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_RADIO, 1);
                        return 1;
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEP_LIC:
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Firearms License: Yes");
                    return 1;
                }
                case INV_DRV_LIC:
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Driving License: Yes");
                    return 1;
                }
                case INV_FLY_LIC:
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Flying License: Yes");
                    return 1;
                }
                case INV_PHONE:
                {
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Phone Number: %d", InventoryInfo[i][targetid][InventoryAmount]);
                    return 1;
                }
                case INV_SPRUNK:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");
                        
                        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_NONE)
                            return SendErrorMessage(playerid, "You cannot do this right now.");

                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
                        InventoryInfo[i][targetid][InventoryAmount]--;
                        if(InventoryInfo[i][targetid][InventoryAmount] < 1)
                        {
                            RemoveInventory(playerid, i);
                        }
                    }
                    return 1;
                }
                case INV_CIG:
                {
                    if(InventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");
                        
                        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_NONE)
                            return SendErrorMessage(playerid, "You cannot do this right now.");

                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
                        InventoryInfo[i][targetid][InventoryAmount]--;
                        if(InventoryInfo[i][targetid][InventoryAmount] < 1)
                        {
                            RemoveInventory(playerid, i);
                        }
                    }
                    return 1;
                }
            }
            RemoveInventory(playerid, i);
        }
        else SendErrorMessage(playerid, "There is nothing there...");
    }
    return 1;
}

CMD:addinv(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new target, type[32], amount, weaponID = 0;
        if(sscanf(params, "us[32]dD(0)", target, type, amount, weaponID))
        {
            SendUsageMessage(playerid, "/addinv [PlayerID/PartOfName] [Type] [Amount] [WeaponID (Only if adding weapon type)]");
            SendClientMessage(playerid, -1, "Types: Weapon, Weed, WeedSeed, Cocaine, Boombox");
            return 1;
        }
        
        if(!IsPlayerConnected(target))
            return SendErrorMessage(playerid, "PlayerID/PartOfName is not connected.");
        
        if(strcmp(type, "Weapon", true) == 0 && weaponID == 0)
            return SendUsageMessage(playerid, "/addinv [PlayerID/PartOfName] [Type] [Amount] [WeaponID]");
        
        if(amount < 1)
            return SendErrorMessage(playerid, "Amount cannot be below 0.");

        if(strcmp(type, "Weapon", true) == 0)
        {
            if(AddInventory(playerid, INV_GUN, amount, weaponID) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Added %s to %s's inventory.", GetServerWeaponName(weaponID), GetUserName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "** %s has added a %s to your inventory.", GetMasterName(playerid), GetServerWeaponName(weaponID));
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else if(strcmp(type, "Weed", true) == 0)
        {
            if(AddInventory(playerid, INV_WEED, amount) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Added %d grams of weed to %s's inventory.", amount, GetUserName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "** %s has added %d grams of weed to your inventory.", GetMasterName(playerid), amount);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else if(strcmp(type, "WeedSeed", true) == 0)
        {
            if(AddInventory(playerid, INV_WEED_SEED, amount) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Added %d weed seeds to %s's inventory.", amount, GetUserName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "** %s has added %d weed seeds to your inventory.", GetMasterName(playerid), amount);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else if(strcmp(type, "Cocaine", true) == 0)
        {
            if(AddInventory(playerid, INV_COCAINE, amount) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Added %d grams of cocaine to %s's inventory.", amount, GetUserName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "** %s has added %d grams of cocaine to your inventory.", GetMasterName(playerid), amount);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else if(strcmp(type, "Boombox", true) == 0)
        {
            if(AddInventory(playerid, INV_BOOMBOX, 1) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Added boombox to %s's inventory.", amount, GetUserName(target));
                SendClientMessageEx(target, COLOR_LIGHTBLUE, "** %s has added a boombox to your inventory.", GetMasterName(playerid), amount);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        return 1;
    }
    return 1;
}

CMD:putitem(playerid, params[])
{
    if(GetPlayerWeapon(playerid) > 2 && GetPlayerWeapon(playerid) < 46)
    {
        new weaponID = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
        if(weaponID > 1 && ammo > 0)
        {
            if(AddInventory(playerid, INV_GUN, ammo, weaponID) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** You have placed your %s into your inventory.", GetServerWeaponName(weaponID));
                RemovePlayerWeapon(playerid, weaponID);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else SendErrorMessage(playerid, "You do not have a weapon to put in your inventory.");
    }
    return 1;
}

CMD:putwep(playerid, params[])
{
    if(GetPlayerWeapon(playerid) > 2 && GetPlayerWeapon(playerid) < 46)
    {
        new weaponID = GetPlayerWeapon(playerid), ammo = GetPlayerAmmo(playerid);
        if(weaponID > 1 && ammo > 0)
        {
            if(AddInventory(playerid, INV_GUN, ammo, weaponID) == 1)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** You have placed your %s into your inventory.", GetServerWeaponName(weaponID));
                RemovePlayerWeapon(playerid, weaponID);
            }
            else SendErrorMessage(playerid, "Storage is at maxium capacity.");
        }
        else SendErrorMessage(playerid, "You do not have a weapon to put in your inventory.");
    }
    return 1;
}

CMD:inventory(playerid, params[])
{
    PrintInventory(playerid, playerid);
    return 1;
}
alias:inventory("inv");