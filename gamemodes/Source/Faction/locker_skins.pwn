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

#define SKINS_PER_FACTION 25
#define MAX_FACTION_SKINS SKINS_PER_FACTION*MAX_FACTIONS

enum lockerSkinEnum
{
    ID,
    SkinID,
    FactionID
};
new LockerSkins[MAX_FACTION_SKINS][lockerSkinEnum];

stock LoadFactionSkins()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `FactionSkin`");
    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "ID", LockerSkins[i][ID]);
            cache_get_value_int(i, "SkinID", LockerSkins[i][SkinID]);
            cache_get_value_int(i, "FactionID", LockerSkins[i][FactionID]);
        }
    }
    cache_delete(result);
}

stock SaveFactionSkins()
{
    for(new i; i < MAX_FACTION_SKINS; i++)
    {
        if(LockerSkins[i][ID])
        {
            SaveFactionSkin(i);
        }
    }
}

stock SaveFactionSkin(wepid)
{
    new query[128];
    mysql_format(g_SQL, "UPDATE `FactionWeapon` SET `SkinID` = %d, `FactionID` = %d WHERE `ID` = %d", LockerSkins[wepid][SkinID], LockerSkins[wepid][FactionID], LockerWep[wepid][ID]);
    mysql_tquery(g_SQL, query);
}

new SkinListTracking[MAX_PLAYERS][MAX_FACTION_SKINS];
new SkinListTrackingID[MAX_PLAYERS][MAX_FACTION_SKINS];

hook OnPlayerConnect(playerid)
{
    for(new i; i < MAX_FACTION_SKINS; i++)
    {
        SkinListTracking[playerid][i] = 0;
        SkinListTrackingID[playerid][i] = 0;
    }
    return 1;
}

stock ShowFactionSkins(playerid)
{
    new bool:found = false, string[10*MAX_FACTION_SKINS], factionid = PlayerInfo[playerid][pFaction];
    if(factionid > 0)
    {
        new trackID = 0;
        for(new i; i < MAX_FACTION_SKINS; i++)
        {
            if(LockerSkins[i][FactionID] == factionid && LockerSkins[i][SkinID] > 0)
            {
                found = true;
                SkinListTracking[playerid][trackID] = LockerSkins[i][SkinID];
                SkinListTrackingID[playerid][trackID] = i;
                format(string, sizeof string, "%s%d\n", string, LockerSkins[i][SkinID]);
                trackID++;
            }
        }
        
        if(found)
        {
            Dialog_Show(playerid, FactionSkins, DIALOG_STYLE_LIST, "Skins", string, "Take", "Exit");
        }
        else SendErrorMessage(playerid, "No skins found.");
    }
    return 1;
}

Dialog:FactionSkins(playerid, response, listitem, inputtext[])
{
    new factionid = PlayerInfo[playerid][pFaction], string[128];
    if(response && factionid > 0)
    {
        for(new i; i < MAX_FACTION_SKINS; i++)
        {
            if(SkinListTrackingID[playerid][listitem] == i && LockerSkins[i][SkinID] > 0)
            {
                if(!PlayerInfo[playerid][pBeforeSkin])
                {
                    PlayerInfo[playerid][pBeforeSkin] = GetPlayerSkin(playerid);
                }
                new skinid = SkinListTracking[playerid][listitem];
                SetSkin(playerid, skinid);
                format(string, sizeof string, "%s (IP: %s AccountID: %d) has equipped skin id %d.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], skinid);
                WriteLog("Logs/Equip.log", string);
                return 1;
            }
        }
    }
    return 1;
}

CMD:factionskins(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new fac;
        if(sscanf(params, "d", fac))
            return SendUsageMessage(playerid, "/factionskins [FactionID (/factions)]");
        
        if(fac < 1 || fac > MAX_FACTIONS)
            return SendErrorMessage(playerid, "Invalid FactionID specified, factions must be between 1 and %d.", MAX_FACTIONS);

        if(!FactionInfo[fac][FactionID])
            return SendErrorMessage(playerid, "Invalid FactionID specified, see /factions.");

        new found = false;
        for(new i; i < MAX_FACTION_SKINS; i++)
        {
            if(LockerSkins[i][FactionID] == fac)
            {
                found = true;
                SendClientMessageEx(playerid, COLOR_YELLOW, "(ID %d): SkinID:[%d] DatabaseID:[%d]", i, LockerSkins[i][SkinID], LockerSkins[i][ID]);
            }
        }
        if(!found)
            return SendErrorMessage(playerid, "No skins were found for this faction, add them using /addskin.");
    }
    return 1;
}

CMD:addskin(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new fac, skin;
        if(sscanf(params, "dd", fac, skin))
            return SendUsageMessage(playerid, "/addskin [FactionID (/factions)] [SkinID]");
        
        new iSkins = 0;
        for(new i; i < MAX_FACTION_SKINS; i++)
        {
            if(LockerSkins[i][ID] && LockerSkins[i][SkinID] >= 1 && LockerSkins[i][FactionID] == fac)
            {
                iSkins++;
                if(iSkins > SKINS_PER_FACTION)
                {
                    return SendErrorMessage(playerid, "This faction has reached the limit for skins. (Limit: %d)", SKINS_PER_FACTION);
                }
            }
        }

        new query[128];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `FactionSkin` (`SkinID`, `FactionID`) VALUES (%d, %d)", skin, fac);
        mysql_tquery(g_SQL, query, "OnAddFactionSkin", "ddd", playerid, fac, skin);
    }
    return 1;
}

CMD:deleteskin(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/deleteskin [ID (see /factionskins)]");
        
        if(LockerSkins[id][ID])
        {
            new query[128];
            mysql_format(g_SQL, query, sizeof query, "DELETE FROM `FactionSkin` WHERE `ID` = %d", LockerSkins[id][ID]);
            mysql_tquery(g_SQL, query);
            
            LockerSkins[id][ID] = 0;
            LockerSkins[id][SkinID] = 0;
            LockerSkins[id][FactionID] = 0;
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Faction Skin %d deleted.", id);
        }
        else SendErrorMessage(playerid, "Skin is not used.");
    }
    return 1;
}

function OnAddFactionSkin(playerid, fac, skin)
{
    new string[128];
    for(new i; i < MAX_FACTION_SKINS; i++)
    {
        if(!LockerSkins[i][ID])
        {
            LockerSkins[i][ID] = cache_insert_id();
            LockerSkins[i][SkinID] = skin;
            LockerSkins[i][FactionID] = fac;
            format(string, sizeof string, "%s %s has added skin %d to faction %d.", GetAdminRank(playerid), GetMasterName(playerid), skin, fac);
            SendAdminCommand(string, 4);
            return 1;
        }
    }
    SendErrorMessage(playerid, "Cannot add skin, faction skins limit was reached. (Limit: %d)", MAX_FACTION_SKINS);
    return 1;
}