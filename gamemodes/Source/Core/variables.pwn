//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

// MySQL connection handle
new MySQL: g_SQL;

new stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

enum E_PLAYERS
{
	ID,
	Name[MAX_PLAYER_NAME],
	Password[65], // the output of SHA256_PassHash function (which was added in 0.3.7 R1 version) is always 256 bytes in length, or the equivalent of 64 Pawn cells
	Salt[17],
	SecretWord[65],
	Kills,
	Deaths,
	Float: X_Pos,
	Float: Y_Pos,
	Float: Z_Pos,
	Float: A_Pos,
	Interior,
	VirtualWorld,
    AdminLevel,
	Ajailed,
	AjailTime,
	AjailReason[128],
	AjailedBy[MAX_PLAYER_NAME+1],
	HelperLevel,
	ChangePassword,
	OfflineJailed,
	OfflineJailTime,
	OfflineJailReason[128],
	OfflineJailAdmin[MAX_PLAYER_NAME],
	DonateLevel,
	DonateExpire,
	PassedTest,
	PassedTutorial,
	BetaTester,
	Mapper,
	HelpmeMutes,
	HelpmeMuted,
	LastActive,
	RegisterDate,
	StoredIP[128],
	StoredGPCI[128],
	NameChanges,
	NumberChanges,
	WeaponBan,
	PlayingHours,

	Cache: Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer
};
new Player[MAX_PLAYERS][E_PLAYERS];

enum pData
{
	pCharacterID,
	pOwnerID,
	pName[MAX_PLAYER_NAME],
	pLoggedIn,
	pSkin,
	pLevel,
	pExpierience,
	pHours,
	pCrashed,
	Float:pLastPos[4],
	pLastInterior,
	pLastVW,
	pMoney,
	pBank,
	pPayCheque,
	pPhoneNo,
	pPhoneType,
	pFaction,
	pFactionRank,
	pWeaponSpawned[4],
	pWeapon[13],
	pAmmo[13],
	pSerial[13],
	pHandcuffed,
	pRadio,
	pRadioChan,
	pRadioSlot,
	pInjured,
	pWeaponLicense,
	pDrivingLicense,
	pFlyingLicense,
	pPrisonTimes,
	pJailTimes,
	pJob,
	pSideJob,
	pWalkStyle,
	pChatStyle,
	pJailed,
	pJailID,
	pJailTime,
	pSpawn,
	pGender,
	pMask,
	pMaskID,
	pLastShot[MAX_PLAYER_NAME+1],
	pLastShotTime,
	pLastRam[MAX_PLAYER_NAME+1],
	pLastRamTime,
	pDeathMode,
	Float:pHealth,
	Float:pArmour,
	pOwnedVehicle[MAX_PVEH],
	pSpawnedVehicle,
	pDutySkin,
	pBeforeSkin,
	pFactionDuty,
	pRenting,
	pConnectedTime,
	pHouseSpawnID,
	pCigarettes,
	pSprunk,
	pPrimaryWeapon,
	pPrimaryAmmo,
	pPrimarySerial,
	pSecondaryWeapon,
	pSecondaryAmmo,
	pSecondarySerial,
	pMeleeWeapon,
	pOtherWeapon,
	pFish,
	pFishBait,
	Float:pWeaponX,
	Float:pWeaponY,
	Float:pWeaponZ,
	Float:pWeaponRX,
	Float:pWeaponRY,
	Float:pWeaponRZ,
	Float:pWeaponSX,
	Float:pWeaponSY,
	Float:pWeaponSZ,
	pWeaponBone,
	pComponents,
	pPackages[12],
	pSavings,
	pWireCutter,
	pWires,
	pBadgeNo,
	pWeedSeeds,
	pPoppySeeds,
	pWeed,
	pHeroin,
	pOpium,
	pHoldingInv,
	pHoldingInvAmount,
	pOrigin[128],
	pLotto,
	pAccent[32],
	pApperance[128],
	pSignChequeAmount,
	pSignChequeCode,
	Text3D:pScene
};
new PlayerInfo[MAX_PLAYERS][pData],
	CharacterNames[MAX_PLAYERS][MAX_CHARACTERS][MAX_PLAYER_NAME + 1],
	CurrentCharacters[MAX_PLAYERS];

enum accEnum
{
	aID,
	aCharacterID,
	aBone,
	aModel,
	Float:aX,
	Float:aY,
	Float:aZ,
	Float:aRX,
	Float:aRY,
	Float:aRZ,
	Float:aSX,
	Float:aSY,
	Float:aSZ,
	bool:aAttached
};
new AccInfo[MAX_PLAYERS][MAX_ACCESSORIES][accEnum];

