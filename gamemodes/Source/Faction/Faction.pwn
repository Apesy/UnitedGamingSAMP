//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
enum
{
    UNIFORM_MENU = 1
};

stock HexToInt(string[])
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

stock IsOnDuty(playerid)
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(factionid > 0)
    {
        if(FactionInfo[factionid][FactionDutyAccess] == 0) // If the faction does not have access to /duty, report them as always on duty.
            return 1;

        if(PlayerInfo[playerid][pFactionDuty] == 1) // Check if the user is on duty, if the are, return 1.
            return 1;
    }
    return 0; // In all other cases return 0.
}

CMD:afactionhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 1))
    {
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Admin Faction Help:{FFFFFF} Type a command for more information.");
        if(Player[playerid][AdminLevel] >= 3)
        {
            SendClientMessage(playerid, COLOR_GRAD5, "Commands: /gotofaction, /towcars, /fann");
        }
        if(Player[playerid][AdminLevel] >= 4)
        {
            SendClientMessage(playerid, COLOR_GRAD4, "Commands: /setpfaction, /createfaction, /editfaction");
            SendClientMessage(playerid, COLOR_GRAD3, "Commands: /setfskin, /setfweapon");
        }
        SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    }
}

CMD:createfaction(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new fAbbrev[30], fName[90];
        if(sscanf(params, "s[30]s[90]", fAbbrev, fName))
        {
            SendUsageMessage(playerid, "/createfaction [abbreviation] [name]");
		    SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]{FFFFFF} Do not use spaces for the abbreviation.");
            return 1;
        }

        if(strlen(fAbbrev) > 30)
		    return SendErrorMessage(playerid, "The faction abbreviation needs to be shorter (less than 30 characters)."); 

        if(strlen(fName) > 90)
		    return SendErrorMessage(playerid, "The faction name needs to be shorter (less than 90 characters)."); 

        new idx = 0;
	
        for (new i = 1; i < MAX_FACTIONS; i++)
        {
            if(!FactionInfo[i][FactionID])
            {
                idx = i; 
                break;
            }
        }
        if(idx == 0)
        {
            return SendServerMessage(playerid, "The server has met the maximum amount of factions."); 
        }

        new thread[128];
        mysql_format(g_SQL, thread, sizeof(thread), "INSERT INTO factions (`FactionName`, `FactionAbbrev`) VALUES('%e', '%e')", fName, fAbbrev);
	    mysql_tquery(g_SQL, thread, "Query_InsertFaction", "issi", playerid, fAbbrev, fName, idx);
        return 1;
    }
    return 1;
}

function Query_InsertFaction(playerid, varName[], varAbbrev[], idx)
{
	new str[128];
	
	FactionInfo[idx][FactionID] = cache_insert_id();
		
	format(FactionInfo[idx][FactionName], 90, "%s", varName);
	format(FactionInfo[idx][FactionAbbrev], 30, "%s", varAbbrev); 
		
	format(str, sizeof(str), "%s has created Faction ID %d.", GetMasterName(playerid), cache_insert_id());
	SendAdminCommand(str, 5);
	
    for (new i = 1; i < MAX_FACTION_RANKS; i++)
    {
        format(FactionRanks[idx][i], 90, "NotSet");
        FactionRankPay[idx][i] = 0;
    }

	SendServerMessage(COLOR_LIGHTRED, "To configure the faction, use \"/editfaction\". "); 
	return 1;
}

stock ReturnFactionType(type)
{
    new typestr[32];
    switch(type)
    {
        case 1: typestr = "Police";
        case 2: typestr = "Fire/EMS";
        case 3: typestr = "Government";
        case 4: typestr = "Gang/Mafia";
        case 5: typestr = "Other";
        case 6: typestr = "News";
        default: typestr = "Unknown";
    }
    return typestr;
}

