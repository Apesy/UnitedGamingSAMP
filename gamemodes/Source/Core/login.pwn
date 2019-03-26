//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

forward OnPlayerDataLoaded(playerid, race_check);
public OnPlayerDataLoaded(playerid, race_check)
{
	/*	race condition check:
		player A connects -> SELECT query is fired -> this query takes very long
		while the query is still processing, player A with playerid 2 disconnects
		player B joins now with playerid 2 -> our laggy SELECT query is finally finished, but for the wrong player

		what do we do against it?
		we create a connection count for each playerid and increase it everytime the playerid connects or disconnects
		we also pass the current value of the connection count to our OnPlayerDataLoaded callback
		then we check if current connection count is the same as connection count we passed to the callback
		if yes, everything is okay, if not, we just kick the player
	*/
	if (race_check != g_MysqlRaceCheck[playerid])
	{
		SendErrorMessage(playerid, "Invalid race condition check, please relog.");
		DelayedKick(playerid);
		return 1;
	}

	if(cache_num_rows() > 0)
	{
		// we store the password and the salt so we can compare the password the player inputs
		// and save the rest so we won't have to execute another query later
		cache_get_value(0, "password", Player[playerid][Password], 65);
		cache_get_value(0, "salt", Player[playerid][Salt], 17);
		cache_get_value(0, "SecretWord", Player[playerid][SecretWord], 65);
		cache_get_value(0, "StoredIP", Player[playerid][StoredIP], 128);
		cache_get_value(0, "StoredGPCI", Player[playerid][StoredGPCI], 128);

		// saves the active cache in the memory and returns an cache-id to access it for later use
		Player[playerid][Cache_ID] = cache_save();

		ShowLoginDialog(playerid);
	}
	else
	{
		ShowRegisterDialog(playerid);
	}
	return 1;
}

stock ShowRegisterDialog(playerid)
{
	new string[128];
	format(string, sizeof string, "Welcome to United Gaming Roleplay, %s.\n\n\
	You can register by entering your password in the field below.", Player[playerid][Name]);
	Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", string, "Register", "Abort");
	return 1;
}

stock ShowLoginDialog(playerid)
{
	new string[144];
	format(string, sizeof string, "Welcome back to United Gaming Roleplay, %s\n\n\
	Please enter your password in the field below.\n\
	You have 30 seconds to login.", Player[playerid][Name]);
	Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Abort");

	if(!Player[playerid][LoginTimer])
	{
		Player[playerid][LoginTimer] = SetTimerEx("OnLoginTimeout", SECONDS_TO_LOGIN * 1000, false, "d", playerid);
	}
	return 1;
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);

	if (strlen(inputtext) <= 5) return Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Your password must be longer than 5 characters!\nPlease enter your password in the field below:", "Register", "Abort");

	// 16 random characters from 33 to 126 (in ASCII) for the salt
	for (new i = 0; i < 16; i++) Player[playerid][Salt][i] = random(94) + 33;
	SHA256_PassHash(inputtext, Player[playerid][Salt], Player[playerid][Password], 65);

	new query[221];
	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `players` (`username`, `password`, `salt`) VALUES ('%e', '%e', '%e')", Player[playerid][Name], Player[playerid][Password], Player[playerid][Salt]);
	mysql_tquery(g_SQL, query, "OnPlayerRegister", "d", playerid);
	return 1;
}

function OnPlayerRegister(playerid)
{
	// retrieves the ID generated for an AUTO_INCREMENT column by the sent query
	Player[playerid][ID] = cache_insert_id();

	TempVar[playerid][IsLoggedIn] = true;
	Player[playerid][PassedTest] = 0;
	Player[playerid][PassedTutorial] = 0;
	Player[playerid][LastActive] = gettime();

	SecretWordDialog(playerid);
	return 1;
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);

	if(isnull(inputtext))
		return ShowLoginDialog(playerid);

	new hashed_pass[65], query[128];
	SHA256_PassHash(inputtext, Player[playerid][Salt], hashed_pass, 65);

	if (strcmp(hashed_pass, Player[playerid][Password]) == 0)
	{
		cache_set_active(Player[playerid][Cache_ID]);

		AssignPlayerData(playerid);

		// remove the active cache from memory and unsets the active cache as well
		cache_delete(Player[playerid][Cache_ID]);
		Player[playerid][Cache_ID] = MYSQL_INVALID_CACHE;


		KillTimer(Player[playerid][LoginTimer]);
		Player[playerid][LoginTimer] = 0;
		TempVar[playerid][IsLoggedIn] = true;
		mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `IsLoggedIn` = 1 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
		mysql_tquery(g_SQL, query);

		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `bans` WHERE `AccountID` = '%d' LIMIT 1", Player[playerid][ID]);
		mysql_tquery(g_SQL, query, "OnCheckLoginBan", "d", playerid);

		// Check for account ID ban
		// sets the specified cache as the active cache so we can retrieve the rest player data
	}
	else
	{
		Player[playerid][LoginAttempts]++;

		if (Player[playerid][LoginAttempts] >= 3)
		{
			Dialog_Show(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have mistyped your password too often (3 times).", "Okay", "");
			DelayedKick(playerid);
		}
		else ShowLoginDialog(playerid);
	}
	return 1;
}

