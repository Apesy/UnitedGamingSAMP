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

CMD:phone(playerid, params[])
{
    Dialog_Show(playerid, PhoneMain, DIALOG_STYLE_LIST, "Phone - Main Menu", "Call\nSMS\nRead SMS\nContacts\nAdd Contact", "Continue", "Exit");
    return 1;
}

Dialog:PhoneMain(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new query[128];
        switch(listitem)
        {
            case 0: Dialog_Show(playerid, PhoneDial, DIALOG_STYLE_INPUT, "Phone - Dial Number", "Type in a number\n[Emergency]: 911\n[Taxi]: 544 - [Mechanic]: 555\n[Police Non Emergency]: 909 - [Fire Dept Non Emergency]: 919", "Continue", "Exit");
            case 1: Dialog_Show(playerid, PhoneSMS, DIALOG_STYLE_INPUT, "Phone - SMS", "Type in a number", "Continue", "Exit");
            case 2:
            {
                mysql_format(g_SQL, query, sizeof query, "SELECT Number, Message FROM sms WHERE Reciever = %d LIMIT 10", PlayerInfo[playerid][pCharacterID]);
                mysql_tquery(g_SQL, query, "OnUserReadSMS", "d", playerid);
            }
            case 3:
            {
                mysql_format(g_SQL, query, sizeof query, "SELECT * FROM phone_contacts WHERE OwnerID = %d", PlayerInfo[playerid][pCharacterID]);
                mysql_tquery(g_SQL, query, "OnUserGetContacts", "d", playerid);
            }
            case 4:
            {
                Dialog_Show(playerid, PhoneContactAddNumber, DIALOG_STYLE_INPUT, "Phone - Add Contact", "Type in the number of this contact.", "Continue", "Exit");
            }
        }
    }
    return 1;
}