CMD:editfaction(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new factionid, oneString[60], secString[90];
        if (sscanf(params, "ds[60]S()[90]", factionid, oneString, secString))
        {
            SendUsageMessage(playerid, "/editfaction [faction id] [option]");
		    SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] AlterRank, JoinRank, ChatRank, TowRank, Spawn, DutySpot");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Name, Abbrev, PoliceCalls, MedicCalls, Badge, Carsign");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Cuff, Deploy, Backup, Dept, Impound, Jail, Mega, Suspect");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] License, Seize, Taser, HQ, Gov, Siren, Duty, Fine, MDC");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Medic, News, Tag, RamRaid, WeaponDelivery, WeaponDeliveryTime");
            SendClientMessage(playerid, COLOR_WHITE, "[OPTIONS] Economy");
            return 1;
        }

        if(!FactionInfo[factionid][FactionID])
            return SendErrorMessage(playerid, "The faction you specified doesn't exist.");

        else if(!strcmp(oneString, "Economy", true))
        {
            if(FactionInfo[factionid][FactionEconomy] == 0)
            {
                FactionInfo[factionid][FactionEconomy] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionEconomy] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's economy perms to %d.", factionid, FactionInfo[factionid][FactionEconomy]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "WeaponDeliveryTime", true))
        {
            new time;
            if(sscanf(secString, "d", time))
            {
                SendUsageMessage(playerid, "/editfaction factionid WeaponDeliveryTime [Time(0-72)]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] Minimum of 2 characters & maximum of 30 characters.");
                return 1;
            }

            if(time < 0)
                return SendErrorMessage(playerid, "You cannot set the hours to below 0.");

            if(time > 72)
                return SendErrorMessage(playerid, "You cannot set the hours above 72.");

            FactionInfo[factionid][WeaponDelivery] = time*60;
            
            SendServerMessage(playerid, "You set faction %d's weapon delivery perms to %d hours.", factionid, time);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "WeaponDelivery", true))
        {
            if(FactionInfo[factionid][FactionDrugRights] == 0)
            {
                FactionInfo[factionid][FactionDrugRights] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionDrugRights] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's weapon delivery perms to %d.", factionid, FactionInfo[factionid][FactionDrugRights]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "ramraid", true))
        {
            if(FactionInfo[factionid][FactionRamRaid] == 0)
            {
                FactionInfo[factionid][FactionRamRaid] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionRamRaid] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's ram raid perms to %d.", factionid, FactionInfo[factionid][FactionRamRaid]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "tag", true))
        {
            if(FactionInfo[factionid][FactionTag] == 0)
            {
                FactionInfo[factionid][FactionTag] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionTag] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's tag perms to %d.", factionid, FactionInfo[factionid][FactionTag]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "news", true))
        {
            if(FactionInfo[factionid][FactionNews] == 0)
            {
                FactionInfo[factionid][FactionNews] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionNews] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's news perms to %d.", factionid, FactionInfo[factionid][FactionNews]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "medic", true))
        {
            if(FactionInfo[factionid][FactionMedic] == 0)
            {
                FactionInfo[factionid][FactionMedic] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionMedic] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's medic perms to %d.", factionid, FactionInfo[factionid][FactionMedic]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "mdc", true))
        {
            if(FactionInfo[factionid][FactionMDC] == 0)
            {
                FactionInfo[factionid][FactionMDC] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionMDC] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's MDC perms to %d.", factionid, FactionInfo[factionid][FactionMDC]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "fine", true))
        {
            if(FactionInfo[factionid][FactionTicket] == 0)
            {
                FactionInfo[factionid][FactionTicket] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionTicket] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's fine (ticket) perms to %d.", factionid, FactionInfo[factionid][FactionTicket]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "duty", true))
        {
            if(FactionInfo[factionid][FactionDutyAccess] == 0)
            {
                FactionInfo[factionid][FactionDutyAccess] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionDutyAccess] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's duty perms to %d.", factionid, FactionInfo[factionid][FactionDutyAccess]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "siren", true))
        {
            if(FactionInfo[factionid][FactionSiren] == 0)
            {
                FactionInfo[factionid][FactionSiren] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionSiren] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's siren perms to %d.", factionid, FactionInfo[factionid][FactionSiren]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "gov", true))
        {
            if(FactionInfo[factionid][FactionGov] == 0)
            {
                FactionInfo[factionid][FactionGov] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionGov] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's gov perms to %d.", factionid, FactionInfo[factionid][FactionGov]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "hq", true))
        {
            if(FactionInfo[factionid][FactionHQ] == 0)
            {
                FactionInfo[factionid][FactionHQ] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionHQ] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's HQ perms to %d.", factionid, FactionInfo[factionid][FactionHQ]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "taser", true))
        {
            if(FactionInfo[factionid][FactionTaser] == 0)
            {
                FactionInfo[factionid][FactionTaser] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionTaser] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's taser (and rubber bullets) perms to %d.", factionid, FactionInfo[factionid][FactionTaser]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "seize", true))
        {
            if(FactionInfo[factionid][FactionSeize] == 0)
            {
                FactionInfo[factionid][FactionSeize] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionSeize] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's seize perms to %d.", factionid, FactionInfo[factionid][FactionSeize]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "license", true))
        {
            if(FactionInfo[factionid][FactionLicense] == 0)
            {
                FactionInfo[factionid][FactionLicense] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionLicense] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's license perms to %d.", factionid, FactionInfo[factionid][FactionLicense]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "suspect", true))
        {
            if(FactionInfo[factionid][FactionSuspect] == 0)
            {
                FactionInfo[factionid][FactionSuspect] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionSuspect] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's suspect perms to %d.", factionid, FactionInfo[factionid][FactionSuspect]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "mega", true))
        {
            if(FactionInfo[factionid][FactionMegaphone] == 0)
            {
                FactionInfo[factionid][FactionMegaphone] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionMegaphone] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's megaphone perms to %d.", factionid, FactionInfo[factionid][FactionMegaphone]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "jail", true))
        {
            if(FactionInfo[factionid][FactionJail] == 0)
            {
                FactionInfo[factionid][FactionJail] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionJail] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's jail perms to %d.", factionid, FactionInfo[factionid][FactionJail]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "impound", true))
        {
            if(FactionInfo[factionid][FactionImpound] == 0)
            {
                FactionInfo[factionid][FactionImpound] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionImpound] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's impound perms to %d.", factionid, FactionInfo[factionid][FactionImpound]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "dept", true))
        {
            if(FactionInfo[factionid][FactionDepartmental] == 0)
            {
                FactionInfo[factionid][FactionDepartmental] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionDepartmental] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's /dep perms to %d.", factionid, FactionInfo[factionid][FactionDepartmental]);
            SaveFaction(factionid);
        }
        // else if(!strcmp(oneString, "backup", true))
        // {
        //     if(FactionInfo[factionid][FactionBackup] == 0)
        //     {
        //         FactionInfo[factionid][FactionBackup] = 1;
        //     }
        //     else
        //     {
        //         FactionInfo[factionid][FactionBackup] = 0;
        //     }
            
        //     SendServerMessage(playerid, "You set faction %d's backup perms to %d.", factionid, FactionInfo[factionid][FactionBackup]);
        //     SaveFaction(factionid);
        // }
        else if(!strcmp(oneString, "deploy", true))
        {
            if(FactionInfo[factionid][FactionDeploy] == 0)
            {
                FactionInfo[factionid][FactionDeploy] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionDeploy] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's deploy perms to %d.", factionid, FactionInfo[factionid][FactionDeploy]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "cuff", true))
        {
            if(FactionInfo[factionid][FactionCuff] == 0)
            {
                FactionInfo[factionid][FactionCuff] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionCuff] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's handcuff perms to %d.", factionid, FactionInfo[factionid][FactionCuff]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "carsign", true))
        {
            if(FactionInfo[factionid][FactionCarsign] == 0)
            {
                FactionInfo[factionid][FactionCarsign] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionCarsign] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's car sign perms to %d.", factionid, FactionInfo[factionid][FactionCarsign]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "badge", true))
        {
            if(FactionInfo[factionid][FactionBadge] == 0)
            {
                FactionInfo[factionid][FactionBadge] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionBadge] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's badge perms to %d.", factionid, FactionInfo[factionid][FactionBadge]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "mediccalls", true))
        {
            if(FactionInfo[factionid][FactionMedicCall] == 0)
            {
                FactionInfo[factionid][FactionMedicCall] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionMedicCall] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's medic call perms to %d.", factionid, FactionInfo[factionid][FactionMedicCall]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "govcalls", true))
        {
            if(FactionInfo[factionid][FactionGovernmentCall] == 0)
            {
                FactionInfo[factionid][FactionGovernmentCall] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionGovernmentCall] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's government landline perms to %d.", factionid, FactionInfo[factionid][FactionGovernmentCall]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "policecalls", true))
        {
            if(FactionInfo[factionid][FactionPoliceCall] == 0)
            {
                FactionInfo[factionid][FactionPoliceCall] = 1;
            }
            else
            {
                FactionInfo[factionid][FactionPoliceCall] = 0;
            }
            
            SendServerMessage(playerid, "You set faction %d's police call perms to %d.", factionid, FactionInfo[factionid][FactionPoliceCall]);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "abbrev", true))
        {
            if(isnull(secString))
            {
                SendUsageMessage(playerid, "/editfaction factionid abbrev [New Abbreviation]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] Minimum of 2 characters & maximum of 30 characters.");
                return 1;
            }
            
            if(strlen(secString) < 2)
                return SendErrorMessage(playerid, "Abbreviation can only be a mimumum of 2 characters");

            if(strlen(secString) > 30)
                return SendErrorMessage(playerid, "Abbreviation can only be a maximum of 30 characters");
                
            format(FactionInfo[factionid][FactionAbbrev], 90, "%s",secString);
            
            SendServerMessage(playerid, "You set faction %d's abbreviation to %s.", factionid, secString);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "name", true))
        {
            if(isnull(secString))
            {
                SendUsageMessage(playerid, "/editfaction factionid name [New Name]");
                SendClientMessage(playerid, COLOR_WHITE, "[NOTE] Minimum of 5 characters & maximum of 90 characters.");
                return 1;
            }
            
            if(strlen(secString) < 5)
                return SendErrorMessage(playerid, "Name can only be a mimumum of 5 characters");

            if(strlen(secString) > 90)
                return SendErrorMessage(playerid, "Name can only be a maximum of 90 characters");
                
            format(FactionInfo[factionid][FactionName], 90, "%s",secString);
            
            SendServerMessage(playerid, "You set faction %d's name to %s.", factionid, secString);
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "alterrank", true))
        {
            new rankid;
            
            if(sscanf(secString, "d", rankid))
            {
                SendUsageMessage(playerid, "/editfaction factionid alterrank [rank]");
                SendServerMessage(playerid, "This is the rank that may edit the factions name and other permissions."); 
                return 1;
            }
            
            if(rankid < 1 || rankid > MAX_FACTION_RANKS-1)
                return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
                
            FactionInfo[factionid][FactionAlterRank] = rankid;
            SendServerMessage(playerid, "You set faction %d's alter rank to %d.", factionid, rankid);
            
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "factionhc", true))
        {
            new rankid;
            
            if(sscanf(secString, "d", rankid))
            {
                SendUsageMessage(playerid, "/editfaction factionid factionhc [rank]");
                SendServerMessage(playerid, "This is the rank that may communicate using /fhc. /fhc is intended for High Command only.");
                return 1;
            }
            
            if(rankid < 1 || rankid > MAX_FACTION_RANKS-1)
                return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
                
            FactionInfo[factionid][FactionHighCommandChat] = rankid;
            SendServerMessage(playerid, "You set faction %d's alter rank to %d.", factionid, rankid);
            
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "joinrank", true))
        {
            new rankid;
            
            if(sscanf(secString, "d", rankid))
            {
                SendUsageMessage(playerid, "/editfaction factionid joinrank [rank]");
                SendServerMessage(playerid, "This is the rank a player receives when they join this faction."); 
                return 1;
            }
            
            if(rankid < 1 || rankid > MAX_FACTION_RANKS-1)
                return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
                
            FactionInfo[factionid][FactionJoinRank] = rankid;
            SendServerMessage(playerid, "You set faction %d's join rank to %d.", factionid, rankid);
            
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "chatrank", true))
        {
            new rankid;
            
            if(sscanf(secString, "d", rankid))
            {
                SendUsageMessage(playerid, "/editfaction factionid chatrank [rank]");
                SendServerMessage(playerid, "This is the rank a player needs to access faction chat.");
                return 1;
            }
            
            if(rankid < 1 || rankid > MAX_FACTION_RANKS-1)
                return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
                
            FactionInfo[factionid][FactionChatRank] = rankid;
            SendServerMessage(playerid, "You set faction %d's chat rank to %d.", factionid, rankid);
            
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "towrank", true))
        {
            new rankid;
            
            if(sscanf(secString, "d", rankid))
            {
                SendUsageMessage(playerid, "/editfaction factionid towrank [rank]");
                SendServerMessage(playerid, "This is the rank a player needs to tow faction vehicles.");
                return 1;
            }
            
            if(rankid < 1 || rankid > MAX_FACTION_RANKS-1)
                return SendErrorMessage(playerid, "Faction ranks are between 1-20.");  
                
            FactionInfo[factionid][FactionTowRank] = rankid;
            SendServerMessage(playerid, "You set faction %d's tow rank to %d.", factionid, rankid); 
            
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "spawn", true))
        {
            GetPlayerPos(playerid, FactionInfo[factionid][FactionSpawn][0], FactionInfo[factionid][FactionSpawn][1], FactionInfo[factionid][FactionSpawn][2]);
            
            FactionInfo[factionid][FactionSpawnInt] = GetPlayerInterior(playerid);
            
            FactionInfo[factionid][FactionSpawnWorld] = GetPlayerVirtualWorld(playerid);
            
            SendServerMessage(playerid, "You changed faction %d's spawn point."); 
            SaveFaction(factionid);
        }
        else if(!strcmp(oneString, "dutyspot", true))
        {
            GetPlayerPos(playerid, FactionInfo[factionid][FactionDutyPos][0], FactionInfo[factionid][FactionDutyPos][1], FactionInfo[factionid][FactionDutyPos][2]);
            
            FactionInfo[factionid][FactionDutyInt] = GetPlayerInterior(playerid);
            
            FactionInfo[factionid][FactionDutyWorld] = GetPlayerVirtualWorld(playerid);
            
            SendServerMessage(playerid, "You changed faction %d's /duty point."); 
            SaveFaction(factionid);
        }
        else return SendErrorMessage(playerid, "Invalid Parameter.");
        return 1;
    }
    return 1;
}

stock SaveFactions()
{
    for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(FactionInfo[i][FactionID])
		{
			SaveFaction(i);
		}
	}
    return 1;
}

stock SaveFaction(id)
{
	if(!FactionInfo[id][FactionID])
		return 0;
		
	new threadSave[256];
	
	mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET FactionName = '%e', FactionAbbrev = '%e', FactionJoinRank = %i, FactionAlterRank = %i, FactionHighCommandChat = %i, FactionChatRank = %i, FactionTowRank = %i, FactionType = %i WHERE FactionID = %i LIMIT 1",
		FactionInfo[id][FactionName],
		FactionInfo[id][FactionAbbrev],
		FactionInfo[id][FactionJoinRank],
		FactionInfo[id][FactionAlterRank],
        FactionInfo[id][FactionHighCommandChat],
		FactionInfo[id][FactionChatRank],
		FactionInfo[id][FactionTowRank],
		FactionInfo[id][FactionType],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);
	
	mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET FactionSpawnX = %f, FactionSpawnY = %f, FactionSpawnZ = %f, FactionSpawnInterior = %i, FactionSpawnWorld = %i, RamRaid = %i WHERE FactionID = %i LIMIT 1",
		FactionInfo[id][FactionSpawn][0],
		FactionInfo[id][FactionSpawn][1],
		FactionInfo[id][FactionSpawn][2],
		FactionInfo[id][FactionSpawnInt],
		FactionInfo[id][FactionSpawnWorld],
        FactionInfo[id][RamRaid],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET FactionDutyX = %f, FactionDutyY = %f, FactionDutyZ = %f, FactionDutyInterior = %i, FactionDutyWorld = %i WHERE FactionID = %i LIMIT 1",
		FactionInfo[id][FactionDutyPos][0],
		FactionInfo[id][FactionDutyPos][1],
		FactionInfo[id][FactionDutyPos][2],
		FactionInfo[id][FactionDutyInt],
		FactionInfo[id][FactionDutyWorld],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);
    
    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET PoliceCall = %d, MedicCall = %d, GovernmentCall = %d, Badge = %d, Carsign = %d, Cuff = %d, Deploy = %d WHERE FactionID = %i LIMIT 1",
		FactionInfo[id][FactionPoliceCall],
		FactionInfo[id][FactionMedicCall],
        FactionInfo[id][FactionGovernmentCall],
        FactionInfo[id][FactionBadge],
        FactionInfo[id][FactionCarsign],
        FactionInfo[id][FactionCuff],
        FactionInfo[id][FactionDeploy],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET Backup = %d, Departmental = %d, Impound = %d, Jail = %d, Megaphone = %d, Suspect = %d WHERE FactionID = %i LIMIT 1",
		FactionInfo[id][FactionBackup],
		FactionInfo[id][FactionDepartmental],
        FactionInfo[id][FactionImpound],
        FactionInfo[id][FactionJail],
        FactionInfo[id][FactionMegaphone],
        FactionInfo[id][FactionSuspect],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET License = %d, Seize = %d, Taser = %d, HQ = %d, Gov = %d, Siren = %d, DutyAccess = %d, Ticket = %d, MDC = %d WHERE FactionID = %i LIMIT 1",
        FactionInfo[id][FactionLicense],
        FactionInfo[id][FactionSeize],
        FactionInfo[id][FactionTaser],
        FactionInfo[id][FactionHQ],
        FactionInfo[id][FactionGov],
        FactionInfo[id][FactionSiren],
        FactionInfo[id][FactionDutyAccess],
        FactionInfo[id][FactionTicket],
        FactionInfo[id][FactionMDC],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET Medic = %d, News = %d, Tag = %d, RamRaidPerm = %d, ChatColour = %d, FHCColour, DrugRights = %d, Economy = %d WHERE FactionID = %i LIMIT 1",
        FactionInfo[id][FactionMedic],
        FactionInfo[id][FactionNews],
        FactionInfo[id][FactionTag],
        FactionInfo[id][FactionRamRaid],
        FactionInfo[id][ChatColour],
        FactionInfo[id][FHCColour],
        FactionInfo[id][FactionDrugRights],
        FactionInfo[id][FactionEconomy],
		FactionInfo[id][FactionID]);
	mysql_tquery(g_SQL, threadSave);

    mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET WeaponDelivery = %d WHERE FactionID = %i LIMIT 1",
        FactionInfo[id][WeaponDelivery]);
	mysql_tquery(g_SQL, threadSave);

    for(new i = 1; i < MAX_FACTION_RANKS; i++)
    {
        mysql_format(g_SQL, threadSave, sizeof(threadSave), "UPDATE factions SET FactionRank%d = '%e', FactionRankPay%d = %d WHERE FactionID = %i LIMIT 1",
            i,
            FactionRanks[id][i],
            i,
            FactionRankPay[id][i],
            FactionInfo[id][FactionID]);
        mysql_tquery(g_SQL, threadSave);
    }
	return 1;
}

CMD:towcars(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        new factionID, bool:vFound = false;
        if(sscanf(params, "i", factionID))
            return SendUsageMessage(playerid, "/towcars [Faction ID] - See /factions for Faction ID.");
        
        if(!FactionInfo[factionID][FactionID] || factionID > MAX_FACTIONS)
            return SendErrorMessage(playerid, "You specified an invalid Faction ID.");
        
        for(new i = 1; i < MAX_DYN_VEH; i++)
        {
            if(VehicleInfo[i][vFactionID] == factionID)
            {
                if(!IsVehicleOccupied(VehicleInfo[i][vScriptID]))
                {
                    vFound = true;
                    RespawnVehicle(VehicleInfo[i][vScriptID]);
                }
            }
        }
        if(vFound)
		{
			foreach(new g : Player) if(PlayerInfo[g][pFaction] == factionID)
				SendClientMessageEx(g, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s has returned all faction vehicles to their parking place.", GetAdminRank(playerid), GetMasterName(playerid));
		}
		else SendErrorMessage(playerid, "No vehicles are available to tow.");
        return 1;
    }
    new factionID = PlayerInfo[playerid][pFaction], bool:vFound = false;
    if(factionID > 0)
    {
        if(PlayerInfo[playerid][pFactionRank] <= FactionInfo[factionID][FactionTowRank] || PlayerInfo[playerid][pFactionRank] <= 1)
        {
            for(new i = 1; i < MAX_DYN_VEH; i++)
            {
                if(VehicleInfo[i][vFactionID] == factionID)
                {
                    if(!IsVehicleOccupied(VehicleInfo[i][vScriptID]))
                    {
                        vFound = true;
                        RespawnVehicle(VehicleInfo[i][vScriptID]);
                    }
                }
            }
            if(vFound)
            {
                foreach(new g : Player) if(PlayerInfo[g][pFaction] == factionID)
                    SendClientMessageEx(g, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s has returned all faction vehicles to their parking place.", GetPlayerRank(playerid), GetUserName(playerid));
            }
            else SendErrorMessage(playerid, "No vehicles are available to tow.");
        }
        return 1;
    }
    SendErrorMessage(playerid, "You are not allowed to use this command.");
    return 1;
}

CMD:f(playerid, params[])
{
    new facid = PlayerInfo[playerid][pFaction];
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction."); 
	
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionChatRank])
		return SendErrorMessage(playerid, "Your rank doesn't have faction OOC chat permissions.");
		
    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	/*if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "You have your faction chat toggled. Use \"/togfam\" to enable.");*/

	if(isnull(params)) return SendUsageMessage(playerid, "/f [OOC Text]");

	if(FactionChatStatus[facid] == true && PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionAlterRank])
	{
		SendErrorMessage(playerid, "Your factions OOC chat is disabled.");  
		return 1;
	}

    new badgeStr[10];
    if(FactionInfo[facid][FactionBadge] == 1 && PlayerInfo[playerid][pBadgeNo] > 0)
    {
        format(badgeStr, sizeof badgeStr, " (#%d)", PlayerInfo[playerid][pBadgeNo]);
    }
	
	if(strlen(params) > 70)
	{
		SendFactionChat(facid, FactionInfo[factionid][ChatColour], "** (( %s %s%s: %.70s ... )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params); 
		SendFactionChat(facid, FactionInfo[factionid][ChatColour], "** (( %s %s%s: ... %s )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params[70]); 
	}
	else SendFactionChat(facid, FactionInfo[factionid][ChatColour], "** (( %s %s%s: %s )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params);
    OOC_Log(playerid, params);
	return 1;
}

CMD:fhc(playerid, params[])
{
    new facid = PlayerInfo[playerid][pFaction];
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction."); 
	
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionChatRank])
		return SendErrorMessage(playerid, "Your rank doesn't have faction OOC chat permissions.");
		
    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");

	/*if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "You have your faction chat toggled. Use \"/togfam\" to enable.");*/

	if(isnull(params)) return SendUsageMessage(playerid, "/fhc [High Command OOC Text]");

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionHighCommandChat])
	{
		SendErrorMessage(playerid, "Your factions OOC chat is disabled.");  
		return 1;
	}

    new badgeStr[10];
    if(FactionInfo[facid][FactionBadge] == 1 && PlayerInfo[playerid][pBadgeNo] > 0)
    {
        format(badgeStr, sizeof badgeStr, " (#%d)", PlayerInfo[playerid][pBadgeNo]);
    }
	
	if(strlen(params) > 70)
	{
		SendFactionChat(facid, FactionInfo[factionid][FHCColour], "** (( %s %s%s: %.70s ... )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params); 
		SendFactionChat(facid, FactionInfo[factionid][FHCColour], "** (( %s %s%s: ... %s )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params[70]); 
	}
	else SendFactionChat(facid, FactionInfo[factionid][FHCColour], "** (( %s %s%s: %s )) **", GetPlayerRank(playerid), GetUserName(playerid), badgeStr, params);
    OOC_Log(playerid, params);
	return 1;
}

CMD:fann(playerid, params[])
{
    if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
    {
        new factionID, message[128];
        if(sscanf(params, "is[128]", factionID,message))
            return SendUsageMessage(playerid, "/fann [Faction ID] [Message] - See /factions for Faction ID.");
        
        if(!FactionInfo[factionID][FactionID] || factionID > MAX_FACTIONS)
            return SendErrorMessage(playerid, "You specified an invalid Faction ID.");
        
        if(strlen(params) > 70)
        {
            SendFactionMessage(factionID, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: %.70s ...", GetAdminRank(playerid), GetMasterName(playerid), message); 
            SendFactionMessage(factionID, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: ... %s", GetAdminRank(playerid), GetMasterName(playerid), message[70]); 
        }
        else SendFactionMessage(factionID, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: %s", GetAdminRank(playerid), GetMasterName(playerid), message);
        if(PlayerInfo[playerid][pFaction] != factionID)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: %s", GetAdminRank(playerid), GetMasterName(playerid), message);
        }
        return 1;
    }

    new facid = PlayerInfo[playerid][pFaction];
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction."); 
	
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionAlterRank])
		return SendErrorMessage(playerid, "Your rank doesn't have faction announcement permissions.");

    if(Player[playerid][Ajailed] == 1)
        return SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");
    
	/*if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "You have your faction chat toggled. Use \"/togfam\" to enable.");*/

	if(isnull(params)) return SendUsageMessage(playerid, "/fann [OOC Text]");


	if(strlen(params) > 70)
	{
		SendFactionMessage(facid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: %.70s ...", GetPlayerRank(playerid), GetUserName(playerid), params); 
		SendFactionMessage(facid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: ... %s", GetPlayerRank(playerid), GetUserName(playerid), params[70]); 
	}
	else SendFactionMessage(facid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s: %s", GetPlayerRank(playerid), GetUserName(playerid), params);
	return 1;
}

CMD:nofac(playerid, params[])
{
	new facid = PlayerInfo[playerid][pFaction];
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionAlterRank])
		return SendErrorMessage(playerid, "Your rank doesn't have permission to alter the faction chat.");
		
	if(FactionChatStatus[facid] == true)
	{
		SendFactionMessage(facid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s turned the Faction OOC (/f) chat on.", GetPlayerRank(playerid), GetUserName(playerid));
		FactionChatStatus[facid] = false;
	}
	else
	{
		SendFactionMessage(facid, COLOR_LIGHTGREEN, "[FACTION]:{FFFFFF} %s %s turned the Faction OOC (/f) chat off.", GetPlayerRank(playerid), GetUserName(playerid));
		FactionChatStatus[facid] = true;
	}	
	return 1;
}

stock SendFactionChat(factionid, colour, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(Player[i][Ajailed] == 1)
                continue;

            if(PlayerInfo[i][pFaction] == factionid && TempVar[i][FactionDisabled] == false)
			{
                SendClientMessage(i, colour, string);
            }
		}
		return 1;
	}
    foreach (new i : Player) 
    {
        if(Player[i][Ajailed] == 1)
            continue;
        
        if(PlayerInfo[i][pFaction] == factionid && TempVar[i][FactionDisabled] == false)
        {
            SendClientMessage(i, colour, str);
        }
    }
	return 1;
}

stock SendFactionDutyMessage(factionid, colour, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(PlayerInfo[i][pFaction] == factionid && IsOnDuty(i))
			{
                SendClientMessage(i, colour, string);
            }
		}
		return 1;
	}
    foreach (new i : Player) 
    {
        if(PlayerInfo[i][pFaction] == factionid && IsOnDuty(i))
        {
            SendClientMessage(i, colour, str);
        }
    }
	return 1;
}

stock SendFactionMessage(factionid, colour, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(PlayerInfo[i][pFaction] == factionid)
			{
                SendClientMessage(i, colour, string);
            }
		}
		return 1;
	}
    foreach (new i : Player) 
    {
        if(PlayerInfo[i][pFaction] == factionid)
        {
            SendClientMessage(i, colour, str);
        }
    }
	return 1;
}

stock GetPlayerRank(playerid)
{
    new rankStr[90];
    rankStr = "Civilian";
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        new 
			factionid = PlayerInfo[playerid][pFaction],
			rank = PlayerInfo[playerid][pFactionRank];
			
		format(rankStr, sizeof(rankStr), "%s", FactionRanks[factionid][rank]);
    }
    return rankStr;
}

CMD:setpfaction(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, facid, rank, str[128];
        if(sscanf(params, "udd", targetid, facid, rank))
        {
            SendUsageMessage(playerid, "/setpfaction [PlayerID/PartOfName] [faction id] [rank]");
            return 1;
        }

        if(!IsPlayerConnected(targetid) || Player[targetid][IsLoggedIn] == false)
        {
            SendErrorMessage(playerid, "This player is not connected or not logged in.");
            return 1;
        }

        if(facid == 0)
        {
            new string[256];
            PlayerInfo[targetid][pFaction] = 0;
            PlayerInfo[targetid][pFactionRank] = 0;
            mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Faction` = %d, `FactionRank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[targetid][pFaction], PlayerInfo[targetid][pFactionRank], PlayerInfo[targetid][pCharacterID]);
            mysql_tquery(g_SQL, string);
            if(targetid != playerid) 
            {
                format(str, sizeof(str), "%s removed %s from their faction.", GetMasterName(playerid), GetUserName(targetid));
                SendAdminCommand(str, 4);
            }
            SendServerMessage(targetid, "You were removed from your faction by %s %s.", GetAdminRank(playerid), GetMasterName(playerid));
            return 1;
        }

        if(!FactionInfo[facid][FactionID]) return SendErrorMessage(playerid, "The faction you specified doesn't exist.");

        PlayerInfo[targetid][pFaction] = facid;
        PlayerInfo[targetid][pFactionRank] = rank;

        new string[256];
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Faction` = %d, `FactionRank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[targetid][pFaction], PlayerInfo[targetid][pFactionRank], PlayerInfo[targetid][pCharacterID]);
        mysql_tquery(g_SQL, string);
        if(targetid != playerid) 
        {
            format(str, sizeof(str), "%s set %s's faction to %d (rank: %d).", GetMasterName(playerid), GetUserName(targetid), facid, rank);
	        SendAdminCommand(str, 4);
        }
        SendServerMessage(targetid, "You were set to faction %d by %s %s.", facid, GetAdminRank(playerid), GetMasterName(playerid));
        if(FactionInfo[facid][FactionDepartmental] == 1)
        {
            if(!GetInventory(targetid, INV_RADIO))
            {
                AddInventory(targetid, INV_RADIO, 1);
                SendClientMessageEx(targetid, COLOR_YELLOW, "-> You were given a radio as a result of joining a government faction. See /radiohelp.");
            }
        }
    }
    return 1;
}

