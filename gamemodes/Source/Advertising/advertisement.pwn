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

#define MAX_ADVERTS 11

enum advertEnum
{
    AdvertText[144],
    PublishTime,
    PlacedBy,
    AdvertType,
    bool:AdvertExists
}
new AdvertisementInfo[MAX_ADVERTS][advertEnum],
    WatchingAdvertID[MAX_PLAYERS];

hook OnGameModeInit()
{
    for(new i; i < MAX_ADVERTS; i++)   
    {
        ResetAdvertisment(i);
    }
}

stock ListAdverts(playerid)
{
    static
        gListString[256*MAX_ADVERTS],
        count = 0
	;
        
	gListString = "#\t\tAdvert\t\tAirs In\n";
	for(new i = 1; i < MAX_ADVERTS; i++)
	{
	    if(AdvertisementInfo[i][AdvertExists])
	    {
            if(strlen(AdvertisementInfo[i][AdvertText]) > 70)
			{
                format(gListString, sizeof(gListString), "%s\n%d\t\t%.70s ...\t\t%i sec", gListString, i, AdvertisementInfo[i][AdvertText], AdvertisementInfo[i][PublishTime]);
            }
            else format(gListString, sizeof(gListString), "%s\n%d\t\t%s ...\t\t%i sec", gListString, i, AdvertisementInfo[i][AdvertText], AdvertisementInfo[i][PublishTime]);
            count ++;
		}
	}
	if (count == 0) SendErrorMessage(playerid, "There are no pending advertisements.");
	else Dialog_Show(playerid, ListAdverts, DIALOG_STYLE_TABLIST_HEADERS, "Advertisements", gListString, "View", "Exit");
    return 1;
}

Dialog:ListAdverts(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new string[256];
        WatchingAdvertID[playerid] = listitem+1;

        if(strlen(AdvertisementInfo[WatchingAdvertID[playerid]][AdvertText]) > 70)
        {
            //GetInventoryAmount(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], GetInventorySlot(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], INV_PHONE))
            format(string, sizeof string, "Advertisement posted by %s (%s)\n\n%.70s", GetRPName(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy]), GetInventoryAmount(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], GetInventorySlot(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], INV_PHONE)), AdvertisementInfo[WatchingAdvertID[playerid]][AdvertText]);
            format(string, sizeof string, "%s\n%s", string, AdvertisementInfo[WatchingAdvertID[playerid]][AdvertText][70]);
        }
        else format(string, sizeof string, "Advertisement posted by %s (%s)\n\n%s", GetRPName(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy]), GetInventoryAmount(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], GetInventorySlot(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], INV_PHONE)), AdvertisementInfo[WatchingAdvertID[playerid]][AdvertText]);
        Dialog_Show(playerid, ListAdverts_SeeOne, DIALOG_STYLE_MSGBOX, "Advertisements", string, "Back", "Exit");
    }
    return 1;
}

Dialog:ListAdverts_SeeOne(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        ListAdverts(playerid);
    }
    return 1;
}

stock PlayerInQueue(playerid)
{
   	new count = 0;
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, name, sizeof(name));
 	for(new i = 0; i < MAX_ADVERTS; i ++)
 	{
 	    if(AdvertisementInfo[i][PlacedBy] == playerid && AdvertisementInfo[i][AdvertExists]) count++;
	}
	return count;
}

stock GetNextAdSlot()
{
	for(new i = 1; i < MAX_ADVERTS; i++)
	{
		if(!AdvertisementInfo[i][AdvertExists])
			return i;
	}
	return -1;
}

stock ResetAdvertisment(i)
{
    AdvertisementInfo[i][AdvertText][0] = 0;
    AdvertisementInfo[i][PublishTime] = -1;
    AdvertisementInfo[i][PlacedBy] = INVALID_PLAYER_ID;
    AdvertisementInfo[i][AdvertType] = 0;
    AdvertisementInfo[i][AdvertExists] = false;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInQueue(playerid) >= 1)
	{
        new count = 0, string[128];
		for(new i; i < MAX_ADVERTS; i++)
		{
            if(AdvertisementInfo[i][PlacedBy] == playerid)
			{
                count++;
                ResetAdvertisment(i);
            }
		}
        format(string, sizeof string, "%s (%s) had %d active adverts placed prior to disconnecting, they've been reset.", GetUserName(playerid), GetMasterName(playerid));
        SendAdminWarning(1, string);
	}
    return 1;
}

