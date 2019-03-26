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

new bool:RequestingNameChange[MAX_PLAYERS],
    RequestingNameChangeName[MAX_PLAYERS][MAX_PLAYER_NAME+1];

hook OnPlayerConnect(playerid)
{
    RequestingNameChange[playerid] = false;
    RequestingNameChangeName[playerid][0] = 0;
    return 1;
}

CMD:help(playerid, params[])
{
    Dialog_Show(playerid, DIALOG_HELP_MAIN, DIALOG_STYLE_LIST, "Help Menu", "Account\nGeneral\nChat\nPhone\nHouse\nBusiness\nJob\nFaction\nAdministrator\nHelper\nBeta Tester", "Select", "Close");
	return 1;
}

CMD:gps(playerid, params[])
{
    Dialog_Show(playerid, GPS_Main, DIALOG_STYLE_LIST, "Choose an option", "Business\nJobs\nPublic Services\nDealerships", "Select", "Close");
    return 1;
}

new GPS_BusinessID[MAX_PLAYERS][20];
Dialog:GPS_Main(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new string[128*20], count = 0;
                SendServerMessage(playerid, "Listing 20 businesses within 500 meters.");
                for(new i; i < MAX_BIZ; i++)
                {
                    if(count > 20) break;
                    if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 500.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
                    {
                        GPS_BusinessID[playerid][count] = i;
                        format(string, sizeof string, "%s%s\n", string, BusinessInfo[i][BizName]);
                        count++;
                    }
                }
                if(count > 0)
                {
                    Dialog_Show(playerid, GPS_Business, DIALOG_STYLE_LIST, "Businesses", string, "Select", "Back");
                }
                else SendErrorMessage(playerid, "There are no businesses nearby.");
            }
            case 1:
            {
                pc_cmd_findjob(playerid, "\0");
            }
            case 2:
            {
                Dialog_Show(playerid, GPS_PublicService, DIALOG_STYLE_LIST, "Public Services", "Bone County Sheriffs Dept\n\
                Fort Carson Hospital\n\
                Fort Carson Town Hall", "Select", "Back");
            }
            case 3:
            {
                new string[128*20], count = 0;
                SendServerMessage(playerid, "Listing 20 dealerships within 200 meters.");
                for(new i = 1; i < MAX_DEALERS; i++)
                {
                    if(count > 20) break;
                    if(BusinessInfo[i][BizID] > 0 && IsPlayerInRangeOfPoint(playerid, 200.0, DealershipInfo[i][DealerPosX], DealershipInfo[i][DealerPosY], DealershipInfo[i][DealerPosZ]))
                    {
                        GPS_BusinessID[playerid][count] = i;
                        format(string, sizeof string, "%s%s\n", string, DealershipInfo[i][DealerName]);
                        count++;
                    }
                }
                if(count > 0)
                {
                    Dialog_Show(playerid, GPS_Dealers, DIALOG_STYLE_LIST, "Vehicle Dealerships", string, "Select", "Back");
                }
                else SendErrorMessage(playerid, "There are no businesses nearby.");
            }
        }
    }
    return 1;
}

Dialog:GPS_Dealers(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = GPS_BusinessID[playerid][listitem];
        if(DealershipInfo[i][DealerID] > 0)
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, DealershipInfo[i][DealerPosX], DealershipInfo[i][DealerPosY], DealershipInfo[i][DealerPosZ], 10.0);
            TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_GPS;
            SendServerMessage(playerid, "GPS point set for %s.", DealershipInfo[i][DealerName]);
        }
    }
    return 1;
}

Dialog:GPS_PublicService(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, 71.4874,1193.1527,18.6697, 10.0);
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_GPS;
                SendServerMessage(playerid, "GPS point set for Bone County Sheriff's Dept.");
            }
            case 1:
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, -315.5881,1061.3363,19.5938, 10.0);
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_GPS;
                SendServerMessage(playerid, "GPS point set for Fort Carson Hospital.");
            }
            case 2:
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, -200.3010,1117.8866,19.5971, 10.0);
                TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_GPS;
                SendServerMessage(playerid, "GPS point set for Fort Carson Town Hall.");
            }
        }
    }
    return 1;
}

Dialog:GPS_Business(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = GPS_BusinessID[playerid][listitem];
        if(BusinessInfo[i][BizID] > 0)
        {
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ], 10.0);
            TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_GPS;
            SendServerMessage(playerid, "GPS point set for %s.", BusinessInfo[i][BizName]);
        }
    }
    return 1;
}

CMD:namechange(playerid, params[])
{
    Dialog_Show(playerid, Name_Change, DIALOG_STYLE_INPUT, "Name Change", "Insert the new name you want.\nMust be in a Firstname_Lastname format.", "Request", "Cancel");
	return 1;
}

/*CMD:phchange(playerid, params[])
{
    Dialog_Show(playerid, Phone_Change, DIALOG_STYLE_INPUT, "Phone Change", "Insert the new number you want.\nMust be in a numerical format.", "Request", "Cancel");
	return 1; 
}

Dialog:Phone_Change(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!IsNumeric(inputtext))
            return SendErrorMessage(playerid, "You cannot choose an numeric phone number");

        mysql_format(g_SQL, query, sizeof(query), "SELECT `Name` FROM `characters` WHERE `Name`= '%e' LIMIT 1", tmpName);
        mysql_tquery(g_SQL, query, "CheckNC", "is", playerid, inputtext);
    }
    return 1;
}*/

CMD:approvenc(playerid,params[])
{
    if(IsHelperLevel(playerid, 1, false) || IsAdminLevel(playerid, 4, false))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/approvenc [PlayerID/PartOfName]");

        if(!IsPlayerConnected(playerid))
            return SendErrorMessage(playerid, "No such player connected.");
        
        if(RequestingNameChange[playerid] == false)
            return SendErrorMessage(playerid, "This player is not requesting a name change.");

        SetPVarString(targetid, "OnSetName", RequestingNameChangeName[targetid]);

        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE `characters` SET `Name` = '%e' WHERE `CharacterID`= '%d' LIMIT 1", RequestingNameChangeName[targetid], PlayerInfo[targetid][pCharacterID]);
        mysql_tquery(g_SQL, query, "OnNCSetName", "i", targetid);
    }
    else SendErrorMessage(playerid, "No.");
    return 1;
}

