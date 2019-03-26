//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
#define NAMETAG_DISTANCE 15.0

new Text3D:NameTag[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    NameTag[playerid] = CreateDynamic3DTextLabel("Loading", 0xFFFFFFFF, 0.0, 0.0, 0.10, NAMETAG_DISTANCE, .attachedplayer = playerid, .testlos = 1);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsValidDynamic3DTextLabel(NameTag[playerid]))
        DestroyDynamic3DTextLabel(NameTag[playerid]);
    return 1;
}

stock GetHealthDots(playerid)
{
    new dots[64];
    new Float:HP;
 
    GetPlayerHealth(playerid, HP);
 
    if(HP == 100)
        dots = "||||||||||";
    else if(HP >= 90 && HP < 100)
        dots = "|||||||||{660000}|";
    else if(HP >= 80 && HP < 90)
        dots = "||||||||{660000}||";
    else if(HP >= 70 && HP < 80)
        dots = "|||||||{660000}|||";
    else if(HP >= 60 && HP < 70)
        dots = "||||||{660000}||||";
    else if(HP >= 50 && HP < 60)
        dots = "|||||{660000}|||||";
    else if(HP >= 40 && HP < 50)
        dots = "||||{660000}||||||";
    else if(HP >= 30 && HP < 40)
        dots = "|||{660000}|||||||";
    else if(HP >= 20 && HP < 30)
        dots = "||{660000}||||||||";
    else if(HP >= 10 && HP < 20)
        dots = "|{660000}|||||||||";
    else if(HP >= 0 && HP < 10)
        dots = "{660000}||||||||||";
 
    return dots;
}

stock GetArmourDots(playerid)
{
    new dots[64];
    new Float:HP;
 
    GetPlayerArmour(playerid, HP);
 
    if(HP == 100)
        dots = "||||||||||";
    else if(HP >= 90 && HP < 100)
        dots = "|||||||||{666666}|";
    else if(HP >= 80 && HP < 90)
        dots = "||||||||{666666}||";
    else if(HP >= 70 && HP < 80)
        dots = "|||||||{666666}|||";
    else if(HP >= 60 && HP < 70)
        dots = "||||||{666666}||||";
    else if(HP >= 50 && HP < 60)
        dots = "|||||{666666}|||||";
    else if(HP >= 40 && HP < 50)
        dots = "||||{666666}||||||";
    else if(HP >= 30 && HP < 40)
        dots = "|||{666666}|||||||";
    else if(HP >= 20 && HP < 30)
        dots = "||{666666}||||||||";
    else if(HP >= 10 && HP < 20)
        dots = "|{666666}|||||||||";
    else if(HP >= 0 && HP < 10)
        dots = "{666666}||||||||||";
 
    return dots;
}

ptask UpdateNametag[500](playerid)
{
    new nametag[128];
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        if(TempVar[playerid][AFKSeconds] >= 2)
        {
            format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%d) {FF0000}[AFK]\n{FF0000}%s", GetPlayerColor(playerid) >>> 8, GetMasterName(playerid), playerid);
        }
        else format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%d)\n{FF0000}%s", GetPlayerColor(playerid) >>> 8, GetMasterName(playerid), playerid);
    }
    else
    {
        if(TempVar[playerid][AFKSeconds] >= 2)
        {
            format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%d) {FF0000}[AFK]\n{FF0000}%s", GetPlayerColor(playerid) >>> 8, GetRPName(playerid), playerid);
        }
        else format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%d)\n{FF0000}%s", GetPlayerColor(playerid) >>> 8, GetRPName(playerid), playerid);
    }
    UpdateDynamic3DTextLabelText(NameTag[playerid], 0xFFFFFFFF, nametag);
    return 1;
}