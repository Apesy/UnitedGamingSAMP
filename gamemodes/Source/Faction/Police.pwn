//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:impound(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1 || FactionInfo[factionid][FactionImpound] == 0)
        return SendErrorMessage(playerid, "You can't use this command.");

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
        return SendErrorMessage(playerid, "You need to be inside a tow truck.");

    if(IsPlayerInRangeOfPoint(playerid, 50.0, -309.1056, 2662.1003, 62.6773))
    {
        if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
        {
            for(new i; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vScriptID] == GetVehicleTrailer(GetPlayerVehicleID(playerid)))
                {
                    if(VehicleInfo[i][vOwnerID] == 0) return SendErrorMessage(playerid, "You cannot impound vehicles that do not have an owner.");
                    if(VehicleInfo[i][vFactionID] > 0) return SendErrorMessage(playerid, "You cannot impound faction vehicles.");
                    new iVeh = GetVehicleTrailer(GetPlayerVehicleID(playerid));
                    GetVehiclePos(iVeh, VehicleInfo[i][vImpoundPos][0], VehicleInfo[i][vImpoundPos][1], VehicleInfo[i][vImpoundPos][2]);
                    GetVehicleZAngle(iVeh, VehicleInfo[i][vImpoundPos][3]);
                    VehicleInfo[i][vInterior] = GetPlayerInterior(playerid);
                    VehicleInfo[i][vVW] = GetVehicleVirtualWorld(iVeh);

                    SaveVehicle(i);
                    ResetVehicleVars(i);
                    DestroyVehicle(i);
                    new string[128];
                    format(string, sizeof string, "%s %s has impounded vehicle %d (%s)", GetPlayerRank(playerid), GetRPName(playerid), i, ReturnVehicleName(VehicleInfo[i][vScriptID]));
                    SendAdminWarning(1, string);
                    return 1;
                }
            }
            SendErrorMessage(playerid, "Cannot impound vehicle.");
        }
        else SendErrorMessage(playerid, "You are not towing a vehicle.");
    }
    else SendErrorMessage(playerid, "You are not at the impound lot.");
    return 1;
}

CMD:vfine(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[factionid][FactionTicket] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

    new targetid, amount, reason[128];
    if(sscanf(params, "dds[128]", targetid, amount, reason))
    {
        SendUsageMessage(playerid, "/vfine [VehicleID(/dl)] [Amount] [Reason]");
        return 1;
    }

    if(IsPlayerNearVehicle(playerid, targetid, 10.0))
    {
        AddVehicleFine(playerid, targetid, amount, reason);
    }
    return 1;
}

stock AddVehicleFine(playerid, vehicleid, amount, reason[])
{
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == vehicleid)
        {
            VehicleInfo[i][vFineAmount] = amount;
            VehicleInfo[i][vFineFactionID] = PlayerInfo[playerid][pFaction];
            VehicleInfo[i][vFineTime] = gettime();
            VehicleInfo[i][vFineOfficerID] = PlayerInfo[playerid][pCharacterID];
            format(VehicleInfo[i][vFineAmount], 128, "%s", reason);

            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}Fine issued on Vehicle %d for $%s. Reason: %s", vehicleid, FormatNumber(amount), reason);

            new string[128];
            format(string, sizeof(string), "%s %s has fined vehicle %d for $%s. Reason: %s", GetPlayerRank(playerid), GetUserName(playerid), vehicleid, FormatNumber(amount), reason);
            SendAdminWarning(1, string);
            SaveVehicle(i);
            return 1;
        }
    }
    SendErrorMessage(playerid, "Cannot fine vehicle (Bugged or Admin Spawned).");
    return 1;
}

CMD:excusefine(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionTicket] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

    new fineid, query[128];
    if(sscanf(params, "d", fineid))
    {
        SendUsageMessage(playerid, "/excusefine [playerid or name]");
        return 1;
    }

    mysql_format(g_SQL, query, sizeof(query), "UPDATE `fines` SET `Active` = 0 WHERE `ID` = %d LIMIT 1", fineid);
    mysql_tquery(g_SQL, query, "OnExcuseFine", "ii", playerid, fineid);
    return 1;
}