enum tempVariables
{
    bool:AdminDuty,
	SentReport,
	SentHelpme,
	Spectating,
	bool:Muted,
	Text3D:RelogID,
	RelogTimer,
	bool:Relogging,
	bool:Masked,
	bool:IsLoggedIn,
	bool:HelperDuty,
	GiveVehID,
	FactionInvite,
	FactionInvitedBy,
	bool:LowHPMessage,
	bool:FactionDisabled,
	bool:HasTaser,
	BeforeTaserWep,
	BeforeTaserAmmo,
	BeforeTaserSerial,
	bool:IsTased,
	AddingChargeID,
	LookingUpVehicle,
	bool:JobDuty,
	bool:LumberLogging,
	CBugAmount,
	bool:VehicleBreakIn,
	VehicleBreakInTimer,
	EditingStreetID,
	bool:EditingMap,
	EditingMapID,
	bool:DeleteMap,
	HelperAssistance,
	BuyingHouse,
	SellingHouse,
	HousePrice,
	SellingID,
	CarSurf,
	bool:IsAFK,
	AFKSeconds,
	AirbreakCooldown,
	FriskRequest,
	BuyingBiz,
	bool:RubberBullets,
	bool:SpecVehicle,
	EditingBizName,
	bool:WelcomeShown,
	TempNote[128],
	LookupID,
	bool:AnimPreloaded,
	bool:AcceptedDeath,
	bool:OnPlayerDeathTriggered,
	EditingGateClosed,
	EditingGateOpen,
	WatchingPM,
	RecentKills,
	BuyClothes,
	bool:DuplicateMap,
	bool:OnCall,
	Mobile,
	bool:CallAnswer,
	CallLandline,
	EmergencyCallText[256],
	ServicesText[256],
	bool:BackupRequsted,
	GhostHackWarnings,
	SpeedHackWarnings,
	UnbanName[MAX_PLAYER_NAME],
	bool:BlindFolded,
	bool:Greenscreen,
	OnTextNumber,
	FishDelay,
	bool:Fishing,
	bool:FishCheckpoint,
	FishCheckpointID,
	DMVTest,
	Blocked,
	bool:SelectRoadblock,
	EditingRoadblock,
	bool:DeleteRoadblock,
	bool:SelectSpike,
	bool:DeleteSpike,
	EditingSpike,
	IdleTime,
	TakingFromHouse,
	Float:PlayerPosX,
	Float:PlayerPosY,
	Float:PlayerPosZ,
	SpamCarCheck,
	CarTrollCheck,
	bool:IdleWarn,
	SpamWarns,
	TestStage,
	TestAnswerOne[128],
	TestAnswerTwo[128],
	TestAnswerThree[128],
	TestAnswerFour[128],
	TestAnswerFive[128],
	TestAnswerSix[128],
	TestAnswerSeven[128],
	TestAnswerEight[128],
	TestAnswerNine[128],
	TestAnswerTen[128],
	AcceptingID,
	FurnCategory,
	bool:EditFurniture,
	EditFurnitureID,
	EditFurnitureArrayID,
	SelectType,
	EditType,
	bool:DisabledOOC,
	CheckpointType,
	JobOffer,
	TaxiFare,
	TaxiDriverID,
	TaxiFarePrice,
	bool:MapperDuty,
	AddNoteID,
	PMConvo,
	AppCheckedBy,
	ShakeOffer,
	ShakeType,
	CJRunWarning,
	JumpTime,
	JumpCount,
	SprayID,
	ConfirmVehicle,
	ConfirmVehiclePrice,
	ConfirmVehicleDealer,
	bool:BeingKicked,
	FlyHackingWarning,
	bool:TalkingLive,
	bool:NewsDisabled,
	bool:AdminDisabled,
	InventorySelectType,
	bool:AdminWarnDisabled,
	bool:PMDisabled,
	bool:StaffDisabled,
	bool:HelperDisabled,
	bool:AdminHide,
	bool:RefuelVehicle,
	PMWarningMSG[144],
	PMWarningID,
	bool:Nametag,
	LastGlobal,
	bool:UsingPayphone,
	bool:CuttingWire,
	PMWarningTime,
	TeleportID,
	CarOffer,
	CarPrice,
	CarSell,
	SeedOffer,
	SeedAmount,
	bool:Handcuffed,
	BeforeSprayWep,
	BeforeSprayAmmo,
	BeforeSpraySerial,
	bool:IsSprayingVehicle,
	SprayingVehicle,
	SprayingVehicleCounter,
	SprayingVehicleColour1,
	SprayingVehicleColour2,
	SprayingVehiclePaintjob,
	bool:SuspectedAimbotter,
	bool:SmokingWeed,
	KillTime,
	bool:ConnectEnabled,
	bool:DonatorTag
};
new TempVar[MAX_PLAYERS][tempVariables];
new bool:BlockedPM[MAX_PLAYERS][MAX_PLAYERS];

enum mPos
{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosA,
	Interior,
	VW
}
new MarkPos[MAX_PLAYERS][MAX_MARK_POS][mPos];

enum sInfo
{
    bool:OOCEnabled,
    GlobalWeather,
	CurrentHour,
	CurrentMinute,
	CurrentSecond,
	ServerUptime,
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ,
	Float:SpawnA,
	PlayerMOTD[128],
	AdminMOTD[128],
	HelperMOTD[128],
	AdvertTimer,
	bool:PayDayPassed,
	TaxRate,
	ServerName[128],
	ServerShortName[128],
	ServerRevision[128],
	ServerWebsite[128],
	ServerPassword[128]
};
new ServerInfo[sInfo];

new g_MysqlRaceCheck[MAX_PLAYERS];

// dialog data
#define DIALOG_UNUSED 0

/*#define DIALOG_LOGIN 1
#define DIALOG_REGISTER 2
#define DIALOG_SECRETWORD_CREATE 3
#define DIALOG_CLEAR_REPORTS 4
#define DIALOG_HELP_MAIN 5
#define SELECT_CHARACTER 6*/

new maleList = mS_INVALID_LISTID;
new femaleList = mS_INVALID_LISTID;
new BuyList = mS_INVALID_LISTID;

new characterName[MAX_PLAYERS][MAX_PLAYER_NAME],
    bool:characterGender[MAX_PLAYERS],
    characterSkin[MAX_PLAYERS],
	characterSpawn[MAX_PLAYERS],
	characterOrigin[MAX_PLAYERS][128];

new MYSQL_HOST[16],
	MYSQL_USER[32],
	MYSQL_PASSWORD[128],
	MYSQL_DATABASE[32],
	GAMEMODE_DEBUG,
	SERVER_PASSWORD[128];


