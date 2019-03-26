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

new TutorialStage[MAX_PLAYERS], TutorialTimer[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    for(new i; i < MAX_CHARACTERS; i++)
    {
        CharacterNames[playerid][i][0] = 0;
    }
	CurrentCharacters[playerid] = 0;
    TutorialStage[playerid] = 0;
    TutorialTimer[playerid] = 0;
    return 1;
}

stock StartCharacterCreation(playerid)
{
    if(TempVar[playerid][IsLoggedIn] == true)
    {
        // Show dialogs for character creation
        SendClientMessage(playerid, COLOR_YELLOW2, "We will now go through the character creation process.");

        Dialog_Show(playerid, DIALOG_CHARACTER_NAME, DIALOG_STYLE_INPUT, "DC-RP Character Creation - Character Name", "{FFFFFF}What is the name of your character?\n\n\
        {FF6347}[WARNING] {FFFFFF}The name must be in a Firstname_Lastname format\n\
        For example: \"John_Doe\" (without quotes).", "Continue", "Cancel");    
    }
}

Dialog:DIALOG_CHARACTER_NAME(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(IsRPName(inputtext) == 0)
        {
            Dialog_Show(playerid, DIALOG_CHARACTER_NAME, DIALOG_STYLE_INPUT, "DC-RP Character Creation - Character Name", "{FFFFFF}What is the name of your character?\n\n\
            {FF6347}[WARNING] {FFFFFF}The name must be in a Firstname_Lastname format\n\
            For example: \"John_Doe\" (without quotes).", "Continue", "Cancel");
            return 1;
        }

        format(characterName[playerid], MAX_PLAYER_NAME, "%s", inputtext);

        Dialog_Show(playerid, DIALOG_CHARACTER_ORIGIN, DIALOG_STYLE_INPUT, "DC-RP Character Creation - Origin", "{FFFFFF}Where is your character from?\n\
        For example: Fort Carson, San Andreas or London, United Kingdom.", "Continue", "Cancel");
    }
    return 1;
}

Dialog:DIALOG_CHARACTER_ORIGIN(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        format(characterOrigin[playerid], 128, "%s", inputtext);

        Dialog_Show(playerid, DIALOG_CHARACTER_GENDER, DIALOG_STYLE_MSGBOX, "DC-RP Character Creation - Select Gender", "{FFFFFF}What is your characters gender?\n\
        Please select either {F5DEB3}\"Male\"{FFFFFF} or {F5DEB3}\"Female\"{FFFFFF}.", "Male", "Female");
    }
    else Kick(playerid);
    return 1;
}

Dialog:DIALOG_CHARACTER_DAY(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        format(characterOrigin[playerid], 128, "%s", inputtext);

        Dialog_Show(playerid, DIALOG_CHARACTER_GENDER, DIALOG_STYLE_MSGBOX, "DC-RP Character Creation - Select Gender", "{FFFFFF}What is your characters gender?\n\
        Please select either {F5DEB3}\"Male\"{FFFFFF} or {F5DEB3}\"Female\"{FFFFFF}.", "Male", "Female");
    }
    else Kick(playerid);
    return 1;
}

Dialog:DIALOG_CHARACTER_GENDER(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        characterGender[playerid] = true;
        SendClientMessage(playerid, COLOR_YELLOW2, "Alright, so you're a male!");
        ShowModelSelectionMenu(playerid, maleList, "Select Skin");
    }
    else
    {
        characterGender[playerid] = false;
        SendClientMessage(playerid, COLOR_YELLOW2, "Alright, so you're a female!");
        ShowModelSelectionMenu(playerid, femaleList, "Select Skin");
    }
    return 1;
}

Dialog:DIALOG_CHARACTER_SPAWN(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        characterSpawn[playerid] = 1;
    }
    else
    {
        characterSpawn[playerid] = 2;
    }
    
    new string[256];
    mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `characters` (`OwnerID`, `Name`, `Spawn`, `Skin`, `Money`, `Level`, `Origin`)\
    VALUE (%d, '%e', %d, %d, 500, 1, '%e')", Player[playerid][ID], characterName[playerid], characterSpawn[playerid], characterSkin[playerid], characterOrigin[playerid]);
    print(string);
    mysql_tquery(g_SQL, string, "OnCreateCharacter", "d", playerid);
    return 1;
}

function OnCreateCharacter(playerid)
{
    ClearChat(playerid, 10);
    SetPlayerName(playerid, characterName[playerid]);
    SetPlayerPosEx(playerid, -152.2196,1088.0068,19.7422);
    SetPlayerFacingAngle(playerid, 0);

    SetSkin(playerid, characterSkin[playerid]);
    SetCameraBehindPlayer(playerid);
    SetPlayerHealthEx(playerid, 99.0);

    PlayerInfo[playerid][pSkin] = characterSkin[playerid];
    PlayerInfo[playerid][pMoney] = 500;
    PlayerInfo[playerid][pLevel] = 1;
    format(PlayerInfo[playerid][pName], MAX_PLAYER_NAME, "%s", characterName[playerid]);
    format(PlayerInfo[playerid][pOrigin], MAX_PLAYER_NAME, "%s", characterOrigin[playerid]);
    GivePlayerMoney(playerid, 500);
    SetPlayerScore(playerid, 1);
    TogglePlayerControllable(playerid, true);
    StartTutorial(playerid);
    return 1;
}

