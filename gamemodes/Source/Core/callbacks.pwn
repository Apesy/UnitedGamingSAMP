//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

new TasedRecently[MAX_PLAYERS];

ptask TaserTimer[1000](playerid)
{
	if(TasedRecently[playerid] > 0)
	{
		TasedRecently[playerid]--;
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	
	return 1;
}

stock ExecuteAcronymAction(playerid, text[])
{
	new string[128];
	if(strlen(text) > 70)
	{
		format (string, sizeof(string), "%s says IC'ly: %.70s...", GetRPName(playerid), text);
		SendAdminWarning(1, string);
		format (string, sizeof(string), "%s says IC'ly: ... %s", GetRPName(playerid), text[70]);
		SendAdminWarning(1, string);
	}
	else
	{
		format (string, sizeof(string), "%s says IC'ly: %s", GetRPName(playerid), text);
		SendAdminWarning(1, string);
	}
}

public OnPlayerText(playerid, text[])
{
	new string[256];
	if(Player[playerid][IsLoggedIn] == true)
	{
		if(stringContainsIP(text) && Player[playerid][AdminLevel] < 1)
		{
			new logString[256];
			format(logString, sizeof logString, "%s (%d) may be server advertising: %s", GetUserName(playerid), playerid, text);
			SendAdminWarning(1, logString);
			format(logString, sizeof logString, "%s (IP: %s AccountID: %s) may be server advertising: /%s %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], text);
			DBLog("ServerAd", logString);
		}

		if(TempVar[playerid][Spectating] != INVALID_PLAYER_ID)
		{
			SendErrorMessage(playerid, "You cannot speak whilst spectating. Use /pm instead.");
			return 0;
		}

		if(!Player[playerid][PassedTutorial])
		{
			StartTutorial(playerid);
			return 0;
		}

		if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		{
			SendErrorMessage(playerid, "You cannot speak you are injured/dead.");
			return 0;
		}

		if(TempVar[playerid][IdleTime] > 0)
		{
			TempVar[playerid][IdleTime] = 0; // If they're talking, they can't possibly be AFK.
		}

		text[0] = toupper(text[0]);

		if(Player[playerid][Ajailed] == 1)
        {
			SendErrorMessage(playerid, "You are restricted to /pm in admin jail.");
			return 0;
		}

		if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
		{
			pc_cmd_b(playerid, text);
			return 0;
		}

		if(TempVar[playerid][TalkingLive] == true)
		{
			if(PlayerInfo[playerid][pFaction] > 0 && FactionInfo[PlayerInfo[playerid][pFaction]][FactionNews] == 1)
			{
				if(strlen(text) > 70)
				{
					SendNewsMessage(0x77BFA0FF, "[Live] Presenter %s: %.70s ...", GetRPName(playerid), (strlen(PlayerInfo[playerid][pAccent]) > 1) ? ("requests") : ("request"), text);
					SendNewsMessage(0x77BFA0FF, "[Live] Presenter %s: ... %s", GetRPName(playerid), text[70]);
				}
				else SendNewsMessage(0x77BFA0FF, "[Live] Presenter %s: %s", GetRPName(playerid), text);
			}
			else
			{
				if(strlen(text) > 70)
				{
					SendNewsMessage(0x77BFA0FF, "[Live] Guest %s: %.70s ...", GetRPName(playerid), text);
					SendNewsMessage(0x77BFA0FF, "[Live] Guest %s: ... %s", GetRPName(playerid), text[70]);
				}
				else SendNewsMessage(0x77BFA0FF, "[Live] Guest %s: %s", GetRPName(playerid), text);
			}
			return 0;
		}

		if(TempVar[playerid][PMConvo] != INVALID_PLAYER_ID)
		{
			new playerb = TempVar[playerid][PMConvo];
			SendPrivateMessage(playerid, playerb, text);
			return 0;
		}

		if(TempVar[playerid][OnCall] == true)
		{
			if (strlen(text) > 70)
			{
				format(string, sizeof(string), "%s says (Phone): %.70s...", GetRPName(playerid), text);
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
						
				format(string, sizeof(string), "%s says (Phone): ... %s", GetRPName(playerid), text[70]); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
						
			}
			else 
			{	
				format(string, sizeof(string), "%s says (Phone): %s", GetRPName(playerid), text);
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
			}

			if(TempVar[playerid][Mobile] != INVALID_PLAYER_ID && TempVar[playerid][CallAnswer] == true)
			{
				if(!IsPlayerConnected(TempVar[playerid][Mobile]))
				{
					SendClientMessage(playerid, COLOR_GREY, "The line went dead... ((Other player disconnected))");
					HangupCall(playerid);
					return 0;
				}

				if (strlen(text) > 70)
				{
					format (string, sizeof(string), "%s says (Phone): %.70s...", GetRPName(playerid), text);
					SendClientMessage(TempVar[playerid][Mobile], COLOR_YELLOW, string);
							
					format (string, sizeof(string), "%s says (Phone): ... %s", GetRPName(playerid), text[70]); 
					SendClientMessage(TempVar[playerid][Mobile], COLOR_YELLOW, string);
				}
				else
				{
					format (string, sizeof(string), "%s says (Phone): %s", GetRPName(playerid), text);
					SendClientMessage(TempVar[playerid][Mobile], COLOR_YELLOW, string);
				}
			}

			if(TempVar[playerid][CallLandline] > 0)
			{
				new phoneNo = GetInventoryAmount(playerid, GetInventorySlot(playerid, INV_PHONE));
				switch(TempVar[playerid][CallLandline])
				{
					case 911:
					{
						format(TempVar[playerid][ServicesText], 256, "%s", text);
						if(strfind(text, "Both", true) != -1 || strfind(text, "And", true) != -1 || strfind(text, "Everyone", true) != -1)
						{
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, the Police and Fire Department will be notified.");
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is your current location?");
							TempVar[playerid][CallLandline] = 916;
							return 0;
						}
						if(strfind(text, "Police", true) != -1 
							|| strfind(text, "Sheriff", true) != -1 
							|| strfind(text, "Law", true) != -1
							|| strfind(text, "BCSD", true) != -1
							|| strfind(text, "SD", true) != -1)
						{
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, the police will be notified.");
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is your current location?");
							TempVar[playerid][CallLandline] = 912;
							return 0;
						}
						if(strfind(text, "Fire", true) != -1 
							|| strfind(text, "Medic", true) != -1 
							|| strfind(text, "EMS", true) != -1
							|| strfind(text, "BCFD", true) != -1
							|| strfind(text, "FD", true) != -1)
						{
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, the Fire Department will be notified.");
							SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is your current location?");
							TempVar[playerid][CallLandline] = 914;
							return 0;
						}
					}
					case 912:
					{
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is the incident?");
						TempVar[playerid][CallLandline] = 913;
						format(TempVar[playerid][EmergencyCallText], 256, "%s", text);
					}
					case 914:
					{
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is the incident?");
						TempVar[playerid][CallLandline] = 915;
						format(TempVar[playerid][EmergencyCallText], 256, "%s", text);
					}
					case 916:
					{
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): What is the incident?");
						TempVar[playerid][CallLandline] = 917;
						format(TempVar[playerid][EmergencyCallText], 256, "%s", text);
					}
					case 913:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionPoliceCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Type: {FFFFFF}Emergency Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}Payphone{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}%d{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, phoneNo, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								if(strlen(TempVar[playerid][ServicesText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%.70s ...", TempVar[playerid][ServicesText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}... %s", TempVar[playerid][ServicesText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%s", TempVar[playerid][ServicesText]);
								if(strlen(TempVar[playerid][EmergencyCallText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%.70s ...", TempVar[playerid][EmergencyCallText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}... %s", TempVar[playerid][EmergencyCallText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%s", TempVar[playerid][EmergencyCallText]);
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%.70s ...", text);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%s", text);
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, the police have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 915:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionMedicCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Type: {FFFFFF}Emergency Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}Payphone{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}%d{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, phoneNo, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								if(strlen(TempVar[playerid][ServicesText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%.70s ...", TempVar[playerid][ServicesText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}... %s", TempVar[playerid][ServicesText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%s", TempVar[playerid][ServicesText]);
								if(strlen(TempVar[playerid][EmergencyCallText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%.70s ...", TempVar[playerid][EmergencyCallText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}... %s", TempVar[playerid][EmergencyCallText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%s", TempVar[playerid][EmergencyCallText]);
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%.70s ...", text);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%s", text);
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, EMS have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 917:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionPoliceCall] == 1 || FactionInfo[i][FactionMedicCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Type: {FFFFFF}Emergency Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}Payphone{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Caller: {FFFFFF}%s{%06x}, Phone: {FFFFFF}%d{%06x}, Trace: {FFFFFF}%s", GetRPName(playerid), COLOR_LIGHTBLUE >>> 8, phoneNo, COLOR_LIGHTBLUE >>> 8, ReturnLocation(playerid));
								}
								if(strlen(TempVar[playerid][ServicesText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%.70s ...", TempVar[playerid][ServicesText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}... %s", TempVar[playerid][ServicesText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Services Required: {FFFFFF}%s", TempVar[playerid][ServicesText]);
								if(strlen(TempVar[playerid][EmergencyCallText]) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%.70s ...", TempVar[playerid][EmergencyCallText]);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}... %s", TempVar[playerid][EmergencyCallText][70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Location: {FFFFFF}%s", TempVar[playerid][EmergencyCallText]);
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%.70s ...", text);
									SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "Incident: {FFFFFF}%s", text);
								SendFactionDutyMessage(i, COLOR_LIGHTBLUE, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, Police and EMS have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 555:
					{
						SendJobMessage(JOB_MECHANIC, COLOR_GREEN, "__________________________________________________");
						SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Type: Mechanic Call.");
						if(TempVar[playerid][UsingPayphone] == true)
						{
							SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Caller: %s, Phone: Payphone", GetRPName(playerid));
						}
						else
						{
							SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Caller: %s, Phone: %d", GetRPName(playerid), phoneNo);
						}
						if(strlen(text) > 70)
						{
							SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Message: %.70s ...", text);
							SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Message: ... %s", text[70]);
						}
						else SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Message: %s", text);
						SendJobMessage(JOB_MECHANIC, COLOR_GREEN, "__________________________________________________");
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, mechanics have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 119:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionPoliceCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_GREEN, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_POLICE, "Type: {FFFFFF}Non Emergency Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_POLICE, "Caller: %s, Phone: Payphone", GetRPName(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_POLICE, "Caller: %s, Phone: %d", GetRPName(playerid), phoneNo);
								}
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_POLICE, "Message: %.70s ...", text);
									SendFactionDutyMessage(i, COLOR_POLICE, "Message: ... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_POLICE, "Message: %s", text);
								SendFactionDutyMessage(i, COLOR_GREEN, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, police have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 219:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionMedicCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_MEDIC, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_MEDIC, "Type: {FFFFFF}Non Emergency Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_MEDIC, "Caller: %s, Phone: Payphone", GetRPName(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_MEDIC, "Caller: %s, Phone: %d", GetRPName(playerid), phoneNo);
								}
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_MEDIC, "Message: %.70s ...", text);
									SendFactionDutyMessage(i, COLOR_MEDIC, "Message: ... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_MEDIC, "Message: %s", text);
								SendFactionDutyMessage(i, COLOR_MEDIC, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, medics have been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
					case 319:
					{
						for(new i; i < MAX_FACTIONS; i++)
						{
							if(FactionInfo[i][FactionGovernmentCall] == 1)
							{
								SendFactionDutyMessage(i, COLOR_GREEN, "__________________________________________________");
								SendFactionDutyMessage(i, COLOR_WHITE, "Type: Landline Call.");
								if(TempVar[playerid][UsingPayphone] == true)
								{
									SendFactionDutyMessage(i, COLOR_WHITE, "Caller: %s, Phone: Payphone", GetRPName(playerid));
								}
								else
								{
									SendFactionDutyMessage(i, COLOR_WHITE, "Caller: %s, Phone: %d", GetRPName(playerid), phoneNo);
								}
								if(strlen(text) > 70)
								{
									SendFactionDutyMessage(i, COLOR_WHITE, "Message: %.70s ...", text);
									SendFactionDutyMessage(i, COLOR_WHITE, "Message: ... %s", text[70]);
								}
								else SendFactionDutyMessage(i, COLOR_WHITE, "Message: %s", text);
								SendFactionDutyMessage(i, COLOR_GREEN, "__________________________________________________");
							}
						}
						SendClientMessage(playerid, COLOR_YELLOW, "Operator says (Phone): Okay, the government has been informed.");
						TempVar[playerid][CallLandline] = 0;
						HangupCall(playerid);
						SendClientMessage(playerid, COLOR_LIGHTRED, "> {FFFFFF}They hung up.");
					}
				}
				return 0;
			}
			return 0;
		}

		if(strfind(text, "lol", true) != -1 || strfind(text, "lmfao", true) != -1 || strfind(text, "noob", true) != -1
			|| strfind(text, "n00b", true) != -1 || strfind(text, "1337", true) != -1 || strfind(text, "brb", true) != -1
			|| strfind(text, "btw", true) != -1  || strfind(text, "g2g", true) != -1 || strfind(text, "gtg", true) != -1
			|| strfind(text, "pce", true) != -1  || strfind(text, "omg", true) != -1 || strfind(text, "gr8", true) != -1)
		{
			ExecuteAcronymAction(playerid, text);
		}

		new accentStr[64];
		if(strlen(PlayerInfo[playerid][pAccent]) > 0)
		{
			format(accentStr, sizeof accentStr, " [%s accent]", PlayerInfo[playerid][pAccent]);
		}

		new vehicleid = GetPlayerVehicleID(playerid);
		if(vehicleid > 0 && IsAGeneralBike(vehicleid) == 0)
		{
			if(CoreVehicle[vehicleid][VehicleWindowFrontLeft] == true
			|| CoreVehicle[vehicleid][VehicleWindowFrontRight] == true
			|| CoreVehicle[vehicleid][VehicleWindowBackLeft] == true
			|| CoreVehicle[vehicleid][VehicleWindowBackRight] == true)
			{
				if (strlen(text) > 70)
				{
					format (string, sizeof(string), "[Window Down] %s says%s: %.70s...", GetRPName(playerid), accentStr, text);
					LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
							
					format (string, sizeof(string), "[Window Down] %s says%s: ... %s", GetRPName(playerid), accentStr, text[70]); 
					LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);			
				}
				else 
				{	
					format (string, sizeof(string), "[Window Down] %s says%s: %s", GetRPName(playerid), accentStr, text);
					LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				}
			}
			else
			{
				if (strlen(text) > 70)
				{
					format (string, sizeof(string), "[Window Up] %s says%s: %.70s...", GetRPName(playerid), accentStr, text);
					LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
							
					format (string, sizeof(string), "[Window Up] %s says%s: ... %s", GetRPName(playerid), accentStr, text[70]); 
					LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				}
				else 
				{	
					format (string, sizeof(string), "[Window Up] %s says%s: %s", GetRPName(playerid), accentStr, text);
					LocalChat(playerid, 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				}
			}
		}
		else
		{
			if (strlen(text) > 70)
			{
				format (string, sizeof(string), "%s says%s: %.70s...", GetRPName(playerid), accentStr, text);
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
						
				format (string, sizeof(string), "%s says%s: ... %s", GetRPName(playerid), accentStr, text[70]); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);			
			}
			else 
			{	
				format (string, sizeof(string), "%s says%s: %s", GetRPName(playerid), accentStr, text);
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
			}
		}
		SetPlayerChatBubble(playerid, text, COLOR_FADE1, 10.0, strlen(text)*100);

		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && TempVar[playerid][Handcuffed] == false && LoopAnim[playerid] == false)
		{
			new randStyle = random(9);
			switch(randStyle)
			{
				case 1: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkA", text);
				case 2: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkB", text);
				case 3: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkC", text);
				case 4: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkD", text);
				case 5: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkE", text);
				case 6: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkF", text);
				case 7: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkG", text);
				case 8: ApplyChatAnimation(playerid, "GANGS", "prtial_gngtlkH", text);
				default: ApplyChatAnimation(playerid, "PED", "IDLE_CHAT", text);
			}
		}

		IC_Log(playerid, text);
		new logString[256];
		format(logString, sizeof(logString), "%s (IP: %s AccountID: %d CharacterID: %d): %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], PlayerInfo[playerid][pCharacterID], text);
		DBLog("LocalChat", logString);
	}
	return 0;
}

stock PM_Log(playerid, reciever, text[])
{
	new string[256];
	mysql_format(g_SQL, string, sizeof string, "INSERT INTO `pm_log` (`AccountID`, `UserName`, `Reciever`, `Message`, `Timestamp`) VALUES (%d, '%e', '%e', '%e', %d)", Player[playerid][ID], GetUserName(playerid), GetUserName(reciever), text, gettime());
	mysql_tquery(g_SQL, string);
}

stock OOC_Log(playerid, text[])
{
	new string[256];
	mysql_format(g_SQL, string, sizeof string, "INSERT INTO `ooc_log` (`AccountID`, `UserName`, `Message`, `Timestamp`) VALUES (%d, '%e', '%e', %d)", Player[playerid][ID], GetUserName(playerid), text, gettime());
	mysql_tquery(g_SQL, string);
}

stock IC_Log(playerid, text[])
{
	new string[256];
	mysql_format(g_SQL, string, sizeof string, "INSERT INTO `ic_log` (`AccountID`, `UserName`, `Message`, `Timestamp`) VALUES (%d, '%e', '%e', %d)", Player[playerid][ID], GetUserName(playerid), text, gettime());
	mysql_tquery(g_SQL, string);
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(Player[playerid][IsLoggedIn] == true)
	{
		Player[playerid][Interior] = newinteriorid;
		if(newinteriorid != 0)
		{
			SetPlayerWeather(playerid, 1);
		}
		else
		{
			SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);
		}
	}
	foreach(new i: Player)
	{
		if(Player[i][IsLoggedIn] == true && TempVar[i][Spectating] == playerid)
		{
			SetPlayerInterior(i, newinteriorid);
			SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));

			if(newinteriorid != 0)
			{
				SetPlayerWeather(i, 1);
			}
			else SetPlayerWeather(i, ServerInfo[GlobalWeather]);

			if(IsPlayerInAnyVehicle(i))
			{
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(i));
			}
			else PlayerSpectatePlayer(playerid, i);

			SetTimerEx("SpectateUpdate", 500, false, "ii", i, playerid);
		}
	}
	return 1;
}

function SpectateUpdate(playerid, targetid)
{
	if(TempVar[playerid][Spectating] == targetid)
	{
		SetPlayerInterior(playerid, GetPlayerInterior(targetid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

		if(IsPlayerInAnyVehicle(targetid))
		{
		    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
		}
		else
		{
		    PlayerSpectatePlayer(playerid, targetid);
		}
	}
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == maleList || listid == femaleList)
	{
	    if(response)
	    {
		    characterSkin[playerid] = modelid;
			new string[256];
			mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `characters` (`OwnerID`, `Name`, `Spawn`, `Skin`, `Money`, `Level`)\
			VALUE (%d, '%e', %d, %d, 500, 1)", Player[playerid][ID], characterName[playerid], characterSpawn[playerid], characterSkin[playerid]);
			print(string);
			mysql_tquery(g_SQL, string, "OnCreateCharacter", "d", playerid);
	    }
	    else SendErrorMessage(playerid, "You have canceled the skin selection."), DelayedKick(playerid);
    	return 1;
	}
	if(listid == BuyList)
	{
	    if(response)
	    {
			new bizid = TempVar[playerid][BuyClothes], string[256];
		    SetSkin(playerid, modelid);
			SendClientMessage(playerid, COLOR_WHITE, "You have purchased new clothes. The clothes have been applied to your skin.");
			TakeMoney(playerid, 50);
			BusinessInfo[bizid][BizSafe] += 50;
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        	mysql_tquery(g_SQL, string);
	    }
	    else SendErrorMessage(playerid, "You have canceled the skin selection.");
    	return 1;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendRconCommand("reloadbans");
	SendServerMessage(playerid, "Loading server, please wait...");
	for(new i; i < MAX_PLAYERS; i++) // This is so every player id even if not connected, this makes sure it gets reset.
	{
		BlockedPM[playerid][i] = false;
	}	
	TasedRecently[playerid] = 0;

	Footer[playerid] = CreatePlayerTextDraw(playerid, 180, 375, "Error");
	PlayerTextDrawAlignment(playerid, Footer[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Footer[playerid], 255);
	PlayerTextDrawFont(playerid, Footer[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Footer[playerid], 0.3, 1.5);
	PlayerTextDrawColor(playerid, Footer[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Footer[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Footer[playerid], 1);

	Blind[playerid] = CreatePlayerTextDraw(playerid, 0.1, 0.1, "_");
	PlayerTextDrawBackgroundColor(playerid, Blind[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, Blind[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Blind[playerid], 0.5, 49.55);
	PlayerTextDrawColor(playerid, Blind[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, Blind[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Blind[playerid], 1);
	PlayerTextDrawUseBox(playerid, Blind[playerid], 1);
	PlayerTextDrawBoxColor(playerid, Blind[playerid], 0x000000FF);
	PlayerTextDrawTextSize(playerid, Blind[playerid], 639.5, 0.0);

	GreenScreen[playerid] = CreatePlayerTextDraw(playerid, 0.1, 0.1, "_");
	PlayerTextDrawBackgroundColor(playerid, GreenScreen[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, GreenScreen[playerid], 1);
	PlayerTextDrawLetterSize(playerid, GreenScreen[playerid], 0.5, 49.55);
	PlayerTextDrawColor(playerid, GreenScreen[playerid], 0x000000FF);
	PlayerTextDrawSetOutline(playerid, GreenScreen[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GreenScreen[playerid], 1);
	PlayerTextDrawUseBox(playerid, GreenScreen[playerid], 1);
	PlayerTextDrawBoxColor(playerid, GreenScreen[playerid], 0x00FF00FF);
	PlayerTextDrawTextSize(playerid, GreenScreen[playerid], 639.5, 0.0);

	OPC_ResetRecentCMD(playerid);
	new count = 0;
	foreach(new i: Player)
	{
		if(!IsPlayerNPC(i) && i != playerid && !strcmp(GetUserIP(playerid), GetUserIP(i), false))
		{
			count++;
			if(count >= 2)
			{
				SendErrorMessage(playerid, "There is already someone with your IP address connected.");
				DelayedKick(playerid);
				return 1;
			}
		}
	}

	g_MysqlRaceCheck[playerid]++;

	SetPlayerColor(playerid, 0x80808000);
	SetPlayerHealthEx(playerid, 99);

	// reset player data
	static const empty_player[E_PLAYERS];
	Player[playerid] = empty_player;

	static const empty_temp[tempVariables];
	TempVar[playerid] = empty_temp;
	TempVar[playerid][Spectating] = INVALID_PLAYER_ID;
	TempVar[playerid][FriskRequest] = INVALID_PLAYER_ID;
	TempVar[playerid][Mobile] = INVALID_PLAYER_ID;
	TempVar[playerid][TaxiDriverID] = INVALID_PLAYER_ID;
	TempVar[playerid][PMConvo] = INVALID_PLAYER_ID;
	TempVar[playerid][AppCheckedBy] = INVALID_PLAYER_ID;
	TempVar[playerid][ShakeOffer] = INVALID_PLAYER_ID;
	TempVar[playerid][SprayingVehicle] = -1;
	TempVar[playerid][WatchingPM] = INVALID_PLAYER_ID;

	VehicleSpeedo[playerid] = CreatePlayerTextDraw(playerid, 480.000000, 316.000000, "~g~Vehicle:~w~ Police Car (LSPD)~n~~g~Speed:~w~ 999 MPH~n~~g~Fuel: ~w~100 percent");
	PlayerTextDrawFont(playerid, VehicleSpeedo[playerid], 2);
	PlayerTextDrawLetterSize(playerid, VehicleSpeedo[playerid], 0.229166, 1.950000);
	PlayerTextDrawTextSize(playerid, VehicleSpeedo[playerid], 625.000000, 18.500000);
	PlayerTextDrawSetOutline(playerid, VehicleSpeedo[playerid], 1);
	PlayerTextDrawSetShadow(playerid, VehicleSpeedo[playerid], 0);
	PlayerTextDrawAlignment(playerid, VehicleSpeedo[playerid], 1);
	PlayerTextDrawColor(playerid, VehicleSpeedo[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, VehicleSpeedo[playerid], 255);
	PlayerTextDrawBoxColor(playerid, VehicleSpeedo[playerid], 100);
	PlayerTextDrawUseBox(playerid, VehicleSpeedo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, VehicleSpeedo[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, VehicleSpeedo[playerid], 0);
	
	ServerCurrentTime = TextDrawCreate(577.000000, 20.000000, "00:00");
	TextDrawFont(ServerCurrentTime, 3);
	TextDrawLetterSize(ServerCurrentTime, 0.554166, 2.449999);
	TextDrawTextSize(ServerCurrentTime, 400.000000, 17.000000);
	TextDrawSetOutline(ServerCurrentTime, 2);
	TextDrawSetShadow(ServerCurrentTime, 0);
	TextDrawAlignment(ServerCurrentTime, 2);
	TextDrawColor(ServerCurrentTime, -1);
	TextDrawBackgroundColor(ServerCurrentTime, 255);
	TextDrawBoxColor(ServerCurrentTime, 50);
	TextDrawUseBox(ServerCurrentTime, 0);
	TextDrawSetProportional(ServerCurrentTime, 1);
	TextDrawSetSelectable(ServerCurrentTime, 0);
	
	// reset player data
	static const empty_pinfo[pData];
	PlayerInfo[playerid] = empty_pinfo;

	PlayerEditingRank[playerid] = 0;
	TempVar[playerid][SellingID] = INVALID_PLAYER_ID;

	GetPlayerName(playerid, Player[playerid][Name], MAX_PLAYER_NAME);
	SetPlayerTeam(playerid, PLAYER_ALIVE); 
	SetPlayerTime(playerid, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);

	ResetDamages(playerid);

	// Fort Carson Tree's
	RemoveBuildingForPlayer(playerid, 16061, -193.3750, 1055.2891, 18.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);

	// Mental Health Unit
	RemoveBuildingForPlayer(playerid, 16674, 666.429, 1712.125, 6.187, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 624.046, 1677.601, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 16362, 613.757, 1692.390, 9.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 603.484, 1707.234, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 606.898, 1702.218, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 610.250, 1697.265, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 613.718, 1692.265, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 16360, 641.843, 1681.992, 6.187, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 617.125, 1687.453, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1686, 620.531, 1682.460, 6.179, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 583.031, 1724.828, 7.015, 0.250);
	RemoveBuildingForPlayer(playerid, 16747, 616.273, 1737.750, 12.882, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 648.132, 1754.093, 3.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1468, 664.976, 1699.382, 7.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1468, 668.742, 1699.156, 7.406, 0.250);
	RemoveBuildingForPlayer(playerid, 16361, 666.429, 1712.125, 6.187, 0.250);
	RemoveBuildingForPlayer(playerid, 1468, 674.062, 1703.750, 7.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 672.992, 1754.148, 3.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 684.023, 1740.796, 5.250, 0.250);

	// Fort Carson Houses
	RemoveBuildingForPlayer(playerid, 3371, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3371, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -51.1484, 1052.1094, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -45.2031, 1130.4141, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -26.7422, 1080.1719, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -5.2188, 1112.5703, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -13.2969, 1112.2656, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -31.8672, 1118.8359, 17.7734, 0.25);

	// Prison
	RemoveBuildingForPlayer(playerid, 3682, -1029.3438, -702.8125, 54.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 17339, -1041.6641, -728.3359, 44.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 17340, -1072.8281, -620.6328, 40.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 17341, -1083.4766, -687.9453, 31.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 17342, -1107.0703, -620.8906, 40.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 17343, -1055.5313, -617.6094, 82.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 17344, -1056.0469, -632.4141, 82.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 17345, -1026.7500, -705.1719, 82.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 17346, -1014.3594, -703.8828, 83.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 17347, -1055.1094, -603.5703, 61.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 17348, -1004.2969, -704.1484, 63.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1124.1797, -682.5625, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1124.1797, -706.7500, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1124.1797, -658.3750, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1124.1797, -634.1953, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1114.4531, -595.7969, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 17013, -1107.0703, -620.8906, 40.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1107.3906, -595.8281, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1101.1250, -595.8594, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 17014, -1041.6641, -728.3359, 44.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 17024, -1026.7500, -705.1719, 82.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3673, -1029.3438, -702.8125, 54.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 17001, -1083.4766, -687.9453, 31.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 17454, -1089.9297, -684.7891, 44.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1037.4219, -694.1016, 36.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1030.3594, -694.1406, 36.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1024.0938, -694.1719, 36.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -999.7813, -682.5625, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -999.7813, -706.7500, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 17022, -1004.2969, -704.1484, 63.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 17023, -1014.3594, -703.8828, 83.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3674, -1020.1094, -702.4375, 57.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -973.7031, -706.7500, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -973.7031, -682.5625, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3637, -992.2891, -711.9766, 38.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -999.7813, -658.3750, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -973.7031, -658.3750, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 17017, -1056.0469, -632.4141, 82.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -973.7031, -634.1953, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -999.7813, -634.1953, 38.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1043.6406, -632.3281, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 17021, -1072.8281, -620.6328, 40.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1043.6406, -626.0625, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1065.9375, -595.8594, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1079.2656, -595.7969, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1072.2031, -595.8281, 36.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 17015, -1055.1094, -603.5703, 61.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 17016, -1055.5313, -617.6094, 82.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, -1043.6406, -619.0000, 36.2578, 0.25);

	// Electric Poles
	RemoveBuildingForPlayer(playerid, 1308, -26.12162, 1087.9019, 22.33901, 8.5308437); // removeWorldObject (telgrphpole02) (1)
	RemoveBuildingForPlayer(playerid, 1308, -45.65669, 1109.0876, 21.26765, 8.5308437); // removeWorldObject (telgrphpole02) (2)
	RemoveBuildingForPlayer(playerid, 1308, -4.35958, 1108.7629, 20.40013, 8.5308437); // removeWorldObject (telgrphpole02) (3)
	RemoveBuildingForPlayer(playerid, 1308, -75.3251, 1109.2152, 24.4421, 8.5308437); // removeWorldObject (telgrphpole02) (4)
	RemoveBuildingForPlayer(playerid, 1308, -87.0011, 1088.4592, 21.01277, 8.5308437); // removeWorldObject (telgrphpole02) (5)
	RemoveBuildingForPlayer(playerid, 1308, -111.64407, 1087.7645, 21.26735, 8.5308437); // removeWorldObject (telgrphpole02) (6)

	// Street Lamp Fixes
	RemoveBuildingForPlayer(playerid, 1294, 49.23251, 1204.1045, 19.64362, 7.969655); // removeWorldObject (mlamppost) (1)
	RemoveBuildingForPlayer(playerid, 1294, 49.3657, 1192.2048, 19.47717, 7.969655); // removeWorldObject (mlamppost) (2)
	RemoveBuildingForPlayer(playerid, 1294, 20.65406, 1192.2953, 19.33099, 7.969655); // removeWorldObject (mlamppost) (3)
	RemoveBuildingForPlayer(playerid, 1294, 21.09003, 1204.155, 19.06933, 7.969655); // removeWorldObject (mlamppost) (4)
	RemoveBuildingForPlayer(playerid, 1294, 0.12193, 1192.2518, 19.20264, 7.969655); // removeWorldObject (mlamppost) (5)
	RemoveBuildingForPlayer(playerid, 1294, -11.79141, 1204.0195, 19.31661, 7.969655); // removeWorldObject (mlamppost) (6)
	RemoveBuildingForPlayer(playerid, 1294, -37.98698, 1204.0216, 19.25855, 7.969655); // removeWorldObject (mlamppost) (7)

	// Church & Ammunation
	RemoveBuildingForPlayer(playerid, 16740, -152.3203, 1144.0703, 30.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 16739, -297.1016, 1152.9688, 27.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -225.7344, 1208.8125, 17.3672, 0.25);

	// Police HQ
	RemoveBuildingForPlayer(playerid, 16672, 86.9063, 1182.6641, 21.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 59.0391, 1181.6797, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 71.1797, 1182.1719, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 16673, 86.9063, 1182.6641, 21.5391, 0.25);

	// Gas Station
	RemoveBuildingForPlayer(playerid, 16478, 55.5625, 1220.6797, 17.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 16477, 55.5625, 1220.6797, 17.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 66.7969, 1207.1563, 18.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 72.0859, 1206.8828, 18.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 73.0938, 1228.0391, 19.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 77.3594, 1206.8828, 18.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 16479, 86.2422, 1214.0391, 17.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 78.2578, 1226.8516, 19.3672, 0.25);

	// Old Cinema
	RemoveBuildingForPlayer(playerid, 3221, 107.140, 1076.790, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 112.648, 1047.660, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 110.875, 1057.219, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 115.969, 1067.199, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 121.140, 1076.790, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 128.141, 1076.790, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 112.375, 1085.670, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 105.375, 1085.670, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 91.375, 1085.670, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 100.140, 1076.790, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 94.968, 1067.199, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 96.875, 1057.219, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 98.648, 1047.660, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 119.648, 1047.660, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 124.875, 1057.219, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 122.969, 1067.199, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3221, 108.969, 1067.199, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 16000, 110.813, 1023.989, 12.648, 0.250);
	RemoveBuildingForPlayer(playerid, 18275, -2376.120, -2196.250, 34.539, 0.250);

	foreach(new i: Player)
	{
		if(TempVar[playerid][ConnectEnabled] == true)
		{
			SendClientMessageEx(i, COLOR_GREY, "[CONNECT]: %s (%d) has connected to the server.", GetUserName(playerid), playerid);
		}
	}
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	if(Player[playerid][IsLoggedIn] == false)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}This server may contain explicit content.");
		SendServerMessage(playerid, "Looking up user data, please wait...");
		new query[128], serial[41];
		gpci(playerid, serial, sizeof(serial));
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `bans` WHERE `Serial` = '%e' LIMIT 1", serial);
		mysql_tquery(g_SQL, query, "OnPlayerSerialCheck", "d", playerid);
	}
	return 1;
}

function OnPlayerSerialCheck(playerid)
{
	new query[128];
	if(!cache_num_rows())
	{
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `bans` WHERE `IPAddress` = '%e' LIMIT 1", GetUserIP(playerid));
		mysql_tquery(g_SQL, query, "OnPlayerIPCheck", "d", playerid);
	}
	else
	{
		new BanDate, iTime, iExpire, AdminName[MAX_PLAYER_NAME], Reason[128];
		cache_get_value_int(0, "BanDate", iTime);
		cache_get_value_int(0, "UnbanTimestamp", iExpire);
		cache_get_value(0, "Admin", AdminName, sizeof(AdminName));
		cache_get_value(0, "Reason", Reason, sizeof(Reason));

		if(iExpire != 0 && gettime() > iExpire)
		{
			mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `bans` WHERE `IPAddress` = '%e' LIMIT 1", GetUserIP(playerid));
			mysql_tquery(g_SQL, query, "OnPlayerIPCheck", "d", playerid);
			return 1;
		}

		if(iExpire)
		{
			ShowBanMessage(playerid, AdminName, Reason, BanDate, iExpire);
		}
		else ShowBanMessage(playerid, AdminName, Reason, BanDate);
		DelayedKick(playerid);
	}
	return 1;
}

function OnPlayerIPCheck(playerid)
{
	new query[256];
	if(!cache_num_rows())
	{
		// send a query to recieve all the stored player data from the table
		mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", Player[playerid][Name]);
		mysql_tquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	}
	else
	{
		new BanDate, iExpire, AdminName[MAX_PLAYER_NAME], Reason[128], iTime;
		cache_get_value_int(0, "BanDate", iTime);
		cache_get_value_int(0, "UnbanTimestamp", iExpire);
		cache_get_value(0, "Admin", AdminName, sizeof(AdminName));
		cache_get_value(0, "Reason", Reason, sizeof(Reason));

		if(iExpire != 0 && gettime() > iExpire)
		{
			mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", Player[playerid][Name]);
			mysql_tquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
			return 1;
		}

		if(iExpire)
		{
			ShowBanMessage(playerid, AdminName, Reason, BanDate, iExpire);
		}
		else ShowBanMessage(playerid, AdminName, Reason, BanDate);
		DelayedKick(playerid);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new reasonString[20], string[128];
	switch(reason)
	{
		case 0:
		{
			reasonString = "timed out";
			PlayerInfo[playerid][pCrashed] = 1;
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
			GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastPos][3]);
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastVW] = GetPlayerVirtualWorld(playerid);
			
		}
		case 1:
		{
			reasonString = "quit";
			PlayerInfo[playerid][pConnectedTime] = 0;
		}
		case 2:
		{
			reasonString = "been kicked/banned";
			PlayerInfo[playerid][pConnectedTime] = 0;
		}
	}

	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "** %s (%s) has %s.", GetUserName(playerid), GetMasterName(playerid), reasonString);

	Player[playerid][LastActive] = gettime();
	if(IsOnDuty(playerid) && PlayerInfo[playerid][pBeforeSkin] != 0)
	{
		PlayerInfo[playerid][pSkin] = PlayerInfo[playerid][pBeforeSkin];
	}
	else PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);
	UpdatePlayerData(playerid);

	PlayerTextDrawDestroy(playerid, VehicleSpeedo[playerid]);
	TextDrawHideForPlayer(playerid, ServerCurrentTime);

	if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pScene]))
	{
		DestroyDynamic3DTextLabel(PlayerInfo[playerid][pScene]);
	}

	if(TempVar[playerid][TalkingLive] == true)
    {
        foreach(new i: Player)
        {
            if(TempVar[i][TalkingLive] == true)
            {
                TempVar[i][TalkingLive] = false;
                SendClientMessage(i, COLOR_LIGHTBLUE, "* You are now off air as the other person disconnected.");
            }
        }
        return 1;
    }

	if(PlayerInfo[playerid][pHandcuffed] == 1)
	{
		format (string, sizeof(string), "%s (%s) has %s whilst handcuffed.", GetUserName(playerid), GetMasterName(playerid), reasonString); 
		SendAdminWarning(1, string);
	}

	g_MysqlRaceCheck[playerid]++;

	// if the player was kicked (either wrong password or taking too long) during the login part, remove the data from the memory
	if (cache_is_valid(Player[playerid][Cache_ID]))
	{
		cache_delete(Player[playerid][Cache_ID]);
		Player[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}

	// if the player was kicked before the time expires (30 seconds), kill the timer
	if (Player[playerid][LoginTimer])
	{
		KillTimer(Player[playerid][LoginTimer]);
		Player[playerid][LoginTimer] = 0;
	}

	// sets "IsLoggedIn" to false when the player disconnects, it prevents from saving the player data twice when "gmx" is used
	mysql_format(g_SQL, string, sizeof string, "UPDATE `players` SET `IsLoggedIn` = 0 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
    mysql_tquery(g_SQL, string);
	Player[playerid][IsLoggedIn] = false;

	foreach(new i: Player)
	{
		if(TempVar[playerid][ConnectEnabled] == true)
		{
			SendClientMessageEx(i, COLOR_GREY, "[DISCONNECT]: %s (%d) has disconnected from the server.", GetUserName(playerid), playerid);
		}
	}
	return 1;
}

function SendToSpawn(playerid)
{
	SetPlayerTime(playerid, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
	SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);

	SetPlayerTeam(playerid, PLAYER_ALIVE); 

	// Prevent players from dual wielding weapons.
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 998);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 998);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 998);
	
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 999);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 999);

	SetCameraBehindPlayer(playerid);
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);
	SetPlayerHealthEx(playerid, 100);
	TextDrawShowForPlayer(playerid, ServerCurrentTime);

	if(Player[playerid][PassedTutorial] == 0)
	{
		StartTutorial(playerid);
		return 1;
	}

	if(TutorialStage[playerid] == 11)
	{
		TutorialStage[playerid] = 0;
		SetPlayerPosEx(playerid, -152.2196, 1088.0068, 19.7422);
		SetCameraBehindPlayer(playerid);
		SetPlayerFacingAngle(playerid, 0);
		SetInterior(playerid, 0);
		SetVirtualWorld(playerid, 0);
		PlayerInfo[playerid][pMoney] = 500;
		PlayerInfo[playerid][pBank] = 1000;

		SendClientMessage(playerid, COLOR_YELLOW2, "Welcome to United Gaming Roleplay, we hope you enjoy your stay.");
		SendClientMessage(playerid, COLOR_YELLOW2, "If you need some assistance, use /helpme and a helper will respond as soon as possible.");
		UpdatePlayerData(playerid);
		SetPlayerTeamColour(playerid);
		return 1;
	}

	SetPlayerTeamColour(playerid);
	if(Player[playerid][Ajailed] == 1)
	{
		SetInterior(playerid, 6);
        SetVirtualWorld(playerid, playerid+100);
        SetPlayerPosEx(playerid, 264.8460, 77.6047, 1001.2493);
        TogglePlayerWait(playerid);
		return 1;
	}

	// spawn the player to their last saved position
	if(TempVar[playerid][Spectating] != INVALID_PLAYER_ID)
	{
		SetPlayerInterior(playerid,GetPVarInt(playerid, "Int"));
		SetPlayerVirtualWorld(playerid,GetPVarInt(playerid, "World"));
		SetPlayerPosEx(playerid,GetPVarFloat(playerid,"MarkX"),GetPVarFloat(playerid,"MarkY"),GetPVarFloat(playerid,"MarkZ"));
		SetCameraBehindPlayer(playerid);
		TempVar[playerid][Spectating] = INVALID_PLAYER_ID;
		GiveSavedWeapons(playerid);
		if(GetPVarInt(playerid, "Int") >= 1)
		{
			TogglePlayerWait(playerid);
		}
		return 1;
	}

	if(PlayerInfo[playerid][pCrashed] == 1)
	{
		PrintFooter(playerid, "Crashed, returning to last position...", 5);
		if(PlayerInfo[playerid][pHealth] < 1)
		{
			PlayerInfo[playerid][pHealth] = 99;
		}
		PlayerInfo[playerid][pCrashed] = 0;
		SetPlayerHealthEx(playerid, PlayerInfo[playerid][pHealth]);
		SetPlayerArmourEx(playerid, PlayerInfo[playerid][pArmour]);
		SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);
		SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastVW]);
		SetPlayerPosEx(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastPos][3]);
		GiveSavedWeapons(playerid);
		return 1;
	}
	PlayerInfo[playerid][pFactionDuty] = 0;

	if((TempVar[playerid][AcceptedDeath] == true) || (TempVar[playerid][OnPlayerDeathTriggered] == true && GetPlayerTeam(playerid) != PLAYER_ALIVE))
	{
		SetPlayerHealthEx(playerid, 100);
		SetPlayerArmourEx(playerid, 0);
		SetPlayerPosEx(playerid, -316.2051, 1056.0616, 19.7248);
		SetPlayerFacingAngle(playerid, 180);
		SetInterior(playerid, 0);
		SetVirtualWorld(playerid, 0);
		ResetDamages(playerid);
		new price = percent(PlayerInfo[playerid][pMoney], 20);
		if(price >= 100)
		{
			SendClientMessageEx(playerid, COLOR_MEDIC, "EMS: Your medical bills are $%s.", FormatNumber(price));
			TakeMoney(playerid, price);// Take 20 percent of the users money to cover medical fee's. 20% so that we can control the economy.
		}
		else
		{
			SendClientMessage(playerid, COLOR_MEDIC, "EMS: The state has covered your medical bills.");
		}
		return 1;
	}

	if(TempVar[playerid][OnPlayerDeathTriggered] == true)
	{
		SetPlayerTeam(playerid, PLAYER_WOUNDED);
		SetPlayerHealthEx(playerid, 100);
		SetPlayerArmourEx(playerid, 0);
		SetPlayerPosEx(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastPos][3]);
		SetInterior(playerid, PlayerInfo[playerid][pLastInterior]);
		SetVirtualWorld(playerid, PlayerInfo[playerid][pLastVW]);
		return 1;
	}

	if(PlayerInfo[playerid][pJailed] >= 1)
	{
		switch(PlayerInfo[playerid][pJailed])
		{
			case 1:
			{
				SetPlayerHealthEx(playerid, 100);
				SendToJail(playerid, PlayerInfo[playerid][pJailID]);
			}
		}
		return 1;
	}

	if(GetPlayerHouses(playerid) > 0 && PlayerInfo[playerid][pSpawn] == 1)
	{
		new houseid = PlayerInfo[playerid][pHouseSpawnID];
		printf("HouseID: %d", houseid);
		if(houseid != -1 && GetHouseOwnerID(houseid) == PlayerInfo[playerid][pCharacterID])
		{
			SendToHouse(playerid, houseid);
			GiveSavedWeapons(playerid);
			return 1;
		}
	}
	if(PlayerInfo[playerid][pRenting] != -1 && PlayerInfo[playerid][pSpawn] == 1)
	{
		SendToHouse(playerid, PlayerInfo[playerid][pRenting]);
		GiveSavedWeapons(playerid);
		return 1;
	}
	if(PlayerInfo[playerid][pFaction] > 0 && PlayerInfo[playerid][pSpawn] == 2)
	{
		new factionid = PlayerInfo[playerid][pFaction];
		SetPlayerPosEx(playerid, FactionInfo[factionid][FactionSpawn][0], FactionInfo[factionid][FactionSpawn][1], FactionInfo[factionid][FactionSpawn][2]);
		if(FactionInfo[factionid][FactionSpawnInt] > 0)
		{
			TogglePlayerWait(playerid);
		}
        SetInterior(playerid, FactionInfo[factionid][FactionSpawnInt]);
        SetVirtualWorld(playerid, FactionInfo[factionid][FactionSpawnWorld]);
		GiveSavedWeapons(playerid);
		return 1;
	}
	SetPlayerHealthEx(playerid, 100);
	SetPlayerArmourEx(playerid, PlayerInfo[playerid][pArmour]);
	SetPlayerPosEx(playerid, -152.2196, 1088.0068, 19.7422);
	SetPlayerFacingAngle(playerid, 0);
	SetInterior(playerid, 0);
	SetVirtualWorld(playerid, 0);
	SetPlayerTeam(playerid, PLAYER_ALIVE);
	GiveSavedWeapons(playerid);
	return 1;
}

stock GiveSavedWeapons(playerid)
{
	if(!IsWeaponRestricted(playerid))
	{
		if(PlayerInfo[playerid][pPrimaryWeapon] >= 0 && PlayerInfo[playerid][pPrimaryAmmo] >= 0)
		{
			GivePlayerGun(playerid, PlayerInfo[playerid][pPrimaryWeapon], PlayerInfo[playerid][pPrimaryAmmo], PlayerInfo[playerid][pPrimarySerial], false);
		}
		if(PlayerInfo[playerid][pSecondaryWeapon] >= 0 && PlayerInfo[playerid][pSecondaryAmmo] >= 0)
		{
			GivePlayerGun(playerid, PlayerInfo[playerid][pSecondaryWeapon], PlayerInfo[playerid][pSecondaryAmmo], PlayerInfo[playerid][pSecondarySerial], false);
		}
		if(PlayerInfo[playerid][pMeleeWeapon] >= 0)
		{
			GivePlayerGun(playerid, PlayerInfo[playerid][pMeleeWeapon], 1, 0, false);
		}
		if(PlayerInfo[playerid][pOtherWeapon] >= 0)
		{
			GivePlayerGun(playerid, PlayerInfo[playerid][pOtherWeapon], 1, 0, false);
		}
	}
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		SetPlayerPosEx(playerid, 0, 0, 0);
		TogglePlayerControllable(playerid, 0);
		return 1;
	}

	if(Player[playerid][IsLoggedIn] == false)
	{
		SetPlayerLoginCamera(playerid);
		return 1;
	}

	UpdateSpectator(playerid);

	// Preload Animations
	if(TempVar[playerid][AnimPreloaded] == false)
	{
		PreloadAnimations(playerid);
		TempVar[playerid][AnimPreloaded] = true;
	}

	SetPlayerPosEx(playerid, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z);
	SetPlayerFacingAngle(playerid, DEFAULT_POS_A);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	ResetDamages(playerid);

	SetTimerEx("SendToSpawn", 500, false, "d", playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	SetPlayerTeam(playerid, PLAYER_DEAD);
	UpdatePlayerDeaths(playerid);
	UpdatePlayerKills(killerid);
	TakePlayerGuns(playerid);

	new string[128];
	if(killerid != INVALID_PLAYER_ID)
	{
		SendAdminMessage(COLOR_ORANGE, 1, "[OnPlayerDeath]: %s (ID: %d) was killed by %s (ID: %d) with %s.", GetUserName(playerid), playerid, GetUserName(killerid), killerid, GetDeathReason(reason));
		format(string, sizeof(string), "%s (IP: %s AccountID: %d) was killed by %s (IP: %s AccountID: %d). Weapon: %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(killerid), GetUserIP(killerid), Player[killerid][ID], GetDeathReason(reason));
		DBLog("OnPlayerDeath", string);
	}
	else
	{
		SendAdminMessage(COLOR_ORANGE, 1, "[OnPlayerDeath]: %s (ID: %d) was killed due to %s.", GetUserName(playerid), playerid, GetDeathReason(reason));
		format(string, sizeof(string), "%s (IP: %s AccountID: %d) was killed. Reason: %d", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], reason);
		DBLog("OnPlayerDeath", string);
	}
	if(TempVar[playerid][AcceptedDeath] == false)
	{
		if(TempVar[playerid][OnPlayerDeathTriggered] == false)
		{
			TempVar[playerid][OnPlayerDeathTriggered] = true;
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPos][0], PlayerInfo[playerid][pLastPos][1], PlayerInfo[playerid][pLastPos][2]);
			GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pLastPos][3]);
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastVW] = GetPlayerVirtualWorld(playerid);
		}
	}
	if(IsPlayerConnected(killerid) && Player[killerid][AdminLevel] < 1 && GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
	{
		switch(reason)
		{
			case 49:
			{
				format(string, sizeof(string), "%s (ID: %d) was car-rammed by %s (ID: %s).", GetUserName(playerid), playerid, GetUserName(killerid), killerid);
				SendAdminWarning(1, string);
				format(string, sizeof(string), "%s (IP: %s AccountID: %d) was car-rammed by %s (IP: %s AccountID: %d).", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(killerid), GetUserIP(killerid), Player[killerid][ID]);
				DBLog("Abuse", string);
			}
			case 50:
			{
				format(string, sizeof(string), "%s (ID: %d) was helibladed by %s (ID: %s).", GetUserName(playerid), playerid, GetUserName(killerid), killerid);
				SendAdminWarning(1, string);
				format(string, sizeof(string), "%s (IP: %s AccountID: %d) was helibladed by %s (IP: %s AccountID: %d).", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(killerid), GetUserIP(killerid), Player[killerid][ID]);
				DBLog("Abuse", string);
			}
			default:
			{
				switch(GetPlayerWeapon(killerid))
				{
					case 32, 28, 29:
					{
						format(string, sizeof(string), "%s (ID: %d) was Driver Driveby'd by %s (ID: %s).", GetUserName(playerid), playerid, GetUserName(killerid), killerid);
						SendAdminWarning(1, string);
						format(string, sizeof(string), "%s (IP: %s AccountID: %d) was Driver Driveby'd by %s (IP: %s AccountID: %d).", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(killerid), GetUserIP(killerid), Player[killerid][ID]);
						DBLog("Abuse", string);
						SendClientMessage(playerid, COLOR_LIGHTRED, "Driver Driveby is not allowed, administrators have been notified.");
					}
				}
			}
		}
	}
	return 1;
}

function OnCheckLoginBan(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		new BanDate, AdminName[MAX_PLAYER_NAME], Reason[128], iTime;
		cache_get_value_int(0, "BanDate", iTime);
		cache_get_value(0, "Admin", AdminName, sizeof(AdminName));
		cache_get_value(0, "Reason", Reason, sizeof(Reason));
		cache_get_value_int(0, "UnbanTimestamp", iTime);
		
		if(iTime == 0)
		{
			ShowBanMessage(playerid, AdminName, Reason, BanDate);
			DelayedKick(playerid);
			return 1;
		}

		if(gettime() > iTime)
		{
			new query[128]; 
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `bans` WHERE `AccountID` = %d LIMIT 1", Player[playerid][ID]);
			mysql_tquery(g_SQL, query, "ShowCharacterMenu", "d", playerid);
		}
		else
		{
			ShowBanMessage(playerid, AdminName, Reason, BanDate, iTime);
			DelayedKick(playerid);
		}
	}
	else ShowCharacterMenu(playerid);
	return 1;
}

stock OnChangePassword(playerid, inputtext[], callback[])
{
	for (new i = 0; i < 16; i++) Player[playerid][Salt][i] = random(94) + 33;
	SHA256_PassHash(inputtext, Player[playerid][Salt], Player[playerid][Password], 65);

	new query[350];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `password` = '%e', `ChangePassword` = 0 WHERE `id` = %d LIMIT 1", Player[playerid][Password], Player[playerid][ID]);
	mysql_tquery(g_SQL, query, callback, "d", playerid);
	return 1;
}

Dialog:CHANGE_PASSWORD_LOGIN(playerid, response, listitem, inputtext[])
{
	if (!response) return DelayedKick(playerid);

	if (strlen(inputtext) <= 5) return Dialog_Show(playerid, CHANGE_PASSWORD_LOGIN, DIALOG_STYLE_PASSWORD, "Change Password", "Your password must be more than 5 characters long!\n\nYou must change your password before proceeding.", "Continue", "Cancel");

	OnChangePassword(playerid, inputtext, "OnLoginPassChange");
	return 1;
}

function OnLoginPassChange(playerid)
{
	SendServerMessage(playerid, "Your password has been changed.");
	Player[playerid][ChangePassword] = 0;
	ShowCharacterMenu(playerid);
	return 1;
}

Dialog:SECRET_WORD_INPUT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new hashed_pass[65], string[128];
		SHA256_PassHash(inputtext, Player[playerid][Salt], hashed_pass, 65);

		if (strcmp(hashed_pass, Player[playerid][SecretWord]) == 0)
		{
			SendServerMessage(playerid, "Correct secret word.");
			HandleUserLogin(playerid);
		}
		else
		{
			format(string, sizeof(string), "%s has entered an incorrect secret word, they've been autokicked.", GetMasterName(playerid));
			SendAdminWarning(1, string);
			SendServerMessage(playerid, "Wrong Secret Word, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

function HandleUserLogin(playerid)
{
	new string[128];

	format(Player[playerid][StoredIP], 128, "%s", GetUserIP(playerid));
	format(Player[playerid][StoredGPCI], 41, "%s", GetUserGPCI(playerid));
	Player[playerid][LastActive] = gettime();

	if (Player[playerid][AdminLevel] > 5 || Player[playerid][AdminLevel] < 0)
	{
		format(string, sizeof(string), "%s has attempted to log in with Admin Level %d.", GetMasterName(playerid), Player[playerid][AdminLevel]);
		SendAdminWarning(4, string);
		Player[playerid][AdminLevel] = 0;
		SetPVarInt(playerid, "AdminLevel", 0);
	}

	mysql_format(g_SQL, string, sizeof(string), "SELECT `Name` FROM `characters` WHERE `OwnerID` = %d LIMIT %d", Player[playerid][ID], MAX_CHARACTERS);
	mysql_tquery(g_SQL, string, "OnGetCharacters", "i", playerid);
}

Dialog:RP_TEST_1(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 1)
		{
			ClearChat(playerid, 20);
			SendClientMessage(playerid, COLOR_YELLOW2, "Question 2: What is DM?");
			Dialog_Show(playerid, RP_TEST_2, DIALOG_STYLE_LIST, "What is DM?", "Deathmatch\nDark Matter\nDeath Montage", "Continue", "Cancel");
		}
		else
		{
			SendErrorMessage(playerid, "Wrong answer, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

Dialog:RP_TEST_2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			ClearChat(playerid, 20);
			SendClientMessage(playerid, COLOR_YELLOW2, "Question 3: What is MG?");
			Dialog_Show(playerid, RP_TEST_3, DIALOG_STYLE_LIST, "What is MG?", "Mighty Game\nMorris Garages\nMetagame", "Continue", "Cancel");
		}
		else
		{
			SendErrorMessage(playerid, "Wrong answer, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

Dialog:RP_TEST_3(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 2)
		{
			ClearChat(playerid, 20);
			SendClientMessage(playerid, COLOR_YELLOW2, "Question 4: What is our policy on sex roleplay?");
			Dialog_Show(playerid, RP_TEST_4, DIALOG_STYLE_LIST, "What is our sex policy?", "There is no policy on it.\nMust be done in private and with OOC consent\nIt is not allowed at all.", "Continue", "Cancel");
		}
		else
		{
			SendErrorMessage(playerid, "Wrong answer, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

Dialog:RP_TEST_4(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 1)
		{
			ClearChat(playerid, 20);
			SendClientMessage(playerid, COLOR_YELLOW2, "Question 5: What is our policy on binds?");
			Dialog_Show(playerid, RP_TEST_5, DIALOG_STYLE_LIST, "What is our binds policy?", "You can only use it to enhance RP, not to automate RP.\nBinds are not allowed at all.\nThere is no policy.", "Continue", "Cancel");
		}
		else
		{
			SendErrorMessage(playerid, "Wrong answer, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

Dialog:RP_TEST_5(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == 0)
		{
			ClearChat(playerid, 20);
			SendServerMessage(playerid, "You have passed the RP test, you can now proceed to the server.");
			Player[playerid][PassedTest] = 1;
			new val[11];
			format(val, sizeof val, "%d", Player[playerid][ID]);
			SQL_SetInt("players", "PassedTest", "id", val, 1);
			ShowCharacterMenu(playerid);
		}
		else
		{
			SendErrorMessage(playerid, "Wrong answer, you have been kicked.");
			DelayedKick(playerid);
		}
	}
	else DelayedKick(playerid);
	return 1;
}

function ShowCharacterMenu(playerid)
{
	if(Player[playerid][PassedTest] == 0)
	{
		ClearChat(playerid, 20);
		SendClientMessage(playerid, COLOR_YELLOW2, "Question 1: What is RP?");
		Dialog_Show(playerid, RP_TEST_1, DIALOG_STYLE_LIST, "What is RP?", "Rockers Paradise\nRoleplay\nRaster Pixel", "Continue", "Cancel");
		return 1;
	}
	/*if(Player[playerid][PassedTest] == 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}You have not completed the roleplay test.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "WARNING: {FFFFFF}You can complete it at https://dc-rp.com/");
		DelayedKick(playerid);
		return 1;
	}*/
	

	if(Player[playerid][ChangePassword] == 1)
	{
		Dialog_Show(playerid, CHANGE_PASSWORD_LOGIN, DIALOG_STYLE_PASSWORD, "Change Password", "You must change your password before proceeding.", "Continue", "Cancel");
		return 1;
	}

	if(strlen(Player[playerid][SecretWord]) < 1)
	{
		Dialog_Show(playerid, DIALOG_SECRETWORD_LOGIN, DIALOG_STYLE_PASSWORD, "Secret Word", "{FFFFFF}SECURITY PRECAUTION:\n\n\
		We have a SECRET CONFIRMATION CODE system in place to help protect user accounts. This is basically a word that will be presented if any connection conditions change.\n\nYou will have to remember this.\n\n\
		{F81414}This should {FFFF00}NOT{F81414} be the same as your password.", "Enter", "Cancel");
		return 1;
	}

	// Check if the IP and GPCI matches whatever is stored in the database, if one of the two do not match, show a secret word popup.
	if(strcmp(GetUserIP(playerid), Player[playerid][StoredIP], true) || strcmp(GetUserGPCI(playerid), Player[playerid][StoredGPCI], true))
	{
		Dialog_Show(playerid, SECRET_WORD_INPUT, DIALOG_STYLE_PASSWORD, "Security Precaution", "Please type in your secret word that you used during login\nIf you forgot your secret word, please file a support .", "Continue", "Cancel");
		return 1;
	}
	HandleUserLogin(playerid);
	return 1;
}

function OnGetCharacters(playerid)
{
	new diaStr[128], rows = cache_num_rows();

	if (rows > 0)
	{
		CurrentCharacters[playerid] = rows;
		for (new i = 0; i < CurrentCharacters[playerid]; i ++) 
		{
		    cache_get_value_name(i, "Name", CharacterNames[playerid][i], MAX_PLAYER_NAME + 1);
			format(diaStr, sizeof(diaStr), "%s%d. %s\n", diaStr, i + 1, CharacterNames[playerid][i]);
	    }
	    format(diaStr, sizeof(diaStr), "%s{FFFF00}Create new character", diaStr);
		Dialog_Show(playerid, SELECT_CHARACTER, DIALOG_STYLE_LIST, "Choose your Character", diaStr, "Select", "Quit");
		if(TempVar[playerid][WelcomeShown] == false)
		{
			ClearChat(playerid, 20);
			TempVar[playerid][WelcomeShown] = true;
			SendClientMessageEx(playerid, COLOR_YELLOW2, "Successfully logged in! Welcome back to our server, %s. We hope you enjoy your stay.", GetMasterName(playerid));
			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

			if(Player[playerid][DonateLevel] >= 1 && gettime() >= Player[playerid][DonateExpire])
			{
				Player[playerid][DonateLevel] = 0;
				Player[playerid][DonateExpire] = 0;
				SendServerMessage(playerid, "Your donator rank has expired.");
				format(diaStr, sizeof diaStr, "The donator status of %s (ID: %d) expired.", GetUserName(playerid), playerid);
				SendAdminCommand(diaStr, 5);
				format(diaStr, sizeof diaStr, "The donator status of %s (IP: %s AccountID: %d) expired.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Donate", diaStr);
			}
		}
	}
	else
	{
		if(Player[playerid][PassedTest] == 0)
		{
			ClearChat(playerid, 20);
			SendClientMessage(playerid, COLOR_YELLOW2, "Question 1: What is RP?");
			Dialog_Show(playerid, RP_TEST_1, DIALOG_STYLE_LIST, "What is RP?", "Rockers Paradise\nRoleplay\nRaster Pixel", "Continue", "Cancel");
			return 1;
		}
		StartCharacterCreation(playerid);
	}
	return 1;
}

Dialog:SELECT_CHARACTER(playerid, response, listitem, inputtext[])
{
	new string[128];
	if (response)
	{
		// A redesigned algorithm.
		if(listitem >= MAX_CHARACTERS)
		{
			SendErrorMessage(playerid, "You have reached the max amount of characters (Max: "#MAX_CHARACTERS")");
			ShowCharacterMenu(playerid);
			return 1;
		}
		if(strlen(CharacterNames[playerid][listitem]) < 1)
		{
			StartCharacterCreation(playerid);
		}
		else
		{
			mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM `characters` WHERE `Name` = '%e' LIMIT 1", CharacterNames[playerid][listitem]);
			mysql_tquery(g_SQL, string, "OnCharacterSelect", "ii", playerid, listitem);
		}
	}
	else
	{
		DelayedKick(playerid);
	}
	return 1;
}

function OnCharacterSelect(playerid, listitem)
{
	new string[128];
	cache_get_value_int(0, "CharacterID", PlayerInfo[playerid][pCharacterID]);
	cache_get_value_int(0, "OwnerID", PlayerInfo[playerid][pOwnerID]);

	cache_get_value(0, "Name", PlayerInfo[playerid][pName], MAX_PLAYER_NAME);

	cache_get_value_int(0, "Level", PlayerInfo[playerid][pLevel]);
	cache_get_value_int(0, "Expierience", PlayerInfo[playerid][pExpierience]);
	cache_get_value_int(0, "Hours", PlayerInfo[playerid][pHours]);
	cache_get_value_int(0, "Crashed", PlayerInfo[playerid][pCrashed]);

	cache_get_value_float(0, "LastPosX", PlayerInfo[playerid][pLastPos][0]);
	cache_get_value_float(0, "LastPosY", PlayerInfo[playerid][pLastPos][1]);
	cache_get_value_float(0, "LastPosZ", PlayerInfo[playerid][pLastPos][2]);
	cache_get_value_float(0, "LastPosA", PlayerInfo[playerid][pLastPos][3]);

	cache_get_value_int(0, "LastInterior", PlayerInfo[playerid][pLastInterior]);
	cache_get_value_int(0, "LastVW", PlayerInfo[playerid][pLastVW]);
	cache_get_value_int(0, "Money", PlayerInfo[playerid][pMoney]);
	cache_get_value_int(0, "Bank", PlayerInfo[playerid][pBank]);
	cache_get_value_int(0, "PayCheque", PlayerInfo[playerid][pPayCheque]);
	cache_get_value_int(0, "PhoneNo", PlayerInfo[playerid][pPhoneNo]);
	cache_get_value_int(0, "PhoneType", PlayerInfo[playerid][pPhoneType]);
	cache_get_value_int(0, "Faction", PlayerInfo[playerid][pFaction]);
	cache_get_value_int(0, "FactionRank", PlayerInfo[playerid][pFactionRank]);

	cache_get_value_int(0, "WeaponSpawned1", PlayerInfo[playerid][pWeaponSpawned][0]);
	cache_get_value_int(0, "WeaponSpawned2", PlayerInfo[playerid][pWeaponSpawned][1]);
	cache_get_value_int(0, "WeaponSpawned3", PlayerInfo[playerid][pWeaponSpawned][2]);
	cache_get_value_int(0, "WeaponSpawned4", PlayerInfo[playerid][pWeaponSpawned][3]);
	/*for(new i; i < 4; i++)
	{
		format(string, sizeof(string), "WeaponSpawned%d", i+1);
		cache_get_value_int(0, string, PlayerInfo[playerid][pWeaponSpawned][i]);
	}*/

	cache_get_value_int(0, "Weapon1", PlayerInfo[playerid][pWeapon][0]);
	cache_get_value_int(0, "Weapon2", PlayerInfo[playerid][pWeapon][1]);
	cache_get_value_int(0, "Weapon3", PlayerInfo[playerid][pWeapon][2]);
	cache_get_value_int(0, "Weapon4", PlayerInfo[playerid][pWeapon][3]);
	/*for(new i; i < 4; i++)
	{
		format(string, sizeof(string), "Weapon%d", i+1);
		cache_get_value_int(0, string, PlayerInfo[playerid][pWeapon][i]);
	}*/

	cache_get_value_int(0, "Ammo1", PlayerInfo[playerid][pAmmo][0]);
	cache_get_value_int(0, "Ammo2", PlayerInfo[playerid][pAmmo][1]);
	cache_get_value_int(0, "Ammo3", PlayerInfo[playerid][pAmmo][2]);
	cache_get_value_int(0, "Ammo4", PlayerInfo[playerid][pAmmo][3]);
	/*for(new i; i < 4; i++)
	{
		format(string, sizeof(string), "Ammo%d", i+1);
		cache_get_value_int(0, string, PlayerInfo[playerid][pAmmo][i]);
	}*/

	cache_get_value_int(0, "Handcuffed", PlayerInfo[playerid][pHandcuffed]);
	cache_get_value_int(0, "Radio", PlayerInfo[playerid][pRadio]);

	cache_get_value_int(0, "RadioChan", PlayerInfo[playerid][pRadioChan]);
	/*for(new i; i < 3; i++)
	{
		format(string, sizeof(string), "RadioChan%d", i+1);
		cache_get_value_int(0, string, PlayerInfo[playerid][pRadioChan][i]);
	}*/

	cache_get_value_int(0, "RadioSlot", PlayerInfo[playerid][pRadioSlot]);
	cache_get_value_int(0, "Injured", PlayerInfo[playerid][pInjured]);
	cache_get_value_int(0, "WeaponLicense", PlayerInfo[playerid][pWeaponLicense]);
	cache_get_value_int(0, "DrivingLicense", PlayerInfo[playerid][pDrivingLicense]);
	cache_get_value_int(0, "FlyingLicense", PlayerInfo[playerid][pFlyingLicense]);

	cache_get_value_int(0, "PrisonTimes", PlayerInfo[playerid][pPrisonTimes]);
	cache_get_value_int(0, "JailTimes", PlayerInfo[playerid][pJailTimes]);
	cache_get_value_int(0, "Job", PlayerInfo[playerid][pJob]);
	cache_get_value_int(0, "SideJob", PlayerInfo[playerid][pSideJob]);
	cache_get_value_int(0, "WalkStyle", PlayerInfo[playerid][pWalkStyle]);
	cache_get_value_int(0, "ChatStyle", PlayerInfo[playerid][pChatStyle]);
	cache_get_value_int(0, "Jailed", PlayerInfo[playerid][pJailed]);
	cache_get_value_int(0, "JailID", PlayerInfo[playerid][pJailID]);
	cache_get_value_int(0, "JailTime", PlayerInfo[playerid][pJailTime]);
	cache_get_value_int(0, "Spawn", PlayerInfo[playerid][pSpawn]);
	cache_get_value_int(0, "Skin", PlayerInfo[playerid][pSkin]);
	cache_get_value_int(0, "Gender", PlayerInfo[playerid][pGender]);
	cache_get_value_int(0, "Mask", PlayerInfo[playerid][pMask]);
	cache_get_value_int(0, "MaskID", PlayerInfo[playerid][pMaskID]);

	cache_get_value(0, "LastShot", PlayerInfo[playerid][pLastShot], MAX_PLAYER_NAME);
	cache_get_value_int(0, "LastShotTime", PlayerInfo[playerid][pLastShotTime]);
	cache_get_value_int(0, "DeathMode", PlayerInfo[playerid][pDeathMode]);
	cache_get_value_float(0, "Health", PlayerInfo[playerid][pHealth]);
	cache_get_value_float(0, "Armour", PlayerInfo[playerid][pArmour]);
	cache_get_value_int(0, "SpawnedVehicle", PlayerInfo[playerid][pSpawnedVehicle]);
	cache_get_value_int(0, "DutySkin", PlayerInfo[playerid][pDutySkin]);
	cache_get_value_int(0, "BeforeSkin", PlayerInfo[playerid][pBeforeSkin]);
	cache_get_value_int(0, "FactionDuty", PlayerInfo[playerid][pFactionDuty]);
	cache_get_value_int(0, "Renting", PlayerInfo[playerid][pRenting]);
	cache_get_value_int(0, "ConnectedTime", PlayerInfo[playerid][pConnectedTime]);
	cache_get_value_int(0, "HouseSpawnID", PlayerInfo[playerid][pHouseSpawnID]);
	cache_get_value_int(0, "PrimaryWep", PlayerInfo[playerid][pPrimaryWeapon]);
	cache_get_value_int(0, "PrimaryAmmo", PlayerInfo[playerid][pPrimaryAmmo]);
	cache_get_value_int(0, "PrimarySerial", PlayerInfo[playerid][pPrimarySerial]);
	cache_get_value_int(0, "SecondaryWep", PlayerInfo[playerid][pSecondaryWeapon]);
	cache_get_value_int(0, "SecondaryAmmo", PlayerInfo[playerid][pSecondaryAmmo]);
	cache_get_value_int(0, "SecondarySerial", PlayerInfo[playerid][pSecondarySerial]);
	cache_get_value_int(0, "MeleeWep", PlayerInfo[playerid][pMeleeWeapon]);
	cache_get_value_int(0, "OtherWep", PlayerInfo[playerid][pOtherWeapon]);

	cache_get_value_int(0, "Fish", PlayerInfo[playerid][pFish]);
	cache_get_value_int(0, "FishBait", PlayerInfo[playerid][pFishBait]);
	cache_get_value_float(0, "WeaponX", PlayerInfo[playerid][pWeaponX]);
	cache_get_value_float(0, "WeaponY", PlayerInfo[playerid][pWeaponY]);
	cache_get_value_float(0, "WeaponZ", PlayerInfo[playerid][pWeaponY]);
	cache_get_value_float(0, "WeaponRX", PlayerInfo[playerid][pWeaponRX]);
	cache_get_value_float(0, "WeaponRY", PlayerInfo[playerid][pWeaponRY]);
	cache_get_value_float(0, "WeaponRZ", PlayerInfo[playerid][pWeaponRY]);
	cache_get_value_float(0, "WeaponSX", PlayerInfo[playerid][pWeaponSX]);
	cache_get_value_float(0, "WeaponSY", PlayerInfo[playerid][pWeaponSY]);
	cache_get_value_float(0, "WeaponSZ", PlayerInfo[playerid][pWeaponSY]);
	cache_get_value_int(0, "WeaponBone", PlayerInfo[playerid][pWeaponBone]);
	cache_get_value_int(0, "Savings", PlayerInfo[playerid][pSavings]);
	cache_get_value_int(0, "WireCutter", PlayerInfo[playerid][pWireCutter]);
	cache_get_value_int(0, "Wires", PlayerInfo[playerid][pWires]);
	cache_get_value_int(0, "BadgeNo", PlayerInfo[playerid][pBadgeNo]);
	cache_get_value_int(0, "WeedSeeds", PlayerInfo[playerid][pWeedSeeds]);
	cache_get_value_int(0, "PoppySeeds", PlayerInfo[playerid][pPoppySeeds]);
	cache_get_value_int(0, "Weed", PlayerInfo[playerid][pWeed]);
	cache_get_value_int(0, "Heroin", PlayerInfo[playerid][pHeroin]);
	cache_get_value_int(0, "Opium", PlayerInfo[playerid][pOpium]);
	cache_get_value_int(0, "HoldingInv", PlayerInfo[playerid][pHoldingInv]);
	cache_get_value_int(0, "HoldingInvAmount", PlayerInfo[playerid][pHoldingInvAmount]);
	cache_get_value(0, "Origin", PlayerInfo[playerid][pOrigin], 128);
	cache_get_value_int(0, "Lotto", PlayerInfo[playerid][pLotto]);
	cache_get_value(0, "Accent", PlayerInfo[playerid][pAccent], 128);
	cache_get_value(0, "Apperance", PlayerInfo[playerid][pApperance], 128);

	new query[128];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `accessories` WHERE CharacterID = %d LIMIT %d", PlayerInfo[playerid][pCharacterID], MAX_ACCESSORIES);
	mysql_tquery(g_SQL, query, "OnAccessoryLoad", "d", playerid);

	if(PlayerInfo[playerid][pMaskID] == 0)
	{
		PlayerInfo[playerid][pMaskID] = PlayerInfo[playerid][pCharacterID]+128;
	}

	SetPlayerName(playerid, PlayerInfo[playerid][pName]);

	format(string, sizeof(string), "~w~Welcome~n~~y~ %s", GetUserName(playerid));
	GameTextForPlayer(playerid, string, 1000, 1);
	ShowFlagsToAdmins(playerid);

	SetPlayerPosEx(playerid, -152.2196,1088.0068,19.7422);
	SetPlayerFacingAngle(playerid, 0);

    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    SetPlayerHealthEx(playerid, 100);
    SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, true);

	ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
    SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	SetPlayerTime(playerid, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
	SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);
	SetPlayerTeam(playerid, PLAYER_ALIVE);

	if(Player[playerid][PassedTest] != 0 && Player[playerid][PassedTutorial] != 0)
	{
		if(strlen(ServerInfo[PlayerMOTD]) > 0)
		{
			SendClientMessageEx(playerid, COLOR_GREEN, "|____________ {FFFFFF}Message of the Day{%06x} ____________|", COLOR_GREEN >>> 8);
			SendClientMessageEx(playerid, COLOR_WHITE, ServerInfo[PlayerMOTD]);
		}
	}

	if (Player[playerid][HelperLevel] >= 1)
	{
		new tTime[3], tDate[3], current_date[10];
		gettime(tTime[0], tTime[1], tTime[2]);
		getdate(tDate[0], tDate[1], tDate[2]);

		format(current_date, sizeof current_date, "%02d/%02d/%d", tDate[2], tDate[1], tDate[0]);
		GetHelperAcceptanceCount(playerid, tTime[0], current_date);

		SendServerMessage(playerid, "You logged in as a helper.");
		if(strlen(ServerInfo[HelperMOTD]) > 0)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "Helper MOTD: %s", ServerInfo[HelperMOTD]);
		}
	}

	if (Player[playerid][AdminLevel] >= 1)
	{
		if(strlen(ServerInfo[AdminMOTD]) > 0)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "Admin MOTD: %s", ServerInfo[AdminMOTD]);
		}
		SendServerMessage(playerid, "You logged in as a level %i admin.", Player[playerid][AdminLevel]);
		foreach(new i: Player)
		{
			if (Player[i][AdminLevel] >= 1 && Player[i][AdminLevel] >= Player[playerid][AdminLevel] && i != playerid)
			{
				SendClientMessageEx(i, COLOR_WHITE, "SERVER: %s %s (%s) has logged in.", GetAdminRank(playerid), GetUserName(playerid), GetMasterName(playerid));
			}
		}
	}

	for(new i; i < MAX_DYN_VEH; i++)
	{
		if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0 && VehicleInfo[i][vScriptID] > 0)
		{
			SendServerMessage(playerid, "Your vehicle is still spawned");
			break;
		}
	}

	Player[playerid][IsLoggedIn] = true;
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `IsLoggedIn` = 1 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
	mysql_tquery(g_SQL, query);

	if(!Player[playerid][PassedTutorial])
	{
		StartTutorial(playerid);
	}

	if(Player[playerid][OfflineJailed] == 1)
	{
		Player[playerid][Ajailed] = 1;
		Player[playerid][AjailTime] = Player[playerid][OfflineJailTime]*60;
        SetInterior(playerid, 0);
        SetVirtualWorld(playerid, 65535);
        SetPlayerPosEx(playerid, 2522.9895, -1673.7750, 14.8606);
		PrintFooter(playerid, "~w~You were ~r~Admin Jailed", 5);

		ShowFlagsToAdmins(playerid);

		new insertLog[256];
		
		format(insertLog, sizeof insertLog, "%s was admin jailed by %s. Reason: %s", GetUserName(playerid), Player[playerid][OfflineJailAdmin], Player[playerid][OfflineJailReason]);
        SendAdminCommand(insertLog);

        mysql_format(g_SQL, insertLog, sizeof(insertLog), "INSERT INTO ajail_logs (`JailedDBID`, `JailedName`, `Reason`, `JailedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
        Player[playerid][ID], "SYSTEM", Player[playerid][OfflineJailReason], GetMasterName(playerid), GetDateTime());
        mysql_tquery(g_SQL, insertLog);

		Player[playerid][OfflineJailed] = 0;
		Player[playerid][OfflineJailTime] = 0;
		Player[playerid][OfflineJailReason][0] = 0;
		Player[playerid][OfflineJailAdmin][0] = 0;
	}
	else
	{
		SetPlayerTeamColour(playerid);
		SendToSpawn(playerid);
		LoadPlayerInventory(playerid);
		GiveSavedWeapons(playerid);
	}
	return 1;
}

function OnAccessoryLoad(playerid)
{
	new rows = cache_num_rows();
	if(rows)
	{
		for(new i = 0; i < rows && i < MAX_ACCESSORIES; i++)
		{
			cache_get_value_int(i, "ID", AccInfo[playerid][i][aID]);
			cache_get_value_int(i, "CharacterID", AccInfo[playerid][i][aCharacterID]);
			cache_get_value_int(i, "Bone", AccInfo[playerid][i][aBone]);
			cache_get_value_int(i, "Model", AccInfo[playerid][i][aModel]);
			cache_get_value_float(i, "PosX", AccInfo[playerid][i][aX]);
			cache_get_value_float(i, "PosY", AccInfo[playerid][i][aY]);
			cache_get_value_float(i, "PosZ", AccInfo[playerid][i][aZ]);
			cache_get_value_float(i, "PosRX", AccInfo[playerid][i][aRX]);
			cache_get_value_float(i, "PosRY", AccInfo[playerid][i][aRY]);
			cache_get_value_float(i, "PosRZ", AccInfo[playerid][i][aRZ]);
			cache_get_value_float(i, "PosSX", AccInfo[playerid][i][aSX]);
			cache_get_value_float(i, "PosSY", AccInfo[playerid][i][aSY]);
			cache_get_value_float(i, "PosSZ", AccInfo[playerid][i][aSZ]);
		}
	}
	return 1;
}

function FinalizeLogin(playerid)
{
	new query[70];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `IsLoggedIn` = 1 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
    mysql_tquery(g_SQL, query);
	Player[playerid][IsLoggedIn] = true;

	// spawn the player to their last saved position after login
	SetSpawnInfo(playerid, NO_TEAM, 0, Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos], Player[playerid][A_Pos], 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetSpawnInfo(playerid, NO_TEAM, 0, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z, DEFAULT_POS_A, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 	1;
}

function OnTaser(playerid)
{
	TogglePlayerControllable(playerid, true);
	PrintFooter(playerid, "~w~Taser effects ~b~wore off.", 5);
	SetPlayerDrunkLevel (playerid, 0);
	TempVar[playerid][IsTased] = false;
}

function OnRubberBullet(playerid)
{
	PrintFooter(playerid, "~w~Rubber Bullet effects ~b~wore off.", 5);
	SetPlayerDrunkLevel (playerid, 0);
}


public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsPlayerConnected(issuerid)) return 0;

	if(issuerid != INVALID_PLAYER_ID)
	{
		new Float:health;
		GetPlayerHealth(playerid, health); 
		format(PlayerInfo[playerid][pLastShot], MAX_PLAYER_NAME+1, "%s", GetUserName(issuerid));
		PlayerInfo[playerid][pLastShotTime] = gettime();

		if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
		{
			return 0;
		}

		if(TempVar[issuerid][RubberBullets] == true && GetPlayerWeapon(issuerid) == 25)
		{
			if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
			{
				SendErrorMessage(issuerid, "You cannot tase on-duty administrators.");
				return 0;
			}

			if(!IsPlayerNearPlayer(issuerid, playerid, 15.0))
			{
				SendClientMessageEx(issuerid, COLOR_LIGHTRED, "-> {FFFF00}You aren't close enough to hit %s with your beanbag.", GetRPName(playerid));
				return 0;
			}

			PrintFooter(playerid, "~r~You have been shot with rubber bullets.", 5);
			SendClientMessage(playerid, COLOR_PURPLE, "-> {FFFF00}You were just hit by a rubber bullet.");
			SendAMe(playerid, "was hit with a rubber bullet.");
			StopAnim(playerid);
			
			StopAnim(playerid);
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
			TogglePlayerControllable(playerid, false);
			if(TempVar[playerid][IsTased] == false)
			{
				SetPlayerDrunkLevel(playerid, 10000);
				TempVar[playerid][IsTased] = true;
				SetTimerEx("OnTaser", 5000, false, "d", playerid);
			}
			ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
			return 0;
		}

		if(TempVar[issuerid][HasTaser] == true && GetPlayerWeapon(issuerid) == 23)
		{
			if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
			{
				SendErrorMessage(issuerid, "You cannot tase on-duty administrators.");
				return 0;
			}

			if(!IsPlayerNearPlayer(issuerid, playerid, 10.0))
			{
				SendClientMessageEx(issuerid, COLOR_LIGHTRED, "-> {FFFF00}You aren't close enough to hit %s with your taser.", GetRPName(playerid));
				SendAMe(issuerid, "attempted to use their taser but failed.");
				TasedRecently[issuerid] = 5;
				return 0;
			}

			if(TasedRecently[issuerid] > 0)
			{
				SendErrorMessage(issuerid, "Spamming the taser is ineffective and the reloading time increased as such.");
				SendAMe(issuerid, "attempted to use their taser but failed.");
				TasedRecently[issuerid]++;
				return 0;
			}

			PrintFooter(playerid, "~r~You have been tased.", 5);
			SendClientMessage(playerid, COLOR_PURPLE, "-> {FFFF00}You were just hit by a taser. 50,000 volts go through your body.");
			SetPlayerArmedWeapon(playerid, 0);

			SendAMe(playerid, "has been shot by a taser.");
			StopAnim(playerid);
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			PlayerPlaySound(playerid, 6003, x, y, z);
			ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
			TogglePlayerControllable(playerid, false);
			if(TempVar[playerid][IsTased] == false)
			{
				SetPlayerDrunkLevel (playerid, 10000);
				TempVar[playerid][IsTased] = true;
				SetTimerEx("OnTaser", 10000, false, "d", playerid);
				TasedRecently[issuerid]++;
			}
			ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
			return 0;
		}

		new Float:damage = 0.0, Float:efficientRange = 0.0;

		switch(weaponid)
		{
			case 22: damage = 8.25, efficientRange = 40.0;
			case 23: damage = 13.2, efficientRange = 21.0;
			case 24: damage = 46.20, efficientRange = 60.0;
			case 25: damage = 50.0, efficientRange = 40.0;
			case 26: damage = 49.50, efficientRange = 60.0;
			case 27: damage = 39.60, efficientRange = 80.0;
			case 28: damage = 6.60, efficientRange = 40.0;
			case 29: damage = 8.25, efficientRange = 60.0;
			case 30: damage = 25.90, efficientRange = 100.0;
			case 31: damage = 30.0, efficientRange = 100.0;
			case 32: damage = 6.60, efficientRange = 40.0;
			case 33: damage = 84.75, efficientRange = 100.0;
			case 34: damage = 41.25, efficientRange = 200.0;
			case 41: damage = 2.5, efficientRange = 200.0;
			default: damage = amount, efficientRange = 1000.0;
		}

		if(!IsPlayerNearPlayer(issuerid, playerid, efficientRange))
		{
			// If the attacker is not in range of the player, then reduce the damage by half.
			damage = damage/2;
		}

		if (bodypart == BODY_PART_HEAD && weaponid != 41)
		{
			damage += 20.0;
		}
		if (bodypart == BODY_PART_CHEST || bodypart == BODY_PART_GROIN)
		{
			if(GetArmour(playerid) >= 5)
			{
				if(damage > 5)
				{
					damage -= 5.0;
				}
			}
		}

		AddDamage(playerid, bodypart, weaponid, damage);

		OnPlayerProcessDamage(playerid, issuerid, weaponid, damage, bodypart);
	}
	return 1;
}

function OnDeathNOPCheck(playerid, vid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 || vehicleid == vid)
        {
			if(Player[playerid][AdminLevel] < 1)
			{
				new string[128];
				format(string, sizeof string, "%s (ID: %d) may be NOP hacking - inside vehicle whilst brutally wounded.", GetUserName(playerid), playerid);
				SendAdminWarning(1, string);
				format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - inside vehicle whilst brutally wounded.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Hack", string);
			}
        }
    }
	return 1;
}

function CheckBulletAmount(playerid) 
{
	return 1;
}

stock IsInvalidGunAnim(playerid)
{
	switch(GetPlayerAnimationIndex(playerid))
	{
		case
			320,
			471,
			1164,
			1183,
			1188,
			1189, // PED: IDLE_STANCE
			1196, // PED: JUMP_LAND
			1198, // PED: JUMP_LAUNCH_R
			1223, // PED: RUN_ARMED
			1231, // PED: RUN_PLAYER
			1197, // PED: JUMP_LAUNCH
			1195, // PED: JUMP_GLIDE
			1266, // PED: WALK_PLAYER
			1246, // PED: SPRINT_CIVI
			1066, // PED: PED CLIMB_STAND
			1067, // PED: CLIMB_STAND_FINISH
			224, // BUDDY: BUDDY_RELOAD
			1234, // PED: RUN_STOP
			1132, // PED: FALL_GLIDE
			1133, // PED: FALL_LAND
			1130, // PED: FALL_FALL
			1129, // PED: PED FALL_COLLAPSE
			1207, // PED: KO_SHOT_STOM
			1274, // PED: WEAPON_CROUCH
			1235, // PED: RUN_STOPR
			1233, // PED: RUN_ROCKET
			1225, // PED: RUN_CSAW
			1062, // PED: CLIMB_JUMP
			1065, // PED: CLIMB_PULL
			1159, // PED: GUNCROUCHFWD
			1269, // PED: WALK_START
			1180, // PED: HIT_WALL
			1069, // PED: CROUCH_ROLL_L
			1070: // PED: CROUCH_ROLL_R
			return 1;
	}
	return 0;
}
public OnVehicleSpawn(vehicleid)
{
	for(new i; i < MAX_DYN_VEH; i++)
	{
		if(VehicleInfo[i][vScriptID] == vehicleid)
		{
			VehicleInfo[i][vFuel] = 100.0;
			return 1;
		}
	}
	CoreVehicle[vehicleid][VehicleFuel] = 100.0;
	return 1;
}

stock GhostHackerAction(playerid)
{
	TempVar[playerid][GhostHackWarnings]++;
	if(TempVar[playerid][GhostHackWarnings] > 2)
	{
		new string[128];
		format(string, sizeof string, "%s (%d) may be potentially ghost hacking.", GetUserName(playerid), playerid);
		SendAdminWarning(1, string);
		format(string, sizeof string, "%s (%s) may be potentially ghost hacking.", GetMasterName(playerid), GetUserIP(playerid));
		DBLog("Hack", string);
		TempVar[playerid][GhostHackWarnings] = 0;
	}
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER)
	{
		if(hitid != INVALID_PLAYER_ID) 
		{
			new queryBuffer[256];
			mysql_format(g_SQL, queryBuffer, sizeof(queryBuffer), "INSERT INTO `damages` (`WeaponID`, `Timestamp`, `Attacker`, `Victim`, `Type`) VALUES (%d, %d, %d, %d, %d);", weaponid, gettime(), PlayerInfo[playerid][pCharacterID], PlayerInfo[hitid][pCharacterID], hittype);
			mysql_tquery(g_SQL, queryBuffer);

			new Float:ac_oX, Float:ac_oY, Float:ac_oZ, Float:ac_X, Float:ac_Y, Float:ac_Z;
			GetPlayerLastShotVectors(playerid, ac_oX, ac_oY, ac_oZ, ac_X, ac_Y, ac_Z);
			if(!IsPlayerInRangeOfPoint(playerid, 8.0, ac_oX, ac_oY, ac_oZ))
			{
				if(TempVar[playerid][AFKSeconds] >= 5)
				{
					GhostHackerAction(playerid);
				}
			}
		}
	}
	if(hittype != BULLET_HIT_TYPE_NONE ) // Bullet Crashing uses just this hittype
    {
		new string[128];
		/*
			A valid offset, it's impossible that a offset bigger than 1000 is legit 
			The object with biggest offset is having ~700-800 radius.
		*/
        if(!(-1000.0 <= fX <= 1000.0) || !(-1000.0 <= fY <= 1000.0) || !(-1000.0 <= fZ <= 1000.0))
        {
			format(string, sizeof(string), "%s (%s) was kicked for a possible invalid hit type!", GetUserName(playerid), GetMasterName(playerid));
			SendAdminWarning(1, string);
			format(string, sizeof(string), "%s (%s) was kicked for a possible invalid hit type!", GetMasterName(playerid), GetUserIP(playerid));
            DBLog("Hack", string);
			InsertKickLog(playerid, "SYSTEM", "Invalid Hit Type.");
            DelayedKick(playerid);
            return 0;
        }
	}
	return 1;
}

function OnPlayerProcessDamage(playerid, attackerid, weaponid, Float:amount, bodypart)
{
	new Float:currentHP, Float:currentArmour;
	GetPlayerHealth(playerid, currentHP);
	GetPlayerArmour(playerid, currentArmour);

	if(GetPlayerTeam(playerid) != PLAYER_DEAD)
	{
		if(GetPlayerTeam(playerid) == PLAYER_WOUNDED)
		{
			Player_AcceptDeath(playerid, attackerid, weaponid);
			return 0;
		}

		if(bodypart == BODY_PART_HEAD)
		{
			if(currentHP > 0.0)
			{
				if(currentHP >= amount)
				{
					currentHP -= amount;
				}
				else
				{
					currentHP = 0;
				}
			}
		}
		else
		{
			if(currentArmour > 0.0)
			{
				if(currentArmour >= amount)
				{
					currentArmour -= amount;
				}
				else
				{
					currentHP -= amount - currentArmour;
					currentArmour = 0;
				}
			}
			else if(currentHP > 0.0)
			{
				if(currentHP >= amount)
				{
					currentHP -= amount;
				}
				else
				{
					currentHP = 0;
				}
			}
		}

		SetPlayerArmourEx(playerid, currentArmour < 0.0 ? 0.0 : currentArmour);
		if(currentHP < 10.0)
		{
			StopAnim(playerid);
			if(IsPlayerInAnyVehicle(playerid))
			{
				new Float:slx, Float:sly, Float:slz, vid = GetPlayerVehicleID(playerid);
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPosEx(playerid, slx, sly, slz+1.3);
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("OnDeathNOPCheck", 5000, false, "dd", playerid, vid);
			}
			
			new string[256];
			OnPlayerWounded(playerid, attackerid, weaponid);
			if(attackerid != INVALID_PLAYER_ID)
			{
				format(string, sizeof(string), "%s (IP: %s AccountID: %d) has been brutally wounded by %s (IP: %s AccountID: %d) with %s.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetUserName(attackerid), GetUserIP(attackerid), Player[attackerid][ID], GetServerWeaponName(weaponid));
				DBLog("Wounded", string);
				TempVar[attackerid][RecentKills]++;
				if(TempVar[attackerid][RecentKills] >= 5)
				{
					TempVar[attackerid][RecentKills] = 0;
					format(string, sizeof(string), "%s (%d) has killed multiple people within the last minute.", GetUserName(attackerid), attackerid);
					SendAdminWarning(1, string);
				}
			}
		}
		else SetPlayerHealthEx(playerid, currentHP < 0.0 ? 0.0 :currentHP);

		new string[256];
		if(attackerid != INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%s (IP: %s AccountID: %d) has attacked %s (IP: %s AccountID: %d) with %s.", GetUserName(attackerid), GetUserIP(attackerid), Player[attackerid][ID], GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], GetServerWeaponName(weaponid));
			DBLog("Attack", string);
			mysql_format(g_SQL, string, sizeof string, "INSERT INTO attack_logs (`CharacterID`, `AttackerID`, `AttackerName`, `MaskID`, `Damage`, `Date`) VALUES(%i, %i, '%e', %d, %f, %d)", 
			PlayerInfo[playerid][pCharacterID], PlayerInfo[attackerid][pCharacterID], GetUserName(attackerid), PlayerInfo[attackerid][pMaskID], amount, gettime());
			mysql_tquery(g_SQL, string);
		}
	}
	return 1;
}

stock GetDeathReason(reason)
{
	new reasonName[24];
	switch (reason)
	{
	    case 0:
	        reasonName = "Fist";
		case 1..46:
		    GetWeaponName(reason, reasonName, sizeof(reasonName));
		case 47:
		    reasonName = "Fake Pistol";
		case 49:
		    reasonName = "Vehicle";
		case 50:
		    reasonName = "Helicopter Blades";
		case 51:
		    reasonName = "Explosion";
		case 53:
		    reasonName = "Drowned";
		case 54:
		    reasonName = "Splat";
		default:
			reasonName = "Act of God";
	}
	return reasonName;
}

function OnPlayerWounded(playerid, killerid, reason)
{
	
	TakePlayerGuns(playerid);
	PrintFooter(playerid,"~r~You have been brutally wounded.",1);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "You have been wounded. If you are not saved, you'll die.");
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "To accept death, use \"/accept death\".");
	SetPlayerHealthEx(playerid, 999);
	SetPlayerArmourEx(playerid, 0);
	SetPlayerTeam(playerid, PLAYER_WOUNDED);
	TempVar[playerid][LowHPMessage] = false;
	PlayerInfo[playerid][pPrimaryWeapon] = 0;
	PlayerInfo[playerid][pPrimaryAmmo] = 0;
	PlayerInfo[playerid][pPrimarySerial] = 0;
	PlayerInfo[playerid][pSecondaryWeapon] = 0;
	PlayerInfo[playerid][pSecondaryAmmo] = 0;
	PlayerInfo[playerid][pSecondarySerial] = 0;
	PlayerInfo[playerid][pMeleeWeapon] = 0;
	PlayerInfo[playerid][pOtherWeapon] = 0;
}

stock Player_AcceptDeath(playerid, killerid, weaponid)
{
	OnPlayerDead(playerid, killerid, weaponid);
}

function OnPlayerDead(playerid, killerid, reason)
{
	PrintFooter(playerid,"~r~You have been killed.",1);
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}You have been killed. You can respawn in 1 minute then you can /respawnme.");
	SendServerMessage(playerid, "Medics can no longer revive you, you have been PK'ed. You have also forgotten everything leading up to that event.");
	TempVar[playerid][KillTime] = 60;
	SetPlayerHealthEx(playerid, 999);
	SetPlayerArmourEx(playerid, 0);
	StopAnim(playerid, 1);
	SetPlayerTeam(playerid, PLAYER_DEAD);
	ApplyAnim(playerid, "PED", "KO_skid_front", 4.1, 0, 0, 0, 1, 0, 1);
	TogglePlayerControllable(playerid, false);
	TempVar[playerid][LowHPMessage] = false;
	new query[256];
	if(IsPlayerConnected(killerid))
	{
		mysql_format(g_SQL, query, sizeof query, "INSERT INTO kills (`CharacterID`, `KillerID`, `Date`, `WeaponID`) VALUE (%d, %d, %d, %d)", 
		PlayerInfo[playerid][pCharacterID], PlayerInfo[killerid][pCharacterID], gettime(), reason);
		mysql_tquery(g_SQL, query);
	}
}

/*function OnPlayerRelog(playerid)
{	
	Delete3DTextLabel(TempVar[playerid][RelogID]);
	if(IsValidDynamic3DTextLabel(PlayerInfo[playerid][pScene]))
	{
		DestroyDynamic3DTextLabel(PlayerInfo[playerid][pScene]);
	}
	KillTimer(TempVar[playerid][RelogTimer]); 
	
	TempVar[playerid][Relogging] = false;
	
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0); 
	
	Player[playerid][IsLoggedIn] = false;

	static const empty_pinfo[pData];
	PlayerInfo[playerid] = empty_pinfo;
	PlayerInfo[playerid][pCharacterID] = 0;
	
	SetPlayerName(playerid, Player[playerid][Name]);
	
	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "* %s (%s) has logged out.", GetUserName(playerid), GetMasterName(playerid));
	SetPlayerLoginCamera(playerid);
	ShowCharacterMenu(playerid);
	TextDrawHideForPlayer(playerid, ServerCurrentTime);

	new string[128];
	mysql_format(g_SQL, string, sizeof string, "UPDATE `players` SET `IsLoggedIn` = 0 WHERE `id` = %d LIMIT 1", Player[playerid][ID]);
	mysql_tquery(g_SQL, string);
	format(string, sizeof(string), "%s (IP: %s ID: %d) has has relogged.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
	DBLog("Relog", string);
	return 1;
}*/

stock SetPlayerLoginCamera(playerid)
{
	new rand = random(3);
	switch(rand)
	{
		case 0:
		{
			SetPlayerCameraPos(playerid, -24.9613, 1064.7769, 86.4443);
			SetPlayerCameraLookAt(playerid, -25.9230, 1065.0585, 85.9193);
		}
		case 1:
		{
			SetPlayerCameraPos(playerid, -389.4807, 1281.2430, 128.7377);
			SetPlayerCameraLookAt(playerid, -388.6707, 1280.6594, 128.2626);
		}
		case 2:
		{
			SetPlayerCameraPos(playerid, 22.9374, 1335.9719, 215.8725);
			SetPlayerCameraLookAt(playerid, 22.3512, 1335.1636, 215.0368);
		}
	}
	SetPlayerWeather(playerid, ServerInfo[GlobalWeather]);
	SetPlayerTime(playerid, ServerInfo[CurrentHour], ServerInfo[CurrentMinute]);
	SetPlayerPosEx(playerid, -51.5818, 1071.4899, 14.3978);
	TogglePlayerControllable(playerid, false);
}

stock Float:DistanceCameraTargetToLocation(Float:cx, Float:cy, Float:cz, Float:ox, Float:oy, Float:oz, Float:vx, Float:vy, Float:vz)
{
	new Float:x, Float:y, Float:z, Float:distance;

    distance = floatround(floatsqroot(((cx - ox) * (cx - ox)) + ((cy - oy) * (cy - oy)) + ((cz - oz) * (cz - oz))));

	x = vx * distance + cx;
	y = vy * distance + cy;
	z = vz * distance + cz;

	return floatsqroot((x - ox) * (x - ox) + (y - oy) * (y - oy) + (z - oz) * (z - oz));
}

IsPlayerInRangeOfDynamicObject(playerid, objectid, Float:radius)
{
	if(IsValidDynamicObject(objectid))
	{
		new
		    interiorid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_INTERIOR_ID),
			worldid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_WORLD_ID),
		    Float:x,
		    Float:y,
		    Float:z;

		GetDynamicObjectPos(objectid, x, y, z);

		if(interiorid == -1) {
		    interiorid = GetPlayerInterior(playerid);
		} if(worldid == -1) {
		    worldid = GetPlayerVirtualWorld(playerid);
		}

		if(IsPlayerInRangeOfPoint(playerid, radius, x, y, z) && GetPlayerInterior(playerid) == interiorid && GetPlayerVirtualWorld(playerid) == worldid)
		{
		    return 1;
		}
	}

	return 0;
}

ptask MoneyCheatCheck[1000](playerid)
{
	new string[128];
	if(GetPlayerMoney(playerid) != PlayerInfo[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	}

	if(GetPlayerTeam(playerid) == PLAYER_WOUNDED)
	{
		format(string, sizeof(string), "** This player is brutally wounded. See /injuries %d for damages. **", playerid);
		SetPlayerChatBubble(playerid, string, COLOR_LIGHTRED, 30.0, 1100); 
	}
	else if(GetPlayerTeam(playerid) == PLAYER_DEAD)
	{
		format(string, sizeof(string), "** THIS PLAYER IS DECEASED. **");
		SetPlayerChatBubble(playerid, string, COLOR_LIGHTRED, 30.0, 1100); 
	}
}

public OnPlayerUpdate(playerid)
{
	if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
		SetPlayerHealth(playerid, 999);

	TempVar[playerid][AFKSeconds] = 0;

	new factionid = PlayerInfo[playerid][pFaction], keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);
	if(factionid > 0 && FactionInfo[factionid][FactionMedic] == 1)
	{
		if((keys & KEY_FIRE) && IsFireActive())
		{
			new
				Float:x,
				Float:y,
				Float:z,
				Float:vx,
				Float:vy,
				Float:vz,
				Float:cx,
				Float:cy,
				Float:cz;

			if(GetPlayerWeapon(playerid) == 42 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			{
				for(new i = 0; i < MAX_FIRES; i ++)
				{
					if(IsPlayerInRangeOfDynamicObject(playerid, gFireObjects[i], 4.0))
					{
						gFireHealth[i] = gFireHealth[i] - 1.0;

						if(gFireHealth[i] <= 0.0)
						{
							GetDynamicObjectPos(gFireObjects[i], x, y, z);
							PrintFooter(playerid, "~r~Fire extinguished", 2);

							SetTimerEx("DestroyWater", 2000, false, "i", CreateDynamicObject(18744, x, y, z - 0.2, 0.0, 0.0, 0.0));
							DestroyDynamicObject(gFireObjects[i]);

							gFireObjects[i] = INVALID_OBJECT_ID;
							gFireHealth[i] = 0.0;
						}
					}
				}
			}
			else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && (GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 544))
			{
				GetPlayerCameraFrontVector(playerid, vx, vy, vz);
				GetPlayerCameraPos(playerid, cx, cy, cz);

				for(new i = 0; i < MAX_FIRES; i ++)
				{
					if(IsPlayerInRangeOfDynamicObject(playerid, gFireObjects[i], 12.0))
					{
						GetDynamicObjectPos(gFireObjects[i], x, y, z);

						if(DistanceCameraTargetToLocation(cx, cy, cz, x, y, z + 2.5, vx, vy, vz) < 12.0)
						{
							gFireHealth[i] = gFireHealth[i] - 0.5;

							if(gFireHealth[i] <= 0.0)
							{
								GetDynamicObjectPos(gFireObjects[i], x, y, z);
								PrintFooter(playerid, "~r~Fire extinguished", 2);

								SetTimerEx("DestroyWater", 2000, false, "i", CreateDynamicObject(18744, x, y, z - 0.2, 0.0, 0.0, 0.0));
								DestroyDynamicObject(gFireObjects[i]);

								gFireObjects[i] = INVALID_OBJECT_ID;
								gFireHealth[i] = 0.0;
							}
						}
					}
				}
			}

			if(!IsFireActive())
			{
				gFires = 0;
			}
		}
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		// Tased
		if (GetPlayerAnimationIndex(playerid) != 388 && TempVar[playerid][IsTased] == true)
		{
			ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
		}
	}

	if(PlayerInfo[playerid][pPrimaryWeapon] > 0 && GetPlayerWeapon(playerid) == PlayerInfo[playerid][pPrimaryWeapon])
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_WEAPON))
		{
			RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
		}
	}
	if(PlayerInfo[playerid][pPrimaryWeapon] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_WEAPON))
		{
			RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
		}
	}
	if(GetPlayerMoney(playerid) != PlayerInfo[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
	}
	return 1;
}