function OnExcuseFine(playerid, fineid)
{
    SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s has excused fine #%d.", GetPlayerRank(playerid), GetUserName(playerid));
    return 1;
}

CMD:myfines(playerid, params[])
{
    GetFines(playerid, playerid);
    return 1;
}

CMD:fines(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionTicket] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

    new target;
    if(sscanf(params, "u", target))
        return SendUsageMessage(playerid, "/fines [PlayerID/PartOfName]");
    
    GetFines(target, playerid);
    return 1;
}

stock GetFines(playerid, targetid)
{
    new query[256];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `fines` WHERE `UserID` = %d AND `Active` = 1 LIMIT 20", PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, query, "OnGetFines", "dd", targetid, playerid);
}

function OnGetFines(playerid, targetid)
{
    new string[128*20], rows = cache_num_rows();
    if(rows > 0)
    {
        format(string, sizeof string, "Amount\tFaction\tReason\n");
        for(new i; i < rows; i++)
        {
            new price,faction,reason[32];
            cache_get_value_int(i, "Amount", price);
            cache_get_value_int(i, "FactionID", faction);
            cache_get_value(i, "Reason", reason, 32);
            format(string, sizeof string, "%s$%s\t%s\t%s\n", string, FormatNumber(price), FactionInfo[faction][FactionName], reason);
        }

        Dialog_Show(targetid, Unused, DIALOG_STYLE_TABLIST_HEADERS, "Active Fines", string, "Okay", "");
    }
    else SendErrorMessage(targetid, "No active fines.");
    return 1;
}

CMD:payfine(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 1346.8292,1571.4750,-13.5820))
    {
        new query[256];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `fines` WHERE `UserID` = %d AND `Active` = 1 LIMIT 20", PlayerInfo[playerid][pCharacterID]);
        mysql_tquery(g_SQL, query, "OnGetPayFines", "d", playerid);
    }
    return 1;
}

new FineID[MAX_PLAYERS][20];
new FinePrice[MAX_PLAYERS][20];
new FineFaction[MAX_PLAYERS][20];
function OnGetPayFines(playerid)
{
    new string[128*20], rows = cache_num_rows();
    if(rows > 0)
    {
        new count = 0;
        format(string, sizeof string, "Amount\tFaction\tReason\n");
        for(new i; i < rows; i++)
        {
            new price,faction,reason[32];
            cache_get_value_int(i, "ID", FineID[playerid][i]);
            cache_get_value_int(i, "Amount", FinePrice[playerid][i]);
            cache_get_value_int(i, "FactionID", FineFaction[playerid][i]);
            cache_get_value(i, "Reason", reason, 32);
            format(string, sizeof string, "%s$%s\t%s\t%s\n", string, FormatNumber(price), FactionInfo[faction][FactionName], reason);
            count++;
        }
        Dialog_Show(playerid, PayFines, DIALOG_STYLE_TABLIST_HEADERS, "Pay Fine", string, "Pay", "Close");
    }
    else SendErrorMessage(playerid, "You have no active fines.");
    return 1;
}

Dialog:PayFines(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(PlayerInfo[playerid][pMoney] >= FinePrice[playerid][listitem])
        {
            new query[256];
            TakeMoney(playerid, FinePrice[playerid][listitem]);
            SendServerMessage(playerid, "You have paid your $%s fine.", FormatNumber(FinePrice[playerid][listitem]));
            SendFactionMessage(FineFaction[playerid][listitem], COLOR_POLICE, "%s has paid their $%s fine.", FormatNumber(FinePrice[playerid][listitem]));
            mysql_format(g_SQL, query, sizeof query, "UPDATE `fines` SET `Active` = 0 WHERE `ID` = %d LIMIT 1", FineID[playerid][listitem]);
            mysql_tquery(g_SQL, query);
        }
        else SendErrorMessage(playerid, "You cannot afford to pay this $%s fine.", FormatNumber(FinePrice[playerid][listitem]));
    }
    return 1;
}

CMD:fine(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionTicket] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    if(!IsOnDuty(playerid))
        return SendErrorMessage(playerid, "You need to be on duty.");

    new targetid, amount, reason[128];
    if(sscanf(params, "uds[128]", targetid, amount, reason))
    {
        SendUsageMessage(playerid, "/fine [playerid or name] [Amount] [Reason]");
        return 1;
    }

    if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "You specified an invalid player.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    AddFine(targetid, playerid, amount, reason);
    return 1;
}