ptask TutTimer[1000](playerid)
{
    if(TutorialTimer[playerid] > 0)
    {
        TutorialTimer[playerid]--;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(TutorialStage[playerid] > 0 && RELEASED(KEY_SPRINT))
    {
        if(TutorialTimer[playerid] >= 1)
            return SendErrorMessage(playerid, "Please read the tutorial.");

        switch(TutorialStage[playerid])
        {
            case 1:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -203.0767, 1171.8337, 60.7462);
                SetPlayerCameraLookAt(playerid, -203.0387, 1172.8298, 59.8112);

                TutorialStage[playerid] = 2;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Starting Out:");
                SendClientMessage(playerid, COLOR_GRAD5, "The first thing we advice is to get a driving license at the DMV. This means that you can legally drive a car.");
                SendClientMessage(playerid, COLOR_GRAD4, "The DMV is located at the top of Main Street.");
                SendClientMessage(playerid, COLOR_GRAD3, "All you need to do is to enter one of the cars and type /drivingexam in order to start the DMV test.");
            }
            case 2:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -151.1521, 1115.2355, 40.3742);
                SetPlayerCameraLookAt(playerid, -151.1627, 1114.2393, 39.7243);

                TutorialStage[playerid] = 3;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Getting Around:");
                SendClientMessage(playerid, COLOR_GRAD5, "Getting around can be done in many ways, you can get a taxi or purchase a car at the dealership.");
                SendClientMessage(playerid, COLOR_GRAD4, "The Taxi stand is located near where you will first spawn and there are dealerships all over Bone County.");
                SendClientMessage(playerid, COLOR_GRAD3, "You can call for a taxi using \"/call 544\" or \"/payphone 544\".");
            }
            case 3:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -247.5549, 1173.9003, 46.3746);
                SetPlayerCameraLookAt(playerid, -247.5739, 1174.8965, 45.7346);

                TutorialStage[playerid] = 4;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Businesses:");
                SendClientMessage(playerid, COLOR_GRAD5, "You can buy new clothes or accessories at a Clothes Store. There is a clothes store at Main Street.");
                SendClientMessage(playerid, COLOR_GRAD4, "Buying new clothes or accessories allows you to spice up your character to how you want them to look.");
                SendClientMessage(playerid, COLOR_GRAD3, "You should also buy a mobile phone at a 24/7 so you can keep connected as you do not spawn with a phone.");
                SendClientMessage(playerid, COLOR_GRAD2, "You can also buy a business if you want to earn money or use as a legal front for your illegal activities.");
            }
            case 4:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -265.3655, 1192.1720, 47.8634);
                SetPlayerCameraLookAt(playerid, -265.5934, 1191.2024, 47.2384);

                TutorialStage[playerid] = 5;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Houses:");
                SendClientMessage(playerid, COLOR_GRAD5, "There are houses scattered all over Bone County which can range from simple trailers, apartments or proper houses.");
                SendClientMessage(playerid, COLOR_GRAD4, "You can also rent some houses as well if you cannot afford to purchase a house.");
                SendClientMessage(playerid, COLOR_GRAD3, "When you buy a house, you can choose to spawn their with /setspawn. This will be done automatically if you rent a house.");
            }
            case 5:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, 309.7894, 1146.2264, 11.6930);
                SetPlayerCameraLookAt(playerid, 308.8099, 1146.0463, 11.4781);

                TutorialStage[playerid] = 6;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Jobs:");
                SendClientMessage(playerid, COLOR_GRAD5, "There are many jobs on the server such as: Taxi Driver, Mechanic, Bus Driver, Farmer and Trucker.");
                SendClientMessage(playerid, COLOR_GRAD4, "You can find these jobs by typing \"/findjob\" which will show a dialog of all jobs.");
                SendClientMessage(playerid, COLOR_GRAD3, "If you do not have a job, you will recieve a government handout to keep you on your feet.");
            }
            case 6:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, 108.6284, 1199.6929, 48.9670);
                SetPlayerCameraLookAt(playerid, 107.8720, 1199.0448, 48.2020);

                TutorialStage[playerid] = 7;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Factions:");
                SendClientMessage(playerid, COLOR_GRAD5, "There are 3 government factions: Bone County Sheriff's Dept, Bone County Fire Dept and Bone County Government.");
                SendClientMessage(playerid, COLOR_GRAD4, "There are also an array of Gangs and other illegal factions on the server as well if you are interested in that.");
                SendClientMessage(playerid, COLOR_GRAD3, "You can find out of all the current factions by using \"/factions\" which will show a list of offical factions.");
            }
            case 7:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -185.6718, 1169.2560, 21.6371);
                SetPlayerCameraLookAt(playerid, -185.0636, 1168.4658, 21.3172);

                TutorialStage[playerid] = 8;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Advertising:");
                SendClientMessage(playerid, COLOR_GRAD5, "Advertising is an important way to make people aware of your current goods or services which you have on offer.");
                SendClientMessage(playerid, COLOR_GRAD4, "Advertisements go through a queue which shows an advertisement every minute, you can only have 1 on the queue unless you donate.");
                SendClientMessage(playerid, COLOR_GRAD3, "An alternative way is to let people know through other in character methods such as talking to people or using the forums.");
            }
            case 8:
            {
                ClearChat(playerid, 20);

                SetPlayerCameraPos(playerid, -300.5721, 801.0477, 100.7206);
                SetPlayerCameraLookAt(playerid, -299.9347, 801.8139, 100.4806);

                TutorialStage[playerid] = 9;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Server Rules:");
                SendClientMessage(playerid, COLOR_GRAD5, "This server is a heavy roleplay server and we will be enforcing the rules as such. We do not tolerate trolling or nonsense");
                SendClientMessage(playerid, COLOR_GRAD4, "Cheating is also futile as we have detection for the vast majority of cheats out there, even some of the more obscure ones.");
                SendClientMessage(playerid, COLOR_GRAD3, "If you catch someone rulebreaking, you should /report (/re) them so an administrator can resolve the situation.");
            }
            case 9:
            {
                ClearChat(playerid, 20);

                TutorialStage[playerid] = 10;
                TutorialTimer[playerid] = 5;
                SendClientMessage(playerid, COLOR_YELLOW2, "Server Staff:");
                SendClientMessage(playerid, COLOR_GRAD5, "The staff team here contains Helpers, Administrators, Developers and Server Management.");
                SendClientMessage(playerid, COLOR_GRAD4, "Helpers are the people that respond to /helpme's and deal with new applicants.");
                SendClientMessage(playerid, COLOR_GRAD3, "Administrators deal with /report's and rulebreakers. Developers develop the gamemode and website");
                SendClientMessage(playerid, COLOR_GRAD2, "Server Management keep the server running by managing the server and making important decisions");
            }
            case 10:
            {
                ClearChat(playerid, 20);
                TutorialStage[playerid] = 11;
                TutorialTimer[playerid] = 0;
                Player[playerid][PassedTutorial] = 1;
                Player[playerid][IsLoggedIn] = true;
                new string[70];
                mysql_format(g_SQL, string, sizeof string, "UPDATE `players` SET `IsLoggedIn` = 1 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
                mysql_tquery(g_SQL, string);
                TogglePlayerSpectating(playerid, false);
                SetTimerEx("FixTutorial", 100, false, "d", playerid);
            }
        }
    }
    return 1;
}

