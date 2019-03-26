//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

function VehicleUpgradeCommand(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You are not in any vehicle.");
    
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "You are not in the driving seat.");
    
    new vehicleid = GetPlayerVehicleID(playerid), vehicle = GetVehicleID(vehicleid);

    if(VehicleInfo[vehicle][vFactionID] > 0)
        return SendErrorMessage(playerid, "You cannot do this to faction vehicles.");

    if(VehicleInfo[vehicle][vOwnerID] != PlayerInfo[playerid][pCharacterID])
        return SendErrorMessage(playerid, "You have to be the owner of this vehicle.");
    
    
    return 1;
}