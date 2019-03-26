/*
    The contents of this file are subject to a non disclosure agreement.
    You may not use this file except in compliance with the NDA.
    You have already agreed to the NDA by joining the DC-RP development team.

    Copyright (C) 2018 Desert County Roleplay
*/

#if defined _INC_lib_dcrp
	#endinput
#endif
#define _INC_lib_dcrp

#include <a_samp>

// Colours
#define 	COLOR_GRAD1 		0xB4B5B7FF
#define 	COLOR_GRAD2 		0xBFC0C2FF
#define 	COLOR_GRAD3 		0xCBCCCEFF
#define 	COLOR_GRAD4 		0xD8D8D8FF
#define 	COLOR_GRAD5 		0xE3E3E3FF
#define 	COLOR_GRAD6 		0xF0F0F0FF
#define 	COLOR_GREY 			0xAFAFAFFF

#define 	COLOR_GREEN 		0x55AA55FF
#define 	COLOR_RED 			0xAA3333FF
#define 	COLOR_REALRED 		0xFF0606FF
#define		COLOR_FROSTYRED		0x994343FF

#define 	COLOR_LIGHTRED 		0xFF6347AA
#define 	COLOR_LIGHTBLUE 	0x33CCFF00
#define 	COLOR_LIGHTGREEN 	0x9ACD32FF

#define 	COLOR_YELLOW 		0xFFFF00FF
#define 	COLOR_YELLOW2 		0xF5DEB3FF

#define 	COLOR_WHITE 		0xFFFFFF00
#define 	COLOR_FADE1 		0xE6E6E6E6
#define 	COLOR_FADE2 		0xC8C8C8C8
#define 	COLOR_FADE3 		0xAAAAAAAA
#define 	COLOR_FADE4 		0x8C8C8C8C
#define 	COLOR_FADE5 		0x6E6E6E6E

#define 	COLOR_PURPLE 		0xC2A2DAAA
#define 	COLOR_PINK 			0xFF66FFAA
#define 	COLOR_DBLUE 		0x2641FEAA
#define 	COLOR_ALLDEPT 		0xFF8282FF
#define 	COLOR_DEPT 			0xFFD700FF
#define 	COLOR_BLACK 		0x000000AA
#define 	COLOR_NEWS 			0xFFA500AA
#define 	COLOR_AOOC 			0xF8DEB8AA
#define 	COLOR_OOC 			0xE0FFFFAA
#define 	COLOR_CYAN 			0x40FFFFFF
#define		COLOR_LIME 			0xABFF66FF
#define     COLOR_ORANGE        0xFF8000FF
#define		COLOR_STAFF			0x93B7B7FF

#define     COLOR_PMRECEIVED    0xFFDC18FF
#define     COLOR_PMSENT        0xEEE854FF

#define		COLOR_POLICE		0x8D8DFF00
#define 	COLOR_MEDIC 		0xFF828200

#define		COLOR_RADIO			0xFFA500AA
#define		COLOR_RADIO2		0xCC8400AA

#define		COLOR_HOUSE			0xFFC166FF
#define		COLOR_BIZ			0x0080FFFF
#define		COLOR_ADVERT		0x00D900FF
#define		COLOR_ANNOUNCE		0x749BCBFF
#define		COLOR_LIGHTPINK		0xFFC0CBFF
#define		COLOR_MEGA1			0xFFFF00FF
#define		COLOR_MEGA2			0xE5E500FF
#define		COLOR_MEGA3			0xCECE00FF

#define		COLOR_SAMP			0xA9C4E4FF

// Messages
#define SendUsageMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTBLUE, "[USAGE]: {FFFFFF}"%1)
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "[ERROR]: {FFFFFF}"%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_GREEN, "[SERVER]: {FFFFFF}"%1)

#define SendCancelMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "** "%1)

#define SendActionMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTBLUE, "** "%1)

// Macros
#define	percent(%0,%1) floatround((float((%0)) / 100) * (%1))

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PRESSING(%0,%1) \
	(%0 & (%1))

#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// Functions
stock WriteLog(logFile[], logText[])
{
    new
		sz_logEntry[256],
		File: logfile,
		i_dateTime[2][3];

	gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
	getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);

	format(sz_logEntry, sizeof(sz_logEntry), "[%i/%i/%i - %i:%02i:%02i] %s\r\n", i_dateTime[1][2], i_dateTime[1][1], i_dateTime[1][0], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2], logText);
	if(logfile) fclose(logfile);
	if(!fexist(logFile)) logfile = fopen(logFile, io_write);
	else logfile = fopen(logFile, io_append);
	if(logfile)
	{
		fwrite(logfile, sz_logEntry);
		fclose(logfile);
	}
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius)) 
			{
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) 
		{
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING || GetPlayerState(targetid) == PLAYER_STATE_SPECTATING)
	{
		return 0;
	}

	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock IsPlayerNearVehicle(playerid, vehicleid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehiclePos(vehicleid, fX, fY, fZ);

	if(IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ))
	{
		return 1;
	}
	return 0;
}