function OnNCSetName(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new name[MAX_PLAYER_NAME], string[256];
        GetPVarString(playerid, "OnSetName", name, sizeof name);
        format(PlayerInfo[playerid][pName], MAX_PLAYER_NAME, name);
        SetPlayerName(playerid, name);
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Name` = '%e' WHERE `CharacterID` = %d LIMIT 1", name, PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
        SendClientMessageEx(playerid, COLOR_YELLOW, "Your name change has been approved.");
    }
    return 1;
}

CMD:denync(playerid,params[])
{
    if(IsHelperLevel(playerid, 1, false) || IsAdminLevel(playerid, 4, false))
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/denync [PlayerID/PartOfName]");
        
        if(!IsPlayerConnected(playerid))
            return SendErrorMessage(playerid, "No such player connected.");
        
        if(RequestingNameChange[playerid] == false)
            return SendErrorMessage(playerid, "This player is not requesting a name change.");
        
        RequestingNameChange[playerid] = false;
        RequestingNameChangeName[playerid][0] = 0;
        SendServerMessage(playerid, "Your namechange was denied.");
    }
    else SendErrorMessage(playerid, "No.");
    return 1;
}

Dialog:Name_Change(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!IsRPName(inputtext))
            return SendErrorMessage(playerid, "You cannot choose a Non-RP name");

        if(strlen(inputtext) < 5)
            return SendErrorMessage(playerid, "You can't select a name that's below 5 characters.");

        if(strlen(inputtext) > MAX_PLAYER_NAME)
            return SendErrorMessage(playerid, "You can't select a name that's above %d characters.", MAX_PLAYER_NAME);

        new query[128], tmpName[32];
        mysql_escape_string(inputtext, tmpName, sizeof(tmpName));
        if(strcmp(inputtext, tmpName, false) == 0)
        {
            mysql_format(g_SQL, query, sizeof(query), "SELECT `Name` FROM `characters` WHERE `Name`= '%e' LIMIT 1", tmpName);
            mysql_tquery(g_SQL, query, "CheckNC", "is", playerid, inputtext);

            /*SetPVarString(giveplayerid, "OnSetName", tmpName);

            mysql_format(g_SQL, query, sizeof(query), "UPDATE `characters` SET `Name` = '%e' WHERE `CharacterID`= '%d' LIMIT 1", tmpName, PlayerInfo[playerid][pCharacterID]);
            mysql_tquery(g_SQL, query, "OnNCSetName", "i", playerid);*/
        }
        else return SendErrorMessage(playerid, "Invalid characters!");
    }
    return 1;
}

function CheckNC(playerid, inputtext[])
{
    if(cache_num_rows() == 0)
    {
        RequestingNameChange[playerid] = true;
        format(RequestingNameChangeName[playerid], MAX_PLAYER_NAME+1, "%s", inputtext);
        SendHelperMessage(COLOR_LIGHTBLUE, 1, "[NAMECHANGE]: {FFFF00}%s (%d) is requesting a namechange to '%s'", GetUserName(playerid), playerid, RequestingNameChangeName[playerid]);
        SendServerMessage(playerid, "Your namechange request was sent to online helpers.");
    }
    else SendErrorMessage(playerid, "Someone with that name already exists.");
    return 1;
}

CMD:activate(playerid, params[])
{
    Dialog_Show(playerid, Donate_Activate, DIALOG_STYLE_INPUT, "Donator Activate", "Activate your donator item using the Activation Code as found on the UCP.", "Activate", "Cancel");
	return 1; 
}

Dialog:Donate_Activate(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[256];
        mysql_format(g_SQL, string, sizeof string, "SELECT * FROM `Donator_Items` WHERE `ActivationString` = '%e' LIMIT 1", inputtext);
        mysql_tquery(g_SQL, string, "OnDonatorActivate", "d", playerid);
    }
    return 1;
}

function OnDonatorActivate(playerid)
{
    new rows = cache_num_rows();
    if(rows >= 1)
    {
        new type, id;
        cache_get_value_int(0, "ID", type);
        cache_get_value_int(0, "Type", type);
        switch(type)
        {
            case 1:
            {
                Player[playerid][NameChanges]++;
                SendServerMessage(playerid, "You were given a namechange (/name_change) by the activation code.");
            }
            case 2:
            {
                Player[playerid][NumberChanges]++;
                SendServerMessage(playerid, "You were given a number change (/number_change) by the activation code.");
            }
            case 3:
            {
                Player[playerid][DonateLevel] = 1;
                Player[playerid][DonateExpire] = gettime()+(30*86400);
                SendServerMessage(playerid, "Your donate level was set to %s by the activation code.", GetDonateRank(Player[playerid][DonateLevel]));
                SendServerMessage(playerid, "It is set to expire on %s.", date(Player[playerid][DonateExpire]));
            }
            case 4:
            {
                Player[playerid][DonateLevel] = 2;
                Player[playerid][DonateExpire] = gettime()+(30*86400);
                SendServerMessage(playerid, "Your donate level was set to %s by the activation code.", GetDonateRank(Player[playerid][DonateLevel]));
                SendServerMessage(playerid, "It is set to expire on %s.", date(Player[playerid][DonateExpire]));
            }
            case 5:
            {
                Player[playerid][DonateLevel] = 3;
                Player[playerid][DonateExpire] = gettime()+(30*86400);
                SendServerMessage(playerid, "Your donate level was set to %s by the activation code.", GetDonateRank(Player[playerid][DonateLevel]));
                SendServerMessage(playerid, "It is set to expire on %s.", date(Player[playerid][DonateExpire]));
            }
            default: 
            {
                SendErrorMessage(playerid, "Your donator code is corrupted, make an Account Request at https://dc-rp.com/forum. ReferenceID: #%d", id);
                return 1;
            }
        }
        new string[128];
        mysql_format(g_SQL, string, sizeof string, "DELETE FROM `Donator_Items` WHERE `ID` = %d LIMIT 1", id);
        mysql_tquery(g_SQL, string);
    }
    else
    {
        Dialog_Show(playerid, Donate_Activate, DIALOG_STYLE_INPUT, "Donator Activate", "ERROR: No such code was found.\n\
        Activate your donator item using the Activation Code as found on the UCP.", "Activate", "Cancel");
    }
    return 1;
}

CMD:tow(playerid, params[])
{
    new myveh = GetPlayerVehicleID(playerid);
    if(IsTrailerAttachedToVehicle(myveh)) 
    {
        PrintFooter(playerid, "Trailer detached.");
        DetachTrailerFromVehicle(myveh);
        return 1;
    }

    if(IsPlayerInAnyVehicle(playerid) && GetVehicleModel(myveh) == 525)
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/tow [VehicleID] - Use /dl to get the vehicle ID.");
            return 1;
        }

        if(!IsNumeric(params))
        {
            SendUsageMessage(playerid, "/tow [VehicleID, must be a valid number] - Use /dl to get the vehicle ID.");
            return 1;
        }

        new vehicleid = strval(params);

        if(!IsValidVehicle(vehicleid))
        {
            SendErrorMessage(playerid, "You specified an invalid vehicle.");
            return 1;
        }

        if(!IsPlayerNearVehicle(playerid, vehicleid, 7.0))
        {
            SendErrorMessage(playerid, "You are not close to the specified vehicle. You must be within 7 meters.");
            return 1;
        }

        if(HasNoEngine(vehicleid))
		{
            SendErrorMessage(playerid, "This vehicle doesn't have a engine.");
            return 1;
        }

        AttachTrailerToVehicle(vehicleid, myveh);
        PrintFooter(playerid, "Trailer attached.");
    }
    else SendErrorMessage(playerid, "You need to be inside a tow truck.");
    return 1;
}

CMD:serial(playerid, params[])
{
    new wep = GetPlayerWeapon(playerid);
    if(wep > 3)
    {
        new idx = GetWeaponSlot(wep);
        SendServerMessage(playerid, "Weapon Serial: %d", PlayerInfo[playerid][pSerial][idx]);
    }
	return 1; 
}

CMD:convostop(playerid, params[])
{
    if(TempVar[playerid][PMConvo] != INVALID_PLAYER_ID)
    {
        TempVar[playerid][PMConvo] = INVALID_PLAYER_ID;
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have stopped your PM conversation.");
    }
    return 1;
}

CMD:convo(playerid, params[])
{
    new giveplayerid;
    if(sscanf(params, "u", giveplayerid))
        return SendUsageMessage(playerid, "/convo [PlayerID/PartOfName] - Start a /pm convo without needing to use /pm.");

    TempVar[playerid][PMConvo] = giveplayerid;
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have started a PM conversation with %s (%d).", GetUserName(giveplayerid), giveplayerid);
    return 1;
}

CMD:stats(playerid, params[])
{
    ShowStats(playerid, playerid);
    return 1;
}

CMD:accent(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/accent [Accent Name]"), SendClientMessage(playerid, COLOR_LIGHTRED, "[WARNING]:{FFFFFF} Make sure your accent is realistic, use \"Bone County\" or \"Texas\" instead of \"Hillbilly\" for example.");
    
    if(strlen(params) < 2 || strlen(params) > 32)
        return SendErrorMessage(playerid, "The accent cannot be less than 2 characters or more than 32 characters.");
    
    new string[128];
    format(PlayerInfo[playerid][pAccent], 128, "%s", params);
    SendServerMessage(playerid, "You have set your accent to: %s", params);
    format(string, sizeof string, "%s (%d) has set their accent to: %s", GetUserName(playerid), playerid, params);
    SendAdminWarning(1, string);
    mysql_format(g_SQL, string, sizeof string, "UPDATE `characters` SET `Accent` = '%e' WHERE `CharacterID` = %d LIMIT 1", params, PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
    return 1;
}

CMD:apperance(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/apperance (/attributes) [Apperance/None]"), SendClientMessage(playerid, COLOR_LIGHTRED, "[WARNING]:{FFFFFF} Make sure your apperance is realistic.");
    
    if(strlen(params) < 2 || strlen(params) >= 128)
        return SendErrorMessage(playerid, "The apperance cannot be less than 2 characters or more than 128 characters.");
    
    new string[128];
    format(PlayerInfo[playerid][pApperance], 128, "%s", params);
    SendServerMessage(playerid, "Apperance: %s", params);
    format(string, sizeof string, "%s (%d) has set their apperance: %s", GetUserName(playerid), playerid, params);
    SendAdminWarning(1, string);
    mysql_format(g_SQL, string, sizeof string, "UPDATE `characters` SET `Apperance` = '%e' WHERE `CharacterID` = %d LIMIT 1", params, PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
    return 1;
}
alias:apperance("attributes");

CMD:describe(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/describe (/examine) [PlayerID/PartOfName]");

    if(!IsPlayerNearPlayer(playerid, targetid, 20.0))
        return SendErrorMessage(playerid, "You aren't near that player."); 
    
    if(strlen(PlayerInfo[targetid][pApperance]) < 2)
        return SendErrorMessage(playerid, "That player has not set an apperance. (/apperance)"); 

    if(strlen(PlayerInfo[targetid][pApperance]) > 70)
    {
        SendClientMessageEx(playerid, COLOR_PURPLE, "%s's apperance: %.70s ...", GetRPName(targetid), PlayerInfo[targetid][pApperance]);
        SendClientMessageEx(playerid, COLOR_PURPLE, "%s's apperance: ... %s", GetRPName(targetid), PlayerInfo[targetid][pApperance][70]);
    }
    else SendClientMessageEx(playerid, COLOR_PURPLE, "%s's apperance: %s", GetRPName(targetid), PlayerInfo[targetid][pApperance]);
    return 1;
}
alias:describe("examine");

stock ShowStats(playerid, targetid)
{
    SendClientMessageEx(targetid, COLOR_GREEN, "______________________ %s ______________________", GetUserName(playerid));
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Account: {FFFFFF}Master Name:[%s], Donator Level:[%d], Admin Level:[%d], Helper Level:[%d]", GetMasterName(playerid), Player[playerid][DonateLevel], Player[playerid][AdminLevel], Player[playerid][HelperLevel]);
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Character: {FFFFFF}Level:[%d] Experience:[%d/%d] Time Played:[%d hours]", 
        PlayerInfo[playerid][pLevel],
        PlayerInfo[playerid][pExpierience],
        ((PlayerInfo[playerid][pLevel]) * 4 + 2),
        PlayerInfo[playerid][pHours]);
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Faction: {FFFFFF}Faction:[%s] Faction Rank:[%s]", 
        GetFactionName(PlayerInfo[playerid][pFaction]), 
        GetPlayerRank(playerid));
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Weapons: {FFFFFF}Primary Weapon:[%s][%d Ammo] Secondary Weapon:[%s][%d Ammo] Melee:[%s] Other:[%s]", 
        GetServerWeaponName(PlayerInfo[playerid][pPrimaryWeapon]),
        PlayerInfo[playerid][pPrimaryAmmo],
        GetServerWeaponName(PlayerInfo[playerid][pSecondaryWeapon]),
        PlayerInfo[playerid][pSecondaryAmmo],
        GetServerWeaponName(PlayerInfo[playerid][pMeleeWeapon]),
        GetServerWeaponName(PlayerInfo[playerid][pOtherWeapon]));
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Inventory: {FFFFFF}Phone:[%d] Radio:[%s] Mask:[%s][%d]", 
        GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)), 
        (GetInventory(playerid, INV_RADIO) != 1) ? ("No") : ("Yes"),
        BinToStr(PlayerInfo[playerid][pMask]), 
        PlayerInfo[playerid][pMaskID]);
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Finance: {FFFFFF}Hand Cash:[$%s] Bank Cash:[$%s] Pay Cheque:[$%s]", 
        FormatNumber(PlayerInfo[playerid][pMoney]),
        FormatNumber(PlayerInfo[playerid][pBank]),
        FormatNumber(PlayerInfo[playerid][pPayCheque]));
    if(Player[targetid][AdminLevel] >= 1)
    {
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Admin: {FFFFFF}CharacterID:[%d] Master Account:[%s] Interior:[%d] Virtual World:[%d]", 
            PlayerInfo[playerid][pCharacterID],
            GetMasterName(playerid),
            GetPlayerInterior(playerid),
            GetPlayerVirtualWorld(playerid));
        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Admin: {FFFFFF}SkinID:[%d] Walk Style:[%d] Chat Style:[%d]", 
            GetPlayerSkin(playerid),
            PlayerInfo[playerid][pWalkStyle],
            PlayerInfo[playerid][pChatStyle]);

        new version[40], Float:packetLoss;
        GetPlayerVersion(playerid, version, sizeof(version));
	    GetPlayerPacketloss(playerid, packetLoss);

        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Admin: {FFFFFF}Version:[%s] Ping:[%d] PacketLoss:[%.2f]", 
            version,
            GetPlayerPing(playerid),
            packetLoss);

        SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "Admin: {FFFFFF}Messages Recieved:[%d] Bytes Sent:[%d] Connection Status:[%s]", 
            NetStats_MessagesReceived(playerid),
            NetStats_BytesSent(playerid),
            GetConnectionStatus(playerid));
    }
    SendClientMessageEx(targetid, COLOR_GREEN, "______________________ %s ______________________", GetUserName(playerid));
}

stock GetConnectionStatus(playerid)
{
    new string[100];
    switch(NetStats_ConnectionStatus(playerid))
    {
        case 0: string = "No Action";
        case 1: string = "Disconnect ASAP";
        case 2: string = "Disconnect ASAP Silently";
        case 3: string = "Disconnect On No Ack";
        case 4: string = "Requested Connection";
        case 5: string = "Handling Connection Request";
        case 6: string = "Unverified Sender";
        case 7: string = "Set Encryption On Multiple 16 Byte Packet";
        case 8: string = "Connected";
    }
    return string;
}

CMD:lock(playerid, params[])
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizExteriorX], BusinessInfo[i][BizExteriorY], BusinessInfo[i][BizExteriorZ]))
            {
                if(GetPlayerInterior(playerid) != BusinessInfo[i][BizExteriorInt])
                    continue;
                        
                if(GetPlayerVirtualWorld(playerid) != BusinessInfo[i][BizExteriorVW])
                    continue;

                if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You do not own this business.");

                if(BusinessInfo[i][BizLocked] == 1)
                {
                    BusinessInfo[i][BizLocked] = 0;
                    PrintFooter(playerid, "~b~Unlocked", 1);
                }
                else
                {
                    BusinessInfo[i][BizLocked] = 1;
                    PrintFooter(playerid, "~r~Locked", 1);
                }
                return 1;
            }
            if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ]))
            {
                if(GetPlayerInterior(playerid) != BusinessInfo[i][BizInteriorInt])
                    continue;
                        
                if(GetPlayerVirtualWorld(playerid) != i)
                    continue;

                if(BusinessInfo[i][BizOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You do not own this business.");

                if(BusinessInfo[i][BizLocked] == 1)
                {
                    BusinessInfo[i][BizLocked] = 0;
                    PrintFooter(playerid, "~b~Unlocked", 1);
                }
                else
                {
                    BusinessInfo[i][BizLocked] = 1;
                    PrintFooter(playerid, "~r~Locked", 1);
                }
                return 1;
            }
        }
    }
    for(new i; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][HouseID] > 0)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseExteriorX], HouseInfo[i][HouseExteriorY], HouseInfo[i][HouseExteriorZ]))
            {
                if(GetPlayerInterior(playerid) != HouseInfo[i][HouseExteriorInt])
                    continue;
                        
                if(GetPlayerVirtualWorld(playerid) != HouseInfo[i][HouseExteriorVW])
                    continue;

                if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You do not own this house.");

                if(HouseInfo[i][HouseLocked] == 1)
                {
                    HouseInfo[i][HouseLocked] = 0;
                    PrintFooter(playerid, "~b~Unlocked", 1);
                }
                else
                {
                    HouseInfo[i][HouseLocked] = 1;
                    PrintFooter(playerid, "~r~Locked", 1);
                }
                return 1;
            }
            if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseInteriorX], HouseInfo[i][HouseInteriorY], HouseInfo[i][HouseInteriorZ]))
            {
                if(GetPlayerInterior(playerid) != HouseInfo[i][HouseInteriorInt])
                    continue;
                        
                if(GetPlayerVirtualWorld(playerid) != i)
                    continue;

                if(HouseInfo[i][HouseOwnerID] != PlayerInfo[playerid][pCharacterID])
                    return SendErrorMessage(playerid, "You do not own this house.");

                if(HouseInfo[i][HouseLocked] == 1)
                {
                    HouseInfo[i][HouseLocked] = 0;
                    PrintFooter(playerid, "~b~Unlocked", 1);
                }
                else
                {
                    HouseInfo[i][HouseLocked] = 1;
                    PrintFooter(playerid, "~r~Locked", 1);
                }
                return 1;
            }
        }
    }
    for(new i; i < MAX_ENTRANCE; i++)
    {
        if(EntranceInfo[i][EntranceID] > 0)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[i][EntranceX], EntranceInfo[i][EntranceY], EntranceInfo[i][EntranceZ])
                || IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[i][EntranceIntX], EntranceInfo[i][EntranceIntY], EntranceInfo[i][EntranceIntZ]))
            {
                if(EntranceInfo[i][EntranceFactionID] > 0 && PlayerInfo[playerid][pFaction] != EntranceInfo[i][EntranceFactionID])
                {
                    if(TempVar[playerid][AdminDuty] == false)
                    {
                        SendErrorMessage(playerid, "You are not a member of the required faction.");
                        return 1;
                    }
                }

                if(EntranceInfo[i][EntranceLocked] == 1)
                {
                    EntranceInfo[i][EntranceLocked] = 0;
                    PrintFooter(playerid, "~b~Unlocked", 1);
                }
                else
                {
                    EntranceInfo[i][EntranceLocked] = 1;
                    PrintFooter(playerid, "~r~Locked", 1);
                }
                return 1;
            }
        }
    }
    return 1;
}

CMD:logout(playerid, params[])
{
    SendErrorMessage(playerid, "This command has been disabled temporarily, relog to switch accounts.");
	/*if(gettime() - PlayerInfo[playerid][pLastShotTime] < 120)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You took damage recently and can't relog yet.");
		
	if(TempVar[playerid][Relogging])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You're already in the middle of relogging.");
		
	new
		Float:x,
		Float:y,
		Float:z
    ;
	
    SendServerMessage(playerid, "Logging out, please wait...");
	GetPlayerPos(playerid, x, y, z);
    SetPlayerTeam(playerid, PLAYER_ALIVE);
	
	TempVar[playerid][Relogging] = true;
	
	TempVar[playerid][RelogID] = Create3DTextLabel("(( LOGGING OUT ))", COLOR_WHITE, x, y, z, 20.0, GetPlayerVirtualWorld(playerid), 1);
	Attach3DTextLabelToPlayer(TempVar[playerid][RelogID], playerid, 0.0, 0.0, 0.1);
	TogglePlayerControllable(playerid, 0);
	
	TempVar[playerid][RelogTimer] = SetTimerEx("OnPlayerRelog", 1000, true, "i", playerid); */
    return 1;
}

CMD:savecharacter(playerid, params[])
{
    if(Player[playerid][IsLoggedIn] == true)
    {
        SaveCharacter(playerid); // We need this
        SendServerMessage(playerid, "Your character details were saved.");
    }
    return 1;
}

stock GetLicenses(playerid, targetid)
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_WHITE, "Licenses on %s", GetRPName(targetid));
    SendClientMessageEx(playerid, COLOR_GRAD5, "* Driving License: %s", BinToStr(GetInventory(targetid, INV_DRV_LIC)));
    SendClientMessageEx(playerid, COLOR_GRAD4, "* Weapon License: %s", BinToStr(GetInventory(targetid, INV_WEP_LIC)));
    SendClientMessageEx(playerid, COLOR_GRAD3, "* Flying License: %s", 
        (PlayerInfo[targetid][pFlyingLicense] == 0) ? ("No") : ("Yes"));
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
}

CMD:mylicenses(playerid, params[])
{
    GetLicenses(playerid, playerid);
    SendMe(playerid, "looks at their licenses.");
    return 1;
}

CMD:showlicenses(playerid, params[])
{
    new targetid, string[128];
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/showlicenses [PlayerID/PartOfName]");

    if(targetid == playerid)
        return SendErrorMessage(playerid, "You cannot show licenses to yourself, use /mylicenses.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You aren't near that player."); 
    
    GetLicenses(targetid, playerid);
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have shown your licenses to %s", GetRPName(playerid));
    format(string, sizeof(string), "shows their licenses to %s.", GetRPName(targetid));
    SendMe(playerid, string);
    return 1;
}
alias:showlicenses("showlicense");

CMD:drivingexam(playerid, params[])
{
	if(PlayerInfo[playerid][pMoney] >= 250)
	{
		new iVeh = GetPlayerVehicleID(playerid);
        for(new i; i < GetVehiclePoolSize(); i++)
        {
            if(DMVVehicles[i] == iVeh)
            {
                if(TempVar[playerid][DMVTest] == 0)
				{
                    if(!GetInventory(playerid, INV_DRV_LIC))
					{
						SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: Welcome to the DMV Driving Test. I will test your driving to see if you are able to drive a car.");
						SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: You will drive a certain path around Fort Carson and I will then assess your driving.");
						SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: Remember: No speeding, no reckless driving and always wear your seatbelt.");
						SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: Now, follow the predefined path on the GPS.");
						TempVar[playerid][DMVTest] = 1;
                        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_DMV;
						SetPlayerCheckpoint(playerid, -196.8718,1207.0576,19.4435, 5.0);
                        ToggleVehicleEngine(iVeh, true);
					}
					else
					{
						SendErrorMessage(playerid, "You already have a driving license.");
						RemovePlayerFromVehicle(playerid);
					}
				}
				else
				{
					SendErrorMessage(playerid, "You are already in the drivers test. Exit the car to quit the test.");
				}
				return 1;
            }
        }
        SendErrorMessage(playerid, "You are not in a DMV vehicle.");
	}
	else SendErrorMessage(playerid, "You do not have enough money. You need $250 to start the test.");
	return 1;
}

CMD:servertime(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREY, "Server Time: {FFFFFF}%s", GetDateTime());
	return 1;
}
alias:servertime("stime");

CMD:clearchat(playerid, params[])
{
    ClearChat(playerid, 35);
    return 1;
}

CMD:rnumber(playerid, params[])
{
    new randMin, randMax;
    if(sscanf(params, "dd", randMin, randMax))
        return SendUsageMessage(playerid, "/rnumber [Min] [Max] - Generates a random number.");

    if(randMin < 1 || randMax < 1)
        return SendErrorMessage(playerid, "The min or max cannot be below 1");

    SendClientMessageEx(playerid, COLOR_GREY, "Random Number: {FFFFFF}%d", Random(randMin, randMax));
	return 1;
}

CMD:dice(playerid, params[])
{
    SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "** %s rolls a dice which lands on the number %i.", GetRPName(playerid), random(6) + 1);
	return 1;
}

CMD:coin(playerid, params[])
{
    if(PlayerInfo[playerid][pMoney] >= 1)
	{
        SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "** %s flips a coin which lands on %s.", GetRPName(playerid), (random(2)) ? ("Heads") : ("Tails"));
    }
    else SendErrorMessage(playerid, "You have no coin to flip. (Get money!)");
	return 1;
}

CMD:leavejob(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] >= 1)
	{
        PlayerInfo[playerid][pJob] = 0;
        SendClientMessageEx(playerid, COLOR_WHITE, "You have left your job.");
    }
    else SendErrorMessage(playerid, "You have no job.");
	return 1;
}

CMD:shakehand(playerid, params[])
{
	new targetid, type;

	if(sscanf(params, "ui", targetid, type))
	{
	    return SendUsageMessage(playerid, "/shakehand [playerid] [type (1-6)]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 5.0))
	{
	    return SendErrorMessage(playerid, "The player specified is disconnected or out of range.");
	}
	if(targetid == playerid)
	{
	    return SendErrorMessage(playerid, "You can't shake your own hand.");
	}
	if(!(1 <= type <= 6))
	{
	    return SendErrorMessage(playerid, "Invalid type. Valid types range from 1 to 6.");
	}

	TempVar[targetid][ShakeOffer] = playerid;
	TempVar[targetid][ShakeType] = type;

	SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "* %s has offered to shake your hand. (/accept handshake)", GetRPName(playerid));
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have sent %s a handshake offer.", GetRPName(targetid));
	return 1;
}

CMD:stopaudio(playerid, params[])
{
    StopAudioStreamForPlayer(playerid);
    return 1;
}
alias:stopaudio("fixr");

CMD:stuck(playerid, params[])
{
    Dialog_Show(playerid, StuckConfirmation, DIALOG_STYLE_MSGBOX, "Stuck", "This will reset your interior and virtual worlds to zero\n\
    Do not use this while inside an interior/property.", "Confirm", "Cancel");
    return 1;
}

Dialog:StuckConfirmation(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        SendClientMessage(playerid, COLOR_SAMP, "Interior and virtual world reset.");
        SetInterior(playerid, 0);
        SetVirtualWorld(playerid, 0);
    }
    return 1;
}

Dialog:DIALOG_HELP_MAIN(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    switch(listitem)
    {
        case 0:
        {
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Account Help:{FFFFFF} Type a command for more information.");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /stats, /logout, /savecharacter");
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        }
        case 1:
        {
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "General Help:{FFFFFF} Type a command for more information.");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /admins, /helpers, /report, /pay, /isafk, /time, /removecp (/rcp), /weapons");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /leavegun, /grabgun, /enter, /exit, /mask, /buy, /setchannel, /accept, /stuck");
            SendClientMessage(playerid, COLOR_GRAD4, "Commands: /respawnme, /setspawn, /setstation, /lock, /apperance, /describe, /deposit");
            SendClientMessage(playerid, COLOR_GRAD4, "Commands: /withdraw, /balance, /mylicenses, /showlicenses, /drivingexam, /door, /gate"); 
            SendClientMessage(playerid, COLOR_GRAD3, "Commands: /barrier, /blindfold, /fishinghelp, /dice, /coin, /virtualworld, /rollwindow");
            SendClientMessage(playerid, COLOR_GRAD3, "Commands: /masteraccount (/ma), /eject, /pullincar, /rnumber, /servertime, /clearchat");
            SendClientMessage(playerid, COLOR_GRAD2, "Commands: /accent, /serial, /myfines");
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        }
        case 2:
        {
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Chat Help:{FFFFFF} Type a command for more information.");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /b (local ooc), /ooc (/o), /pm, /t(alk), /(l)ocal, /low, /(s)hout");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /(r)adio, /radiolow (/rlow)");
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        }
        case 3:
        {
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "Phone Help:{FFFFFF} Type a command for more information.");
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /(c)all, /payphone, /(h)angup, /(p)ickup, /sms (/txt), /loudspeaker");
            SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        }
        case 4:
        {
            pc_cmd_househelp(playerid, inputtext);
        }
        case 5:
        {
            pc_cmd_businesshelp(playerid, inputtext);
        }
        case 6:
        {
            pc_cmd_jobhelp(playerid, inputtext);
        }
        case 7:
        {
            pc_cmd_factionhelp(playerid, inputtext);
        }
        case 8:
        {
            pc_cmd_ahelp(playerid, inputtext);
        }
        case 9:
        {
            pc_cmd_hhelp(playerid, inputtext);
        }
        case 10:
        {
            pc_cmd_testerhelp(playerid, inputtext);
        }
    }
    return 1;
}

CMD:eject(playerid, params[])
{
    new targetid, string[128];
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/eject [PlayerID/PartOfName]");
    
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
        return SendErrorMessage(playerid, "You must be in a vehicle as the driver to use this.");

    if(!IsPlayerConnected(targetid)) 
        return SendErrorMessage(playerid, "This player is not connected.");
    
    if(targetid == playerid)
        return SendErrorMessage(playerid, "You cannot eject yourself.");

    if(GetPlayerVehicleID(targetid) == GetPlayerVehicleID(playerid))
    {
        format(string, sizeof(string), "* You ejected %s from the vehicle.", GetRPName(targetid));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), "* You were ejected by driver %s.", GetRPName(playerid));
        SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
        RemovePlayerFromVehicle(targetid);
    }
    return 1;
}

CMD:pullincar(playerid, params[])
{
    new targetID, seatID;
    if(sscanf(params, "ud", targetID, seatID))
        return SendUsageMessage(playerid, "/pullincar [PlayerID/PartOfName] [SeatID (2-3 are valid)");

    if(targetID == playerid)
        return SendErrorMessage(playerid, "You cannot put yourself in an ambulance.");
    
    if(!IsPlayerNearPlayer(playerid, targetID, 20.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    if(GetPlayerTeam(targetID) != PLAYER_WOUNDED)
        return SendErrorMessage(playerid, "You cannot use this on someone who is not brutally wounded.");

    if(seatID < 2 || seatID > 3)
            return SendErrorMessage(playerid, "Invalid SeatID. (2-3 are valid)");

    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleID = GetPlayerVehicleID(playerid);
        PutPlayerInVehicle(targetID, vehicleID, seatID);
        SetVirtualWorld(targetID, GetVehicleVirtualWorld(vehicleID));
        SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been pulled inside a vehicle by %s %s.", GetPlayerRank(playerid), GetRPName(playerid));
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have placed %s pulled inside your vehicle.", GetRPName(targetID));
    }
    return 1;
}

CMD:tog(playerid, params[])
{
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/tog [Chat to toggle]");
        SendClientMessage(playerid, -1, "Chats: News, OOC, PM, Faction, Connect");
        if(IsStaffMember(playerid, false))
        {
            SendClientMessage(playerid, -1, "Staff Chats: Admin, Staff, Helper, AdmCmd, AdmWarn");
        }
        return 1;
    }
    if(strcmp(params, "connect", true) == 0)
    {
        if(TempVar[playerid][ConnectEnabled] == false)
        {
            TempVar[playerid][ConnectEnabled] = true;
            SendClientMessage(playerid, COLOR_GREY, "Connect and Disconnect messages have been enabled.");
        }
        else
        {
            TempVar[playerid][ConnectEnabled] = false;
            SendClientMessage(playerid, COLOR_GREY, "Connect and Disconnect messages have been disable.");
        }
    }
    else if(strcmp(params, "news", true) == 0)
    {
        if(TempVar[playerid][NewsDisabled] == false)
        {
            TempVar[playerid][NewsDisabled] = true;
            SendClientMessage(playerid, COLOR_GREY, "News has been disabled.");
        }
        else
        {
            TempVar[playerid][NewsDisabled] = false;
            SendClientMessage(playerid, COLOR_GREY, "News has been enabled.");
        }
    }
    else if(strcmp(params, "ooc", true) == 0)
    {
        if(TempVar[playerid][DisabledOOC] == false)
        {
            TempVar[playerid][DisabledOOC] = true;
            SendClientMessage(playerid, COLOR_GREY, "Global OOC (/o) has been disabled.");
        }
        else
        {
            TempVar[playerid][DisabledOOC] = false;
            SendClientMessage(playerid, COLOR_GREY, "Global OOC (/o) has been enabled.");
        }
    }
    else if(strcmp(params, "pm", true) == 0)
    {
        if(Player[playerid][AdminLevel] >= 1 || Player[playerid][HelperLevel] >= 1 || Player[playerid][DonateLevel] >= 1)
        {
            if(TempVar[playerid][PMDisabled] == false)
            {
                TempVar[playerid][PMDisabled] = true;
                SendClientMessage(playerid, COLOR_GREY, "Private Messages (/pm) has been disabled.");
            }
            else
            {
                TempVar[playerid][PMDisabled] = false;
                SendClientMessage(playerid, COLOR_GREY, "Private Messages (/pm) has been enabled.");
            }
        }
        else SendErrorMessage(playerid, "This feature is restricted to donators and staff.");
    }
    else if(strcmp(params, "faction", true) == 0)
    {
        if(TempVar[playerid][FactionDisabled] == false)
        {
            TempVar[playerid][FactionDisabled] = true;
            SendClientMessage(playerid, COLOR_GREY, "Faction Messages (/f) has been disabled.");
        }
        else
        {
            TempVar[playerid][FactionDisabled] = false;
            SendClientMessage(playerid, COLOR_GREY, "Faction Messages (/f) has been enabled.");
        }
    }
    else if(strcmp(params, "Admin", true) == 0)
    {
        if(IsAdminLevel(playerid, 1))
        {
            if(GetPVarInt(playerid, "AdminDisabled") == 0)
            {
                SetPVarInt(playerid, "AdminDisabled", 1);
                SendClientMessage(playerid, COLOR_GREY, "Admin Messages (/a) has been disabled.");
            }
            else
            {
                SetPVarInt(playerid, "AdminDisabled", 0);
                SendClientMessage(playerid, COLOR_GREY, "Admin Messages (/a) has been enabled.");
            }
        }
    }
    else if(strcmp(params, "Staff", true) == 0)
    {
        if(IsStaffMember(playerid, false))
        {
            if(TempVar[playerid][StaffDisabled] == false)
            {
                TempVar[playerid][StaffDisabled] = true;
                SendClientMessage(playerid, COLOR_GREY, "Staff Messages (/staff) has been disabled.");
            }
            else
            {
                TempVar[playerid][StaffDisabled] = false;
                SendClientMessage(playerid, COLOR_GREY, "Staff Messages (/staff) has been enabled.");
            }
        }
    }
    else if(strcmp(params, "Helper", true) == 0)
    {
        if(IsHelperLevel(playerid, 1, false) || IsAdminLevel(playerid, 4, false))
        {
            if(TempVar[playerid][StaffDisabled] == false)
            {
                TempVar[playerid][StaffDisabled] = true;
                SendClientMessage(playerid, COLOR_GREY, "Helper Messages (/hc) has been disabled.");
            }
            else
            {
                TempVar[playerid][StaffDisabled] = false;
                SendClientMessage(playerid, COLOR_GREY, "Helper Messages (/hc) has been enabled.");
            }
        }
    }
    else if(strcmp(params, "AdmCmd", true) == 0)
    {
        if(IsAdminLevel(playerid, 1))
        {
            if(GetPVarInt(playerid, "AdminCmdDisabled") == 0)
            {
                SetPVarInt(playerid, "AdminCmdDisabled", 1);
                SendClientMessage(playerid, COLOR_GREY, "Admin Command Messages (AdmCmd) has been disabled.");
            }
            else
            {
                SetPVarInt(playerid, "AdminCmdDisabled", 0);
                SendClientMessage(playerid, COLOR_GREY, "Admin Command Messages (AdmCmd) has been enabled.");
            }
        }
    }
    else if(strcmp(params, "AdmWarn", true) == 0)
    {
        if(IsAdminLevel(playerid, 1))
        {
            if(GetPVarInt(playerid, "AdminWarnDisabled") == 0)
            {
                SetPVarInt(playerid, "AdminWarnDisabled", 1);
                SendClientMessage(playerid, COLOR_GREY, "Admin Warning Messages (AdmWarn) has been disabled.");
            }
            else
            {
                SetPVarInt(playerid, "AdminWarnDisabled", 0);
                SendClientMessage(playerid, COLOR_GREY, "Admin Warning Messages (AdmWarn) has been enabled.");
            }
        }
    }
    return 1;
}

CMD:masteraccount(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________ %s ______________________", GetMasterName(playerid));
    SendClientMessageEx(playerid, COLOR_GRAD5, "Admin Level:[%d][%s], Helper Level:[%d][%s], Donator Level:[%d][%s]", 
        Player[playerid][AdminLevel], GetAdminRank(playerid), 
        Player[playerid][HelperLevel], GetHelperRank(playerid), 
        Player[playerid][DonateLevel], GetDonateRank(playerid));
    SendClientMessageEx(playerid, COLOR_GRAD4, "Last Active:[%s], Register Date:[%s]", date(Player[playerid][LastActive]), date(Player[playerid][RegisterDate]));
    SendClientMessageEx(playerid, COLOR_GRAD4, "Name Changes:[%d], Number Changes:[%d]", Player[playerid][NameChanges], Player[playerid][NumberChanges]);
    return 1;
}
alias:masteraccount("ma");

CMD:rollwindow(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        new window;
        if(sscanf(params, "d", window))
        {
            SendUsageMessage(playerid, "/rollwindow [Window ID]");
            return SendClientMessage(playerid,-1,"Window ID: 1. Driver window, 2. Passenger window, 3. Rear-left window, 4. Rear-right window");
        }

        if(window > 4 || window < 1) return SendErrorMessage(playerid, "Valid Windows: 1. Driver window, 2. Passenger window, 3. Rear-left window, 4. Rear-right window");

        new driver, passenger, backleft, backright;
        GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

        switch(window)
        {
            case 1: 
            {
                if(driver == 0) 
                { 
                    driver = 1;
                    CoreVehicle[vehicleid][VehicleWindowFrontLeft] = true;
                }
                else
                { 
                    driver = 0;
                    CoreVehicle[vehicleid][VehicleWindowFrontLeft] = false;
                }
            }
            case 2:
            {
                if(passenger == 0) 
                { 
                    passenger = 1;
                    CoreVehicle[vehicleid][VehicleWindowFrontRight] = true;
                }
                else
                { 
                    passenger = 0;
                    CoreVehicle[vehicleid][VehicleWindowFrontRight] = false;
                }
            }
            case 3:
            {
                if(backleft == 0) 
                { 
                    backleft = 1;
                    CoreVehicle[vehicleid][VehicleWindowBackLeft] = true;
                }
                else
                { 
                    backleft = 0;
                    CoreVehicle[vehicleid][VehicleWindowBackLeft] = false;
                }
            }
            case 4:
            {
                if(backright == 0) 
                { 
                    backright = 1;
                    CoreVehicle[vehicleid][VehicleWindowBackRight] = true;
                }
                else
                { 
                    backright = 0;
                    CoreVehicle[vehicleid][VehicleWindowBackRight] = false;
                }
            }
        }
        switch(window)
		{
			case 1: pc_cmd_ame(playerid, "rolls the driver window.");
	        case 2: pc_cmd_ame(playerid, "rolls the passenger window.");
	        case 3: pc_cmd_ame(playerid, "rolls the back left window.");
	        case 4: pc_cmd_ame(playerid, "rolls the back right window.");
		}
        SetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), driver, passenger, backleft, backright);
    }
    else SendErrorMessage(playerid, "You are not the driver of this vehicle.");
    return 1;
}
alias:rollwindow("rw");

CMD:blindfold(playerid, params[])
{
    if(TempVar[playerid][BlindFolded] == false)
    {
        TempVar[playerid][BlindFolded] = true;
        PlayerTextDrawShow(playerid, Blind[playerid]);
    }
    else
    {
        TempVar[playerid][BlindFolded] = false;
        PlayerTextDrawHide(playerid, Blind[playerid]);
    }
    return 1;
}

/*CMD:tognicks(playerid, params[])
{
    if(TempVar[playerid][Nametag] == false)
    {
        foreach(new i : Player)
        {
        	ShowPlayerNameTagForPlayer(playerid, i, false);
        	TempVar[playerid][Nametag] = true;
        }
    }
    else
    {
        foreach(new i : Player)
        {
        	if(TempVar[playerid][Masked] == false)
            {
                ShowPlayerNameTagForPlayer(playerid, i, true);
            }
        	TempVar[playerid][Nametag] = false;
        }
    }
    return 1;
}*/

CMD:mask(playerid, params[])
{
    if(PlayerInfo[playerid][pLevel] < 5 && !Player[playerid][AdminLevel])
		return SendErrorMessage(playerid, "You aren't level 5 or higher."); 
		
	if(!PlayerInfo[playerid][pMask] && !Player[playerid][AdminLevel])
		return SendErrorMessage(playerid, "You don't have a mask."); 
	
	if(TempVar[playerid][Masked] == false)
	{
		/*foreach(new i : Player)
		{
			if(TempVar[i][AdminDuty] == false)
            {
                ShowPlayerNameTagForPlayer(i, playerid, 0);
            }
		}*/
		TempVar[playerid][Masked] = true;
        PrintFooter(playerid, "~p~Your mask is now on.", 3);
	}
	else
	{
		/*foreach(new i : Player)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}*/
		TempVar[playerid][Masked] = false;
		PrintFooter(playerid, "~p~Your mask is now off.", 3);
	}
    return 1;
}


CMD:pay(playerid, params[])
{
	new playerb, amount, str[128]; 

	if(sscanf(params, "ui", playerb, amount))
		return SendUsageMessage(playerid, "/pay [playerid OR name] [amount]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");
		
	if(!Player[playerb][IsLoggedIn])
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near that player."); 

    if(playerid == playerb)
		return SendErrorMessage(playerid, "You cannot do this to yourself."); 

    if(amount < 1)
		return SendErrorMessage(playerid, "You cannot pay less than $1.");

	if(amount > PlayerInfo[playerid][pMoney])
		return SendErrorMessage(playerid, "You don't have that amount of money.");
	
    if(!strcmp(GetUserIP(playerid), GetUserIP(playerb)))
    {
        format(str, sizeof(str), "%s (ID: %d) has transferred money to %s (ID: %d) with the same IP.", GetUserName(playerid), playerid, GetUserName(playerb), playerb);
		SendAdminWarning(1, str);
    }

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(playerb, 1052, 0.0, 0.0, 0.0); 
	
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have sent %s, $%s.", GetRPName(playerb), FormatNumber(amount));
	SendClientMessageEx(playerb, COLOR_LIGHTBLUE, "* You have received $%s from %s.", FormatNumber(amount), GetRPName(playerid));
	
    if (amount < 1000)
    {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s gives %s a few bills.", GetRPName(playerid), GetRPName(playerb)); 
    }
    else SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s gives %s a bunch of bills.", GetRPName(playerid), GetRPName(playerb)); 
	
	if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[playerb][pLevel] <= 3 || amount >= 10000)
	{
		format(str, sizeof(str), "%s (Level %d) has paid $%s to %s (Level %d).", GetUserName(playerid), PlayerInfo[playerid][pLevel], FormatNumber(amount), GetUserName(playerb), PlayerInfo[playerb][pLevel]); 
		SendAdminWarning(1, str);
	}
	
    PlayerPlaySound(playerb, 1083, 0.0, 0.0, 0.0);
    PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	GiveMoney(playerid, -amount); 
    GiveMoney(playerb, amount);
	return 1;
}

CMD:accept(playerid, params[])
{
    new string[128];
    if(isnull(params))
    {
        SendUsageMessage(playerid, "/accept [Option]");
        SendUsageMessage(playerid, "Faction, House, Death, Frisk, Job, Handshake, Repair, Vehicle, Seeds");
        return 1;
    }
    if(strcmp(params, "seeds", true) == 0)
    {
        HandleSeedAccept(playerid);
    }
    else if(strcmp(params, "vehicle", true) == 0)
    {
        if (IsPlayerConnected(TempVar[playerid][CarOffer]))
        {
            new vehicle = TempVar[playerid][CarSell];
		    new price = TempVar[playerid][CarPrice];

            if(VehicleInfo[playerid][vOwnerID] != PlayerInfo[playerid][pCharacterID])
                return SendErrorMessage(playerid, "The vehicle offer has expired.");

            if(PlayerInfo[playerid][pMoney] < price)
                return SendErrorMessage(playerid, "You can't afford to buy the vehicle.");

            if(!IsPlayerNearPlayer(playerid, TempVar[playerid][CarOffer], 10.0))
                return SendErrorMessage(playerid, "You need to be near the player who offered the vehicle.");

            VehicleInfo[vehicle][vOwnerID] = PlayerInfo[playerid][pCharacterID];

	        SaveVehicle(vehicle);

	        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have purchased %s's %s for {33CC33}%s{FFFFFF}.", GetRPName(TempVar[playerid][CarOffer]), ReturnVehicleModelName(VehicleInfo[vehicle][vModel]), FormatNumber(price));
	        SendClientMessageEx(TempVar[playerid][CarOffer], COLOR_LIGHTBLUE, "* %s has purchased your %s for {33CC33}%s{FFFFFF}.", GetRPName(playerid), ReturnVehicleModelName(VehicleInfo[vehicle][vModel]), FormatNumber(price));

            if(PlayerInfo[playerid][pLevel] <= 3 || PlayerInfo[TempVar[playerid][CarOffer]][pLevel] <= 3 || price >= 10000)
            {
                format(string, sizeof(string), "%s (Level %d) has bought a %s for $%s from %s (Level %d).", GetUserName(playerid), PlayerInfo[playerid][pLevel], ReturnVehicleModelName(VehicleInfo[vehicle][vModel]), FormatNumber(price), GetUserName(TempVar[playerid][CarOffer]), PlayerInfo[TempVar[playerid][CarOffer]][pLevel]);
                SendAdminWarning(1, string);
            }

        	GiveMoney(TempVar[playerid][CarOffer], price);
            TakeMoney(playerid, price);
	        TempVar[playerid][CarOffer] = INVALID_PLAYER_ID;
        }
    }
    else if(strcmp(params, "faction", true) == 0)
    {
        HandleFactionAccept(playerid);
    }
    else if(strcmp(params, "house", true) == 0)
    {
        HandleHouseAccept(playerid);
    }
    else if(strcmp(params, "death", true) == 0)
    {
        if(GetPlayerTeam(playerid) == PLAYER_WOUNDED)
        {
            Player_AcceptDeath(playerid, INVALID_PLAYER_ID, 0);
   	        SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "(( [%d] %s has accepted death. ))", playerid, GetUserName(playerid));
        }
        else SendErrorMessage(playerid, "You are not wounded or already dead.");
    }
    else if(strcmp(params, "frisk", true) == 0)
    {
        if(TempVar[playerid][FriskRequest] != INVALID_PLAYER_ID)
        {
            FriskPlayer(TempVar[playerid][FriskRequest], playerid);
            format(string, sizeof(string), "performs a frisk on %s.", GetRPName(playerid));
            SendMe(TempVar[playerid][FriskRequest], string);
            TempVar[playerid][FriskRequest] = INVALID_PLAYER_ID;
        }
        else SendErrorMessage(playerid, "Nobody wants to frisk you.");
    }
    else if(strcmp(params, "handshake", true) == 0)
	{
	    new offeredby = TempVar[playerid][ShakeOffer];

	    if(offeredby == INVALID_PLAYER_ID)
	    {
	        return SendClientMessage(playerid, COLOR_GREY, "You haven't received any offers for a handshake.");
	    }
	    if(!IsPlayerNearPlayer(playerid, offeredby, 5.0))
		{
	        return SendClientMessage(playerid, COLOR_GREY, "The player who initiated the offer is out of range.");
	    }

	    ClearAnimations(playerid);
		ClearAnimations(offeredby);

		SetPlayerToFacePlayer(playerid, offeredby);
		SetPlayerToFacePlayer(offeredby, playerid);

		switch(TempVar[playerid][ShakeType])
		{
		    case 1:
		    {
				ApplyAnimationEx(playerid,  "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimationEx(offeredby, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 2:
			{
				ApplyAnimationEx(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimationEx(offeredby, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 3:
			{
				ApplyAnimationEx(playerid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimationEx(offeredby, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 4:
			{
				ApplyAnimationEx(playerid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimationEx(offeredby, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 5:
			{
				ApplyAnimationEx(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimationEx(offeredby, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 6:
			{
			    ApplyAnimationEx(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0);
			    ApplyAnimationEx(offeredby, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0);
			}
	    }

	    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have accepted %s's handshake offer.", GetRPName(offeredby));
	    SendClientMessageEx(offeredby, COLOR_LIGHTBLUE, "* %s has accepted your handshake offer.", GetRPName(playerid));

  		TempVar[playerid][ShakeOffer] = INVALID_PLAYER_ID;
	}
    else if(strcmp(params, "repair", true) == 0)
    {
        new mechid = GetPVarInt(playerid, "MechanicID");
        if(mechid != INVALID_PLAYER_ID)
        {
            MechanicRepair(mechid, playerid);
        }
        else SendErrorMessage(playerid, "Nobody offered to repair your vehicle.");
    }
    return 1;
}

stock SetPlayerToFacePlayer(playerid, targetid)
{
	new
	    Float:px,
	    Float:py,
	    Float:pz,
	    Float:tx,
	    Float:ty,
	    Float:tz;

	GetPlayerPos(targetid, tx, ty, tz);
	GetPlayerPos(playerid, px, py, pz);
	SetPlayerFacingAngle(playerid, 180.0 - atan2(px - tx, py - ty));
}

CMD:id(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/id [PlayerID/Name]");

    if(IsNumeric(params))
    {
        new target = strval(params);
        if(IsPlayerConnected(target))
        {
            SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "(ID %d) {FFFFFF}Name:[%s] Master Name:[%s] Level:[%d] Ping:[%d]", target, GetUserName(target), GetMasterName(target), PlayerInfo[target][pLevel], GetPlayerPing(target));
        }
        else SendErrorMessage(playerid, "No such player is connected.");
        return 1;
    }

    if(strlen(params) < 2)
	    return SendErrorMessage(playerid, "Please input at least two characters to search.");

    new name[MAX_PLAYER_NAME], found = false;
    foreach(new i: Player)
    {
        GetPlayerName(playerid, name, sizeof name);
        if(Player[i][IsLoggedIn] == true)
        {
            if(strfind(name, params, true) != -1 || strfind(GetMasterName(i), params, true) != -1)
            {
                found = true;
                SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "(ID %d) {FFFFFF}Name:[%s] Master Name:[%s] Level:[%d] Ping:[%d]", i, GetUserName(i), GetMasterName(i), PlayerInfo[i][pLevel], GetPlayerPing(i));
            }
        }
    }
    if(!found)
    {
        SendErrorMessage(playerid, "Nobody matching the paramaters was not found.");
    }
    return 1;
}

CMD:isafk(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/isafk [PlayerID/Name]");

    if(Player[playerid][AdminLevel] < 1 && Player[targetid][AdminLevel] >= 1)
        return SendErrorMessage(playerid, "You cannot check an admins AFK status.");

    if(TempVar[targetid][AFKSeconds] >= 1)
    {
        SendServerMessage(playerid, "%s (%s) has been AFK for %s.", GetUserName(targetid), GetMasterName(targetid), TimeConvert(TempVar[targetid][AFKSeconds]));
    }
    else
    {
        SendServerMessage(playerid, "%s (%s) is not AFK.", GetUserName(targetid), GetMasterName(targetid));
    }
    return 1;
}

CMD:time(playerid, params[])
{
    new string[128], thour, suffix[3];
	if(ServerInfo[CurrentHour] > 12 && ServerInfo[CurrentHour] < 24)
	{
		thour = ServerInfo[CurrentHour] - 12;
		suffix = "PM";
	}
	else if(ServerInfo[CurrentHour] == 12)
	{
		thour = 12;
		suffix = "PM";
	}
	else if(ServerInfo[CurrentHour] > 0 && ServerInfo[CurrentHour] < 12)
	{
		thour = ServerInfo[CurrentHour];
		suffix = "AM";
	}
	else if(ServerInfo[CurrentHour] == 0)
	{
		thour = 12;
		suffix = "AM";
	}

    pc_cmd_ame(playerid, "checks the time.");

    if (Player[playerid][AjailTime] > 0)
	{
		format(string, sizeof(string), "~g~|~w~%d:%02d %s~g~|~n~~w~Ajail Time Left: ~r~%s", thour, ServerInfo[CurrentMinute], suffix, TimeConvert(Player[playerid][AjailTime]));
        PrintFooter(playerid, string, 3);
        return 1;
	}
	if (PlayerInfo[playerid][pJailTime] > 0)
	{
		format(string, sizeof(string), "~g~|~w~%d:%02d %s~g~|~n~~w~jail Time Left: ~r~%s", thour, ServerInfo[CurrentMinute], suffix, TimeConvert(PlayerInfo[playerid][pJailTime]));
        PrintFooter(playerid, string, 3);
        return 1;
	}
    format(string, sizeof(string), "~g~|~w~%d:%02d %s~g~|", thour, ServerInfo[CurrentMinute], suffix);
    PrintFooter(playerid, string, 3);
    return 1;
}

CMD:credits(playerid, params[])
{
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Credits", "Script Created by Seanny\n\n\
    Developers:\n\
    Seanny - Scripting, Mapping and Server Owner\n\
    Tyler - Mapping and Server Co-Owner\n\n\
    Third Party Code:\n\
    Y_Less - Foreach and YSI\n\
	Incognito - Streamer\n\
	YourShadow - Pawn.CMD\n\
	d0 - mSelection\n\
	BlueG - MySQL Plugin\n\
	Gammix - Attachments Bug Fixes\n\
	Maddinat0r - Discord Connector\n\
	Zeex - CrashDetect", "Close", "");
    return 1;
}

CMD:coords(playerid, params[])
{
	new Float:x1, Float:y1, Float:z1, Float:a;
	GetPlayerPos(playerid, x1, y1, z1);
	GetPlayerFacingAngle(playerid, a);
	SendClientMessageEx(playerid, COLOR_SAMP, "Current Position: %.f, %.f, %.f, %.f.", x1, y1, z1, a);
	return 1;
}

CMD:virtualworld(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_SAMP, "Current Virtual World: %d.", GetPlayerVirtualWorld(playerid));
    return 1;
}

CMD:removecp(playerid, params[])
{
    if(TempVar[playerid][Fishing] == true)
        return SendErrorMessage(playerid, "You are fishing, use /stopfish. Relog if you are bugged.");
    
    TempVar[playerid][CheckpointType] =
    DisablePlayerCheckpoint(playerid);
    return 1;
}
alias:removecp("rcp");

stock ShowWeapons(playerid, targetid)
{
    SendClientMessageEx(targetid, COLOR_GREEN, "____________| %s's Weapons |____________", GetUserName(playerid));
    for (new i = 0; i < 13; i++)
	{
        new myweapons[13][2], weaponname[50];
		GetPlayerWeaponData(playerid, i, myweapons[i][0], myweapons[i][1]);
		if(myweapons[i][0] > 0)
		{
			if(PlayerInfo[playerid][pWeapon][i] == myweapons[i][0])
			{
				GetWeaponName(myweapons[i][0], weaponname, sizeof(weaponname));
				SendClientMessageEx(targetid, COLOR_GRAD5, "(ID: %d) %s (Ammo: %d)", myweapons[i][0], weaponname, myweapons[i][1]);
			}
		}
	}
}

CMD:weapons(playerid, params[])
{
    ShowWeapons(playerid, playerid);
    return 1;
}

CMD:enter(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid), sprayPrice = 500;
        if(PlayerInfo[playerid][pFaction] > 0)
        {
            new factionid = PlayerInfo[playerid][pFaction];
            if(FactionInfo[factionid][FactionGov] == 1)
            {
                sprayPrice = 0;
            }
        }
        for(new p = 0; p < sizeof(SprayShop); p++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, SprayShop[p][0], SprayShop[p][1], SprayShop[p][2]))
            {
                if(PlayerInfo[playerid][pMoney] >= sprayPrice)
                {
                    SetVehiclePos(vehicleid, SprayShop[p][4], SprayShop[p][5], SprayShop[p][6]);
                    TogglePlayerControllable(playerid, false);
                    TempVar[playerid][SprayID] = p;
                    if(sprayPrice >= 1)
                    {
                        TakeMoney(playerid, sprayPrice);
                    }
                    SetTimerEx("OnSprayShop", 5000, false, "d", playerid);
                    SprayShopUsed[p] = true;
                }
            }
        } 
    }
    House_HandleEnter(playerid);
    Biz_HandleEnter(playerid);
    Entrance_HandleEnter(playerid);
    Complex_HandleEnter(playerid);
    return 1;
}

function OnSprayShop(playerid)
{
    new carid = GetPlayerVehicleID(playerid), sprayid = TempVar[playerid][SprayID];

	SetVehiclePos(carid,SprayShop[sprayid][0],SprayShop[sprayid][1],SprayShop[sprayid][2] + 0.5);
	SetVehicleZAngle(carid,SprayShop[sprayid][3]);

    RepairVehicle(carid);
    SprayShopUsed[sprayid] = false;
    TempVar[playerid][SprayID] = 0;
    TogglePlayerControllable(playerid, true);
    return 1;
}

CMD:exit(playerid, params[])
{
    House_HandleExit(playerid);
    Biz_HandleExit(playerid);
    Entrance_HandleExit(playerid);
    Complex_HandleExit(playerid);
    return 1;
}


CMD:setspawn(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/setspawn [Newbie, House, Faction]");

    if(strcmp(params, "newbie", true) == 0)
    {
        PlayerInfo[playerid][pSpawn] = 0;
        SendServerMessage(playerid, "Your spawn has been set to the newbie spawn.");
    }
    else if(strcmp(params, "house", true) == 0)
    {
        if(PlayerInfo[playerid][pRenting] > 0 || GetPlayerHouses(playerid) > 0)
        {
            new houseid = IsPlayerInsideHouse(playerid);
            if(houseid != -1 && HouseInfo[houseid][HouseOwnerID] == PlayerInfo[playerid][pCharacterID])
            {
                PlayerInfo[playerid][pSpawn] = 1;
                PlayerInfo[playerid][pHouseSpawnID] = HouseInfo[houseid][HouseID];
                SendServerMessage(playerid, "Your spawn has been set to your house.");
                return 1;
            }
            if(houseid != -1 && PlayerInfo[playerid][pRenting] == HouseInfo[houseid][HouseID])
            {
                PlayerInfo[playerid][pSpawn] = 1;
                PlayerInfo[playerid][pHouseSpawnID] = HouseInfo[houseid][HouseID];
                SendServerMessage(playerid, "Your spawn has been set to your house.");
                return 1;
            }
            SendErrorMessage(playerid, "You must be inside the house you wish to spawn at.");
        }
        else SendErrorMessage(playerid, "You do not own/rent a house.");
    }
    else if(strcmp(params, "faction", true) == 0)
    {
        if(PlayerInfo[playerid][pFaction] > 0)
        {
            PlayerInfo[playerid][pSpawn] = 2;
            SendServerMessage(playerid, "Your spawn has been set to your faction.");
        }
        else SendErrorMessage(playerid, "You are not a faction member.");
    }
    else SendUsageMessage(playerid, "Please type in \"Newbie\", \"House\" or \"Faction\".");
    new string[256];
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Spawn` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pSpawn], PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
    return 1;
}

