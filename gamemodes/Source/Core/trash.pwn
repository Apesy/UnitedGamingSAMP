//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_GARBAGE_BINS 50

enum garbageData 
{
	garbageID,
 	garbageModel,
	garbageCapacity,
    garbageWeapon,
    garbageWeaponAmmo,
    garbageWeaponSerial,
	Float:garbagePos[4],
	garbageInterior,
	garbageWorld,
	Text3D:garbageText3D,
	garbageObject
};
new GarbageData[MAX_GARBAGE_BINS][garbageData],
    Cache:trashCache;

#define MAX_TRASH_INVENTORY 20

enum trashInventoryEnum
{
    InventoryID,
    InventoryType,
    InventoryWeaponID,
    InventoryAmount,
    InventoryWeight,
    InventorySerial
};
new TrashInventoryInfo[MAX_TRASH_INVENTORY][MAX_GARBAGE_BINS][trashInventoryEnum];

stock GetTrashInventory(id, type)
{
    for(new i; i < MAX_TRASH_INVENTORY; i++) 
    {
        if(TrashInventoryInfo[i][id][InventoryType] == type)
        {
            return 1;
        }
    }
    return 0;
}

stock AddTrashInventory(id, type, amount, weaponid = 0, serial = 0)
{
    if(type == INV_NONE || amount < 1)
        return 0;

    for(new i; i < MAX_TRASH_INVENTORY; i++)
    {
        if(TrashInventoryInfo[i][id][InventoryType] == INV_NONE)
        {
            new query[128];
            mysql_format(g_SQL, query, sizeof query, "INSERT INTO `Trash_Inventory` (`Type`, `WeaponID`, `Amount`, `Serial`, `GarbageID`) VALUES (%d, %d, %d, %d, %d)", type, weaponid, amount, serial, id);
            mysql_tquery(g_SQL, query, "OnAddTrashInv", "dddddd", id, i, type, weaponid, amount, serial);
            return 1;
        }
    }
    return 0;
}

function OnAddTrashInv(id, i, type, weaponid, amount, serial)
{
    TrashInventoryInfo[i][id][InventoryID] = cache_insert_id();
    TrashInventoryInfo[i][id][InventoryType] = type;
    TrashInventoryInfo[i][id][InventoryWeaponID] = weaponid;
    TrashInventoryInfo[i][id][InventoryAmount] = amount;
    TrashInventoryInfo[i][id][InventorySerial] = serial;
    return 1;
}

stock RemoveTrashInventory(slot, id)
{
    TrashInventoryInfo[slot][id][InventorySerial] = 0;
    TrashInventoryInfo[slot][id][InventoryWeaponID] = 0;
    TrashInventoryInfo[slot][id][InventoryAmount] = 0;
    TrashInventoryInfo[slot][id][InventoryType] = INV_NONE;
}

stock ResetTrashInventory(id)
{
    for(new slot; slot < MAX_TRASH_INVENTORY; slot++)
    {
        TrashInventoryInfo[slot][id][InventorySerial] = 0;
        TrashInventoryInfo[slot][id][InventoryWeaponID] = 0;
        TrashInventoryInfo[slot][id][InventoryAmount] = 0;
        TrashInventoryInfo[slot][id][InventoryType] = INV_NONE;
    }
}

function PrintTrashInventory(playerid, id)
{
    new result[128*MAX_TRASH_INVENTORY];
    SetPVarInt(playerid, "TakeInvID", id);
    result = "Name\tAmount";
    for(new i; i < MAX_TRASH_INVENTORY; i++)
    {
        if(TrashInventoryInfo[i][id][InventoryType] != INV_NONE)
        {
            if(TrashInventoryInfo[i][id][InventoryAmount] > 0)
            {
                format(result, sizeof result, "%s\n%s\t%d", result, GetItemName(TrashInventoryInfo[i][id][InventoryType], TrashInventoryInfo[i][id][InventoryWeaponID]), TrashInventoryInfo[i][id][InventoryAmount]);
            }
            else format(result, sizeof result, "%s\n%s\tEmpty", result, GetItemName(TrashInventoryInfo[i][id][InventoryType], TrashInventoryInfo[i][id][InventoryWeaponID]));
        }
        else format(result, sizeof result, "%s\nEmpty\tEmpty", result);
    }
    TempVar[playerid][InventorySelectType] = 2;
    Dialog_Show(playerid, Trash_Inventory, DIALOG_STYLE_TABLIST_HEADERS, "Garbage Inventory", result, "Take", "Exit");
    return 1;
}