stock PlaceAdvertisement(playerid, text[], type)
{
    new i = GetNextAdSlot();
    if(i != -1)
    {
        new string[128];
        format(AdvertisementInfo[i][AdvertText], 144, "%s", text);
        AdvertisementInfo[i][PublishTime] = i*60;
        AdvertisementInfo[i][PlacedBy] = playerid;
        AdvertisementInfo[i][AdvertType] = type;
        AdvertisementInfo[i][AdvertExists] = true;
        format(string, sizeof string, "%s (%d) placed advert: %s", GetUserName(playerid), playerid, text);
        SendAdminWarning(1, string);
    }
    return i;
}

stock SendAdvertisementMessage(colour, const str[], {Float,_}:...)
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

		foreach(new i: Player)
        {
            if(Player[i][Ajailed] != 1)
            {
                SendClientMessage(i, colour, string);
            }
        }
		return 1; 
	}
    foreach(new i: Player)
    {
        if(Player[i][Ajailed] != 1)
        {
            SendClientMessage(i, colour, str);
        }
    }
    return 1;
}

task AdvertisementTimer[1000]()
{
    for(new i = 1; i < MAX_ADVERTS; i++)
	{
		if(AdvertisementInfo[i][AdvertExists] && AdvertisementInfo[i][PublishTime] != -1)
        {
            AdvertisementInfo[i][PublishTime]--;
            if(AdvertisementInfo[i][PublishTime] < 1)
            {
                new playerid = AdvertisementInfo[i][PlacedBy], string[128];
                switch(AdvertisementInfo[i][AdvertType])
                {
                    case 2:
                    {
                        if(strlen(AdvertisementInfo[i][AdvertText]) > 70)
                        {
                            SendAdvertisementMessage(COLOR_ADVERT, "[Company Advertisement] %.70s", AdvertisementInfo[i][AdvertText]);
                            SendAdvertisementMessage(COLOR_ADVERT, "[Company Advertisement] ... %s", AdvertisementInfo[i][AdvertText][70]);
                        }
                        else SendAdvertisementMessage(COLOR_ADVERT, "[Company Advertisement] %s", AdvertisementInfo[i][AdvertText]);
                        format(string, sizeof string, "[Company Advertisement] %s (Username: %s IP: %s AccountID: %d)", AdvertisementInfo[i][AdvertText], GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                        DBLog("Advertisement", string);
                    }
                    default:
                    {
                        if(strlen(AdvertisementInfo[i][AdvertText]) > 70)
                        {
                            SendAdvertisementMessage(COLOR_ADVERT, "[Advertisement] %.70s", AdvertisementInfo[i][AdvertText]);
                            SendAdvertisementMessage(COLOR_ADVERT, "[Advertisement] ... %s (Contact: %d)", AdvertisementInfo[i][AdvertText][70], GetInventoryAmount(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], GetInventorySlot(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], INV_PHONE)));
                        }
                        else SendAdvertisementMessage(COLOR_ADVERT, "[Advertisement] %s (Contact: %d)", AdvertisementInfo[i][AdvertText], GetInventoryAmount(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], GetInventorySlot(AdvertisementInfo[WatchingAdvertID[playerid]][PlacedBy], INV_PHONE)));
                        format(string, sizeof string, "[Advertisement] %s (Username: %s IP: %s AccountID: %d)", AdvertisementInfo[i][AdvertText], GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
                        DBLog("Advertisement", string);
                    }
                }
                format(string, sizeof string, "Last advert was made by %s (%s).", GetUserName(playerid), GetMasterName(playerid));
                SendAdminWarning(1, string);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Your advertisement was posted.");
                ResetAdvertisment(i);
            }
        }
	}
}

