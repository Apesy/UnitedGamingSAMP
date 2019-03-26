/*
------------------------------------------------------------------------------
						Script Developed by Sean McElholm
					Based on MySQL R40 Cache Login Registration

* 3rd Party Credits:
	Y_Less - Foreach and YSI
	Incognito - Streamer
	YourShadow - Pawn.CMD
	d0 - mSelection
	_Emmet - Callbacks
	BlueG - MySQL Plugin
	Gammix - Attachments
	Maddinat0r - Discord Connector
	Zeex - CrashDetect
	RogueDrifter - Anticheat Pack
------------------------------------------------------------------------------
*/
#include 	<a_samp>

// Check if IsValidVehicle exists, if not then define it.
#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

// Check if gpci exists, if not then define it.
#if !defined gpci
    native gpci(playerid, serial[], len);
#endif

// No need to touch this, as it does nothing really.
#define		SERVER_GM_TEXT		"UG-RP"

// Server Info
#define		SERVER_WEBSITE		"dc-rp.com"
#define		SERVER_TEAMSPEAK	"dc-rp.com"
#define		SERVER_DISCORD		"www.sa-mp.com"

#define function%0(%1) forward%0(%1); public%0(%1)

// change MAX_PLAYERS to the amount of players (slots) you want
// It is by default 1000 (as of 0.3.7)
#undef	  	MAX_PLAYERS
#define	 	MAX_PLAYERS			100

#undef INVALID_TEXT_DRAW
#define INVALID_TEXT_DRAW (Text:0xFFFF)

#define     ManualUse // Do not remove this, it's required for the AntiCheat.
#define		PROFILE_BUILD
//#define		DEBUG_BUILD

// Fixes
#define 	FIXES_ServerVarMsg 	0
#include 	<fixes>

// Anticheat Includes - These go first, according to the instructions.
#include 	<Anti_cheat_pack>

// Plugin Headers
#include 	<a_mysql>
#include 	<crashdetect>
#include 	<streamer>
#include 	<Pawn.CMD>
#include 	<sscanf2>
#include 	<discord-connector>

#if defined PROFILE_BUILD
	#include <plugin_profiler>
#endif

// Non Plugin Headers
#include 	<YSI\y_timers>
#include 	<YSI\y_hooks>
#include 	<mSelection>
#include 	<callbacks>
#include 	<attachments>
#include 	<evi>
#include 	<rEac>
#include 	<mapandreas>

#include 	<libdcrp>

// Do not change the include order as it may cause compiling errors.
#include 	"./Source/Utility/defines.pwn"
#include 	"./Source/Utility/timefunc.pwn"
#include 	"./Source/Utility/number.pwn"
#include 	"./Source/Core/variables.pwn"
#include 	"./Source/Chat/announce.pwn"
#include 	"./Source/Properties/rental.pwn"
#include 	"./Source/Core/vehicle.pwn"
#include 	"./Source/Core/modshop.pwn"
#include 	"./Source/Core/mysql.pwn"

#include 	"./Source/Core/proxy.pwn"
#include 	"./Source/Core/fire.pwn"
#include 	"./Source/Core/damages.pwn"
#include 	"./Source/Core/camp_fire.pwn"
#include 	"./Source/Character/nametag.pwn"

#include 	"./Source/Properties/House.pwn"
#include 	"./Source/Properties/furniture.pwn"
#include 	"./Source/Properties/business.pwn"

#include 	"./Source/Boombox/boombox.pwn"
#include 	"./Source/Boombox/xmr.pwn"

#include 	"./Source/Core/gaspumps.pwn"
#include 	"./Source/Properties/entrance.pwn"
#include 	"./Source/Properties/doors.pwn"
#include 	"./Source/Properties/dealership.pwn"
#include 	"./Source/Properties/complex.pwn"
#include 	"./Source/mapping/payphones.pwn"
#include 	"./Source/Core/drugs.pwn"
#include 	"./Source/Character/inventory.pwn"
#include 	"./Source/Properties/atm.pwn"
#include 	"./Source/Core/labels.pwn"
#include 	"./Source/Core/trash.pwn"

#include 	"./Source/Jobs/fishing.pwn"

