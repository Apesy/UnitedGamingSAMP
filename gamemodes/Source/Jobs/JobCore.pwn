//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock Init_Jobs()
{
    new string[128];
    for(new i = 1; i < sizeof(gJobLocation); i++)
    {
        format(string, sizeof string, "%s\n{FFFFFF}Type {55AA55}/takejob{FFFFFF} to become one.", gJobNames[i]);
        CreateDynamic3DTextLabel(string, COLOR_GREEN, gJobLocation[i][0], gJobLocation[i][1], gJobLocation[i][2], 20.0, .testlos = 0);
        CreateDynamicPickup(1239, 1, gJobLocation[i][0], gJobLocation[i][1], gJobLocation[i][2]);
    }
}

stock GetJobName(jobid)
{
    new jobName[32];
    format(jobName, sizeof(jobName), "%s", gJobNames[jobid]);
    if(strlen(jobName) < 1)
    {
        format(jobName, sizeof(jobName), "Undefined");
    }
    return gJobNames[jobid];
}

stock Accept_JobOffer(playerid)
{
    if(TempVar[playerid][JobOffer] > 0)
    {
        PlayerInfo[playerid][pJob] = TempVar[playerid][JobOffer];
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You are now a %s, Type /jobhelp to see your new commands.", gJobNames[TempVar[playerid][JobOffer]]);
    }
}

CMD:takejob(playerid, params[])
{
    for(new i = 1; i < sizeof(gJobLocation); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 10, gJobLocation[i][0], gJobLocation[i][1], gJobLocation[i][2]))
        {
            new string[180];
            TempVar[playerid][JobOffer] = i;
            if(PlayerInfo[playerid][pJob] > 0)
            {
                format(string, sizeof string, "You are about to become a %s.\n\
                Are you sure you wish to become one?\n\n\
                WARNING: This will replace your current job!", gJobNames[i]);
            }
            else format(string, sizeof string, "You are about to become a %s.\nAre you sure you wish to become one?", gJobNames[i]);
            Dialog_Show(playerid, Job_Contract, DIALOG_STYLE_MSGBOX, "Job Contract", string, "Accept", "Deny");
            return 1;
        }
    }
    SendErrorMessage(playerid, "You are not near a job. Use /findjob to find one.");
    return 1;
}

Dialog:Job_Contract(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Accept_JobOffer(playerid);
    }
    return 1;
}

CMD:findjob(playerid, params[])
{
    new string[128*5];
    for(new i = 1; i < sizeof(gJobNames); i++)
    {
        format(string, sizeof string, "%s%s\n", string, gJobNames[i]);
    }
    Dialog_Show(playerid, FindJob, DIALOG_STYLE_LIST, "Find Job", string, "Find", "Close");
    return 1;
}

Dialog:FindJob(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        DisablePlayerCheckpoint(playerid);
        SetPlayerCheckpoint(playerid, gJobLocation[listitem+1][0], gJobLocation[listitem+1][1], gJobLocation[listitem+1][2], 5.0);
        TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FIND_JOB;
        SendClientMessage(playerid, COLOR_PINK, "Job Location has been marked on your GPS. (/rcp to remove)");
    }
}

CMD:jobhelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 0)
        return SendErrorMessage(playerid, "You do not have a job (/findjob).");

    if(PlayerInfo[playerid][pJob] == JOB_TAXIDRIVER)
    {
        pc_cmd_taxihelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_COURIER)
    {
        pc_cmd_truckerhelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
    {
        pc_cmd_mechanichelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_TRASH)
    {
        pc_cmd_trashhelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_SWEEPER)
    {
        pc_cmd_sweeperhelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_FARMER)
    {
        pc_cmd_farmerhelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_MINER)
    {
        pc_cmd_minerhelp(playerid, params);
    }
    else if(PlayerInfo[playerid][pJob] == JOB_BUSDRIVER)
    {
        pc_cmd_bushelp(playerid, params);
    }
    return 1;
}

stock SendJobMessage(job, colour, const str[], {Float,_}:...)
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
            if(job != JOB_MECHANIC)
            {
                if(PlayerInfo[i][pJob] == job && TempVar[i][JobDuty] == true)
                {
                    SendClientMessage(i, colour, string);
                }
            }
            else
            {
                if(PlayerInfo[i][pJob] == job)
                {
                    SendClientMessage(i, colour, string);
                }
            }
		}
		return 1;
	}
	foreach (new i : Player)
    {
        if(job != JOB_MECHANIC)
        {
            if(PlayerInfo[i][pJob] == job && TempVar[i][JobDuty] == true)
            {
                SendClientMessage(i, colour, str);
            }
        }
        else
        {
            if(PlayerInfo[i][pJob] == job)
            {
                SendClientMessage(i, colour, str);
            }
        }
    }
    return 1;
}

CMD:jobduty(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] > 0 && PlayerInfo[playerid][pJob] != JOB_MECHANIC)
    {
        if(TempVar[playerid][JobDuty] == false)
        {
            TempVar[playerid][JobDuty] = true;
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[JOB] {FFFF00}You are now on duty. You can use the commands available in /jobhelp.");
        }
        else
        {
            TempVar[playerid][JobDuty] = false;
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "[JOB] {FFFF00}You are now off duty.");
        }
    }
    else SendErrorMessage(playerid, "You do not have a job (/findjob).");
    return 1;
}