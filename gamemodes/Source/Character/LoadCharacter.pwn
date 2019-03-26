//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

// NOTICE: This function has been depreciated, we should directly save the player data after we use it.
function SaveCharacter(playerid)
{
    new string[2048];

    if(PlayerInfo[playerid][pCharacterID] > 0)
    {
        new charID = PlayerInfo[playerid][pCharacterID];
        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `OwnerID` = %d,`Name` = '%e',`Skin` = %d,`Level` = %d,`Expierience` = %d,`Hours` = %d WHERE `CharacterID` = %d LIMIT 1", 
        PlayerInfo[playerid][pOwnerID],
        PlayerInfo[playerid][pName],
        PlayerInfo[playerid][pSkin],
        PlayerInfo[playerid][pLevel],
        PlayerInfo[playerid][pExpierience],
        PlayerInfo[playerid][pHours],
        charID);
        mysql_tquery(g_SQL, string);

        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Crashed` = %d, `LastPosX` = %f, `LastPosY` = %f, `LastPosZ` = %f, `LastPosA` = %f, `LastInterior` = %d, `LastVW` = %d, `Money` = %d, `Bank` = %d, `PayCheque` = %d WHERE `CharacterID` = %d LIMIT 1", 
        PlayerInfo[playerid][pCrashed],
        PlayerInfo[playerid][pLastPos][0],
        PlayerInfo[playerid][pLastPos][1],
        PlayerInfo[playerid][pLastPos][2],
        PlayerInfo[playerid][pLastPos][3],
        PlayerInfo[playerid][pLastInterior],
        PlayerInfo[playerid][pLastVW],
        PlayerInfo[playerid][pMoney],
        PlayerInfo[playerid][pBank],
        PlayerInfo[playerid][pPayCheque],
        charID
        );
        mysql_tquery(g_SQL, string);

        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `PhoneNo` = %d,\
        `PhoneType` = %d,\
        `Faction` = %d,\
        `FactionRank` = %d,\
        `WeaponSpawned1` = %d,\
        `WeaponSpawned2` = %d,\
        `WeaponSpawned3` = %d,\
        `WeaponSpawned4` = %d,\
        `Weapon1` = %d,\
        `Weapon2` = %d,\
        `Weapon3` = %d,\
        `Weapon4` = %d,\
        `Ammo1` = %d,\
        `Ammo2` = %d,\
        `Ammo3` = %d,\
        `Ammo4` = %d,\
        `Handcuffed` = %d,\
        `Radio` = %d,\
        `RadioChan` = %d,\
        `RadioSlot` = %d WHERE `CharacterID` = %d LIMIT 1",
        PlayerInfo[playerid][pPhoneNo],
        PlayerInfo[playerid][pPhoneType],
        PlayerInfo[playerid][pFaction],
        PlayerInfo[playerid][pFactionRank],
        PlayerInfo[playerid][pWeaponSpawned][0],
        PlayerInfo[playerid][pWeaponSpawned][1],
        PlayerInfo[playerid][pWeaponSpawned][2],
        PlayerInfo[playerid][pWeaponSpawned][3],
        PlayerInfo[playerid][pWeapon][0],
        PlayerInfo[playerid][pWeapon][1],
        PlayerInfo[playerid][pWeapon][2],
        PlayerInfo[playerid][pWeapon][3],
        PlayerInfo[playerid][pAmmo][0],
        PlayerInfo[playerid][pAmmo][1],
        PlayerInfo[playerid][pAmmo][2],
        PlayerInfo[playerid][pAmmo][3],
        PlayerInfo[playerid][pHandcuffed],
        PlayerInfo[playerid][pRadio],
        PlayerInfo[playerid][pRadioChan],
        PlayerInfo[playerid][pRadioSlot],
        charID
        );
        mysql_tquery(g_SQL, string);

        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Injured` = %d,\
        `WeaponLicense` = %d,\
        `DrivingLicense` = %d,\
        `FlyingLicense` = %d,\
        `PrisonTimes` = %d,\
        `JailTimes` = %d,\
        `Job` = %d,\
        `SideJob` = %d,\
        `WalkStyle` = %d,\
        `ChatStyle` = %d,\
        `Jailed` = %d,\
        `JailID` = %d,\
        `JailTime` = %d,\
        `Spawn` = %d,\
        `Gender` = %d,\
        `Mask` = %d,\
        `MaskID` = %d,\
        `LastShot` = '%e',\
        `LastShotTime` = %d,\
        `DeathMode` = %d,\
        `Health` = %f,\
        `Armour` = %f,\
        `OwnedVehicle1` = %d,\
        `OwnedVehicle2` = %d,\
        `OwnedVehicle3` = %d,\
        `OwnedVehicle4` = %d,\
        `OwnedVehicle5` = %d,\
        `SpawnedVehicle` = %d WHERE `CharacterID` = %d LIMIT 1",
        PlayerInfo[playerid][pInjured],
        PlayerInfo[playerid][pWeaponLicense],
        PlayerInfo[playerid][pDrivingLicense],
        PlayerInfo[playerid][pFlyingLicense],
        PlayerInfo[playerid][pPrisonTimes],
        PlayerInfo[playerid][pJailTimes],
        PlayerInfo[playerid][pJob],
        PlayerInfo[playerid][pSideJob],
        PlayerInfo[playerid][pWalkStyle],
        PlayerInfo[playerid][pChatStyle],
        PlayerInfo[playerid][pJailed],
        PlayerInfo[playerid][pJailID],
        PlayerInfo[playerid][pJailTime],
        PlayerInfo[playerid][pSpawn],
        PlayerInfo[playerid][pGender],
        PlayerInfo[playerid][pMask],
        PlayerInfo[playerid][pMaskID],
        PlayerInfo[playerid][pLastShot],
        PlayerInfo[playerid][pLastShotTime],
        PlayerInfo[playerid][pDeathMode],
        PlayerInfo[playerid][pHealth],
        PlayerInfo[playerid][pArmour],
        PlayerInfo[playerid][pOwnedVehicle][0],
        PlayerInfo[playerid][pOwnedVehicle][1],
        PlayerInfo[playerid][pOwnedVehicle][2],
        PlayerInfo[playerid][pOwnedVehicle][3],
        PlayerInfo[playerid][pOwnedVehicle][4],
        PlayerInfo[playerid][pSpawnedVehicle],
        charID
        );
        mysql_tquery(g_SQL, string);

        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `DutySkin` = %d,\
        `BeforeSkin` = %d,\
        `FactionDuty` = %d,\
        `Renting` = %d,\
        `ConnectedTime` = %d,\
        `HouseSpawnID` = %d,\
        `PrimaryWep` = %d,\
        `PrimaryAmmo` = %d,\
        `PrimarySerial` = %d,\
        `SecondaryWep` = %d,\
        `SecondaryAmmo` = %d,\
        `SecondarySerial` = %d,\
        `MeleeWep` = %d,\
        `OtherWep` = %d WHERE `CharacterID` = %d LIMIT 1",
        PlayerInfo[playerid][pDutySkin],
        PlayerInfo[playerid][pBeforeSkin],
        PlayerInfo[playerid][pFactionDuty],
        PlayerInfo[playerid][pRenting],
        PlayerInfo[playerid][pConnectedTime],
        PlayerInfo[playerid][pHouseSpawnID],
        PlayerInfo[playerid][pPrimaryWeapon],
        PlayerInfo[playerid][pPrimaryAmmo],
        PlayerInfo[playerid][pPrimarySerial],
        PlayerInfo[playerid][pSecondaryWeapon],
        PlayerInfo[playerid][pSecondaryAmmo],
        PlayerInfo[playerid][pSecondarySerial],
        PlayerInfo[playerid][pMeleeWeapon],
        PlayerInfo[playerid][pOtherWeapon],
        charID
        );
        mysql_tquery(g_SQL, string);

        mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Fish` = %d, \
        `FishBait` = %d, \
        `WeaponX` = %f, \
        `WeaponY` = %f, \
        `WeaponZ` = %f, \
        `WeaponRX` = %f, \
        `WeaponRY` = %f, \
        `WeaponRZ` = %f, \
        `WeaponSX` = %f, \
        `WeaponSY` = %f, \
        `WeaponSZ` = %f, \
        `WeaponBone` = %d, \
        `Savings` = %d, \
        `WireCutter` = %d, \
        `Wires` = %d, \
        `BadgeNo` = %d, \
        `WeedSeeds` = %d, \
        `PoppySeeds` = %d, \
        `Weed` = %d, \
        `Heroin` = %d, \
        `Opium` = %d, \
        `HoldingInv` = %d, \
        `HoldingInvAmount` = %d, \
        `Origin` = '%e', \
        `Lotto` = %d, \
        `Accent` = '%e' \
        WHERE `CharacterID` = %d LIMIT 1",
        PlayerInfo[playerid][pFish],
        PlayerInfo[playerid][pFishBait],
        PlayerInfo[playerid][pWeaponX],
        PlayerInfo[playerid][pWeaponY],
        PlayerInfo[playerid][pWeaponZ],
        PlayerInfo[playerid][pWeaponRX],
        PlayerInfo[playerid][pWeaponRY],
        PlayerInfo[playerid][pWeaponRZ],
        PlayerInfo[playerid][pWeaponSX],
        PlayerInfo[playerid][pWeaponSY],
        PlayerInfo[playerid][pWeaponSZ],
        PlayerInfo[playerid][pWeaponBone],
        PlayerInfo[playerid][pSavings],
        PlayerInfo[playerid][pWireCutter],
        PlayerInfo[playerid][pWires],
        PlayerInfo[playerid][pBadgeNo],
        PlayerInfo[playerid][pWeedSeeds],
        PlayerInfo[playerid][pPoppySeeds],
        PlayerInfo[playerid][pWeed],
        PlayerInfo[playerid][pHeroin],
        PlayerInfo[playerid][pOpium],
        PlayerInfo[playerid][pHoldingInv],
        PlayerInfo[playerid][pHoldingInvAmount],
        PlayerInfo[playerid][pOrigin],
        PlayerInfo[playerid][pLotto],
        PlayerInfo[playerid][pAccent],
        PlayerInfo[playerid][pApperance],
        charID
        );
        mysql_tquery(g_SQL, string);

        UpdatePlayerData(playerid);
    }
    return 1;
}

stock SavePlayerClothing(playerid)
{
    if(PlayerInfo[playerid][pCharacterID] > 0)
    {
        new string[512];
        for(new i; i < MAX_ACCESSORIES; i++)
        {
            mysql_format(g_SQL, string, sizeof(string), "UPDATE `accessories` SET `CharacterID` = %d, \
            `Bone` = %d, \
            `Model` = %d, \
            `PosX` = %f, \
            `PosY` = %f, \
            `PosZ` = %f, \
            `PosRX` = %f, \
            `PosRY` = %f, \
            `PosRZ` = %f, \
            `PosSX` = %f, \
            `PosSY` = %f, \
            `PosSZ` = %f \
            WHERE `ID` = %d LIMIT 1",
            PlayerInfo[playerid][pCharacterID],
            AccInfo[playerid][i][aBone],
            AccInfo[playerid][i][aModel],
            AccInfo[playerid][i][aX],
            AccInfo[playerid][i][aY],
            AccInfo[playerid][i][aZ],
            AccInfo[playerid][i][aRX],
            AccInfo[playerid][i][aRY],
            AccInfo[playerid][i][aRZ],
            AccInfo[playerid][i][aSX],
            AccInfo[playerid][i][aSY],
            AccInfo[playerid][i][aSZ],
            AccInfo[playerid][i][aID]
            );
            mysql_tquery(g_SQL, string);
        }
        return 1;
    }
    return 0;
}