stock PreloadAnimLib(playerid,animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0,0,0,0,0,1);
	return 1;
}

stock IsCbugWeapon(playerid)
{
    new weaponID = GetPlayerWeapon(playerid);
    if(weaponID == 22 || weaponID == 24 || weaponID == 25 || weaponID == 27)
    {
		return 1;
    }
	return 0;
}

function OnResetBunnyhop(playerid)
{
	TempVar[playerid][JumpCount] = 0;
}

ptask EngineKeyTimer[1000](playerid)
{
	if(KeyActionTimer[playerid] > 0)
	{
		KeyActionTimer[playerid]--;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(RELEASED(KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && KeyActionTimer[playerid] < 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!HasNoEngine(vehicleid))
		{
			Try_Engine(playerid, vehicleid);
			KeyActionTimer[playerid] = 2;
		}
	}

	if (PRESSED(KEY_JUMP) && PRESSED(KEY_UP))
    {
		if(Player[playerid][AdminLevel] < 1)
		{
			if(!IsPlayerInAnyVehicle(playerid))
			{
				TempVar[playerid][JumpCount]++;
				if(TempVar[playerid][JumpCount] >= 7 && TempVar[playerid][AFKSeconds] < 5)
				{
					new string[128];
					format(string, sizeof(string), "%s (ID: %d) may be bunny hopping.", GetUserName(playerid), playerid);
					SendAdminWarning(1, string);
				}
			}
		}
    }

	if(RELEASED(KEY_SPRINT) && LoopAnim[playerid])
	{
		StopAnim(playerid);
	}
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(Player[playerid][IsLoggedIn] == false && strcmp(cmd, "starttest", true)) // If the player is not logged in and also not using /starttest
		return SendErrorMessage(playerid, "You are not logged in."), 0;
	
	if(strfind(params, "|") != -1 || strfind(params, "\r") != -1 || strfind(params, "\n") != -1)
		return SendErrorMessage(playerid, "You cannot use special characters in commands."), 0;

	if(stringContainsIP(params) && Player[playerid][AdminLevel] < 1)
	{
		new string[256];
		format(string, sizeof string, "%s (%d) may be server advertising: /%s %s", GetUserName(playerid), playerid, cmd, params);
		SendAdminWarning(1, string);
		format(string, sizeof string, "%s (IP: %s AccountID: %s) may be server advertising: /%s %s", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID], cmd, params);
		DBLog("ServerAd", string);
	}

	if(strlen(params) > 0)
	{
		printf("[cmd] [%s]: /%s %s", GetUserName(playerid), cmd, params);
	}
	else printf("[cmd] [%s]: /%s", GetUserName(playerid), cmd);
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags) 
{
	if(TempVar[playerid][IdleTime] > 0)
	{
		TempVar[playerid][IdleTime] = 0; // If they're talking, they can't possibly be AFK.
	}
    if(result == -1)
	{
		if(strlen(cmd) > 28) // Preventing long bad commands from returning default message;
		{
			SendErrorMessage(playerid, "Sorry, that command doesn't exist. Use {%06x}/help{FFFFFF} or {%06x}/helpme{FFFFFF} if you need assistance.", COLOR_LIGHTRED >>> 8, COLOR_LIGHTRED >>> 8); 
		}	
		else 
		{
			SendErrorMessage(playerid, "Sorry, the command \"/%s\" doesn't exist. Use {%06x}/help{FFFFFF} or {%06x}/helpme{FFFFFF} if you need assistance.", cmd, COLOR_LIGHTRED >>> 8, COLOR_LIGHTRED >>> 8);
		}
	}
	else
	{
		new string[256], query[512];
		if(strlen(params) > 0)
		{
			format(string, sizeof string, "[%s(%s) IP: %s AccountID: %d]: /%s %s", GetUserName(playerid), GetMasterName(playerid), GetUserIP(playerid), PlayerInfo[playerid][pCharacterID], cmd, params);
		}
		else
		{
			format(string, sizeof string, "[%s(%s) IP: %s AccountID: %d]: /%s", GetUserName(playerid), GetMasterName(playerid), GetUserIP(playerid), PlayerInfo[playerid][pCharacterID], cmd);
		}
		WriteLog("Logs/cmd.log", string);
		DBLog("Command", string);
		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `cmd_log` (`AccountID`, `UserName`, `Command`, `Params`, `Timestamp`) VALUES (%d, '%e', '%e', '%e', '%d')", Player[playerid][ID], GetUserName(playerid), cmd, params, gettime());
		mysql_tquery(g_SQL, query);
	}
    return 1; 
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		PlayerTextDrawHide(playerid, VehicleSpeedo[playerid]);
		if(TempVar[playerid][TaxiFare] >= 1)
		{
			if(PlayerInfo[playerid][pMoney] < TempVar[playerid][TaxiFare])
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You could not afford the fare!");
				SendClientMessageEx(TempVar[playerid][TaxiDriverID], COLOR_LIGHTRED, "%s could not afford the fare!", GetRPName(playerid));
			}
			else
			{
				TakeMoney(playerid, TempVar[playerid][TaxiFare]);
				GiveMoney(TempVar[playerid][TaxiDriverID], TempVar[playerid][TaxiFare]);
				SendClientMessage(playerid, COLOR_YELLOW, "You have paid your fare.");
				SendClientMessageEx(TempVar[playerid][TaxiDriverID], COLOR_YELLOW, "Passenger %s has paid their fare.", GetRPName(playerid));
			}
			TempVar[playerid][TaxiFare] = 0;
			TempVar[playerid][TaxiDriverID] = INVALID_PLAYER_ID;
		}
		if(TempVar[playerid][DMVTest] >= 1)
		{
			new iVeh = GetPlayerVehicleID(playerid), string[256];
			RemovePlayerFromVehicle(playerid);
			TempVar[playerid][DMVTest] = 0;
			DisablePlayerCheckpoint(playerid);
			SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: You have left the vehicle during the test, you failed!");
			TakeMoney(playerid, 50);
			mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        	mysql_tquery(g_SQL, string);
			SetVehicleToRespawn(iVeh);
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		SetPlayerArmedWeapon(playerid, 0);
		new vehicleid = GetPlayerVehicleID(playerid);
		if(HasNoEngine(vehicleid))
		{
			ToggleVehicleEngine(vehicleid, true);
		}
		for(new i; i < sizeof(AdminVehicle); i++)
		{
			if(vehicleid == AdminVehicle[i])
			{
				SendServerMessage(playerid, "This is an admin spawned vehicle.");
				ToggleVehicleEngine(vehicleid, true);
				break;
			}
		}
		PlayerTextDrawShow(playerid, VehicleSpeedo[playerid]);
		for(new i; i < sizeof(DMVVehicles); i++)
		{
			if(DMVVehicles[i] == GetPlayerVehicleID(playerid))
			{
				if(GetInventory(playerid, INV_DRV_LIC) == 0)
				{
					SendClientMessageEx(playerid, COLOR_YELLOW, "Use /drivingexam to start the driving license exam.");
				}
				else
				{
					SendErrorMessage(playerid, "You already have a driving license.");
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPosEx(playerid, slx, sly, slz+1.3);
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("OnDrivingExamNOPCheck", 2000, false, "dd", playerid, DMVVehicles[i]);
				}
				return 1;
			}
		}

		for(new i; i < sizeof(RentalVehicle); i++)
		{
			if(RentalVehicle[i] == GetPlayerVehicleID(playerid))
			{
				if(RentingVehicle{playerid} == INVALID_VEHICLE_ID)
				{
					PrintFooter(playerid, "~w~You can rent this vehicle using ~g~/rentvehicle~w~.");
					return 1;
				}
			}
		}

		if(CoreVehicle[vehicleid][VehicleEngine] == false)
			PrintFooter(playerid, "~w~The engine of this vehicle is ~r~off~w~. Use ~g~/engine~w~ or press ~g~~k~~CONVERSATION_NO~~w~ key to start.");

		for(new i; i < MAX_DYN_VEH; i++)
		{
			if(VehicleInfo[i][vScriptID] == GetPlayerVehicleID(playerid))
			{
				if(VehicleInfo[i][vOwnerID] == PlayerInfo[playerid][pCharacterID] && VehicleInfo[i][vFactionID] == 0)
				{
					SendClientMessageEx(playerid, COLOR_WHITE, "Welcome to your %s.", ReturnVehicleName(vehicleid));
					if(VehicleInfo[i][vFineAmount] > 0)
					{
						new string[256];
						mysql_format(g_SQL, string, sizeof string, "INSERT INTO `fines` (`UserID`, `OfficerID`, `FactionID`, `Reason`, `Timestamp`, `Amount`) VALUES (%d, %d, %d, '%e', %d, %d)", 
							PlayerInfo[playerid][pCharacterID],VehicleInfo[i][vFineOfficerID],VehicleInfo[i][vFineFactionID], VehicleInfo[i][vFineReason], VehicleInfo[i][vFineTime], VehicleInfo[i][vFineAmount]);
						mysql_tquery(g_SQL, string, "OnGetVehicleFine", "dddds", playerid, VehicleInfo[i][vFineAmount], VehicleInfo[i][vFineFactionID], VehicleInfo[i][vFineOfficerID], VehicleInfo[i][vFineReason]);
					}
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
		new weaponid = GetPlayerWeapon(playerid);
		if(weaponid != 22 && weaponid != 25 && weaponid != 26 && weaponid != 28 && weaponid != 28 && weaponid != 30 && weaponid != 31 && weaponid != 32)
		{
			SetPlayerArmedWeapon(playerid, 0);
		}
	}
	return 1;
}

function OnDrivingExamNOPCheck(playerid, vehicleid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerPing(playerid) < 400) // Check if they are a driver and their ping is below 350.
    {
        if(GetPlayerVehicleID(playerid) == vehicleid)
        {
			if(Player[playerid][AdminLevel] < 1)
			{
				new string[128];
				format(string, sizeof string, "%s (ID: %d) may be NOP hacking - inside driving exam vehicle whilst owning a license.", GetUserName(playerid), playerid);
				SendAdminWarning(1, string);
				format(string, sizeof string, "%s (IP: %s AccountID: %d) may be NOP hacking - inside driving exam vehicle whilst owning a license.", GetUserName(playerid), GetUserIP(playerid), Player[playerid][ID]);
				DBLog("Hack", string);
			}
        }
    }
	return 1;
}

function OnGetVehicleFine(playerid, amount, faction, officerid, reason[])
{
	new string[256];
    mysql_format(g_SQL, string, sizeof string, "INSERT INTO `fines` (`UserID`, `OfficerID`, `FactionID`, `Reason`, `Timestamp`, `Amount`, `Active`) VALUES (%d, %d, %d, '%e', %d, %d, 1);", 
        PlayerInfo[playerid][pCharacterID], officerid, faction, reason, gettime(), amount);
    mysql_tquery(g_SQL, string, "OnAddVehFine", "ddds", playerid, officerid, amount, reason);
    return 1;
}

function OnAddVehFine(playerid, faction, amount, reason[])
{
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}Fine issued on vehicle for $%s. Reason: %s", FormatNumber(amount), reason);
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ ! ] {FFFFFF}You can pay this fine at the town hall.");
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(!IsValidDynamicObject(objectid)) return 1;

	new string[256];
	if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
		switch(TempVar[playerid][EditType])
		{
			case EDIT_TYPE_BOOMBOX:
			{
				new bbid = EditBoomboxID[playerid];
				if(bbid != -1)
				{
					TempVar[playerid][EditType] = 0;
					if(response == EDIT_RESPONSE_FINAL)
					{
						BoomboxInfo[bbid][PosX] = x;
						BoomboxInfo[bbid][PosY] = y;
						BoomboxInfo[bbid][PosZ] = z;
						BoomboxInfo[bbid][PosRX] = rx;
						BoomboxInfo[bbid][PosRY] = ry;
						BoomboxInfo[bbid][PosRZ] = rz;
						BoomboxInfo[bbid][Interior] = GetPlayerInterior(playerid);
						BoomboxInfo[bbid][VirtualWorld] = GetPlayerVirtualWorld(playerid);
						SendServerMessage(playerid, "Boombox position modified.");
					}
					else SendCancelMessage(playerid, "Boombox editing cancelled.");
					ReloadBoombox(bbid);
					Streamer_UpdateEx(playerid, x, y, z);
				}
			}
			case EDIT_TYPE_GARBAGE:
			{
				if(GetPVarInt(playerid, "GarbageID") != -1)
				{
					TempVar[playerid][EditType] = 0;
					new garbageid = GetPVarInt(playerid, "GarbageID");
					if(response == EDIT_RESPONSE_FINAL)
					{
						GarbageData[garbageid][garbagePos][0] = x;
						GarbageData[garbageid][garbagePos][1] = y;
						GarbageData[garbageid][garbagePos][2] = z;
						GarbageData[garbageid][garbagePos][3] = rz;
						GarbageData[garbageid][garbageInterior] = GetPlayerInterior(playerid);
						GarbageData[garbageid][garbageWorld] = GetPlayerVirtualWorld(playerid);
						SendServerMessage(playerid, "Garbage Bin position has been modified.");
						Garbage_Save(garbageid);
					}
					else SendCancelMessage(playerid, "Garbage Bin editing cancelled.");
					Garbage_Refresh(garbageid);
					Streamer_UpdateEx(playerid, x, y, z);
					DeletePVar(playerid, "GarbageID");
				}
			}
			case EDIT_TYPE_EDIT_SPIKES:
			{
				for(new i; i < MAX_SPIKES; i++)
				{
					if(IsValidDynamicObject(Spikes[i][sObjectID]) && TempVar[playerid][EditingRoadblock] == i)
					{
						TempVar[playerid][EditType] = 0;
						if(response == EDIT_RESPONSE_FINAL)
						{
							Spikes[i][sX] = x;
							Spikes[i][sY] = y;
							Spikes[i][sZ] = z;
							Spikes[i][sRX] = rx;
							Spikes[i][sRY] = ry;
							Spikes[i][sRZ] = rz;
						}
						else SendCancelMessage(playerid, "Spike editing cancelled.");
						SetDynamicObjectPos(Spikes[i][sObjectID], Spikes[i][sX], Spikes[i][sY], Spikes[i][sZ]);
						SetDynamicObjectRot(Spikes[i][sObjectID], Spikes[i][sRX], Spikes[i][sRY], Spikes[i][sRZ]);
						Streamer_Update(playerid);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Spike modified.");
						return 1;
					}
				}
			}
			case EDIT_TYPE_ATM:
			{
				if(GetPVarInt(playerid, "AtmID") != -1)
				{
					TempVar[playerid][EditType] = 0;
					new id = GetPVarInt(playerid, "AtmID");
					if(response == EDIT_RESPONSE_FINAL)
					{
						AtmInfo[id][AtmX] = x;
						AtmInfo[id][AtmY] = y;
						AtmInfo[id][AtmZ] = z;
						AtmInfo[id][AtmRX] = rx;
						AtmInfo[id][AtmRY] = ry;
						AtmInfo[id][AtmRZ] = rz;
						AtmInfo[id][AtmInterior] = GetPlayerInterior(playerid);
						AtmInfo[id][AtmWorld] = GetPlayerVirtualWorld(playerid);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* ATM %d's position has been modified.", id);
					}
					else SendCancelMessage(playerid, "ATM editing cancelled.");
					SaveATM(id);
					ReloadATM(id);
					Streamer_UpdateEx(playerid, x, y, z);
					DeletePVar(playerid, "AtmID");
				}
			}
			case EDIT_TYPE_WEED:
			{
				if(GetPVarInt(playerid, "WeedID") != -1)
				{
					TempVar[playerid][EditType] = 0;
					new id = GetPVarInt(playerid, "WeedID");
					if(response == EDIT_RESPONSE_FINAL)
					{
						WeedPlants[id][weedX] = x;
						WeedPlants[id][weedY] = y;
						WeedPlants[id][weedZ] = z;
						WeedPlants[id][weedA] = rz;
						WeedPlants[id][weedInterior] = GetPlayerInterior(playerid);
						WeedPlants[id][weedWorld] = GetPlayerVirtualWorld(playerid);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Plant %d's position has been modified.", id);
					}
					else SendCancelMessage(playerid, "Plant editing cancelled.");
					SaveWeed(id);
					ReloadWeedPlant(id);
					Streamer_UpdateEx(playerid, x, y, z);
					DeletePVar(playerid, "WeedID");
				}
			}
			case EDIT_TYPE_GRAFFITI:
			{
				if(GetPVarInt(playerid, "GraffitiID") != -1)
				{
					TempVar[playerid][EditType] = 0;
					new graffiti = GetPVarInt(playerid, "GraffitiID");
					if(response == EDIT_RESPONSE_FINAL)
					{
						GraffitiInfo[graffiti][GraffitiX] = x;
						GraffitiInfo[graffiti][GraffitiY] = y;
						GraffitiInfo[graffiti][GraffitiZ] = z;
						GraffitiInfo[graffiti][GraffitiA] = rz;
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Graffiti %d's position has been modified.", graffiti);
					}
					else SendCancelMessage(playerid, "Graffiti editing cancelled.");
					SaveGraffiti(graffiti);
					UpdateGraffiti(graffiti);
					Streamer_UpdateEx(playerid, x, y, z);
					DeletePVar(playerid, "GraffitiID");
				}
			}
			case EDIT_TYPE_TRASH:
			{
				if(GetPVarInt(playerid, "EditingTrash") >= 1)
				{
					TempVar[playerid][EditType] = 0;
					new bizID = GetPVarInt(playerid, "EditingTrash");
					if(response == EDIT_RESPONSE_FINAL)
					{
						BusinessInfo[bizID][BizTrashX] = x;
						BusinessInfo[bizID][BizTrashY] = y;
						BusinessInfo[bizID][BizTrashZ] = z;
					}
					else SendCancelMessage(playerid, "Trash editing cancelled.");
					SetDynamicObjectPos(BusinessTrashObject[bizID], BusinessInfo[bizID][BizTrashX], BusinessInfo[bizID][BizTrashY], BusinessInfo[bizID][BizTrashZ]);
					SetDynamicObjectRot(BusinessTrashObject[bizID], 0.0, 0.0, 0.0);
					Streamer_UpdateEx(playerid, BusinessInfo[bizID][BizTrashX], BusinessInfo[bizID][BizTrashY], BusinessInfo[bizID][BizTrashZ]);
					SaveBusiness(bizID);
					DeletePVar(playerid, "EditingTrash");
				}
			}
			case EDIT_TYPE_GAS_PUMP:
			{
				if(GetPVarInt(playerid, "EditingGasPump") >= 1)
				{
					TempVar[playerid][EditType] = 0;
					new pumpID = GetPVarInt(playerid, "EditingGasPump");
					if(response == EDIT_RESPONSE_FINAL)
					{
						GasPump[pumpID][PumpPosX] = x;
						GasPump[pumpID][PumpPosY] = y;
						GasPump[pumpID][PumpPosZ] = z;
						GasPump[pumpID][PumpPosRX] = rx;
						GasPump[pumpID][PumpPosRY] = ry;
						GasPump[pumpID][PumpPosRZ] = rz;
						UpdatePumpPickup(pumpID);
						SavePump(pumpID);
					}
					else SendCancelMessage(playerid, "Gas Pump editing cancelled.");
					Streamer_Update(playerid);
					DeletePVar(playerid, "EditingGasPump");
				}
			}
			case EDIT_TYPE_EDIT_FURNITURE:
			{
				if(TempVar[playerid][EditFurnitureID] > 0)
				{
					TempVar[playerid][EditType] = 0;
					new furnid = TempVar[playerid][EditFurnitureID];
					if(response == EDIT_RESPONSE_FINAL)
					{
						FurnitureInfo[furnid][furX] = x;
						FurnitureInfo[furnid][furY] = y;
						FurnitureInfo[furnid][furZ] = z;
						FurnitureInfo[furnid][furRX] = rx;
						FurnitureInfo[furnid][furRY] = ry;
						FurnitureInfo[furnid][furRZ] = rz;
					}
					else SendCancelMessage(playerid, "Furniture editing cancelled.");
					ReloadFurniture(furnid);
					SaveFurniture(furnid);
					return 1;
				}
			}
			case EDIT_TYPE_BUY_FURNITURE:
			{
				if(IsValidDynamicObject(FurnBuyObject[playerid]) && FurnBuyModel[playerid])
				{
					if(response == EDIT_RESPONSE_FINAL)
					{
						new query[256];
						format(query, sizeof(query), "INSERT INTO `Furniture` (`HouseID`, `ModelID`, `X`, `Y`, `Z`, `RX`, `RY`, `RZ`, `Interior`) VALUES (%d, %d, %f, %f, %f, %f, %f, %f, %d)", 
						GetPlayerVirtualWorld(playerid), FurnBuyModel[playerid], x, y, z, rx, ry, rz, GetPlayerInterior(playerid));
						mysql_tquery(g_SQL, query, "OnCreateFurniture", "dddffffffd", playerid, GetPlayerVirtualWorld(playerid), FurnBuyModel[playerid], x, y, z, rx, ry, rz, GetPlayerInterior(playerid));
					}
					else
					{
						DestroyDynamicObject(FurnBuyObject[playerid]);
						FurnBuyObject[playerid] = INVALID_OBJECT_ID;
						ShowFurnCategory(playerid, SelectedCategory[playerid]);
					}
				}
				else SendErrorMessage(playerid, "There is nothing in FurnBuyObject or FurnBuyModel is empty, post a bug report. (Model: %d, Date/Time: %s)", FurnBuyModel[playerid], GetDateTime());
			}
			case EDIT_TYPE_EDIT_ROADBLOCK:
			{
				for(new i; i < MAX_ROADBLOCKS; i++)
				{
					if(IsValidDynamicObject(Roadblocks[i][rObjectID]) && TempVar[playerid][EditingRoadblock] == i)
					{
						TempVar[playerid][EditType] = 0;
						if(response == EDIT_RESPONSE_FINAL)
						{
							Roadblocks[i][rX] = x;
							Roadblocks[i][rY] = y;
							Roadblocks[i][rZ] = z;
							Roadblocks[i][rRX] = rx;
							Roadblocks[i][rRY] = ry;
							Roadblocks[i][rRZ] = rz;
						}
						SetDynamicObjectPos(Roadblocks[i][rObjectID], Roadblocks[i][rX], Roadblocks[i][rY], Roadblocks[i][rZ]);
						SetDynamicObjectRot(Roadblocks[i][rObjectID], Roadblocks[i][rRX], Roadblocks[i][rRY], Roadblocks[i][rRZ]);
						Streamer_Update(playerid);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* Roadblock modified.");
						return 1;
					}
				}
			}
			case EDIT_TYPE_GATE_OPENPOS:
			{
				for(new i; i < MAX_GATES; i++)
				{
					if(GateInfo[i][GateID] == TempVar[playerid][EditingGateOpen])
					{
						if(response == EDIT_RESPONSE_FINAL)
						{
							format(string, sizeof(string), "%s has changed gate %d's open position. (B: %f, %f, %f | A: %f, %f, %f)", GetMasterName(playerid), GateInfo[i][GateID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], x, y, z);
							DBLog("EditObject", string);

							GateInfo[i][GateOpenPosX] = x;
							GateInfo[i][GateOpenPosY] = y;
							GateInfo[i][GateOpenPosZ] = z;
							GateInfo[i][GateOpenPosRX] = rx;
							GateInfo[i][GateOpenPosRY] = ry;
							GateInfo[i][GateOpenPosRZ] = rz;

							UpdateGate(i);
							SaveGate(i);
							TempVar[playerid][EditingGateOpen] = 0;
							SendClientMessageEx(playerid, COLOR_YELLOW, "You have modified gate %d's open position.", GateInfo[i][GateID]);
						}
						if(response == EDIT_RESPONSE_CANCEL)
						{
							UpdateGate(i);
							TempVar[playerid][EditingGateOpen] = 0;
							SendClientMessageEx(playerid, COLOR_YELLOW, "You have cancelled editing gate %d's position.", GateInfo[i][GateID]);
						}
						Streamer_Update(playerid);
						TempVar[playerid][EditType] = 0;
						return 1;
					}
				}
			}
			case EDIT_TYPE_GATE_CLOSEDPOS:
			{
				for(new i; i < MAX_GATES; i++)
				{
					if(GateInfo[i][GateID] == TempVar[playerid][EditingGateClosed])
					{
						TempVar[playerid][EditType] = 0;
						if(response == EDIT_RESPONSE_FINAL)
						{
							format(string, sizeof(string), "%s has changed gate %d's position. (B: %f, %f, %f | A: %f, %f, %f)", GetMasterName(playerid), GateInfo[i][GateID], GateInfo[i][GateClosedPosX], GateInfo[i][GateClosedPosY], GateInfo[i][GateClosedPosZ], x, y, z);
							DBLog("EditObject", string);

							GateInfo[i][GateClosedPosX] = x;
							GateInfo[i][GateClosedPosY] = y;
							GateInfo[i][GateClosedPosZ] = z;
							GateInfo[i][GateClosedPosRX] = rx;
							GateInfo[i][GateClosedPosRY] = ry;
							GateInfo[i][GateClosedPosRZ] = rz;
							GateInfo[i][GateInterior] = GetPlayerInterior(playerid);
							GateInfo[i][GateVW] = GetPlayerVirtualWorld(playerid);

							UpdateGate(i);
							SaveGate(i);
							TempVar[playerid][EditingGateClosed] = 0;
							SendClientMessageEx(playerid, COLOR_YELLOW, "You have modified gate %d's position.", GateInfo[i][GateID]);
						}
						if(response == EDIT_RESPONSE_CANCEL)
						{
							UpdateGate(i);
							TempVar[playerid][EditingGateClosed] = 0;
							SendClientMessageEx(playerid, COLOR_YELLOW, "You have cancelled editing gate %d's position.", GateInfo[i][GateID]);
						}
						Streamer_Update(playerid);
						return 1;
					}
				}
			}
			case EDIT_TYPE_EDIT_MAPPING:
			{
				for(new i; i < MAX_DYN_OBJECTS; i++)
				{
					if(i == TempVar[playerid][EditingMapID])
					{
						TempVar[playerid][EditType] = 0;
						TempVar[playerid][EditingMapID] = 0;
						if(response == EDIT_RESPONSE_FINAL)
						{
							format(string, sizeof(string), "%s has changed object %d's position. (B: %f, %f, %f | A: %f, %f, %f)", GetMasterName(playerid), i, MappingInfo[i][mX], MappingInfo[i][mY], MappingInfo[i][mZ], x, y, z);
							DBLog("EditObject", string);

							MappingInfo[i][mX] = x;
							MappingInfo[i][mY] = y;
							MappingInfo[i][mZ] = z;
							MappingInfo[i][mRX] = rx;
							MappingInfo[i][mRY] = ry;
							MappingInfo[i][mRZ] = rz;

							SendClientMessageEx(playerid, COLOR_YELLOW, "You have modified object %d's position.", i);
						}
						if(response == EDIT_RESPONSE_CANCEL)
						{
							SendClientMessageEx(playerid, COLOR_YELLOW, "You have cancelled editing object %d's position.", MappingInfo[i][mID]);
						}
						ReloadObject(i);
						Streamer_Update(playerid);
						SaveMapping(i);
						return 1;
					}
				}
			}
		}
	}
    return 1;
}