stock LoadFactions()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `factions`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            cache_get_value_int(i, "FactionID", FactionInfo[i+1][FactionID]);
		
            cache_get_value_name(i, "FactionName", FactionInfo[i+1][FactionName], 90);
            cache_get_value_name(i, "FactionAbbrev", FactionInfo[i+1][FactionAbbrev], 30);
            
            cache_get_value_float(i, "FactionSpawnX", FactionInfo[i+1][FactionSpawn][0]);
            cache_get_value_float(i, "FactionSpawnY", FactionInfo[i+1][FactionSpawn][1]);
            cache_get_value_float(i, "FactionSpawnZ", FactionInfo[i+1][FactionSpawn][2]);
            
            cache_get_value_int(i, "FactionSpawnInterior", FactionInfo[i+1][FactionSpawnInt]);
            cache_get_value_int(i, "FactionSpawnWorld", FactionInfo[i+1][FactionSpawnWorld]);

            cache_get_value_float(i, "FactionDutyX", FactionInfo[i+1][FactionDutyPos][0]);
            cache_get_value_float(i, "FactionDutyY", FactionInfo[i+1][FactionDutyPos][1]);
            cache_get_value_float(i, "FactionDutyZ", FactionInfo[i+1][FactionDutyPos][2]);
            
            cache_get_value_int(i, "FactionDutyInterior", FactionInfo[i+1][FactionDutyInt]);
            cache_get_value_int(i, "FactionDutyWorld", FactionInfo[i+1][FactionDutyWorld]);
            
            cache_get_value_int(i, "FactionJoinRank", FactionInfo[i+1][FactionJoinRank]);
            cache_get_value_int(i, "FactionAlterRank", FactionInfo[i+1][FactionAlterRank]);
            cache_get_value_int(i, "FactionHighCommandChat", FactionInfo[i+1][FactionHighCommandChat]);
            cache_get_value_int(i, "FactionChatRank", FactionInfo[i+1][FactionChatRank]);
            cache_get_value_int(i, "FactionTowRank", FactionInfo[i+1][FactionTowRank]);
            cache_get_value_int(i, "RamRaid", FactionInfo[i+1][RamRaid]);
            cache_get_value_int(i, "ChatColour", FactionInfo[i+1][ChatColour]);
            cache_get_value_int(i, "FHCColour", FactionInfo[i+1][FHCColour]);
            
            cache_get_value_int(i, "FactionType", FactionInfo[i+1][FactionType]);

            // Faction Permissions
            cache_get_value_int(i, "PoliceCall", FactionInfo[i+1][FactionPoliceCall]);
            cache_get_value_int(i, "MedicCall", FactionInfo[i+1][FactionMedicCall]);
            cache_get_value_int(i, "GovernmentCall", FactionInfo[i+1][FactionGovernmentCall]);
            cache_get_value_int(i, "Badge", FactionInfo[i+1][FactionBadge]);
            cache_get_value_int(i, "Carsign", FactionInfo[i+1][FactionCarsign]);
            cache_get_value_int(i, "Cuff", FactionInfo[i+1][FactionCuff]);
            cache_get_value_int(i, "Deploy", FactionInfo[i+1][FactionDeploy]);
            cache_get_value_int(i, "Backup", FactionInfo[i+1][FactionBackup]);
            cache_get_value_int(i, "Departmental", FactionInfo[i+1][FactionDepartmental]);
            cache_get_value_int(i, "Impound", FactionInfo[i+1][FactionImpound]);
            cache_get_value_int(i, "Jail", FactionInfo[i+1][FactionJail]);
            cache_get_value_int(i, "Megaphone", FactionInfo[i+1][FactionMegaphone]);
            cache_get_value_int(i, "Suspect", FactionInfo[i+1][FactionSuspect]);
            cache_get_value_int(i, "License", FactionInfo[i+1][FactionLicense]);
            cache_get_value_int(i, "Seize", FactionInfo[i+1][FactionSeize]);
            cache_get_value_int(i, "Taser", FactionInfo[i+1][FactionTaser]);
            cache_get_value_int(i, "HQ", FactionInfo[i+1][FactionHQ]);
            cache_get_value_int(i, "Gov", FactionInfo[i+1][FactionGov]);
            cache_get_value_int(i, "Siren", FactionInfo[i+1][FactionSiren]);
            cache_get_value_int(i, "DutyAccess", FactionInfo[i+1][FactionDutyAccess]);
            cache_get_value_int(i, "Ticket", FactionInfo[i+1][FactionTicket]);
            cache_get_value_int(i, "MDC", FactionInfo[i+1][FactionMDC]);
            cache_get_value_int(i, "Medic", FactionInfo[i+1][FactionMedic]);
            cache_get_value_int(i, "News", FactionInfo[i+1][FactionNews]);
            cache_get_value_int(i, "Tag", FactionInfo[i+1][FactionTag]);
            cache_get_value_int(i, "RamRaidPerm", FactionInfo[i+1][FactionRamRaid]);
            cache_get_value_int(i, "DrugRights", FactionInfo[i+1][FactionDrugRights]);
            cache_get_value_int(i, "WeaponDelivery", FactionInfo[i+1][WeaponDelivery]);
            cache_get_value_int(i, "Economy", FactionInfo[i+1][FactionEconomy]);
            
            new newThread[128];
            for (new j = 1; j < MAX_FACTION_RANKS; j++)
            {
                format(newThread, sizeof(newThread), "FactionRank%i", j); 
                cache_get_value_name(i, newThread, FactionRanks[i+1][j], 60);

                format(newThread, sizeof(newThread), "FactionRankPay%i", j); 
                cache_get_value_name_int(0, newThread, FactionRankPay[i+1][j]);
            }
        }
    }
    cache_delete(result); 
}

