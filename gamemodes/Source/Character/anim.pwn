//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
new bool:LoopAnim[MAX_PLAYERS];
new Text:AnimText;
new StopTalkingTimer[MAX_PLAYERS];

stock ApplyChatAnimation(playerid, lib[], name[], text[])
{
	new time = strlen(text)*100;
	ApplyAnimation(playerid, lib, name, 4.1, 0, 1, 1, 1, 1);
	StopTalkingTimer[playerid] = SetTimerEx("OnStopChat", time, false, "d", playerid);
}

function OnStopChat(playerid)
{
	StopAnim(playerid);
	return 1;
}

stock ApplyAnim(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0, 1);
	for(new i = 0; i < 5; i++)
	{
		ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	}
	return 1;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	if (loop > 0 || freeze > 0)
	{
		LoopAnim[playerid] = true;
		TextDrawSetString(AnimText, "Press ~r~~k~~PED_SPRINT~~w~ to stop animation");
		TextDrawShowForPlayer(playerid, AnimText);
	}
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0, 1);
	for(new i = 0; i < 5; i++)
	{
		ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	}
	return 1;
}

stock AnimationCheck(playerid)
{
	return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT);
}

new AnimationLibraries[][] = 
{
	"AIRPORT", "Attractors", "BAR", "BASEBALL", "BD_FIRE", "BEACH", "benchpress", "BF_injection", "BIKED", "BIKEH", "BIKELEAP",
	"BIKES", "BIKEV", "BIKE_DBZ", "BLOWJOBZ", "BMX", "BOMBER", "BOX", "BSKTBALL", "BUDDY", "BUS", "CAMERA", "CAR", "CARRY", "CAR_CHAT",
	"CASINO", "CHAINSAW", "CHOPPA", "CLOTHES", "COACH", "COLT45", "COP_AMBIENT", "COP_DVBYZ", "CRACK", "CRIB", "DAM_JUMP", "DANCING",
	"DEALER", "DILDO", "DODGE", "DOZER", "DRIVEBYS", "FAT", "FIGHT_B", "FIGHT_C", "FIGHT_D", "FIGHT_E", "FINALE", "FINALE2", "FLAME",
	"Flowers", "FOOD", "Freeweights", "GANGS", "GHANDS", "GHETTO_DB", "goggles", "GRAFFITI", "GRAVEYARD", "GRENADE", "GYMNASIUM", "HAIRCUTS",
	"HEIST9", "INT_HOUSE", "INT_OFFICE", "INT_SHOP", "JST_BUISNESS", "KART", "KISSING", "KNIFE", "LAPDAN1", "LAPDAN2", "LAPDAN3", "LOWRIDER",
	"MD_CHASE", "MD_END", "MEDIC", "MISC", "MTB", "MUSCULAR", "NEVADA", "ON_LOOKERS", "OTB", "PARACHUTE", "PARK", "PAULNMAC", "ped", "PLAYER_DVBYS",
	"PLAYIDLES", "POLICE", "POOL", "POOR", "PYTHON", "QUAD", "QUAD_DBZ", "RAPPING", "RIFLE", "RIOT", "ROB_BANK", "ROCKET", "RUSTLER", "RYDER",
	"SCRATCHING", "SHAMAL", "SHOP", "SHOTGUN", "SILENCED", "SKATE", "SMOKING", "SNIPER", "SPRAYCAN", "STRIP", "SUNBATHE", "SWAT", "SWEET", "SWIM",
	"SWORD", "TANK", "TATTOOS", "TEC", "TRAIN", "TRUCK", "UZI", "VAN", "VENDING", "VORTEX", "WAYFARER", "WEAPONS", "WUZI", "SAMP"
};

stock PreloadAnimations(playerid)
{
	for (new i; i < sizeof(AnimationLibraries); i++) ApplyAnimation(playerid, AnimationLibraries[i], "null", 0.0, 0, 0, 0, 0, 0);
	return 1;
}

stock StopAnim(playerid, forcesync=0)
{
	LoopAnim[playerid] = false;
	TextDrawHideForPlayer(playerid, AnimText);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 3.1, 0, 0, 0, 0, 0, forcesync);
	SetTimerEx("OnClearAnim", 200, false, "d", playerid);
	return 1;
}