stock AddFine(playerid, officerid, amount, reason[])
{
    new string[256];
    mysql_format(g_SQL, string, sizeof string, "INSERT INTO `fines` (`UserID`, `OfficerID`, `FactionID`, `Reason`, `Timestamp`, `Amount`, `Active`) VALUES (%d, %d, %d, '%e', %d, %d, 1);", 
        PlayerInfo[playerid][pCharacterID],PlayerInfo[officerid][pCharacterID],PlayerInfo[officerid][pFaction], reason, gettime(), amount);
    mysql_tquery(g_SQL, string, "OnAddFine", "ddds", playerid, officerid, amount, reason);
}

function OnAddFine(playerid, officerid, amount, reason[])
{
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}Fine issued by %s %s for $%s. Reason: %s", GetPlayerRank(officerid), GetRPName(officerid), FormatNumber(amount), reason);
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}You can pay this fine at the town hall.");
    SendClientMessageEx(officerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}Fine issued on %s for $%s. Reason: %s", GetRPName(playerid), FormatNumber(amount), reason);

    new string[128];
    format(string, sizeof(string), "%s %s has fined %s for $%s. Reason: %s", GetPlayerRank(officerid), GetUserName(officerid), GetUserName(playerid), FormatNumber(amount), reason);
    SendAdminWarning(1, string);
    return 1;
}

// Commented out until further notice.
/*CMD:bk(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionBackup] == 0)
        return SendErrorMessage(playerid, "You can't use this command.");

    if(TempVar[playerid][BackupRequsted] == false)
    {
        foreach(new i: Player)
        {
            if(PlayerInfo[playerid][pFaction] == PlayerInfo[i][pFaction])
            {
                SetPlayerMarkerForPlayer(i, playerid, 0xFF0000FF);
            }
        }
        TempVar[playerid][BackupRequsted] = true;
        SendFactionDutyMessage(PlayerInfo[playerid][pFaction], COLOR_POLICE, "DISPATCH: %s %s is requesting backup at %s. They've been marked on the GPS.", GetPlayerRank(playerid), GetRPName(playerid), ReturnLocation(playerid));
        SendClientMessageEx(playerid, COLOR_WHITE, "Type \"/bk\" again to clear your backup request.");
    }
    else
    {
        foreach(new i: Player)
        {
            SetPlayerMarkerForPlayer(i, playerid, COLOR_WHITE);
        }
        TempVar[playerid][BackupRequsted] = false;
        SendFactionDutyMessage(PlayerInfo[playerid][pFaction], COLOR_POLICE, "DISPATCH: %s %s has cancelled their backup request.", GetPlayerRank(playerid), GetRPName(playerid));
        SendClientMessageEx(playerid, COLOR_WHITE, "Your backup request has been cleared.");
    }
    return 1;
}*/

stock AddCharge(playerid, playerb, charge[])
{
    new add_query[256];
    mysql_format(g_SQL, add_query, sizeof(add_query), "INSERT INTO CriminalRecords (CharacterName, Charge, Timestamp, Active, OfficerID) VALUES('%e', '%e', %d, 1, %d)", GetUserName(playerb), charge, gettime(), PlayerInfo[playerid][pCharacterID]);
	mysql_tquery(g_SQL, add_query, "OnPlayerAddCharge", "iss", playerid, GetUserName(playerb), charge);
}

stock AddChargeEx(playerid, playername[], charge[])
{
    new add_query[256];
    mysql_format(g_SQL, add_query, sizeof(add_query), "INSERT INTO CriminalRecords (CharacterName, Charge, Timestamp, Active, OfficerID) VALUES('%e', '%e', %d, 1, %d)", playername, charge, gettime(), PlayerInfo[playerid][pCharacterID]);
	mysql_tquery(g_SQL, add_query, "OnPlayerAddCharge", "iss", playerid, playername, charge);
}