forward OnLoginTimeout(playerid);
public OnLoginTimeout(playerid)
{
	// reset the variable that stores the timerid
	Player[playerid][LoginTimer] = 0;
	
	Dialog_Show(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been kicked for taking too long to login successfully to your account.", "Okay", "");
	DelayedKick(playerid);
	return 1;
}

Dialog:DIALOG_SECRETWORD_LOGIN(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);

	if (strlen(inputtext) <= 5)
	{
		Dialog_Show(playerid, DIALOG_SECRETWORD_LOGIN, DIALOG_STYLE_PASSWORD, "Secret Word", "{FFFFFF}SECURITY PRECAUTION:\n\n\
		SERVER: Your secret word must be more than 5 characters long!\n\
		We have introduced a SECRET CONFIRMATION CODE system to help protect user accounts. This is basically a word that will be presented if any connection conditions change.\n\nYou will have to remember this.\n\n\
		{F81414}This should {FFFF00}NOT{F81414} be the same as your password.", "Enter", "Cancel");
		return 1;
	}
	SHA256_PassHash(inputtext, Player[playerid][Salt], Player[playerid][SecretWord], 65);

	new query[221];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `SecretWord` = '%e' WHERE `id` = %d LIMIT 1", Player[playerid][SecretWord], Player[playerid][ID]);
	mysql_tquery(g_SQL, query, "OnSecretWordLogin", "d", playerid);
	return 1;
}

function OnSecretWordLogin(playerid)
{
	SendServerMessage(playerid, "Secret Word added sucessfully.");
	ShowCharacterMenu(playerid);
	return 1;
}

stock SecretWordDialog(playerid)
{
	Dialog_Show(playerid, DIALOG_SECRETWORD_CREATE, DIALOG_STYLE_PASSWORD, "Secret Word", "{FFFFFF}SECURITY PRECAUTION:\n\n\
		SERVER: Your secret word must be more than 5 characters long!\n\
		We have introduced a SECRET CONFIRMATION CODE system to help protect user accounts. This is basically a word that will be presented if any connection conditions change.\n\nYou will have to remember this.\n\n\
		{F81414}This should {FFFF00}NOT{F81414} be the same as your password.", "Enter", "Cancel");
}

Dialog:DIALOG_SECRETWORD_CREATE(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);

	if (strlen(inputtext) <= 5)
	{
		SecretWordDialog(playerid);
		return 1;
	}
	SHA256_PassHash(inputtext, Player[playerid][Salt], Player[playerid][SecretWord], 65);

	new query[221];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `SecretWord` = '%e' WHERE `id` = %d LIMIT 1", Player[playerid][SecretWord], Player[playerid][ID]);
	mysql_tquery(g_SQL, query, "OnSecretWord", "d", playerid);
	return 1;
}

function OnSecretWord(playerid)
{
	Player[playerid][PassedTutorial] = 0;
	Player[playerid][IsLoggedIn] = true;
	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `IsLoggedIn` = 1 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
	mysql_tquery(g_SQL, query);
	if(Player[playerid][PassedTest] == 0)
	{
		ClearChat(playerid, 20);
		SendClientMessage(playerid, COLOR_YELLOW2, "Question 1: What is RP?");
		Dialog_Show(playerid, RP_TEST_1, DIALOG_STYLE_LIST, "What is RP?", "Rockers Paradise\nRoleplay\nRaster Pixel", "Continue", "Cancel");
		return 1;
	}
	StartCharacterCreation(playerid);
	return 1;
}

forward _KickPlayerDelayed(playerid);
public _KickPlayerDelayed(playerid)
{
	Kick(playerid);
	return 1;
}


//-----------------------------------------------------

