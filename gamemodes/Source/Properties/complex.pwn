//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#define MAX_COMPLEX 10 // 10 for now, I'll add more as needed.
#define COMPLEX_COLOUR 0x00FF00FF

enum complexEnum
{
    ComplexID,
    ComplexName[33],//32 + terminator
    ComplexFaction,
    ComplexOwnerID,
    Float:ComplexExteriorX,
    Float:ComplexExteriorY,
    Float:ComplexExteriorZ,
    Float:ComplexExteriorA,
    ComplexExteriorInt,
    ComplexExteriorVW,
    Float:ComplexInteriorX,
    Float:ComplexInteriorY,
    Float:ComplexInteriorZ,
    Float:ComplexInteriorA,
    ComplexInteriorInt,
    ComplexInteriorVW,

    ComplexPickup,
    Text3D:ComplexLabel
}
new ComplexInfo[MAX_COMPLEX][complexEnum],
    Cache:complexCache;

stock LoadComplexes()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `complex`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            complexCache = cache_save();
            cache_get_value_int(i, "ID", ComplexInfo[i+1][ComplexID]);

            cache_get_value(i, "Name", ComplexInfo[i+1][ComplexName]);
            cache_get_value_int(i, "Faction", ComplexInfo[i+1][ComplexFaction]);
            cache_get_value_int(i, "OwnerID", ComplexInfo[i+1][ComplexOwnerID]);

            cache_get_value_float(i, "ExteriorX", ComplexInfo[i+1][ComplexExteriorX]);
            cache_get_value_float(i, "ExteriorY", ComplexInfo[i+1][ComplexExteriorY]);
            cache_get_value_float(i, "ExteriorZ", ComplexInfo[i+1][ComplexExteriorZ]);
            cache_get_value_float(i, "ExteriorA", ComplexInfo[i+1][ComplexExteriorA]);
            cache_get_value_int(i, "ExteriorInt", ComplexInfo[i+1][ComplexExteriorInt]);
            cache_get_value_int(i, "ExteriorVW", ComplexInfo[i+1][ComplexExteriorVW]);

            cache_get_value_float(i, "InteriorX", ComplexInfo[i+1][ComplexInteriorX]);
            cache_get_value_float(i, "InteriorY", ComplexInfo[i+1][ComplexInteriorY]);
            cache_get_value_float(i, "InteriorZ", ComplexInfo[i+1][ComplexInteriorZ]);
            cache_get_value_float(i, "InteriorA", ComplexInfo[i+1][ComplexInteriorA]);
            cache_get_value_int(i, "InteriorInt", ComplexInfo[i+1][ComplexInteriorInt]);
            cache_get_value_int(i, "InteriorVW", ComplexInfo[i+1][ComplexInteriorVW]);

            UpdateComplexPickup(i+1);
            Iter_Add(Complexes,i);
            cache_set_active(complexCache);
        }
    }
    cache_delete(result); 
}

stock UpdateComplexPickup(i)
{
    if(i > 0 && i < MAX_COMPLEX)
    {
        if(IsValidDynamicPickup(ComplexInfo[i][ComplexPickup]))
        {
            DestroyDynamicPickup(ComplexInfo[i][ComplexPickup]);
        }

        if(IsValidDynamic3DTextLabel(ComplexInfo[i][ComplexLabel]))
        {
            DestroyDynamic3DTextLabel(ComplexInfo[i][ComplexLabel]);
        }

        if(ComplexInfo[i][ComplexID])
        {
            new string[128], ownerString[128];
            ComplexInfo[i][ComplexPickup] = CreateDynamicPickup(1314, 1, 
                ComplexInfo[i][ComplexExteriorX], ComplexInfo[i][ComplexExteriorY], ComplexInfo[i][ComplexExteriorZ], ComplexInfo[i][ComplexExteriorVW], ComplexInfo[i][ComplexExteriorInt]);

            if(ComplexInfo[i][ComplexOwnerID] != 0)
            {
                format(ownerString, sizeof ownerString, "Owned by %s", GetDatabaseName(ComplexInfo[i][ComplexOwnerID]));
            }
            else
            {
                format(ownerString, sizeof ownerString, "{FFFF00}FOR SALE{FFFFFF}", GetDatabaseName(ComplexInfo[i][ComplexOwnerID]));
            }

            if(ComplexInfo[i][ComplexFaction] != 0)
            {
                format(ownerString, sizeof ownerString, "Owned by %s", FactionInfo[ComplexInfo[i][ComplexFaction]][FactionName]);
            }

            format(string, sizeof string, "Apartment Complex{FFFFFF}\n%s\n{%06x}/enter", ComplexInfo[i][ComplexName], COMPLEX_COLOUR >>> 8);
            ComplexInfo[i][ComplexLabel] = CreateDynamic3DTextLabel(string, COMPLEX_COLOUR, 
                ComplexInfo[i][ComplexExteriorX], ComplexInfo[i][ComplexExteriorY], ComplexInfo[i][ComplexExteriorZ]+0.50, 20.0, .testlos = 0);
        }
    }
}