CMD:buyaccessories(playerid, params[])
{
    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 3)
                {
                    new string[128*180];
                    format(string, sizeof string, "Price\t\tName\n");
                    for(new a; a < sizeof(ShopAttachments); a++)
                    {
                        format(string, sizeof string, "%s$%d\t\t%s\n", string, ShopAttachments[a][Price], ShopAttachments[a][Name]);
                    }
                    Dialog_Show(playerid, Dialog_BuyAttachments, DIALOG_STYLE_TABLIST_HEADERS, "Buy Accessories", string, "View", "Close");
                    return 1;
                }
                return SendErrorMessage(playerid, "You are not inside the correct business.");
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a business.");
    return 1;
}

Dialog:Dialog_BuyAttachments(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid && BusinessInfo[i][BizType] == 3)
            {
                for(new a; a < sizeof(ShopAttachments); a++)
                {
                    if(listitem == a)
                    {
                        SetPlayerAttachedObject(playerid, SLOT_MISC, ShopAttachments[a][Model], 2);
                        TempVar[playerid][EditType] = EDIT_TYPE_BUY_ACCESSORY;
                        EditAttachedObject(playerid, SLOT_MISC);
                        return 1;
                    }
                }
            }
        }
        SavePlayerClothing(playerid);
    }
    return 1;
}