function OnPlayerAddCharge(playerid, suspect[], charge[])
{
    foreach(new i: Player)
    {
        if(PlayerInfo[i][pFaction] > 0 && FactionInfo[PlayerInfo[i][pFaction]][FactionSuspect] == 1)
        {
            if(strlen(charge) > 70)
            {
                SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: Reporter: %s, Suspect: %s, Reason: %.70s ...", GetRPName(playerid), suspect, charge);
                SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: ... %s", charge[70]);
            }
            else SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: Reporter: %s, Suspect: %s, Reason: %s", GetRPName(playerid), suspect, charge);
        }
    }
	return 1; 
}

CMD:prison(playerid, params[])
{
	new
		time,
		playerb
	;
	
	if(PlayerInfo[playerid][pFaction] < 1)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionJail] == 0)
		return SendErrorMessage(playerid, "This command is restricted to cops only."); 
	
	if(sscanf(params, "ud", playerb, time))
		return SendUsageMessage(playerid, "/jail [playerid OR name] [time]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");

    if(!IsPlayerNearPlayer(playerid, playerb, 15.0))
        return SendErrorMessage(playerid, "You are not near the person you want to jail.");
	
    JailPlayer(playerid, playerb, time);
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "UPDATE CriminalRecords SET `Active` = 0 WHERE `CharacterName` = '%e'", GetUserName(playerb));
    mysql_tquery(g_SQL, query);
	return 1;
}

CMD:jail(playerid, params[])
{
	new
		time,
		playerb
	;
	
    if(PlayerInfo[playerid][pFaction] < 1 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionJail] == 0)
        return SendErrorMessage(playerid, "You can't use this command.");
	
	if(sscanf(params, "ud", playerb, time))
		return SendUsageMessage(playerid, "/jail [playerid OR name] [time]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");

    if(!IsPlayerNearPlayer(playerid, playerb, 15.0))
        return SendErrorMessage(playerid, "You are not near the person you want to jail.");
	
    JailPlayer(playerid, playerb, time);
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "UPDATE CriminalRecords SET `Active` = 0 WHERE `CharacterName` = '%e'", GetUserName(playerb));
    mysql_tquery(g_SQL, query);
	return 1;
}

CMD:suspect(playerid, params[])
{
	new
		charge[90],
		playerb
	;
	
	if(PlayerInfo[playerid][pFaction] < 1)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionSuspect] == 0)
		return SendErrorMessage(playerid, "This command is restricted to cops only."); 
	
	if(sscanf(params, "us[90]", playerb, charge))
		return SendUsageMessage(playerid, "/suspect [playerid OR name] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
	
	AddCharge(playerid, playerb, charge);
	return 1;
}

CMD:givelicense(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
        return SendErrorMessage(playerid, "You can't use this command."); 
    
    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionLicense] == 0)
		return SendErrorMessage(playerid, "This command is restricted to cops only."); 

    new targetid, string[128];
    if(sscanf(params, "u", targetid))
    {
        SendUsageMessage(playerid, "/givelicense [playerid or name]");
        return 1;
    }

    if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "You specified an invalid player.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "-> {FFFF00}You have given %s a weapon license.", GetRPName(targetid));
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "-> {FFFF00}You were have given a weapon license by %s.", GetRPName(playerid));
    
    AddInventory(targetid, INV_WEP_LIC, 1);
    foreach(new i: Player)
    {
        if(PlayerInfo[i][pFaction] && FactionInfo[PlayerInfo[i][pFaction]][FactionLicense] == 1)
        {
            SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: %s %s has issued %s a weapon license.", GetPlayerRank(playerid), GetRPName(playerid), GetRPName(targetid));
        }
    }
    format (string, sizeof(string), "%s %s has issued %s a weapon license.", GetFactionName(PlayerInfo[playerid][pFaction]), GetUserName(playerid), GetUserName(targetid)); 
    SendAdminWarning(1, string);
    return 1;
}