#include 	"./Source/mapping/CoreMap.pwn"
#include 	"./Source/mapping/police.pwn"
#include 	"./Source/mapping/street.pwn"

#include 	"./Source/Utility/message.pwn"
#include 	"./Source/Utility/name.pwn"
#include 	"./Source/Utility/FileHandle.pwn"
#include 	"./Source/Utility/logging.pwn"

#include 	"./Source/Character/anim.pwn"

#include 	"./Source/Core/phone.pwn"

#include 	"./Source/Faction/Faction.pwn"
#include 	"./Source/Faction/blackmarket.pwn"
#include 	"./Source/Faction/locker_wep.pwn"
#include 	"./Source/Faction/locker_skins.pwn"
#include 	"./Source/Faction/Government.pwn"
#include 	"./Source/Faction/Police.pwn"
#include 	"./Source/Faction/mdc.pwn"
#include 	"./Source/Faction/bolo.pwn"
#include 	"./Source/Faction/roadblocks.pwn"
#include 	"./Source/Faction/spikes.pwn"
#include 	"./Source/Faction/jailpos.pwn"
#include 	"./Source/Faction/news.pwn"
#include 	"./Source/Faction/illegal.pwn"

#include 	"./Source/Core/timers.pwn"
#include 	"./Source/Character/CharacterCreation.pwn"
#include 	"./Source/Core/callbacks.pwn"
#include 	"./Source/Core/gamemode.pwn"
#include 	"./Source/Core/login.pwn"
#include 	"./Source/Core/weapon.pwn"

#include 	"./Source/Advertising/advertisement.pwn"


#include 	"./Source/Chat/chat.pwn"
#include 	"./Source/Chat/announce.pwn"
#include 	"./Source/Chat/emote.pwn"
#include 	"./Source/Chat/ooc.pwn"

#include 	"./Source/Core/general.pwn"
#include 	"./Source/Core/setplayer.pwn"

#include 	"./Source/Character/damages.pwn"

#include 	"./Source/Admin/mapper.pwn"
#include 	"./Source/Admin/tester.pwn"
#include 	"./Source/Admin/staff.pwn"
#include 	"./Source/Admin/spectate.pwn"
#include 	"./Source/Admin/ajail.pwn"
#include 	"./Source/Admin/admin.pwn"
#include 	"./Source/Admin/report.pwn"
#include 	"./Source/Admin/ban.pwn"
#include 	"./Source/Admin/helper.pwn"
#include 	"./Source/Admin/helpme.pwn"
#include 	"./Source/Weapons/weapondrop.pwn"
#include 	"./Source/Core/discord.pwn"

#include 	"./Source/AntiCheat/anticheat.pwn"

#include 	"./Source/Core/payday.pwn"

#include 	"./Source/Character/LoadCharacter.pwn"
#include 	"./Source/Core/location.pwn"
#include 	"./Source/Character/clothing.pwn"

#include 	"./Source/Core/radio.pwn"

#include 	"./Source/Interiors/HouseInts.pwn"
#include 	"./Source/Interiors/Nightclub.pwn"
#include 	"./Source/Interiors/Apartment.pwn"
#include 	"./Source/Interiors/MobInterior.pwn"

#include 	"./Source/Jobs/JobCore.pwn"
#include 	"./Source/Jobs/taxi.pwn"
#include 	"./Source/Jobs/trucker.pwn"
#include 	"./Source/Jobs/mechanic.pwn"
#include 	"./Source/Admin/mapping.pwn"
#include 	"./Source/Core/donate.pwn"
#include 	"./Source/Jobs/sweeper.pwn"
#include 	"./Source/Jobs/farmer.pwn"
#include 	"./Source/Jobs/trash.pwn"
#include 	"./Source/Jobs/miner.pwn"
#include 	"./Source/Jobs/bus_driver.pwn"

#include 	"./Source/Core/teleports.pwn"
#include 	"./Source/Core/restaurant.pwn"


main() 
{
	print("-------------------------------------------");
	print("United Gaming Roleplay");
	print("Copyright (C) 2019 United Gaming LLC");
	print("All Rights Reserved");
	printf("Compiled: %s %s", __date, __time);
	print("-------------------------------------------");
}