Dialog:SavingsWithdraw(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128];
        format(string, sizeof string, "%s has withdrawn $%s from their savings account.", FormatNumber(PlayerInfo[playerid][pSavings]));
        SendAdminWarning(1, string);
        format(string, sizeof string, "%s (IP: %s AccountID: %d) has withdraw $%s from their savings account.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], FormatNumber(PlayerInfo[playerid][pSavings]));
        DBLog("Transaction", string);
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have withdrawn $%s from your savings account.", FormatNumber(PlayerInfo[playerid][pSavings]));
        GiveMoney(playerid, PlayerInfo[playerid][pSavings]);
        PlayerInfo[playerid][pSavings] = 0;
    }
    return 1;
}

Dialog:SavingsDeposit(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[128];
        if(isnull(inputtext))
        {
            format(string, sizeof string, "{FF6347}ERROR: {FFFFFF}You must type in a number between 1000 and 50000.\n\nYou can put in a minimum of $1,000 which will increase by 0.1 percent per payday\nYour savings will then capped at $50,000, meaning you cannot save more than that amount.");
            Dialog_Show(playerid, SavingsDeposit, DIALOG_STYLE_INPUT, "Savings", string, "Deposit", "Exit");
            return 1;
        }

        if(!IsNumeric(inputtext))
        {
            format(string, sizeof string, "{FF6347}ERROR: {FFFFFF}You must type in a number between 1000 and 50000.\n\nYou can put in a minimum of $1,000 which will increase by 0.1 percent per payday\nYour savings will then capped at $50,000, meaning you cannot save more than that amount.");
            Dialog_Show(playerid, SavingsDeposit, DIALOG_STYLE_INPUT, "Savings", string, "Deposit", "Exit");
            return 1;
        }

        new amount = strval(inputtext);

        if(amount < 1000 || amount > 50000)
        {
            format(string, sizeof string, "{FF6347}ERROR: {FFFFFF}You must type in a number between 1000 and 50000.\n\nYou can put in a minimum of $1,000 which will increase by 0.1 percent per payday\nYour savings will then capped at $50,000, meaning you cannot save more than that amount.");
            Dialog_Show(playerid, SavingsDeposit, DIALOG_STYLE_INPUT, "Savings", string, "Deposit", "Exit");
            return 1;
        }

        format(string, sizeof string, "%s has deposited $%s into their savings account.", FormatNumber(amount));
        SendAdminWarning(1, string);
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have deposited $%s into your savings account.", FormatNumber(amount));
        TakeMoney(playerid, amount);
        PlayerInfo[playerid][pSavings] = amount;
        format(string, sizeof string, "%s (IP: %s AccountID: %d) has deposited $%s into their savings account.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], FormatNumber(amount));
        DBLog("Transaction", string);
    }
    return 1;
}

