//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//
stock ShowClothingMain(playerid)
{
    Dialog_Show(playerid, ClothingMain, DIALOG_STYLE_LIST, "Clothing", "Wear / Remove\nAdjust Position\nAdjust Bone\nDrop", "Select", "Exit");
}

stock ShowClothingWear(playerid)
{
    new dialogString[1024], string[128], bool:found = false;
    strcat(dialogString, "ID\t\tName\n");
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(AccInfo[playerid][i][aModel] > 0)
        {
            found = true;
            format(string, sizeof string, "%d\t\tUnknown\n", i);
            for(new x; x < sizeof(GlobalAttachments); x++)
            {
                if(AccInfo[playerid][i][aModel] == GlobalAttachments[x][Model])
                {
                    format(string, sizeof string, "%d\t\t%s\n", i, GlobalAttachments[x][Name]);
                }
            }
            strcat(dialogString, string);
        }
        else
        {
            format(string, sizeof string, "%d\t\tEmpty\n", i);
            strcat(dialogString, string);
        }
    }
    if(found == false)
    {
        SendErrorMessage(playerid, "You do not own any accessory items. Buy some from a clothes shop.");
        ShowClothingMain(playerid);
    }
    else
    {
        Dialog_Show(playerid, ClothingWear, DIALOG_STYLE_TABLIST_HEADERS, "Wear / Remove Accessories", dialogString, "Select", "Back");
    }
}

stock ShowClothingEdit(playerid)
{
    new dialogString[1024], string[128], bool:found = false;
    strcat(dialogString, "Slot\t\tName\n");
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(AccInfo[playerid][i][aModel] > 0)
        {
            found = true;
            format(string, sizeof string, "%d\t\tUnknown\n", i);
            for(new x; x < sizeof(GlobalAttachments); x++)
            {
                if(AccInfo[playerid][i][aModel] == GlobalAttachments[x][Model])
                {
                    format(string, sizeof string, "%d\t\t%s\n", i, GlobalAttachments[x][Name]);
                    strcat(dialogString, string);
                }
            }
        }
        else
        {
            format(string, sizeof string, "%d\t\tEmpty\n", i);
            strcat(dialogString, string);
        }
    }
    if(found == false)
    {
        SendErrorMessage(playerid, "You do not own any accessory items. Buy some from a clothes shop.");
        ShowClothingMain(playerid);
    }
    else
    {
        Dialog_Show(playerid, ClothingAdjust, DIALOG_STYLE_TABLIST_HEADERS, "Adjust Accessories", dialogString, "Select", "Back");
    }
}

stock ShowClothingBoneEdit(playerid)
{
    new dialogString[1024], string[128], bool:found = false;
    strcat(dialogString, "Slot\t\tName\n");
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(AccInfo[playerid][i][aModel] > 0)
        {
            found = true;
            format(string, sizeof string, "%d\t\tUnknown\n", i);
            for(new x; x < sizeof(GlobalAttachments); x++)
            {
                if(AccInfo[playerid][i][aModel] == GlobalAttachments[x][Model])
                {
                    format(string, sizeof string, "%d\t\t%s\n", i, GlobalAttachments[x][Name]);
                    strcat(dialogString, string);
                }
            }
        }
        else
        {
            format(string, sizeof string, "%d\t\tEmpty\n", i);
            strcat(dialogString, string);
        }
    }
    if(found == false)
    {
        SendErrorMessage(playerid, "You do not own any accessory items. Buy some from a clothes shop.");
        ShowClothingMain(playerid);
    }
    else
    {
        Dialog_Show(playerid, ClothingAdjustBone, DIALOG_STYLE_TABLIST_HEADERS, "Adjust Accessory Bone", dialogString, "Select", "Back");
    }
}

Dialog:ClothingAdjustBone(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        SetPVarInt(playerid, "AttachmentID", listitem);
        Dialog_Show(playerid, ClothingAdjustBoneList, DIALOG_STYLE_LIST, "Adjust Accessory Bone", "Spine\n\
            Head\n\
            Left Upper Arm\n\
            Right Upper Arm\n\
            Left Hand\n\
            Right Hand\n\
            Left Thigh\n\
            Right Thigh\n\
            Left Foot\n\
            Right Foot", "Select", "Cancel");
    }
    else ShowClothingMain(playerid);
    return 1;
}