stock GetTrashAmount(id)
{
    new amount = 0;
    for(new i; i < MAX_TRASH_INVENTORY; i++)
    {
        if(TrashInventoryInfo[i][id][InventoryType] != INV_NONE)
        {
            amount++;
        }
    }
    return amount;
}

CMD:checktrash(playerid, params[])
{
    new id = Garbage_Nearest(playerid);
    if(id != -1)
    {
        PrintTrashInventory(playerid, id);
    }
    return 1;
}

CMD:putintrash(playerid, params[])
{
    new id = Garbage_Nearest(playerid), string[128];
    if(id != -1)
    {
        new weaponid = GetPlayerWeapon(playerid), idx = GetWeaponIDSlot(weaponid); 
        if(weaponid > 1)
        {
            new trashAmount = GetTrashAmount(id);
            if (trashAmount >= 20)
                return SendErrorMessage(playerid, "This garbage bin is full of trash.");

            Garbage_Save(id);

            if(AddTrashInventory(id, INV_GUN, PlayerInfo[playerid][pAmmo][idx], weaponid, PlayerInfo[playerid][pSerial][idx]) == 1)
            {
                RemovePlayerWeapon(playerid, weaponid);
                format(string, sizeof string, "%s", GetServerWeaponName(weaponid));
                SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s throws their %s into the bin.", GetRPName(playerid), string);

                format(string, sizeof(string), "Garbage Bin\n{FFFFFF}Capacity: %d/%d", trashAmount+1, MAX_TRASH_INVENTORY);
                UpdateDynamic3DTextLabelText(GarbageData[id][garbageText3D], COLOR_DEPT, string);
            }
            else SendErrorMessage(playerid, "Cannot place weapon in trash.");
            return 1;
        }
        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
        {
            new trashAmount = GetTrashAmount(id);
            if (trashAmount >= 20)
                return SendErrorMessage(playerid, "This garbage bin is full of trash.");

            Garbage_Save(id);

            if(AddTrashInventory(id, PlayerInfo[playerid][pHoldingInv], PlayerInfo[playerid][pHoldingInvAmount]) == 1)
            {
                StopHoldInventoryItem(playerid);
                format(string, sizeof string, "%s", GetItemName(PlayerInfo[playerid][pHoldingInv]));
                SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s throws their %s into the bin.", GetRPName(playerid), string);

                format(string, sizeof(string), "Garbage Bin\n{FFFFFF}Capacity: %d/%d", trashAmount+1, MAX_TRASH_INVENTORY);
                UpdateDynamic3DTextLabelText(GarbageData[id][garbageText3D], COLOR_DEPT, string);
            }
            else SendErrorMessage(playerid, "Cannot place item in trash.");
            return 1;
        }
        SendErrorMessage(playerid, "You are not holding anything. Take something from your inventory or scroll a weapon.");
    }
    return 1;
}

