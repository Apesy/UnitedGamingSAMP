//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock UserToUserLog(playerid, targetid, logTable[], logText[])
{
	new query[128];
	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `%s` (`Timestamp`,`PlayerID`,`TargetID`,`LogText`,`PlayerIP`,`TargetIP`) VALUES ('%d','%d','%d','%e','%e','%e')", logTable, gettime(), Player[playerid][ID], Player[targetid][ID], logText, GetUserIP(playerid), GetUserIP(targetid));
	mysql_tquery(g_SQL, query);
}

stock UserLog(playerid, logTable[], logText[])
{
	new query[128];
	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `UserLog` (`Timestamp`,`PlayerID`,`LogText`,`PlayerIP`) VALUES ('%d','%d','%e','%e')", logTable, gettime(), Player[playerid][ID], logText, GetUserIP(playerid));
	mysql_tquery(g_SQL, query);
}

stock DBLog(logTypes[], logText[])
{
	new query[2048];
	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `ServerLogs` (`Message`, `Timestamp`, `LogType`) VALUES ('%e', %d, '%e')", logText, gettime(), logTypes);
	mysql_tquery(g_SQL, query);
}