Dialog:PhoneContactAddNumber(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(isnull(inputtext))
            return Dialog_Show(playerid, PhoneContactAddNumber, DIALOG_STYLE_INPUT, "Phone - Add Contact", "ERROR: You must enter a number.\n\
            Type in the number of this contact.", "Continue", "Exit");

        new number = strval(inputtext);
        if(number == 0 || number == 911 || number == 544 || number == 555)
            return Dialog_Show(playerid, PhoneContactAddNumber, DIALOG_STYLE_INPUT, "Phone - Add Contact", "ERROR: You must enter a valid number.\n\
            Type in the number of this contact.", "Continue", "Exit");

        SetPVarInt(playerid, "ContactAddNumber", number);
        Dialog_Show(playerid, PhoneContactAddName, DIALOG_STYLE_INPUT, "Phone - Add Contact", "Type in the name of this contact.", "Continue", "Exit");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

Dialog:PhoneContactAddName(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(isnull(inputtext))
            return Dialog_Show(playerid, PhoneContactAddName, DIALOG_STYLE_INPUT, "Phone - Add Contact", "ERROR: You must enter something.\n\
            Type in the name of this contact.", "Continue", "Exit");

        if(strlen(inputtext) >= 128 || strlen(inputtext) < 1)
            return Dialog_Show(playerid, PhoneContactAddName, DIALOG_STYLE_INPUT, "Phone - Add Contact", "ERROR: You must enter a valid name. Max is 127 and min is 1.\n\
            Type in the name of this contact.", "Continue", "Exit");

        new number = GetPVarInt(playerid, "ContactAddNumber"), query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `phone_contacts` (`OwnerID`, `Name`, `Number`) VALUES (%d, '%e', %d)", PlayerInfo[playerid][pCharacterID], inputtext, number);
        mysql_tquery(g_SQL, query, "OnAddContact", "d", playerid);
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

function OnAddContact(playerid)
{
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* The contact has been added.");
    pc_cmd_phone(playerid, "");
    return 1;
}

new ListItemTrackID[MAX_PLAYERS][20],
    ListItemTrackDBID[MAX_PLAYERS][20],
    TrackingID[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    for(new i; i < 20; i++)
    {
        ListItemTrackID[playerid][i] = 0;
    }
    return 1;
}

Dialog:PhoneContactList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        TrackingID[playerid] = listitem;
        Dialog_Show(playerid, PhoneContactView, DIALOG_STYLE_LIST, "Phone Contact", "Call\nSMS\nRemove Contact", "Continue", "Exit");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

Dialog:PhoneContactView(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new szMiscArray[256];
        switch(listitem)
        {
            case 0:
            {
                format(szMiscArray, sizeof(szMiscArray), "%d", ListItemTrackID[playerid][TrackingID[playerid]]);
                pc_cmd_call(playerid, szMiscArray);
            }
            case 1:
            {
                TempVar[playerid][OnTextNumber] = ListItemTrackID[playerid][TrackingID[playerid]];
                Dialog_Show(playerid, SendSMSMessage, DIALOG_STYLE_INPUT, "Phone - SMS", "Type in your message\nMax of 128 characters.", "Send", "Cancel");
            }
            case 2:
            {
                mysql_format(g_SQL, szMiscArray, sizeof szMiscArray, "DELETE FROM `phone_contacts` WHERE `phone_contacts`.`ID` = %d", ListItemTrackDBID[playerid][TrackingID[playerid]]);
                mysql_tquery(g_SQL, szMiscArray, "OnRemoveContact", "d", playerid);
            }
        }
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

function OnRemoveContact(playerid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM phone_contacts WHERE OwnerID = %d", PlayerInfo[playerid][pCharacterID]);
    mysql_tquery(g_SQL, query, "OnUserGetContacts", "d", playerid);
}

function OnUserGetContacts(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new string[128*11], id, number, name[128], count = 0;
        format(string, sizeof string, "Name\t\tNumber\n");
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", id);
            cache_get_value_int(i, "Number", number);
            cache_get_value(i, "Name", name);
            format(string, sizeof string, "%s%s\t\t%d\n", string, name, number);
            ListItemTrackDBID[playerid][i] = id;
            ListItemTrackID[playerid][i] = number;
            count++;
        }
        if(count == 0)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "No contacts available.");
            pc_cmd_phone(playerid, "");
            return 1;
        }
        Dialog_Show(playerid, PhoneContactList, DIALOG_STYLE_TABLIST_HEADERS, "Phone - Contact List", string, "Continue", "Exit");
    }
    else 
    {
        SendClientMessage(playerid, COLOR_GRAD1, "You do not have any contacts.");
        pc_cmd_phone(playerid, "");
    }
    return 1;
}
function OnUserReadSMS(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new string[4096], textID, number, text[128], count = 0;
        format(string, sizeof string, "Number\tMessage\n");
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", textID);
            cache_get_value_int(i, "Number", number);
            cache_get_value(i, "Message", text);
            if(strlen(text) > 10)
            {
                format(string, sizeof string, "%s%d\t%s...\n", string, number, text[10]);
            }
            else format(string, sizeof string, "%s%d\t%s\n", string, number, text);
            ListItemTrackID[playerid][i] = textID;
            count++;
        }
        if(count == 0)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "No recent texts.");
            pc_cmd_phone(playerid, "");
            return 1;
        }
        Dialog_Show(playerid, PhoneSMSList, DIALOG_STYLE_TABLIST_HEADERS, "Phone - SMS List", string, "Read", "Back");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

Dialog:PhoneSMSList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new query[128];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM sms WHERE ID = %d LIMIT 1", ListItemTrackID[playerid][listitem]);
        mysql_tquery(g_SQL, query, "OnUserReadSMSMessage", "d", playerid);
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

function OnUserReadSMSMessage(playerid)
{
    new rows = cache_num_rows();
    if(rows > 0)
    {
        new string[4096], textID, number, text[128], count = 0;
        format(string, sizeof string, "Number\tMessage\n");
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", textID);
            cache_get_value_int(i, "Number", number);
            cache_get_value(i, "Message", text);
            if(strlen(text) > 10)
            {
                format(string, sizeof string, "%s%d\t%s...\n", string, number, text[10]);
            }
            else format(string, sizeof string, "%s%d\t%s\n", string, number, text);
            ListItemTrackID[playerid][i] = textID;
            count++;
        }
        if(count == 0)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "No recent texts.");
            pc_cmd_phone(playerid, "");
            return 1;
        }
        Dialog_Show(playerid, PhoneSMSList, DIALOG_STYLE_TABLIST_HEADERS, "Phone - SMS List", string, "Continue", "Exit");
    }
    else 
    {
        SendClientMessageEx(playerid, -1, "Something went wrong during OnUserReadSMSMessage(%d), operation aborted!", playerid);
        pc_cmd_phone(playerid, "");
    }
    return 1;
}