CMD:savings(playerid, params[])
{
    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 9)
                {
                    new string[128];
                    if(PlayerInfo[playerid][pSavings] >= 1)
                    {
                        format(string, sizeof string, "{FFFFFF}You current have $%s in your savings.\nPress 'Withdraw' to withdraw it all.", FormatNumber(PlayerInfo[playerid][pSavings]));
                        Dialog_Show(playerid, SavingsWithdraw, DIALOG_STYLE_LIST, "Savings", string, "Withdraw", "Exit");
                    }
                    else
                    {
                        format(string, sizeof string, "{FFFFFF}You can put in a minimum of $1,000 which will increase by 0.1 percent per payday\nYour savings will then capped at $50,000, meaning you cannot save more than that amount.");
                        Dialog_Show(playerid, SavingsDeposit, DIALOG_STYLE_INPUT, "Savings", string, "Deposit", "Exit");
                    }
                    return 1;
                }
                return SendErrorMessage(playerid, "You are not inside a bank.");
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a bank.");
    return 1;
}

CMD:deposit(playerid, params[])
{
    new amount;
    if(sscanf(params, "d", amount))
        return SendUsageMessage(playerid, "/deposit (/bank) [amount]");
    
    if(amount < 1 || amount > PlayerInfo[playerid][pMoney])
        return SendErrorMessage(playerid, "Invalid amount.");

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 9)
                {
                    TakeMoney(playerid, amount);
                    PlayerInfo[playerid][pBank] += amount;
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have deposited $%s into your bank account.", FormatNumber(amount));
                    return 1;
                }
                return SendErrorMessage(playerid, "You are not inside the correct business.");
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a business.");
    return 1;
}
alias:deposit("bank");

