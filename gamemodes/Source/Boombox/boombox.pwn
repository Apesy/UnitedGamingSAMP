//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/*
	Boombox System Design Spec
	Commands:
	[Player] /buy -> Boombox (Standard 24/7)
    [Player] /inv -> Boombox -> Place boombox in hand.
    [Player] /putboombox -> Dialog: Confirm Place Boombox + Information -> Place Boombox + Show SA-MP object editor for boombox.
	[Player] /grabboombox -> Check if player is not holding an item or weapon, then place boombox in player hand.
	[Player] /giveboombox [playerid] -> Give ownership to another player.
	[Player] /boomboxhelp -> Show all boombox commands.
    [Player] /setstation -> Check if near boombox, if yes then show standard radio dialog.
	[Level 1+ Admin & on duty cops] /seizeboombox -> Check if near boombox, if yes then show dialog to confirm if they want to seize.
*/

#include <YSI\y_hooks>

#define MAX_BOOMBOX 25
#define BOOMBOX_RANGE 25.0 // Default 25 SA-MP meters.

enum boomboxEnum
{
	bool:Used,
	OwnerID,
	URL[128],
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosRX,
	Float:PosRY,
	Float:PosRZ,
	Interior,
	VirtualWorld,
	Float:AudioRange,

	ObjectID,
	Text3D:Label,
	AreaID
};
new BoomboxInfo[MAX_BOOMBOX][boomboxEnum];

stock ResetBoombox(id)
{
	if(IsValidDynamicObject(BoomboxInfo[id][ObjectID]))
	{
		DestroyDynamicObject(BoomboxInfo[id][ObjectID]);
	}

	if(IsValidDynamic3DTextLabel(BoomboxInfo[id][Label]))
	{
		DestroyDynamic3DTextLabel(BoomboxInfo[id][Label]);
	}

	if(IsValidDynamicArea(BoomboxInfo[id][AreaID]))
	{
		DestroyDynamicArea(BoomboxInfo[id][AreaID]);
	}

	BoomboxInfo[id][Used] = false;
	BoomboxInfo[id][OwnerID] = INVALID_PLAYER_ID;
	BoomboxInfo[id][URL][0] = 0;
	BoomboxInfo[id][PosX] = 0.0;
	BoomboxInfo[id][PosY] = 0.0;
	BoomboxInfo[id][PosZ] = 0.0;
	BoomboxInfo[id][PosRX] = 0.0;
	BoomboxInfo[id][PosRY] = 0.0;
	BoomboxInfo[id][PosRZ] = 0.0;
	BoomboxInfo[id][Interior] = 0;
	BoomboxInfo[id][VirtualWorld] = 0;
	BoomboxInfo[id][AudioRange] = 0.0;
}

stock ReloadBoombox(id)
{
	if(IsValidDynamicObject(BoomboxInfo[id][ObjectID]))
	{
		DestroyDynamicObject(BoomboxInfo[id][ObjectID]);
	}

	if(IsValidDynamic3DTextLabel(BoomboxInfo[id][Label]))
	{
		DestroyDynamic3DTextLabel(BoomboxInfo[id][Label]);
	}

	if(IsValidDynamicArea(BoomboxInfo[id][AreaID]))
	{
		DestroyDynamicArea(BoomboxInfo[id][AreaID]);
	}

	BoomboxInfo[id][ObjectID] = CreateDynamicObject(2226, 
		BoomboxInfo[id][PosX], BoomboxInfo[id][PosY], BoomboxInfo[id][PosZ], 
		BoomboxInfo[id][PosRX], BoomboxInfo[id][PosRY], BoomboxInfo[id][PosRZ], 
		.worldid = BoomboxInfo[id][Interior], .interiorid = BoomboxInfo[id][VirtualWorld]);
	BoomboxInfo[id][Label] = CreateDynamic3DTextLabel("Boombox", COLOR_GREEN, BoomboxInfo[id][PosX], BoomboxInfo[id][PosY], BoomboxInfo[id][PosZ]+0.5, 10.0, .worldid = BoomboxInfo[id][Interior], .interiorid = BoomboxInfo[id][VirtualWorld]);
	BoomboxInfo[id][AreaID] = CreateDynamicCircle(BoomboxInfo[id][PosX], BoomboxInfo[id][PosY], BoomboxInfo[id][AudioRange], .worldid = BoomboxInfo[id][Interior], .interiorid = BoomboxInfo[id][VirtualWorld]);
}

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(strlen(CoreVehicle[vehicleid][RadioURL]) < 1)
	{
		for(new i; i < MAX_BOOMBOX; i++)
		{
			if(BoomboxInfo[i][Used] == true && BoomboxInfo[i][AreaID] == areaid)
			{
				if(strlen(BoomboxInfo[i][URL]) > 0)
				{
					PlayBoombox(playerid, i);
				}
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA areaid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(strlen(CoreVehicle[vehicleid][RadioURL]) < 1)
	{
		for(new i; i < MAX_BOOMBOX; i++)
		{
			if(BoomboxInfo[i][Used] == true && BoomboxInfo[i][AreaID] == areaid)
			{
				if(strlen(BoomboxInfo[i][URL]) > 0)
				{
					StopAudioStreamForPlayer(playerid);
				}
			}
		}
	}
	return 1;
}

hook OnGameModeInit()
{
	for(new i; i < MAX_BOOMBOX; i++)
	{
		ResetBoombox(i);
	}
	return 1;
}

stock PlayBoombox(playerid, id)
{
	PlayAudioStreamForPlayer(playerid, BoomboxInfo[id][URL], BoomboxInfo[id][PosX], BoomboxInfo[id][PosY], BoomboxInfo[id][PosZ], BoomboxInfo[id][AudioRange], 1);
}

stock IsPlayerNearBoombox(playerid, Float:range = 3.0)
{
	for(new i; i < MAX_BOOMBOX; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, BoomboxInfo[i][PosX], BoomboxInfo[i][PosY], BoomboxInfo[i][PosZ]))
		{
			return i;
		}
	}
	return -1;
}