public OnPlayerSelectDynamicObject(playerid, STREAMER_TAG_OBJECT objectid, modelid, Float:x, Float:y, Float:z)
{
	CancelEdit(playerid);
	switch(TempVar[playerid][SelectType])
	{
		case SELECT_TYPE_SELL_FURNITURE:
		{
			for(new i; i < MAX_FURNITURE; i ++)
			{
				if(FurnitureInfo[i][furID] > 0 && FurnitureInfo[i][furHouseID] == EditFurnHouseID[playerid] && FurnitureInfo[i][furObjectID] == objectid)
				{
					TempVar[playerid][EditFurnitureID] = i;
					Dialog_Show(playerid, Furniture_Sell, DIALOG_STYLE_MSGBOX, "Sell Furniture", "Are you sure you wish to sell this item?\nYou will only recieve 70 percent of the price back.", "Select", "Exit");
					return 1;
				}
			}
		}
		case SELECT_TYPE_EDIT_FURNITURE:
		{
			for(new i; i < MAX_FURNITURE; i ++)
			{
				if(FurnitureInfo[i][furID] > 0 && FurnitureInfo[i][furHouseID] == EditFurnHouseID[playerid] && FurnitureInfo[i][furObjectID] == objectid)
				{
					TempVar[playerid][EditFurnitureID] = i;
					Dialog_Show(playerid, FurnitureEdit, DIALOG_STYLE_LIST, "Edit Furniture", "Position\nSell\nTexture", "Continue", "Close");
					return 1;
				}
			}
			SendErrorMessage(playerid, "That's not part of your furniture.");
		}
		case SELECT_TYPE_DELETE_SPIKE:
		{
			for(new i; i < MAX_SPIKES; i++)
			{
				if(IsValidDynamicObject(Spikes[i][sObjectID]) && Spikes[i][sObjectID] == objectid)
				{
					DestroyDynamicObject(Spikes[i][sObjectID]);
					TempVar[playerid][DeleteSpike] = false;
					CancelEdit(playerid);
					
					return 1;
				}
			}
			SendErrorMessage(playerid, "Please select a valid spike strip.");
		}
		case SELECT_TYPE_EDIT_SPIKE:
		{
			for(new i; i < MAX_SPIKES; i++)
			{
				if(IsValidDynamicObject(Spikes[i][sObjectID]) && Spikes[i][sObjectID] == objectid)
				{
					EditDynamicObject(playerid, Spikes[i][sObjectID]);
					TempVar[playerid][EditingRoadblock] = i;
					TempVar[playerid][SelectSpike] = false;
					TempVar[playerid][EditType] = EDIT_TYPE_EDIT_SPIKES;
					return 1;
				}
			}
			SendErrorMessage(playerid, "Please select a valid spike strip.");
		}
		case SELECT_TYPE_DELETE_ROADBLOCK:
		{
			for(new i; i < MAX_ROADBLOCKS; i++)
			{
				if(IsValidDynamicObject(Roadblocks[i][rObjectID]) && Roadblocks[i][rObjectID] == objectid)
				{
					DestroyDynamicObject(Roadblocks[i][rObjectID]);
					TempVar[playerid][EditType] = 0;
					TempVar[playerid][DeleteRoadblock] = false;
					CancelEdit(playerid);
					return 1;
				}
			}
			SendErrorMessage(playerid, "Please select a valid roadblock.");
		}
		case SELECT_TYPE_EDIT_ROADBLOCK:
		{
			for(new i; i < MAX_ROADBLOCKS; i++)
			{
				if(IsValidDynamicObject(Roadblocks[i][rObjectID]) && Roadblocks[i][rObjectID] == objectid)
				{
					EditDynamicObject(playerid, Roadblocks[i][rObjectID]);
					TempVar[playerid][SelectRoadblock] = false;
					TempVar[playerid][EditType] = EDIT_TYPE_EDIT_ROADBLOCK;
					return 1;
				}
			}
			SendErrorMessage(playerid, "Please select a valid roadblock.");
		}
		case SELECT_TYPE_EDIT_MAPPING:
		{
			for(new i; i < MAX_DYN_OBJECTS; i++)
			{
				if(MappingInfo[i][mObjectID] == objectid)
				{
					EditDynamicObject(playerid, MappingInfo[i][mObjectID]);
					TempVar[playerid][EditingMapID] = i;
					TempVar[playerid][EditingMap] = false;
					TempVar[playerid][EditType] = EDIT_TYPE_EDIT_MAPPING;
					SendClientMessageEx(playerid, COLOR_YELLOW, "You are now editing object %d", i);
					return 1;
				}
			}
			SendErrorMessage(playerid, "Can't find object, must be part of the mapping system.");
		}
		case SELECT_TYPE_DELETE_MAPPING:
		{
			for(new i; i < MAX_DYN_OBJECTS; i++)
			{
				if(MappingInfo[i][mObjectID] == objectid)
				{
					DeleteObjectFromSystem(i);
					TempVar[playerid][DeleteMap] = false;
					CancelEdit(playerid);
					return 1;
				}
			}
			SendErrorMessage(playerid, "Can't find object, must be part of the mapping system.");
		}
		case SELECT_TYPE_DUP_MAPPING:
		{
			for(new d; d < MAX_DYN_OBJECTS; d++)
			{
				if(MappingInfo[d][mObjectID] == objectid)
				{
					for(new i; i < MAX_DYN_OBJECTS; i++)
					{
						if(!MappingInfo[i][mID])
						{
							MappingInfo[i][mModelID] = MappingInfo[d][mModelID];
							MappingInfo[i][mX] = MappingInfo[d][mX];
							MappingInfo[i][mY] = MappingInfo[d][mY];
							MappingInfo[i][mZ] = MappingInfo[d][mZ];
							MappingInfo[i][mRX] = MappingInfo[d][mRX];
							MappingInfo[i][mRY] = MappingInfo[d][mRY];
							MappingInfo[i][mRZ] = MappingInfo[d][mRZ];
							MappingInfo[i][mDrawDistance] = MappingInfo[d][mDrawDistance];
							format(MappingInfo[i][mName], 32, "%s", MappingInfo[d][mName]);

							new query[512];
							mysql_format(g_SQL, query, sizeof query, "INSERT INTO mapping (ModelID, X, Y, Z, RX, RY, RZ, DrawDistance, Name) VALUES(%d, %f, %f, %f, %f, %f, %f, %f, '%e')", 
								MappingInfo[i][mModelID],
								MappingInfo[i][mX],
								MappingInfo[i][mY],
								MappingInfo[i][mZ],
								MappingInfo[i][mRX],
								MappingInfo[i][mRY],
								MappingInfo[i][mRZ],
								MappingInfo[i][mDrawDistance],
								MappingInfo[i][mName]);
							mysql_tquery(g_SQL, query, "OnMappingCreate", "dd", playerid, i);
							CancelEdit(playerid);
							return 1;
						}
					}
					SendErrorMessage(playerid, "Can't create object.");
					return 1;
				}
			}
			SendErrorMessage(playerid, "Can't find object, must be part of the mapping system.");
		}
	}
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	new pip[16];
	foreach(new i: Player)
	{
		GetPlayerIp(i, pip, sizeof(pip));
		if(!strcmp(ip, pip, true)) //If a player's IP is the IP that failed the login
		{
			if(Player[i][AdminLevel] < 5)
			{
				if(TempVar[i][BeingKicked] == false)
				{
					SystemBan(i, "RCON Login Attempt.");
				}
			}
			else 
			{
				new string[128];
				if(success)
				{
					format(string, sizeof string, "%s (%s) logged in to RCON.", GetUserName(i), GetMasterName(i));
					SendAdminWarning(5, string);
				}
				else
				{
					format(string, sizeof string, "%s (%s) failed to login to RCON.", GetUserName(i), GetMasterName(i));
					SendAdminWarning(5, string);
				}
			}
		}
	}
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	switch(TempVar[playerid][CheckpointType])
	{
		case CHECKPOINT_TYPE_BUS:
		{
			HandleBusRoute(playerid);
		}
		case CHECKPOINT_TYPE_MINER:
		{
			HandleMinerDelivery(playerid);
		}
		case CHECKPOINT_TYPE_FARMER:
		{
			HandleFarmerDelivery(playerid);
		}
		/*case CHECKPOINT_TYPE_TRASH:
		{
			DisablePlayerCheckpoint(playerid);
			new i = GetPVarInt(playerid, "BusinessTrash");
			new trash = BusinessInfo[i][BizTrash];
			TempVar[playerid][TrashAmount]++;
			BusinessInfo[i][BizTrash] = 0;
			if(TempVar[playerid][TrashAmount] >= 10)
			{
				for(new i; i < MAX_BIZ; i++)
				{
					if(strlen(BusinessInfo[i][BizName]) < 1)
                    	continue;

					if(!IsValidDynamicObject(BusinessTrashObject[i]))
						continue;

					if(BusinessInfo[i][BizTrashX] == 0)
						continue;
					
					if(BusinessInfo[i][BizTrash] >= 1 && BusinessInfo[i][BizTrashCooldown] < 1)
					{
						TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_TRASH;
						DisablePlayerCheckpoint(playerid);
						SetPlayerCheckpoint(playerid, BusinessInfo[i][BizTrashX], BusinessInfo[i][BizTrashY], BusinessInfo[i][BizTrashZ], 10.0);
						new zone[32];
						GetLocation(BusinessInfo[i][BizTrashX], BusinessInfo[i][BizTrashY], BusinessInfo[i][BizTrashZ], zone, sizeof(zone));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Collect the trash from %s, %s.", BusinessInfo[i][BizName], zone);
						return 1;
					}
				}
			}
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "-> {FFFF00}No trash needs to be collected, return to the trash facility.");
		}*/
		case CHECKPOINT_TYPE_SWEEP:
		{
			HandleSweeperCheckpoint(playerid);
		}
		case CHECKPOINT_TYPE_TRUCK_COLLECT:
		{
			HandleTruckCheckpoint(playerid);
		}
		/*case CHECKPOINT_TYPE_TRUCK_DELIVER:
		{
			new randMoney = random(15)+random(20)+random(30)+50;
			DisablePlayerCheckpoint(playerid);
			TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_NONE;
			GiveMoney(playerid, randMoney);
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have sucessfully delivered the goods, you earned $%s.", FormatNumber(randMoney));
		}
		case CHECKPOINT_TYPE_TRUCK_COLLECT:
		{
			new rand = random(sizeof(DeliveryLocations));
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, DeliveryLocations[rand][0], DeliveryLocations[rand][1], DeliveryLocations[rand][2], 10.0);
			TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_TRUCK_DELIVER;
			SendClientMessageEx(playerid, COLOR_GREEN, "__________ {FFFFFF}Trucker Delivery{%06x} __________", COLOR_GREEN >>> 8);
            SendClientMessageEx(playerid, COLOR_GRAD5, "Go to %s to deliver your goods.", DeliveryNames[rand]);
		}*/
		case CHECKPOINT_TYPE_GPS:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the place.");
		}
		case CHECKPOINT_TYPE_WEP_BOX:
		{
			IsUsed = false;
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the weapon box, use /openbox.");
		}
		case CHECKPOINT_TYPE_FIND:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the trash dump, use /dumptrash.");
		}
		case CHECKPOINT_TYPE_FIND_DEALER:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the dealership.");
		}
		case CHECKPOINT_TYPE_FIND_VEH:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found your vehicle.");
		}
		case CHECKPOINT_TYPE_FIND_JOB:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the job. Type /takejob to become one.");
		}
		case CHECKPOINT_TYPE_FISHING:
		{
			if(IsABoat(playerid))
			{
				PrintFooter(playerid, "~w~Reeling in ~g~fish~w~~n~please wait", 5);
				SetTimerEx("FishingCatch", 5000, false, "i", playerid);
			}
		}
		case CHECKPOINT_TYPE_FIND_PIER:
		{
			PlayerPlaySound(playerid, 1056, 0, 0, 0);
			DisablePlayerCheckpoint(playerid);
			SendClientMessage(playerid, COLOR_PINK, "You have found the fishing point. Type /pierfish to continue.");
		}
		case CHECKPOINT_TYPE_DMV:
		{
			if(TempVar[playerid][DMVTest] != 0)
			{
				new iVeh = GetPlayerVehicleID(playerid);
				PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				switch(TempVar[playerid][DMVTest])
				{
					case 1:
					{
						SetPlayerCheckpoint(playerid, -198.1288,1112.3391,19.3332, 5.0);
						TempVar[playerid][DMVTest] = 2;
					}
					case 2:
					{
						SetPlayerCheckpoint(playerid, -79.2173,1095.9467,19.3428, 5.0);
						TempVar[playerid][DMVTest] = 3;
					}
					case 3:
					{
						SetPlayerCheckpoint(playerid, -68.1928,1036.7374,19.3377, 5.0);
						TempVar[playerid][DMVTest] = 4;
					}
					case 4:
					{
						SetPlayerCheckpoint(playerid, -27.6141,1021.2209,19.3401, 5.0);
						TempVar[playerid][DMVTest] = 5;
					}
					case 5:
					{
						SetPlayerCheckpoint(playerid, -13.0056,1085.1722,19.3321, 5.0);
						TempVar[playerid][DMVTest] = 6;
					}
					case 6:
					{
						SetPlayerCheckpoint(playerid, 31.9512,1123.1838,19.3355, 5.0);
						TempVar[playerid][DMVTest] = 7;
					}
					case 7:
					{
						SetPlayerCheckpoint(playerid, -50.6885,1150.5938,19.3292, 5.0);
						TempVar[playerid][DMVTest] = 8;
					}
					case 8:
					{
						SetPlayerCheckpoint(playerid, -63.0618,1186.0138,19.2881, 5.0);
						TempVar[playerid][DMVTest] = 9;
					}
					case 9:
					{
						SetPlayerCheckpoint(playerid, 105.5024,1195.4900,17.9986, 5.0);
						TempVar[playerid][DMVTest] = 10;
					}
					case 10:
					{
						SetPlayerCheckpoint(playerid, 18.7291,1262.3783,10.5456, 5.0);
						TempVar[playerid][DMVTest] = 11;
					}
					case 11:
					{
						SetPlayerCheckpoint(playerid, -107.7874,1259.4988,15.9974, 5.0);
						TempVar[playerid][DMVTest] = 12;
					}
					case 12:
					{
						SetPlayerCheckpoint(playerid, -117.7058,1212.1141,19.0651, 5.0);
						TempVar[playerid][DMVTest] = 13;
					}
					case 13:
					{
						SetPlayerCheckpoint(playerid, -178.2613,1201.1727,19.3243, 5.0);
						TempVar[playerid][DMVTest] = 14;
					}
					case 14:
					{
						SetPlayerCheckpoint(playerid, -197.6018,1206.0159,19.4128, 5.0);
						TempVar[playerid][DMVTest] = 15;
					}
					case 15:
					{
						RemovePlayerFromVehicle(playerid);
						SetVehicleToRespawn(iVeh);
						TempVar[playerid][DMVTest] = 0;
						AddInventory(playerid, INV_DRV_LIC, 1);
						SendClientMessageEx(playerid, COLOR_YELLOW, "Instructor says: Okay, you have passed your driving test today. Well done!");
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have received a driving license.");
						TakeMoney(playerid, 250);
						new string[256];
						mysql_format(g_SQL, string, sizeof(string), "UPDATE `characters` SET `Money` = %d WHERE `CharacterID` = %d LIMIT 1", PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pCharacterID]);
        				mysql_tquery(g_SQL, string);
					}
				}
			}
		}
	}
	return 1;
}