CMD:balance(playerid, params[])
{
    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 9)
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "____________| Bank Statement |____________");
                    SendClientMessageEx(playerid, COLOR_WHITE, "You have $%s in your bank account.", FormatNumber(PlayerInfo[playerid][pBank]));
                    return 1;
                }
                return SendErrorMessage(playerid, "You are not inside a bank.");
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a bank.");
    return 1;
}

CMD:withdraw(playerid, params[])
{
    new amount;
    if(sscanf(params, "d", amount))
        return SendUsageMessage(playerid, "/withdraw [amount]");
    
    if(amount < 1 || amount > PlayerInfo[playerid][pBank])
        return SendErrorMessage(playerid, "Invalid amount.");

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 9)
                {
                    GiveMoney(playerid, amount);
                    PlayerInfo[playerid][pBank] -= amount;
                    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have withdrawn $%s from your bank account.", FormatNumber(amount));
                    return 1;
                }
                return SendErrorMessage(playerid, "You are not inside a bank.");
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a bank.");
    return 1;
}

Dialog:Dialog_GunShop(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new bizid = IsPlayerInsideBiz(playerid), str[128];
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid && BusinessInfo[i][BizType] == 4)
            {
                new serial = Random(10000, 999999999), valstring[128];
                valstr(valstring, serial);
                switch(listitem)
                {
                    case 0:
                    {
                        if(PlayerInfo[playerid][pMoney] < 400)
                            return SendErrorMessage(playerid, "You do not have enough, you need $500.");

                        AddInventory(playerid, INV_GUN, 100, 22, serial);

                        new lockerinfo[256];
			            format(lockerinfo, sizeof(lockerinfo), "Store: %s", BusinessInfo[i][BizName]);
                        AddWeaponToRegistry(playerid, lockerinfo, valstring, GetServerWeaponName(22));
                        format(str, sizeof(str), "%s bought a Colt 54 with 100 ammo.", GetUserName(playerid));
                        SendAdminWarning(1, str);
                        TakeMoney(playerid, 400);
                        BusinessInfo[bizid][BizSafe] += 400;
                        return 1;
                    }
                    case 1:
                    {
                        if(PlayerInfo[playerid][pMoney] < 600)
                            return SendErrorMessage(playerid, "You do not have enough, you need $200.");

                        AddInventory(playerid, INV_GUN, 100, 24, serial);
                        
                        new lockerinfo[256];
			            format(lockerinfo, sizeof(lockerinfo), "Store: %s", BusinessInfo[i][BizName]);
                        AddWeaponToRegistry(playerid, lockerinfo, valstring, GetServerWeaponName(24));
                        format(str, sizeof(str), "%s bought a Deagle with 100 ammo.", GetUserName(playerid));
                        SendAdminWarning(1, str);
                        TakeMoney(playerid, 600);
                        BusinessInfo[bizid][BizSafe] += 600;
                        return 1;
                    }
                    case 2:
                    {
                        if(PlayerInfo[playerid][pMoney] < 350)
                            return SendErrorMessage(playerid, "You do not have enough, you need $350.");

                        AddInventory(playerid, INV_GUN, 50, 25, serial);

                        new lockerinfo[256];
			            format(lockerinfo, sizeof(lockerinfo), "Store: %s", BusinessInfo[i][BizName]);
                        AddWeaponToRegistry(playerid, lockerinfo, valstring, GetServerWeaponName(25));
                        format(str, sizeof(str), "%s bought a Shotgun with 50 ammo.", GetUserName(playerid));
                        SendAdminWarning(1, str);
                        TakeMoney(playerid, 350);
                        BusinessInfo[bizid][BizSafe] += 350;
                        return 1;
                    }
                    case 3:
                    {
                        if(PlayerInfo[playerid][pMoney] < 250)
                            return SendErrorMessage(playerid, "You do not have enough, you need $250.");

                        AddInventory(playerid, INV_GUN, 50, 33, serial);

                        new lockerinfo[256];
			            format(lockerinfo, sizeof(lockerinfo), "Store: %s", BusinessInfo[i][BizName]);
                        AddWeaponToRegistry(playerid, lockerinfo, valstring, GetServerWeaponName(33));
                        format(str, sizeof(str), "%s bought a Country Rifle with 50 ammo.", GetUserName(playerid));
                        SendAdminWarning(1, str);
                        TakeMoney(playerid, 250);
                        BusinessInfo[bizid][BizSafe] += 250;
                        return 1;
                    }
                    case 4:
                    {
                        if(PlayerInfo[playerid][pMoney] < 200)
                            return SendErrorMessage(playerid, "You do not have enough, you need $250.");

                        SetPlayerArmourEx(playerid, 50.0);
                        format(str, sizeof(str), "%s bought body armour with 50 armour points.", GetUserName(playerid));
                        SendAdminWarning(1, str);
                        TakeMoney(playerid, 200);
                        BusinessInfo[bizid][BizSafe] += 200;
                        return 1;
                    }
                }
                new string[256];
                mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
                mysql_tquery(g_SQL, string);
            }
        }
        return SendErrorMessage(playerid, "You are not inside the correct business.");
    }
    return 1;
}

