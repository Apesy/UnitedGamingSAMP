//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_ROADBLOCKS 20

enum roadblockEnum
{
    rModelID,
    Float:rX,
    Float:rY,
    Float:rZ,
    Float:rRX,
    Float:rRY,
    Float:rRZ,
    rObjectID
};
new Roadblocks[MAX_ROADBLOCKS][roadblockEnum];

stock CreateRoadblock(playerid, modelid, Float:x, Float:y, Float:z, Float:a)
{
    for(new i; i < sizeof(Roadblocks); i++)
    {
        if(!IsValidDynamicObject(Roadblocks[i][rObjectID]))
        {
            Roadblocks[i][rX] = x;
            Roadblocks[i][rY] = y;
            Roadblocks[i][rZ] = z;
            Roadblocks[i][rRZ] = a;
            Roadblocks[i][rObjectID] = CreateDynamicObject(modelid, x, y+2.5, z+0.5, 0, 0, a);
            TempVar[playerid][EditingRoadblock] = i;
            TempVar[playerid][EditType] = EDIT_TYPE_EDIT_ROADBLOCK;
            EditDynamicObject(playerid, Roadblocks[i][rObjectID]);
            return 1;
        }
    }
    return 1;
}

CMD:editroadblock(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 1)
    {
        TempVar[playerid][SelectType] = SELECT_TYPE_EDIT_ROADBLOCK;
        SelectObject(playerid);
    }
    return 1;
}

CMD:flare(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 1)
    {
        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        CreateRoadblock(playerid, 18728, x, y, z, a);
    }
    return 1;
}

CMD:cone(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 1)
    {
        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        CreateRoadblock(playerid, 1238, x, y, z, a);
    }
    return 1;
}

CMD:disband(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 1)
    {
        TempVar[playerid][SelectType] = SELECT_TYPE_DELETE_ROADBLOCK;
        SelectObject(playerid);
    }
    return 1;
}

CMD:disbandroadblocks(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new string[128];
        for(new i; i < sizeof(Roadblocks); i++)
        {
            if(IsValidDynamicObject(Roadblocks[i][rObjectID]))
            {
                Roadblocks[i][rX] = 0;
                Roadblocks[i][rY] = 0;
                Roadblocks[i][rZ] = 0;
                Roadblocks[i][rRX] = 0;
                Roadblocks[i][rRY] = 0;
                Roadblocks[i][rRZ] = 0;
                DestroyDynamicObject(Roadblocks[i][rObjectID]);
            }
        }
        format(string, sizeof string, "%s %s has removed all roadblocks.", GetAdminRank(playerid), GetMasterName(playerid));
        SendAdminCommand(string);
    }
    return 1;
}

stock RoadblockMenu(playerid)
{
    Dialog_Show(playerid, RoadblockMain, DIALOG_STYLE_LIST, "Roadblocks", "Place\nEdit Roadblock\nDisband Roadblock", "Continue", "Quit");
}

CMD:roadblock(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDeploy] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    RoadblockMenu(playerid);
    return 1;
}

Dialog:RoadblockMain(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: 
            {
                Dialog_Show(playerid, RoadblockPlace, DIALOG_STYLE_LIST, "Roadblocks", "Traffic Cone\n\
                    Roadblock\n\
                    Detour Sign\n\
                    Small Barrier\n\
                    Medium Barrier\n\
                    Large Barrier\n\
                    Gate\n\
                    Large Gate\n\
                    Road Stop\n\
                    Work Zone\n\
                    Road Closed\n\
                    Left Chevron\n\
                    Right Chevron\n\
                    Speed Camera Sign", "Continue", "Back");
            } 
            case 1:
            {
                pc_cmd_editroadblock(playerid, "");
            }
            case 2:
            {
                pc_cmd_disband(playerid, "");
            }
        }
    }
    return 1;
}

Dialog:RoadblockPlace(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        switch(listitem)
        {
            case 0: CreateRoadblock(playerid, 1238, x, y, z, a);
            case 1: CreateRoadblock(playerid, 1427, x, y, z, a);
            case 2: CreateRoadblock(playerid, 1425, x, y, z, a);
            case 3: CreateRoadblock(playerid, 1424, x, y, z, a);
            case 4: CreateRoadblock(playerid, 978, x, y, z, a);
            case 5: CreateRoadblock(playerid, 8674, x, y, z, a);
            case 6: CreateRoadblock(playerid, 7657, x, y, z, a);
            case 7: CreateRoadblock(playerid, 981, x, y, z, a);
            case 8: CreateRoadblock(playerid, 19975, x, y, z, a);
            case 9: CreateRoadblock(playerid, 19972, x, y, z, a);
            case 10: CreateRoadblock(playerid, 19953, x, y, z, a);
            case 11: CreateRoadblock(playerid, 19954, x, y, z, a);
            case 12: CreateRoadblock(playerid, 19979, x, y, z, a);
        }
    }
    else RoadblockMenu(playerid);
    return 1;
}