Dialog:PhoneSMS(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(IsNumeric(inputtext))
        {
            new number = strval(inputtext);
            TempVar[playerid][OnTextNumber] = number;
            Dialog_Show(playerid, SendSMSMessage, DIALOG_STYLE_INPUT, "Phone - SMS", "Type in your message\nMax of 128 characters.", "Send", "Cancel");
            //SMSNumber(playerid, number, inputtext);
        }
        else Dialog_Show(playerid, PhoneSMS, DIALOG_STYLE_INPUT, "Phone - SMS", "Type in a number", "Continue", "Exit");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

Dialog:SendSMSMessage(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!isnull(inputtext))
        {
            SMSNumber(playerid, TempVar[playerid][OnTextNumber], inputtext);
        }
        else Dialog_Show(playerid, SendSMSMessage, DIALOG_STYLE_INPUT, "Phone - SMS", "Type in your message\nMax of 128 characters.", "Send", "Cancel");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

Dialog:PhoneDial(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(IsNumeric(inputtext))
        {
            new number = strval(inputtext);
            DialNumber(playerid, number);
        }
        else Dialog_Show(playerid, PhoneDial, DIALOG_STYLE_INPUT, "Phone - Dial Number", "Type in a number\n[Emergency]: 911\n[Taxi]: 544 - [Mechanic]: 555\n[Police Non Emergency]: 119 - [Fire Dept Non Emergency]: 219", "Continue", "Exit");
    }
    else pc_cmd_phone(playerid, "");
    return 1;
}

function TogglePlayerPhone(playerid, bool:enable)
{
    if(enable == true)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(VehicleHasDoors(vehicleid))
            {
                ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 0, 0, 0, 0, 1);
            }
        }
        else
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            SetPlayerAttachedObject(playerid, SLOT_PHONE, 330, 6);
        }
    }
    else
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(VehicleHasDoors(vehicleid))
            {
                ApplyAnimationEx(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 0, 0, 0, 0, 1);
            }
        }
        else
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
            RemovePlayerAttachedObject(playerid, SLOT_PHONE);
        }
    }
}

stock DialNumber(playerid, number)
{
    if(!GetInventory(playerid, INV_PHONE))
        return SendErrorMessage(playerid, "You do not own a phone.");

    if(TempVar[playerid][Mobile] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You are already in a call.");

    TempVar[playerid][UsingPayphone] = false;
    if(GetSpecialNumber(playerid, number) == 0)
    {
        TempVar[playerid][CallLandline] = 0;

        if(number == GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)))
            return SendErrorMessage(playerid, "You cannot call yourself.");

        if(PlayerInfo[playerid][pPhoneType] < 1)
            return SendErrorMessage(playerid, "You do not have enough credits. Please purchase some from a 24/7.");

        foreach(new i: Player)
        {
            if(GetInventoryAmount(i, GetInventorySlot(i, INV_PHONE)) == number && number != 0)
            {
                if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
                    return SendErrorMessage(playerid, "You cannot do this to on duty administrators.");

                if(Player[i][Ajailed] == 1)
                    return SendErrorMessage(playerid, "This player is current admin jailed.");
                
                if(TempVar[i][Spectating] != INVALID_PLAYER_ID)
                    return SendClientMessage(playerid, COLOR_YELLOW, "*** Phone is offline.");

                if(TempVar[i][Mobile] != INVALID_PLAYER_ID) 
                    return SendClientMessage(playerid, COLOR_YELLOW, "*** You just recieve a busy tone...");

                if(TempVar[i][Mobile] == INVALID_PLAYER_ID)
                {
                    TempVar[playerid][OnCall] = true;
                    TempVar[playerid][CallAnswer] = false;
                    TempVar[playerid][Mobile] = i;
                    TempVar[i][Mobile] = playerid;
                    SendClientMessageEx(playerid, COLOR_YELLOW, "*** You are ringing %d... Please wait for an answer.", GetInventoryAmount(i, GetInventorySlot(i, INV_PHONE)));
                    SendClientMessageEx(i, COLOR_YELLOW, "*** Phone call from %d. Use /(p)ickup to answer.", GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)));
                    SendMe(i, "phone begins to ring.");
                    HandlePhoneRing(i);

                    TogglePlayerPhone(playerid, true);
                }
                return 1;
            }
        }
        SendClientMessage(playerid, COLOR_YELLOW, "*** You just recieve a busy tone...");
    }
    return 1;
}