CMD:cad(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/cad [Company Advertisement]");

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 2)
                {
                    new payout = strlen(params) * 2;
                    if(PlayerInfo[playerid][pMoney] >= payout)
                    {
                        if(PlayerInQueue(playerid) >= 1 && Player[playerid][DonateLevel] < 1)
                            return SendErrorMessage(playerid, "You already have an advertisement placed.");

                        if(PlayerInQueue(playerid) >= 2 && Player[playerid][DonateLevel] < 2)
                            return SendErrorMessage(playerid, "You already have a 2 advertisements placed.");

                        if(PlayerInQueue(playerid) >= 3 && Player[playerid][DonateLevel] < 3)
                            return SendErrorMessage(playerid, "You already have a 3 advertisements placed.");

                        new advertID = PlaceAdvertisement(playerid, params, 2);
                        if(advertID != -1)
                        {
                            new string[128];
                            format(string, sizeof(string), "~r~Paid $%d~n~~w~Message contained: %d Characters", payout, strlen(params));
                            PrintFooter(playerid, string, 5);
                            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Your advertisement was placed in the queue. It is #%d in the queue.", advertID);
                            BusinessInfo[i][BizSafe] += payout;
                            TakeMoney(playerid, payout);
                        }
                        else SendErrorMessage(playerid, "There are no advertisement slots available, please try again in a minute.");
                    }
                    else SendErrorMessage(playerid, "You do not have enough, this costs $%s.", FormatNumber(payout));
                    return 1;
                }
            }
        }
        SendErrorMessage(playerid, "You are not inside the correct business.");
    }
    else SendErrorMessage(playerid, "You are not inside a business.");
    return 1;
}

CMD:ads(playerid, params[])
{
    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 2)
                {
                    ListAdverts(playerid);
                    return 1;
                }
            }
        }
        SendErrorMessage(playerid, "You are not inside the correct business.");
    }
    else SendErrorMessage(playerid, "You are not inside a business.");
    return 1;
}

CMD:ad(playerid, params[])
{
    if(isnull(params))
        return SendUsageMessage(playerid, "/ad [Advertisement]");

    new bizid = IsPlayerInsideBiz(playerid);
    if(bizid != -1)
    {
        for(new i; i < MAX_BIZ; i++)
        {
            if(i == bizid)
            {
                if(BusinessInfo[i][BizType] == 2)
                {
                    if(GetInventory(playerid, INV_PHONE) == 0)
                        return SendErrorMessage(playerid, "You need a phone in order to do this.");

                    new payout = strlen(params) * 2;
                    if(PlayerInfo[playerid][pMoney] >= payout)
                    {
                        if(PlayerInQueue(playerid) >= 1 && Player[playerid][DonateLevel] < 1)
                            return SendErrorMessage(playerid, "You already have an advertisement placed, purchase donator to get more slots.");

                        if(PlayerInQueue(playerid) >= 2 && Player[playerid][DonateLevel] < 2)
                            return SendErrorMessage(playerid, "You already have a 2 advertisements placed.");

                        if(PlayerInQueue(playerid) >= 3 && Player[playerid][DonateLevel] < 3)
                            return SendErrorMessage(playerid, "You already have a 3 advertisements placed.");

                        new advertID = PlaceAdvertisement(playerid, params, 1);
                        if(advertID != -1)
                        {
                            new string[128];
                            format(string, sizeof(string), "~r~Paid $%d~n~~w~Message contained: %d Characters", payout, strlen(params));
                            PrintFooter(playerid, string, 5);
                            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Your advertisement was placed in the queue. It is #%d in the queue.", advertID);
                            BusinessInfo[i][BizSafe] += payout;
                            TakeMoney(playerid, payout);
                        }
                        else SendErrorMessage(playerid, "There are no advertisement slots available, please try again in a minute.");
                        return 1;
                    }
                    SendErrorMessage(playerid, "You do not have enough, this costs $%s.", FormatNumber(payout));
                    return 1;
                }
            }
        }
    }
    SendErrorMessage(playerid, "You are not inside an advertisement business.");
    return 1;
}