CMD:factions(playerid, params[])
{
	new str[182], longstr[556]; 

    strcat(longstr, "Faction ID\t\t\tFaction Name\t\t\tMembers Online\n");
	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(!FactionInfo[i][FactionID])
			continue;
			
		format(str, sizeof(str), "%d\t\t\t%s\t\t\t%d Online\n", i, FactionInfo[i][FactionName], GetFactionOnlineMemberCount(i));
		strcat(longstr, str);
	}
	
	Dialog_Show(playerid, FactionList, DIALOG_STYLE_TABLIST_HEADERS, "Faction List", longstr, "Okay", ""); 
	return 1;
}

stock GetFactionOnlineMemberCount(factionid)
{
	new counter;
	foreach(new i : Player)
	{	
		if(PlayerInfo[i][pFaction] == factionid)
		{
			counter++;
		}
	}
	return counter;
}

/*stock GetFactionTotalMemberCount(factionid)
{
	if(factionid == 0 || !FactionInfo[factionid][FactionID])
		return 0; 
		
	new threadCheck[128], counter;
	
	mysql_format(g_SQL, threadCheck, sizeof(threadCheck), "SELECT COUNT(*) FROM characters WHERE Faction = %i", factionid);
	mysql_query(g_SQL, threadCheck);
	
	//counter = cache_get_row_int(0, 0);
    counter = cache_get_value_int(0, "", 0);
	return counter;
}*/

