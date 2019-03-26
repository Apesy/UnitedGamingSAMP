//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock ShowLumberjackCmds(playerid)
{
    SendClientMessage(playerid, COLOR_GRAD1, "[LUMBERJACK] /jobduty, /getequipment, /cutdown, /cutlogs, /deliverlogs");
}

CMD:getequipment(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 1)
    {
        if(TempVar[playerid][JobDuty] == false)
            return SendErrorMessage(playerid, "You are not on duty. (/jobduty)");

        GivePlayerGun(playerid, 9, 1);
    }
    else SendErrorMessage(playerid, "You are not a lumberjack.");
    return 1;
}

CMD:cutdown(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 1)
    {
        if(TempVar[playerid][JobDuty] == false)
            return SendErrorMessage(playerid, "You are not on duty. (/jobduty)");
        
        for(new i; i < sizeof(LumberjackTree); i++)
        {
            new Float:pos[3];
            GetDynamicObjectPos(LumberjackTree[i], pos[0], pos[1], pos[2]);
            if(IsPlayerInRangeOfPoint(playerid, 5, pos[0], pos[1], pos[2]))
            {
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Cutting Tree...", 2000, 3);
                SetTimerEx("LumberjackTimer", 2000, false, "d", playerid);
                TogglePlayerControllable(playerid, false);
                break;
            }
            else SendErrorMessage(playerid, "You are not near a tree.");
        }
    }
    return 1;
}

function LumberjackTimer(playerid)
{
    TempVar[playerid][LumberLogging] = true;
    TogglePlayerControllable(playerid, true);
    SendErrorMessage(playerid, "The tree has now been cut. Use /cutlogs now to cut it into logs.");
    return 1;
}

CMD:cutlogs(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 1)
    {
        if(TempVar[playerid][JobDuty] == false)
            return SendErrorMessage(playerid, "You are not on duty. (/jobduty)");
        
        for(new i; i < sizeof(LumberjackTree); i++)
        {
            new Float:pos[3];
            GetDynamicObjectPos(LumberjackTree[i], pos[0], pos[1], pos[2]);
            if(IsPlayerInRangeOfPoint(playerid, 5, pos[0], pos[1], pos[2]))
            {
                GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Cutting Tree...", 2000, 3);
                SetTimerEx("LumberjackTimer", 2000, false, "d", playerid);
                TogglePlayerControllable(playerid, false);
                break;
            }
            else SendErrorMessage(playerid, "You are not near a tree.");
        }
    }
    return 1;
}