AssignPlayerData(playerid)
{
	cache_get_value_int(0, "id", Player[playerid][ID]);
	
	cache_get_value_int(0, "kills", Player[playerid][Kills]);
	cache_get_value_int(0, "deaths", Player[playerid][Deaths]);
	
	cache_get_value_float(0, "x", Player[playerid][X_Pos]);
	cache_get_value_float(0, "y", Player[playerid][Y_Pos]);
	cache_get_value_float(0, "z", Player[playerid][Z_Pos]);
	cache_get_value_float(0, "angle", Player[playerid][A_Pos]);
	cache_get_value_int(0, "interior", Player[playerid][Interior]);
    cache_get_value_int(0, "AdminLevel", Player[playerid][AdminLevel]);
	SetPVarInt(playerid, "AdminLevel", Player[playerid][AdminLevel]);
	cache_get_value_int(0, "HelperLevel", Player[playerid][HelperLevel]);
	cache_get_value_int(0, "ChangePassword", Player[playerid][ChangePassword]);

	cache_get_value_int(0, "OfflineJailed", Player[playerid][OfflineJailed]);
	cache_get_value_int(0, "OfflineJailTime", Player[playerid][OfflineJailTime]);
	cache_get_value(0, "OfflineJailReason", Player[playerid][OfflineJailReason], 128);
	cache_get_value(0, "OfflineJailAdmin", Player[playerid][OfflineJailAdmin], MAX_PLAYER_NAME);

	cache_get_value_int(0, "DonateLevel", Player[playerid][DonateLevel]);
	cache_get_value_int(0, "DonateExpire", Player[playerid][DonateExpire]);
	cache_get_value_int(0, "Ajailed", Player[playerid][Ajailed]);
	cache_get_value_int(0, "AjailTime", Player[playerid][AjailTime]);
	cache_get_value(0, "AjailReason", Player[playerid][AjailReason], 128);
	cache_get_value(0, "AjailedBy", Player[playerid][AjailedBy], MAX_PLAYER_NAME+1);
	cache_get_value_int(0, "PassedTest", Player[playerid][PassedTest]);
	cache_get_value_int(0, "PassedTutorial", Player[playerid][PassedTutorial]);
	cache_get_value_int(0, "BetaTester", Player[playerid][BetaTester]);
	cache_get_value_int(0, "Mapper", Player[playerid][Mapper]);
	cache_get_value_int(0, "HelpmeMutes", Player[playerid][HelpmeMutes]);
	cache_get_value_int(0, "HelpmeMuted", Player[playerid][HelpmeMuted]);
	cache_get_value_int(0, "LastActive", Player[playerid][LastActive]);
	cache_get_value_int(0, "RegisterDate", Player[playerid][RegisterDate]);
	cache_get_value(0, "StoredIP", Player[playerid][StoredIP], 128);
	cache_get_value(0, "StoredGPCI", Player[playerid][StoredGPCI], 128);
	cache_get_value_int(0, "NameChanges", Player[playerid][NameChanges]);
	cache_get_value_int(0, "NameChanges", Player[playerid][NameChanges]);
	cache_get_value_int(0, "NumberChanges", Player[playerid][NumberChanges]);
	cache_get_value_int(0, "BMXPermission", Player[playerid][WeaponBan]);
	cache_get_value_int(0, "PlayingHours", Player[playerid][PlayingHours]);
	return 1;
}

stock DelayedKick(playerid, time = 500)
{
	TempVar[playerid][BeingKicked] = true;
	SetTimerEx("_KickPlayerDelayed", time, false, "d", playerid);
	return 1;
}

