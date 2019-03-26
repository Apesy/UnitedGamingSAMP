//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:hq(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        new factionid, message[128];
        if(sscanf(params, "ds[128]", factionid, message))
            return SendUsageMessage(playerid, "/hq [faction id] [text]");
        
        SendFactionDutyMessage(factionid, COLOR_LIGHTBLUE, "HQ: Game Admin %s: %s", GetMasterName(playerid), message);
        if(PlayerInfo[playerid][pFaction] != factionid)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "HQ: Game Admin %s: %s", GetMasterName(playerid), message);
        }
        return 1;
    }

    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionHQ] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/hq [text]");

	SendFactionDutyMessage(factionid, COLOR_LIGHTBLUE, "HQ: %s %s: %s", GetPlayerRank(playerid), GetRPName(playerid), params);
    return 1;
}

CMD:atclow(playerid, params[])
{
    if(IsAnAircraft(GetPlayerVehicleID(playerid)))
		return SendErrorMessage(playerid, "You aren't in any aircraft.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/atclow [air traffic control]");

	foreach(new i : Player)
	{
		if(IsAnAircraft(GetPlayerVehicleID(playerid)) || Player[i][AdminLevel] >= 1)
		{
            if(strlen(params) > 70)
            {
                SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: %.70s ...", GetRPName(playerid), params);
                SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: ... %s", GetRPName(playerid), params[70]);
            }
			else SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: %s",  GetRPName(playerid), params);
		}
	}

    new accentStr[64];
    if(strlen(PlayerInfo[playerid][pAccent]) > 0)
    {
        format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
    }

    new string[128];
    if(strlen(params) > 70)
    {
        format(string, sizeof string, "(Radio) %s says quietly%s: %.70s ...", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        format(string, sizeof string, "(Radio) %s says quietly%s: ... %s", GetRPName(playerid), accentStr, params[70]);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    else
    {
        format(string, sizeof string, "(Radio) %s says quietly%s: %s", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    return 1;
}

CMD:atc(playerid, params[])
{
    if(!IsAnAircraft(GetPlayerVehicleID(playerid)))
		return SendErrorMessage(playerid, "You aren't in any aircraft.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/atc [air traffic control]");

	foreach(new i : Player)
	{
		if(IsAnAircraft(GetPlayerVehicleID(playerid)) || Player[i][AdminLevel] >= 1)
		{
            if(strlen(params) > 70)
            {
                SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: %.70s ...", GetRPName(playerid), params);
                SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: ... %s", GetRPName(playerid), params[70]);
            }
			else SendClientMessageEx(i, COLOR_DEPT, "* [ATC] %s: %s",  GetRPName(playerid), params);
		}
	}

    new accentStr[64];
    if(strlen(PlayerInfo[playerid][pAccent]) > 0)
    {
        format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
    }

    new string[128];
    if(strlen(params) > 70)
    {
        format(string, sizeof string, "(Radio) %s says%s: %.70s ...", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        format(string, sizeof string, "(Radio) %s says%s: ... %s", GetRPName(playerid), accentStr, params[70]);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    else
    {
        format(string, sizeof string, "(Radio) %s says%s: %s", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    return 1;
}

CMD:deplow(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionDepartmental] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/deplow [text]");

	SendDeptMessage(playerid, params);

    new accentStr[64];
    if(strlen(PlayerInfo[playerid][pAccent]) > 0)
    {
        format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
    }

    new string[128];
    if(strlen(params) > 70)
    {
        format(string, sizeof string, "(Radio) %s says quietly%s: %.70s ...", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        format(string, sizeof string, "(Radio) %s says quietly%s: ... %s", GetRPName(playerid), accentStr, params[70]);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    else
    {
        format(string, sizeof string, "(Radio) %s says quietly%s: %s", GetRPName(playerid), accentStr, params);
        LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    return 1;
}

stock SendDeptMessage(playerid, text[])
{
    new myFac = PlayerInfo[playerid][pFaction];
    foreach(new i : Player)
	{		
        new facid = PlayerInfo[i][pFaction];
		if(facid > 0 && FactionInfo[facid][FactionDepartmental] == 1 && Player[i][Ajailed] != 1)
		{
            if(strlen(text) > 70)
            {
                SendClientMessageEx(i, COLOR_ALLDEPT, "** [%s] %s %s: %.70s ... **", FactionInfo[myFac][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), text);
                SendClientMessageEx(i, COLOR_ALLDEPT, "** [%s] %s %s: ... %s **", FactionInfo[myFac][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), text[70]);
            }
			else SendClientMessageEx(i, COLOR_ALLDEPT, "** [%s] %s %s: %s **", FactionInfo[myFac][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), text);
		}
	}
    return 1;
}

CMD:gov(playerid, params[])
{
    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionGov] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 

    if(PlayerInfo[playerid][pFactionRank] > 2)
		return SendErrorMessage(playerid, "You do not have access to this command. You need to be leader or assistant leader.");

	if(isnull(params))
		return SendUsageMessage(playerid, "/gov [text]");

    new string[256];
    if(strlen(params) > 70)
    {
        SendAdvertisementMessage(0x0080FF96, "[%s] %s %s: %.70s ...", FactionInfo[factionid][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), params);
        SendAdvertisementMessage(0x0080FF96, "[%s] %s %s: ... %s", FactionInfo[factionid][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), params[70]);
    }
    else SendAdvertisementMessage(0x0080FF96, "[%s] %s %s: %s", FactionInfo[factionid][FactionAbbrev], GetPlayerRank(playerid), GetRPName(playerid), params);
    format(string, sizeof string, "[%s] %s (Username %s IP %s AccountID %s)", FactionInfo[factionid][FactionAbbrev], params, GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
    WriteLog("Logs/Government.log", string);
    return 1;
}

CMD:department(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");

    if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDepartmental] == 0)
        return SendErrorMessage(playerid, "You can't use this command.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/(dep)artment [text]");

	SendDeptMessage(playerid, params);

    new string[128];
    if(strlen(params) > 70)
    {
        format(string, sizeof string, "%s says (Radio): %.70s ...", GetRPName(playerid), params);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
        format(string, sizeof string, "%s says (Radio): ... %s", GetRPName(playerid), params[70]);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    else
    {
        format(string, sizeof string, "%s says (Radio): %s", GetRPName(playerid), params);
        LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, true);
    }
    return 1;
}
alias:department("dep", "dept");

CMD:operation(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionMedic] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    new reviveID;
    if(sscanf(params, "u", reviveID))
        return SendUsageMessage(playerid, "/operation [PlayerID/PartOfName]");

    if(!IsPlayerConnected(reviveID) || Player[reviveID][IsLoggedIn] == false)
        return SendErrorMessage(playerid, "That player is not connected or not logged in.");

    if(IsPlayerNearPlayer(playerid, reviveID, 5.0) || reviveID == playerid)
    {
        SetPlayerHealthEx(reviveID, 10); 
        SetPlayerTeam(reviveID, PLAYER_ALIVE);

        TogglePlayerControllable(reviveID, 1); 

        StopAnim(reviveID);

        SetPlayerSkillLevel(reviveID, WEAPONSKILL_PISTOL, 998);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_MICRO_UZI, 998);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_SAWNOFF_SHOTGUN, 998);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_AK47, 999);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_DESERT_EAGLE, 999);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_SHOTGUN, 999);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_M4, 999);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_MP5, 999);
        SetPlayerSkillLevel(reviveID, WEAPONSKILL_SPAS12_SHOTGUN, 999);
        ClearDamages(reviveID);

        new string[128];
        SendClientMessageEx(reviveID, COLOR_LIGHTBLUE, "* You have been revived by %s %s.", GetPlayerRank(playerid), GetRPName(playerid));
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have revived %s.", GetRPName(reviveID));
        format(string, sizeof string, "%s was revived by medic %s.", GetUserName(reviveID), GetUserName(playerid));
        SendAdminWarning(1, string);
    }
    return 1;
}