stock Garbage_Create(playerid, type)
{
    for(new i; i < MAX_GARBAGE_BINS; i++)
    {
        if (!GarbageData[i][garbageID])
        {
            switch (type) 
            {
                case 1: GarbageData[i][garbageModel] = 3035;
                case 2: GarbageData[i][garbageModel] = 1359;
                case 3: GarbageData[i][garbageModel] = 1358;
                case 4: GarbageData[i][garbageModel] = 1343;
            }
            GetPlayerPos(playerid, GarbageData[i][garbagePos][0], GarbageData[i][garbagePos][1], GarbageData[i][garbagePos][2]);
	        GetPlayerFacingAngle(playerid, GarbageData[i][garbagePos][3]);

            GarbageData[i][garbagePos][0] = GarbageData[i][garbagePos][0] + 1.8;
            GarbageData[i][garbagePos][1] = GarbageData[i][garbagePos][1] + 1.8;


            GarbageData[i][garbageInterior] = GetPlayerInterior(playerid);
            GarbageData[i][garbageWorld] = GetPlayerVirtualWorld(playerid);

            Garbage_Refresh(i);
		    mysql_tquery(g_SQL, "INSERT INTO `garbage` (`garbageCapacity`) VALUES(0)", "OnGarbageCreated", "d", i);

            TempVar[playerid][EditType] = EDIT_TYPE_GARBAGE;
            EditDynamicObject(playerid, GarbageData[i][garbageObject]);
            return i;
        }
    }
    return -1;
}

stock Garbage_Refresh(garbageid)
{
	if (garbageid != -1 && GarbageData[garbageid][garbageID])
	{
	    if (IsValidDynamic3DTextLabel(GarbageData[garbageid][garbageText3D]))
	        DestroyDynamic3DTextLabel(GarbageData[garbageid][garbageText3D]);

		if (IsValidDynamicObject(GarbageData[garbageid][garbageObject]))
		    DestroyDynamicObject(GarbageData[garbageid][garbageObject]);

		new
			string[64];

		format(string, sizeof(string), "Garbage Bin\n{FFFFFF}Capacity: %d/%d", GetTrashAmount(garbageid), MAX_TRASH_INVENTORY);

		GarbageData[garbageid][garbageText3D] = CreateDynamic3DTextLabel(string, COLOR_DEPT, GarbageData[garbageid][garbagePos][0], GarbageData[garbageid][garbagePos][1], GarbageData[garbageid][garbagePos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GarbageData[garbageid][garbageWorld], GarbageData[garbageid][garbageInterior]);
		GarbageData[garbageid][garbageObject] = CreateDynamicObject(GarbageData[garbageid][garbageModel], GarbageData[garbageid][garbagePos][0], GarbageData[garbageid][garbagePos][1], GarbageData[garbageid][garbagePos][2], 0.0, 0.0, GarbageData[garbageid][garbagePos][3], GarbageData[garbageid][garbageWorld], GarbageData[garbageid][garbageInterior]);
	}
	return 1;
}

function OnGarbageCreated(garbageid)
{
	if (garbageid == -1)
	    return 0;

	GarbageData[garbageid][garbageID] = cache_insert_id();
	Garbage_Save(garbageid);

	return 1;
}

stock Garbage_Save(garbageid)
{
	new
	    query[300];

	format(query, sizeof(query), "UPDATE `garbage` SET `garbageModel` = '%d', `garbageCapacity` = '%d', `garbageX` = '%f', `garbageY` = '%f', `garbageZ` = '%f', `garbageA` = '%f', `garbageInterior` = '%d', `garbageWorld` = '%d' WHERE `garbageID` = '%d'",
        GarbageData[garbageid][garbageModel],
        GarbageData[garbageid][garbageCapacity],
        GarbageData[garbageid][garbagePos][0],
        GarbageData[garbageid][garbagePos][1],
        GarbageData[garbageid][garbagePos][2],
        GarbageData[garbageid][garbagePos][3],
        GarbageData[garbageid][garbageInterior],
        GarbageData[garbageid][garbageWorld],
        GarbageData[garbageid][garbageID]
	);
	return mysql_tquery(g_SQL, query);
}

stock Garbage_Nearest(playerid)
{
    for (new i = 0; i != MAX_GARBAGE_BINS; i ++) if (GarbageData[i][garbageID] && IsPlayerInRangeOfPoint(playerid, 3.0, GarbageData[i][garbagePos][0], GarbageData[i][garbagePos][1], GarbageData[i][garbagePos][2]))
	{
		if (GetPlayerInterior(playerid) == GarbageData[i][garbageInterior] && GetPlayerVirtualWorld(playerid) == GarbageData[i][garbageWorld])
			return i;
	}
	return -1;
}

stock Garbage_Delete(garbageid)
{
	if (garbageid != -1 && GarbageData[garbageid][garbageID])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `garbage` WHERE `garbageID` = '%d'", GarbageData[garbageid][garbageID]);
		mysql_tquery(g_SQL, string);

        if (IsValidDynamic3DTextLabel(GarbageData[garbageid][garbageText3D]))
	        DestroyDynamic3DTextLabel(GarbageData[garbageid][garbageText3D]);

		if (IsValidDynamicObject(GarbageData[garbageid][garbageObject]))
		    DestroyDynamicObject(GarbageData[garbageid][garbageObject]);

	    GarbageData[garbageid][garbageID] = 0;
	}
	return 1;
}