function SMSNumber(playerid, number, message[])
{
    if(!GetInventory(playerid, INV_PHONE))
        return SendErrorMessage(playerid, "You do now own a phone."), 0;

    if(number == GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)))
        return SendErrorMessage(playerid, "You cannot SMS yourself."), 0;

    if(TempVar[playerid][Mobile] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You are already in a call."), 0;

    if(PlayerInfo[playerid][pPhoneType] == 0)
        return SendErrorMessage(playerid, "You do not have enough credits. Please purchase some from a 24/7."), 0;

    foreach(new i: Player)
    {
        if(GetInventoryAmount(i, GetInventorySlot(i, INV_PHONE)) == number)
        {
            new query[256];
            mysql_format(g_SQL, query, sizeof query, "INSERT INTO `sms` (`Message`, `Number`, `ReciverID`, `Timestamp`) VALUES ('%e', %d, %d, %d)", 
                message, GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE)), PlayerInfo[playerid][pCharacterID], gettime());
            mysql_tquery(g_SQL, query, "OnSendSMS", "dd", playerid, i);
            return 1;
        }
    }
    return 0;
}

function OnSendSMS(playerid, recieverid)
{
    PrintFooter(recieverid, "~g~Received SMS~n~~w~See /phone", 1);
    PrintFooter(playerid, "~g~Sent SMS", 1);
    return 1;
}

new Float:WeaponDeliverPlace[][3] =
{
    {395.9581,2679.8186,59.0537},
    {128.7828,2437.3455,16.7206},
    {545.6396,2363.3645,31.0988},
    {548.8168,2274.4675,34.7270},
    {715.4873,1595.6788,4.0578},
    {613.8559,1554.0808,5.0250},
    {540.1252,1557.7291,1.0000},
    {-456.2956,613.9200,16.7397}
};

new WeaponDeliveryObject, Text3D:WeaponDeliveryLabel, bool:IsUsed = false;

Dialog:Weapon_Delivery(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new fac = PlayerInfo[playerid][pFaction];
        if(fac == 0)
            return SendErrorMessage(playerid, "You cannot use this!");

        if(FactionInfo[fac][FactionDrugRights] == 0)
            return SendErrorMessage(playerid, "You cannot use this!");

        if(IsValidDynamicObject(WeaponDeliveryObject) || IsUsed == true)
            return SendErrorMessage(playerid, "This service is not available right now (There is already a weapon box spawned).", FactionInfo[fac][WeaponDelivery]);

        FactionInfo[fac][WeaponDelivery] = 24*60;
        SaveFaction(fac);
        SendClientMessage(playerid, COLOR_YELLOW, "You will be notified in 10 minutes of where to find your weapons.");
        SetTimerEx("SpawnWep", 60000*10, false, "d", playerid);
        IsUsed = true;
    }
    return 1;
}

function SpawnWep(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new fac = PlayerInfo[playerid][pFaction];
        if(fac == 0)
        {
            ResetWeaponBox();
            return 1;
        }

        if(FactionInfo[fac][FactionDrugRights] == 0)
        {
            ResetWeaponBox();
            return 1;
        }

        new rand = random(8);
        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_WEP_BOX;
        SendClientMessage(playerid, COLOR_YELLOW, "Your weapons can be found on your GPS.");
        DisablePlayerCheckpoint(playerid);

        ResetWeaponBox();

        WeaponDeliveryObject = CreateDynamicObject(1271, WeaponDeliverPlace[rand][0], WeaponDeliverPlace[rand][1], WeaponDeliverPlace[rand][2]-1, 0.0, 0.0, 0.0, .worldid = 0, .interiorid = 0);
        SetPlayerCheckpoint(playerid, WeaponDeliverPlace[rand][0], WeaponDeliverPlace[rand][1], WeaponDeliverPlace[rand][2], 20.0);
        WeaponDeliveryLabel = CreateDynamic3DTextLabel("Weapon Delivery\n((/openbox))", COLOR_YELLOW, WeaponDeliverPlace[rand][0], WeaponDeliverPlace[rand][1], WeaponDeliverPlace[rand][2], 10.0, .worldid = 0, .interiorid = 0);
    }
    else ResetWeaponBox();
    return 1;
}