CMD:putinambu(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionMedic] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    new targetID, seatID;
    if(sscanf(params, "ud", targetID, seatID))
        return SendUsageMessage(playerid, "/putinambu [PlayerID/PartOfName] [SeatID (2-3 are valid)");

    if(targetID == playerid)
        return SendErrorMessage(playerid, "You cannot put yourself in an ambulance.");
    
    if(!IsPlayerNearPlayer(playerid, targetID, 20.0))
        return SendErrorMessage(playerid, "You aren't near that player.");

    if(GetPlayerTeam(targetID) == PLAYER_ALIVE)
        return SendErrorMessage(playerid, "You cannot use this on someone who is not brutally wounded or deceased.");

    if(seatID < 2 || seatID > 3)
            return SendErrorMessage(playerid, "Invalid SeatID. (2-3 are valid)");

    new vehicleID = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleID) == 416 || GetVehicleModel(vehicleID) == 497)
    {
        PutPlayerInVehicle(targetID, vehicleID, seatID);
        SetVirtualWorld(targetID, GetVehicleVirtualWorld(vehicleID));
        SendClientMessageEx(targetID, COLOR_LIGHTBLUE, "* You have been placed inside an ambulance by %s %s.", GetPlayerRank(playerid), GetRPName(playerid));
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have placed %s inside your ambulance.", GetRPName(targetID));
    }
    return 1;
}