stock LoadGarbages()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `garbage`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            trashCache = cache_save();
            cache_get_value_int(i, "garbageID", GarbageData[i][garbageID]);
            cache_get_value_int(i, "garbageModel", GarbageData[i][garbageModel]);
            cache_get_value_int(i, "garbageCapacity", GarbageData[i][garbageCapacity]);

            cache_get_value_float(i, "garbageX", GarbageData[i][garbagePos][0]);
            cache_get_value_float(i, "garbageY", GarbageData[i][garbagePos][1]);
            cache_get_value_float(i, "garbageZ", GarbageData[i][garbagePos][2]);
            cache_get_value_float(i, "garbageA", GarbageData[i][garbagePos][3]);

            cache_get_value_int(i, "garbageInterior", GarbageData[i][garbageInterior]);
            cache_get_value_int(i, "garbageWorld", GarbageData[i][garbageWorld]);



            Garbage_Refresh(i);
            cache_set_active(trashCache);
        }
    }
    cache_delete(result); 
}

function LoadTrashInventory(id)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `Trash_Inventory` WHERE `GarbageID` = %d LIMIT %d", GarbageData[id][garbageID], MAX_TRASH_INVENTORY);
    mysql_tquery(g_SQL, query, "OnLoadTrashInventory", "d", id);
}

function OnLoadTrashInventory(id)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", TrashInventoryInfo[i][id][InventoryID]);
            cache_get_value_int(i, "Type", TrashInventoryInfo[i][id][InventoryType]);
            cache_get_value_int(i, "WeaponID", TrashInventoryInfo[i][id][InventoryWeaponID]);
            cache_get_value_int(i, "Amount", TrashInventoryInfo[i][id][InventoryAmount]);
            cache_get_value_int(i, "Weight", TrashInventoryInfo[i][id][InventoryWeight]);
            cache_get_value_int(i, "Serial", TrashInventoryInfo[i][id][InventorySerial]);
        }
    }
    return 1;
}

CMD:creategarbage(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id = -1,
            type;

        if (sscanf(params, "d", type))
        {
            SendUsageMessage(playerid, "/creategarbage [type]");
            SendClientMessage(playerid, COLOR_WHITE, "Types: 1. Dumpster, 2. Trash Can, 3. Skip, 4. Wheelie Bin");
            return 1;
        }
        if (type < 1 || type > 4)
            return SendErrorMessage(playerid, "The specified type can't be below 1 or above 2.");

        id = Garbage_Create(playerid, type);

        if (id == -1)
            return SendErrorMessage(playerid, "The server has reached the limit for garbage bins.");

        EditDynamicObject(playerid, GarbageData[id][garbageObject]);
        TempVar[playerid][EditType] = EDIT_TYPE_GARBAGE;
        SetPVarInt(playerid, "GarbageID", id);

        SendServerMessage(playerid, "You have successfully created garbage bin ID: %d.", id);
    }
	return 1;
}

