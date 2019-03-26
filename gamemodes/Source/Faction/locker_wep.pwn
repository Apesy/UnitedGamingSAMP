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

#define MAX_FACTION_WEAPONS	100

enum lockerWepEnum
{
    ID,
    WeaponID,
    Ammo,
    FactionID
};
new LockerWep[MAX_FACTION_WEAPONS][lockerWepEnum];

stock LoadFactionWeapons()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `FactionWeapon`");
    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "ID", LockerWep[i][ID]);
            cache_get_value_int(i, "WeaponID", LockerWep[i][WeaponID]);
            cache_get_value_int(i, "Ammo", LockerWep[i][Ammo]);
            cache_get_value_int(i, "FactionID", LockerWep[i][FactionID]);
        }
    }
    cache_delete(result);
}

stock SaveFactionWeapons()
{
    for(new i; i < MAX_FACTION_WEAPONS; i++)
    {
        if(LockerWep[i][ID])
        {
            SaveFactionWeapon(i);
        }
    }
}

stock SaveFactionWeapon(wepid)
{
    new query[128];
    mysql_format(g_SQL, "UPDATE `FactionWeapon` SET `WeaponID` = %d, `Ammo` = %d, `FactionID` = %d WHERE `ID` = %d", LockerWep[wepid][WeaponID], LockerWep[wepid][Ammo], LockerWep[wepid][FactionID], LockerWep[wepid][ID]);
    mysql_tquery(g_SQL, query);
}

/*CMD:setfweapon(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new factionid, slot, wepid;
        if(sscanf(params, "iii", factionid, slot, wepid))
        {
            SendUsageMessage(playerid, "/setfweapon [FactionID] [Slot] [WeaponID]");
            for(new i; i < MAX_FACTION_WEAPONS; i++)
            {
                if(FactionWeapons[factionid][i] > 0)
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "%d. %s", i, GetServerWeaponName(FactionWeapons[factionid][i]));
                }
                else SendClientMessageEx(playerid, COLOR_YELLOW, "%d. Unused", i);
            }
            return 1;
        }
        
        if(factionid < 1 || factionid > MAX_FACTIONS || !FactionInfo[factionid][FactionID])
            return SendErrorMessage(playerid, "You specified an invalid faction.");

        if(slot < 0 || slot > MAX_FACTION_WEAPONS)
            return SendErrorMessage(playerid, "You specified an invalid slot.");
        
        FactionWeapons[factionid][slot] = wepid;
        SendServerMessage(playerid, "You set faction %d slot %d weapon to %s", factionid, slot, GetServerWeaponName(wepid));
        SaveFaction(factionid);
    }
	return 1;
}*/

new ListTracking[MAX_PLAYERS][MAX_FACTION_WEAPONS];
new ListTrackingAmmo[MAX_PLAYERS][MAX_FACTION_WEAPONS];
new ListTrackingID[MAX_PLAYERS][MAX_FACTION_WEAPONS];

hook OnPlayerConnect(playerid)
{
    for(new i; i < MAX_FACTION_WEAPONS; i++)
    {
        ListTracking[playerid][i] = 0;
        ListTrackingAmmo[playerid][i] = 0;
        ListTrackingID[playerid][i] = 0;
    }
    return 1;
}