CMD:boomboxhelp(playerid, params[])
{
	SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Boombox Help:{FFFFFF} Type a command for more information.");
	SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /putboombox, /grabboombox, /setstation, /giveboombox");
	SendClientMessageEx(playerid, COLOR_GRAD4, "Buying: You can buy a boombox at a 24/7.");
	if(Player[playerid][AdminLevel] >= 1)
	{
		SendClientMessageEx(playerid, COLOR_GRAD3, "Admin Commands: /seizeboombox [You need to be on admin duty]");
	}
	SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
	return 1;
}

CMD:giveboombox(playerid, params[])
{
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendUsageMessage(playerid, "/giveboombox [PlayerID/PartOfName]");

	if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "No such player is online.");

	if(!IsPlayerNearPlayer(playerid, targetid, 5))
		return SendErrorMessage(playerid, "You are not near the other player.");
	
	if(PlayerInfo[playerid][pHoldingInv] == INV_BOOMBOX)
	{
		HoldInventoryItem(targetid, INV_BOOMBOX, 1);
		StopHoldInventoryItem(playerid);
		SendServerMessage(targetid, "You were given a boombox by %s.", GetRPName(playerid));
		SendServerMessage(playerid, "You have given %s a boombox.", GetRPName(targetid));
		return 1;
	}

	new bbid = IsPlayerNearBoombox(playerid);
	if(bbid != -1)
	{
		BoomboxInfo[bbid][OwnerID] = targetid;
		SendServerMessage(targetid, "You were given ownership of a boombox by %s.", GetRPName(playerid));
		SendServerMessage(playerid, "You have given ownership of %s a boombox.", GetRPName(targetid));
		return 1;
	}
	return 1;
}

CMD:grabboombox(playerid, params[])
{
	new bbid = IsPlayerNearBoombox(playerid);
	if(bbid != -1)
	{
		if(BoomboxInfo[bbid][OwnerID] != playerid)
			return SendErrorMessage(playerid, "You cannot grab this boombox, you do not own it.");
		
		foreach(new i: Player)
		{
			if(IsPlayerNearBoombox(i, BoomboxInfo[bbid][AudioRange]) == bbid)
			{
				StopAudioStreamForPlayer(i);
			}
		}
		ResetBoombox(bbid);
		HoldInventoryItem(playerid, INV_BOOMBOX, 1);
		SendServerMessage(playerid, "You are now holding the boombox. Use /boomboxhelp to see available commands.");
	}
	else SendErrorMessage(playerid, "You are not near a boombox.");
	return 1;
}