stock ResetWeaponBox()
{
    if(IsValidDynamicObject(WeaponDeliveryObject))
    {
        DestroyDynamicObject(WeaponDeliveryObject);
    }
    if(IsValidDynamic3DTextLabel(WeaponDeliveryLabel))
    {
        DestroyDynamic3DTextLabel(WeaponDeliveryLabel);
    }
    IsUsed = false;
}

CMD:openbox(playerid, params[])
{
    if(IsValidDynamicObject(WeaponDeliveryObject))
    {
        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(WeaponDeliveryObject, x, y, z);
        if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
        {
            if(IsWeaponRestricted(playerid))
                return SendErrorMessage(playerid,"You are currently restricted from using weapons.");
            
            new randPrimary = random(5), randAmmo = 0;
            switch(randPrimary)
            {
                case 0: 
                {
                    randAmmo = random(400)+100;
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a shotgun with %d ammo.", randAmmo);
                    AddInventory(playerid, INV_GUN, 100, 25, 0);
                }
                case 1: 
                {
                    randAmmo = random(400)+400;
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a AK-47 with %d ammo.", randAmmo);
                    AddInventory(playerid, INV_GUN, 400, 30, 0);
                }
                case 2:
                { 
                    randAmmo = random(400)+400;
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a M4 with %d ammo.", randAmmo);
                    AddInventory(playerid, INV_GUN, 400, 31, 0);
                }
                case 3: 
                {
                    randAmmo = random(100)+100;
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a Country Rifle with %d ammo.", randAmmo);
                    AddInventory(playerid, INV_GUN, 100, 33, 0);
                }
                case 4: 
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a Sniper Rifle with 50 ammo.");
                    AddInventory(playerid, INV_GUN, 50, 34, 0);
                }
            }
            /*switch(randSecondary)
            {   
                case 0: 
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a 9mm with 100 ammo.");
                    AddInventory(playerid, INV_GUN, 100, 22, 0);
                }
                case 1: 
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a Desert Eagle with 100 ammo.");
                    AddInventory(playerid, INV_GUN, 100, 24, 0);
                }
                case 2:
                { 
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a UZI with 400 ammo.");
                    AddInventory(playerid, INV_GUN, 400, 28, 0);
                }
                case 3: 
                {
                    SendClientMessageEx(playerid, COLOR_GREEN, "You have found a TEC-9 with 400 ammo.");
                    AddInventory(playerid, INV_GUN, 400, 32, 0);
                }
            }*/
            SendClientMessage(playerid, COLOR_LIGHTRED, "Check your inventory for these weapons using /inventory (/inv).");
            ResetWeaponBox();
        }
    }
    return 1;
}

CMD:sms(playerid, params[])
{
    new number, text[128];
    if(sscanf(params, "ds[128]", number, text))
    {
        SendUsageMessage(playerid, "/sms [Number] [Text]");
        ShowSMSList(playerid);
        return 1;
    }

    new fac = PlayerInfo[playerid][pFaction];
    if(fac >= 1 && FactionInfo[fac][FactionDrugRights] == 1)
    {
        if(IsValidDynamicObject(WeaponDeliveryObject) || IsUsed == true)
            return SendErrorMessage(playerid, "This service is not available right now (There is already a weapon box spawned).", FactionInfo[fac][WeaponDelivery]);

        if(FactionInfo[fac][WeaponDelivery] >= 1)
            return SendErrorMessage(playerid, "You need to wait for another %d minutes before using this.", FactionInfo[fac][WeaponDelivery]);
        
        if(number == 763375)
        {
            Dialog_Show(playerid, Weapon_Delivery, DIALOG_STYLE_MSGBOX, "Confirm Delivery", "Are you sure you wish to get a delivery? Your faction will not able to do this for 72 hours.", "Confirm", "Exit");
            return 1;
        }
    }

    SMSNumber(playerid, number, text);
    return 1;
}

