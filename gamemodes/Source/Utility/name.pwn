//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock ReturnMasterUser(text[]) 
{
	new
		strPos,
		returnID = 0,
		bool: isnum = true;
	
	if(!strlen(text)) return INVALID_PLAYER_ID;
	
	while(text[strPos]) 
	{
		if(isnum) 
		{
			if ('0' <= text[strPos] <= '9') returnID = (returnID * 10) + (text[strPos] - '0');
			else isnum = false;
		}
		strPos++;
	}
	if (isnum) 
	{
		if(IsPlayerConnected(returnID)) return returnID;
	}
	else 
	{
		foreach(new i: Player)
		{
			if(!strcmp(GetMasterName(returnID), text, true, strPos)) return i;
		}	
	}
	return INVALID_PLAYER_ID;
}

stock GetMasterName(playerid)
{
	new name[MAX_PLAYER_NAME+1];
	format(name, sizeof(name), "%s", Player[playerid][Name]);
	return name;
}

stock GetRPName(playerid)
{
    new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName)); 

    if(TempVar[playerid][Masked] == true)
        format(playersName, sizeof(playersName), "Stranger_%i", PlayerInfo[playerid][pMaskID]); 
        
    else
    {
        for(new i = 0, j = strlen(playersName); i < j; i ++) 
        { 
            if(playersName[i] == '_') 
            { 
                playersName[i] = ' '; 
            } 
        } 
    }
	return playersName;
}

stock GetDatabaseMasterName(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT `username` FROM `players` WHERE `id` = %i LIMIT 1", dbid);
	print(query);
	new Cache:cache = mysql_query(g_SQL, query);
	
	if(!cache_num_rows())
		returnString = "Unknown";
		
	else
		cache_get_value(0, "username", returnString, 60);
	
	cache_delete(cache);
	return returnString;
}

stock GetDatabaseName(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT `Name` FROM characters WHERE `CharacterID` = %i LIMIT 1", dbid);
	new Cache:cache = mysql_query(g_SQL, query);
	
	if(!cache_num_rows())
		returnString = "Unknown";
		
	else
		cache_get_value(0, "Name", returnString, 60);
	
	cache_delete(cache);
	return returnString;
}

stock GetDatabaseGender(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT `Gender `FROM characters WHERE `CharacterID` = %i", dbid);
	new Cache:cache = mysql_query(g_SQL, query);
	
	if(!cache_num_rows())
		returnString = "Unknown";
		
	else
		cache_get_value(0, "Gender", returnString, 60);
	
	cache_delete(cache);
	return returnString;
}


/*stock GetDatabaseGender(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(g_SQL, query, sizeof(query), "SELECT `Gender `FROM characters WHERE `CharacterID` = %i", dbid);
	new Cache:cache = mysql_query(g_SQL, query);
	
	if(!cache_num_rows())
		returnString = "Unknown";
		
	else
		cache_get_value(0, "Gender", returnString, 60);
	
	cache_delete(cache);
	return returnString;
}*/