CMD:seizeboombox(playerid, params[])
{
	if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
	{
		new bbid = IsPlayerNearBoombox(playerid), string[128];
		if(bbid != -1)
		{
			SendClientMessageEx(playerid, -1, "Removed boombox owned by %s.", GetUserName(BoomboxInfo[bbid][OwnerID]));
			format(string, sizeof string, "%s %s has removed boombox %d.", GetAdminRank(playerid), GetMasterName(playerid));
			SendAdminCommand(string, 1);
			foreach(new i: Player)
			{
				if(IsPlayerNearBoombox(i, BoomboxInfo[bbid][AudioRange]) == bbid)
				{
					StopAudioStreamForPlayer(i);
				}
			}
			ResetBoombox(bbid);
		}
		else SendErrorMessage(playerid, "You are not near a boombox.");
		return 1;
	}
	if(PlayerInfo[playerid][pFaction] >= 1 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionSeize] == 1)
	{
		new bbid = IsPlayerNearBoombox(playerid), string[128];
		if(bbid != -1)
		{
			SendClientMessageEx(playerid, -1, "Removed boombox owned by %s.", GetUserName(BoomboxInfo[bbid][OwnerID]));
			format(string, sizeof string, "Law Enforcer %s has removed boombox %d.", GetUserName(playerid));
			SendAdminWarning(1, string);
			foreach(new i: Player)
			{
				if(IsPlayerNearBoombox(i, BoomboxInfo[bbid][AudioRange]) == bbid)
				{
					StopAudioStreamForPlayer(i);
				}
			}
			ResetBoombox(bbid);
		}
		else SendErrorMessage(playerid, "You are not near a boombox.");
		return 1;
	}
	SendErrorMessage(playerid, "You cannot use this command.");
	return 1;
}

CMD:putboombox(playerid, params[])
{
	if(IsPlayerNearBoombox(playerid) != -1)
	{
		SendErrorMessage(playerid, "You are too close to another boombox, please move away from it.");
		return 1;
	}

	if(PlayerInfo[playerid][pHoldingInv] != INV_BOOMBOX)
	{
		SendErrorMessage(playerid, "You need to be holding a boombox (/inventory).");
		return 1;
	}

	Dialog_Show(playerid, Confirm_Place, DIALOG_STYLE_MSGBOX, "Confirm", "Are you sure you want to place this boombox down?\n\
	If you log off with the boombox still placed, it will be automatically deleted unless you give ownership of it to someone else.", "Yes", "No");
	return 1;
}

new EditBoomboxID[MAX_PLAYERS];
Dialog:Confirm_Place(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		for(new id; id < MAX_BOOMBOX; id++)
		{
			if(!BoomboxInfo[id][Used])
			{
				GetPlayerPos(playerid, BoomboxInfo[id][PosX], BoomboxInfo[id][PosY], BoomboxInfo[id][PosZ]);
				BoomboxInfo[id][PosY] = BoomboxInfo[id][PosY] + 1;
				BoomboxInfo[id][Interior] = GetPlayerInterior(playerid);
				BoomboxInfo[id][VirtualWorld] = GetPlayerVirtualWorld(playerid);
				BoomboxInfo[id][OwnerID] = playerid;
				BoomboxInfo[id][AudioRange] = 25.0;

				ReloadBoombox(id);
				EditDynamicObject(playerid, BoomboxInfo[id][ObjectID]);
				TempVar[playerid][EditType] = EDIT_TYPE_BOOMBOX;
				EditBoomboxID[playerid] = id;
				StopHoldInventoryItem(playerid);

				BoomboxInfo[id][Used] = true;
				SendClientMessage(playerid, COLOR_YELLOW, "Use your {00FF00}Mouse Cursor{FFFF00} to select a button or move the object. Use {00FF00}~k~~PED_SPRINT~{FFFF00} to adjust the camera.");
            	SendClientMessage(playerid, COLOR_YELLOW, "Click the {00FF00}Floppy Disk{FFFF00} to confirm the adjustment or press {00FF00}ESC{FFFF00} to cancel.");
				return 1;
			}
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < MAX_BOOMBOX; i++)
	{
		if(BoomboxInfo[i][OwnerID] == playerid)
		{
			foreach(new p: Player)
			{
				if(IsPlayerNearBoombox(p, BoomboxInfo[i][AudioRange]) == i)
				{
					StopAudioStreamForPlayer(p);
				}
			}
			ResetBoombox(i);
		}
	}
	return 1;
}

stock OnPlayerAttemptBuyBoombox(playerid, bizid)
{
	if(PlayerInfo[playerid][pMoney] >= 100)
	{
		TakeMoney(playerid, 100);
		HoldInventoryItem(playerid, INV_BOOMBOX, 1);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a boombox for $100.");
		SendClientMessage(playerid, COLOR_WHITE, "You have purchased a boombox. /boomboxhelp to see your new commands.");
		BusinessInfo[bizid][BizSafe] += 100;
	}
	return 1;
}