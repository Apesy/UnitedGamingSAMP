//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#include <YSI\y_hooks>

new FarmPlant[103], CropLevel[103], Text3D:CropLevelLabel[103];
hook OnGameModeInit()
{
    FarmPlant[0] = CreateDynamicObject(819, 262.35928, 1124.48511, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[1] = CreateDynamicObject(819, 255.54878, 1124.51843, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[2] = CreateDynamicObject(819, 247.81273, 1123.76147, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[3] = CreateDynamicObject(819, 241.20302, 1123.23413, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[4] = CreateDynamicObject(819, 234.96658, 1122.99414, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[5] = CreateDynamicObject(819, 228.18193, 1122.58911, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[6] = CreateDynamicObject(819, 262.27777, 1153.76343, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[7] = CreateDynamicObject(819, 255.46709, 1154.09058, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[8] = CreateDynamicObject(819, 247.73018, 1153.63013, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[9] = CreateDynamicObject(819, 241.11948, 1153.40234, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[10] = CreateDynamicObject(819, 234.88239, 1153.46118, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[11] = CreateDynamicObject(819, 228.09671, 1153.36047, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[12] = CreateDynamicObject(819, 262.29572, 1147.31335, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[13] = CreateDynamicObject(819, 255.48509, 1147.57556, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[14] = CreateDynamicObject(819, 247.74835, 1147.05017, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[15] = CreateDynamicObject(819, 241.13786, 1146.75623, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[16] = CreateDynamicObject(819, 234.90094, 1146.74939, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[17] = CreateDynamicObject(819, 228.11551, 1146.58130, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[18] = CreateDynamicObject(819, 262.31372, 1140.85315, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[19] = CreateDynamicObject(819, 255.50313, 1141.05066, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[20] = CreateDynamicObject(819, 247.76656, 1140.45959, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[21] = CreateDynamicObject(819, 241.15631, 1140.09961, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[22] = CreateDynamicObject(819, 234.91953, 1140.02686, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[23] = CreateDynamicObject(819, 228.13429, 1139.79163, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[24] = CreateDynamicObject(819, 262.33054, 1134.80298, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[25] = CreateDynamicObject(819, 255.52002, 1134.93982, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[26] = CreateDynamicObject(819, 247.78362, 1134.28760, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[27] = CreateDynamicObject(819, 241.17357, 1133.86572, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[28] = CreateDynamicObject(819, 234.93692, 1133.73120, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[29] = CreateDynamicObject(819, 228.15192, 1133.43286, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[30] = CreateDynamicObject(819, 262.34457, 1129.76086, 10.82168,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[31] = CreateDynamicObject(819, 255.53409, 1129.84692, 11.22469,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[32] = CreateDynamicObject(819, 247.79785, 1129.14380, 11.73071,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[33] = CreateDynamicObject(819, 241.18796, 1128.67029, 12.14385,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[34] = CreateDynamicObject(819, 234.95142, 1128.48425, 12.66947,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[35] = CreateDynamicObject(819, 228.16661, 1128.13367, 12.97660,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[36] = CreateDynamicObject(819, 277.95834, 1040.06030, 25.26341,   0.00000, 0.00000, 359.84036, .worldid = 0, .interiorid = 0);
    FarmPlant[37] = CreateDynamicObject(819, 270.40417, 1040.11658, 25.26909,   0.00000, 0.00000, 359.84195, .worldid = 0, .interiorid = 0);
    FarmPlant[38] = CreateDynamicObject(819, 263.46521, 1040.08594, 25.27591,   0.00000, 0.00000, 359.84351, .worldid = 0, .interiorid = 0);
    FarmPlant[39] = CreateDynamicObject(819, 256.08585, 1039.99072, 25.28393,   0.00000, 0.00000, 359.84506, .worldid = 0, .interiorid = 0);
    FarmPlant[40] = CreateDynamicObject(819, 248.57697, 1040.42517, 25.29311,   0.00000, 0.00000, 359.84659, .worldid = 0, .interiorid = 0);
    FarmPlant[41] = CreateDynamicObject(819, 241.31480, 1040.55847, 25.30348,   0.00000, 0.00000, 359.84811, .worldid = 0, .interiorid = 0);
    FarmPlant[42] = CreateDynamicObject(819, 278.49628, 1095.72290, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[43] = CreateDynamicObject(819, 270.94287, 1095.82385, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[44] = CreateDynamicObject(819, 264.00436, 1095.84680, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[45] = CreateDynamicObject(819, 256.62637, 1095.80762, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[46] = CreateDynamicObject(819, 249.11772, 1096.30249, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[48] = CreateDynamicObject(819, 241.85619, 1096.50256, 13.41498,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[49] = CreateDynamicObject(819, 278.42871, 1089.35400, 14.57925,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[50] = CreateDynamicObject(819, 270.87466, 1089.39160, 14.59089,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[51] = CreateDynamicObject(819, 263.93546, 1089.34973, 14.60265,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[52] = CreateDynamicObject(819, 256.55673, 1089.24548, 14.61452,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[53] = CreateDynamicObject(819, 249.04744, 1089.67517, 14.62652,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[54] = CreateDynamicObject(819, 241.78520, 1089.80908, 14.63863,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[55] = CreateDynamicObject(819, 278.20334, 1083.00854, 15.59002,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[56] = CreateDynamicObject(819, 270.64719, 1082.98254, 15.61178,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[57] = CreateDynamicObject(819, 263.70569, 1082.87634, 15.63374,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[58] = CreateDynamicObject(819, 256.32443, 1082.70715, 15.65593,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[59] = CreateDynamicObject(819, 248.81297, 1083.07202, 15.67834,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[60] = CreateDynamicObject(819, 241.54836, 1083.14014, 15.70097,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[61] = CreateDynamicObject(819, 277.92377, 1077.52380, 16.87176,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[62] = CreateDynamicObject(819, 270.36478, 1077.44336, 16.90633,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[63] = CreateDynamicObject(819, 263.42056, 1077.28149, 16.94124,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[64] = CreateDynamicObject(819, 256.03644, 1077.05627, 16.97650,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[65] = CreateDynamicObject(819, 248.52209, 1077.36450, 17.01211,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[66] = CreateDynamicObject(819, 241.25455, 1077.37561, 17.04808,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[67] = CreateDynamicObject(819, 278.34412, 1071.57288, 18.32871,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[68] = CreateDynamicObject(819, 270.78934, 1071.43311, 18.37786,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[69] = CreateDynamicObject(819, 263.84943, 1071.21130, 18.42748,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[70] = CreateDynamicObject(819, 256.46957, 1070.92517, 18.47760,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[71] = CreateDynamicObject(819, 248.95949, 1071.17212, 18.52823,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[72] = CreateDynamicObject(819, 241.69630, 1071.12158, 18.57936,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[73] = CreateDynamicObject(819, 241.54372, 1065.00439, 19.90955,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[74] = CreateDynamicObject(819, 248.80846, 1065.11548, 19.84525,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[75] = CreateDynamicObject(819, 256.32004, 1064.92871, 19.78158,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[76] = CreateDynamicObject(819, 263.70132, 1065.27393, 19.71855,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[77] = CreateDynamicObject(819, 270.64273, 1065.55457, 19.65615,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[78] = CreateDynamicObject(819, 278.19897, 1065.75232, 19.59435,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[79] = CreateDynamicObject(819, 241.40903, 1059.59937, 20.81971,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[80] = CreateDynamicObject(819, 248.67235, 1059.65723, 20.76451,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[81] = CreateDynamicObject(819, 256.18259, 1059.41577, 20.71003,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[82] = CreateDynamicObject(819, 263.56253, 1059.70593, 20.65628,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[83] = CreateDynamicObject(819, 270.50241, 1059.93091, 20.60326,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[84] = CreateDynamicObject(819, 278.05725, 1060.07178, 20.55093,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[85] = CreateDynamicObject(819, 241.38548, 1054.84363, 21.83229,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[86] = CreateDynamicObject(819, 248.64853, 1054.85364, 21.78722,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[87] = CreateDynamicObject(819, 256.15845, 1054.56409, 21.74297,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[88] = CreateDynamicObject(819, 263.53824, 1054.80554, 21.69955,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[89] = CreateDynamicObject(819, 270.47784, 1054.98193, 21.65696,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[90] = CreateDynamicObject(819, 278.03253, 1055.07349, 21.61517,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[91] = CreateDynamicObject(819, 241.36362, 1050.42358, 22.76392,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[92] = CreateDynamicObject(819, 248.62639, 1050.38916, 22.72816,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[93] = CreateDynamicObject(819, 256.13599, 1050.05481, 22.69332,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[94] = CreateDynamicObject(819, 263.51566, 1050.25098, 22.65940,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[95] = CreateDynamicObject(819, 270.45505, 1050.38232, 22.62642,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[96] = CreateDynamicObject(819, 278.00958, 1050.42810, 22.59431,   0.00000, 0.00000, 0.00000, .worldid = 0, .interiorid = 0);
    FarmPlant[97] = CreateDynamicObject(819, 241.33983, 1045.61646, 24.02174,   0.00000, 0.00000, 359.84811, .worldid = 0, .interiorid = 0);
    FarmPlant[98] = CreateDynamicObject(819, 248.60231, 1045.53381, 23.99856,   0.00000, 0.00000, 359.84659, .worldid = 0, .interiorid = 0);
    FarmPlant[99] = CreateDynamicObject(819, 256.11157, 1045.15076, 23.97643,   0.00000, 0.00000, 359.84506, .worldid = 0, .interiorid = 0);
    FarmPlant[100] = CreateDynamicObject(819, 263.49109, 1045.29773, 23.95534,   0.00000, 0.00000, 359.84351, .worldid = 0, .interiorid = 0);
    FarmPlant[101] = CreateDynamicObject(819, 270.43024, 1045.37988, 23.93531,   0.00000, 0.00000, 359.84195, .worldid = 0, .interiorid = 0);
    FarmPlant[102] = CreateDynamicObject(819, 277.98462, 1045.37598, 23.91629,   0.00000, 0.00000, 359.84036, .worldid = 0, .interiorid = 0);

    for(new i; i < sizeof(FarmPlant); i++)
    {
        CropLevel[i] = 15;
        UpdateCropLevel(i);
    }
    return 1;
}

stock UpdateCropLevel(i)
{
    if(IsValidDynamic3DTextLabel(CropLevelLabel[i]))
        DestroyDynamic3DTextLabel(CropLevelLabel[i]);

    new Float:pos[3], string[20];
    GetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]);
    format(string, sizeof string, "Crop Level\n%d/15", CropLevel[i]);
    CropLevelLabel[i] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, pos[0], pos[1], pos[2]+0.5, 3.0, .worldid = 0, .interiorid = 0);
}

CMD:harvestcrop(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_FARMER)
        return SendErrorMessage(playerid, "You must be a farmer to be able to do this.");
    
    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
        return SendErrorMessage(playerid, "You must be crouched to do this.");

    new Float:pos[3];
    for(new i; i < sizeof(FarmPlant); i++)
    {
        GetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]);
        if(IsPlayerInRangeOfPoint(playerid, 3.0, pos[0], pos[1], pos[2]) && CropLevel[i] >= 15)
        {
            ApplyAnimationEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
            SetTimerEx("FarmerCP", 1000, false, "dd", playerid, i);
            return 1;
        }
    }
    SendErrorMessage(playerid, "You are not near a fully grown crop, wait until you see a floating label.");
    return 1;
}

CMD:farmerhelp(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_FARMER)
    {
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Farmer Help:{FFFFFF} Type a command for more information.");
        SendClientMessageEx(playerid, COLOR_GRAD5, "You must go to one of the crops that have a 15/15 level and use \"/harvestcrop\".");
        SendClientMessageEx(playerid, COLOR_GRAD4, "Crops take 15 minutes to be ready for harvesting, you cannot harvest before then.");
        SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    }
    return 1;
}

function FarmerCP(playerid, i)
{
    new Float:pos[3];
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_FARMER;
    CropLevel[i] = 0;
    UpdateCropLevel(i);
    GetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]);
    SetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]-15);
    SetPlayerAttachedObject(playerid, SLOT_MISC, 2901, 5, 0.019999, 0.074000, 0.209000, 0.000000, -78.299980, 0.000000, 1.000000, 1.000000, 1.000000);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerCheckpoint(playerid, 300.2046, 1141.2954, 9.1463, 2.5);
}

stock HandleFarmerDelivery(playerid)
{
    new rand = random(50)+10;
    TempVar[playerid][CheckpointType] = CHECKPOINT_TYPE_NONE;
    DisablePlayerCheckpoint(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, SLOT_MISC);
    ClearAnimations(playerid);
    SendActionMessage(playerid, "$%d was added to your pay cheque for completing the job.", rand);
    PlayerInfo[playerid][pPayCheque] += rand;
}

task CropTimer[60000]() 
{
    new Float:pos[3];
    for(new i; i < sizeof(FarmPlant); i++)
    {
        if(CropLevel[i] < 15)
        {
            GetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]);
            SetDynamicObjectPos(FarmPlant[i], pos[0], pos[1], pos[2]+1);
            CropLevel[i]++;
            UpdateCropLevel(i);
        }
    }
    return 1;
}