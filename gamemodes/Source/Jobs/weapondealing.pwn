//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

enum bMarket
{
    MarketID,
    Float:MarketPosX,
    Float:MarketPosY,
    Float:MarketPosZ,
    MarketInt,
    MarketVW,
    MarketFactionID,
    MarketPrice,
};
new BlackMarket[MAX_BLACK_MARKETS][bMarket];

CMD:weaponhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_WHITE, "Weapon Help: Type a command for more information.");
    SendClientMessage(playerid, COLOR_GRAD3, "Commands: /packageweapon [Weapon] [Ammo]");
    if(PlayerInfo[playerid][pJob] == JOB_WEAPONSUPPLIER)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "Commands: /buycomponents [amount], /givecomponents [PlayerID/PartOfName] [Amount]");
        SendClientMessage(playerid, COLOR_GRAD4, "Commands: /buypowder [amount], /givepowder [PlayerID/PartOfName] [Amount]");
    }
    return 1;
}

CMD:buycomponents(playerid, params[])
{
    if(sscanf(params, "d", amount))
        return SendUsageMessage(playerid, "/buycomponents [Amount]");

    if(amount < 1)
        return SendErrorMessage(playerid, "You cannot buy less than 1 component.");

    if(amount > 12)
        return SendErrorMessage(playerid, "You cannot buy more than 12 components.");

    for(new i; i < sizeof(BlackMarket); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10.0, BlackMarket[i][MarketPosX], BlackMarket[i][MarketPosY], BlackMarket[i][MarketPosZ]))
        {
            new finalPrice = amount*BlackMarket[i][MarketPrice];
            if(PlayerInfo[playerid][pMoney] >= finalPrice)
            {
                TakeMoney(playerid, finalPrice);
            }
            else SendErrorMessage(playerid, "You do not have enough, you need $%s.", FormatNumber(finalPrice));
            return 1;
        }
    }
    SendErrorMessage(playerid, "You are not in range of a black market.");
    return 1;
}