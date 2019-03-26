//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
CMD:mappinghelp(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Mapping Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Mapping System: /createobject, /editobject, /deleteobject, /objectid");
        SendClientMessageEx(playerid, COLOR_GRAD5, "Mapping System: /gotoobject, /setmodelid, /getobject, /settexture");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:settexture(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new objectid, index, modelid, textureName[32], txdName[32];
        if(sscanf(params, "ddds[32]s[32]", objectid, index, modelid, textureName, txdName))
            return SendUsageMessage(playerid, "/getobject [object id] [Index] [Original ModelID] [Texture Name] [TXD Name]");

        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(i == objectid)
            {
                switch(index)
                {
                    case 0: MappingInfo[i][mTextureModelID0] = modelid;
                    case 1: MappingInfo[i][mTextureModelID1] = modelid;
                    case 2: MappingInfo[i][mTextureModelID2] = modelid;
                    case 3: MappingInfo[i][mTextureModelID3] = modelid;
                    case 4: MappingInfo[i][mTextureModelID4] = modelid;
                    case 5: MappingInfo[i][mTextureModelID5] = modelid;
                }
                switch(index)
                {
                    case 0: format(MappingInfo[i][mTextureName0], 32, "%s", textureName);
                    case 1: format(MappingInfo[i][mTextureName1], 32, "%s", textureName);
                    case 2: format(MappingInfo[i][mTextureName2], 32, "%s", textureName);
                    case 3: format(MappingInfo[i][mTextureName3], 32, "%s", textureName);
                    case 4: format(MappingInfo[i][mTextureName4], 32, "%s", textureName);
                    case 5: format(MappingInfo[i][mTextureName5], 32, "%s", textureName);
                }
                switch(index)
                {
                    case 0: format(MappingInfo[i][mTextureTXD0], 32, "%s", txdName);
                    case 1: format(MappingInfo[i][mTextureTXD1], 32, "%s", txdName);
                    case 2: format(MappingInfo[i][mTextureTXD2], 32, "%s", txdName);
                    case 3: format(MappingInfo[i][mTextureTXD3], 32, "%s", txdName);
                    case 4: format(MappingInfo[i][mTextureTXD4], 32, "%s", txdName);
                    case 5: format(MappingInfo[i][mTextureTXD5], 32, "%s", txdName);
                }

                ReloadObject(i);
                SaveMapping(i);
                
                SendClientMessageEx(playerid, COLOR_YELLOW, "You have modified the texture of object %d.", i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "That object does not exist in the database.");
    }
    return 1;
}

CMD:getobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new objectid;
        if(sscanf(params, "d", objectid))
            return SendUsageMessage(playerid, "/getobject [object id]");

        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(i == objectid)
            {
                GetPlayerPos(playerid, MappingInfo[i][mX], MappingInfo[i][mY], MappingInfo[i][mZ]);
                ReloadObject(i);
                SaveMapping(i);
                
                SendClientMessageEx(playerid, COLOR_YELLOW, "You have teleported to object %d.", i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "That object does not exist in the database.");
    }
    return 1;
}

CMD:setmodelid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new objectid, modelid;
        if(sscanf(params, "dd", objectid, modelid))
            return SendUsageMessage(playerid, "/gotoobject [object id]");

        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(i == objectid)
            {
                MappingInfo[i][mModelID] = modelid;
                SendClientMessageEx(playerid, COLOR_YELLOW, "You have set object %d's model to %d.", i, MappingInfo[i][mModelID]);
                ReloadObject(i);
                SaveMapping(i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "That object does not exist in the database.");
    }
    return 1;
}

CMD:gotoobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new objectid;
        if(sscanf(params, "d", objectid))
            return SendUsageMessage(playerid, "/gotoobject [object id]");

        if(objectid < 1 || objectid > MAX_DYN_OBJECTS)
            return SendErrorMessage(playerid, "Invalid object ID, valid from 1 to %d.", MAX_DYN_OBJECTS);

        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(i == objectid)
            {
                SetPlayerPosEx(playerid, MappingInfo[i][mX], MappingInfo[i][mY], MappingInfo[i][mZ]);
                SendClientMessageEx(playerid, COLOR_YELLOW, "You have teleported to object %d.", i);
                return 1;
            }
        }
        SendErrorMessage(playerid, "That object does not exist in the database.");
    }
    return 1;
}