CMD:elm(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionSiren] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 

    new vehicleid = GetPlayerVehicleID(playerid), panels, doors, lights, tires;
    if (!GetVehicleModel(vehicleid)) return SendClientMessage(playerid, -1, "* You are not in a vehicle!");

    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0)
            {
                if(Flasher[vehicleid])
                {
                    GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                    if(LightPwr[vehicleid] == 1)
                    {
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                    }
                    else
                    {
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                    }
                    Flasher[vehicleid] = 0;
                    PrintFooter(playerid, "~r~ELM Turned Off", 1);
                }
                else 
                {
                    ToggleVehicleLights(vehicleid, true);
                    GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                    if(LightPwr[vehicleid] == 1)
                    {
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                    }
                    else
                    {
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                    }
                    Flasher[vehicleid] = 1;
                    PrintFooter(playerid, "~g~ELM Turned On", 1);
                }
            }
        }
    }
    return 1;
}

CMD:siren(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionSiren] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 

    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0)
            {
                new vehicleid = VehicleInfo[i][vScriptID];
                if(CoreVehicle[vehicleid][SirenStatus] == 1)
                { 
                    ToggleVehicleSiren(vehicleid, false);
                    PrintFooter(playerid, "~r~Siren Turned Off", 1);
                }
                else
                {
                    ToggleVehicleSiren(vehicleid, true);
                    PrintFooter(playerid, "~b~Siren Turned On", 1);
                }
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You aren't in a faction vehicle.");    
    return 1;
}

CMD:traffic(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionSiren] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 

    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0)
            {
                new vehicleid = VehicleInfo[i][vScriptID];
                if(CoreVehicle[vehicleid][SirenStatus] == 1)
                { 
                    ToggleVehicleSiren(vehicleid, false, 2);
                    PrintFooter(playerid, "~r~Siren Turned Off", 1);
                }
                else
                {
                    ToggleVehicleSiren(vehicleid, true, 2);
                    PrintFooter(playerid, "~b~Siren Turned On", 1);
                }
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You aren't in a faction vehicle.");    
    return 1;
}

CMD:carsignremove(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
	if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionCarsign] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
    new vehicleid = GetPlayerVehicleID(playerid);
		
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0)
            {
                SendClientMessageEx(playerid, COLOR_YELLOW, "You have removed the carsign."); 
                Delete3DTextLabel(VehicleCarSign[vehicleid]); 
                VehicleHasCarSign[vehicleid] = false;
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You aren't in a faction vehicle.");
	return 1;
}

