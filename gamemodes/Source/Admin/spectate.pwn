//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
CMD:spec(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        if(strcmp(params, "off", true) == 0 && GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
        {
            SendClientMessageEx(playerid, COLOR_YELLOW, "** You stopped spectating %s.", GetUserName(TempVar[playerid][Spectating]));

            TogglePlayerSpectating(playerid, false); 
            return 1;
        }

        new playerb;
        
        if (sscanf(params, "u", playerb))
            return SendUsageMessage(playerid, "/spec [playerid or name]");
            
        if(!IsPlayerConnected(playerb))
            return SendErrorMessage(playerid, "The player you specified isn't connected."); 
            
        if(Player[playerb][IsLoggedIn] == false)
            return SendErrorMessage(playerid, "The player you specified isn't logged in."); 
            
        if(TempVar[playerb][Spectating] != INVALID_PLAYER_ID)
            return SendErrorMessage(playerid, "That player is spectating another player."); 

        if(playerb == playerid) return SendErrorMessage(playerid, "You can't spectate yourself.");

        if(Player[playerb][AdminLevel] >= 4)
        {
            SendClientMessageEx(playerb, COLOR_LIGHTRED, "WARNING: %s %s is spectating you.", GetAdminRank(playerid), GetMasterName(playerid));
        }

        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
        {
            new Float:health,Float:armour,Float:x, Float:y, Float:z,world = GetPlayerVirtualWorld(playerid), interior = GetPlayerInterior(playerid);
            GetPlayerPos(playerid,x,y,z); GetPlayerHealth(playerid,health); GetPlayerArmour(playerid,armour);
            SetPVarFloat(playerid,"MarkX",x);
            SetPVarFloat(playerid,"MarkY",y);
            SetPVarFloat(playerid,"MarkZ",z);
            SetPVarFloat(playerid, "Health", health);
            SetPVarFloat(playerid, "Armour", armour);
            SetPVarInt(playerid, "Int", interior);
            SetPVarInt(playerid, "World", world);
        }
        
        SetPlayerInterior(playerid, GetPlayerInterior(playerb));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));

        TogglePlayerSpectating(playerid, true);
        if(IsPlayerInAnyVehicle(playerb))
        {
            PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerb));
        }
        else
        {
            PlayerSpectatePlayer(playerid, playerb);
        }

        TempVar[playerid][Spectating] = playerb; 
        SendClientMessageEx(playerid, COLOR_LIGHTRED, "** {FFFF00}You're now spectating %s. To stop, use \"/spec off\" to stop spectating.", GetUserName(playerb));
        
    }
	return 1;
}
alias:spec("awp");