function FixTutorial(playerid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
    {
        TogglePlayerSpectating(playerid, false);
    }
}

stock StartTutorial(playerid)
{
    ClearChat(playerid, 10);

    TogglePlayerSpectating(playerid, true);
    SetPlayerCameraPos(playerid, -203.2384, 1152.0148, 112.4420);
    SetPlayerCameraLookAt(playerid, -203.7769, 1151.1758, 111.4170);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

    TutorialStage[playerid] = 1;
    SendClientMessage(playerid, COLOR_YELLOW2, "Introduction:");
    SendClientMessage(playerid, COLOR_GRAD5, "Welcome to United Gaming Roleplay. This tutorial will guide you through the basics of our server.");
    SendClientMessageEx(playerid, COLOR_GRAD4, "Use {%06x}~k~~PED_SPRINT~{%06x} to go forward in the tutorial.", COLOR_YELLOW2 >>> 8, COLOR_GRAD4 >>> 8);
}

function OnSetName(adminid, playerid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(adminid))
    {
        new string[256], name[MAX_PLAYER_NAME];
        GetPVarString(playerid, "OnSetName", name, sizeof name);
        format(string, sizeof string, "%s %s has changed %s's name to %s.", GetAdminRank(adminid), GetMasterName(adminid), GetUserName(playerid), name);
        SendAdminWarning(3, string);
        format(PlayerInfo[playerid][pName], MAX_PLAYER_NAME, name);
        SetPlayerName(playerid, name);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Name` = '%e' WHERE `CharacterID` = %d LIMIT 1", name, PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
        SendClientMessageEx(playerid, COLOR_YELLOW, "Your name has been set to %s by %s %s", PlayerInfo[playerid][pName], GetAdminRank(adminid), GetMasterName(adminid));
    }
    return 1;
}

function OnSetAccountName(adminid, playerid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(adminid))
    {
        new string[128], name[MAX_PLAYER_NAME];
        GetPVarString(adminid, "OnSetName", name, sizeof name);
        format(string, sizeof string, "%s %s has changed %s's master name to %s.", GetAdminRank(adminid), GetMasterName(adminid), GetMasterName(playerid), name);
        SendAdminWarning(3, string);
        format(Player[playerid][Name], MAX_PLAYER_NAME, "%s", name);
        UpdatePlayerData(playerid);
        SendClientMessageEx(playerid, COLOR_YELLOW, "Your master name has been set to %s by %s %s", Player[playerid][Name], GetAdminRank(adminid), GetMasterName(adminid));
    }
    return 1;
}