CMD:destroygarbage(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if (sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/destroygarbage [garbage id]");

        if ((id < 0 || id >= MAX_GARBAGE_BINS) || !GarbageData[id][garbageID])
            return SendErrorMessage(playerid, "You have specified an invalid garbage ID.");

        Garbage_Delete(id);
        SendServerMessage(playerid, "You have successfully destroyed garbage bin ID: %d.", id);
    }
	return 1;
}

CMD:editgarbage(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if (sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/destroygarbage [garbage id]");

        if ((id < 0 || id >= MAX_GARBAGE_BINS) || !GarbageData[id][garbageID])
            return SendErrorMessage(playerid, "You have specified an invalid garbage ID.");
        
        EditDynamicObject(playerid, GarbageData[id][garbageObject]);
        TempVar[playerid][EditType] = EDIT_TYPE_GARBAGE;
        SetPVarInt(playerid, "GarbageID", id);
    }
    return 1;
}

CMD:editgarbagetype(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new id, type;
        if (sscanf(params, "dd", id, type))
        {
            SendUsageMessage(playerid, "/editgarbagetype [garbage id] [type]");
            SendClientMessage(playerid, COLOR_WHITE, "Types: 1. Dumpster, 2. Trash Can, 3. Skip, 4. Wheelie Bin");
            return 1;
        }
        if (type < 1 || type > 4)
            return SendErrorMessage(playerid, "The specified type can't be below 1 or above 2.");

        if ((id < 0 || id >= MAX_GARBAGE_BINS) || !GarbageData[id][garbageID])
            return SendErrorMessage(playerid, "You have specified an invalid garbage ID.");
        
        switch (type) 
        {
            case 1: GarbageData[id][garbageModel] = 3035;
            case 2: GarbageData[id][garbageModel] = 1359;
            case 3: GarbageData[id][garbageModel] = 1358;
            case 4: GarbageData[id][garbageModel] = 1343;
        }
        Garbage_Refresh(id);
    }
    return 1;
}

Dialog:Trash_Inventory(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = listitem, targetid = GetPVarInt(playerid, "TakeInvID");
        if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0 && TrashInventoryInfo[i][targetid][InventoryType] != INV_NONE)
        {
            switch(TrashInventoryInfo[i][targetid][InventoryType])
            {
                case INV_GUN:
                {
                    if(PlayerInfo[playerid][pLevel] < 2)
		                return SendErrorMessage(playerid, "You need to be level 2 in order to take guns from the trash.");

                    if(TrashInventoryInfo[i][targetid][InventoryWeaponID] > 0 && TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(IsWeaponRestricted(playerid))
                            return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                        PlayerInfo[playerid][pHoldingInvAmount] = TrashInventoryInfo[i][targetid][InventoryAmount];
                        GivePlayerGun(targetid, TrashInventoryInfo[i][targetid][InventoryWeaponID], TrashInventoryInfo[i][targetid][InventoryAmount], TrashInventoryInfo[i][targetid][InventorySerial]);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED:
                {
                    if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_WEED, TrashInventoryInfo[i][targetid][InventoryAmount]);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_WEED_SEED:
                {
                    if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
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
                    if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_COCAINE, TrashInventoryInfo[i][targetid][InventoryAmount]);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_BOOMBOX:
                {
                    if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_BOOMBOX, 1);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
                case INV_RADIO:
                {
                    if(TrashInventoryInfo[i][targetid][InventoryAmount] > 0)
                    {
                        if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
                            return SendErrorMessage(playerid, "You are already holding an item, place it before using it.");

                        HoldInventoryItem(targetid, INV_RADIO, 1);
                    }
                    else return SendErrorMessage(playerid, "There is nothing there, please post a bug report (%s).", GetDateTime());
                }
            }
            RemoveTrashInventory(playerid, i);
        }
        else SendErrorMessage(playerid, "There is nothing there...");
    }
    return 1;
}
