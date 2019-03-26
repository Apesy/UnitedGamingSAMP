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
    Restaurant System created by Seanny

    Restaurnant Business Types (BizType):
    8. Donut Store
    11. Cluckin' Bell
    12. Pizzastack
    13. Burgershot
*/

#include <YSI\y_hooks>

new bool:HoldingFood[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    HoldingFood[playerid] = false;
    return 1;
}

// Check if the player is inside a restaurant, if yes then return it's business id, if not return -1.
stock IsPlayerInsideRestaurant(playerid)
{
    for(new i; i < MAX_BIZ; i++)
    {
        if(BusinessInfo[i][BizID] > 0)
        {
            if(IsPlayerInRangeOfPoint(playerid, 50.0, BusinessInfo[i][BizInteriorX], BusinessInfo[i][BizInteriorY], BusinessInfo[i][BizInteriorZ])
                && GetPlayerInterior(playerid) == BusinessInfo[i][BizInteriorInt]
                && GetPlayerVirtualWorld(playerid) == i)
            {
                if(BusinessInfo[i][BizType] == 8 || BusinessInfo[i][BizType] == 11 || BusinessInfo[i][BizType] == 12 || BusinessInfo[i][BizType] == 13)
                {
                    return i;
                }
            }
        }
    }
    return -1;
}

CMD:buyfood(playerid, params[])
{
    new bizid = IsPlayerInsideRestaurant(playerid);
    if(bizid == -1)
        return SendErrorMessage(playerid, "You must be inside a restaurant to use this.");
    
    switch(BusinessInfo[bizid][BizType])
    {
        case 8: // Donut Restaurant
        {
            Dialog_Show(playerid, DonutMenu, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Name\tPrice\n\
            Ring Donut\t$1\n\
            Sprunk\t$1", "Buy", "Exit");
        }
        case 11: // Cluckin' Bell Restaurant
        {
            Dialog_Show(playerid, ClukinBellMenu, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Name\tPrice\n\
            Little Meal\t$2\n\
            Big Meal\t$5\n\
            Huge Meal\t$10\n\
            Salad Meal\t$10\n\
            Sprunk\t$1", "Buy", "Exit");
        }
        case 12: // Pizzastack Restaurant
        {
            Dialog_Show(playerid, PizzastackMenu, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Name\tPrice\n\
            Buster\t$2\n\
            Double D-Luxe\t$5\n\
            Full Rack\t$10\n\
            Salad Meal\t$10\n\
            Sprunk\t$1", "Buy", "Exit");
        }
        case 13: // Burger Shot Restaurant
        {
            Dialog_Show(playerid, BurgerShotMenu, DIALOG_STYLE_TABLIST_HEADERS, BusinessInfo[bizid][BizName], "Name\tPrice\n\
            Moo Kids Meal\t$2\n\
            Beef Tower\t$5\n\
            Meat Stack\t$10\n\
            Salad Meal\t$5\n\
            Sprunk\t$1", "Buy", "Exit");
        }
    }
    return 1;
}

Dialog:DonutMenu(playerid, response, listitem, inputtext[])
{
    new bizid = IsPlayerInsideRestaurant(playerid);
    if(response && bizid != -1)
    {
        new Float:health;
        GetPlayerHealth(playerid, health);
        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pMoney] < 5)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $5");
                
                TakeMoney(playerid, 5);
                BusinessInfo[bizid][BizSafe] += 5;
                SetPlayerHealthEx(playerid, health+30);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Ring Donut{%06x} for $5.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2221, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 1:
            {
                if(PlayerInfo[playerid][pMoney] < 1)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $1");
                
                TakeMoney(playerid, 1);
                BusinessInfo[bizid][BizSafe] += 1;
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Sprunk{%06x} for $1. Use /inv to use it.", COLOR_LIGHTBLUE >>> 8);
                AddInventory(playerid, INV_SPRUNK, 1);
            }
        }
    }
    return 1;
}