public OnGameModeInit()
{
	new initTick = GetTickCount();
	print("[SERVER]: Starting Gamemode...");
	MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL);

	// MySQL init
	SQL_Init();

	SetGameModeText(SERVER_GM_TEXT);
	//ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	ShowNameTags(0);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	//SetNameTagDrawDistance(15.0);
	Streamer_TickRate(100);

	ManualVehicleEngineAndLights();

	gettime(ServerInfo[CurrentHour], ServerInfo[CurrentMinute], ServerInfo[CurrentSecond]);

	RandomWeather();

	// if the table has been created, the "SetupPlayerTable" function does not have any purpose so you may remove it completely
	SetupPlayerTable();

	print("[SYSTEM]: Loading skins...");
	maleList = LoadModelSelectionMenu("males.skn");
	femaleList = LoadModelSelectionMenu("females.skn");
	BuyList = LoadModelSelectionMenu("buy.skn");

	print("[SYSTEM]: Loading Settings...");
	LoadSettings();
	print("[SYSTEM]: Loading factions...");
	LoadFactions();
	print("[SYSTEM]: Loading vehicles...");
	LoadVehicles();
	print("[SYSTEM]: Loading mapping...");
	LoadMapping();
	print("[SYSTEM]: Loading houses...");
	LoadHouses();
	print("[SYSTEM]: Loading businesses...");
	LoadBusinesses();
	print("[SYSTEM]: Loading entrances...");
	LoadEntrance();
	print("[SYSTEM]: Loading gates...");
	LoadGates();
	print("[SYSTEM]: Loading jails...");
	LoadJails();
	print("[SYSTEM]: Loading dealership...");
	LoadDealership();
	print("[SYSTEM]: Loading gas pumps...");
	LoadGasPumps();
	print("[SYSTEM]: Loading streets...");
	LoadStreets();
	print("[SYSTEM]: Loading graffiti...");
	LoadGraffiti();
	print("[SYSTEM]: Loading complex...");
	LoadComplexes();
	print("[SYSTEM]: Loading teleports...");
	LoadTeleports();
	print("[SYSTEM]: Loading weed...");
	LoadWeeds();
	print("[SYSTEM]: Loading atm...");
	LoadATMs();
	print("[SYSTEM]: Loading rental vehicles...");
	LoadRentalVehicles();
	print("[SYSTEM]: Loading trucker pos...");
	LoadTruckerPositions();
	print("[SYSTEM]: Loading sweeper veh...");
	LoadSweeperVehicles();
	print("[SYSTEM]: Loading pbolo...");
	LoadPBolos();
	print("[SYSTEM]: Loading vbolo...");
    LoadVBolos();
	print("[SYSTEM]: Loading garbage...");
	LoadGarbages();
	print("[SYSTEM]: Loading fac wep...");
	LoadFactionWeapons();
	print("[SYSTEM]: Loading black market...");
	LoadBlackMarkets();
	print("[SYSTEM]: Loading fac skins...");
	LoadFactionSkins();
	print("[SYSTEM]: Loading furniture...");
	LoadFurniture();
	print("[SYSTEM]: Loading radio station...");
	LoadRadioStations();

	print("[SYSTEM]: Reset Vehicle...");
	for (new x = 0; x < MAX_VEHICLES; x++)
	{
		LightPwr[x] = 1;
		Flasher[x] = 0;
		FlasherState[x] = 0;
		SetVehicleParamsCarWindows(x, 1, 1, 1, 1);
		SetVehicleParamsEx(x, 0, 0, 0, 0, 0, 0, 0);//Reset all these params to 0.
		CoreVehicle[x][VehicleFuel] = 100.0;
		CoreVehicle[x][TrashAmount] = 0;
		CoreVehicle[x][RadioURL][0] = 0;
	}

	print("[SYSTEM]: Loading Pickups and 3D Text Labels...");
	for(new i; i < sizeof(SprayShop); i++)
	{
		CreateDynamic3DTextLabel("Pay & Spray\n{FFFFFF}Type {33AA33}/enter{FFFFFF} to enter", 0x33AA33FF, SprayShop[i][0], SprayShop[i][1], SprayShop[i][2]+0.50, 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 50.0);
		CreateDynamicPickup(1318, 1, SprayShop[i][0], SprayShop[i][1], SprayShop[i][2]);
	}

	CreateDynamic3DTextLabel("Fort Carson Town Hall\n{FFFFFF}/payfine, /signcheque", 0x33AA33FF, 1346.8292, 1571.4750, -13.5820+0.50, 20.0);
	CreateDynamicPickup(1239, 1, 1346.8292, 1571.4750, -13.5820);

	print("[SYSTEM]: Loading payphones...");
	InitPayphones();

	print("[SYSTEM]: Loading static maps...");
	LoadStaticMaps();
	LoadBlankHouseInteriors();

	AddPlayerClass(1, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z, DEFAULT_POS_A, 0, 0, 0, 0, 0, 0);

	AnimText = TextDrawCreate(435.000000, 426.000000, "Press ~r~~k~~PED_SPRINT~~w~ to stop animation");
	TextDrawBackgroundColor(AnimText, 255);
	TextDrawFont(AnimText, 2);
	TextDrawLetterSize(AnimText, 0.260000, 1.299999);
	TextDrawColor(AnimText, -1);
	TextDrawSetOutline(AnimText, 1);
	TextDrawSetProportional(AnimText, 1);

	SendRconCommand("conncookies 1");
	SendRconCommand("cookielogging 1");
	SendRconCommand("chatlogging 0");

	LoadFishingPier();
	Init_Jobs();

	gAnticheat = true;

	print("[SYSTEM]: Set streamer settings...");
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 1000);
	Streamer_SetTickRate(20);

	new str[128];
	SendRconCommand("mapname Bone County");

	format(str, sizeof str, "weburl %s", ServerInfo[ServerWebsite]);
	SendRconCommand(str);
	SendRconCommand("language English");

	format(str, sizeof str, "hostname %s", ServerInfo[ServerName]);
	SendRconCommand(str);

	gettime(.hour = ServerInfo[CurrentHour], .minute = ServerInfo[CurrentMinute], .second = ServerInfo[CurrentSecond]);
	SetWorldTime(ServerInfo[CurrentHour]);

	if(strlen(SERVER_PASSWORD) > 0)
	{
		format(str, sizeof str, "password %s", SERVER_PASSWORD);
		SendRconCommand(str);
	}
	else SendRconCommand("password 0");

	if(strlen(ServerInfo[ServerRevision]) > 0)
	{
		format(str, sizeof str, "DC-RP %s", ServerInfo[ServerRevision]);
		SetGameModeText(str);
	}
	else SetGameModeText("DC-RP");
	printf("Gamemode Round Started: %s (Tick: %d)", GetDateTime(), GetTickCount()-initTick);
	return 1;
}

