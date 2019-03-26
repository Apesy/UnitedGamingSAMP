//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/*#define SendTeleportMessage(%s) \
	SendClientMessage(%0, COLOR_GREY, "You have been teleported.")*/

#define SendDebugMessage(%1) printf("[Debug] "%1)


// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	60

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1958.3783
#define 	DEFAULT_POS_Y 		1343.1572
#define 	DEFAULT_POS_Z 		15.3746
#define 	DEFAULT_POS_A 		270.1425

#define     MAX_REPORTS         50
#define     MAX_MARK_POS        2
#define     MAX_CHARACTERS      5
#define		MAX_PVEH			10
#define		MAX_FACTIONS		30
#define		MAX_FACTION_RANKS	21
//#define		MAX_BOLO			50
#define		MAX_DYN_OBJECTS		1000
#define 	MAX_ZONE_NAME 		28
#define     MAX_HOUSES      	1000
#define		MAX_HOUSE_WEP		21
#define     MAX_BIZ      		1000
#define     MAX_ENTRANCE      	500
#define		MAX_GATES			100
#define		MAX_DYN_VEH			1000 //Max Dyn Veh cannot go above 2000.
#define 	MAX_INDEX 			16
#define		MAX_ACCESSORIES		5

/*#define		GiveMoney(%1,%2)	PlayerInfo[%1][pMoney] += %2
#define		TakeMoney(%1,%2)	PlayerInfo[%1][pMoney] -= %2*/

#define		GetFaction(%1)		GetFactionName(PlayerInfo[%1][pFaction])

#define		PLAYER_ALIVE		1
#define		PLAYER_WOUNDED		2
#define		PLAYER_DEAD			3

#define 	SLOT_WEAPON 		5
#define 	SLOT_HANDCUFF 		6
#define 	SLOT_PHONE 			7
#define 	SLOT_INV_ITEM 		8
#define 	SLOT_MISC 			9

#define		MAX_PING			500
#define		MAX_AFK				10
#define		MAX_XMR_CATEGORY	40
#define		MAX_XMR_CATEGORY_STATIONS 60
#define 	MAX_TELEPORTS 		100

#define		DISCORD_STAFF		0
#define		DISCORD_ADMIN		1
#define		DISCORD_LEAD		2
#define		DISCORD_HELPER		3
#define		DISCORD_WARNING		4

#define SELECT_TYPE_EDIT_FURNITURE		1
#define SELECT_TYPE_DELETE_SPIKE		2
#define SELECT_TYPE_EDIT_SPIKE			3
#define SELECT_TYPE_DELETE_ROADBLOCK	4
#define SELECT_TYPE_EDIT_ROADBLOCK		5
#define SELECT_TYPE_EDIT_MAPPING		6
#define SELECT_TYPE_DELETE_MAPPING		7
#define SELECT_TYPE_DUP_MAPPING			8
#define SELECT_TYPE_SELL_FURNITURE		9

#define EDIT_TYPE_EDIT_FURNITURE		1
#define EDIT_TYPE_BUY_FURNITURE			2
#define EDIT_TYPE_EDIT_ROADBLOCK		3
#define EDIT_TYPE_GATE_OPENPOS			4
#define EDIT_TYPE_GATE_CLOSEDPOS		5
#define EDIT_TYPE_EDIT_MAPPING			6
#define	EDIT_TYPE_PRIMARY_WEP			7
#define	EDIT_TYPE_GAS_PUMP				8
#define	EDIT_TYPE_ACCESSORY				9
#define	EDIT_TYPE_BUY_ACCESSORY			10
#define EDIT_TYPE_TRASH					11
#define EDIT_TYPE_GRAFFITI				12
#define EDIT_TYPE_WEED					13
#define EDIT_TYPE_ATM					14
#define EDIT_TYPE_EDIT_SPIKES			15
#define EDIT_TYPE_BOOMBOX				16
#define EDIT_TYPE_GARBAGE				17

#define BODY_PART_CHEST 				3
//#define BODY_PART_GROIN 				4
#define BODY_PART_LEFTARM 				5
#define BODY_PART_RIGHTARM 				6
#define BODY_PART_LEFTLEG 				7
#define BODY_PART_RIGHTLEG 				8
//#define BODY_PART_HEAD 					9