stock SaveComplexes()
{
    for(new i = 1; i < MAX_COMPLEX; i++)
    {
        if(ComplexInfo[i][ComplexID])
        {
            SaveComplex(i);
        }
    }
}

stock SaveComplex(i)
{
    new string[512];
    mysql_format(g_SQL, string, sizeof string, "UPDATE `complex` SET \
    `Name` = '%s',\
    `Faction` = %d,\
    `OwnerID` = %d,\
    `ExteriorX` = %f,\
    `ExteriorY` = %f,\
    `ExteriorZ` = %f,\
    `ExteriorA` = %f,\
    `ExteriorInt` = %d,\
    `ExteriorVW` = %d,\
    `InteriorX` = %f,\
    `InteriorY` = %f,\
    `InteriorZ` = %f,\
    `InteriorA` = %f,\
    `InteriorInt` = %d,\
    `InteriorVW` = %d WHERE `ID` = %d LIMIT 1", 
    ComplexInfo[i][ComplexName],
    ComplexInfo[i][ComplexFaction],
    ComplexInfo[i][ComplexOwnerID],
    ComplexInfo[i][ComplexExteriorX],
    ComplexInfo[i][ComplexExteriorY],
    ComplexInfo[i][ComplexExteriorZ],
    ComplexInfo[i][ComplexExteriorA],
    ComplexInfo[i][ComplexExteriorInt],
    ComplexInfo[i][ComplexExteriorVW],
    ComplexInfo[i][ComplexInteriorX],
    ComplexInfo[i][ComplexInteriorY],
    ComplexInfo[i][ComplexInteriorZ],
    ComplexInfo[i][ComplexInteriorA],
    ComplexInfo[i][ComplexInteriorInt],
    ComplexInfo[i][ComplexInteriorVW],
    ComplexInfo[i][ComplexID]);
    mysql_tquery(g_SQL, string);
}

CMD:complexhelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Apartment Complex Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /createcomplex, /editcomplex, /deletecomplex.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:createcomplex(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        if(isnull(params))
            return SendUsageMessage(playerid, "/createcomplex [Apartment Complex Name]");
        
        if(strlen(params) < 5 || strlen(params) > 32)
            return SendErrorMessage(playerid, "Name is too long, minimum of 5 and maximum of 32. You entered %d characters.", strlen(params));

        for(new i = 1; i < MAX_COMPLEX; i++)
        {
            if(!ComplexInfo[i][ComplexID])
            {
                new Float:x, Float:y, Float:z, Float:ang, string[256];
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, Float:ang);
                mysql_format(g_SQL, string, sizeof string, "INSERT INTO `complex` (`Name`, `ExteriorX`, `ExteriorY`, `ExteriorZ`, `ExteriorA`, `ExteriorInt`, `ExteriorVW`) VALUES ('%e', %f, %f, %f, %f, %d, %d)", 
                params, x, y, z, ang, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
                mysql_tquery(g_SQL, string, "OnCreateComplex", "dffffsd", playerid, x, y, z, ang, params, i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "Cannot create complex, limit was reached. (Limit: %d)", MAX_COMPLEX);
    }
    return 1;
}

function OnCreateComplex(playerid, Float:px, Float:py, Float:pz, Float:ang, name[], i)
{
    ComplexInfo[i][ComplexID] = i;
    format(ComplexInfo[i][ComplexName], 33, "%s", name);
    ComplexInfo[i][ComplexExteriorX] = px;
    ComplexInfo[i][ComplexExteriorY] = py;
    ComplexInfo[i][ComplexExteriorZ] = pz;
    ComplexInfo[i][ComplexExteriorInt] = GetPlayerInterior(playerid);
    ComplexInfo[i][ComplexExteriorVW] = GetPlayerVirtualWorld(playerid);
    ComplexInfo[i][ComplexExteriorA] = ang;
    UpdateComplexPickup(i);
    SaveComplex(i);
    SendClientMessageEx(playerid, COLOR_YELLOW, "Complex created with ID %d.", i);
    return 1;
}

stock ShowComplexEditMenu(playerid, aptID)
{
    SetPVarInt(playerid, "ComplexID", aptID);
    Dialog_Show(playerid, EditComplex, DIALOG_STYLE_LIST, "Editing Complex", "Complex Name\n\
        Outside Position\n\
        Inside Position\n\
        Assigned Faction\n", "Select", "Exit");
}

CMD:editcomplex(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new aptID;
        if(sscanf(params, "d", aptID))
            return SendUsageMessage(playerid, "/edit [Complex ID]");
        
        if(aptID < 1 || aptID > MAX_COMPLEX)
            return SendErrorMessage(playerid, "Valid Complexes are between 1 and %d.", MAX_COMPLEX);

        ShowComplexEditMenu(playerid, aptID);
    }
    return 1;
}

