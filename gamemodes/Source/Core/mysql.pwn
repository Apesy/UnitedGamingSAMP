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
	SQL backend system
    If we (for whatever reason) decide to change to another SQL system or decide to update to a newer version, this will make life easier for us.
*/

stock SQL_Init()
{
    new fileString[128], File: fileHandle = fopen("mysql.cfg", io_read);

	while(fread(fileHandle, fileString, sizeof(fileString))) 
	{
		if(ini_GetValue(fileString, "HOST", MYSQL_HOST, sizeof(MYSQL_HOST))) continue;
		if(ini_GetValue(fileString, "DB", MYSQL_DATABASE, sizeof(MYSQL_DATABASE))) continue;
		if(ini_GetValue(fileString, "USER", MYSQL_USER, sizeof(MYSQL_USER))) continue;
		if(ini_GetValue(fileString, "PASS", MYSQL_PASSWORD, sizeof(MYSQL_PASSWORD))) continue;
		if(ini_GetValue(fileString, "SERVER_PASS", SERVER_PASSWORD, sizeof(SERVER_PASSWORD))) continue;
		if(ini_GetInt(fileString, "DEBUG", GAMEMODE_DEBUG)) continue;
	}
	fclose(fileHandle);

    new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true); // it automatically reconnects when loosing connection to mysql server

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id); // AUTO_RECONNECT is enabled for this connection handle only
	if (g_SQL == MYSQL_INVALID_HANDLE)
	{
		printf("[ERROR] Fatal Error! There was an invalid Handle.");
		printf("[ERROR] Error number: %d", mysql_errno(g_SQL));
		SendRconCommand("exit"); // close the server if there is no connection
		return 0;
	}

	if (mysql_errno(g_SQL) != 0)
	{
		new str[128];
		mysql_error(str, sizeof(str));
		printf("[ERROR] Fatal Error! Could not connect to MySQL: Host %s - DB: %s - User: %s", MYSQL_HOST, MYSQL_DATABASE, MYSQL_USER);
		print("[ERROR] Note: Make sure that you have provided the correct connection credentials.");
		printf("[ERROR] Error number: %d", mysql_errno(g_SQL));
		SendRconCommand("exit"); // close the server if there is no connection
		return 0;
	}

	// Enable all logs if the gamemode is running in debug mode, else disable all logs.
	if(GAMEMODE_DEBUG == 1)
	{
		mysql_log(ERROR|WARNING);
	}
	else mysql_log(NONE);
    return 1;
}

stock SQL_SetInt(table[], field[], where[], what[], value)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `%e` SET `%e` = %d WHERE `%e` = '%e' LIMIT 1", table, field, value, where, what);
	if(GAMEMODE_DEBUG == 1)
	{
		print(query);
	}
    mysql_tquery(g_SQL, query);
}

stock SQL_SetFloat(table[], field[], where[], what[], Float:value)
{
    new query[64];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `%e` SET `%e` = %f WHERE `%e` = '%e' LIMIT 1", table, field, value, where, what);
	if(GAMEMODE_DEBUG == 1)
	{
		print(query);
	}
    mysql_tquery(g_SQL, query);
}

stock SQL_SetString(table[], field[], where[], what[], value[])
{
    new query[64];
    mysql_format(g_SQL, query, sizeof query, "UPDATE `%e` SET `%e` = '%e' WHERE `%e` = '%e' LIMIT 1", table, field, value, where, what);
	if(GAMEMODE_DEBUG == 1)
	{
		print(query);
	}
    mysql_tquery(g_SQL, query);
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	new string[2048];
	switch(errorid) 
	{
		case CR_SERVER_GONE_ERROR: 
		{
			printf("[ERROR] Lost connection to server");
			return 1;

		}
		case ER_SYNTAX_ERROR: 
		{
			for(new i; i < 5; i++)
			{
				print("");
			}
			print("----------------------------------------------");
			print("Something is wrong in your syntax!");
			printf("[QUERY]: %s", query);
			printf("[CALLBACK]: %s", callback);
			printf("[ERROR]: %s", error);
			print("----------------------------------------------");
			for(new i; i < 5; i++)
			{
				print("");
			}
			return 1;

		}
		default: 
		{
			printf("[ERROR] Other mysql error %d %s (callback %s), query %s", errorid, error, callback, query);
		}
	}
	WriteLog("mysql_error.log", string);
	return 1;
}