Dialog:ClothingAdjustBoneList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new editid = GetPVarInt(playerid, "AttachmentID");
        switch(listitem)
        {
            case 0:
            {
                AccInfo[playerid][editid][aBone] = 1;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Spine", listitem);
            }
            case 1:
            {
                AccInfo[playerid][editid][aBone] = 2;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Head", listitem);
            }
            case 2:
            {
                AccInfo[playerid][editid][aBone] = 3;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Left Upper Arm", listitem);
            }
            case 3:
            {
                AccInfo[playerid][editid][aBone] = 4;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Right Upper Arm", listitem);
            }
            case 4:
            {
                AccInfo[playerid][editid][aBone] = 5;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Left Hand", listitem);
            }
            case 5:
            {
                AccInfo[playerid][editid][aBone] = 6;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Right Hand", listitem);
            }
            case 6:
            {
                AccInfo[playerid][editid][aBone] = 7;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Left Thigh", listitem);
            }
            case 7:
            {
                AccInfo[playerid][editid][aBone] = 8;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Right Thigh", listitem);
            }
            case 8:
            {
                AccInfo[playerid][editid][aBone] = 9;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Left Foot", listitem);
            }
            case 9:
            {
                AccInfo[playerid][editid][aBone] = 10;
                SendClientMessageEx(playerid, COLOR_YELLOW, "Accessory %d bone set to Right Foot", listitem);
            }
        }

        if(IsPlayerAttachedObjectSlotUsed(playerid, editid))
        {
            RemovePlayerAttachedObject(playerid, editid);
            SetPlayerAttachedObject(playerid, editid, AccInfo[playerid][editid][aModel], AccInfo[playerid][editid][aBone], 
            AccInfo[playerid][editid][aX], AccInfo[playerid][editid][aY], AccInfo[playerid][editid][aZ], 
            AccInfo[playerid][editid][aRX], AccInfo[playerid][editid][aRY], AccInfo[playerid][editid][aRZ], 
            AccInfo[playerid][editid][aSX], AccInfo[playerid][editid][aSY], AccInfo[playerid][editid][aSZ]);
        }
        SavePlayerClothing(playerid);
    }
    else ShowClothingMain(playerid);
    return 1;
}

stock ShowClothingDrop(playerid)
{
    new dialogString[1024], string[128], bool:found = false;
    strcat(dialogString, "Slot\t\tName\n");
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(AccInfo[playerid][i][aModel] > 0)
        {
            found = true;
            format(string, sizeof string, "%d\t\tUnknown\n", i);
            for(new x; x < sizeof(GlobalAttachments); x++)
            {
                if(AccInfo[playerid][i][aModel] == GlobalAttachments[x][Model])
                {
                    format(string, sizeof string, "%d\t\t%s\n", i, GlobalAttachments[x][Name]);
                    strcat(dialogString, string);
                }
            }
        }
        else
        {
            format(string, sizeof string, "%d\t\tEmpty\n", i);
            strcat(dialogString, string);
        }
    }
    if(found == false)
    {
        SendErrorMessage(playerid, "You do not own any accessory items.");
        ShowClothingMain(playerid);
    }
    else
    {
        Dialog_Show(playerid, ClothingDrop, DIALOG_STYLE_TABLIST_HEADERS, "Drop Accessories", dialogString, "Select", "Back");
    }
}

CMD:clothing(playerid, params[])
{
    ShowClothingMain(playerid);
    return 1;
}

Dialog:ClothingMain(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                ShowClothingWear(playerid);
            }
            case 1:
            {
                ShowClothingEdit(playerid);
            }
            case 2:
            {
                ShowClothingBoneEdit(playerid);
            }
            case 3:
            {
                ShowClothingDrop(playerid);
            }
        }
    }
    return 1;
}

