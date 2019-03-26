//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

CMD:bankhelp(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Bank Help:{FFFFFF} Type a command for more information.");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Available Commands: /withdraw, /deposit, /savings");
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

CMD:signcheque(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 1346.8292,1571.4750,-13.5820))
    {
        if(isnull(params))
        {
            SendUsageMessage(playerid, "/signcheque (/signcheck) [Code] - Use /signcode to find out the code to use.");
            return 1;
        }

        if(!IsNumeric(params))
            return SendErrorMessage(playerid, "The code must be in a numeric format.");

        new code = strval(params);

        if(PlayerInfo[playerid][pSignChequeCode] >= 1)
        {
            if(PlayerInfo[playerid][pSignChequeCode] != code)
                return SendErrorMessage(playerid, "You did not enter the correct code. Use /signcode to find out the code.");

            new taxValue = (PlayerInfo[playerid][pSignChequeAmount] / 100) * 20, afterTax, bankBefore = PlayerInfo[playerid][pBank];

            new nextLevel = ((PlayerInfo[playerid][pLevel]) * 4 + 2);

            PlayerInfo[playerid][pExpierience]++;
            
            new taxAdded = 0, string[256];
            if(PlayerInfo[playerid][pExpierience] >= nextLevel)
            {
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                PlayerInfo[playerid][pLevel]++;
                format(string, sizeof string, "~r~Level Up ~b~You are now level ~w~%d", PlayerInfo[playerid][pLevel]);
                PrintFooter(playerid, string, 3);
                PlayerInfo[playerid][pExpierience] = 0;
            }

            new savingsInterest, Float:newSavings;
            if(PlayerInfo[playerid][pSavings] > 0 && PlayerInfo[playerid][pSavings] < 50000)
            {
                newSavings = (PlayerInfo[playerid][pSavings] / 100) * 1.5;
                savingsInterest = floatround(newSavings);
                PlayerInfo[playerid][pSavings] += savingsInterest;
                if(PlayerInfo[playerid][pSavings] > 50000)
                {
                    PlayerInfo[playerid][pSavings] = 50000;
                }
            }


            SendClientMessageEx(playerid, COLOR_GREEN, "-----------------------[Payday]-----------------------");

            if(PlayerInfo[playerid][pJob] == 0)
            {
                PlayerInfo[playerid][pSignChequeAmount] += 50+random(50);
                PlayerInfo[playerid][pBank] += PlayerInfo[playerid][pSignChequeAmount];
                SendClientMessageEx(playerid, COLOR_GRAD5, " Government Handout: $%s | Tax Paid: $0 (Exempt)", FormatNumber(PlayerInfo[playerid][pSignChequeAmount]));
            }
            else
            {
                SendClientMessageEx(playerid, COLOR_GRAD5, " Paycheque Before Tax: $%s | Tax Paid: $%s (20 percent)", FormatNumber(PlayerInfo[playerid][pSignChequeAmount]), FormatNumber(taxValue));
                afterTax = (PlayerInfo[playerid][pSignChequeAmount] - taxValue);
                taxAdded += taxValue;
                PlayerInfo[playerid][pBank] += afterTax;
                SendClientMessageEx(playerid, COLOR_GRAD4, " Paycheque After Tax: $%s", FormatNumber(afterTax));
            }
            if(PlayerInfo[playerid][pSavings] > 0)
            {
                if(PlayerInfo[playerid][pSavings] < 50000)
                {
                    SendClientMessageEx(playerid, COLOR_GRAD3, " New Savings: $%s | Savings Interest: $%s (1.5 percent)", FormatNumber(PlayerInfo[playerid][pSavings]), FormatNumber(savingsInterest));
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_GRAD3, " New Savings: $%s | Savings Interest: $0 (Capped to $50k)", FormatNumber(PlayerInfo[playerid][pSavings]));
                }
            }
            PlayerInfo[playerid][pSignChequeAmount] = 0;
            PlayerInfo[playerid][pPayCheque] = 0;
            SendClientMessageEx(playerid, COLOR_GRAD2, " New Balance: $%s | Old Balance: $%s", FormatNumber(PlayerInfo[playerid][pBank]), FormatNumber(bankBefore));
            SendClientMessageEx(playerid, COLOR_GREEN, "-----------------------[Payday]-----------------------");
            new uid[11];
			format(uid, sizeof uid, "%d", PlayerInfo[playerid][pCharacterID]);
			SQL_SetInt("characters", "SignChequeAmount", "CharacterID", uid, 0);
            SQL_SetInt("characters", "SignChequeCode", "CharacterID", uid, 0);
            SQL_SetInt("characters", "PayCheque", "CharacterID", uid, 0);
            SQL_SetInt("characters", "Bank", "CharacterID", uid, PlayerInfo[playerid][pBank]);
            for(new i; i < MAX_FACTIONS; i++)
            {
                if(FactionInfo[i][FactionEconomy] == 1)
                {
                    FactionInfo[i][FactionBank] += taxAdded;
                }
            }
        }
        else SendErrorMessage(playerid, "You do not have a pending pay cheque.");
    }
    else SendErrorMessage(playerid, "You are not at the Fort Carson Town Hall.");
    return 1;
}
alias:signcheque("signcheck");

CMD:signcode(playerid, params[])
{
    if(PlayerInfo[playerid][pSignChequeCode])
    {
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Use /signcheque %d inside Fort Carson Town Hall to sign your pay cheque.", PlayerInfo[playerid][pSignChequeCode]);
    }
    else SendErrorMessage(playerid, "You do not have a pay cheque to sign.");
    return 1;
}

stock PayDay()
{
    new string[128];
    foreach(new playerid: Player)
    {
        if(PlayerInfo[playerid][pConnectedTime] >= 900)
        {
            Player[playerid][PlayingHours]++;
            PlayerInfo[playerid][pHours]++;
            PlayerInfo[playerid][pSignChequeAmount] += PlayerInfo[playerid][pPayCheque];
            PlayerInfo[playerid][pSignChequeCode] = Random(1000, 9999);
            SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Payday! Go to the Fort Carson Town Hall and \"/signcheque %d\".", PlayerInfo[playerid][pSignChequeCode]);
            SendClientMessage(playerid, -1, "If you forget this code, use /signcode to see it.");
            new uid[11];
			format(uid, sizeof uid, "%d", PlayerInfo[playerid][pCharacterID]);
			SQL_SetInt("characters", "SignChequeAmount", "CharacterID", uid, PlayerInfo[playerid][pSignChequeAmount]);
            SQL_SetInt("characters", "SignChequeCode", "CharacterID", uid, PlayerInfo[playerid][pSignChequeCode]);
            format(string, sizeof(string), "~y~Payday~n~~w~Paycheck~n~~g~$%d", PlayerInfo[playerid][pPayCheque]);
		    PrintFooter(playerid, string, 3);
        }
        else SendServerMessage(playerid, "You have not played enough to earn a payday.");
    }
    ActiveReportWarning();
    ResetWeaponBox();
    SetTimer("PayDayPassedTimer", 10000, false);
    return 1;
}

function PayDayPassedTimer()
{
    ServerInfo[PayDayPassed] = false;
}