function SetPlayerTeamColour(playerid)
{
	if(Player[playerid][AdminLevel] >= 1 && TempVar[playerid][AdminDuty] == true)
	{
		SetPlayerColor(playerid, 0x00FF0000);
		return 1;
	}
	if(Player[playerid][HelperLevel] >= 1 && TempVar[playerid][HelperDuty] == true)
	{
		SetPlayerColor(playerid, 0x04A6DB00);
		return 1;
	}
	if(Player[playerid][DonateLevel] >= 1 && TempVar[playerid][DonatorTag] == true)
	{
		SetPlayerColor(playerid, 0xBF800000);
		return 1;
	}
	SetPlayerColor(playerid, COLOR_WHITE);
	return 1;
}

function OnBuyAccessory(playerid, boneid, modelid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	for(new i; i < MAX_ACCESSORIES; i++)
	{
		if(AccInfo[playerid][i][aModel] == 0)
		{
			AccInfo[playerid][i][aID] = cache_insert_id();
			AccInfo[playerid][i][aModel] = modelid;
			AccInfo[playerid][i][aCharacterID] = PlayerInfo[playerid][pCharacterID];
			AccInfo[playerid][i][aBone] = boneid;
			AccInfo[playerid][i][aX] = fOffsetX;
			AccInfo[playerid][i][aY] = fOffsetY;
			AccInfo[playerid][i][aZ] = fOffsetZ;
			AccInfo[playerid][i][aRX] = fRotX;
			AccInfo[playerid][i][aRY] = fRotY;
			AccInfo[playerid][i][aRZ] = fRotZ;
			AccInfo[playerid][i][aSX] = fScaleX;
			AccInfo[playerid][i][aSY] = fScaleY;
			AccInfo[playerid][i][aSZ] = fScaleZ;

			if(fScaleX == 0.0)
			{
				AccInfo[playerid][i][aSX] = 1.0;
				AccInfo[playerid][i][aSY] = 1.0;
				AccInfo[playerid][i][aSZ] = 1.0;
			}

			RemovePlayerAttachedObject(playerid, SLOT_MISC);
			if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				RemovePlayerAttachedObject(playerid, i);
			}

			SetPlayerAttachedObject(playerid, i, AccInfo[playerid][i][aModel], AccInfo[playerid][i][aBone], 
			AccInfo[playerid][i][aX], AccInfo[playerid][i][aY], AccInfo[playerid][i][aZ], 
			AccInfo[playerid][i][aRX], AccInfo[playerid][i][aRY], AccInfo[playerid][i][aRZ], 
			AccInfo[playerid][i][aSX], AccInfo[playerid][i][aSY], AccInfo[playerid][i][aSZ]);

			new name[128], price = 1;
			format(name, sizeof(name), "Unknown");
			for(new x; x < sizeof(GlobalAttachments); x++)
			{
				if(modelid == GlobalAttachments[x][Model])
				{
					format(name, sizeof(name), "%s", GlobalAttachments[x][Name]);
					price = GlobalAttachments[x][Price];
					break;
				}
			}
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have purchased %s in slot %d for $%s.", name, i, FormatNumber(price));
			TakeMoney(playerid, price);
			SavePlayerClothing(playerid);
			return 1;
		}
	}
	SendErrorMessage(playerid, "Cannot buy accessory, too many slots used.");
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
		switch(TempVar[playerid][EditType])
		{
			case EDIT_TYPE_BUY_ACCESSORY:
			{
				if(response == EDIT_RESPONSE_FINAL)
				{
					new query[256];
					mysql_format(g_SQL, query, sizeof query, "INSERT INTO `accessories` (`CharacterID`, `Bone`, `Model`, `PosX`, `PosY`, `PosZ`, `PosRX`, `PosRY`, `PosRZ`, `PosSX`, `PosSY`, `PosSZ`) VALUES (%d, 2, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f)",
					PlayerInfo[playerid][pCharacterID], modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
					mysql_tquery(g_SQL, query, "OnBuyAccessory", "dddfffffffff", playerid, boneid, modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
				}
				else
				{
					RemovePlayerAttachedObject(playerid, SLOT_MISC);
					SendClientMessage(playerid, COLOR_YELLOW, "Accessory purchase cancelled.");
				}
				return 1;
			}
			case EDIT_TYPE_ACCESSORY:
			{
				new editid = GetPVarInt(playerid, "AttachmentID");
				if(response == EDIT_RESPONSE_FINAL)
				{
					AccInfo[playerid][editid][aBone] = boneid;
					AccInfo[playerid][editid][aX] = fOffsetX;
					AccInfo[playerid][editid][aY] = fOffsetY;
					AccInfo[playerid][editid][aZ] = fOffsetZ;
					AccInfo[playerid][editid][aRX] = fRotX;
					AccInfo[playerid][editid][aRY] = fRotY;
					AccInfo[playerid][editid][aRZ] = fRotZ;
					AccInfo[playerid][editid][aSX] = fScaleX;
					AccInfo[playerid][editid][aSY] = fScaleY;
					AccInfo[playerid][editid][aSZ] = fScaleZ;

					if(fScaleX == 0.0)
					{
						AccInfo[playerid][editid][aSX] = 1.0;
						AccInfo[playerid][editid][aSY] = 1.0;
						AccInfo[playerid][editid][aSZ] = 1.0;
					}

					RemovePlayerAttachedObject(playerid, editid);
					SetPlayerAttachedObject(playerid, editid, 
					AccInfo[playerid][editid][aModel], AccInfo[playerid][editid][aBone], 
					AccInfo[playerid][editid][aX], AccInfo[playerid][editid][aY], AccInfo[playerid][editid][aZ], 
					AccInfo[playerid][editid][aRX], AccInfo[playerid][editid][aRY], AccInfo[playerid][editid][aRZ], 
					AccInfo[playerid][editid][aSX], AccInfo[playerid][editid][aSY], AccInfo[playerid][editid][aSZ]);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d adjusted.", editid);
					SavePlayerClothing(playerid);
					return 1;
				}
				else
				{
					RemovePlayerAttachedObject(playerid, editid);
					SetPlayerAttachedObject(playerid, editid, 
					AccInfo[playerid][editid][aModel], AccInfo[playerid][editid][aBone], 
					AccInfo[playerid][editid][aX], AccInfo[playerid][editid][aY], AccInfo[playerid][editid][aZ], 
					AccInfo[playerid][editid][aRX], AccInfo[playerid][editid][aRY], AccInfo[playerid][editid][aRZ], 
					AccInfo[playerid][editid][aSX], AccInfo[playerid][editid][aSY], AccInfo[playerid][editid][aSZ]);
					SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d adjustment cancelled.", editid);
					return 1;
				}
			}
			case EDIT_TYPE_PRIMARY_WEP:
			{
				if(response == EDIT_RESPONSE_FINAL)
				{
					PlayerInfo[playerid][pWeaponBone] = boneid;
					PlayerInfo[playerid][pWeaponX] = fOffsetX;
					PlayerInfo[playerid][pWeaponY] = fOffsetY;
					PlayerInfo[playerid][pWeaponZ] = fOffsetZ;
					PlayerInfo[playerid][pWeaponRX] = fRotX;
					PlayerInfo[playerid][pWeaponRY] = fRotY;
					PlayerInfo[playerid][pWeaponRZ] = fRotZ;
					PlayerInfo[playerid][pWeaponSX] = fScaleX;
					PlayerInfo[playerid][pWeaponSY] = fScaleY;
					PlayerInfo[playerid][pWeaponSZ] = fScaleZ;

					RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Weapon Slot modified. It should appear within a second.");
					return 1;
				}
				else
				{
					RemovePlayerAttachedObject(playerid, SLOT_WEAPON);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Weapon modified cancelled. It should reappear within a second.");
				}
			}
		}
	}
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	new vehicle = GetVehicleID(vehicleid);
	if (VehicleInfo[vehicle][vSirens] && !IsAGeneralBike(vehicleid))
	{
		if (newstate)
		{
			ToggleVehicleSiren(vehicleid, true);
		}
		else
		{
			ToggleVehicleSiren(vehicleid, false);
		}
	}
	return 1;
}