stock GetFactionAbbrev(factionid)
{
    new nameStr[90];
    nameStr = "UNDEFINED";

    if(FactionInfo[factionid][FactionID] > 0)
    {
        if(strlen(FactionInfo[factionid][FactionAbbrev]) > 0)
        {		
            format(nameStr, sizeof(nameStr), "%s", FactionInfo[factionid][FactionAbbrev]);
        }    
    }
    return nameStr;
}

stock GetFactionName(factionid)
{
    new nameStr[90];
    nameStr = "Undefined";

    if(FactionInfo[factionid][FactionID] > 0)
    {
        if(strlen(FactionInfo[factionid][FactionName]) > 0)
        {		
            format(nameStr, sizeof(nameStr), "%s", FactionInfo[factionid][FactionName]);
        }    
    }
    return nameStr;
}

CMD:invite(playerid, params[])
{
	new playerb, facid = PlayerInfo[playerid][pFaction];
	
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/invite [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction])
		return SendErrorMessage(playerid, "The player you specified is already in a faction."); 
		
	TempVar[playerb][FactionInvite] = facid;	
	TempVar[playerb][FactionInvitedBy] = playerid;
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "%s has invited you to join the %s, type \"/accept faction\" to join.", GetUserName(playerid), GetFactionName(facid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "You invited %s to join the %s.", GetUserName(playerb), GetFactionName(facid));
	return 1;
}

stock HandleFactionAccept(playerid)
{
    if(PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You're already in a faction.");

	if(!TempVar[playerid][FactionInvite])
		return SendErrorMessage(playerid, "You weren't invited to join any faction.");
			
	SendServerMessage(TempVar[playerid][FactionInvitedBy], "%s accepted your faction invitation.", GetUserName(playerid));
	SendServerMessage(playerid, "You joined '%s'", GetFactionName(TempVar[playerid][FactionInvite]));
	
	PlayerInfo[playerid][pFaction] = TempVar[playerid][FactionInvite]; 
	PlayerInfo[playerid][pFactionRank] = FactionInfo[TempVar[playerid][FactionInvite]][FactionJoinRank]; 
	
	TempVar[playerid][FactionInvite] = 0;
	TempVar[playerid][FactionInvitedBy] = INVALID_PLAYER_ID;

    if(FactionInfo[TempVar[playerid][FactionInvite]][FactionDepartmental] == 1 || FactionInfo[TempVar[playerid][FactionInvite]][FactionGov] == 1)
    {
        if(!GetInventory(playerid, INV_RADIO))
        {
            AddInventory(playerid, INV_RADIO, 1);
            SendClientMessageEx(playerid, COLOR_YELLOW, "-> You were given a radio as a result of joining a government faction. See /radiohelp.");
        }
    }
    new string[256];
	mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Faction` = %d, `FactionRank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pFaction], PlayerInfo[playerid][pFactionRank], PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, string);
    return 1;
}