function UpdatePlayerData(playerid)
{
	if (Player[playerid][IsLoggedIn] == false) return 0;

	// if the client crashed, it's not possible to get the player's position in OnPlayerDisconnect callback
	// so we will use the last saved position (in case of a player who registered and crashed/kicked, the position will be the default spawn point)
	GetPlayerPos(playerid, Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos]);
	GetPlayerFacingAngle(playerid, Player[playerid][A_Pos]);
	
	new query[256];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `x` = %f, `y` = %f, `z` = %f, `angle` = %f, `interior` = %d WHERE `id` = %d LIMIT 1", 
	Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos], Player[playerid][A_Pos], GetPlayerInterior(playerid), Player[playerid][ID]);
	mysql_tquery(g_SQL, query);
	
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `AdminLevel` = %d, `HelperLevel` = %d WHERE `id` = %d LIMIT 1", 
	Player[playerid][AdminLevel], Player[playerid][HelperLevel], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `DonateLevel` = %d, `DonateExpire` = %d WHERE `id` = %d LIMIT 1", 
	Player[playerid][DonateLevel], Player[playerid][DonateExpire], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `Ajailed` = %d, `AjailTime` = %d, `AjailReason` = '%e', `AjailedBy` = '%e' WHERE `id` = %d LIMIT 1", 
	Player[playerid][Ajailed], Player[playerid][AjailTime], Player[playerid][AjailReason], Player[playerid][AjailedBy], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `PassedTest` = %d, `PassedTutorial` = %d, `BetaTester` = %d, `Mapper` = %d, `LastActive` = %d, `StoredIP` = '%e' WHERE `id` = %d LIMIT 1", 
	Player[playerid][PassedTest], Player[playerid][PassedTutorial], Player[playerid][BetaTester], Player[playerid][Mapper], Player[playerid][LastActive], Player[playerid][StoredIP], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `HelpmeMutes` = %d, `HelpmeMuted` = %d, `StoredGPCI` = '%e', `RegisterDate` = %d WHERE `id` = %d LIMIT 1", 
	Player[playerid][HelpmeMutes], Player[playerid][HelpmeMuted], Player[playerid][StoredGPCI], Player[playerid][RegisterDate], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `NameChanges` = %d, `NumberChanges` = %d, `BMXPermission` = %d, `PlayingHours` = %d WHERE `id` = %d LIMIT 1", 
	Player[playerid][NameChanges], Player[playerid][NumberChanges], Player[playerid][WeaponBan], Player[playerid][PlayingHours], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

stock IsWeaponRestricted(playerid)
{
	if(Player[playerid][WeaponBan])
	{
		return 1;
	}
	return 0;
}

UpdatePlayerDeaths(playerid)
{
	if (Player[playerid][IsLoggedIn] == false) return 0;
	
	Player[playerid][Deaths]++;
	
	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `deaths` = %d WHERE `id` = %d LIMIT 1", Player[playerid][Deaths], Player[playerid][ID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

UpdatePlayerKills(killerid)
{
	// we must check before if the killer wasn't valid (connected) player to avoid run time error 4
	if (killerid == INVALID_PLAYER_ID) return 0;
	if (Player[killerid][IsLoggedIn] == false) return 0;
	
	Player[killerid][Kills]++;
	
	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `kills` = %d WHERE `id` = %d LIMIT 1", Player[killerid][Kills], Player[killerid][ID]);
	mysql_tquery(g_SQL, query);
	return 1;
}

SetupPlayerTable()
{
	//mysql_tquery(g_SQL, "CREATE TABLE IF NOT EXISTS `players` (`id` int(11) NOT NULL AUTO_INCREMENT,`username` varchar(24) NOT NULL,`password` char(64) NOT NULL,`salt` char(16) NOT NULL,`kills` mediumint(8) NOT NULL DEFAULT '0',`deaths` mediumint(8) NOT NULL DEFAULT '0',`x` float NOT NULL DEFAULT '0',`y` float NOT NULL DEFAULT '0',`z` float NOT NULL DEFAULT '0',`angle` float NOT NULL DEFAULT '0',`interior` tinyint(3) NOT NULL DEFAULT '0', PRIMARY KEY (`id`), UNIQUE KEY `username` (`username`))");
	return 1;
}

CMD:changepass(playerid, params[])
{
	Dialog_Show(playerid, ChangeUserPass, DIALOG_STYLE_PASSWORD, "Change Password", "Enter your current password.", "Enter", "Exit");
	return 1;
}

Dialog:ChangeUserPass(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	if(isnull(inputtext))
		return Dialog_Show(playerid, ChangeUserPass, DIALOG_STYLE_PASSWORD, "Change Password", "Enter your current password.", "Enter", "Exit");
	
	return Dialog_Show(playerid, ChangeUserPassStep2, DIALOG_STYLE_PASSWORD, "Change Password", "Enter your new password.", "Enter", "Exit");
}

Dialog:ChangeUserPassStep2(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	if(isnull(inputtext))
		return Dialog_Show(playerid, ChangeUserPassStep2, DIALOG_STYLE_PASSWORD, "Change Password", "Enter your new password.", "Enter", "Exit");
	
	SHA256_PassHash(inputtext, Player[playerid][Salt], Player[playerid][Password], 65);

	new query[221];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players SET `password` = '%e' WHERE `id` = %d", Player[playerid][Password], Player[playerid][ID]);
	mysql_tquery(g_SQL, query, "OnUpdatePassword", "d", playerid);
	return 1;
}

function OnUpdatePassword(playerid)
{
	UpdatePlayerData(playerid);
	SendServerMessage(playerid, "You have updated your password.");
}