CMD:carsign(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
	if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionCarsign] == 0)
		return SendErrorMessage(playerid, "You can't use this command."); 
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/carsign [text]"); 

    if(strlen(params) < 2 || strlen(params) >= 50)
		return SendErrorMessage(playerid, "Your text has to be greater than 1 char and less than 50.");
		
    new vehicleid = GetPlayerVehicleID(playerid);
		
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] == PlayerInfo[playerid][pFaction])
            {
                SendClientMessageEx(playerid, COLOR_YELLOW, "Use \"/carsignremove\" to remove it the carsign you made."); 

                if(VehicleHasCarSign[vehicleid]) Delete3DTextLabel(VehicleCarSign[vehicleid]);

                new Float:fSizeX, Float:fSizeY, Float:fSizeZ;
                GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSizeX, fSizeY, fSizeZ);

                fSizeY = -(fSizeY / 2) + 0.2;
                fSizeZ = -(fSizeZ / 2) + 0.2;

                VehicleCarSign[vehicleid] = Create3DTextLabel(params, 0xFFFFFFFF, 0.0, 0.0, 0.0, 25.0, 0, 0); 
                Attach3DTextLabelToVehicle(VehicleCarSign[vehicleid], vehicleid, -0.7, fSizeY, fSizeZ); 

                VehicleHasCarSign[vehicleid] = true;
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You aren't in a faction vehicle.");
	return 1;
}

CMD:megaphone(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
	if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(FactionInfo[factionid][FactionMegaphone] == 0)
        return SendErrorMessage(playerid, "You can't use this command.");
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You aren't in any vehicle.");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/(m)egaphone [text]"); 
		
    for(new i; i < MAX_DYN_VEH; i++)
    {
        if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
        {
            if(VehicleInfo[i][vFactionID] > 0)
            {
                new string[128];
                format (string, sizeof(string), "[Megaphone] %s:o< %s", GetRPName(playerid), params);
				LocalChat(playerid, 60.0, string, COLOR_MEGA1, COLOR_MEGA1, COLOR_MEGA2, COLOR_MEGA3);
                return 1;
            }
        }
    }
    SendErrorMessage(playerid, "You aren't in a faction vehicle.");
	return 1;
}
alias:megaphone("m");

stock IsNearFactionDuty(playerid)
{
    new faction = PlayerInfo[playerid][pFaction];
    if(faction == 0)
        return 0;

    if(IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[faction][FactionDutyPos][0], FactionInfo[faction][FactionDutyPos][1], FactionInfo[faction][FactionDutyPos][2]))
        return 1;

    return 0;
}

CMD:equip(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(!IsNearFactionDuty(playerid))
            return SendErrorMessage(playerid, "You aren't near your faction duty spot.");
            
        if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDutyAccess] == 1)
        {
            Dialog_Show(playerid, EquipLocker, DIALOG_STYLE_LIST, "Faction Locker", "Duty\nHealth\nArmour\nUniform\nWeapons", "Select", "Cancel");
        }
    }
    return 1;
}

Dialog:EquipLocker(playerid, response, listitem, inputtext[])
{
    switch(listitem)
    {
        case 0:
        {
            if(PlayerInfo[playerid][pFactionDuty])
            {
                pc_cmd_offduty(playerid, "\0");
            }
            else pc_cmd_duty(playerid, "\0");
        }
        case 1:
        {
            SetPlayerHealthEx(playerid, 100.0);
        }
        case 2:
        {
            SetPlayerArmour(playerid, 100.0);
        }
        case 3:
        {
            pc_cmd_uniform(playerid, "\0");
        }
        case 4:
        {
            ShowFactionWeapons(playerid);
        }
    }
    return 1;
}

