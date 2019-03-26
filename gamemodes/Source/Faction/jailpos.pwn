//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_JAILS 20

enum jailEnum
{
    ID,
    Float:PosX,
    Float:PosY,
    Float:PosZ,
    Float:PosA,
    Interior,
    VirtualWorld,
    FactionID
};
new JailInfo[MAX_JAILS][jailEnum],
    Cache:jailCache;

stock LoadJails()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `jails`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            jailCache = cache_save();
            cache_get_value_int(i, "ID", JailInfo[i+1][ID]);

            cache_get_value_float(i, "PosX", JailInfo[i+1][PosX]);
            cache_get_value_float(i, "PosY", JailInfo[i+1][PosY]);
            cache_get_value_float(i, "PosZ", JailInfo[i+1][PosZ]);
            cache_get_value_float(i, "PosA", JailInfo[i+1][PosA]);
            cache_get_value_int(i, "Interior", JailInfo[i+1][Interior]);
            cache_get_value_int(i, "VirtualWorld", JailInfo[i+1][VirtualWorld]);
            cache_get_value_int(i, "FactionID", JailInfo[i+1][FactionID]);
        
            Iter_Add(Jails,i);
            cache_set_active(jailCache);
        }
    }
    cache_delete(result); 
}

stock SaveJails()
{
    for(new i; i < MAX_JAILS; i++)
    {
        if(JailInfo[i][ID])
        {
            SaveJail(i);
        }
    }
}

stock SaveJail(i)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE jails SET PosX = %f, PosY = %f, PosZ = %f, PosA = %f, Interior = %d, VirtualWorld = %d, FactionID = %d WHERE ID = %d LIMIT 1", 
        JailInfo[i][PosX],
        JailInfo[i][PosY],
        JailInfo[i][PosZ],
        JailInfo[i][PosA],
        JailInfo[i][Interior],
        JailInfo[i][VirtualWorld],
        JailInfo[i][FactionID],
        JailInfo[i][ID]);
    mysql_tquery(g_SQL, query);
}

CMD:createjail(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        for(new i; i < MAX_JAILS; i++)
        {
            if(!JailInfo[i][ID])
            {
                new Float:x, Float:y, Float:z, Float:angle, query[256];
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, angle);
                mysql_format(g_SQL, query, sizeof(query), "INSERT INTO jails (PosX, PosY, PosZ, PosA) VALUES(%f, %f, %f, %f)", x, y, z, angle);
                mysql_tquery(g_SQL, query, "OnCreateJail", "iiffff", playerid, i, x, y, z, angle);
                return 1;
            }
        }
        SendErrorMessage(playerid, "The maximum number of businesses has been reached.");
    }
    return 1;
}

function OnCreateJail(playerid, i, x, y, z, angle)
{
    JailInfo[i][ID] = cache_insert_id();

    JailInfo[i][PosX] = x;
    JailInfo[i][PosY] = y;
    JailInfo[i][PosZ] = z;
    JailInfo[i][PosA] = angle;
    JailInfo[i][Interior] = GetPlayerInterior(playerid);
    JailInfo[i][VirtualWorld] = GetPlayerVirtualWorld(playerid);
    JailInfo[i][FactionID] = 0;

    new string[128];
    format(string, sizeof string, "%s %s has created a new jail pos with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
    SendAdminCommand(string, 4);
    format(string, sizeof(string), "%s %s has created a new jail pos with ID %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
    WriteLog("Logs/editjail.log", string);

    SaveJail(i);
    return 1;
}

CMD:editjail(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i, option[32], paramater;
        if(sscanf(params, "ds[32]D", i, option, paramater))
        {
            SendErrorMessage(playerid, "/editjail [JailID] [Option]");
            SendClientMessage(playerid, -1, "Option: Position, FactionID");
            return 1;
        }

        if(!JailInfo[i][ID])
            return SendErrorMessage(playerid, "You must /createjail first.");

        if(i < 1 || i > MAX_JAILS)
            return SendErrorMessage(playerid, "Cannot find jail.");

        if(strcmp(option, "position", true) == 0)
        {
            new Float:x, Float:y, Float:z, Float:angle;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            JailInfo[i][PosX] = x;
            JailInfo[i][PosY] = y;
            JailInfo[i][PosZ] = z;
            JailInfo[i][PosA] = angle;
            JailInfo[i][Interior] = GetPlayerInterior(playerid);
            JailInfo[i][VirtualWorld] = GetPlayerVirtualWorld(playerid);

            SendClientMessageEx(playerid, COLOR_GREY, "Jail %d position set to your current spot.", i);
            SaveJail(i);
            return 1;
        }
        SendClientMessage(playerid, -1, "Option: Position, FactionID");
        return 1;
    }
    return 1;
}

CMD:gotojail(playerid, params[])
{
    if(IsAdminLevel(playerid, 2))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/gotojail [Jail ID]");


        if(!JailInfo[i][ID])
            return SendErrorMessage(playerid, "You must /createjail first.");

        if(i < 1 || i > MAX_JAILS)
            return SendErrorMessage(playerid, "The jail you specified doesn't exist.");

        SetPlayerPosEx(playerid, JailInfo[i][PosX], JailInfo[i][PosY], JailInfo[i][PosZ]);
        SetPlayerFacingAngle(playerid, JailInfo[i][PosA]);
        SetInterior(playerid, JailInfo[i][Interior]);
        SetVirtualWorld(playerid, JailInfo[i][VirtualWorld]);
        TogglePlayerWait(playerid);
        SendTeleportMessage(playerid);
        return 1;
    }
    return 1;
}

function JailPlayer(playerid, playerb, time)
{
    for(new i; i < MAX_JAILS; i++)
    {
        if(JailInfo[i][ID] > 0 && IsPlayerInRangeOfPoint(playerid, 10.0, JailInfo[i][PosX], JailInfo[i][PosY], JailInfo[i][PosZ]))
        {
            PlayerInfo[playerb][pJailed] = 1;
            PlayerInfo[playerb][pJailTime] = time*60;
            PlayerInfo[playerb][pJailID] = JailInfo[i][ID];
            PrintFooter(playerb, "~w~You were~n~~r~ Arrested", 5);
            SendClientMessageEx(playerb, COLOR_LIGHTBLUE, "* You were arrested by %s %s for %d minutes.", GetPlayerRank(playerid), GetRPName(playerid), time);
            new string[256];
            mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Jailed` = %d, `JailTime` = %d, `JailID` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerb][pJailed], PlayerInfo[playerb][pJailTime], PlayerInfo[playerb][pJailID], PlayerInfo[playerb][pCharacterID]);
            mysql_tquery(g_SQL, string);
            SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_DBLUE, "%s %s has jailed %s for %d min.", GetPlayerRank(playerid), GetRPName(playerid), GetRPName(playerb), time);
            return 1;
        }
    }
    SendErrorMessage(playerid, "You are not near a jail cell.");
    return 1;
}

stock SendToJail(playerid, jailid)
{
    for(new i; i < MAX_JAILS; i++)
    {
        if(JailInfo[i][ID] == jailid)
        {
            SetPlayerPosEx(playerid, JailInfo[i][PosX], JailInfo[i][PosY], JailInfo[i][PosZ]);
            SetPlayerFacingAngle(playerid, JailInfo[i][PosA]);
            SetInterior(playerid, JailInfo[i][Interior]);
            SetVirtualWorld(playerid, JailInfo[i][VirtualWorld]);
            TogglePlayerWait(playerid);
            return 1;
        }
    }
    return 1;
}