CMD:objectid(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_WHITE, "Nearest objects...");
        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(MappingInfo[i][mModelID] > 0)
            {
                if(IsPlayerInRangeOfPoint(playerid, 20.0, MappingInfo[i][mX], MappingInfo[i][mY], MappingInfo[i][mZ]))
                {
                    SendClientMessageEx(playerid, COLOR_GRAD5, "ID: %d, Model: %d, Name: %s", i, MappingInfo[i][mModelID], MappingInfo[i][mName]);
                }
            }
        }
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

CMD:duplicateobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Select an object using the mouse cursor.");
        SelectObject(playerid);
        TempVar[playerid][SelectType] = SELECT_TYPE_DUP_MAPPING;
    }
    return 1;
}

CMD:deleteobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Select an object using the mouse cursor.");
        SelectObject(playerid);
        TempVar[playerid][SelectType] = SELECT_TYPE_DELETE_MAPPING;
    }
    return 1;
}

CMD:editobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "Select an object using the mouse cursor.");
        SelectObject(playerid);
        TempVar[playerid][SelectType] = SELECT_TYPE_EDIT_MAPPING;
    }
    return 1;
}

CMD:createobject(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new modelid, name[32];
        if(sscanf(params, "ds[32]", modelid, name))
        {
            SendUsageMessage(playerid, "/createobject [Model ID] [Object Name] - Be careful, incorrect model can cause problems.");
            return 1;
        }

        for(new i; i < MAX_DYN_OBJECTS; i++)
        {
            if(!MappingInfo[i][mID] && !IsValidDynamicObject(MappingInfo[i][mObjectID]))
            {
                new Float:pos[3];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                MappingInfo[i][mModelID] = modelid;
                MappingInfo[i][mX] = pos[0];
                MappingInfo[i][mY] = pos[1];
                MappingInfo[i][mZ] = pos[2];
                MappingInfo[i][mRX] = 0.0;
                MappingInfo[i][mRY] = 0.0;
                MappingInfo[i][mRZ] = 0.0;
                MappingInfo[i][mDrawDistance] = 0.0;
                format(MappingInfo[i][mName], 32, "%s", name);

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
                return 1;
            }
        }
    }
    return 1;
}

function ReloadObject(i)
{
    if(IsValidDynamicObject(MappingInfo[i][mObjectID]))
    {
        DestroyDynamicObject(MappingInfo[i][mObjectID]);
    }
    MappingInfo[i][mObjectID] = CreateDynamicObject(MappingInfo[i][mModelID],
                MappingInfo[i][mX],
                MappingInfo[i][mY],
                MappingInfo[i][mZ],
                MappingInfo[i][mRX],
                MappingInfo[i][mRY],
                MappingInfo[i][mRZ]);

    if(MappingInfo[i][mTextureModelID0] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 0, MappingInfo[i][mTextureModelID0], MappingInfo[i][mTextureName0], MappingInfo[i][mTextureTXD0], 0xFFFFFFFF);
    if(MappingInfo[i][mTextureModelID1] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 1, MappingInfo[i][mTextureModelID1], MappingInfo[i][mTextureName1], MappingInfo[i][mTextureTXD1], 0xFFFFFFFF);
    if(MappingInfo[i][mTextureModelID2] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 2, MappingInfo[i][mTextureModelID2], MappingInfo[i][mTextureName2], MappingInfo[i][mTextureTXD2], 0xFFFFFFFF);
    if(MappingInfo[i][mTextureModelID3] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 3, MappingInfo[i][mTextureModelID3], MappingInfo[i][mTextureName3], MappingInfo[i][mTextureTXD3], 0xFFFFFFFF);
    if(MappingInfo[i][mTextureModelID4] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 4, MappingInfo[i][mTextureModelID4], MappingInfo[i][mTextureName4], MappingInfo[i][mTextureTXD4], 0xFFFFFFFF);
    if(MappingInfo[i][mTextureModelID5] > 0) SetDynamicObjectMaterial(MappingInfo[i][mObjectID], 5, MappingInfo[i][mTextureModelID5], MappingInfo[i][mTextureName5], MappingInfo[i][mTextureTXD5], 0xFFFFFFFF);
}

function OnMappingCreate(playerid, i)
{
    MappingInfo[i][mID] = cache_insert_id();

    ReloadObject(i);

    TempVar[playerid][EditType] = EDIT_TYPE_EDIT_MAPPING;
    EditDynamicObject(playerid, MappingInfo[i][mObjectID]);
    TempVar[playerid][EditingMapID] = i;

    new string[128];
    format(string, sizeof string, "%s %s has created a new object with ID %d. [Name: %s]", GetStaffRank(playerid), GetMasterName(playerid), i, MappingInfo[i][mName]);
    SendAdminCommand(string, 4);
    return 1;
}