CMD:uniform(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(!IsNearFactionDuty(playerid))
            return SendErrorMessage(playerid, "You aren't near your faction duty spot.");
            
        if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDutyAccess] == 1)
        {
            ShowFactionSkins(playerid);
        }
    }
    return 1;
}

Dialog:DIALOG_EMS_SKINS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        PlayerInfo[playerid][pBeforeSkin] = GetPlayerSkin(playerid);
        switch(listitem)
        {
            case 0: SetSkin(playerid, 277);
            case 1: SetSkin(playerid, 278);
            case 2: SetSkin(playerid, 279);
            case 3: SetSkin(playerid, 274);
            case 4: SetSkin(playerid, 275);
            case 5: SetSkin(playerid, 276);
            case 6: SetSkin(playerid, 308);
        }
    }
    return 1;
}

Dialog:DIALOG_POLICE_SKINS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        PlayerInfo[playerid][pBeforeSkin] = GetPlayerSkin(playerid);
        switch(listitem)
        {
            case 0: SetSkin(playerid, 280);
            case 1: SetSkin(playerid, 300);
            case 2: SetSkin(playerid, 281);
            case 3: SetSkin(playerid, 301);
            case 4: SetSkin(playerid, 306);
            case 5: SetSkin(playerid, 307);
            case 6: SetSkin(playerid, 265);
            case 7: SetSkin(playerid, 267);
            case 8: SetSkin(playerid, 266);
            case 9: SetSkin(playerid, 284);
        }
    }
    return 1;
}

CMD:badge(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionBadge] == 1)
        {
            new targetid;
            if(sscanf(params, "u", targetid))
            {
                SendUsageMessage(playerid, "/badge [player id or name]");
                return 1;
            }

            if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
		        return SendErrorMessage(playerid, "You aren't near that player."); 

            if(targetid == playerid)
                SendNearbyMessage(playerid, 5.0, COLOR_PURPLE, "* %s looks at their badge.", GetRPName(playerid));
            
            else SendNearbyMessage(playerid, 5.0, COLOR_PURPLE, "* %s shows %s their badge.", GetRPName(playerid), GetRPName(targetid));

            SendClientMessageEx(targetid, COLOR_GREEN, "____________| Badge |____________");
            SendClientMessageEx(targetid, COLOR_GRAD5, "* Name: %s", GetUserName(playerid));
            SendClientMessageEx(targetid, COLOR_GRAD4, "* Rank: %s", GetPlayerRank(playerid));
            SendClientMessageEx(targetid, COLOR_GRAD3, "* Agency: %s", GetFactionName(PlayerInfo[playerid][pFaction]));
            if(PlayerInfo[playerid][pBadgeNo] >= 1)
            {
                SendClientMessageEx(targetid, COLOR_GRAD2, "* Badge #%d", PlayerInfo[playerid][pBadgeNo]);
            }
        }
    }
    return 1;
}
alias:badge("showbadge");

CMD:offduty(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDutyAccess] == 1)
        {
            SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_POLICE, "DISPATCH: %s %s is now off duty.", GetPlayerRank(playerid), GetRPName(playerid));
            
            SetPlayerArmourEx(playerid, 0);
            TakePlayerGuns(playerid);
            PlayerInfo[playerid][pFactionDuty] = false;
            if(PlayerInfo[playerid][pBeforeSkin] != 0)
            {
                SetSkin(playerid, PlayerInfo[playerid][pBeforeSkin]);
            }
            SetPlayerTeamColour(playerid);
        }
        else SendErrorMessage(playerid, "Your faction does not have this function.");
    }
    return 1;
}

Dialog:GovernmentAttachments(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        for(new a; a < sizeof(GovernmentAttachments); a++)
        {
            if(listitem == a)
            {
                SetPlayerAttachedObject(playerid, SLOT_MISC, GovernmentAttachments[a][Model], 2);
                TempVar[playerid][EditType] = EDIT_TYPE_BUY_ACCESSORY;
                EditAttachedObject(playerid, SLOT_MISC);
                return 1;
            }
        }
    }
    return 1;
}