Dialog:ClukinBellMenu(playerid, response, listitem, inputtext[])
{
    new bizid = IsPlayerInsideRestaurant(playerid);
    if(response && bizid != -1)
    {
        new Float:health;
        GetPlayerHealth(playerid, health);
        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pMoney] < 2)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $2");
                
                TakeMoney(playerid, 2);
                BusinessInfo[bizid][BizSafe] += 2;
                SetPlayerHealthEx(playerid, health+10);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Little Meal{%06x} for $2.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2215, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 1:
            {
                if(PlayerInfo[playerid][pMoney] < 5)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $5");
                
                TakeMoney(playerid, 5);
                BusinessInfo[bizid][BizSafe] += 5;
                SetPlayerHealthEx(playerid, health+20);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Big Meal{%06x} for $5.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2216, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 2:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+30);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Big Meal{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2217, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 3:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+35);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Salad Meal{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2353, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 4:
            {
                if(PlayerInfo[playerid][pMoney] < 1)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $1");
                
                TakeMoney(playerid, 1);
                BusinessInfo[bizid][BizSafe] += 1;
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Sprunk{%06x} for $1. Use /inv to use it.", COLOR_LIGHTBLUE >>> 8);
                AddInventory(playerid, INV_SPRUNK, 1);
            }
        }
    }
    return 1;
}

Dialog:PizzastackMenu(playerid, response, listitem, inputtext[])
{
    new bizid = IsPlayerInsideRestaurant(playerid);
    if(response && bizid != -1)
    {
        new Float:health;
        GetPlayerHealth(playerid, health);
        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pMoney] < 2)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $2");
                
                TakeMoney(playerid, 2);
                BusinessInfo[bizid][BizSafe] += 2;
                SetPlayerHealthEx(playerid, health+10);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Buster{%06x} for $2.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 19571, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 1:
            {
                if(PlayerInfo[playerid][pMoney] < 5)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $5");
                
                TakeMoney(playerid, 5);
                BusinessInfo[bizid][BizSafe] += 5;
                SetPlayerHealthEx(playerid, health+20);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Double D-Luxe{%06x} for $5.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 19571, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 2:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+30);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Full Rack{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 19571, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 3:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+35);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Salad Meal{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                SetPlayerAttachedObject(playerid, SLOT_MISC, 2355, 5, 0.050000,0.103999,0.179000,-85.000015,0.000000,19.699998,1.000000,1.000000,1.000000);
                HoldingFood[playerid] = true;
            }
            case 4:
            {
                if(PlayerInfo[playerid][pMoney] < 1)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $1");
                
                TakeMoney(playerid, 1);
                BusinessInfo[bizid][BizSafe] += 1;
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Sprunk{%06x} for $1. Use /inv to use it.", COLOR_LIGHTBLUE >>> 8);
                AddInventory(playerid, INV_SPRUNK, 1);
            }
        }
    }
    return 1;
}

Dialog:BurgerShotMenu(playerid, response, listitem, inputtext[])
{
    new bizid = IsPlayerInsideRestaurant(playerid);
    if(response && bizid != -1)
    {
        new Float:health;
        GetPlayerHealth(playerid, health);
        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pMoney] < 2)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $2");
                
                TakeMoney(playerid, 2);
                BusinessInfo[bizid][BizSafe] += 2;
                SetPlayerHealthEx(playerid, health+10);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Moo Kids Meal{%06x} for $2.", COLOR_LIGHTBLUE >>> 8);
                // TODO: Set burgershot item attached to player.
            }
            case 1:
            {
                if(PlayerInfo[playerid][pMoney] < 5)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $5");
                
                TakeMoney(playerid, 5);
                BusinessInfo[bizid][BizSafe] += 5;
                SetPlayerHealthEx(playerid, health+20);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Beef Tower{%06x} for $5.", COLOR_LIGHTBLUE >>> 8);
                // TODO: Set burgershot item attached to player.
            }
            case 2:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+30);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Meat Stack{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                // TODO: Set burgershot item attached to player.
            }
            case 3:
            {
                if(PlayerInfo[playerid][pMoney] < 10)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $10");
                
                TakeMoney(playerid, 10);
                BusinessInfo[bizid][BizSafe] += 10;
                SetPlayerHealthEx(playerid, health+35);
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Salad Meal{%06x} for $10.", COLOR_LIGHTBLUE >>> 8);
                // TODO: Set burgershot item attached to player.
            }
            case 4:
            {
                if(PlayerInfo[playerid][pMoney] < 1)
                    return SendErrorMessage(playerid, "You do not have enough money. You need $1");
                
                TakeMoney(playerid, 1);
                BusinessInfo[bizid][BizSafe] += 1;
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have bought a {00FF00}Sprunk{%06x} for $1. Use /inv to use it.", COLOR_LIGHTBLUE >>> 8);
                AddInventory(playerid, INV_SPRUNK, 1);
            }
        }
    }
    return 1;
}

CMD:putfood(playerid, params[])
{

    return 1;
}