CMD:deletecomplex(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new i;
        if(sscanf(params, "d", i))
            return SendUsageMessage(playerid, "/deletecomplex [Complex ID]");
        
        if(i < 1 || i > MAX_COMPLEX)
            return SendErrorMessage(playerid, "Valid Complexes are between 1 and %d.", MAX_COMPLEX);

        if(!ComplexInfo[i][ComplexID])
            return SendErrorMessage(playerid, "No such complex exists.");

        ComplexInfo[i][ComplexName][0] = 0;
        ComplexInfo[i][ComplexFaction] = 0;
        ComplexInfo[i][ComplexOwnerID] = 0;
        ComplexInfo[i][ComplexExteriorX] = 0;
        ComplexInfo[i][ComplexExteriorY] = 0;
        ComplexInfo[i][ComplexExteriorZ] = 0;
        ComplexInfo[i][ComplexExteriorA] = 0;
        ComplexInfo[i][ComplexExteriorInt] = 0;
        ComplexInfo[i][ComplexExteriorVW] = 0;
        ComplexInfo[i][ComplexInteriorX] = 0;
        ComplexInfo[i][ComplexInteriorY] = 0;
        ComplexInfo[i][ComplexInteriorZ] = 0;
        ComplexInfo[i][ComplexInteriorA] = 0;
        ComplexInfo[i][ComplexInteriorInt] = 0;
        ComplexInfo[i][ComplexInteriorVW] = 0;
        ComplexInfo[i][ComplexID] = 0;
        SendClientMessageEx(playerid, COLOR_YELLOW, "Complex %d deleted.", i);
    }
    return 1;
}


Dialog:ComplexName(playerid, response, listitem, inputtext[])
{
    new aptID = GetPVarInt(playerid, "ComplexID");
    if(response)
    {
        format(ComplexInfo[aptID][ComplexName], 33, "%s", inputtext);
        SendClientMessageEx(playerid, COLOR_YELLOW, "Complex %d name set to: %s", aptID, inputtext);
        UpdateComplexPickup(aptID);
        SaveComplex(aptID);
    }
    ShowComplexEditMenu(playerid, aptID);
    return 1;
}

Dialog:ComplexFaction(playerid, response, listitem, inputtext[])
{
    new aptID = GetPVarInt(playerid, "ComplexID");
    if(response)
    {
        ComplexInfo[aptID][ComplexName] = listitem + 1;
        SendClientMessageEx(playerid, COLOR_YELLOW, "Complex %d faction assigned to: %s", aptID, FactionInfo[listitem+1][FactionName]);
        UpdateComplexPickup(aptID);
        SaveComplex(aptID);
    }
    ShowComplexEditMenu(playerid, aptID);
    return 1;
}