Dialog:MedicAttachments(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        for(new a; a < sizeof(MedicAttachments); a++)
        {
            if(listitem == a)
            {
                SetPlayerAttachedObject(playerid, SLOT_MISC, MedicAttachments[a][Model], 2);
                TempVar[playerid][EditType] = EDIT_TYPE_BUY_ACCESSORY;
                EditAttachedObject(playerid, SLOT_MISC);
                return 1;
            }
        }
    }
    return 1;
}

Dialog:PoliceAttachments(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        for(new a; a < sizeof(PoliceAttachments); a++)
        {
            if(listitem == a)
            {
                switch(PoliceAttachments[a][Model])
                {
                    case 19142:
                    {
                        SetPlayerAttachedObject(playerid,SLOT_MISC,PoliceAttachments[a][Model],1,0.1,0.05,0.0,0.0,0.0,0.0);
                    }
                    case 19141:
                    {
                        SetPlayerAttachedObject(playerid,SLOT_MISC,PoliceAttachments[a][Model],2,0.11,0.0,0.0,0.0,0.0,0.0);
                    }
                    case 18637:
                    {
                        SetPlayerAttachedObject(playerid,SLOT_MISC,PoliceAttachments[a][Model],13,0.35,0.0,0.0,0.0,0.0,180.0);
                    }
                    case 19515:
                    {
                        SetPlayerAttachedObject(playerid,SLOT_MISC,PoliceAttachments[a][Model],1,0.1,0.05,0.0,0.0,0.0,0.0);
                    }
                    case 19514:
                    {
                        SetPlayerAttachedObject(playerid,SLOT_MISC,PoliceAttachments[a][Model],2,0.11,0.0,0.0,0.0,0.0,0.0);
                    }
                    default:
                    {
                        SetPlayerAttachedObject(playerid, SLOT_MISC, PoliceAttachments[a][Model], 2);
                    }
                }
                TempVar[playerid][EditType] = EDIT_TYPE_BUY_ACCESSORY;
                EditAttachedObject(playerid, SLOT_MISC);
                return 1;
            }
        }
    }
    return 1;
}

CMD:removesceneall(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new count = 0;
        foreach(new i: Player)
        {
            if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pScene]))
            {
                count++;
                DestroyDynamic3DTextLabel(PlayerInfo[playerid][pScene]);
                SendClientMessageEx(playerid, COLOR_LIGHTRED, "* %s %s has removed all scenes (including yours).", GetAdminRank(playerid), GetMasterName(playerid));
            }
        }
        if(count > 0) 
        {
            SendClientMessageEx(playerid, -1, "%s scenes removed.", count);
        }
        else SendErrorMessage(playerid, "No scenes available to remove.");
    }
    return 1;
}

CMD:removescene(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        new targetid;
        if(sscanf(params, "u", targetid))
            return SendUsageMessage(playerid, "/removescene [OwnerID/PartOfName]");

        if(IsValidDynamic3DTextLabel(PlayerInfo[targetid][pScene]))
        {
            DestroyDynamic3DTextLabel(PlayerInfo[targetid][pScene]);
            SendClientMessageEx(targetid, COLOR_WHITE, "Your scene was removed.");
            SendClientMessageEx(playerid, COLOR_WHITE, "Scene was removed.");
        }
        else SendErrorMessage(playerid, "This player has not created a scene.");
        return 1;
    }
    if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pScene]))
    {
        DestroyDynamic3DTextLabel(PlayerInfo[playerid][pScene]);
        SendClientMessageEx(playerid, COLOR_WHITE, "Scene was removed.");
    }
    return 1;
}