stock ShowSMSList(playerid)
{
    new fac = PlayerInfo[playerid][pFaction];
    if(fac >= 1 && FactionInfo[fac][FactionDrugRights] == 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "[Weapons Delivery]: 763375");
    }
    return 1;
}

stock ShowCallList(playerid)
{
    SendClientMessage(playerid, COLOR_GRAD5, "[Emergency]: 911");
    SendClientMessage(playerid, COLOR_GRAD4, "[Mechanic]: 555, [Taxi]: 544");
    SendClientMessage(playerid, COLOR_GRAD3, "[BCSD Non Emergency]: 119");
    SendClientMessage(playerid, COLOR_GRAD2, "[BCFD Non Emergency]: 219");
    SendClientMessage(playerid, COLOR_GRAD1, "[Government Hotline]: 319");
    return 1;
}

CMD:payphone(playerid, params[])
{
    new number;
    if(sscanf(params, "d", number))
    {
        SendUsageMessage(playerid, "/call [Number]");
        ShowCallList(playerid);
        return 1;
    }
    if(IsPlayerNearPayphone(playerid) != -1)
    {
        SendServerMessage(playerid, "Attempting payphone call...");
        PayphoneCall(playerid, number);
    }
    else SendErrorMessage(playerid, "You are not near a payphone.");
    return 1;
}

CMD:call(playerid, params[])
{
    new number;
    if(sscanf(params, "d", number))
    {
        SendUsageMessage(playerid, "/call [Number]");
        ShowCallList(playerid);
        return 1;
    }
    DialNumber(playerid, number);    
    return 1;
}

CMD:pickup(playerid, params[])
{
    if(TempVar[playerid][Mobile] != INVALID_PLAYER_ID)
    {
        if(TempVar[playerid][OnCall] == false)
        {
            TempVar[playerid][OnCall] = true;
            TempVar[playerid][CallAnswer] = true;
            TempVar[TempVar[playerid][Mobile]][OnCall] = true;
            TempVar[TempVar[playerid][Mobile]][CallAnswer] = true;
            TempVar[TempVar[playerid][Mobile]][Mobile] = playerid;
            PlayerPlaySound(playerid, 20601, 0.0, 0.0, 0.0);
            TogglePlayerPhone(playerid, true);
            SendClientMessage(TempVar[playerid][Mobile], COLOR_LIGHTRED, "> {FFFFFF}They picked up. You can talk now by using the SA-MP chat box.");
        }
    }
    return 1;
}
alias:pickup("p");

CMD:hangup(playerid, params[])
{
    if(TempVar[playerid][OnCall] == true)
    {
        if(TempVar[playerid][UsingPayphone] == true)
        {
            TakeMoney(playerid, 1);
        }
        else 
        {
            PlayerInfo[playerid][pPhoneType]--;
        }
        foreach(new i: Player)
        {
            if(TempVar[i][Mobile] == playerid)
            {
                SendClientMessage(i, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
                HangupCall(i);
                break; // You can only be on call with one person at a time.
            }
        }
        HangupCall(playerid);
        PlayerPlaySound(playerid, 20601, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}You hung up.");
    }
    return 1;
}
alias:hangup("h");

function HandlePhoneRing(playerid)
{
    if(TempVar[playerid][OnCall] == true && TempVar[playerid][CallAnswer] == false)
    {
        PlayerPlaySound(playerid, 16001, 0.0, 0.0, 0.0);
        PlayNearbySound(playerid, 20600);
	    SetTimerEx("HandlePhoneRing", 4000, false, "i", playerid);
    }
    return 1;
}

stock HangupCall(playerid)
{
    TempVar[playerid][Mobile] = INVALID_PLAYER_ID;
    TempVar[playerid][OnCall] = false;
    TempVar[playerid][CallAnswer] = false;
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
    TogglePlayerPhone(playerid, false);
}

stock PlayNearbySound(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

    PlayerPlaySound(playerid, sound, x, y, z);
	return 1;
}