Dialog:ClothingWear(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!IsPlayerAttachedObjectSlotUsed(playerid, listitem))
        {
            if(AccInfo[playerid][listitem][aModel] > 0)
            {
                if(AccInfo[playerid][listitem][aSX] == 0.0)
                {
                    AccInfo[playerid][listitem][aSX] = 1.0;
                }

                if(AccInfo[playerid][listitem][aSY] == 0.0)
                {
                    AccInfo[playerid][listitem][aSY] = 1.0;
                }

                if(AccInfo[playerid][listitem][aSZ] == 0.0)
                {
                    AccInfo[playerid][listitem][aSZ] = 1.0;
                }

                /*if(AccInfo[playerid][listitem][aX] > 2.0)
                {
                    AccInfo[playerid][listitem][aX] = 2.0;
                }

                if(AccInfo[playerid][listitem][aY] > 2.0)
                {
                    AccInfo[playerid][listitem][aZ] = 2.0;
                }

                if(AccInfo[playerid][listitem][aZ] > 2.0)
                {
                    AccInfo[playerid][listitem][aZ] = 2.0;
                }*/

                SetPlayerAttachedObject(playerid, listitem, 
                AccInfo[playerid][listitem][aModel], AccInfo[playerid][listitem][aBone], 
                AccInfo[playerid][listitem][aX], AccInfo[playerid][listitem][aY], AccInfo[playerid][listitem][aZ], 
                AccInfo[playerid][listitem][aRX], AccInfo[playerid][listitem][aRY], AccInfo[playerid][listitem][aRZ], 
                AccInfo[playerid][listitem][aSX], AccInfo[playerid][listitem][aSY], AccInfo[playerid][listitem][aSZ]);
                SendClientMessageEx(playerid, COLOR_WHITE, "Accessory attached on slot %d.", listitem);
            }
            else
            {
                SendErrorMessage(playerid, "There is nothing there...");
                ShowClothingWear(playerid);
            }
        }
        else 
        {
            RemovePlayerAttachedObject(playerid, listitem);
            SendClientMessage(playerid, -1, "Object Removed.");
        }
    }
    else ShowClothingMain(playerid);
    return 1;
}

Dialog:ClothingAdjust(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(AccInfo[playerid][listitem][aModel] > 0)
        {    
            if(AccInfo[playerid][listitem][aSX] == 0.0)
            {
                AccInfo[playerid][listitem][aSX] = 1.0;
            }

            if(AccInfo[playerid][listitem][aSY] == 0.0)
            {
                AccInfo[playerid][listitem][aSY] = 1.0;
            }

            if(AccInfo[playerid][listitem][aSZ] == 0.0)
            {
                AccInfo[playerid][listitem][aSZ] = 1.0;
            }

            if(!IsPlayerAttachedObjectSlotUsed(playerid, listitem))
            {
                SetPlayerAttachedObject(playerid, listitem, 
                AccInfo[playerid][listitem][aModel], AccInfo[playerid][listitem][aBone], 
                AccInfo[playerid][listitem][aX], AccInfo[playerid][listitem][aY], AccInfo[playerid][listitem][aZ], 
                AccInfo[playerid][listitem][aRX], AccInfo[playerid][listitem][aRY], AccInfo[playerid][listitem][aRZ], 
                AccInfo[playerid][listitem][aSX], AccInfo[playerid][listitem][aSY], AccInfo[playerid][listitem][aSZ]);
            }
            TempVar[playerid][EditType] = EDIT_TYPE_ACCESSORY;
            SetPVarInt(playerid, "AttachmentID", listitem);
            EditAttachedObject(playerid, listitem);
            SendClientMessageEx(playerid, COLOR_YELLOW, "Adjusting accessory on slot %d.", listitem);
            SendClientMessage(playerid, COLOR_YELLOW, "Use your {00FF00}Mouse Cursor{FFFF00} to select a button or move the object. Use {00FF00}~k~~PED_SPRINT~{FFFF00} to adjust the camera.");
            SendClientMessage(playerid, COLOR_YELLOW, "Click the {00FF00}Floppy Disk{FFFF00} to confirm the adjustment or press {00FF00}ESC{FFFF00} to cancel.");
        }
        else
        {
            SendErrorMessage(playerid, "There is nothing there...");
            ShowClothingEdit(playerid);
        }
    }
    else ShowClothingMain(playerid);
    return 1;
}

Dialog:ClothingDrop(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(AccInfo[playerid][listitem][aModel] > 0)
        {
            if(IsPlayerAttachedObjectSlotUsed(playerid, listitem))
            {
                RemovePlayerAttachedObject(playerid, listitem);
            }
            new query[256];
            mysql_format(g_SQL, query, sizeof query, "DELETE FROM `accessories` WHERE `ID` = %d LIMIT 1", AccInfo[playerid][listitem][aID]);
            mysql_tquery(g_SQL, query, "OnDropAttachment", "dd", playerid, listitem);
        }
        else
        {
            SendErrorMessage(playerid, "There is nothing there...");
            ShowClothingEdit(playerid);
        }
    }
    else ShowClothingMain(playerid);
    return 1;
}

