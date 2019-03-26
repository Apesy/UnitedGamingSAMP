//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_SPIKES 20

enum spikeEnum
{
    sModelID,
    Float:sX,
    Float:sY,
    Float:sZ,
    Float:sRX,
    Float:sRY,
    Float:sRZ,
    sObjectID
};
new Spikes[MAX_SPIKES][spikeEnum];

stock CreateSpike(playerid, modelid, Float:x, Float:y, Float:z, Float:a)
{
    for(new i; i < sizeof(Spikes); i++)
    {
        if(!IsValidDynamicObject(Spikes[i][sObjectID]))
        {
            Spikes[i][sX] = x;
            Spikes[i][sY] = y;
            Spikes[i][sZ] = z;
            Spikes[i][sRZ] = a;
            Spikes[i][sObjectID] = CreateDynamicObject(modelid, x, y+0.5, z, 0, 0, a);
            TempVar[playerid][EditingSpike] = i;
            TempVar[playerid][EditType] = EDIT_TYPE_EDIT_SPIKES;
            EditDynamicObject(playerid, Spikes[i][sObjectID]);
            return 1;
        }
    }
    return 1;
}

CMD:editspike(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    TempVar[playerid][SelectType] = SELECT_TYPE_EDIT_SPIKE;
    SelectObject(playerid);
    SendClientMessage(playerid, -1, "Select a spike strip to modify.");
    return 1;
}

CMD:spiker(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    TempVar[playerid][SelectType] = SELECT_TYPE_DELETE_SPIKE;
    SelectObject(playerid);
    SendClientMessage(playerid, -1, "Select a spike strip to remove.");
    return 1;
}

CMD:disbandspikes(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new string[128];
        for(new i; i < sizeof(Spikes); i++)
        {
            if(IsValidDynamicObject(Spikes[i][sObjectID]))
            {
                Spikes[i][sX] = 0;
                Spikes[i][sY] = 0;
                Spikes[i][sZ] = 0;
                Spikes[i][sRX] = 0;
                Spikes[i][sRY] = 0;
                Spikes[i][sRZ] = 0;
                DestroyDynamicObject(Spikes[i][sObjectID]);
            }
        }
        format(string, sizeof string, "%s %s has removed all spike strips.", GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string);
    }
    return 1;
}

CMD:spike(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    CreateSpike(playerid, 2899, x, y, z, a);
    SendClientMessage(playerid, -1, "Set the spike strips position.");
    return 1;
}

CMD:spikel(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    CreateSpike(playerid, 2892, x, y, z, a);
    SendClientMessage(playerid, -1, "Set the spike strips position.");
    return 1;
}

hook OnPlayerUpdate(playerid)
{
   if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
   {
       new vehicleid = GetPlayerVehicleID(playerid);
       for(new i = 0; i < MAX_SPIKES; i++)
       {
           if(IsValidDynamicObject(Spikes[i][sObjectID]))
           {
               if(GetVehicleDistanceFromPoint(vehicleid, Spikes[i][sX], Spikes[i][sY], Spikes[i][sZ]) <= 3)
               {
                    new panels, doors, lights, tires;
                    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
                    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 15);
               }
           }
       }
   }
   return 1;
}