CMD:take(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionSeize] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 

    new playerb, a_str[60], string[128];
    if(sscanf(params, "us[60]", playerb, a_str))
    {
        SendUsageMessage(playerid, "/take [PlayerID/PartOfName] [Item]");
        SendClientMessage(playerid, COLOR_LIGHTRED, "[Items]{FFFFFF} Weapons, Drugs, Drivinglicense, Weaponlicense");
        return 1;
    }

    if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "You specified an invalid player.");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "You aren't near the specified player.");

    if(!strcmp(a_str, "weapons",true))
	{
		TakePlayerGuns(playerb);
        SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}You have removed %s's weapons", GetRPName(playerb));
        SendClientMessageEx(playerb, COLOR_LIGHTRED, "-> {FFFF00}%s %s has removed your weapons.", GetPlayerRank(playerid), GetRPName(playerb));
        format (string, sizeof(string), "%s %s has removed %s's weapons.", GetFactionName(PlayerInfo[playerid][pFaction]), GetUserName(playerid), GetUserName(playerb)); 
		SendAdminWarning(1, string);
	}
    else if(!strcmp(a_str, "drugs",true))
	{
		//TODO: Implement drugs.
        SendClientMessage(playerid, -1, "Drugs coming soon...");
	}
    else if(!strcmp(a_str, "driverlicense",true))
	{
		new drivelicSlot = GetInventorySlot(playerb, INV_DRV_LIC);
        if(drivelicSlot == -1)
            return SendErrorMessage(playerid, "This player does not have a weapons license.");

        RemoveInventory(playerb, drivelicSlot);
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pFaction] && FactionInfo[PlayerInfo[i][pFaction]][FactionLicense] == 1)
            {
                SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: %s %s revoked %s's driving license.", GetPlayerRank(playerid), GetRPName(playerid), GetRPName(playerb));
            }
        }
        format (string, sizeof(string), "%s %s revoked %s's driving license.", GetFactionName(PlayerInfo[playerid][pFaction]), GetUserName(playerid), GetUserName(playerb)); 
		SendAdminWarning(1, string);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}You have removed %s's driving license", GetRPName(playerb));
        SendClientMessageEx(playerb, COLOR_LIGHTRED, "-> {FFFF00}%s %s has removed your driving license.", GetPlayerRank(playerid), GetRPName(playerb));
	}
    else if(!strcmp(a_str, "Weaponlicense",true))
	{
        new weplicSlot = GetInventorySlot(playerb, INV_WEP_LIC);
        if(weplicSlot == -1)
            return SendErrorMessage(playerid, "This player does not have a weapons license.");

        RemoveInventory(playerb, weplicSlot);
        foreach(new i: Player)
        {
            if(PlayerInfo[i][pFaction] && FactionInfo[PlayerInfo[i][pFaction]][FactionLicense] == 1)
            {
                SendClientMessageEx(i, COLOR_POLICE, "DISPATCH: %s %s revoked %s's weapon license.", GetPlayerRank(playerid), GetRPName(playerid), GetRPName(playerb));
            }
        }
        format (string, sizeof(string), "%s %s revoked %s's weapon license.", GetFactionName(PlayerInfo[playerid][pFaction]), GetUserName(playerid), GetUserName(playerb)); 
		SendAdminWarning(1, string);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}You have removed %s's weapon license", GetRPName(playerb));
        SendClientMessageEx(playerb, COLOR_LIGHTRED, "-> {FFFF00}%s %s has removed your weapon license.", GetPlayerRank(playerid), GetRPName(playerb));
	}
    return 1;
}

CMD:taser(playerid, params[])
{
    if(IsWeaponRestricted(playerid))
        return SendErrorMessage(playerid, "You are currently restricted from using weapons.");

    if(PlayerInfo[playerid][pFaction] < 1 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionTaser] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(!IsOnDuty(playerid))
		return SendErrorMessage(playerid, "You can't use this command while off duty."); 

    if(TempVar[playerid][HasTaser] == false)
    {
        if(PlayerHasWeapon(playerid, 24) || PlayerHasWeapon(playerid, 23) || PlayerHasWeapon(playerid, 22))
        {
            GetPlayerWeaponData(playerid, 2, TempVar[playerid][BeforeTaserWep], TempVar[playerid][BeforeTaserAmmo]);
            TempVar[playerid][BeforeTaserSerial] = PlayerInfo[playerid][pSerial][2];
        }
        TempVar[playerid][HasTaser] = true;
        GivePlayerGun(playerid, 23, 99999, 0, false);
        SendClientMessage(playerid, COLOR_YELLOW,"You have taken out a taser.");
        pc_cmd_ame(playerid, "has taken out a taser.");
    }
    else
    {
        RemovePlayerWeapon(playerid, 23);
        if(TempVar[playerid][BeforeTaserWep] > 0)
        {
            // Give back their old weapon and ammo.
            GivePlayerGun(playerid, TempVar[playerid][BeforeTaserWep], TempVar[playerid][BeforeTaserAmmo], TempVar[playerid][BeforeTaserSerial], false);
        }
        TempVar[playerid][HasTaser] = false;
        TempVar[playerid][BeforeTaserWep] = 0;
        TempVar[playerid][BeforeTaserAmmo] = 0;
        TempVar[playerid][BeforeTaserSerial] = 0;
        SendClientMessage(playerid, COLOR_YELLOW,"You have removed your taser.");
        pc_cmd_ame(playerid, "has put their taser away.");
    }
    return 1;
}

