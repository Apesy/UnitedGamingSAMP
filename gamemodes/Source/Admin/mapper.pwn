//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
#define COLOR_MAPPER 0xF19CBBFF

CMD:developerhelp(playerid, params[])
{
    if(Player[playerid][Mapper] >= 1)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Developer Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /st (staff chat)");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    else SendErrorMessage(playerid, "You are not a developer.");
    return 1;
}

CMD:setdeveloper(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetID;
        if(sscanf(params, "u", targetID))
            return SendUsageMessage(playerid, "/setdeveloper [PlayerID/PartOfName]");

        if(!IsPlayerConnected(targetID))
            return SendErrorMessage(playerid, "Invalid PlayerID/PartOfName specified.");

        if(Player[targetID][Mapper] == 0)
        {
            Player[targetID][Mapper] = 1;
            SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been made a Developer by %s.", GetMasterName(playerid));
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have made %s a Developer.", GetMasterName(targetID));
        }
        else
        {
            Player[targetID][Mapper] = 0;
            SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been removed as a Developer by %s.", GetMasterName(playerid));
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have removed %s as a Developer.", GetMasterName(targetID));
        }
        UpdatePlayerData(targetID);
    }
    return 1;
}