stock ShowShopMenu(playerid, bizid)
{
    Dialog_Show(playerid, Dialog_Shop, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Product\t\tPrice\n\
        Radio\t\t$50\n\
        Phone\t\t$100\n\
        Phone Credit\t\t$10\n\
        Baseball Bat\t\t$50\n\
        Flowers\t\t$50\n\
        Cigarette\t\t$10\n\
        Sprunk\t\t$1\n\
        Lotto Ticket\t\t$1\n\
        Boombox\t\t$100", "Buy", "Close");
}

CMD:buy(playerid, params[])
{
    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 1)
                {
                    ShowShopMenu(playerid, i);
                }
                else if(BusinessInfo[i][BizType] == 3)
                {
                    TempVar[playerid][BuyClothes] = i;
                    ShowModelSelectionMenu(playerid, BuyList, BusinessInfo[i][BizName]);
                }
                else if(BusinessInfo[i][BizType] == 4)
                {
                    if(!GetInventory(playerid, INV_WEP_LIC))
                        return SendErrorMessage(playerid, "You do not have a weapons license. You can get one from the BCSD.");

                    Dialog_Show(playerid, Dialog_GunShop, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Weapon\tPrice\tAmmo\n9mm\t$200\t100\nDeagle\t$200\t100\nShotgun\t$350\t50\nCountry Rifle\t$250\t50", "Buy", "Close");
                }
                else if(BusinessInfo[i][BizType] == 5)
                {
                    Dialog_Show(playerid, Dialog_Bar, DIALOG_STYLE_LIST, BusinessInfo[bizid][BizName], "Beer\nWine\nSprunk", "Buy", "Close");
                }
                else SendErrorMessage(playerid, "You are not inside the correct business.");
                return 1;
            }
        }
    }
    else SendErrorMessage(playerid, "You are not inside a business.");
    return 1;
}

CMD:charity(playerid, params[])
{
    new amount;
    if(sscanf(params, "d", amount))
        return SendUsageMessage(playerid, "/charity [Amount]");

    TakeMoney(playerid, amount);
    SendClientMessageEx(playerid, COLOR_GREY, "You have donated $%s to charity!", FormatNumber(amount));
    new string[256];
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);

    format(string, sizeof string, "%s has donated $%s.", GetUserName(playerid), FormatNumber(amount));
    SendAdminWarning(1, string);
    return 1;
}

Dialog:Dialog_Bar(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid && BusinessInfo[i][BizType] == 5)
            {
                // Beer\nWine\nSprunk
                switch(listitem)
                {
                    case 0:
                    {   
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
                        SendClientMessage(playerid, COLOR_WHITE, "You have bought beer.");
                        TakeMoney(playerid, 5);
                        new string[256];
                        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
                        mysql_tquery(g_SQL, string);
                        BusinessInfo[bizid][BizSafe] += 5;
                        return 1;
                    }
                    case 1:
                    {   
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
                        SendClientMessage(playerid, COLOR_WHITE, "You have bought wine.");
                        TakeMoney(playerid, 10);
                        new string[256];
                        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
                        mysql_tquery(g_SQL, string);
                        BusinessInfo[bizid][BizSafe] += 10;
                        return 1;
                    }
                    case 2:
                    {   
                        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
                        SendClientMessage(playerid, COLOR_WHITE, "You have bought sprunk.");
                        TakeMoney(playerid, 2);
                        new string[256];
                        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
                        mysql_tquery(g_SQL, string);
                        BusinessInfo[bizid][BizSafe] += 2;
                        return 1;
                    }
                }
                return SendErrorMessage(playerid, "You are not inside the correct business.");
            }
        }
    }
    return 1;
}

Dialog:Dialog_Shop(playerid, response, listitem, inputtext[])
{
    if(!response) return 1;

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid && BusinessInfo[i][BizType] == 1)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        if(PlayerInfo[playerid][pMoney] < 50)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        if(GetInventory(playerid, INV_RADIO))
                            return SendErrorMessage(playerid, "You already own a radio.");
                        
                        AddInventory(playerid, INV_RADIO, 1);
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased a radio. Use /radiohelp for more help.");
                        TakeMoney(playerid, 50);
                        BusinessInfo[bizid][BizSafe] += 50;
                    }
                    case 1:
                    {
                        if(PlayerInfo[playerid][pMoney] < 100)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        new rand = random(89999999)+10000000;
                        AddInventory(playerid, INV_PHONE, rand);
                        SendClientMessageEx(playerid, COLOR_WHITE, "You have purchased a phone. Your number is %d.", rand);
                        TakeMoney(playerid, 100);
                        BusinessInfo[bizid][BizSafe] += 100;
                    }
                    case 2:
                    {
                        if(PlayerInfo[playerid][pMoney] < 10)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        PlayerInfo[playerid][pPhoneType] += 10;
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased $10 phone credits.");
                        TakeMoney(playerid, 10);
                        BusinessInfo[bizid][BizSafe] += 10;
                    }
                    case 3:
                    {
                        if(IsWeaponRestricted(playerid))
                            return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                        if(PlayerInfo[playerid][pMoney] < 50)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        GivePlayerGun(playerid, 5, 1, 0, false);
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased a baseball bat.");
                        TakeMoney(playerid, 50);
                        BusinessInfo[bizid][BizSafe] += 50;
                    }
                    case 4:
                    {
                        if(IsWeaponRestricted(playerid))
                            return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

                        if(PlayerInfo[playerid][pMoney] < 10)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        GivePlayerGun(playerid, 14, 1, 0, false);
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased flowers.");
                        TakeMoney(playerid, 10);
                        BusinessInfo[bizid][BizSafe] += 10;
                    }
                    case 5:
                    {
                        if(PlayerInfo[playerid][pMoney] < 10)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        AddInventory(playerid, INV_CIG, 20);
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased a pack of cigarettes. /inv to use it.");
                        TakeMoney(playerid, 10);
                        BusinessInfo[bizid][BizSafe] += 10;
                    }
                    case 6:
                    {
                        if(PlayerInfo[playerid][pMoney] < 1)
                            return SendErrorMessage(playerid, "You cannot afford this.");

                        AddInventory(playerid, INV_SPRUNK, 1);
                        SendClientMessage(playerid, COLOR_WHITE, "You have purchased a can of sprunk. /inv to use it.");
                        TakeMoney(playerid, 1);
                        BusinessInfo[bizid][BizSafe] += 1; 
                    }
                    case 7:
                    {
                        Dialog_Show(playerid, LottoMenu, DIALOG_STYLE_INPUT, "Lotto Ticket", "{FFFFFF}Enter a number between 1 and 100.", "Buy", "Back");
                    }
                    case 8:
                    {
                        OnPlayerAttemptBuyBoombox(playerid, bizid);
                    }
                }
            }
        }
        new string[256];
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, string);
    }
    return 1;
}