stock ClearChat(playerid, lines = 20)
{
	for(new i; i < lines; i++)
    {
        SendClientMessage(playerid, -1, " ");
    }
}

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[156]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 156
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
} // Credits to Emmet, South Central Roleplay

stock SendClientMessageToAllEx(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
			SendClientMessage(i, color, string);
		}
		return 1;
	}
	return SendClientMessageToAll(color, str);
}

stock IsRPName(name[], max_underscores=2)
{
	new underscores = 0;
    if (name[0] < 'A' || name[0] > 'Z') return 0;
    for(new i = 1; i < strlen(name); i++)
    {
        if(name[i] != '_' && (name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z')) return 0;
        if( (name[i] >= 'A' && name[i] <= 'Z') && (name[i - 1] != '_') ) return 0;
        if(name[i] == '_')
        {
            underscores++;
            if(underscores > max_underscores || i == strlen(name)) return 0;
            if(name[i + 1] < 'A' || name[i + 1] > 'Z') return 0;
        }
    }
    if (underscores == 0) return 0;
	return 1;
}

stock GetUserName(playerid)
{
	new name[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock ReturnUser(text[]) 
{
	new
		strPos,
		returnID = 0,
		bool: isnum = true;
	
	if(!strlen(text)) return INVALID_PLAYER_ID;
	
	while(text[strPos]) {
		if(isnum) {
			if ('0' <= text[strPos] <= '9') returnID = (returnID * 10) + (text[strPos] - '0');
			else isnum = false;
		}
		strPos++;
	}
	if (isnum) {
		if(IsPlayerConnected(returnID)) return returnID;
	}
	else {

		new
			sz_playerName[MAX_PLAYER_NAME];

		foreach(new i: Player)
		{
			GetPlayerName(i, sz_playerName, MAX_PLAYER_NAME);
			if(!strcmp(sz_playerName, text, true, strPos)) return i;
		}	
	}
	return INVALID_PLAYER_ID;
}

stock GetUserGPCI(playerid)
{
	new serial[41];
	gpci(playerid, serial, sizeof(serial));
	return serial;
}

stock GetUserIP(playerid)
{
	new ipAddr[MAX_PLAYER_NAME+1];
	GetPlayerIp(playerid, ipAddr, sizeof(ipAddr));
	return ipAddr;
}

stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock IsAdminLevel(playerid, level, bool:warning = true) 
{
	if(GetPVarInt(playerid, "AdminLevel") >= level) return 1;
	if(warning) SendErrorMessage(playerid, "You are not authorised to use this command.");
	return 0;
}

stock FormatNumber(integer)
{
	new value[20], string[20];

	valstr(value, integer);

	new charcount;

	for(new i = strlen(value); i >= 0; i --)
	{
		format(string, sizeof(string), "%c%s", value[i], string);
		if(charcount == 3)
		{
			if(i != 0)
				format(string, sizeof(string), ",%s", string);
			charcount = 0;
		}
		charcount ++;
	}

	return string;
}

stock date( timestamp, _form=2 )
{
    /*
        date( 1247182451 )  will print >> 09.07.2009-23:34:11
        date( 1247182451, 1) will print >> 09/07/2009, 23:34:11
        date( 1247182451, 2) will print >> July 09, 2009, 23:34:11
        date( 1247182451, 3) will print >> 9 Jul 2009, 23:34
    */
    new year=1970, day=0, month=0, hourt=0, mins=0, sec=0;

    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
    new names_of_month[12][10] = {"January","February","March","April","May","June","July","August","September","October","November","December"};
    new returnstring[32];

    while(timestamp>31622400){
        timestamp -= 31536000;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
        year++;
    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )
        days_of_month[1] = 29;
    else
        days_of_month[1] = 28;


    while(timestamp>86400){
        timestamp -= 86400, day++;
        if(day==days_of_month[month]) day=0, month++;
    }

    while(timestamp>60){
        timestamp -= 60, mins++;
        if( mins == 60) mins=0, hourt++;
    }

    sec=timestamp;

    switch( _form ){
        case 1: format(returnstring, 31, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hourt, mins, sec);
        case 2: format(returnstring, 31, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hourt, mins, sec);
        case 3: format(returnstring, 31, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hourt,mins);
		case 4: format(returnstring, 31, "%s %02d, %d", names_of_month[month],day+1,year);
        default: format(returnstring, 31, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hourt, mins, sec);
    }

    return returnstring;
}

// This function freezes the player whilsts making them wait 1 second + ping*20 second
stock TogglePlayerWait(playerid, time = 1000)
{
    TogglePlayerControllable(playerid, false);
    Streamer_Update(playerid, 0);
    SetTimerEx("OnPlayerWait", time+(GetPlayerPing(playerid)*20), false, "i", playerid);
}

function OnPlayerWait(playerid)
{
    TogglePlayerControllable(playerid, true);
}

stock bool:strreplace(dest[], const string[], const replacestr[], bool:ignorecase = true, bool:ReplaceAll = true, maxlenght = sizeof(dest))
{
    new pos = strfind(dest, string, ignorecase);
    if(!strlen(dest) || !strlen(string) || pos == -1 || (!strcmp(string, replacestr, ignorecase) && strlen(replacestr))) return false;
    if(ReplaceAll) while(pos != -1)
    {
        strdel(dest, pos, pos + strlen(string));
        strins(dest, replacestr, pos, maxlenght);
        pos = strfind(dest, string, ignorecase);
    }
    else strdel(dest, pos, pos + strlen(string)), strins(dest, replacestr, pos, maxlenght);
    return true;
}

stock ConvertTo12Hour(tHour)
{
	new string[56], suffix[3], cHour;
	if(tHour > 12 && tHour < 24)
	{
		cHour = tHour - 12;
		suffix = "PM";
	}
	else if(tHour == 12)
	{
		cHour = 12;
		suffix = "PM";
	}
	else if(tHour > 0 && tHour < 12)
	{
		cHour = tHour;
		suffix = "AM";
	}
	else if(tHour == 0)
	{
		cHour = 12;
		suffix = "AM";
	}
	format(string, sizeof(string), "%d%s", cHour, suffix);
	return string;
}

stock TimeConvert(time) 
{
	new jhour, jmin, jdiv, jsec, string[128];
	if(time > 3599)
	{
		jhour = floatround(time / (60*60));
		jdiv = floatround(time % (60*60));
        jmin = floatround(jdiv / 60, floatround_floor);
        jsec = floatround(jdiv % 60, floatround_ceil);
        format(string,sizeof(string),"%02d:%02d:%02d",jhour,jmin,jsec);
    }
    else if(time > 59 && time < 3600)
	{
        jmin = floatround(time/60);
        jsec = floatround(time - jmin*60);
        format(string,sizeof(string),"%02d:%02d",jmin,jsec);
    }
    else
	{
        jsec = floatround(time);
        format(string,sizeof(string),"%02d seconds",jsec);
    }
    return string;
}

stock ini_GetInt(szParse[], szValueName[], &iValue) // Credits to NGG.
{
	new
		iPos = strfind(szParse, "=", false);

	if(strcmp(szParse, szValueName, false, iPos) == 0) {
		iValue = strval(szParse[iPos + 1]);
		return 1;
	}
	return 0;
}

stock ini_GetFloat(szParse[], szValueName[], & Float: iValue) { // Credits to NGG.
	new
		iPos = strfind(szParse, "=", false);
	if(strcmp(szParse, szValueName, false, iPos) == 0) {
		iValue = floatstr(szParse[iPos + 1]);
		return 1;
	}
	return 0;
}

/*ini_GetString(szParse[], szValueName[], szDest[], iLength = sizeof(szDest)) { // Credits to NGG.
	new
		iPos = strfind(szParse, "=", false);
	if(strcmp(szParse, szValueName, false, iPos) == 0) {
		strcat(szDest, szParse[iPos + 1], iLength);
		return 1;
	}
	return 0;
}*/

stock ini_GetValue(szParse[], szValueName[], szDest[], iDestLen) // Credits to NGG.
{

	new
		iPos = strfind(szParse, "=", false),
		iLength = strlen(szParse);
		
	while(iLength-- && szParse[iLength] <= ' ') {
		szParse[iLength] = 0;
	}

	if(strcmp(szParse, szValueName, false, iPos) == 0) {
		strmid(szDest, szParse, iPos + 1, iLength + 1, iDestLen);
		return 1;
	}
	return 0;
}

stock GetDateTime()
{
	new sendString[90], MonthStr[40], month, day, year;
	new hour, minute, second;
	
	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}
	
	format(sendString, 90, "%s %d, %d %02d:%02d:%02d", MonthStr, day, year, hour, minute, second);
	return sendString;
}

stock SendAdminCommand(string[], level = 0)
{
	new rankStr[32];
	if(level >= 1)
	{
		format(rankStr, sizeof rankStr, "(%d)", level);
	}
    foreach(new i: Player)
    {
        if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminCmdDisabled") == 0)
        {
            if(strlen(string) > 116)
            {
                SendClientMessageEx(i, COLOR_LIGHTRED, "AdmCmd%s: %.116s ...", rankStr, string);
                SendClientMessageEx(i, COLOR_LIGHTRED, "AdmCmd%s: ... %s", rankStr, string[116]);
            }
            else SendClientMessageEx(i, COLOR_LIGHTRED, "AdmCmd%s: %s", rankStr, string);
        }
    }
    new logString[256];
    format(logString, sizeof logString, "[COMMAND] %s", string);
    WriteLog("Logs/adminmessage.log", logString);
}

stock SendAdminCommandEx(colour, string[], level = 0)
{
	new rankStr[32];
	if(level >= 1)
	{
		format(rankStr, sizeof rankStr, "(%d)", level);
	}
    foreach(new i: Player)
    {
        if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminCmdDisabled") == 0)
        {
            if(strlen(string) > 116)
            {
                SendClientMessageEx(i, colour, "AdmCmd%s: %.116s ...", rankStr, string);
                SendClientMessageEx(i, colour, "AdmCmd%s: ... %s", rankStr, string[116]);
            }
            else SendClientMessageEx(i, colour, "AdmCmd%s: %s", rankStr, string);
        }
    }
    new logString[256];
    format(logString, sizeof logString, "[COMMAND] %s", string);
    WriteLog("Logs/adminmessage.log", logString);
}

stock SendAdminWarning(level, string[])
{
    foreach(new i: Player)
    {
        if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminWarnDisabled") == 0)
        {
            if(strlen(string) > 116)
            {
                SendClientMessageEx(i, COLOR_LIGHTRED, "AdmWarn(%d): {FFFF00}%.116s ...", level, string);
                SendClientMessageEx(i, COLOR_LIGHTRED, "AdmWarn(%d): {FFFF00}... %s", level, string[116]);
            }
            else SendClientMessageEx(i, COLOR_LIGHTRED, "AdmWarn(%d): {FFFF00}%s", level, string);
        }
    }
    DCC_SendChannelMessage(DCC_FindChannelById("420618860522110977"), string);

    new logString[256];
    format(logString, sizeof logString, "[WARNING] %s", string);
    WriteLog("Logs/adminmessage.log", string);
}

stock GetAdminRank(playerid)
{
    new rankStr[32];
    switch(GetPVarInt(playerid, "AdminLevel"))
    {
		case 0: format(rankStr, sizeof(rankStr), "Regular User");
        case 1: format(rankStr, sizeof(rankStr), "Trial Administrator");
        case 2: format(rankStr, sizeof(rankStr), "General Administrator");
        case 3: format(rankStr, sizeof(rankStr), "Senior Administrator");
        case 4: format(rankStr, sizeof(rankStr), "Lead Administrator");
        case 5: format(rankStr, sizeof(rankStr), "Server Manager");
        default: format(rankStr, sizeof(rankStr), "Undefined Administrator (%d)", GetPVarInt(playerid, "AdminLevel"));
    }
    return rankStr;
}

stock SendAdminMessageEx(color, level, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminDisabled") == 0)
			{
                SendClientMessage(i, color, string);
            }
		}
		return 1;
	}
	foreach (new i : Player)
    {
        if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminDisabled") == 0)
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

stock SendAdminMessage(color, level, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.pri args
		#emit ADD.C 4
		#emit PUSH.pri
		#emit SYSREQ.C format

        #emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) 
		{
            if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminDisabled") == 0)
			{
                SendClientMessage(i, color, string);
            }
		}
		return 1;
	}
	foreach (new i : Player)
    {
        if(GetPVarInt(i, "AdminLevel") >= level && GetPVarInt(i, "AdminDisabled") == 0)
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

stock stringContainsIP(string[])
{
	new number, dot, pos, character, colon;
	while((character = string[pos++]))
	{
		if('0' <= character <= '9') 
		{
			number++;
		}
		else if(character == '.')
		{
			dot++;
		}
		else if(character == ':')
		{
			colon++;
		}
	}

	if(number >= 7 && dot >= 3 && colon >= 1)
	{
		return 1;
	}
	return 0;
}

stock BinToStr(number)
{
    new string[5];
    if(number)
    {
        string = "Yes";
    }
    else string = "No";
    return string;
}