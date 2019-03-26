-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 01, 2018 at 04:21 PM
-- Server version: 5.7.23-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `sa-mp`
--
CREATE DATABASE IF NOT EXISTS `sa-mp` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sa-mp`;

-- --------------------------------------------------------

--
-- Table structure for table `accessories`
--

CREATE TABLE IF NOT EXISTS `accessories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CharacterID` int(11) NOT NULL,
  `Bone` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosRX` float NOT NULL,
  `PosRY` float NOT NULL,
  `PosRZ` float NOT NULL,
  `PosSX` float NOT NULL,
  `PosSY` float NOT NULL,
  `PosSZ` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `admin_notes`
--

CREATE TABLE IF NOT EXISTS `admin_notes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  `Admin` varchar(32) NOT NULL,
  `Message` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ajail_logs`
--

CREATE TABLE IF NOT EXISTS `ajail_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `JailedDBID` int(11) NOT NULL,
  `JailedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `JailedBy` varchar(32) NOT NULL,
  `Date` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Atm`
--

CREATE TABLE IF NOT EXISTS `Atm` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Money` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `World` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `AddedBy` varchar(25) NOT NULL,
  `AddedDate` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `attack_logs`
--

CREATE TABLE IF NOT EXISTS `attack_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AttackerID` int(11) NOT NULL,
  `AttackerName` varchar(32) NOT NULL,
  `MaskID` int(11) NOT NULL,
  `Damage` float NOT NULL,
  `Date` int(11) NOT NULL,
  `CharacterID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `BanID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `Admin` varchar(128) NOT NULL,
  `UnbanTimestamp` int(20) NOT NULL,
  `Reason` varchar(512) NOT NULL,
  `IPAddress` varchar(128) NOT NULL,
  `BanDate` int(20) NOT NULL,
  `Serial` varchar(41) NOT NULL,
  PRIMARY KEY (`BanID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ban_logs`
--

CREATE TABLE IF NOT EXISTS `ban_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BannedDBID` int(11) NOT NULL,
  `BannedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `BannedBy` varchar(32) NOT NULL,
  `Date` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `BlackMarkets`
--

CREATE TABLE IF NOT EXISTS `BlackMarkets` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FactionID` int(10) UNSIGNED NOT NULL,
  `Stock` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `Interior` int(10) UNSIGNED NOT NULL,
  `World` int(10) UNSIGNED NOT NULL,
  `HasKnife` int(11) NOT NULL,
  `Has9mm` int(11) NOT NULL,
  `HasSDPistol` int(11) NOT NULL,
  `HasDeagle` int(11) NOT NULL,
  `HasShotgun` int(11) NOT NULL,
  `HasSawnoff` int(11) NOT NULL,
  `HasUzi` int(11) NOT NULL,
  `HasMP5` int(11) NOT NULL,
  `HasAK47` int(11) NOT NULL,
  `HasM4` int(11) NOT NULL,
  `HasTec9` int(11) NOT NULL,
  `HasRifle` int(11) NOT NULL,
  `HasSniper` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE IF NOT EXISTS `business` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `MarketPrice` int(11) NOT NULL,
  `ExteriorX` float NOT NULL,
  `ExteriorY` float NOT NULL,
  `ExteriorZ` float NOT NULL,
  `ExteriorA` float NOT NULL,
  `ExteriorInt` int(11) NOT NULL,
  `ExteriorVW` int(11) NOT NULL,
  `InteriorX` float NOT NULL,
  `InteriorY` float NOT NULL,
  `InteriorZ` float NOT NULL,
  `InteriorA` float NOT NULL,
  `InteriorInt` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `EntryFee` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `Safe` int(11) NOT NULL,
  `Products` int(11) NOT NULL,
  `GovClosed` int(11) NOT NULL,
  `Slogan` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE IF NOT EXISTS `characters` (
  `CharacterID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Level` int(11) NOT NULL,
  `Expierience` int(11) NOT NULL,
  `Hours` int(11) NOT NULL,
  `Crashed` int(11) NOT NULL,
  `LastPosX` float NOT NULL,
  `LastPosY` float NOT NULL,
  `LastPosZ` float NOT NULL,
  `LastPosA` float NOT NULL,
  `LastInterior` int(11) NOT NULL,
  `LastVW` int(11) NOT NULL,
  `Money` int(11) NOT NULL,
  `Bank` int(11) NOT NULL,
  `PayCheque` int(11) NOT NULL,
  `PhoneNo` int(11) NOT NULL,
  `PhoneType` int(11) NOT NULL,
  `Faction` int(11) NOT NULL,
  `FactionRank` int(11) NOT NULL,
  `WeaponSpawned1` int(11) NOT NULL,
  `WeaponSpawned2` int(11) NOT NULL,
  `WeaponSpawned3` int(11) NOT NULL,
  `WeaponSpawned4` int(11) NOT NULL,
  `Weapon1` int(11) NOT NULL,
  `Weapon2` int(11) NOT NULL,
  `Weapon3` int(11) NOT NULL,
  `Weapon4` int(11) NOT NULL,
  `Ammo1` int(11) NOT NULL,
  `Ammo2` int(11) NOT NULL,
  `Ammo3` int(11) NOT NULL,
  `Ammo4` int(11) NOT NULL,
  `Handcuffed` int(11) NOT NULL,
  `Radio` int(11) NOT NULL,
  `RadioChan` int(11) NOT NULL,
  `RadioChan2` int(11) NOT NULL,
  `RadioChan3` int(11) NOT NULL,
  `RadioSlot` int(11) NOT NULL,
  `Injured` int(11) NOT NULL,
  `WeaponLicense` int(11) NOT NULL,
  `DrivingLicense` int(11) NOT NULL,
  `FlyingLicense` int(11) NOT NULL,
  `PrisonTimes` int(11) NOT NULL,
  `JailTimes` int(11) NOT NULL,
  `Job` int(11) NOT NULL,
  `SideJob` int(11) NOT NULL,
  `WalkStyle` int(11) NOT NULL,
  `ChatStyle` int(11) NOT NULL,
  `Jailed` int(11) NOT NULL,
  `JailID` int(11) NOT NULL,
  `JailTime` int(11) NOT NULL,
  `Spawn` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Gender` int(11) NOT NULL,
  `Mask` int(11) NOT NULL,
  `MaskID` int(11) NOT NULL,
  `LastShot` varchar(25) NOT NULL,
  `LastShotTime` int(11) NOT NULL,
  `DeathMode` int(11) NOT NULL,
  `Health` float NOT NULL,
  `Armour` float NOT NULL,
  `OwnedVehicle1` int(11) NOT NULL,
  `OwnedVehicle2` int(11) NOT NULL,
  `OwnedVehicle3` int(11) NOT NULL,
  `OwnedVehicle4` int(11) NOT NULL,
  `OwnedVehicle5` int(11) NOT NULL,
  `SpawnedVehicle` int(11) NOT NULL,
  `DutySkin` int(11) NOT NULL,
  `BeforeSkin` int(11) NOT NULL,
  `FactionDuty` int(11) NOT NULL,
  `Renting` int(11) NOT NULL,
  `ConnectedTime` int(11) NOT NULL,
  `HouseSpawnID` int(11) NOT NULL,
  `PrimaryWep` int(11) NOT NULL,
  `PrimaryAmmo` int(11) NOT NULL,
  `SecondaryWep` int(11) NOT NULL,
  `SecondaryAmmo` int(11) NOT NULL,
  `MeleeWep` int(11) NOT NULL,
  `OtherWep` int(11) NOT NULL,
  `Fish` int(11) NOT NULL,
  `FishBait` int(11) NOT NULL,
  `WeaponX` float NOT NULL,
  `WeaponY` float NOT NULL,
  `WeaponZ` float NOT NULL,
  `WeaponRX` float NOT NULL,
  `WeaponRY` float NOT NULL,
  `WeaponRZ` float NOT NULL,
  `WeaponSX` float NOT NULL,
  `WeaponSY` float NOT NULL,
  `WeaponSZ` float NOT NULL,
  `WeaponBone` int(11) NOT NULL,
  `Savings` int(11) NOT NULL,
  `WireCutter` int(11) NOT NULL,
  `Wires` int(11) NOT NULL,
  `BadgeNo` int(11) NOT NULL,
  `WeedSeeds` int(11) NOT NULL,
  `Weed` int(11) NOT NULL,
  `BMXPermission` int(11) NOT NULL,
  `Heroin` int(11) NOT NULL,
  `PoppySeeds` int(11) NOT NULL,
  `Opium` int(11) NOT NULL,
  `HoldingInv` int(11) NOT NULL,
  `HoldingInvAmount` int(11) NOT NULL,
  `Origin` int(11) NOT NULL,
  `Lotto` int(11) NOT NULL,
  `PrimarySerial` int(11) NOT NULL,
  `SecondarySerial` int(11) NOT NULL,
  `Accent` varchar(33) NOT NULL,
  `Apperance` varchar(128) NOT NULL,
  `LastRam` varchar(25) NOT NULL,
  `LastRamTime` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`CharacterID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cmd_log`
--

CREATE TABLE IF NOT EXISTS `cmd_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Command` varchar(32) NOT NULL,
  `Params` varchar(256) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41816 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `complex`
--

CREATE TABLE IF NOT EXISTS `complex` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(33) NOT NULL,
  `Faction` int(11) NOT NULL,
  `OwnerID` int(11) NOT NULL,
  `ExteriorX` float NOT NULL,
  `ExteriorY` float NOT NULL,
  `ExteriorZ` float NOT NULL,
  `ExteriorA` float NOT NULL,
  `ExteriorInt` int(11) NOT NULL,
  `ExteriorVW` int(11) NOT NULL,
  `InteriorX` float NOT NULL,
  `InteriorY` float NOT NULL,
  `InteriorZ` float NOT NULL,
  `InteriorA` float NOT NULL,
  `InteriorInt` int(11) NOT NULL,
  `InteriorVW` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CriminalRecords`
--

CREATE TABLE IF NOT EXISTS `CriminalRecords` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CharacterName` varchar(32) NOT NULL,
  `Charge` varchar(128) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  `Active` int(11) NOT NULL,
  `OfficerID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

CREATE TABLE IF NOT EXISTS `damages` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `WeaponID` int(11) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  `Attacker` int(11) NOT NULL,
  `Victim` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2073 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealership`
--

CREATE TABLE IF NOT EXISTS `dealership` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Type` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `OwnerID` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnA` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Donator_Items`
--

CREATE TABLE IF NOT EXISTS `Donator_Items` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ActivationString` varchar(32) NOT NULL,
  `BuyerID` int(10) UNSIGNED NOT NULL,
  `Type` int(11) NOT NULL,
  `BuyTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ActivationString` (`ActivationString`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Dynamic_Labels`
--

CREATE TABLE IF NOT EXISTS `Dynamic_Labels` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Text` varchar(144) NOT NULL,
  `AddedBy` varchar(25) NOT NULL,
  `AddedDate` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

CREATE TABLE IF NOT EXISTS `entrances` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) NOT NULL,
  `FactionID` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  `BusinessID` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `OutsideInt` int(11) NOT NULL,
  `OutsideVW` int(11) NOT NULL,
  `IntX` float NOT NULL,
  `IntY` float NOT NULL,
  `IntZ` float NOT NULL,
  `IntA` float NOT NULL,
  `InsideInt` int(11) NOT NULL,
  `InsideVW` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `CustomExt` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE IF NOT EXISTS `factions` (
  `FactionID` int(11) NOT NULL AUTO_INCREMENT,
  `FactionName` varchar(90) NOT NULL,
  `FactionAbbrev` varchar(30) NOT NULL,
  `FactionJoinRank` int(11) NOT NULL,
  `FactionAlterRank` int(11) NOT NULL,
  `FactionChatRank` int(11) NOT NULL,
  `FactionTowRank` int(11) NOT NULL,
  `FactionType` int(11) NOT NULL,
  `FactionSpawnX` float NOT NULL,
  `FactionSpawnY` float NOT NULL,
  `FactionSpawnZ` float NOT NULL,
  `FactionSpawnInterior` int(11) NOT NULL,
  `FactionSpawnWorld` int(11) NOT NULL,
  `FactionRank0` varchar(90) NOT NULL,
  `FactionRank1` varchar(90) NOT NULL,
  `FactionRank2` varchar(90) NOT NULL,
  `FactionRank3` varchar(90) NOT NULL,
  `FactionRank4` varchar(90) NOT NULL,
  `FactionRank5` varchar(90) NOT NULL,
  `FactionRank6` varchar(90) NOT NULL,
  `FactionRank7` varchar(90) NOT NULL,
  `FactionRank8` varchar(90) NOT NULL,
  `FactionRank9` varchar(90) NOT NULL,
  `FactionRank10` varchar(90) NOT NULL,
  `FactionRank11` varchar(90) NOT NULL,
  `FactionRank12` varchar(90) NOT NULL,
  `FactionRank13` varchar(90) NOT NULL,
  `FactionRank14` varchar(90) NOT NULL,
  `FactionRank15` varchar(90) NOT NULL,
  `FactionRank16` varchar(90) NOT NULL,
  `FactionRank17` varchar(90) NOT NULL,
  `FactionRank18` varchar(90) NOT NULL,
  `FactionRank19` varchar(90) NOT NULL,
  `FactionRank20` varchar(90) NOT NULL,
  `FactionRankPay1` int(11) NOT NULL,
  `FactionRankPay2` int(11) NOT NULL,
  `FactionRankPay3` int(11) NOT NULL,
  `FactionRankPay4` int(11) NOT NULL,
  `FactionRankPay5` int(11) NOT NULL,
  `FactionRankPay6` int(11) NOT NULL,
  `FactionRankPay7` int(11) NOT NULL,
  `FactionRankPay8` int(11) NOT NULL,
  `FactionRankPay9` int(11) NOT NULL,
  `FactionRankPay10` int(11) NOT NULL,
  `FactionRankPay11` int(11) NOT NULL,
  `FactionRankPay12` int(11) NOT NULL,
  `FactionRankPay13` int(11) NOT NULL,
  `FactionRankPay14` int(11) NOT NULL,
  `FactionRankPay15` int(11) NOT NULL,
  `FactionRankPay16` int(11) NOT NULL,
  `FactionRankPay17` int(11) NOT NULL,
  `FactionRankPay18` int(11) NOT NULL,
  `FactionRankPay19` int(11) NOT NULL,
  `FactionRankPay20` int(11) NOT NULL,
  `RamRaid` int(11) NOT NULL,
  `PoliceCall` int(11) NOT NULL,
  `MedicCall` int(11) NOT NULL,
  `GovernmentCall` int(11) NOT NULL,
  `Badge` int(11) NOT NULL,
  `Carsign` int(11) NOT NULL,
  `Cuff` int(11) NOT NULL,
  `Deploy` int(11) NOT NULL,
  `Backup` int(11) NOT NULL,
  `Departmental` int(11) NOT NULL,
  `Impound` int(11) NOT NULL,
  `Jail` int(11) NOT NULL,
  `Megaphone` int(11) NOT NULL,
  `Suspect` int(11) NOT NULL,
  `License` int(11) NOT NULL,
  `Seize` int(11) NOT NULL,
  `Taser` int(11) NOT NULL,
  `HQ` int(11) NOT NULL,
  `Gov` int(11) NOT NULL,
  `Siren` int(11) NOT NULL,
  `DutyAccess` int(11) NOT NULL,
  `Ticket` int(11) NOT NULL,
  `MDC` int(11) NOT NULL,
  `Medic` int(11) NOT NULL,
  `News` int(11) NOT NULL,
  `FactionSkin0` int(11) NOT NULL,
  `FactionSkin1` int(11) NOT NULL,
  `FactionSkin2` int(11) NOT NULL,
  `FactionSkin3` int(11) NOT NULL,
  `FactionSkin4` int(11) NOT NULL,
  `FactionSkin5` int(11) NOT NULL,
  `FactionSkin6` int(11) NOT NULL,
  `FactionSkin7` int(11) NOT NULL,
  `FactionSkin8` int(11) NOT NULL,
  `FactionSkin9` int(11) NOT NULL,
  `FactionSkin10` int(11) NOT NULL,
  `FactionSkin11` int(11) NOT NULL,
  `FactionSkin12` int(11) NOT NULL,
  `FactionSkin13` int(11) NOT NULL,
  `FactionSkin14` int(11) NOT NULL,
  `FactionSkin15` int(11) NOT NULL,
  `FactionSkin16` int(11) NOT NULL,
  `FactionSkin17` int(11) NOT NULL,
  `FactionSkin18` int(11) NOT NULL,
  `FactionSkin19` int(11) NOT NULL,
  `Tag` int(11) NOT NULL,
  `RamRaidPerm` int(11) NOT NULL,
  `Economy` int(11) NOT NULL,
  `DrugRights` int(11) NOT NULL,
  `FactionWeapon0` int(11) NOT NULL,
  `FactionWeapon1` int(11) NOT NULL,
  `FactionWeapon2` int(11) NOT NULL,
  `FactionWeapon3` int(11) NOT NULL,
  `FactionWeapon4` int(11) NOT NULL,
  `FactionWeapon5` int(11) NOT NULL,
  `FactionWeapon6` int(11) NOT NULL,
  `FactionWeapon7` int(11) NOT NULL,
  `FactionWeapon8` int(11) NOT NULL,
  `FactionWeapon9` int(11) NOT NULL,
  `FactionWeapon10` int(11) NOT NULL,
  `ChatColour` int(11) NOT NULL,
  `FactionDutyX` float NOT NULL,
  `FactionDutyY` float NOT NULL,
  `FactionDutyZ` float NOT NULL,
  `FactionDutyInterior` int(11) NOT NULL,
  `FactionDutyWorld` int(11) NOT NULL,
  `WeaponDelivery` int(11) NOT NULL,
  PRIMARY KEY (`FactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FactionSkin`
--

CREATE TABLE IF NOT EXISTS `FactionSkin` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SkinID` int(10) UNSIGNED NOT NULL,
  `FactionID` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `FactionWeapon`
--

CREATE TABLE IF NOT EXISTS `FactionWeapon` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `WeaponID` int(10) UNSIGNED NOT NULL,
  `Ammo` int(10) UNSIGNED NOT NULL,
  `FactionID` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE IF NOT EXISTS `fines` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `OfficerID` int(11) NOT NULL,
  `FactionID` int(11) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Active` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Furniture`
--

CREATE TABLE IF NOT EXISTS `Furniture` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `HouseID` int(10) UNSIGNED NOT NULL,
  `ModelID` int(10) UNSIGNED NOT NULL,
  `ObjectName` varchar(128) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `World` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `AddedBy` varchar(25) NOT NULL,
  `AddedDate` varchar(32) NOT NULL,
  `TXD1` varchar(32) NOT NULL,
  `Texture1` varchar(32) NOT NULL,
  `Colour1` int(11) NOT NULL,
  `ModelID1` int(11) NOT NULL,
  `TXD2` varchar(32) NOT NULL,
  `Texture2` varchar(32) NOT NULL,
  `Colour2` int(11) NOT NULL,
  `ModelID2` int(11) NOT NULL,
  `TXD3` varchar(32) NOT NULL,
  `Texture3` varchar(32) NOT NULL,
  `Colour3` int(11) NOT NULL,
  `ModelID3` int(11) NOT NULL,
  `TXD4` varchar(32) NOT NULL,
  `Texture4` varchar(32) NOT NULL,
  `Colour4` int(11) NOT NULL,
  `ModelID4` int(11) NOT NULL,
  `TXD5` varchar(32) NOT NULL,
  `Texture5` varchar(32) NOT NULL,
  `Colour5` int(11) NOT NULL,
  `ModelID5` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Furn_Texture`
--

CREATE TABLE IF NOT EXISTS `Furn_Texture` (
  `ID` int(11) NOT NULL,
  `FurnID` int(11) NOT NULL,
  `TXD` varchar(32) NOT NULL,
  `Texture` varchar(32) NOT NULL,
  `Colour` int(11) NOT NULL,
  `ModelID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `garbage`
--

CREATE TABLE IF NOT EXISTS `garbage` (
  `garbageID` int(11) NOT NULL AUTO_INCREMENT,
  `garbageModel` int(11) NOT NULL,
  `garbageCapacity` int(11) NOT NULL,
  `garbageX` float NOT NULL,
  `garbageY` float NOT NULL,
  `garbageZ` float NOT NULL,
  `garbageA` float NOT NULL,
  `garbageInterior` int(11) NOT NULL,
  `garbageWorld` int(11) NOT NULL,
  PRIMARY KEY (`garbageID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gas_pumps`
--

CREATE TABLE IF NOT EXISTS `gas_pumps` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosRX` float NOT NULL,
  `PosRY` float NOT NULL,
  `PosRZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Business` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE IF NOT EXISTS `gates` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FactionID` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `Type` int(11) NOT NULL,
  `ClosedPosX` float NOT NULL,
  `ClosedPosY` float NOT NULL,
  `ClosedPosZ` float NOT NULL,
  `ClosedPosRX` float NOT NULL,
  `ClosedPosRY` float NOT NULL,
  `ClosedPosRZ` float NOT NULL,
  `OpenPosX` float NOT NULL,
  `OpenPosY` float NOT NULL,
  `OpenPosZ` float NOT NULL,
  `OpenPosRX` float NOT NULL,
  `OpenPosRY` float NOT NULL,
  `OpenPosRZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Speed` float NOT NULL,
  `Distance` float NOT NULL,
  `ModelID` int(11) NOT NULL,
  `Code` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE IF NOT EXISTS `graffiti` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Text` varchar(128) NOT NULL,
  `PlacedBy` int(11) NOT NULL,
  `PlaceTime` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hacker_log`
--

CREATE TABLE IF NOT EXISTS `hacker_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `Username` varchar(32) NOT NULL,
  `Action` varchar(128) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `HelperAcceptance`
--

CREATE TABLE IF NOT EXISTS `HelperAcceptance` (
  `TokenID` int(11) NOT NULL AUTO_INCREMENT,
  `Date` varchar(10) NOT NULL,
  `Hour` int(11) NOT NULL,
  `ID` int(11) NOT NULL,
  PRIMARY KEY (`TokenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) UNSIGNED NOT NULL,
  `MarketPrice` int(11) NOT NULL,
  `ExteriorX` float NOT NULL,
  `ExteriorY` float NOT NULL,
  `ExteriorZ` float NOT NULL,
  `ExteriorA` float NOT NULL,
  `ExteriorInt` int(11) NOT NULL,
  `ExteriorVW` int(11) NOT NULL,
  `InteriorX` float NOT NULL,
  `InteriorY` float NOT NULL,
  `InteriorZ` float NOT NULL,
  `InteriorA` float NOT NULL,
  `InteriorInt` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `CashBox` int(11) NOT NULL,
  `Weapons0` int(11) NOT NULL,
  `Weapons1` int(11) NOT NULL,
  `Weapons2` int(11) NOT NULL,
  `Weapons3` int(11) NOT NULL,
  `Weapons4` int(11) NOT NULL,
  `Weapons5` int(11) NOT NULL,
  `Weapons6` int(11) NOT NULL,
  `Weapons7` int(11) NOT NULL,
  `Weapons8` int(11) NOT NULL,
  `Weapons9` int(11) NOT NULL,
  `Weapons10` int(11) NOT NULL,
  `Weapons11` int(11) NOT NULL,
  `Weapons12` int(11) NOT NULL,
  `Weapons13` int(11) NOT NULL,
  `Weapons14` int(11) NOT NULL,
  `Weapons15` int(11) NOT NULL,
  `Weapons16` int(11) NOT NULL,
  `Weapons17` int(11) NOT NULL,
  `Weapons18` int(11) NOT NULL,
  `Weapons19` int(11) NOT NULL,
  `Weapons20` int(11) NOT NULL,
  `WeaponsAmmo0` int(11) NOT NULL,
  `WeaponsAmmo1` int(11) NOT NULL,
  `WeaponsAmmo2` int(11) NOT NULL,
  `WeaponsAmmo3` int(11) NOT NULL,
  `WeaponsAmmo4` int(11) NOT NULL,
  `WeaponsAmmo5` int(11) NOT NULL,
  `WeaponsAmmo6` int(11) NOT NULL,
  `WeaponsAmmo7` int(11) NOT NULL,
  `WeaponsAmmo8` int(11) NOT NULL,
  `WeaponsAmmo9` int(11) NOT NULL,
  `WeaponsAmmo10` int(11) NOT NULL,
  `WeaponsAmmo11` int(11) NOT NULL,
  `WeaponsAmmo12` int(11) NOT NULL,
  `WeaponsAmmo13` int(11) NOT NULL,
  `WeaponsAmmo14` int(11) NOT NULL,
  `WeaponsAmmo15` int(11) NOT NULL,
  `WeaponsAmmo16` int(11) NOT NULL,
  `WeaponsAmmo17` int(11) NOT NULL,
  `WeaponsAmmo18` int(11) NOT NULL,
  `WeaponsAmmo19` int(11) NOT NULL,
  `WeaponsAmmo20` int(11) NOT NULL,
  `WeaponsSerial0` int(11) NOT NULL,
  `WeaponsSerial1` int(11) NOT NULL,
  `WeaponsSerial2` int(11) NOT NULL,
  `WeaponsSerial3` int(11) NOT NULL,
  `WeaponsSerial4` int(11) NOT NULL,
  `WeaponsSerial5` int(11) NOT NULL,
  `WeaponsSerial6` int(11) NOT NULL,
  `WeaponsSerial7` int(11) NOT NULL,
  `WeaponsSerial8` int(11) NOT NULL,
  `WeaponsSerial9` int(11) NOT NULL,
  `WeaponsSerial10` int(11) NOT NULL,
  `WeaponsSerial11` int(11) NOT NULL,
  `WeaponsSerial12` int(11) NOT NULL,
  `WeaponsSerial13` int(11) NOT NULL,
  `WeaponsSerial14` int(11) NOT NULL,
  `WeaponsSerial15` int(11) NOT NULL,
  `WeaponsSerial16` int(11) NOT NULL,
  `WeaponsSerial17` int(11) NOT NULL,
  `WeaponsSerial18` int(11) NOT NULL,
  `WeaponsSerial19` int(11) NOT NULL,
  `WeaponsSerial20` int(11) NOT NULL,
  `PlacePosX` float NOT NULL,
  `PlacePosY` float NOT NULL,
  `PlacePosZ` float NOT NULL,
  `Boombox` int(11) NOT NULL,
  `RentFee` int(11) NOT NULL,
  `Rentable` int(11) NOT NULL,
  `Wired` int(11) NOT NULL,
  `Address` varchar(128) NOT NULL,
  `CustomExterior` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `house_wep`
--

CREATE TABLE IF NOT EXISTS `house_wep` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `WeaponID` int(11) NOT NULL,
  `WeaponAmmo` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `h_bolopersons`
--

CREATE TABLE IF NOT EXISTS `h_bolopersons` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `facID` int(11) DEFAULT NULL,
  `reporter` varchar(32) DEFAULT NULL,
  `suspect` varchar(32) DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `h_bolovehicles`
--

CREATE TABLE IF NOT EXISTS `h_bolovehicles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `facID` int(11) DEFAULT NULL,
  `reporter` varchar(32) DEFAULT NULL,
  `plate` varchar(32) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `reason` varchar(128) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ic_log`
--

CREATE TABLE IF NOT EXISTS `ic_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Message` varchar(144) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6261 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jails`
--

CREATE TABLE IF NOT EXISTS `jails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VirtualWorld` int(11) NOT NULL,
  `FactionID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jail_sentences`
--

CREATE TABLE IF NOT EXISTS `jail_sentences` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FactionID` int(11) NOT NULL,
  `OfficerID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kick_logs`
--

CREATE TABLE IF NOT EXISTS `kick_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `KickedDBID` int(11) NOT NULL,
  `KickedName` varchar(32) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `KickedBy` varchar(32) NOT NULL,
  `Date` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kills`
--

CREATE TABLE IF NOT EXISTS `kills` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CharacterID` int(11) NOT NULL,
  `KillerID` int(11) NOT NULL,
  `Date` int(11) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mapping`
--

CREATE TABLE IF NOT EXISTS `mapping` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ModelID` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `DrawDistance` float NOT NULL,
  `Name` varchar(32) NOT NULL,
  `TextureModelID0` int(11) NOT NULL,
  `TextureModelID1` int(11) NOT NULL,
  `TextureModelID2` int(11) NOT NULL,
  `TextureModelID3` int(11) NOT NULL,
  `TextureModelID4` int(11) NOT NULL,
  `TextureModelID5` int(11) NOT NULL,
  `TextureModelID6` int(11) NOT NULL,
  `TextureModelID7` int(11) NOT NULL,
  `TextureModelID8` int(11) NOT NULL,
  `TextureModelID9` int(11) NOT NULL,
  `TextureModelID10` int(11) NOT NULL,
  `TextureModelID11` int(11) NOT NULL,
  `TextureModelID12` int(11) NOT NULL,
  `TextureModelID13` int(11) NOT NULL,
  `TextureModelID14` int(11) NOT NULL,
  `TextureModelID15` int(11) NOT NULL,
  `TextureName0` varchar(32) NOT NULL,
  `TextureName1` varchar(32) NOT NULL,
  `TextureName2` varchar(32) NOT NULL,
  `TextureName3` varchar(32) NOT NULL,
  `TextureName4` varchar(32) NOT NULL,
  `TextureName5` varchar(32) NOT NULL,
  `TextureName6` varchar(32) NOT NULL,
  `TextureName7` varchar(32) NOT NULL,
  `TextureName8` varchar(32) NOT NULL,
  `TextureName9` varchar(32) NOT NULL,
  `TextureName10` varchar(32) NOT NULL,
  `TextureName11` varchar(32) NOT NULL,
  `TextureName12` varchar(32) NOT NULL,
  `TextureName13` varchar(32) NOT NULL,
  `TextureName14` varchar(32) NOT NULL,
  `TextureName15` varchar(32) NOT NULL,
  `TextureTXD0` varchar(32) NOT NULL,
  `TextureTXD1` varchar(32) NOT NULL,
  `TextureTXD2` varchar(32) NOT NULL,
  `TextureTXD3` varchar(32) NOT NULL,
  `TextureTXD4` varchar(32) NOT NULL,
  `TextureTXD5` varchar(32) NOT NULL,
  `TextureTXD6` varchar(32) NOT NULL,
  `TextureTXD7` varchar(32) NOT NULL,
  `TextureTXD8` varchar(32) NOT NULL,
  `TextureTXD9` varchar(32) NOT NULL,
  `TextureTXD10` varchar(32) NOT NULL,
  `TextureTXD11` varchar(32) NOT NULL,
  `TextureTXD12` varchar(32) NOT NULL,
  `TextureTXD13` varchar(32) NOT NULL,
  `TextureTXD14` varchar(32) NOT NULL,
  `TextureTXD15` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `News`
--

CREATE TABLE IF NOT EXISTS `News` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Timestamp` int(10) UNSIGNED NOT NULL,
  `Poster` varchar(32) NOT NULL,
  `Message` text NOT NULL,
  `Title` varchar(128) NOT NULL,
  `Draft` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ooc_log`
--

CREATE TABLE IF NOT EXISTS `ooc_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Message` varchar(144) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3702 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phone_contacts`
--

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `Number` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `salt` varchar(256) NOT NULL,
  `SecretWord` varchar(256) NOT NULL,
  `deaths` int(11) NOT NULL,
  `kills` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `angle` float NOT NULL,
  `interior` int(11) NOT NULL,
  `virtualworld` int(11) NOT NULL,
  `AdminLevel` int(11) NOT NULL,
  `HelperLevel` int(11) NOT NULL,
  `ChangePassword` int(11) NOT NULL,
  `OfflineJailed` int(11) NOT NULL,
  `OfflineJailTime` int(11) NOT NULL,
  `OfflineJailReason` varchar(32) NOT NULL,
  `OfflineJailAdmin` varchar(24) NOT NULL,
  `DonateLevel` int(11) NOT NULL,
  `DonateExpire` int(11) NOT NULL,
  `Ajailed` int(11) NOT NULL,
  `AjailTime` int(11) NOT NULL,
  `AjailReason` varchar(128) NOT NULL,
  `AjailedBy` varchar(25) NOT NULL,
  `PassedTest` int(11) NOT NULL,
  `BetaTester` int(11) NOT NULL,
  `HelpmeMutes` int(11) NOT NULL,
  `HelpmeMuted` int(11) NOT NULL,
  `Mapper` int(11) NOT NULL,
  `LastActive` int(11) NOT NULL,
  `StoredIP` varchar(128) NOT NULL,
  `StoredGPCI` varchar(41) NOT NULL,
  `RegisterDate` int(11) NOT NULL,
  `NameChanges` int(11) NOT NULL,
  `NumberChanges` int(11) NOT NULL,
  `BMXPermission` int(11) NOT NULL,
  `Lotto` int(11) NOT NULL,
  `PassedTutorial` int(11) NOT NULL,
  `PlayingHours` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `activated` tinyint(1) NOT NULL,
  `dcrp_terms` int(11) NOT NULL,
  `samp_terms` int(11) NOT NULL,
  `IsLoggedIn` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Player_Inventory`
--

CREATE TABLE IF NOT EXISTS `Player_Inventory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `CharacterID` int(11) NOT NULL,
  `Serial` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pm_log`
--

CREATE TABLE IF NOT EXISTS `pm_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AccountID` int(11) NOT NULL,
  `UserName` varchar(32) NOT NULL,
  `Reciever` varchar(32) NOT NULL,
  `Message` varchar(144) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2210 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roleplay_test`
--

CREATE TABLE IF NOT EXISTS `roleplay_test` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_1` text NOT NULL,
  `question_2` text NOT NULL,
  `question_3` text NOT NULL,
  `question_4` text NOT NULL,
  `account_id` int(10) UNSIGNED NOT NULL,
  `timestamp` int(11) NOT NULL,
  `ip_addr` varchar(256) NOT NULL,
  `host_name` varchar(128) NOT NULL,
  `user_agent` varchar(128) NOT NULL,
  `app_status` int(11) NOT NULL,
  `denied_id` int(11) NOT NULL,
  `deny_reason` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ServerLogs`
--

CREATE TABLE IF NOT EXISTS `ServerLogs` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Message` varchar(256) NOT NULL,
  `Timestamp` int(10) UNSIGNED NOT NULL,
  `LogType` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=54163 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `PlayerMOTD` varchar(128) NOT NULL,
  `HelperMOTD` varchar(128) NOT NULL,
  `AdminMOTD` varchar(123) NOT NULL,
  `TaxRate` int(11) NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnA` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `World` int(11) NOT NULL,
  `ServerName` varchar(128) NOT NULL,
  `ServerShortName` varchar(128) NOT NULL,
  `ServerRevision` varchar(128) NOT NULL,
  `ServerWebsite` varchar(128) NOT NULL,
  `ServerPassword` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE IF NOT EXISTS `sms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Message` varchar(128) NOT NULL,
  `Number` int(11) NOT NULL,
  `Reciever` int(11) NOT NULL,
  `Timestamp` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `speed_cameras`
--

CREATE TABLE IF NOT EXISTS `speed_cameras` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pos_x` float(10,5) NOT NULL,
  `pos_y` float(10,5) NOT NULL,
  `pos_z` float(10,5) NOT NULL,
  `rotation` float(10,5) NOT NULL,
  `range` float(10,5) NOT NULL,
  `speed_limit` float(10,5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains data regarding speed cameras.';

-- --------------------------------------------------------

--
-- Table structure for table `street_data`
--

CREATE TABLE IF NOT EXISTS `street_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `startX` float NOT NULL,
  `startY` float NOT NULL,
  `endX` float NOT NULL,
  `endY` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teleports`
--

CREATE TABLE IF NOT EXISTS `teleports` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) NOT NULL,
  `AddedBy` varchar(25) NOT NULL,
  `AddedDate` varchar(32) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `World` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Trash_Inventory`
--

CREATE TABLE IF NOT EXISTS `Trash_Inventory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Serial` int(11) NOT NULL,
  `GarbageID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UCP_Comments`
--

CREATE TABLE IF NOT EXISTS `UCP_Comments` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NewsID` int(10) UNSIGNED NOT NULL,
  `Message` tinytext NOT NULL,
  `UserID` int(10) UNSIGNED NOT NULL,
  `Timestamp` int(10) UNSIGNED NOT NULL,
  `Hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE IF NOT EXISTS `vehicles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OwnerID` int(11) NOT NULL,
  `FactionID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Colour1` int(11) NOT NULL,
  `Colour2` int(11) NOT NULL,
  `PaintJob` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `PosA` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Locked` int(11) NOT NULL,
  `Impounded` int(11) NOT NULL,
  `ImpoundPosX` float NOT NULL,
  `ImpoundPosY` float NOT NULL,
  `ImpoundPosZ` float NOT NULL,
  `ImpoundPosA` float NOT NULL,
  `LastDriver1` varchar(24) NOT NULL,
  `LastDriver2` varchar(24) NOT NULL,
  `LastDriver3` varchar(24) NOT NULL,
  `LastDriver4` varchar(24) NOT NULL,
  `LastDriver5` varchar(24) NOT NULL,
  `Fuel` float NOT NULL,
  `Sirens` int(11) NOT NULL,
  `Plates` varchar(32) NOT NULL,
  `FineReason` varchar(128) NOT NULL,
  `FineAmount` int(11) NOT NULL,
  `FineOfficerID` int(11) NOT NULL,
  `FineFactionID` int(11) NOT NULL,
  `FineTime` int(11) NOT NULL,
  `DMVVehicle` int(11) NOT NULL,
  `Value` int(11) NOT NULL,
  `Mileage` int(11) NOT NULL,
  `MileageX` float NOT NULL,
  `MileageY` float NOT NULL,
  `MileageZ` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Inventory`
--

CREATE TABLE IF NOT EXISTS `Vehicle_Inventory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Type` int(11) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `VehicleID` int(11) NOT NULL,
  `Serial` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Warehouse`
--

CREATE TABLE IF NOT EXISTS `Warehouse` (
  `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FactionID` tinyint(3) UNSIGNED NOT NULL,
  `Name` char(128) NOT NULL,
  `ExteriorX` float NOT NULL,
  `ExteriorY` float NOT NULL,
  `ExteriorZ` float NOT NULL,
  `ExteriorA` float NOT NULL,
  `ExteriorCustom` tinyint(1) NOT NULL,
  `InteriorX` float NOT NULL,
  `InteriorY` float NOT NULL,
  `InteriorZ` float NOT NULL,
  `InteriorA` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `WeaponRegistry`
--

CREATE TABLE IF NOT EXISTS `WeaponRegistry` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Player` varchar(25) DEFAULT NULL,
  `Info` varchar(256) DEFAULT NULL,
  `Serial` varchar(128) DEFAULT NULL,
  `WeaponName` varchar(32) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Weed_Plants`
--

CREATE TABLE IF NOT EXISTS `Weed_Plants` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Growth` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `World` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `AddedBy` varchar(25) NOT NULL,
  `AddedDate` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `xmr_categories`
--

CREATE TABLE IF NOT EXISTS `xmr_categories` (
  `XMRDBID` int(11) NOT NULL AUTO_INCREMENT,
  `XMRCategoryName` varchar(90) NOT NULL,
  PRIMARY KEY (`XMRDBID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `xmr_stations`
--

CREATE TABLE IF NOT EXISTS `xmr_stations` (
  `XMRStationDBID` int(11) NOT NULL AUTO_INCREMENT,
  `XMRCategory` int(11) NOT NULL,
  `XMRStationName` varchar(90) NOT NULL,
  `XMRStationURL` varchar(128) NOT NULL,
  PRIMARY KEY (`XMRStationDBID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