function OnClearAnim(playerid)
{
	ClearAnimations(playerid);
	return 1;
}

stock CanUseAnim(playerid)
{
	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
		return 0;
	return 1;
}

CMD:stopanim(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_ALIVE)
	{
		SendErrorMessage(playerid, "You cannot do this at the moment.");
		return 1;
	}
	StopAnim(playerid);
	return 1;
}
alias:stopanim("sa", "stopanims");

#define ANIM_MSG 11
new Animation[][90] =
{
	{"/dance, /handsup, /bat, /slapface, /bar, /wash, /lay, /workout, /blowjob, /bomb"},
	{"/carry, /crack, /sleep, /jump, /deal, /dancing, /eating, /puke, /gsign, /chat"},
	{"/goggles, /spray, /throw, /swipe, /office, /kiss, /knife, /cpr, /dj, /point"},
	{"/cheer, /wave, /strip, /smoke, /reload, /taichi, /wank, /cower, /skate, /drunk"},
	{"/cry, /tired, /sit, /crossarms, /fuckyou, /walk, /piss, /rap, /signal, /slapass"},
	{"/followme, /hitch, /backfall, /frontfall, /airkick, /groundkick, /sword, /facefall"},
	{"/slapped, /getup, /kostomach, /laugh, /lookout, /carjacked, /shotfront, /skidback"},
	{"/die, /injured, /push, /doorkick, /spraying, /headbutt, /lifejump, /rollfall, /no"},
	{"/carlock, /carjack, /hoodfrisked, /box, /fight, /lean, /inbed, /coplook, /scratch"},
	{"/leftslap, /palmbitch, /gift, /basket, /yes, /thx, /checkout, /nod, /bend, /endchat"},
	{"/cockgun, /lowrider"}
};

CMD:lowrider(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");
    
    new anim;
    if(sscanf(params, "i", anim) || anim < 1 || anim > 33)
        return SendUsageMessage(playerid, "/lowrider (1-33)");

    switch(anim)
    {
        case 1:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 2:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 3:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_hair", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 4:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_hurry", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 5:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_idleloop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 6:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 7:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 8:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 9:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 10:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 11:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 12:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 13:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 14:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 15:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 16:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 17:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 18:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 19:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 20:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 21:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 22:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 23:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.0, 0, 0, 0, 1, 0, 1);
        }
        case 24:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 25:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 26:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 27:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkC", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 28:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkD", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 29:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 30:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 31:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 32:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "Sit_relaxed", 4.0, 1, 0, 0, 0, 0, 1);
        }
        case 33:
        {
            ApplyAnimationEx(playerid, "LOWRIDER", "Tap_hand", 4.0, 1, 0, 0, 0, 0, 1);
        }
    }
    return 1;
}

