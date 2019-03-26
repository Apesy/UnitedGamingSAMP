//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock LoadSettings()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `settings`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++)
		{
			cache_get_value(i, "PlayerMOTD", ServerInfo[PlayerMOTD], sizeof ServerInfo[PlayerMOTD]);
			cache_get_value(i, "HelperMOTD", ServerInfo[HelperMOTD], sizeof ServerInfo[HelperMOTD]);
			cache_get_value(i, "AdminMOTD", ServerInfo[AdminMOTD], sizeof ServerInfo[AdminMOTD]);
			cache_get_value_int(i, "TaxRate", ServerInfo[TaxRate]);
			cache_get_value_float(i, "SpawnX", ServerInfo[SpawnX]);
			cache_get_value_float(i, "SpawnY", ServerInfo[SpawnY]);
			cache_get_value_float(i, "SpawnZ", ServerInfo[SpawnZ]);
			cache_get_value_float(i, "SpawnA", ServerInfo[SpawnA]);
			cache_get_value(i, "ServerName", ServerInfo[ServerName], sizeof ServerInfo[ServerName]);
			cache_get_value(i, "ServerShortName", ServerInfo[ServerShortName], sizeof ServerInfo[ServerShortName]);
			cache_get_value(i, "ServerRevision", ServerInfo[ServerRevision], sizeof ServerInfo[ServerRevision]);
			cache_get_value(i, "ServerWebsite", ServerInfo[ServerWebsite], sizeof ServerInfo[ServerWebsite]);
			cache_get_value(i, "ServerPassword", ServerInfo[ServerPassword], sizeof ServerInfo[ServerPassword]);
		}
    }
    cache_delete(result); 
}

function InitGamemodeExit()
{
	// save all player data before closing connection
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) // GetPlayerPoolSize function was added in 0.3.7 version and gets the highest playerid currently in use on the server
	{
		if (IsPlayerConnected(i))
		{
			SetPlayerName(i, Player[i][Name]);
		}
	}

	// Shutdown server.
	SetTimer("ShutDown", 1000, false);
	return 1;
}

function ShutDown()
{
	// Kick all online players.
	foreach(new i: Player) Kick(i);

	// Save server data
	SaveAllData();

    mysql_close(g_SQL);
	printf("Gamemode Round Ended: %s", GetDateTime());
	return GameModeExit();
}