stock ShowFactionWeapons(playerid)
{
    new bool:found = false, string[128*MAX_FACTION_WEAPONS], factionid = PlayerInfo[playerid][pFaction];
    if(factionid > 0)
    {
        new trackID = 0;
        format(string, sizeof string, "Weapon\tAmmo\n");
        for(new i; i < MAX_FACTION_WEAPONS; i++)
        {
            if(LockerWep[i][FactionID] == factionid)
            {
                found = true;
                ListTracking[playerid][trackID] = LockerWep[i][WeaponID];
                ListTrackingAmmo[playerid][trackID] = LockerWep[i][Ammo];
                ListTrackingID[playerid][trackID] = i;
                format(string, sizeof string, "%s%s\t%d\n", string, GetServerWeaponName(LockerWep[i][WeaponID]), LockerWep[i][Ammo]);
                trackID++;
            }
        }
        
        if(found)
        {
            Dialog_Show(playerid, FactionWeapons, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", string, "Take", "Exit");
        }
        else SendErrorMessage(playerid, "No weapons found.");
    }
    return 1;
}

Dialog:FactionWeapons(playerid, response, listitem, inputtext[])
{
    new factionid = PlayerInfo[playerid][pFaction], string[128];
    if(response && factionid > 0)
    {
        for(new i; i < MAX_FACTION_WEAPONS; i++)
        {
            if(ListTrackingID[playerid][listitem] == i)
            {
                if(IsWeaponRestricted(playerid))
                    return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                new wepid = ListTracking[playerid][listitem], wepAmmo = 0;
                if(wepid == GetPlayerWeapon(playerid))
                {
                    wepAmmo = GetPlayerAmmo(playerid) + ListTrackingAmmo[playerid][listitem];
                }
                else wepAmmo = ListTrackingAmmo[playerid][listitem];
                GivePlayerGun(playerid, wepid, wepAmmo, 0);
                format(string, sizeof string, "%s has been equipped.", GetServerWeaponName(wepid));
                PrintFooter(playerid, string);
                format(string, sizeof string, "%s (IP: %s AccountID: %d) has equipped %s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetServerWeaponName(wepid));
                WriteLog("Logs/Equip.log", string);
                return 1;
            }
        }
    }
    return 1;
}

CMD:factionweps(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new fac;
        if(sscanf(params, "d", fac))
            return SendUsageMessage(playerid, "/factionweps [FactionID (/factions)]");
        
        new found = false;
        for(new i; i < MAX_FACTION_WEAPONS; i++)
        {
            if(LockerWep[i][FactionID] == fac)
            {
                found = true;
                SendClientMessageEx(playerid, COLOR_YELLOW, "(ID %d): WeaponID:[%d (%s)] Ammo:[%d] DatabaseID:[%d]", i, LockerWep[i][WeaponID], GetServerWeaponName(LockerWep[i][WeaponID]), LockerWep[i][Ammo], LockerWep[i][ID]);
            }
        }
        if(!found)
            return SendErrorMessage(playerid, "No weapons were found for this faction, add them using /addwep.");
    }
    return 1;
}

CMD:addwep(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new fac, wepid, ammo;
        if(sscanf(params, "ddd", fac, wepid, ammo))
            return SendUsageMessage(playerid, "/addwep [FactionID (/factions)] [Ammo] [WeaponID]");

        new query[128];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `FactionWeapon` (`WeaponID`, `Ammo`, `FactionID`) VALUES (%d, %d, %d)", wepid, ammo, fac);
        mysql_tquery(g_SQL, query, "OnAddFactionWeapon", "ddd", playerid, fac, wepid, ammo);
    }
    return 1;
}

CMD:deletewep(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/deletewep [ID (see /factionweps)]");
        
        if(LockerWep[id][ID])
        {
            new query[128];
            mysql_format(g_SQL, query, sizeof query, "DELETE FROM `FactionWeapon` WHERE `ID` = %d", LockerWep[id][ID]);
            mysql_tquery(g_SQL, query);
            
            LockerWep[id][ID] = 0;
            LockerWep[id][WeaponID] = 0;
            LockerWep[id][Ammo] = 0;
            LockerWep[id][FactionID] = 0;
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Faction Weapon %d deleted.", id);
        }
        else SendErrorMessage(playerid, "Weapon is not used.");
    }
    return 1;
}

function OnAddFactionWeapon(playerid, fac, wepid, ammo)
{
    new string[128];
    for(new i; i < MAX_FACTION_WEAPONS; i++)
    {
        if(!LockerWep[i][ID])
        {
            LockerWep[i][ID] = cache_insert_id();
            LockerWep[i][WeaponID] = wepid;
            LockerWep[i][Ammo] = ammo;
            LockerWep[i][FactionID] = fac;
            format(string, sizeof string, "%s %s has added weapon %d to faction %d.", GetAdminRank(playerid), GetMasterName(playerid), wepid, fac);
            SendAdminCommand(string, 4);
            return 1;
        }
    }
    SendErrorMessage(playerid, "Cannot add weapon, faction weapons limit was reached. (Limit: %d)", MAX_FACTION_WEAPONS);
    return 1;
}