enum E_DAMAGE_INFO
{
	eDamageTaken,
	eDamageTime,
	
	eDamageWeapon,
	
	eDamageBodypart,
	eDamageArmor,
	
	eDamageBy
}

new DamageInfo[MAX_PLAYERS][100][E_DAMAGE_INFO]; 
new TotalPlayerDamages[MAX_PLAYERS];

enum E_DROPPEDGUN_DATA
{
	bool:eWeaponDropped,
	eWeaponObject,
	Text3D:eWeaponLabel,
	eWeaponTimer,
	
	eWeaponWepID,
	eWeaponWepAmmo,
	eWeaponType,
	
	Float:eWeaponPos[3],
	eWeaponInterior,
	eWeaponWorld,
	
	eWeaponDroppedBy,
	eWeaponSerial
}

new WeaponDropInfo[200][E_DROPPEDGUN_DATA];

enum vInfo
{
	vID,
	vScriptID,
	bool:vExists,
	vOwnerID,
	vFactionID,
	vModel,
	vColour1,
	vColour2,
	vPaintJob,
	Float:vPos[4],
	vInterior,
	vVW,
	vLocked,
	vImpounded,
	Float:vImpoundPos[4],
	vLastDrivers[5],
	bool:vEngine,
	bool:vLights,
	bool:vHood,
	bool:vAlarm,
	bool:vTrunk,
	Float:vFuel,
	bool:vAdminSpawn,
	vWindows,
	vWindowFrontLeft,
	vWindowFrontRight,
	vWindowBackLeft,
	vWindowBackRight,
	vPlates[32],
	vSirens,
	vFineReason[128],
	vFineAmount,
	vFineOfficerID,
	vFineFactionID,
	vFineTime,
	vDMVVehicle,
	vValue,
	vMileage,
	Float:vMileagePosX,
	Float:vMileagePosY,
	Float:vMileagePosZ,

	// Vehicle Gunrack - Restricted to factions with gunrack permissions.
	vGunRack[4],
	vGunRackAmmo[4]
}
new VehicleInfo[MAX_VEHICLES][vInfo],
	Cache:vCache;

enum coreVeh
{
	bool:VehicleEngine,
	bool:VehicleLights,
	bool:VehicleHood,
	bool:VehicleLocked,
	bool:VehicleTrunk,
	bool:VehicleAlarm,
	bool:VehicleWindowFrontLeft,
	bool:VehicleWindowFrontRight,
	bool:VehicleWindowBackLeft,
	bool:VehicleWindowBackRight,
	Float:VehicleFuel,
	SirenObject,
	SirenStatus,
	bool:IsAdminVehicle,
	TrashAmount,
	RadioURL[128]
};
new CoreVehicle[MAX_VEHICLES][coreVeh];

new tempVehModel[MAX_PLAYERS][MAX_PVEH], tempVehDBID[MAX_PLAYERS][MAX_PVEH], 
	tempVehColour1[MAX_PLAYERS][MAX_PVEH], tempVehColour2[MAX_PLAYERS][MAX_PVEH],
	tempVehPaintJob[MAX_PLAYERS][MAX_PVEH], Float:tempVehPosX[MAX_PLAYERS][MAX_PVEH], 
	Float:tempVehPosY[MAX_PLAYERS][MAX_PVEH], Float:tempVehPosZ[MAX_PLAYERS][MAX_PVEH], 
	Float:tempVehPosA[MAX_PLAYERS][MAX_PVEH], Float:tempVehFuel[MAX_PLAYERS][MAX_PVEH];

new bool:VehicleHasCarSign[MAX_VEHICLES], Text3D:VehicleCarSign[MAX_VEHICLES];

//new PoliceSiren[MAX_VEHICLES], VehicleSiren[MAX_VEHICLES];

new LightPwr[MAX_VEHICLES];
new Flasher[MAX_VEHICLES] = 0;
new FlasherState[MAX_VEHICLES];

new DCC_Channel:g_StaffChat, DCC_Channel:g_AdminChat, DCC_Channel:g_LeadAdminChat, DCC_Channel:g_HelperChat, DCC_Channel:g_AdminWarning;

enum fInfo
{
	FactionID,
	FactionName[90],
	FactionAbbrev[30],
	Float:FactionSpawn[3],
	FactionSpawnInt,
	FactionSpawnWorld,
	Float:FactionDutyPos[3],
	FactionDutyInt,
	FactionDutyWorld,
	FactionJoinRank,
	FactionAlterRank,
	FactionHighCommandChat,
	FactionChatRank,
	FactionTowRank,
	FactionType,
	FactionBank,
	RamRaid,
	WeaponDelivery,
	ChatColour,

	// Faction Permissions
	FactionPoliceCall, // Police 911 Calls
	FactionMedicCall, // Medic 911 Calls
	FactionGovernmentCall, // Government Landline Calls
	FactionBadge, // /badge, /setbadge, /osetbadge
	FactionCarsign, // /carsign, /carsignremove
	FactionCuff, // /handcuff, /unhandcuff
	FactionDeploy, // /roadblock, /spike, /spikeL, /spikeR
	FactionBackup, // /bk
	FactionDepartmental, // /dep, /deplow
	FactionImpound, // /impound
	FactionJail, // /jail, /prison
	FactionMegaphone, // /m
	FactionSuspect, // /suspect
	FactionLicense, // /givelicense
	FactionSeize, // /take, /seizeplant, /seizeboombox
	FactionTaser, // /taser, /rubberbullets
	FactionHQ, // /hq
	FactionGov, // /gov, free spray
	FactionSiren, // /siren, /elm
	FactionDutyAccess, // /duty, /uniform, /govaccessories, /equip
	FactionTicket, // /fine, /vfine, /excusefine
	FactionMDC, // /mdc, /createbolo, /deletebolo
	FactionMedic, // /putinambu, /operation
	FactionNews, // /news, /live
	FactionTag, // /graffiti
	FactionRamRaid, // /ramraid, /cutwire
	FactionEconomy, // Tax Money goes to this faction, TODO: Add /settax
	FactionDrugRights, // /buyseed
	FactionGunRights // 
}
new FactionInfo[MAX_FACTIONS][fInfo];
new FactionRanks[MAX_FACTIONS][MAX_FACTION_RANKS][60],
	FactionRankPay[MAX_FACTIONS][MAX_FACTION_RANKS];