CMD:cockgun(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:no(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "MISC", "plyr_shkhead", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:bend(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BAR", "Barserve_bottle", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:nod(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_nod",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:checkout(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:thx(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"FOOD","SHP_Thank", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:yes(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:basket(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/basket [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idleloop",4.1, 0, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",4.1, 0, 1, 1, 1, 1, 1);
        case 3: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_pickup",4.1, 0, 1, 1, 1, 1, 1);
        case 4: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_run",4.1, 0, 1, 1, 1, 1, 1);
        case 5: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_loop",4.1, 0, 1, 1, 1, 1, 1);
        case 6: ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:gift(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"KISSING","gift_give",4.1, 0, 1, 1, 1, 1, 1); 
	return 1;
}

CMD:palmbitch(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"MISC","bitchslap",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:endchat(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"MISC","endchat_01",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:scratch(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"MISC","Scratchballs_01",4.1, 0, 1, 1, 1, 1, 1); 
	return 1;
}

CMD:coplook(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_watch",4.1, 0, 1, 1, 1, 1, 1); 
	return 1;
}

CMD:inbed(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/inbed [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"INT_HOUSE","BED_Loop_L",4.1, 0, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid,"INT_HOUSE","BED_Loop_R",4.1, 0, 1, 1, 1, 1, 1);
        case 3: ApplyAnimationEx(playerid,"INT_HOUSE","BED_In_L",4.1, 0, 1, 1, 1, 1, 1);
        case 4: ApplyAnimationEx(playerid,"INT_HOUSE","BED_In_R",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:lean(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/lean [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"GANGS","leanIDLE",4.1, 0, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid,"MISC","Plyrlean_loop",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:fight(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/fight [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"FIGHT_D","FightD_3",4.1, 0, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid,"FIGHT_D","FightD_2",4.1, 0, 1, 1, 1, 1, 1);
        case 3: ApplyAnimationEx(playerid,"FIGHT_D","FightD_IDLE",4.1, 0, 1, 1, 1, 1, 1);
        case 4: ApplyAnimationEx(playerid,"FIGHT_B","FightB_G",4.1, 0, 1, 1, 1, 1, 1);
        case 5: ApplyAnimationEx(playerid,"FIGHT_C","FightC_M",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:box(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"GYMNASIUM","GYMshadowbox",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:hoodfrisked(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"POLICE","crm_drgbst_01",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:carjack(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/carjack [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"PED","CAR_pulloutL_LHS",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimationEx(playerid,"PED","CAR_pulloutL_RHS",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimationEx(playerid,"PED","CAR_pullout_LHS",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimationEx(playerid,"PED","CAR_pullout_RHS",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:carlock(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","CAR_doorlocked_LHS",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:rollfall(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","BIKE_fallR",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:leftslap(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","BIKE_elbowL",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:lifejump(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","EV_dive",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:headbutt(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"WAYFARER","WF_Fwd",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:spraying(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"SPRAYCAN","spraycan_full",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:push(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/push [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"GANGS","shake_cara",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimationEx(playerid,"GANGS","shake_carSH",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:injured(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:die(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:skidback(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "KO_shot_front", 4.1, 0, 1, 1, 1, 0, 1);
	return 1;
}

CMD:doorkick(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "POLICE","Door_Kick",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:shotfront(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "KO_shot_front", 4.1, 0, 1, 1, 1, 0, 1);
	return 1;
}

CMD:carjacked(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/carjacked [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"PED","CAR_jackedLHS",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimationEx(playerid,"PED","CAR_jackedRHS",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:laugh(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:lookout(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 1, 1, 1); 
	return 1;
}

CMD:getup(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","getup",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:slapped(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"SWEET","ho_ass_slapped",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:sword(playerid,params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"SWORD","sword_block",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:airkick(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"FIGHT_C","FightC_M",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:groundkick(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"FIGHT_D","FightD_G",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:anim(playerid, params[]) return pc_cmd_anims(playerid, params);
CMD:anims(playerid, params[])
{
	new string[91*ANIM_MSG];
	format(string, sizeof(string), "{FFFF00}Use {FFFFFF}/stopanim (/sa){FFFF00} to stop your current animation.{FFFFFF}\n\n");
	for(new i; i < sizeof(Animation); i++)
	{
		format(string, sizeof(string), "%s%s.\n", string, Animation[i]);
	}
	Dialog_Show(playerid, DIALOG_ANIMATION, DIALOG_STYLE_MSGBOX, "Animations", string, "Okay", "Print");
    return 1;
}

Dialog:DIALOG_ANIMATION(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		SendClientMessage(playerid, COLOR_GREEN, "----------------- [ ANIMATIONS ] -----------------");
		SendClientMessage(playerid, COLOR_YELLOW, "Use {FFFFFF}/stopanim (/sa){FFFF00} to stop your current animation.");
		for(new i; i < sizeof(Animation); i++)
		{
			SendClientMessageEx(playerid, COLOR_GRAD5, "%s.", Animation[i]);
		}
	}
	return 1;
}

CMD:facefall(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","KO_shot_face",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:kostomach(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid,"PED","KO_shot_stom",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:frontfall(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "ped", "FLOOR_hit_f", 4.0, 0, 1, 1, 1, 0);
	return 1;
}

CMD:backfall(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/backfall [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid, "ped", "FLOOR_hit", 4.0, 0, 1, 1, 1, 0);
		case 2: ApplyAnimationEx(playerid, "ped", "fall_back", 4.0, 0, 1, 1, 1, 0);
	}
	return 1;
}

CMD:hitch(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/hitch [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid, "MISC", "Hiker_Pose", 4.0, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "MISC", "Hiker_Pose_L", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;
}

CMD:followme(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "WUZI", "Wuzi_follow", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:slapass(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:bomb(playerid, params[])
{
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
	return 1;
}

CMD:signal(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/signal [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
		case 1: ApplyAnimationEx(playerid,"POLICE","CopTraf_Come",4.0,0,0,0,0,0);
		case 2: ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.0,0,0,0,0,0);
	}
	return 1;
}

CMD:rap(playerid, params[])
{
	new type;
	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/dance [1-3]");

	if(type < 1 || type > 3)
		return SendErrorMessage(playerid, "Invalid type specified.");

	switch(type)
	{
		case 1: ApplyAnimationEx(playerid,"RAPPING","RAP_A_Loop",4.0,1,1,1,1,0);
		case 2: ApplyAnimationEx(playerid,"RAPPING","RAP_B_Loop",4.0,1,1,1,1,0);
		case 3: ApplyAnimationEx(playerid,"RAPPING","RAP_C_Loop",4.0,1,1,1,1,0);
	}
	return 1;
}

CMD:dance(playerid, params[])
{
	new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/dance [1-11]");

	if (type < 1 || type > 11)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
	    case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
	    case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
	    case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
		case 5: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 1, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 1, 0, 0, 0, 0, 1);
		case 9: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
		case 10: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 1, 0, 0, 0, 0, 1);
		case 11: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:handsup(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

CMD:piss(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:bat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/bat [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BASEBALL", "Bat_1", 4.1, 0, 1, 1, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BASEBALL", "Bat_3", 4.1, 0, 1, 1, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BASEBALL", "Bat_4", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:slapface(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BASEBALL", "Bat_M", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:bar(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/bar [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BAR", "Barserve_bottle", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BAR", "Barserve_give", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BAR", "Barserve_glass", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BAR", "Barserve_in", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BAR", "Barserve_order", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.1, 0, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wash(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:lay(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/lay [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:workout(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/workout [1-7]");

	if (type < 1 || type > 7)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/blowjob [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:bombanim(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:carry(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/carry [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CARRY", "liftup05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:crack(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/crack [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.1, 0, 0, 0, 1, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:sleep(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/sleep [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.1, 0, 0, 0, 1, 0, 1);
	}
	return 1;
}

CMD:jump(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 0, 0, 1);
	return 1;
}

CMD:deal(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/deal [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "DEALER", "DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:dancing(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/dancing [1-11]");

	if (type < 1 || type > 11)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
	    case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
	    case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0, 1);
	    case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
	    case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0, 1);
	    case 11: ApplyAnimationEx(playerid, "DANCING", "dnce_M_d", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:eating(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/eating [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:puke(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:gsign(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/gsign [1-15]");

	if (type < 1 || type > 15)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "GHANDS", "gsign1", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "GHANDS", "gsign1LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "GHANDS", "gsign2", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "GHANDS", "gsign2LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "GHANDS", "gsign3", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "GHANDS", "gsign3LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "GHANDS", "gsign4", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "GHANDS", "gsign4LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 9: ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 10: ApplyAnimationEx(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
		case 11: ApplyAnimationEx(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);
		case 12: ApplyAnimationEx(playerid, "GANGS", "Invite_No", 4.1, 0, 0, 0, 0, 0, 1);
		case 13: ApplyAnimationEx(playerid, "GANGS", "Invite_Yes", 4.1, 0, 0, 0, 0, 0, 1);
		case 14: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkD", 4.1, 0, 0, 0, 0, 0, 1);
		case 15: ApplyAnimationEx(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:chat(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/chat [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkB", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkE", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkF", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkG", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "GANGS", "prtial_gngtlkH", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:goggles(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:spray(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

 	ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:throw(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:swipe(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:office(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/office [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:kiss(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/kiss [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:knife(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/knife [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "KNIFE", "knife_1", 4.1, 0, 1, 1, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "KNIFE", "knife_2", 4.1, 0, 1, 1, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "KNIFE", "knife_3", 4.1, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "KNIFE", "knife_4", 4.1, 0, 1, 1, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "KNIFE", "WEAPON_knifeidle", 4.1, 1, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Player", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cpr(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

CMD:dj(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/dj [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
    	case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, 1, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:point(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/point [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.1, 0, 0, 0, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 1, 0, 0, 0, 0, 1);
    	case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "point_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cheer(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/cheer [1-8]");

	if (type < 1 || type > 8)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 1, 0, 0, 0, 0, 1);
		case 5: ApplyAnimationEx(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: ApplyAnimationEx(playerid, "RIOT", "RIOT_shout", 4.1, 0, 0, 0, 0, 0, 1);
		case 7: ApplyAnimationEx(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 0, 0, 0, 0, 1);
		case 8: ApplyAnimationEx(playerid, "OTB", "wtchrace_win", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:wave(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/wave [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "endchat_03", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "KISSING", "gfwave2", 4.1, 0, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:smoke(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/smoke [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:reload(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/reload [1-4]");

	if (type < 1 || type > 4)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "UZI", "UZI_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: ApplyAnimationEx(playerid, "RIFLE", "rifle_load", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:taichi(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:wank(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/wank [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "PAULNMAC", "wank_in", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: ApplyAnimationEx(playerid, "PAULNMAC", "wank_out", 4.1, 0, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:cower(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
	return 1;
}

CMD:skate(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/skate [1-3]");

	if (type < 1 || type > 3)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "SKATE", "skate_idle", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: ApplyAnimationEx(playerid, "SKATE", "skate_run",  4.1, 1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimationEx(playerid, "SKATE", "skate_sprint", 4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:drunk(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}

CMD:cry(playerid, params[])
{
    if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:tired(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/tired [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
	}
	return 1;
}

CMD:sit(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/sit [1-6]");

	if (type < 1 || type > 6)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
		case 1: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 1, 0, 0, 0, 0);
		case 2: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 1, 0);
		case 3: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, 1, 0, 0, 0, 0);
		case 4: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.1, 1, 0, 0, 0, 0);
		case 5: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.1, 1, 0, 0, 0, 0);
		case 6: ApplyAnimationEx(playerid, "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/crossarms [1-5]");

	if (type < 1 || type > 5)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 0, 1);
	    case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0, 1);
	    case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0, 1);
	    case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 0, 1);
		case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:fuckyou(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/fuckyou [1-2]");

	if (type < 1 || type > 2)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) 
	{
	    case 1: ApplyAnimationEx(playerid,"PED","fucku",4.1, 0, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid,"RIOT","RIOT_FUKU",4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:walk(playerid, params[])
{
    new type;

	if (!AnimationCheck(playerid))
	    return SendErrorMessage(playerid, "You can't perform animations at the moment.");

	if (sscanf(params, "d", type))
	    return SendUsageMessage(playerid, "/walk [1-16]");

	if (type < 1 || type > 17)
	    return SendErrorMessage(playerid, "Invalid type specified.");

	switch (type) {
	    case 1: ApplyAnimationEx(playerid, "FAT", "FatWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 2: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleWalk", 4.1, 1, 1, 1, 1, 1, 1);
	    case 3: ApplyAnimationEx(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
	    case 4: ApplyAnimationEx(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 5: ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
	    case 6: ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 7: ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
	    case 8: ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
	    case 9: ApplyAnimationEx(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
	    case 10: ApplyAnimationEx(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
	    case 11: ApplyAnimationEx(playerid, "PED", "WALK_wuzi", 4.1, 1, 1, 1, 1, 1, 1);
	    case 12: ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 13: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.1, 1, 1, 1, 1, 1, 1);
	    case 14: ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.1, 1, 1, 1, 1, 1, 1);
	    case 15: ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
	    case 16: ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.1, 1, 1, 1, 1, 1, 1);
	}
	return 1;
}