CMD:rubberbullets(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1 || FactionInfo[PlayerInfo[playerid][pFaction]][FactionTaser] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(!IsOnDuty(playerid))
		return SendErrorMessage(playerid, "You can't use this command while off duty."); 

    if(TempVar[playerid][RubberBullets] == false)
    {
        if(PlayerHasWeapon(playerid, 25))
        {
            TempVar[playerid][RubberBullets] = true;
            SendClientMessage(playerid, COLOR_YELLOW,"You are now using rubber bullets.");
        }
    }
    else
    {
       if(PlayerHasWeapon(playerid, 25))
        {
            TempVar[playerid][RubberBullets] = false;
            SendClientMessage(playerid, COLOR_YELLOW,"You are no longer using rubber bullets.");
        }
    }
    return 1;
}

CMD:unhandcuff(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionCuff] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    new targetid;
    if(sscanf(params, "u", targetid))
    {
        SendUsageMessage(playerid, "/unhandcuff [playerid or name]");
        return 1;
    }

    if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "You specified an invalid player.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    if(GetPlayerSpecialAction(targetid) != SPECIAL_ACTION_CUFFED)
        return SendErrorMessage(playerid, "That player is not handcuffed/tied up.");

    RemovePlayerAttachedObject(targetid, SLOT_HANDCUFF);
	SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "* You have had your handcuffs removed by %s.", GetRPName(playerid));
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have removed the handcuffs from %s.", GetRPName(targetid));
    TempVar[targetid][Handcuffed] = false;
    return 1;
}
alias:unhandcuff("uncuff");

CMD:handcuff(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] < 1)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionCuff] == 0)
        return SendErrorMessage(playerid, "You can't use this command."); 

    new targetid;
    if(sscanf(params, "u", targetid))
    {
        SendUsageMessage(playerid, "/handcuff [playerid or name]");
        return 1;
    }

    if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "You specified an invalid player.");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    if(GetPlayerState(targetid) == SPECIAL_ACTION_CUFFED)
        return SendErrorMessage(playerid, "That player is already handcuffed/tied up.");

    if(IsPlayerAttachedObjectSlotUsed(targetid, SLOT_HANDCUFF))
        return RemovePlayerAttachedObject(targetid, SLOT_HANDCUFF);

    //SetPlayerAttachedObject(targetid, SLOT_HANDCUFF, 19418,6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
    SetPlayerAttachedObject(targetid, SLOT_HANDCUFF, 19418,6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
	SetPlayerSpecialAction(targetid, SPECIAL_ACTION_CUFFED);
    SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "* You have been handcuffed by %s.", GetRPName(playerid));
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have handcuffed %s.", GetRPName(targetid));
    TempVar[targetid][Handcuffed] = true;
    return 1;
}
alias:handcuff("cuff");

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
	    if (TempVar[playerid][Handcuffed] == true)
	    {
	        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
	    }
	}
	return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{
	if (TempVar[playerid][Handcuffed] == true)
	{
        new string[128];
        format(string, sizeof string, "%s (%s) has left the server while cuffed.", GetUserName(playerid), GetMasterName(playerid));
        SendAdminWarning(1, string);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (TempVar[playerid][Handcuffed] == true && !ispassenger)
	{
	    ClearAnimations(playerid);
	    return 0;
	}
	return 1;
}