Dialog:LottoMenu(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(PlayerInfo[playerid][pLotto] > 0)
            return SendErrorMessage(playerid, "You already have a lotto ticket. Use /lotto for more information.");

        if(PlayerInfo[playerid][pMoney] < 1)
            return SendErrorMessage(playerid, "You need $1 for a Lottery Ticket.");
        
        if(isnull(inputtext))
            return Dialog_Show(playerid, LottoMenu, DIALOG_STYLE_INPUT, "Lotto Ticket", "{00FF00}ERROR: {AFAFAF}You must enter a valid number.\n\
            {FFFFFF}Enter a number between 1 and 100.", "Buy", "Back");
        
        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, LottoMenu, DIALOG_STYLE_INPUT, "Lotto Ticket", "{00FF00}ERROR: {AFAFAF}You did not enter a number.\n\
            {FFFFFF}Enter a number between 1 and 100.", "Buy", "Back");

        new lottoNumber = strval(inputtext);
        if(lottoNumber < 1 || lottoNumber > 100)
            return Dialog_Show(playerid, LottoMenu, DIALOG_STYLE_INPUT, "Lotto Ticket", "{00FF00}ERROR: {AFAFAF}Your Lotto Number can't be below 1 or above 100!\n\
            {FFFFFF}Enter a number between 1 and 100.", "Buy", "Back");
        
        SendActionMessage(playerid, "You have bought a lottery ticket with number %d.", lottoNumber);
        TakeMoney(playerid, 1);
        PlayerInfo[playerid][pLotto] = lottoNumber;
    }
    return 1;
}

new gJackpot;

CMD:lotto(playerid, params[])
{
    if(PlayerInfo[playerid][pLotto] > 0)
    {
        SendClientMessageEx(playerid, COLOR_PINK, "Your lottery number is %d. The current jackpot is $%s.", PlayerInfo[playerid][pLotto], FormatNumber(gJackpot));
    }
    else SendClientMessageEx(playerid, COLOR_PINK, "You can buy a lottery ticket at a 24/7. The current jackpot is $%s.", FormatNumber(gJackpot));
    return 1;
}

stock Lotto(number)
{
    if(gJackpot == 0 || gJackpot >= 5000) // This should keep the lotto jackpot to a more controllable level and prevent a gJackpot of 0.
    {
        new rand = random(1000)+1000; rand += floatround(rand/2);
	    gJackpot = rand;
    }
    new bool:JackpotFallen = false;
    foreach(new i: Player)
    {
        SendClientMessageEx(i, COLOR_PINK, "[LOTTO]: The winning number is %d.", number);
        if(PlayerInfo[i][pLotto] > 0)
        {
            if(PlayerInfo[i][pLotto] == number)
            {
                JackpotFallen = true;
                SendActionMessage(i, "You have won $%s with your lottery. It was placed into your bank account.", FormatNumber(gJackpot));
            }
            else SendCancelMessage(i, "You did not win the lottery this time, better luck next time.");
        }
        PlayerInfo[i][pLotto] = 0;
    }
    if(JackpotFallen == true)
    {
        new rand = random(1000)+1000; rand += floatround(rand/2);
	    gJackpot = rand;
    } 
    else
    {
	    gJackpot += floatround(gJackpot/2);
    }
    SendClientMessageToAllEx(COLOR_PINK, "[LOTTO]: A new jackpot has been started with $%s.", FormatNumber(gJackpot));
    return 1;
}

CMD:startlotto(playerid, params[])
{
    if(IsAdminLevel(playerid, 5))
    {
        new number = 0, string[128];
        if(!sscanf(params, "D(0)", number))
        {
            if(number == 0)
            {
                number = random(100)+1;
            }
            
            SendClientMessageToAllEx(COLOR_PINK, "[LOTTO]: We have started a lottery.");
            format(string, sizeof string, "%s %s has started the lottery.", GetAdminRank(playerid), GetMasterName(playerid));
            SendAdminWarning(1, string);
            Lotto(number);
        }

    }
    return 1;
}

stock GetPlayerBone(bone)
{
    new bonestr[32];
    switch(bone)
    {
        case 1: bonestr = "Spine";
        case 2: bonestr = "Head";
        case 3: bonestr = "Left Upper Arm";
        case 4: bonestr = "Right Upper Arm";
        case 5: bonestr = "Left Hand";
        case 6: bonestr = "Right Hand";
        case 7: bonestr = "Left Thigh";
        case 8: bonestr = "Right Thigh";
        case 9: bonestr = "Left Foot";
        case 10: bonestr = "Right Foot";
        case 11: bonestr = "Right Calf";
        case 12: bonestr = "Left Calf";
        case 13: bonestr = "Left Forearm";
        case 14: bonestr = "Right Forearm";
        case 15: bonestr = "Left Shoulder";
        case 16: bonestr = "Right Shoulder";
        case 17: bonestr = "Neck";
        case 18: bonestr = "Jaw";
        case 19: bonestr = "Undefined";
    }
    return bonestr;
}

CMD:weapon(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/weapon [Adjust/Bone/Reset] - You must actually have the weapon on person but unscrolled to adjust it.");

    if(PlayerInfo[playerid][pPrimaryWeapon] > 0)
    {
        if(GetPlayerWeapon(playerid) != PlayerInfo[playerid][pPrimaryWeapon])
        {
            if(strcmp(params, "adjust", true) == 0)
            {
                TempVar[playerid][EditType] = EDIT_TYPE_PRIMARY_WEP;
                EditAttachedObject(playerid, SLOT_WEAPON);
            }
            else if(strcmp(params, "bone", true) == 0)
            {
                Dialog_Show(playerid, AdjustWeaponBone, DIALOG_STYLE_LIST, "Adjust Weapon Bone", "Spine\n\
                Left Upper Arm\n\
                Right Upper Arm\n\
                Left Hand\n\
                Right Hand\n\
                Left Thigh\n\
                Right Thigh\n\
                Left Foot\n\
                Right Foot", "Select", "Cancel");
            }
            else if(strcmp(params, "reset", true) == 0)
            {
                PlayerInfo[playerid][pWeaponBone] = 1;
				PlayerInfo[playerid][pWeaponX] = 0.139415;
				PlayerInfo[playerid][pWeaponY] = -0.167970;
				PlayerInfo[playerid][pWeaponZ] = 0.120848;
				PlayerInfo[playerid][pWeaponRX] = 0.000000;
				PlayerInfo[playerid][pWeaponRY] = 152.342666;
				PlayerInfo[playerid][pWeaponRZ] = 0.000000;
				PlayerInfo[playerid][pWeaponSX] = 1.0;
				PlayerInfo[playerid][pWeaponSY] = 1.0;
				PlayerInfo[playerid][pWeaponSZ] = 1.0;

				RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Weapon Slot reset. It should appear within a second.");
            }
        }
        else SendErrorMessage(playerid, "You must not be holding this weapon. Unscroll it.");
    }
    else SendErrorMessage(playerid, "You must have a weapon to adjust.");
    return 1;
}

Dialog:AdjustWeaponBone(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
        PlayerInfo[playerid][pWeaponBone] = listitem+1;
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Weapon Bone modified to %s. It should appear within a second.", GetPlayerBone(PlayerInfo[playerid][pWeaponBone]));
    }
    return 1;
}

CMD:respawnme(playerid, params[])
{
    if(GetPlayerTeam(playerid) == PLAYER_DEAD)
    {
        if(TempVar[playerid][KillTime] >= 1)
            return SendErrorMessage(playerid, "The timer has not completed yet, please wait %d seconds.", TempVar[playerid][KillTime]);

        TogglePlayerControllable(playerid, 1); 
        SetPlayerTeam(playerid, PLAYER_ALIVE);

        SetPlayerChatBubble(playerid, "(( Respawned ))", COLOR_WHITE, 21.0, 3000); 
        StopAnim(playerid);

        SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 998);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 998);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 998);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 999);
        SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 999);
        ClearDamages(playerid);    
        TempVar[playerid][AcceptedDeath] = true;
        SetPlayerHealthEx(playerid, 0); 
    }
    else SendErrorMessage(playerid, "You are not dead.");
    return 1;
}

CMD:bugreport(playerid, params[])
{
    SendErrorMessage(playerid, "Bug reports go on the forum: https://dc-rp.com/forum");
    return 1;
}

CMD:frisk(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid))
        return SendUsageMessage(playerid, "/frisk [PlayerID/Name]");

    TempVar[targetid][FriskRequest] = playerid;
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have sent a frisk request to %s. Wait for their response.", GetRPName(targetid));
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "%s wants to frisk you. Type \"/accept frisk\" to approve.", GetRPName(playerid));
    return 1;
}

stock FriskPlayer(playerid, targetid)
{
    SendClientMessageEx(playerid, COLOR_GREEN, "|________________ Items on %s ________________|", GetRPName(targetid));
    if(PlayerInfo[targetid][pMoney] > 1000)
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* More than $1,000.");
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* $%s.", FormatNumber(PlayerInfo[targetid][pMoney]));
    }
    if(GetInventoryAmount(targetid, GetInventorySlot(targetid, INV_PHONE)) != 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "* Phone.");
    }
    if(GetInventory(playerid, INV_RADIO))
    {
        SendClientMessage(playerid, COLOR_GREY, "* Radio.");
    }
    if(GetInventory(playerid, INV_CIG))
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* %d cigarettes.", PlayerInfo[targetid][pCigarettes]);
    }
    if(GetInventory(playerid, INV_WEED))
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* %d grams of weed.", PlayerInfo[targetid][pWeed]);
    }
    if(GetInventory(playerid, INV_WEED_SEED))
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* %d weed seeds.", PlayerInfo[targetid][pWeedSeeds]);
    }
    if(PlayerInfo[targetid][pPoppySeeds] >= 1)
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* %d poppy seeds.", PlayerInfo[targetid][pPoppySeeds]);
    }
    if(PlayerInfo[targetid][pWires] >= 1)
    {
        SendClientMessageEx(playerid, COLOR_GREY, "* %d wires.", PlayerInfo[targetid][pWires]);
    }
    new weapons[13], weaponAmmo[13];
    for(new i; i < 13; i++)
    {
        GetPlayerWeaponData(targetid, i, weapons[i], weaponAmmo[i]);
        if(weapons[i] > 0 && weaponAmmo[i] > 0)
        {
            SendClientMessageEx(playerid, COLOR_GREY, "* %s (%d Ammo).", GetServerWeaponName(weapons[i]), weaponAmmo[i]);
        }
    }
    return 1;
}

/*#define MAX_ITEM_DROP 100

enum itemDropEnum
{
    ItemType,
    ItemModelID,
    ItemAmount,
    ItemDroppedBy[MAX_PLAYER_NAME],
    ItemDroppedWhen[32],
    ItemDropTimer,
    ItemDropObject,
    Text3D:ItemDropLabel
}
new ItemDrop[MAX_ITEM_DROP][itemDropEnum];

CMD:dropitem(playerid, params[])
{
    if(PlayerInfo[playerid][pHoldingInv] != INV_NONE)
    {
        new modelID, itemType;
        for(new i; i < sizeof(GlobalInventory); i++)
        {
            if(GlobalInventory[i][ItemType] != INV_DRV_LIC
                && GlobalInventory[i][ItemType] != INV_WEP_LIC
                && GlobalInventory[i][ItemType] != INV_FLY_LIC
                && GlobalInventory[i][ItemType] != INV_NONE)
            {
                itemType = GlobalInventory[i][ItemType];
                modelID = GlobalInventory[i][ItemModelID];
                break;
            }
        }

        for(new i; i < MAX_ITEM_DROP; i++)
        {
            if(ItemDrop[i][itemType] == INV_NONE)
            {
                ItemDrop[i][ItemModelID] = CreateDynamicObject(itemType,
                    x,
                    y,
                    z - 1,
                    0.0,
                    0.0,
                    0.0,
                    GetPlayerVirtualWorld(playerid),
                    GetPlayerInterior(playerid)); 
                return 1;
            }
        }
    }
    return 1;
}*/