CMD:createscene(playerid, params[])
{
    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

    if(PlayerInfo[playerid][pFaction] >= 1 || Player[playerid][DonateLevel] > 0)
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/createscene [Emote]");

        if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pScene]))
        {
            DestroyDynamic3DTextLabel(PlayerInfo[playerid][pScene]);
        }

        new Float:x, Float:y, Float:z, string[MAX_PLAYER_NAME+144+8];
        GetPlayerPos(playerid, x, y, z);
        format(string, sizeof string, "(( %s )) %s", GetUserName(playerid), params);
        PlayerInfo[playerid][pScene] = CreateDynamic3DTextLabel(string, COLOR_PURPLE, x, y, z, 40.0, .testlos = 0);
        format(string, sizeof string, "%s (%d) created a scene at %s: %s", GetUserName(playerid), playerid, ReturnLocation(playerid), params);
        SendAdminWarning(1, string);
        if(strlen(params) > 70)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Created scene: (( %s )) %.70s", GetUserName(playerid), params);
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* ... %s", params[70]);
        }
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Created scene: (( %s )) %s", GetUserName(playerid), params);
        SendClientMessageEx(playerid, COLOR_WHITE, "Use /removescene to remove it.");
    }
    else SendErrorMessage(playerid, "You need to be an official faction member or donator to use this.");
    return 1;
}

CMD:taxwithdraw(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1 || FactionInfo[factionid][FactionEconomy] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You are not at the right rank to use this command.");

    new amount, string[128];
    if(sscanf(params, "d", amount))
    {
        SendUsageMessage(playerid, "/taxwithdraw [Amount]");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Faction Bank:{FFFFFF} $%s", FormatNumber(FactionInfo[factionid][FactionBank]));
        return 1;
    }

    if(amount < 1)
        return SendErrorMessage(playerid, "You cannot withdraw less than $1.");

    if(amount > FactionInfo[factionid][FactionBank])
        return SendErrorMessage(playerid, "There is not enough money in the tax vault to do this.");

    FactionInfo[factionid][FactionBank] += amount;

    format(string, sizeof(string), "Government Leader %s (%s) has withdrawn $%s from the tax vault.", GetUserName(playerid), GetMasterName(playerid), FormatNumber(amount));
    SendAdminWarning(1, string);
    return 1;
}

CMD:taxdeposit(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1 || FactionInfo[factionid][FactionEconomy] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You are not at the right rank to use this command.");

    new amount, string[128];
    if(sscanf(params, "d", amount))
    {
        SendUsageMessage(playerid, "/taxdeposit [Amount]");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Faction Bank:{FFFFFF} $%s", FormatNumber(FactionInfo[factionid][FactionBank]));
        return 1;
    }

    if(amount < 1)
        return SendErrorMessage(playerid, "You cannot deposit less than $1.");

    if(amount > PlayerInfo[playerid][pMoney])
        return SendErrorMessage(playerid, "There is not enough money in the tax vault to do this.");

    FactionInfo[factionid][FactionBank] += amount;

    format(string, sizeof(string), "Government Leader %s (%s) has deposited $%s into the tax vault.", GetUserName(playerid), GetMasterName(playerid), FormatNumber(amount));
    SendAdminWarning(1, string);
    format(string, sizeof(string), "[FACTION]:{FFFFFF} Government Leader %s has transferred $%s to the faction bank.", GetUserName(playerid), FormatNumber(amount));
    SendFactionMessage(factionid, COLOR_LIGHTGREEN, string);
    return 1;
}