CMD:uninvite(playerid, params[])
{
	new playerb, facid = PlayerInfo[playerid][pFaction];
	
	if(!facid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[facid][FactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uninvite [playerid OR name]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction] != facid)
		return SendErrorMessage(playerid, "The player you specified is not in your faction.");

    if(PlayerInfo[playerb][pFactionRank] < PlayerInfo[playerid][pFactionRank])
		return SendErrorMessage(playerid, "You don't have permission to do this.");
	
	SendServerMessage(playerb, "You were removed from the %s by %s.", GetFactionName(facid), GetUserName(playerid));
	SendServerMessage(playerid, "You removed %s from your faction.", GetUserName(playerb));
	
	PlayerInfo[playerb][pFaction] = 0;
	PlayerInfo[playerb][pFactionRank] = 0;
	
	SetSkin(playerb, 264);
    new string[256];
    mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Faction` = %d, `FactionRank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerb][pFaction], PlayerInfo[playerb][pFactionRank], PlayerInfo[playerb][pCharacterID]);
    mysql_tquery(g_SQL, string);
	return 1;
}

CMD:ranks(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
	
    new string[55*MAX_FACTION_RANKS];
    for(new i = 1; i < MAX_FACTION_RANKS; i++)
    {
        if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
            continue;
            
        format(string, sizeof string, "%s%i\t%s\t($%s/hour)\n", string, i, FactionRanks[PlayerInfo[playerid][pFaction]][i], FormatNumber(FactionRankPay[PlayerInfo[playerid][pFaction]][i]));
    }
    Dialog_Show(playerid, Unused, DIALOG_STYLE_MSGBOX, "Faction Ranks", string, "Okay", "");
	return 1;
}

CMD:factionon(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction];
    if(!factionid)
        return SendErrorMessage(playerid, "You aren't in any faction.");

    SendClientMessageEx(playerid, COLOR_GREY, "Members of %s online:", GetFactionName(factionid));
    
    foreach(new i : Player)
    {
        if(PlayerInfo[i][pFaction] != PlayerInfo[playerid][pFaction])
            continue;
            
        if(Player[i][AdminLevel] >= 1 && TempVar[i][AdminDuty] == true)
        {
            SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) {00FF00}%s %s", i, GetPlayerRank(i), GetUserName(i));
            continue;
        }
        if(IsOnDuty(i) && FactionInfo[factionid][FactionDutyAccess])
        {
            SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) {%06x}%s %s", i, FactionInfo[factionid][ChatColour] >>> 8, GetPlayerRank(i), GetUserName(i));
            continue;
        }
        SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s %s", i, GetPlayerRank(i), GetUserName(i));
    }
	return 1;
}
alias:factionon("fon", "members");

CMD:setrank(playerid, params[])
{
	new playerb, rank;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][FactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "ui", playerb, rank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
        {
            if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
                continue;
                
            SendClientMessageEx(playerid, COLOR_YELLOW, "%i. %s ($%s/hour)", i, FactionRanks[PlayerInfo[playerid][pFaction]][i], FormatNumber(FactionRankPay[PlayerInfo[playerid][pFaction]][i]));
        }
	
		SendUsageMessage(playerid, "/setrank [player id] [rank id]");
		return 1;
	}
	
	if(rank < 1 || rank > MAX_FACTION_RANKS-1)
		return SendErrorMessage(playerid, "You specified an invalid rank."); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "The player you specified isn't connected."); 
		
	if(Player[playerb][IsLoggedIn] == false)
		return SendErrorMessage(playerid, "The player you specified hasn't logged in yet.");
		
	if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "The player you specified is not in your faction.");
		
	if(PlayerInfo[playerb][pFactionRank] < PlayerInfo[playerid][pFactionRank])
		return SendErrorMessage(playerid, "You can't alter %s's rank.", GetUserName(playerb)); 
		
	SendServerMessage(playerb, "Your rank has been set from %s to %s by %s!", FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank], GetUserName(playerid));
	SendServerMessage(playerid, "You set %s's rank from %s to %s!", GetUserName(playerb), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
		
	PlayerInfo[playerb][pFactionRank] = rank; 
    new string[256];
	mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `FactionRank` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerb][pFactionRank], PlayerInfo[playerb][pCharacterID]);
    mysql_tquery(g_SQL, string);
	return 1;
}

CMD:setrankpay(playerid, params[])
{
	new payment, rank, factionid = PlayerInfo[playerid][pFaction];
	
	if(!factionid)
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	if(sscanf(params, "ii", rank, payment))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
        {
            if(!strcmp(FactionRanks[factionid][i], "NotSet"))
                continue;
                
            SendClientMessageEx(playerid, COLOR_YELLOW, "%i. %s ($%d/hour)", i, FactionRanks[factionid][i], FactionRankPay[PlayerInfo[playerid][pFaction]][i]);
        }
	
		SendUsageMessage(playerid, "/setrankpay [rank id] [hourly pay]");
		return 1;
	}
	
	if(rank < 1 || rank > MAX_FACTION_RANKS-1)
		return SendErrorMessage(playerid, "You specified an invalid rank."); 

    if(payment < 1 || payment > 100)
		return SendErrorMessage(playerid, "Payment cannot be less than 1 or higher than 100.");
		
	SendServerMessage(playerid, "You set rank %d pay from $%d to $%d!", FactionRankPay[factionid][rank], payment);
		
    FactionRankPay[factionid][rank] = payment;
    SaveFaction(factionid);
	return 1;
}

stock ShowFactionConfig(playerid)
{
	new rankCount, infoString[128], showString[256]; 
	
    format(infoString, sizeof(infoString), "Faction Name: %s\n", FactionInfo[PlayerInfo[playerid][pFaction]][FactionName]);
	strcat(showString, infoString);

    format(infoString, sizeof(infoString), "Faction Abbreviation: %s\n", FactionInfo[PlayerInfo[playerid][pFaction]][FactionAbbrev]);
	strcat(showString, infoString);

	format(infoString, sizeof(infoString), "Join Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][FactionJoinRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "Chat Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][FactionChatRank]);
	strcat(showString, infoString);
	
	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
			continue;
			
		rankCount++;
	}
	
	format(infoString, sizeof(infoString), "Faction Ranks (%i)\n", rankCount);
	strcat(showString, infoString); 
	
	format(infoString, sizeof(infoString), "Tow Rank: %d\n", FactionInfo[PlayerInfo[playerid][pFaction]][FactionTowRank]);
	strcat(showString, infoString);

    strcat(showString, "Faction Spawn\n");

    strcat(showString, "Chat Colour\n");

    strcat(showString, "High Command Chat Colour\n");

    strcat(showString, "Duty Point\n");
	
	Dialog_Show(playerid, DIALOG_FACTION_CONFIG, DIALOG_STYLE_LIST, "Faction Configuration", showString, "Select", "<<");
	return 1;
}