new bool:FactionChatStatus[MAX_FACTIONS],
	PlayerEditingRank[MAX_PLAYERS];

new const VehicleColoursTableRGBA[256] =
{
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

//new LumberjackTree[11];

/*new VehicleSirenVeh[4][1] = {
	{596},
	{597},
	{598},
	{579}
};

new Float:VehicleSirenPos[4][3] = {
	{-0.0001, -0.3852, 0.9047},
	{-0.0001, -0.3852, 0.8847},
	{-0.0001, -0.3452, 0.8847},
	{-0.6801, 0.1948, 1.2525}
};*/

enum mInfo
{
	mID,
	mModelID,
	Float:mX,
	Float:mY,
	Float:mZ,
	Float:mRX,
	Float:mRY,
	Float:mRZ,
	Float:mDrawDistance,
	mObjectID,
	mName[32],
	mTextureModelID0,
	mTextureModelID1,
	mTextureModelID2,
	mTextureModelID3,
	mTextureModelID4,
	mTextureModelID5,
	mTextureName0[64],
	mTextureName1[64],
	mTextureName2[64],
	mTextureName3[64],
	mTextureName4[64],
	mTextureName5[64],
	mTextureTXD0[64],
	mTextureTXD1[64],
	mTextureTXD2[64],
	mTextureTXD3[64],
	mTextureTXD4[64],
	mTextureTXD5[64]
};
new MappingInfo[MAX_DYN_OBJECTS][mInfo],
	Cache:mapCache;

enum E_XMR_CATEGORY_DATA
{
	eXMRID,
	eXMRCategoryName[90]
}

enum E_XMR_CATEGORY_STATIONS_DATA
{
	eXMRStationID,
	eXMRCategory,
	
	eXMRStationName[90],
	eXMRStationURL[128]
}


enum buy_attach
{
	Model,
	Name[128],
	Price,
	Bone
};


enum glob_attach
{
	Model,
	Name[128],
	Price
};

new GovernmentAttachments[][buy_attach] = {
	{19904, "Hi-Vis Vest", 20, 1},
	{18641, "Flashlight", 5, 5},
	{19138, "Black Glasses", 100, 2},
	{19139, "Red Glasses", 100, 2},
	{19140, "Blue Glasses", 100, 2}
};

new MedicAttachments[][buy_attach] = {
	{19904, "Hi-Vis Vest", 20, 1},
	{18641, "Flashlight", 5, 5},
	{11738, "Medic Case", 50, 5},
	{19521, "High Command Hat", 40, 2},
	{19138, "Black Glasses", 100, 2},
	{19139, "Red Glasses", 100, 2},
	{19140, "Blue Glasses", 100, 2}
};

new PoliceAttachments[][buy_attach] = {
	{19904, "Hi-Vis Vest", 20, 1},
	{18641, "Flashlight", 5, 5},
	{18637, "Riot Shield", 30, 5},
	{11738, "Medic Case", 50, 5},
	{19142, "Police Armour", 50, 1},
	{19521, "High Command Hat", 40, 2},
	{18636, "Police Hat", 30, 2},
	{19161, "Cadet Hat 1", 20, 2},
	{19162, "Cadet Hat 2", 20, 2},
	{19347, "Sheriff Badge", 60, 1},
	{19099, "Sheriff Hat 1", 10, 2},
	{19100, "Sheriff Hat 2", 10, 2},
	{19138, "Black Glasses", 100, 2},
	{19139, "Red Glasses", 100, 2},
	{19140, "Blue Glasses", 100, 2},
	{19141, "SWAT Helmet", 50, 2},
	{11749, "Handcuffs", 10, 1}
};

new ShopAttachments[][buy_attach] = {
	{18638, "Hard Hat 1", 20, 2},
	{19093, "Hard Hat 2", 20, 2},
	{19160, "Hard Hat 3", 20, 2},
	{18639, "Black Hat 1", 20, 2},
	{18640, "Hair 1", 20, 2},
	{18975, "Hair 2", 20, 2},
	{19136, "Hair 4", 20, 2},
	{19274, "Hair 5", 20, 2},
	{18891, "Bandana 1", 20, 2},
	{18892, "Bandana 2", 20, 2},
	{18893, "Bandana 3", 20, 2},
	{18894, "Bandana 4", 20, 2},
	{18895, "Bandana 5", 20, 2},
	{18896, "Bandana 6", 20, 2},
	{18897, "Bandana 7", 20, 2},
	{18898, "Bandana 8", 20, 2},
	{18899, "Bandana 9", 20, 2},
	{18900, "Bandana 10", 20, 2},
	{18901, "Bandana 11", 20, 2},
	{18902, "Bandana 12", 20, 2},
	{18903, "Bandana 13", 20, 2},
	{18904, "Bandana 14", 20, 2},
	{18905, "Bandana 15", 20, 2},
	{18906, "Bandana 16", 20, 2},
	{18907, "Bandana 17", 20, 2},
	{18908, "Bandana 18", 20, 2},
	{18909, "Bandana 19", 20, 2},
	{18910, "Bandana 20", 20, 2},
	{18911, "Mask 1", 20, 2},
	{18912, "Mask 2", 20, 2},
	{18913, "Mask 3", 20, 2},
	{18914, "Mask 4", 20, 2},
	{18915, "Mask 5", 20, 2},
	{18916, "Mask 6", 20, 2},
	{18917, "Mask 7", 20, 2},
	{18918, "Mask 8", 20, 2},
	{18919, "Mask 9", 20, 2},
	{18920, "Mask 10", 20, 2},
	{18921, "Beret 1", 20, 2},
	{18922, "Beret 2", 20, 2},
	{18923, "Beret 3", 20, 2},
	{18924, "Beret 4", 20, 2},
	{18925, "Beret 5", 20, 2},
	{18926, "Hat 1", 20, 2},
	{18927, "Hat 2", 20, 2},
	{18928, "Hat 3", 20, 2},
	{18929, "Hat 4", 20, 2},
	{18930, "Hat 5", 20, 2},
	{18931, "Hat 6", 20, 2},
	{18932, "Hat 7", 20, 2},
	{18933, "Hat 8", 20, 2},
	{18934, "Hat 9", 20, 2},
	{18935, "Hat 10", 20, 2},
	{18936, "Helmet 1", 20, 2},
	{18937, "Helmet 2", 20, 2},
	{18938, "Helmet 3", 20, 2},
	{18939, "Cap Back 1", 20, 2},
	{18940, "Cap Back 2", 20, 2},
	{18941, "Cap Back 3", 20, 2},
	{18942, "Cap Back 4", 20, 2},
	{18943, "Cap Back 5", 20, 2},
	{18944, "Hat Boater 1", 20, 2},
	{18945, "Hat Boater 2", 20, 2},
	{18946, "Hat Boater 3", 20, 2},
	{18947, "Hat Bowler 1", 20, 2},
	{18948, "Hat Bowler 2", 20, 2},
	{18949, "Hat Bowler 3", 20, 2},
	{18950, "Hat Bowler 4", 20, 2},
	{18951, "Hat Bowler 5", 20, 2},
	{19488, "Hat Bowler 6", 20, 2},
	{18952, "Boxing Helmet", 20, 2},
	{18953, "Cap Knit 1", 20, 2},
	{18954, "Cap Knit 2", 20, 2},
	{18955, "Cap Over Eye 1", 20, 2},
	{18956, "Cap Over Eye 2", 20, 2},
	{18957, "Cap Over Eye 3", 20, 2},
	{18958, "Cap Over Eye 4", 20, 2},
	{18959, "Cap Over Eye 5", 20, 2},
	{18960, "Cap Rim Up", 20, 2},
	{18961, "Cap Trucker 1", 20, 2},
	{18962, "Cowboy Hat 2", 20, 2},
	{18964, "Skully Cap 1", 20, 2},
	{18965, "Skully Cap 2", 20, 2},
	{18966, "Skully Cap 3", 20, 2},
	{18967, "Hat Man 1", 20, 2},
	{18968, "Hat Man 2", 20, 2},
	{18969, "Hat Man 3", 20, 2},
	{18970, "Hat Tiger", 20, 2},
	{18971, "Hat Cool 1", 20, 2},
	{18972, "Hat Cool 2", 20, 2},
	{18973, "Hat Cool 3", 20, 2},
	{18645, "Motorcycle Helmet 1", 20, 2},
	{18976, "Motorcycle Helmet 2", 20, 2},
	{18977, "Motorcycle Helmet 3", 20, 2},
	{18978, "Motorcycle Helmet 4", 20, 2},
	{18979, "Motorcycle Helmet 5", 20, 2},
	{19006, "Glasses 1", 20, 2},
	{19007, "Glasses 2", 20, 2},
	{19008, "Glasses 3", 20, 2},
	{19009, "Glasses 4", 20, 2},
	{19010, "Glasses 5", 20, 2},
	{19011, "Glasses 6", 20, 2},
	{19012, "Glasses 7", 20, 2},
	{19013, "Glasses 8", 20, 2},
	{19014, "Glasses 9", 20, 2},
	{19015, "Glasses 10", 20, 2},
	{19016, "Glasses 11", 20, 2},
	{19017, "Glasses 12", 20, 2},
	{19018, "Glasses 13", 20, 2},
	{19019, "Glasses 14", 20, 2},
	{19020, "Glasses 15", 20, 2},
	{19021, "Glasses 16", 20, 2},
	{19022, "Glasses 17", 20, 2},
	{19023, "Glasses 18", 20, 2},
	{19024, "Glasses 19", 20, 2},
	{19025, "Glasses 20", 20, 2},
	{19026, "Glasses 21", 20, 2},
	{19027, "Glasses 22", 20, 2},
	{19028, "Glasses 23", 20, 2},
	{19029, "Glasses 24", 20, 2},
	{19030, "Glasses 25", 20, 2},
	{19031, "Glasses 26", 20, 2},
	{19032, "Glasses 27", 20, 2},
	{19033, "Glasses 28", 20, 2},
	{19034, "Glasses 29", 20, 2},
	{19035, "Glasses 30", 20, 2},
	{19036, "Hockey Mask 1", 20, 2},
	{19037, "Hockey Mask 2", 20, 2},
	{19038, "Hockey Mask 3", 20, 2},
	{19039, "Watch 1", 20, 3},
	{19040, "Watch 2", 20, 3},
	{19041, "Watch 3", 20, 3},
	{19042, "Watch 4", 20, 3},
	{19043, "Watch 5", 20, 3},
	{19044, "Watch 6", 20, 3},
	{19045, "Watch 7", 20, 3},
	{19046, "Watch 8", 20, 3},
	{19047, "Watch 9", 20, 3},
	{19048, "Watch 10", 20, 3},
	{19049, "Watch 11", 20, 3},
	{19050, "Watch 12", 20, 3},
	{19051, "Watch 13", 20, 3},
	{19052, "Watch 14", 20, 3},
	{19053, "Watch 15", 20, 3},
	{19095, "Cowboy Hat 1", 20, 2},
	{19096, "Cowboy Hat 3", 20, 2},
	{19097, "Cowboy Hat 4", 20, 2},
	{19098, "Cowboy Hat 5", 20, 2},
	{19101, "Army Helmet 1", 20, 2},
	{19102, "Army Helmet 2", 20, 2},
	{19103, "Army Helmet 3", 20, 2},
	{19104, "Army Helmet 4", 20, 2},
	{19105, "Army Helmet 5", 20, 2},
	{19106, "Army Helmet 6", 20, 2},
	{19107, "Army Helmet 7", 20, 2},
	{19108, "Army Helmet 8", 20, 2},
	{19109, "Army Helmet 9", 20, 2},
	{19110, "Army Helmet 10", 20, 2},
	{19111, "Army Helmet 11", 20, 2},
	{19112, "Army Helmet 12", 20, 2},
	{19113, "Silly Helmet 1", 20, 2},
	{19114, "Silly Helmet 2", 20, 2},
	{19115, "Silly Helmet 3", 20, 2},
	{19116, "Plain Helmet 1", 20, 2},
	{19117, "Plain Helmet 2", 20, 2},
	{19118, "Plain Helmet 3", 20, 2},
	{19119, "Plain Helmet 4", 20, 2},
	{19120, "Plain Helmet 5", 20, 2},
	{19349, "Monocle", 20, 2},
	{19350, "Moustache 1", 20, 2},
	{19351, "Moustache 2", 20, 2},
	{19352, "Tophat 1", 20, 2},
	{19487, "Tophat 2", 20, 2}
};

new GlobalAttachments[][glob_attach] = {
	{18638, "Hard Hat 1", 20},
	{19093, "Hard Hat 2", 20},
	{19160, "Hard Hat 3", 20},
	{18639, "Black Hat 1", 20},
	{18640, "Hair 1", 20},
	{18975, "Hair 2", 20},
	{19136, "Hair 4", 20},
	{19274, "Hair 5", 20},
	{18891, "Bandana 1", 20},
	{18892, "Bandana 2", 20},
	{18893, "Bandana 3", 20},
	{18894, "Bandana 4", 20},
	{18895, "Bandana 5", 20},
	{18896, "Bandana 6", 20},
	{18897, "Bandana 7", 20},
	{18898, "Bandana 8", 20},
	{18899, "Bandana 9", 20},
	{18900, "Bandana 10", 20},
	{18901, "Bandana 11", 20},
	{18902, "Bandana 12", 20},
	{18903, "Bandana 13", 20},
	{18904, "Bandana 14", 20},
	{18905, "Bandana 15", 20},
	{18906, "Bandana 16", 20},
	{18907, "Bandana 17", 20},
	{18908, "Bandana 18", 20},
	{18909, "Bandana 19", 20},
	{18910, "Bandana 20", 20},
	{18911, "Mask 1", 20},
	{18912, "Mask 2", 20},
	{18913, "Mask 3", 20},
	{18914, "Mask 4", 20},
	{18915, "Mask 5", 20},
	{18916, "Mask 6", 20},
	{18917, "Mask 7", 20},
	{18918, "Mask 8", 20},
	{18919, "Mask 9", 20},
	{18920, "Mask 10", 20},
	{18921, "Beret 1", 20},
	{18922, "Beret 2", 20},
	{18923, "Beret 3", 20},
	{18924, "Beret 4", 20},
	{18925, "Beret 5", 20},
	{18926, "Hat 1", 20},
	{18927, "Hat 2", 20},
	{18928, "Hat 3", 20},
	{18929, "Hat 4", 20},
	{18930, "Hat 5", 20},
	{18931, "Hat 6", 20},
	{18932, "Hat 7", 20},
	{18933, "Hat 8", 20},
	{18934, "Hat 9", 20},
	{18935, "Hat 10", 20},
	{18936, "Helmet 1", 20},
	{18937, "Helmet 2", 20},
	{18938, "Helmet 3", 20},
	{18939, "Cap Back 1", 20},
	{18940, "Cap Back 2", 20},
	{18941, "Cap Back 3", 20},
	{18942, "Cap Back 4", 20},
	{18943, "Cap Back 5", 20},
	{18944, "Hat Boater 1", 20},
	{18945, "Hat Boater 2", 20},
	{18946, "Hat Boater 3", 20},
	{18947, "Hat Bowler 1", 20},
	{18948, "Hat Bowler 2", 20},
	{18949, "Hat Bowler 3", 20},
	{18950, "Hat Bowler 4", 20},
	{18951, "Hat Bowler 5", 20},
	{19488, "Hat Bowler 6", 20},
	{18952, "Boxing Helmet", 20},
	{18953, "Cap Knit 1", 20},
	{18954, "Cap Knit 2", 20},
	{18955, "Cap Over Eye 1", 20},
	{18956, "Cap Over Eye 2", 20},
	{18957, "Cap Over Eye 3", 20},
	{18958, "Cap Over Eye 4", 20},
	{18959, "Cap Over Eye 5", 20},
	{18960, "Cap Rim Up", 20},
	{18961, "Cap Trucker 1", 20},
	{18962, "Cowboy Hat 2", 20},
	{18964, "Skully Cap 1", 20},
	{18965, "Skully Cap 2", 20},
	{18966, "Skully Cap 3", 20},
	{18967, "Hat Man 1", 20},
	{18968, "Hat Man 2", 20},
	{18969, "Hat Man 3", 20},
	{18970, "Hat Tiger", 20},
	{18971, "Hat Cool 1", 20},
	{18972, "Hat Cool 2", 20},
	{18973, "Hat Cool 3", 20},
	{18645, "Motorcycle Helmet 1", 20},
	{18976, "Motorcycle Helmet 2", 20},
	{18977, "Motorcycle Helmet 3", 20},
	{18978, "Motorcycle Helmet 4", 20},
	{18979, "Motorcycle Helmet 5", 20},
	{19006, "Glasses 1", 20},
	{19007, "Glasses 2", 20},
	{19008, "Glasses 3", 20},
	{19009, "Glasses 4", 20},
	{19010, "Glasses 5", 20},
	{19011, "Glasses 6", 20},
	{19012, "Glasses 7", 20},
	{19013, "Glasses 8", 20},
	{19014, "Glasses 9", 20},
	{19015, "Glasses 10", 20},
	{19016, "Glasses 11", 20},
	{19017, "Glasses 12", 20},
	{19018, "Glasses 13", 20},
	{19019, "Glasses 14", 20},
	{19020, "Glasses 15", 20},
	{19021, "Glasses 16", 20},
	{19022, "Glasses 17", 20},
	{19023, "Glasses 18", 20},
	{19024, "Glasses 19", 20},
	{19025, "Glasses 20", 20},
	{19026, "Glasses 21", 20},
	{19027, "Glasses 22", 20},
	{19028, "Glasses 23", 20},
	{19029, "Glasses 24", 20},
	{19030, "Glasses 25", 20},
	{19031, "Glasses 26", 20},
	{19032, "Glasses 27", 20},
	{19033, "Glasses 28", 20},
	{19034, "Glasses 29", 20},
	{19035, "Glasses 30", 20},
	{19036, "Hockey Mask 1", 20},
	{19037, "Hockey Mask 2", 20},
	{19038, "Hockey Mask 3", 20},
	{19039, "Watch 1", 20},
	{19040, "Watch 2", 20},
	{19041, "Watch 3", 20},
	{19042, "Watch 4", 20},
	{19043, "Watch 5", 20},
	{19044, "Watch 6", 20},
	{19045, "Watch 7", 20},
	{19046, "Watch 8", 20},
	{19047, "Watch 9", 20},
	{19048, "Watch 10", 20},
	{19049, "Watch 11", 20},
	{19050, "Watch 12", 20},
	{19051, "Watch 13", 20},
	{19052, "Watch 14", 20},
	{19053, "Watch 15", 20},
	{19095, "Cowboy Hat 1", 20},
	{19096, "Cowboy Hat 3", 20},
	{19097, "Cowboy Hat 4", 20},
	{19098, "Cowboy Hat 5", 20},
	{19101, "Army Helmet 1", 20},
	{19102, "Army Helmet 2", 20},
	{19103, "Army Helmet 3", 20},
	{19104, "Army Helmet 4", 20},
	{19105, "Army Helmet 5", 20},
	{19106, "Army Helmet 6", 20},
	{19107, "Army Helmet 7", 20},
	{19108, "Army Helmet 8", 20},
	{19109, "Army Helmet 9", 20},
	{19110, "Army Helmet 10", 20},
	{19111, "Army Helmet 11", 20},
	{19112, "Army Helmet 12", 20},
	{19113, "Silly Helmet 1", 20},
	{19114, "Silly Helmet 2", 20},
	{19115, "Silly Helmet 3", 20},
	{19116, "Plain Helmet 1", 20},
	{19117, "Plain Helmet 2", 20},
	{19118, "Plain Helmet 3", 20},
	{19119, "Plain Helmet 4", 20},
	{19120, "Plain Helmet 5", 20},
	{19349, "Monocle", 20},
	{19350, "Moustache 1", 20},
	{19351, "Moustache 2", 20},
	{19352, "Tophat 1", 20},
	{19487, "Tophat 2", 20},
	{19904, "Hi-Vis Vest", 20},
	{18641, "Flashlight", 5},
	{18637, "Riot Shield", 30},
	{11738, "Medic Case", 50},
	{19142, "Police Armour", 50},
	{19521, "High Command Hat", 40},
	{18636, "Police Hat", 30},
	{19161, "Cadet Hat 1", 20},
	{19162, "Cadet Hat 2", 20},
	{19347, "Sheriff Badge", 60},
	{19099, "Sheriff Hat 1", 10},
	{19100, "Sheriff Hat 2", 10},
	{19138, "Black Glasses", 100},
	{19139, "Red Glasses", 100},
	{19140, "Blue Glasses", 100},
	{19141, "SWAT Helmet", 50},
	{11749, "Handcuffs", 10}
};

new AdminVehicle[50] = INVALID_VEHICLE_ID;
new PlayerText:Blind[MAX_PLAYERS], PlayerText:GreenScreen[MAX_PLAYERS], PlayerText:Footer[MAX_PLAYERS];

enum
{
	JOB_NONE,
	JOB_TAXIDRIVER,
	JOB_COURIER,
	JOB_MECHANIC,
	JOB_TRASH,
	JOB_SWEEPER,
	JOB_MINER,
	JOB_BUSDRIVER,
	JOB_FARMER,
	JOB_LUMBERJACK
};

new gJobNames[9][128] =
{
	{"None"},
	{"Taxi Driver"},
	{"Trucker"},
	{"Mechanic"},
	{"Trash Collector"},
	{"Street Sweeper"},
	{"Miner"},
	{"Bus Driver"},
	{"Farmer"}
	//{"Lumberjack"}
};

new Float:gJobLocation[9][3] =
{
	{0.0,0.0,0.0},
	{-142.9149,1079.4022,19.7500},// Taxi
	{622.1021,1225.1176,11.7188},// Trucker
	{-90.0095,1115.8694,19.7422},// Mechanic
	{178.6656,1165.5652,14.7578},// Trash Collector
	{-80.2790,1166.9756,19.7422},// Street Sweeper
	{321.9444,851.5753,20.4063},// Miner
	{23.4988,1232.6945,20.3666},// Bus Driver
	{300.2046, 1141.2954, 9.1463}// Farmer
};

enum
{
	CHECKPOINT_TYPE_NONE = 0,
	CHECKPOINT_TYPE_FIND_PIER,
	CHECKPOINT_TYPE_DMV,
	CHECKPOINT_TYPE_FIND_JOB,
	CHECKPOINT_TYPE_FISHING,
	CHECKPOINT_TYPE_FIND_VEH,
	CHECKPOINT_TYPE_FIND_DEALER,
	CHECKPOINT_TYPE_TRUCK_DELIVER,
	CHECKPOINT_TYPE_TRUCK_COLLECT,
	CHECKPOINT_TYPE_TRASH,
	CHECKPOINT_TYPE_SWEEP,
	CHECKPOINT_TYPE_FARMER,
	CHECKPOINT_TYPE_MINER,
	CHECKPOINT_TYPE_FIND,
	CHECKPOINT_TYPE_BUS,
	CHECKPOINT_TYPE_WEP_BOX,
	CHECKPOINT_TYPE_GPS
};

enum
{
	FACTION_TYPE_NONE = 0,
	FACTION_TYPE_POLICE,
	FACTION_TYPE_MEDICAL,
	FACTION_TYPE_GOVERNMENT,
	FACTION_TYPE_ILLEGAL,
	FACTION_TYPE_OTHER,
	FACTION_TYPE_NEWS
}

// X, Y, Z, A - X, Y, Z, A
new Float:SprayShop[][8] = {
	{-99.0460, 1104.5813, 19.7551, 90.0, -99.8711, 1117.9530, 19.7551, 0.0}, // Fort Carson
	{-1421.3027, 2593.3755, 55.7110, 90.0, -1420.5272, 2584.7324, 55.7110, 0.0} // El Quebrados
};
new SprayShopUsed[2];

/*enum truckEnum
{
    tName[32],
    Float:tPosX,
    Float:tPosY,
    Float:tPosZ
};

new CollectionNames[][128] = 
{
	{"Snake Farm"},
	{"Oil Refinery"},
	{"Goods Factory"},
	{"The Quarry"},
	{"Meat Company"},
	{"Fish Store"},
	{"Redneck Farm"}
};

new Float:CollectionLocations[][3] = 
{
    {-36.1516, 2346.8960, 24.5683},
    {260.0407, 1408.5452, 10.9768},
    {-118.0329, 1137.9639, 20.2365},
    {371.2353, 875.5602, 20.9600},
    {970.1701, 2152.1287, 11.1939},
    {-1248.9766, 1934.3438, 81.3906},
    {311.4090, 1138.0221, 9.0675}
};

new DeliveryNames[][128] = 
{
	{"Fort Carson Hospital"},
	{"Furniture Store"},
	{"Electrical Substation"},
	{"Oil Transit"},
	{"Satellite Facility"},
	{"Camping Site"}
};

new Float:DeliveryLocations[][3] = 
{
    {-334.0978, 1063.0127, 20.2245},
    {-151.0820,1179.1636,20.3503},
    {767.0616,2087.5164,7.3235},
    {643.8387,1240.0183,12.2513},
    {-301.0822,1554.6487,75.9609},
	{-780.3583,1629.6768,27.7156}
};*/

enum teleportEnum 
{
	teleID,
	Float:teleX,
	Float:teleY,
	Float:teleZ,
	Float:teleA,
	teleName[128],
	teleWorld,
	teleInterior,
	teleAddedBy[MAX_PLAYER_NAME+1],
	teleAddedDate[32]
};
new TeleportInfo[MAX_TELEPORTS][teleportEnum],
    Cache:TeleportCache;

new DMVVehicles[3];

new PlayerText:VehicleSpeedo[MAX_PLAYERS],
	Text:ServerCurrentTime;

// Foreach Interators
new Iterator:Mapping<MAX_DYN_OBJECTS>,
	Iterator:Entrances<MAX_ENTRANCE>,
	Iterator:Gates<MAX_GATES>,
	Iterator:Jails<20>,
	Iterator:Dealerships<50>,
	Iterator:GasPumps<100>,
	Iterator:Complexes<10>;

new TeleportHolder[MAX_PLAYERS][MAX_TELEPORTS];

/*new InvalidWords[][128] =
{
	"lol", "lmfao", "noob", "n00b",
	"1337", "brb", "btw", "g2g",
	"gtg", "pce", "omg", "gr8"
};*/

new gAnticheat = true;

// Inventory Types
enum
{
    INV_NONE = 0,
    INV_GUN,
    INV_WEED,
    INV_WEED_SEED,
	INV_COCAINE,
	INV_DRV_LIC,
	INV_WEP_LIC,
	INV_FLY_LIC,
	INV_MED_KIT,
	INV_ARMOUR,
	INV_PHONE,
	INV_RADIO,
	INV_FISH,
	INV_PIZZA,
	INV_BOOMBOX,
	INV_SPRUNK,
	INV_CIG
};