stock RandomWeather()
{
	new randWeather = random(21);
	switch(randWeather)
	{
		case 0, 1, 2, 3, 4:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Clear Skies with temperatures of 40 celcius / 100 farenheit.");
			ServerInfo[GlobalWeather] = 0;
		}
		case 5, 6, 7, 8:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Clear Skies with temperatures of 20 celcius / 70 farenheit.");
			ServerInfo[GlobalWeather] = 1;
		}
		case 9, 10, 11, 12:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Slight Clouds, Temperatures of 30 celcius / 85 farenheit.");
			ServerInfo[GlobalWeather] = 2;
		}
		case 13, 14, 15, 16:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Slight Clouds, Temperatures of 20 celcius / 70 farenheit.");
			ServerInfo[GlobalWeather] = 3;
		}
		case 17, 18:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Sand Storm, take extra precaution.");
			ServerInfo[GlobalWeather] = 19;
		}
		case 19:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Heavy Fog, take extra precaution.");
			ServerInfo[GlobalWeather] = 9;
		}
		case 20:
		{
			SendClientMessageToAllEx(COLOR_ORANGE, "[Weather Report] Heavy Rain, take extra precaution.");
			ServerInfo[GlobalWeather] = 8;
		}
	}
	foreach(new i: Player)
	{
		if(GetPlayerInterior(i) == 0)
		{
			SetPlayerWeather(i, ServerInfo[GlobalWeather]);
		}
	}
}

public OnGameModeExit()
{
	return 1;
}

//-----------------------------------------------------