Dialog:DIALOG_FACTION_CONFIG(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: 
            {
                if(PlayerInfo[playerid][pFactionRank] == 1)
                {
                    Dialog_Show(playerid, FACTION_ALTER_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new name:", "Select", "<<");
                }
                else 
                {
                    SendErrorMessage(playerid, "You cannot use this command. You need to be the faction leader.");
                    ShowFactionConfig(playerid);
                }
                return 1;
            }
            case 1:
            {
                if(PlayerInfo[playerid][pFactionRank] == 1)
                {
                    Dialog_Show(playerid, FACTION_ALTER_ABBR, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new abbreviation:", "Select", "<<");
                }
                else 
                {
                    SendErrorMessage(playerid, "You cannot use this command. You need to be the faction leader.");
                    ShowFactionConfig(playerid);
                }
                return 1;
            }
            case 2: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new join rank:", "Select", "<<");
            case 3: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new chat rank:", "Select", "<<"); 
            case 4: return Dialog_Show(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions rank ID you want to alter. (1-20)", "Select", "<<");
            case 5: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions new tow rank:", "Select", "<<"); 
            case 6:
            {
                if(PlayerInfo[playerid][pFactionRank] != 1)
							return SendErrorMessage(playerid, "The factions spawn may only be changed by the leader.");
					
                AdjustFactionSpawn(PlayerInfo[playerid][pFaction], playerid);
                SaveFaction(PlayerInfo[playerid][pFaction]);

                SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions spawn has been altered."); 
                return ShowFactionConfig(playerid);
            }
            case 7: return Dialog_Show(playerid, DIALOG_FACTION_CHAT, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new OOC chat color (Example: 0x8D8DFFFF):", "Select", "<<"); 
            case 8: return Dialog_Show(playerid, DIALOG_FACTION_FHC, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new high command chat color (Example: 0x8D8DFFFF):", "Select", "<<"); 
            case 9:
            {
                if(PlayerInfo[playerid][pFactionRank] != 1)
							return SendErrorMessage(playerid, "The factions duty point may only be changed by the leader.");
					
                AdjustFactionDuty(PlayerInfo[playerid][pFaction], playerid);
                SaveFaction(PlayerInfo[playerid][pFaction]);

                SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions duty point has been altered."); 
                return ShowFactionConfig(playerid);
            }
        }
    }
    return 1;
}

stock AdjustFactionSpawn(factionid, playerid)
{
    GetPlayerPos(playerid, FactionInfo[factionid][FactionSpawn][0], FactionInfo[factionid][FactionSpawn][1], FactionInfo[factionid][FactionSpawn][2]);

    FactionInfo[factionid][FactionSpawnInt] = GetPlayerInterior(playerid);

    FactionInfo[factionid][FactionSpawnWorld] = GetPlayerVirtualWorld(playerid);
}

stock AdjustFactionDuty(factionid, playerid)
{
    GetPlayerPos(playerid, FactionInfo[factionid][FactionDutyPos][0], FactionInfo[factionid][FactionDutyPos][1], FactionInfo[factionid][FactionDutyPos][2]);

    FactionInfo[factionid][FactionDutyInt] = GetPlayerInterior(playerid);

    FactionInfo[factionid][FactionDutyWorld] = GetPlayerVirtualWorld(playerid);
}

Dialog:DIALOG_FACTION_CHAT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    FactionInfo[PlayerInfo[playerid][pFaction]][ChatColour] = HexToInt(inputtext);
    SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions chat color was altered.");
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_FHC(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    FactionInfo[PlayerInfo[playerid][pFaction]][FHCColour] = HexToInt(inputtext);
    SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions high command chat color was altered.");
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:FACTION_ALTER_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 89)
        return Dialog_Show(playerid, FACTION_ALTER_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new name:\nFaction name must be below 90 characters.", "Select", "<<");
        
    SendClientMessageEx(playerid, COLOR_YELLOW, "> You edited your faction name to: \"%s\". ", inputtext);
    format(FactionInfo[PlayerInfo[playerid][pFaction]][FactionName], 90, "%s", inputtext);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:FACTION_ALTER_ABBR(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 29)
        return Dialog_Show(playerid, FACTION_ALTER_ABBR, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new abbreviation:", "Select", "<<");
        
    SendClientMessageEx(playerid, COLOR_YELLOW, "> You edited your faction abbrevion to: \"%s\". ", inputtext);
    format(FactionInfo[PlayerInfo[playerid][pFaction]][FactionAbbrev], 30, "%s", inputtext);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_ALTER_T(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new tow rank:", "Select", "<<"); 
        
    new rankid = strval(inputtext); 
    
    if(rankid > 20 || rankid < 1)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions chat rank must be between 1-20.\n\nEnter your factions new tow rank:", "Select", "<<");

    FactionInfo[PlayerInfo[playerid][pFaction]][FactionTowRank] = rankid;
    SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions tow rank is now: %i.", rankid);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_RANKEDIT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
        
    new str[128];
        
    if(strlen(inputtext) > 60 || strlen(inputtext) < 1)
    {
        format(str, sizeof(str), "Your rank should be less than 60 characters.\n\nYou're editing your factions rank ID %i ('%s').\n{F81414}To remove this rank, set the name to \"NotSet\". Case sensitive.", FactionRanks[PlayerInfo[playerid][pFaction]][PlayerEditingRank[playerid]], PlayerEditingRank[playerid]);
        return Dialog_Show(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "Select", "<<"); 
    }
    
    SendClientMessageEx(playerid, COLOR_YELLOW, "> You edited faction rank %i (%s) to: \"%s\". ", PlayerEditingRank[playerid], FactionRanks[PlayerInfo[playerid][pFaction]][PlayerEditingRank[playerid]], inputtext);
    format(FactionRanks[PlayerInfo[playerid][pFaction]][PlayerEditingRank[playerid]], 60, "%s", inputtext);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_RANKS(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
        
    new rankid = strval(inputtext), str[128];
    
    if(rankid > 20 || rankid < 1)
        return Dialog_Show(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter the factions rank ID you want to alter. (1-20)", "Select", "<<");
        
    PlayerEditingRank[playerid] = rankid;
    
    format(str, sizeof(str), "You're editing your factions rank ID %i ('%s').\n\n{F81414}To remove this rank, set the name to \"NotSet\". Case sensitive.", rankid, FactionRanks[PlayerInfo[playerid][pFaction]][rankid]);
    return Dialog_Show(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "Select", "<<"); 
}

Dialog:DIALOG_FACTION_ALTER_C(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new chat rank:", "Select", "<<"); 

    new rankid = strval(inputtext); 
    
    if(rankid > 20 || rankid < 1)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions chat rank must be between 1-20.\n\nEnter your factions new chat rank:", "Select", "<<"); 
    
    FactionInfo[PlayerInfo[playerid][pFaction]][FactionChatRank] = rankid;
    SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions chat rank is now: %i.", rankid);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_ALTER_J(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowFactionConfig(playerid);
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Enter your factions new join rank:", "Select", "<<"); 

    new rankid = strval(inputtext); 
    
    if(rankid > 20 || rankid < 1)
        return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "Your factions join rank must be between 1-20.\n\nEnter your factions new join rank:", "Select", "<<"); 
    
    FactionInfo[PlayerInfo[playerid][pFaction]][FactionJoinRank] = rankid;
    SendClientMessageEx(playerid, COLOR_YELLOW, "> Your factions join rank is now: %i.", rankid);
    
    SaveFaction(PlayerInfo[playerid][pFaction]);
    return ShowFactionConfig(playerid);
}

CMD:factionconfig(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > 1)
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
	
	ShowFactionConfig(playerid);
	return 1;
}

CMD:factionhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    new factionid = PlayerInfo[playerid][pFaction];
    if(PlayerInfo[playerid][pFaction] > 0)
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Faction Help:{FFFFFF} Type a command for more information.");

        new list[144], counter = 0;
        if (!counter)
        {
            format(list, sizeof list, "/f (faction chat), /tog faction, /ranks, /factionon");
            counter += 4;
        }
        else if (counter)
        {
            format(list, sizeof list, "%s, /f (faction chat), /tog faction, /ranks, /factionon", list);
            counter += 4;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionBadge] == 1)
        {
            format(list, sizeof list, "/badge, /setbadge, /osetbadge");
            counter += 3;
        }
        else if (counter && FactionInfo[factionid][FactionBadge] == 1)
        {
            format(list, sizeof list, "%s, /badge, /setbadge, /osetbadge", list);
            counter += 3;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionCarsign] == 1)
        {
            format(list, sizeof list, "/carsign, /carsignremove");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionCarsign] == 1)
        {
            format(list, sizeof list, "%s, /carsign, /carsignremove", list);
            counter += 2;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionCuff] == 1)
        {
            format(list, sizeof list, "/handcuff, /unhandcuff");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionCuff] == 1)
        {
            format(list, sizeof list, "%s, /handcuff, /unhandcuff", list);
            counter += 2;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionDeploy] == 1)
        {
            format(list, sizeof list, "/roadblock, /spike, /spikeL, /spikeR");
            counter += 4;
        }
        else if (counter && FactionInfo[factionid][FactionDeploy] == 1)
        {
            format(list, sizeof list, "%s, /roadblock, /spike, /spikeL, /spikeR", list);
            counter += 4;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        // if (!counter && FactionInfo[factionid][FactionBackup] == 1)
        // {
        //     format(list, sizeof list, "/bk");
        //     counter += 1;
        // }
        // else if (counter && FactionInfo[factionid][FactionBackup] == 1)
        // {
        //     format(list, sizeof list, "%s, /bk", list);
        //     counter += 1;
        // }

        // if (counter >= 7)
        // {
        //     SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
        //     counter = 0;
        //     list[0] = 0;
        // }

        if (!counter && FactionInfo[factionid][FactionDepartmental] == 1)
        {
            format(list, sizeof list, "/(dep)artments, /deplow");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionDepartmental] == 1)
        {
            format(list, sizeof list, "%s, /(dep)artments, /deplow", list);
            counter += 2;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionImpound] == 1)
        {
            format(list, sizeof list, "/impound");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionImpound] == 1)
        {
            format(list, sizeof list, "%s, /impound", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionJail] == 1)
        {
            format(list, sizeof list, "/jail, /prison");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionJail] == 1)
        {
            format(list, sizeof list, "%s, /jail, /prison", list);
            counter += 2;
        }
        
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionMegaphone] == 1)
        {
            format(list, sizeof list, "/(m)egaphone");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionMegaphone] == 1)
        {
            format(list, sizeof list, "%s, /(m)egaphone", list);
            counter += 1;
        }
        
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "/(su)spect");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "%s, /(su)spect", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "/givelicense");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "%s, /givelicense", list);
            counter += 1;
        }
        
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "/take, /seizeplant");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionSuspect] == 1)
        {
            format(list, sizeof list, "%s, /take, /seizeplant", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionTaser] == 1)
        {
            format(list, sizeof list, "/taser, /rubberbullets");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionTaser] == 1)
        {
            format(list, sizeof list, "%s, /taser, /rubberbullets", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionHQ] == 1)
        {
            format(list, sizeof list, "/hq");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionHQ] == 1)
        {
            format(list, sizeof list, "%s, /hq", list);
            counter += 1;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionGov] == 1)
        {
            format(list, sizeof list, "/gov");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionGov] == 1)
        {
            format(list, sizeof list, "%s, /gov", list);
            counter += 1;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionSiren] == 1)
        {
            format(list, sizeof list, "/siren, /elm");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionSiren] == 1)
        {
            format(list, sizeof list, "%s, /siren, /elm", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionDutyAccess] == 1)
        {
            format(list, sizeof list, "/duty, /uniform, /govaccessories");
            counter += 3;
        }
        else if (counter && FactionInfo[factionid][FactionDutyAccess] == 1)
        {
            format(list, sizeof list, "%s, /duty, /uniform, /govaccessories", list);
            counter += 3;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }
        
        if (!counter && FactionInfo[factionid][FactionTicket] == 1)
        {
            format(list, sizeof list, "/fine, /vfine, /excusefine");
            counter += 3;
        }
        else if (counter && FactionInfo[factionid][FactionTicket] == 1)
        {
            format(list, sizeof list, "%s, /fine, /vfine, /excusefine", list);
            counter += 3;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionMDC] == 1)
        {
            format(list, sizeof list, "/mdc, /bolo");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionMDC] == 1)
        {
            format(list, sizeof list, "%s, /mdc, /bolo", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionMedic] == 1)
        {
            format(list, sizeof list, "/putinambu, /operation");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionMedic] == 1)
        {
            format(list, sizeof list, "%s, /putinambu, /operation", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionNews] == 1)
        {
            format(list, sizeof list, "/news, /live");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionNews] == 1)
        {
            format(list, sizeof list, "%s, /news, /live", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionTag] == 1)
        {
            format(list, sizeof list, "/graffiti");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionTag] == 1)
        {
            format(list, sizeof list, "%s, /graffiti", list);
            counter += 1;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionRamRaid] == 1)
        {
            format(list, sizeof list, "/ramraid, /cutwire");
            counter += 2;
        }
        else if (counter && FactionInfo[factionid][FactionRamRaid] == 1)
        {
            format(list, sizeof list, "%s, /ramraid, /cutwire", list);
            counter += 2;
        }
        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionDrugRights] == 1)
        {
            format(list, sizeof list, "/buyseed");
            counter += 1;
        }
        else if (counter && FactionInfo[factionid][FactionDrugRights] == 1)
        {
            format(list, sizeof list, "%s, /buyseed", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionTowRank])
        {
            format(list, sizeof list, "/towcars");
            counter += 1;
        }
        else if (counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionTowRank])
        {
            format(list, sizeof list, "%s, /towcars", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && FactionInfo[factionid][FactionEconomy] == 1 && PlayerInfo[playerid][pFactionRank] < 2)
        {
            format(list, sizeof list, "/taxrate, /taxwithdraw, /taxdeposit, /taxtransfer");
            counter += 4;
        }
        else if (counter && FactionInfo[factionid][FactionEconomy] == 1 && PlayerInfo[playerid][pFactionRank] < 2)
        {
            format(list, sizeof list, "%s, /taxrate, /taxwithdraw, /taxdeposit, /taxtransfer", list);
            counter += 4;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionHighCommandChat])
        {
            format(list, sizeof list, "/fhc");
            counter += 1;
        }
        else if (counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionHighCommandChat])
        {
            format(list, sizeof list, "%s, /fhc", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionAlterRank])
        {
            format(list, sizeof list, "/invite, /uninvite, /setrank, /nofac");
            counter += 1;
        }
        else if (counter && PlayerInfo[playerid][pFactionRank] < FactionInfo[factionid][FactionAlterRank])
        {
            format(list, sizeof list, "%s, /invite, /uninvite, /setrank, /nofac", list);
            counter += 1;
        }

        if (counter >= 7)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }

        if (!counter && PlayerInfo[playerid][pFactionRank] <= 1)
        {
            format(list, sizeof list, "/factionconfig");
            counter += 1;
        }
        else if (counter && PlayerInfo[playerid][pFactionRank] <= 1)
        {
            format(list, sizeof list, "%s, /factionconfig", list);
            counter += 1;
        }

        if (counter >= 1)
        {
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "Commands: {FFFFFF}%s.", list);
            counter = 0;
            list[0] = 0;
        }
    }
    else SendErrorMessage(playerid, "You are not in a faction.");
    SendClientMessage(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:gotofaction(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new factionid;
        if(sscanf(params, "d", factionid))
            return SendUsageMessage(playerid, "/gotofaction [Faction ID]");

        if(!FactionInfo[factionid][FactionID])
            return SendErrorMessage(playerid, "The faction you specified doesn't exist.");

        SetPlayerPosEx(playerid, FactionInfo[factionid][FactionSpawn][0], FactionInfo[factionid][FactionSpawn][1], FactionInfo[factionid][FactionSpawn][2]);
        SetInterior(playerid, FactionInfo[factionid][FactionSpawnInt]);
        SetVirtualWorld(playerid, FactionInfo[factionid][FactionSpawnWorld]);
        SendClientMessageEx(playerid, COLOR_GREY, ">>> {FFFFFF}You have been teleported to faction %d's spawn.", factionid);
    }
    return 1;
}