CMD:taxtransfer(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1 || FactionInfo[factionid][FactionEconomy] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You are not at the right rank to use this command.");

    new faction, amount, string[128];
    if(sscanf(params, "dd", faction, amount))
    {
        SendUsageMessage(playerid, "/taxtransfer [FactionID] [Amount]");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Faction Bank:{FFFFFF} $%s", FormatNumber(FactionInfo[factionid][FactionBank]));
        return 1;
    }

    if(amount < 1 || !FactionInfo[faction][FactionID])
        return SendErrorMessage(playerid, "That faction does not exist, see /factions.");
    
    if(!FactionInfo[faction][FactionGov])
        return SendErrorMessage(playerid, "That faction is not a government faction.");

    if(FactionInfo[factionid][FactionBank]-amount < 1 || amount > FactionInfo[factionid][FactionBank])
        return SendErrorMessage(playerid, "There is not enough money in the tax vault to do this.");

    FactionInfo[faction][FactionBank] += amount;
    FactionInfo[factionid][FactionBank] -= amount;

    format(string, sizeof(string), "Government Leader %s (%s) has has transferred $%s to %s.", GetUserName(playerid), GetMasterName(playerid), FormatNumber(amount), FactionInfo[faction][FactionName]);
    SendAdminWarning(1, string);
    format(string, sizeof(string), "[FACTION]:{FFFFFF} Government Leader %s has transferred $%s to the faction bank.", GetUserName(playerid), FormatNumber(amount));
    SendFactionMessage(factionid, COLOR_LIGHTGREEN, string);
    return 1;
}

CMD:taxrate(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid < 1 || FactionInfo[factionid][FactionEconomy] == 0)
		return SendErrorMessage(playerid, "You can't use this command.");

    if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You are not at the right rank to use this command.");

    new rate;
    if(sscanf(params, "d", rate))
        return SendUsageMessage(playerid, "/taxrate [Tax Rate (1-40)]");

    if(rate < 1)
        return SendErrorMessage(playerid, "The tax rate cannot be below 1 percent.");
    
    if(rate > 40)
        return SendErrorMessage(playerid, "The tax rate cannot be above 40 percent.");

    new string[128], query[128];
    ServerInfo[TaxRate] = rate;

    mysql_format(g_SQL, query, sizeof(query), "UPDATE `settings` SET `TaxRate` = %d", rate);
    mysql_tquery(g_SQL, query);

    format(string, sizeof(string), "Government Leader %s (%s) has set the tax rate to %d percent.", GetUserName(playerid), GetMasterName(playerid), rate);
    SendAdminWarning(1, string);
    format(string, sizeof(string), "[FACTION]:{FFFFFF} %s %s has set the tax rate to %d percent.", GetPlayerRank(playerid), GetUserName(playerid), rate);
    SendFactionMessage(factionid, COLOR_LIGHTGREEN, string);
    return 1;
}

CMD:govaccessories(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(IsNearFactionDuty(playerid))
        {
            if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDutyAccess] == 1)
            {
                new string[128*180];
                format(string, sizeof string, "Price\t\tName\n");
                for(new a; a < sizeof(PoliceAttachments); a++)
                {
                    format(string, sizeof string, "%s$%d\t\t%s\n", string, PoliceAttachments[a][Price], PoliceAttachments[a][Name]);
                }
                Dialog_Show(playerid, PoliceAttachments, DIALOG_STYLE_TABLIST_HEADERS, "Buy Accessories", string, "View", "Close");
            }
            else SendErrorMessage(playerid, "Your faction does not have access to this.");
            return 1;
        }
        else SendErrorMessage(playerid, "You are not at your faction spawn.");
    }
    else SendErrorMessage(playerid, "You are not a member of a faction.");
    return 1;
}

CMD:duty(playerid, params[])
{
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        if(FactionInfo[PlayerInfo[playerid][pFaction]][FactionDutyAccess] == 1)
        {
            SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_POLICE, "DISPATCH: %s %s is now on duty.", GetPlayerRank(playerid), GetRPName(playerid));
            SetPlayerHealthEx(playerid, 100);
            
            PlayerInfo[playerid][pFactionDuty] = 1;
            if(PlayerInfo[playerid][pBeforeSkin] == 0)
            {
                SendClientMessage(playerid, -1, "Make sure you set your uniform by doing /uniform.");
            }
            SetPlayerTeamColour(playerid);
        }
        else SendErrorMessage(playerid, "Your faction does not have this function.");
    }
    return 1;
}