Dialog:EditComplex(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = GetPVarInt(playerid, "ComplexID");
        switch(listitem)
        {
            case 0:
            {
                Dialog_Show(playerid, ComplexName, DIALOG_STYLE_INPUT, "Complex Name", "Input the new name for the apartment complex.\n\
                Minimum of 5 and a max", "Continue", "Back");
            }
            case 1:
            {
                new Float:x, Float:y, Float:z, Float:ang;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, Float:ang);
                ComplexInfo[i][ComplexExteriorX] = x;
                ComplexInfo[i][ComplexExteriorY] = y;
                ComplexInfo[i][ComplexExteriorZ] = z;
                ComplexInfo[i][ComplexExteriorA] = ang;
                ComplexInfo[i][ComplexExteriorInt] = GetPlayerInterior(playerid);
                ComplexInfo[i][ComplexExteriorVW] = GetPlayerVirtualWorld(playerid);
                UpdateComplexPickup(i);
                SaveComplex(i);
            }
            case 2:
            {
                new Float:x, Float:y, Float:z, Float:ang;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, Float:ang);
                ComplexInfo[i][ComplexInteriorX] = x;
                ComplexInfo[i][ComplexInteriorY] = y;
                ComplexInfo[i][ComplexInteriorZ] = z;
                ComplexInfo[i][ComplexInteriorA] = ang;
                ComplexInfo[i][ComplexInteriorInt] = GetPlayerInterior(playerid);
                ComplexInfo[i][ComplexInteriorVW] = GetPlayerVirtualWorld(playerid);
                UpdateComplexPickup(i);
                SaveComplex(i);
            }
            case 3:
            {
                new string[128], bool:found = false;
                format(string, sizeof string, "ID\t\tname\n");
                for(new f; f < sizeof(FactionInfo); f++)
                {
                    if(FactionInfo[f][FactionID])
                    {
                        found = true;
                        format(string, sizeof string, "%s%d\t\t%s\n", string, f, FactionInfo[f][FactionName]);
                    }
                }

                if(found == true)
                {
                    Dialog_Show(playerid, ComplexFaction, DIALOG_STYLE_TABLIST_HEADERS, "Complex Faction", string, "Select", "Back");
                }
                else
                {
                    SendErrorMessage(playerid, "There are no factions.");
                    ShowComplexEditMenu(playerid, i);
                }
            }
        }
    }
    return 1;
}

stock Complex_HandleEnter(playerid)
{
    for(new i = 1; i < MAX_COMPLEX; i++)
    {
        if(ComplexInfo[i][ComplexID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, ComplexInfo[i][ComplexExteriorX], ComplexInfo[i][ComplexExteriorY], ComplexInfo[i][ComplexExteriorZ]))
        {
            if(GetPlayerInterior(playerid) != ComplexInfo[i][ComplexExteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != ComplexInfo[i][ComplexExteriorVW])
				continue;

            if(IsPlayerInAnyVehicle(playerid))
                return SendErrorMessage(playerid, "You need to leave your vehicle.");

            SetPlayerPosEx(playerid, ComplexInfo[i][ComplexInteriorX], ComplexInfo[i][ComplexInteriorY], ComplexInfo[i][ComplexInteriorZ]);
            SetPlayerFacingAngle(playerid, ComplexInfo[i][ComplexInteriorA]);
            SetVirtualWorld(playerid, ComplexInfo[i][ComplexInteriorVW]);
            SetInterior(playerid, ComplexInfo[i][ComplexInteriorInt]);
            TogglePlayerWait(playerid);
            PrintFooter(playerid, "~w~Type /exit to get out", 5);
            return 1;
        }
    }
    return 1;
}

stock Complex_HandleExit(playerid)
{
    for(new i = 1; i < MAX_COMPLEX; i++)
    {
        if(ComplexInfo[i][ComplexID] > 0 && IsPlayerInRangeOfPoint(playerid, 3.0, ComplexInfo[i][ComplexInteriorX], ComplexInfo[i][ComplexInteriorY], ComplexInfo[i][ComplexInteriorZ]))
        {
            if(GetPlayerInterior(playerid) != ComplexInfo[i][ComplexInteriorInt])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != ComplexInfo[i][ComplexInteriorVW])
				continue;

            if(IsPlayerInAnyVehicle(playerid))
                return SendErrorMessage(playerid, "You need to leave your vehicle.");

            SetPlayerPosEx(playerid, ComplexInfo[i][ComplexExteriorX], ComplexInfo[i][ComplexExteriorY], ComplexInfo[i][ComplexExteriorZ]);
            SetPlayerFacingAngle(playerid, ComplexInfo[i][ComplexExteriorA]);
            SetVirtualWorld(playerid, ComplexInfo[i][ComplexExteriorVW]);
            SetInterior(playerid, ComplexInfo[i][ComplexExteriorInt]);
            if(ComplexInfo[i][ComplexExteriorInt] > 0)
            {
                TogglePlayerWait(playerid);
            }
            return 1;
        }
    }
    return 1;
}