CMD:gotofactionduty(playerid, params[])
{
    if(IsAdminLevel(playerid, 3))
    {
        new factionid;
        if(sscanf(params, "d", factionid))
            return SendUsageMessage(playerid, "/gotofactionduty [Faction ID]");

        if(!FactionInfo[factionid][FactionID])
            return SendErrorMessage(playerid, "The faction you specified doesn't exist.");

        SetPlayerPosEx(playerid, FactionInfo[factionid][FactionDutyPos][0], FactionInfo[factionid][FactionDutyPos][1], FactionInfo[factionid][FactionDutyPos][2]);
        SetInterior(playerid, FactionInfo[factionid][FactionDutyInt]);
        SetVirtualWorld(playerid, FactionInfo[factionid][FactionDutyWorld]);
        SendClientMessageEx(playerid, COLOR_GREY, ">>> {FFFFFF}You have been teleported to faction %d's /duty spot.", factionid);
    }
    return 1;
}

CMD:setbadge(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][FactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 
    
	new targetid, badgenumber;
	if (sscanf(params, "ui", targetid, badgenumber))
		return SendUsageMessage(playerid, "/setbadge [PlayerID/PartOfName] [Badge Number]");
    
	if (!IsPlayerConnected(targetid))
	    return SendErrorMessage(playerid, "The player is not online, use /osetbadge.");

	if (PlayerInfo[playerid][pFaction] != PlayerInfo[targetid][pFaction])
        return SendErrorMessage(playerid, "Player is not in the same faction as you.");

	PlayerInfo[targetid][pBadgeNo] = badgenumber;
	SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_CYAN, "** %s %s has set badge number #%i to faction member %s.", GetPlayerRank(playerid), GetUserName(playerid), badgenumber, GetUserName(targetid));
	return 1;
}

CMD:osetbadge(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "You aren't in any faction.");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][FactionAlterRank])
		return SendErrorMessage(playerid, "You don't have permission to use this command."); 

	new target[MAX_PLAYER_NAME], badgenumber;
	if (sscanf(params, "s[25]i", target, badgenumber))
		return SendUsageMessage(playerid, "/osetbadge [Target_Name] [Badge Number]");

	new id = GetPlayeridByName(target);
	if (id == INVALID_PLAYER_ID)
	{
		new query[256];
		format(query, sizeof(query), "SELECT ID, Faction FROM characters WHERE Name = '%q'", target);
		mysql_tquery(g_SQL, query, "OnSetPlayerBadge", "isi", playerid, target, badgenumber);
	}
	else
	{
		if (PlayerInfo[playerid][pFaction] != PlayerInfo[id][pFaction])
		{
			return SendErrorMessage(playerid, "Player is not in the same faction as you.");
		}
		PlayerInfo[id][pBadgeNo] = badgenumber;
		SendFactionMessage(PlayerInfo[playerid][pFaction], COLOR_CYAN, "** %s %s has set badge number #%i to faction member %s.", GetPlayerRank(playerid), GetUserName(playerid), badgenumber, GetUserName(id));
	}
	return 1;
}