CMD:giveaccessory(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new targetid, bone, objectid;
        if(sscanf(params, "udd", targetid, bone, objectid))
        {
            SendUsageMessage(playerid, "/giveaccessory [PlayerID/PartOfName] [Bone]");
            SendClientMessage(playerid, COLOR_GRAD6, "Valid Bones: 1. Spine, 2. Head, 3. Left Upper Arm, 4. Right Upper Arm, 5. Left Hand, 6. Right Hand");
            SendClientMessage(playerid, COLOR_GRAD5, "Valid Bones: 7. Left Thigh, 8. Right Thigh, 9. Left Foot, 10. Right Foot, 11. Right Calf, 12. Left Calf");
            SendClientMessage(playerid, COLOR_GRAD4, "Valid Bones: 13. Left Forearm, 14. Right Forearm, 15. Left Clavicle, 16. Right Clavicle, 17. Neck, 18. Jaw");
            return 1;
        }

        if(!IsPlayerConnected(targetid))
            return SendErrorMessage(playerid, "You have specified an invalid PlayerID/PartOfName.");

        if(bone < 1 || bone > 18)
            return SendErrorMessage(playerid, "You have specified an invalid bone (Valid is from 1 to 18).");

        new string[128*180];
        SetPVarInt(playerid, "Bone", bone);
        SetPVarInt(playerid, "GiveID", targetid);
        for(new i; i < sizeof(GlobalAttachments); i++)
        {
            format(string, sizeof string, "%s", GlobalAttachments[i][Name]);
        }

        Dialog_Show(playerid, Admin_GiveAttachment, DIALOG_STYLE_LIST, "Give Accessory", string, "Give", "Exit");
    }
    return 1;
}

Dialog:Admin_GiveAttachment(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new query[256], targetid = GetPVarInt(playerid, "GiveID");
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `accessories` (`CharacterID`, `Bone`, `Model`, `PosX`, `PosY`, `PosZ`, `PosRX`, `PosRY`, `PosRZ`, `PosSX`, `PosSY`, `PosSZ`) VALUES (%d, %d, %d, 0, 0, 0, 0, 0, 0, 1, 1, 1)",
        PlayerInfo[targetid][pCharacterID], GetPVarInt(playerid, "Bone"), GlobalAttachments[listitem][Model]);
        mysql_tquery(g_SQL, query, "OnGiveAccessory", "dddd", playerid, targetid, GlobalAttachments[listitem][Model], GetPVarInt(playerid, "Bone"));
    }
    DeletePVar(playerid, "GiveID");
    DeletePVar(playerid, "Bone");
    return 1;
}

function OnDropAttachment(playerid, i)
{
    AccInfo[playerid][i][aID] = 0;
    AccInfo[playerid][i][aModel] = 0;
    AccInfo[playerid][i][aCharacterID] = 0;
    AccInfo[playerid][i][aBone] = 0;
    AccInfo[playerid][i][aX] = 0.0;
    AccInfo[playerid][i][aY] = 0.0;
    AccInfo[playerid][i][aZ] = 0.0;
    AccInfo[playerid][i][aRX] = 0.0;
    AccInfo[playerid][i][aRY] = 0.0;
    AccInfo[playerid][i][aRZ] = 0.0;
    AccInfo[playerid][i][aSX] = 1.0;
    AccInfo[playerid][i][aSY] = 1.0;
    AccInfo[playerid][i][aSZ] = 1.0;
    return 1;
}

function OnGiveAccessory(playerid, targetid, objectid, bone)
{
    for(new i; i < MAX_ACCESSORIES; i++)
    {
        if(AccInfo[targetid][i][aModel] == 0)
        {
            AccInfo[targetid][i][aID] = cache_insert_id();
            AccInfo[targetid][i][aModel] = objectid;
            AccInfo[targetid][i][aCharacterID] = PlayerInfo[targetid][pCharacterID];
            AccInfo[targetid][i][aBone] = bone;
            AccInfo[targetid][i][aX] = 0.0;
            AccInfo[targetid][i][aY] = 0.0;
            AccInfo[targetid][i][aZ] = 0.0;
            AccInfo[targetid][i][aRX] = 0.0;
            AccInfo[targetid][i][aRY] = 0.0;
            AccInfo[targetid][i][aRZ] = 0.0;
            AccInfo[targetid][i][aSX] = 1.0;
            AccInfo[targetid][i][aSY] = 1.0;
            AccInfo[targetid][i][aSZ] = 1.0;
            SendClientMessageEx(targetid, COLOR_LIGHTBLUE, "* You were given an attachment by %s %s in slot %d.", GetAdminRank(playerid), GetMasterName(playerid), i);
            if(targetid != playerid)
            {
                SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have given %s an attachment in slot %d.", GetUserName(targetid), i);
            }
            return 1;
        }
    }
    return 1;
}