stock SaveMappings()
{
    for(new i; i < MAX_DYN_OBJECTS; i++)
    {
        if(MappingInfo[i][mID])
        {
            SaveMapping(i);
        }
    }
    return 1;
}

stock SaveMapping(i)
{
    new query[512];
    mysql_format(g_SQL, query, sizeof query, "UPDATE mapping SET ModelID = %d, X = %f, Y = %f, Z = %f, RX = %f, RY = %f, RZ = %f, DrawDistance = %f, Name = '%e' WHERE ID = %d LIMIT 1", 
        MappingInfo[i][mModelID],
        MappingInfo[i][mX],
        MappingInfo[i][mY],
        MappingInfo[i][mZ],
        MappingInfo[i][mRX],
        MappingInfo[i][mRY],
        MappingInfo[i][mRZ],
        MappingInfo[i][mDrawDistance],
        MappingInfo[i][mName],
        MappingInfo[i][mID]);
    mysql_tquery(g_SQL, query);
    return 1;
}

stock DeleteObjectFromSystem(objectid)
{
    new query[128];
    mysql_format(g_SQL, query, sizeof query, "DELETE FROM mapping WHERE ID = %d LIMIT 1", 
        MappingInfo[objectid][mID]);
    return mysql_tquery(g_SQL, query, "OnDeleteObject", "d", objectid);
}

function OnDeleteObject(objectid)
{
    DestroyDynamicObject(MappingInfo[objectid][mObjectID]);
    MappingInfo[objectid][mModelID] = 0;
    MappingInfo[objectid][mID] = 0;
    return 1;
}

stock LoadMapping()
{
    new rows;
    new Cache:result;

    result = mysql_query(g_SQL, "SELECT * FROM `mapping`");

    if(cache_get_row_count(rows)) 
    {
        for(new i = 0; i < rows; i++) 
        {
            mapCache = cache_save();
            cache_get_value_int(i, "ID", MappingInfo[i][mID]);
            cache_get_value_int(i, "ModelID", MappingInfo[i][mModelID]);
            cache_get_value_float(i, "X", MappingInfo[i][mX]);
            cache_get_value_float(i, "Y", MappingInfo[i][mY]);
            cache_get_value_float(i, "Z", MappingInfo[i][mZ]);
            cache_get_value_float(i, "RX", MappingInfo[i][mRX]);
            cache_get_value_float(i, "RY", MappingInfo[i][mRY]);
            cache_get_value_float(i, "RZ", MappingInfo[i][mRZ]);
            cache_get_value(i, "Name", MappingInfo[i][mName], 128);

            cache_get_value_int(i, "TextureModelID0", MappingInfo[i][mTextureModelID0]);
            cache_get_value_int(i, "TextureModelID1", MappingInfo[i][mTextureModelID1]);
            cache_get_value_int(i, "TextureModelID2", MappingInfo[i][mTextureModelID2]);
            cache_get_value_int(i, "TextureModelID3", MappingInfo[i][mTextureModelID3]);
            cache_get_value_int(i, "TextureModelID4", MappingInfo[i][mTextureModelID4]);
            cache_get_value_int(i, "TextureModelID5", MappingInfo[i][mTextureModelID5]);
            cache_get_value(i, "TextureName0", MappingInfo[i][mTextureName0], 32);
            cache_get_value(i, "TextureName1", MappingInfo[i][mTextureName1], 32);
            cache_get_value(i, "TextureName2", MappingInfo[i][mTextureName2], 32);
            cache_get_value(i, "TextureName3", MappingInfo[i][mTextureName3], 32);
            cache_get_value(i, "TextureName4", MappingInfo[i][mTextureName4], 32);
            cache_get_value(i, "TextureName5", MappingInfo[i][mTextureName5], 32);
            cache_get_value(i, "TextureTXD0", MappingInfo[i][mTextureTXD0], 32);
            cache_get_value(i, "TextureTXD1", MappingInfo[i][mTextureTXD1], 32);
            cache_get_value(i, "TextureTXD2", MappingInfo[i][mTextureTXD2], 32);
            cache_get_value(i, "TextureTXD3", MappingInfo[i][mTextureTXD3], 32);
            cache_get_value(i, "TextureTXD4", MappingInfo[i][mTextureTXD4], 32);
            cache_get_value(i, "TextureTXD5", MappingInfo[i][mTextureTXD5], 32);

            ReloadObject(i);
            Iter_Add(Mapping,i);
            cache_set_active(mapCache);
        }
    }
    cache_delete(result); 
}