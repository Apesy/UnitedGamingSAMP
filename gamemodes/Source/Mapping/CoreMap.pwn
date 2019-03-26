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

stock LoadBlankHouseInteriors()
{
    // Blank House Interior 1
    CreateDynamicObject(19446, -47.89640, 1115.47986, 1121.56543,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19379, -42.77380, 1114.65491, 1119.85815,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19379, -32.27500, 1114.65491, 1119.85803,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19446, -43.27630, 1112.98254, 1121.56543,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19446, -33.65000, 1112.98242, 1121.56543,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19446, -33.00000, 1115.47986, 1121.56543,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19446, -43.27630, 1119.05005, 1121.56543,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19446, -33.65000, 1119.05103, 1121.56543,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19379, -32.27500, 1114.65491, 1123.40295,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19379, -42.77380, 1114.65491, 1123.40210,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(1522, -47.86160, 1113.07312, 1119.91797,   0.00000, 0.00000, 90.00000, .interiorid = 1);
    CreateDynamicObject(1522, -47.86160, 1117.44995, 1119.91797,   0.00000, 0.00000, 90.00000, .interiorid = 2);
    return 1;
}

stock LoadStaticMaps()
{
    // Impound Lot
    CreateDynamic3DTextLabel("Impound Lot\n{FFFFFF}((/impound))", COLOR_FROSTYRED, -309.1056, 2662.1003, 62.6773, 20.0, .testlos = 1, .worldid = 0, .interiorid = 0);

    CreateDynamicObject(3037, -308.69650, 2657.97632, 63.34679,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, -325.03149, 2660.52271, 63.46723,   0.00000, 0.00000, -51.48000);
    CreateDynamicObject(8673, -267.10834, 2659.67480, 63.56301,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, -277.12393, 2669.66064, 63.56300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -288.24921, 2669.69409, 63.56300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -299.35519, 2669.69409, 63.56300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -288.24921, 2669.69409, 60.61970,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -299.35519, 2669.69409, 60.63360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -303.05121, 2669.69604, 60.63360,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -287.77509, 2647.28003, 63.60900,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -303.05121, 2669.69604, 63.56300,   0.00000, 0.00000, 0.00000);

    // FC Sign
    CreateDynamicObject(16480, -215.80046, 957.65289, 18.12448,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(16482, -215.73155, 957.62683, 18.31502,   0.00000, 0.00000, 0.00000);

    // FC Main Street
    CreateDynamicObject(19463, -125.61590, 1163.10486, 19.58790,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -125.61590, 1172.72632, 19.58790,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -127.22910, 1181.96594, 19.58790,   0.00000, 0.00000, 20.00000);
    CreateDynamicObject(669, -129.45410, 1162.70593, 18.67969,   356.85840, 0.00000, -2.00713);
    CreateDynamicObject(669, -128.27066, 1174.34509, 18.67969,   356.85840, 0.00000, -2.00713);
    CreateDynamicObject(669, -128.41002, 1167.57019, 18.67969,   356.85840, 0.00000, -2.00713);
    CreateDynamicObject(1408, -157.70377, 1188.27881, 19.28000,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(1408, -152.18401, 1188.27881, 19.28000,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(1408, -146.64330, 1188.27881, 19.28000,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(19463, -159.49490, 1186.37415, 13.94000,   90.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -144.29340, 1186.37415, 13.94000,   90.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -152.02130, 1186.37415, 13.94000,   90.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, -148.85551, 1173.80054, 18.75000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(638, -136.91991, 1174.33191, 19.42000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(638, -138.83301, 1175.73218, 19.42000,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(638, -141.85451, 1175.73218, 19.42000,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(638, -149.36031, 1175.73218, 19.42000,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(638, -152.44220, 1175.73218, 19.42000,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(638, -153.74379, 1174.24683, 19.42000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, -139.36784, 1174.18652, 18.75000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, -142.61775, 1174.15625, 18.75000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, -151.88260, 1174.03101, 18.75000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -159.12730, 1173.17175, 20.48000,   0.00000, 0.00000, 80.00000);
    CreateDynamicObject(1412, -157.95441, 1158.48425, 20.02340,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1412, -163.24651, 1158.48425, 20.02340,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -132.49339, 1163.12024, 19.58790,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -131.47810, 1176.49475, 18.50000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1294, -155.69342, 1175.62048, 23.00310,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(1294, -134.87427, 1175.42249, 23.00310,   0.00000, 0.00000, -90.00000);
    CreateDynamicObject(982, -194.94960, 1172.76331, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(982, -194.94960, 1147.10596, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(984, -194.94960, 1127.90515, 19.44000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(984, -191.07240, 1127.90515, 19.44000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(982, -191.07240, 1172.76331, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(982, -191.07240, 1147.10596, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(982, -191.07240, 1060.99231, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(982, -194.91924, 1060.96631, 19.48000,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.43913, 1038.54565, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.49240, 1059.28687, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.31552, 1062.81848, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.10789, 1066.42065, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.38966, 1069.86597, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.08009, 1079.23608, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.21848, 1051.76575, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.25510, 1047.67371, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.37302, 1043.02649, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -192.90514, 1180.08533, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.51828, 1115.95386, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.77672, 1118.98804, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.39731, 1125.05225, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.38081, 1127.50342, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.47545, 1130.50562, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.57854, 1137.10010, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.20665, 1139.76221, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.10065, 1142.92468, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.33348, 1146.73669, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.29350, 1153.13647, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.07762, 1156.08228, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.18703, 1159.03259, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -193.28899, 1161.78198, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -192.78030, 1174.37634, 18.98320,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(870, -192.82088, 1177.10242, 18.98320,   0.00000, 0.00000, 0.00000);

    // FC Hospital Park
    CreateDynamicObject(970, -287.67548, 1073.33423, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -300.99786, 1088.37952, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -305.12415, 1073.35120, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -300.99890, 1073.37219, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -285.51508, 1086.35986, 19.24442,   0.00000, 0.00000, 90.42602);
    CreateDynamicObject(970, -285.54868, 1075.40210, 19.24442,   0.00000, 0.00000, 88.56775);
    CreateDynamicObject(970, -285.52179, 1077.48523, 19.24442,   0.00000, 0.00000, 89.91698);
    CreateDynamicObject(970, -285.51706, 1084.32520, 19.24442,   0.00000, 0.00000, 89.91698);
    CreateDynamicObject(970, -287.58621, 1088.42493, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -291.71097, 1088.43518, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -300.99786, 1088.37952, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -305.13522, 1088.38794, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -291.80051, 1073.32385, 19.24442,   0.00000, 0.00000, 360.00000);
    CreateDynamicObject(970, -307.24094, 1075.40283, 19.24442,   0.00000, 0.00000, 90.83311);
    CreateDynamicObject(970, -307.25891, 1077.63745, 19.24442,   0.00000, 0.00000, 89.91698);
    CreateDynamicObject(970, -307.23334, 1084.26331, 19.24442,   0.00000, 0.00000, 89.91698);
    CreateDynamicObject(970, -307.22345, 1086.30640, 19.24442,   0.00000, 0.00000, 89.91698);
    CreateDynamicObject(1280, -286.03030, 1085.22632, 19.14673,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1280, -285.98471, 1076.38110, 19.14673,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1280, -306.72119, 1077.04858, 19.14673,   0.00000, 0.00000, 180.21719);
    CreateDynamicObject(1280, -306.77585, 1085.39246, 19.14673,   0.00000, 0.00000, 180.21719);
    CreateDynamicObject(700, -316.44644, 1110.09778, 18.60958,   356.85840, 0.00000, 3.14159);
    CreateDynamicObject(700, -307.29123, 1135.47668, 18.60958,   356.85840, 0.00000, 3.14159);
    CreateDynamicObject(705, -284.44305, 1012.56598, 18.51467,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(705, -295.85876, 1079.54651, 18.72080,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(705, -282.64203, 1203.00183, 18.70061,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(705, 96.20636, 1206.99915, 17.99872,   0.00000, 0.00000, 0.00000);

    // 24/7
    CreateDynamicObject(6977, -246.15619, 1222.07813, 18.41328,   0.00000, 0.00000, 90.05865);
    CreateDynamicObject(1496, -247.66017, 1211.60083, 19.85161,   0.00000, 0.00000, 359.17142);

    // Government Debate Chamber (Tyler)
    new tmpobjid;
    tmpobjid = CreateDynamicObject(19380, 1596.729370, 2427.186523, -70.667716, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.299438, 2427.186523, -70.667716, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.299438, 2416.745605, -70.667716, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1596.709716, 2416.745605, -70.667716, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1601.624633, 2432.497070, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1592.045166, 2432.497070, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1592.045166, 2432.497070, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1611.095092, 2432.497070, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1611.095092, 2427.757568, -71.099082, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1611.095092, 2418.248291, -71.099082, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1610.939819, 2413.481933, -71.099082, 0.000000, 0.000000, 315.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1604.395507, 2411.568603, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1591.923828, 2427.757568, -71.099082, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1591.923828, 2418.276367, -71.099082, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1592.023437, 2413.446533, -71.099082, 0.000000, 0.000000, 405.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1594.905639, 2411.568603, -71.099082, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1611.069335, 2432.502685, -67.769584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1601.519531, 2432.502685, -67.769584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1591.959350, 2432.502685, -67.769584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1591.899291, 2427.782470, -67.769584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1591.899291, 2418.224365, -67.769584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1611.120239, 2418.224365, -67.769584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1611.120239, 2427.664550, -67.769584, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1610.993041, 2413.520996, -67.769584, 0.000000, 0.000000, 315.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1592.015014, 2413.423095, -67.769584, 0.000000, 0.000000, 405.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1598.709350, 2411.562011, -67.769584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1608.249267, 2411.552001, -67.769584, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1592.488403, 2431.923583, -71.841758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1610.508422, 2431.894531, -71.841758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1610.508422, 2421.943603, -68.071746, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1592.506835, 2421.943603, -68.121749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1610.508422, 2431.894531, -66.851760, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1592.487304, 2431.924560, -66.851760, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.299438, 2426.691162, -70.507713, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1596.809326, 2426.691162, -70.507713, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1596.809326, 2430.144531, -70.367706, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.399902, 2430.144531, -70.367706, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14383, "burg_1", "carpet4kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19440, 1601.635131, 2432.478759, -67.621757, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1600.767944, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1602.528564, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19440, 1596.823364, 2432.478759, -67.621757, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19440, 1606.934204, 2432.478759, -67.621757, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1606.048950, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1607.828857, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1597.717529, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1595.937377, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1599.149658, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1604.270874, 2433.189453, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1608.362182, 2433.181640, -65.971755, 0.000000, 90.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1604.902343, 2433.181640, -65.971755, 0.000000, 90.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1601.492797, 2433.181640, -65.971755, 0.000000, 90.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1598.033325, 2433.181640, -65.971755, 0.000000, 90.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1594.533813, 2433.181640, -65.971755, 0.000000, 90.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2429.711669, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2426.252197, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2422.822021, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2419.332519, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2415.952392, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1591.191772, 2412.472656, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1592.436279, 2412.020507, -65.971755, 0.000000, 90.000000, 315.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1595.636474, 2410.859375, -65.971755, 0.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1599.136596, 2410.859375, -65.971755, 0.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1602.556274, 2410.859375, -65.971755, 0.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1606.006225, 2410.859375, -65.971755, 0.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1609.435913, 2410.859375, -65.971755, 0.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1609.386352, 2410.908935, -65.971755, 0.000000, 90.000000, 405.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.832641, 2413.355468, -65.971755, 0.000000, 90.000000, 405.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2415.251708, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2418.661621, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2422.111572, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2425.542968, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2428.972412, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1611.822387, 2432.372558, -65.971755, 0.000000, 90.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1596.709716, 2416.745605, -65.797729, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.330200, 2416.745605, -65.797729, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1606.330200, 2427.216552, -65.797729, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, 1596.721313, 2427.216552, -65.797729, 0.000000, 90.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(1532, 1600.747680, 2411.658203, -70.581779, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "staddoors1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1606.241088, 2410.877929, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1596.729614, 2410.867919, -67.621749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2184, 1600.439697, 2421.945556, -70.421783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1605.265136, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1607.205322, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1609.155639, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1598.663330, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1596.713134, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1594.763305, 2418.950439, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1594.763305, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1596.693481, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1598.624267, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1605.285400, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1607.215942, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1609.156372, 2416.337890, -70.581771, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1604.344726, 2422.832519, -70.461753, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1606.295043, 2422.832519, -70.461769, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1608.235107, 2422.832519, -70.461769, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1597.784179, 2422.832519, -70.431770, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1595.853271, 2422.832519, -70.431770, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1593.913574, 2422.832519, -70.441780, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1593.933593, 2426.324462, -70.311782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1595.883544, 2426.324462, -70.311805, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1597.813232, 2426.324462, -70.311805, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1604.453491, 2426.324462, -70.311805, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1606.384155, 2426.324462, -70.311805, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1608.314086, 2426.324462, -70.311813, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1602.514282, 2426.324462, -70.311790, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, 1599.743164, 2426.324462, -70.311813, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2755, 1601.521240, 2422.749023, -65.921768, 90.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    tmpobjid = CreateDynamicObject(14439, 1602.013061, 2419.470214, -64.451820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "gz_vicdoor2", 0x00000000);
    tmpobjid = CreateDynamicObject(2196, 1600.815795, 2422.838867, -69.661766, 0.000000, 0.000000, 30.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(13649, 1601.532226, 2422.647216, -65.291824, 0.000000, 180.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "gun_ceiling2_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(11721, 1610.909179, 2416.709960, -69.941802, 0.000000, 0.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(11721, 1610.909179, 2428.252685, -69.691764, 0.000000, 0.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(11721, 1592.138427, 2416.709960, -69.941802, 0.000000, 0.000000, 450.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1604.744506, 2417.899414, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1606.655273, 2417.899414, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1608.686279, 2417.899414, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1608.686279, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1606.625122, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1604.724243, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1598.103271, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1596.262084, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1594.321411, 2415.177734, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1594.321411, 2417.838378, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1596.261962, 2417.968505, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1598.272949, 2417.968505, -70.161773, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1598.272949, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1596.452392, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1594.411987, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1604.932983, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1606.783813, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1608.775024, 2424.010986, -69.951782, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1608.775024, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1606.814819, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1604.854980, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1603.034667, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1600.304443, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1598.283569, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1596.272827, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(1671, 1594.372314, 2427.513183, -69.821800, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "ws_whitestripe", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1604.899047, 2431.977294, -69.681785, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1603.718750, 2431.977294, -69.681785, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1599.607788, 2431.977294, -69.681785, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1598.907348, 2431.977294, -69.681785, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1595.355590, 2412.084228, -69.991775, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1604.817749, 2412.084228, -69.991775, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(2639, 1606.887573, 2412.084228, -69.991775, 0.000000, 0.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(16779, 1601.545166, 2422.671875, -65.901809, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19610, 1601.470703, 2422.414550, -69.580825, 45.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2894, 1602.130249, 2422.283447, -69.641784, 0.000000, 0.000000, 195.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2614, 1601.513793, 2411.728759, -66.971778, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19174, 1592.124267, 2417.545898, -67.711769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19173, 1592.031616, 2426.543212, -67.771827, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(3462, 1598.755859, 2412.142822, -69.101821, 0.000000, 0.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(11710, 1601.492675, 2411.645263, -67.951820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(11736, 1611.011352, 2417.619384, -69.071800, 90.000000, 90.000000, 360.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2690, 1603.003417, 2411.793701, -69.941780, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19829, 1602.628540, 2411.665283, -69.081787, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19814, 1599.805175, 2432.374023, -70.051788, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19814, 1594.084960, 2432.374023, -70.051788, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19814, 1592.035400, 2417.634033, -70.311782, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(19814, 1597.866577, 2411.649902, -70.311782, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2824, 1603.033935, 2426.223144, -69.511802, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2813, 1595.316040, 2418.911376, -69.781799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2813, 1605.506835, 2416.291015, -69.781799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(14604, 1609.098632, 2432.075439, -69.321769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2616, 1610.971557, 2419.224609, -68.451805, 0.000000, 0.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2616, 1610.932006, 2425.204345, -68.451805, 0.000000, 0.000000, 270.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(2833, 1602.000244, 2416.623779, -70.581779, 0.000000, 0.000000, 90.000000, -1, -1, -1, 350.00, 350.00); 
    tmpobjid = CreateDynamicObject(1714, 1601.475708, 2423.412353, -70.431777, 0.000000, 0.000000, 0.000000, -1, -1, -1, 350.00, 350.00);

    // Town Hall Interior
    tmpobjid = CreateDynamicObject(18762, 1356.155395, 1578.472167, -8.536698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.142822, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1337.733642, 1578.592407, -9.029707, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1347.214111, 1578.592407, -9.029706, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1356.763793, 1578.592407, -9.169709, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1337.733642, 1578.592407, -5.659701, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1347.193481, 1578.592407, -5.659701, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1356.753051, 1578.592407, -5.669702, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.362060, 1580.223876, -11.043776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1337.571533, 1581.894287, -12.853778, 0.000015, 0.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.522338, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.942382, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1356.155395, 1578.472167, -13.526699, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1331.364257, 1578.472167, -13.506698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1331.364257, 1578.472167, -8.586700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.282958, 1580.233276, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.802001, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.682373, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.472167, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.532226, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.702148, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.702148, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.871826, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.971679, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.091308, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.101074, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.181274, 1580.223876, -6.833768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.181274, 1580.223876, -10.873771, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.730224, 1580.223876, -9.313776, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.730224, 1580.223876, -8.493776, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1354.870239, 1580.223876, -8.353773, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1354.870239, 1580.223876, -9.353777, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.650024, 1580.223876, -9.353777, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.650024, 1580.223876, -8.373778, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1345.489868, 1580.223876, -8.373778, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1345.489868, 1580.223876, -9.243782, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.399047, 1580.223876, -9.243782, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.399047, 1580.223876, -8.493780, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.228027, 1580.223876, -8.493780, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.228027, 1580.223876, -9.243782, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.127685, 1580.223876, -9.243782, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.127685, 1580.223876, -8.473781, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.847656, 1580.203857, -8.363780, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.837646, 1580.203857, -9.353786, 90.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1327.961181, 1581.894287, -12.853778, 0.000015, 0.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.181884, 1580.223876, -11.043776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1328.173461, 1578.592407, -5.659701, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1328.173461, 1578.592407, -9.139703, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.712280, 1580.223876, -11.043774, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.472167, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.542968, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1341.863403, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.744140, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.104003, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1348.004272, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1352.315063, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.185668, 1580.223876, -9.573768, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.882202, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.062011, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.232055, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.352050, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1347.171630, 1581.894287, -12.873778, 0.000015, 0.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1356.790893, 1581.894287, -12.883778, 0.000015, 0.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(1500, 1344.937988, 1581.789794, -14.663767, 0.000000, -0.000015, 179.999908, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(1500, 1346.587646, 1581.809814, -14.663767, 0.000000, -0.000015, 179.999908, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8869, "buildingsitevge", "telepole2128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.319213, 1583.535156, -13.593775, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.972167, 1583.545166, -12.073777, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1346.649414, 1583.535156, -13.583775, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.989135, 1583.535156, -13.593775, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.972167, 1583.385864, -14.623785, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1348.222290, 1581.884887, -13.103777, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1348.230346, 1583.486816, -11.393777, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.359619, 1583.535156, -12.903775, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1348.230346, 1583.518188, -12.083777, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1348.230346, 1583.518188, -14.553779, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.359619, 1583.535156, -16.013769, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.079223, 1583.535156, -12.903775, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.079223, 1583.535156, -16.063766, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1341.640869, 1581.884887, -13.103777, 0.000007, 0.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1341.648925, 1583.486816, -11.393777, 0.000007, 90.000000, 89.999977, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.778198, 1583.535156, -12.903775, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1341.648925, 1583.518188, -12.083777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1341.648925, 1583.518188, -14.553779, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.778198, 1583.535156, -16.013769, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.497802, 1583.535156, -12.903775, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.497802, 1583.535156, -16.063766, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.041748, 1580.223876, -11.043776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.951782, 1580.223876, -11.043776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.181884, 1580.223876, -10.953774, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.041748, 1580.223876, -10.953774, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.951782, 1580.223876, -10.953774, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.552734, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.762207, 1580.223876, -11.043775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.552734, 1580.223876, -11.003775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.763549, 1580.223876, -11.003775, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1334.417236, 1581.804321, -12.823074, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1353.547607, 1581.804321, -12.823074, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1336.107543, 1583.535156, -12.713771, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1336.107543, 1583.535156, -15.793771, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.167236, 1583.415039, -15.793771, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.167236, 1583.415039, -12.623774, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1333.656860, 1583.415039, -12.623774, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1333.656860, 1583.415039, -15.653772, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.736694, 1583.415039, -15.653772, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.736694, 1583.415039, -12.433774, 89.999992, 270.000000, -89.999969, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1335.268066, 1583.408203, -12.083777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1333.657836, 1583.408203, -12.083777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1333.597778, 1583.408203, -12.083777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1333.597778, 1583.408203, -14.483776, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1335.177856, 1583.408203, -14.483776, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1335.267944, 1583.408203, -14.483776, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1352.747558, 1583.408203, -14.483777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1354.347656, 1583.408203, -14.483777, 0.000022, 90.000000, 89.999931, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.849365, 1583.535156, -12.663763, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.849365, 1583.535156, -15.813766, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1352.759887, 1583.435058, -15.813766, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1352.759887, 1583.435058, -12.623768, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1354.330200, 1583.435058, -12.623768, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1354.330200, 1583.435058, -15.633765, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1355.229736, 1583.435058, -15.633765, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1355.229736, 1583.435058, -12.443765, 89.999992, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.558837, 1583.435058, -11.843766, 180.000000, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.488769, 1583.435058, -11.843766, 180.000000, 270.000000, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.951782, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.151733, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.281982, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.491821, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.691650, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.842163, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.051757, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.241577, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.392089, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.552124, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.743041, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.932983, 1580.223876, -6.193776, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1325.102905, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1328.603271, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1332.013061, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1335.383056, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1338.693115, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1342.093261, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1345.513183, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1348.963012, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1352.363159, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1355.823364, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1359.293457, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1362.753295, 1577.721801, -6.027727, 720.000000, 270.000000, 900.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.782836, 1575.202148, -6.027727, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.152832, 1575.172363, -6.027736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1327.958740, 1580.167480, -14.669319, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1337.558471, 1580.167480, -14.669318, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1347.158813, 1580.167480, -14.669318, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.748901, 1580.167480, -14.669318, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1327.958740, 1576.667602, -14.669319, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1337.588745, 1576.667602, -14.669319, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1347.198364, 1576.667602, -14.669319, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1576.667602, -14.669319, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1327.963012, 1573.188964, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1337.552856, 1573.188964, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1347.142578, 1573.188964, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1329.782958, 1575.178710, -6.057892, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1339.412719, 1575.178710, -6.057892, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1349.022705, 1575.178710, -6.057892, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1358.612548, 1575.178710, -6.057892, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(14407, 1353.767089, 1573.366333, -17.800491, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1573.167358, -16.129320, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1576.657226, -16.129320, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1575.026855, -16.409330, 180.000000, 180.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 1320.198364, 1582.293823, -13.629467, 90.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 1367.767944, 1582.293823, -13.629467, 90.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1328.599243, 1564.434814, -8.536698, 0.000007, -0.000007, 179.999832, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.611816, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1347.020996, 1564.314575, -9.029707, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1337.540527, 1564.314575, -9.029706, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1327.990844, 1564.314575, -9.169709, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1347.020996, 1564.314575, -5.659701, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1337.561157, 1564.314575, -5.659701, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1328.001586, 1564.314575, -5.669702, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.392578, 1562.683105, -11.043776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1347.183105, 1561.012695, -12.853778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.232299, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.812255, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1328.599243, 1564.434814, -13.526699, 0.000007, -0.000007, 179.999832, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1353.390380, 1564.434814, -13.506698, 0.000007, -0.000007, 179.999832, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1353.390380, 1564.434814, -8.586700, 0.000007, -0.000007, 179.999832, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.471679, 1562.673706, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.952636, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.072265, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.282470, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.222412, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.052490, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.052490, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.882812, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.782958, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.663330, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.653564, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.573364, 1562.683105, -6.833768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.573364, 1562.683105, -10.873771, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.024414, 1562.683105, -9.313776, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.024414, 1562.683105, -8.493776, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1329.884399, 1562.683105, -8.353773, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1329.884399, 1562.683105, -9.353777, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.104614, 1562.683105, -9.353777, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.104614, 1562.683105, -8.373778, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.264770, 1562.683105, -8.373778, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.264770, 1562.683105, -9.243782, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.355590, 1562.683105, -9.243782, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.355590, 1562.683105, -8.493780, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.526611, 1562.683105, -8.493780, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.526611, 1562.683105, -9.243782, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1345.626953, 1562.683105, -9.243782, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1345.626953, 1562.683105, -8.473781, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.906982, 1562.703125, -8.363780, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.916992, 1562.703125, -9.353786, 89.999992, 424.471191, -64.471252, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1356.793457, 1561.012695, -12.853778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.572753, 1562.683105, -11.043776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1356.581176, 1564.314575, -5.659701, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, 1356.581176, 1564.314575, -9.139703, -0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1344.042358, 1562.683105, -11.043774, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.282470, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.211669, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.891235, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.010498, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.650634, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1336.750366, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.439575, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.568969, 1562.683105, -9.573768, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.872436, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.692626, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.522583, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.402587, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1337.583007, 1561.012695, -12.873778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1327.963745, 1561.012695, -12.883778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(1500, 1339.816650, 1561.117187, -14.663767, -0.000007, -0.000007, -0.000083, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(1500, 1338.166992, 1561.097167, -14.663767, -0.000007, -0.000007, -0.000083, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8869, "buildingsitevge", "telepole2128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1341.435424, 1559.371826, -13.593775, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.782470, 1559.361816, -12.073777, 0.000007, 89.999992, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1338.105224, 1559.371826, -13.583775, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.765502, 1559.371826, -13.593775, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1339.782470, 1559.521118, -14.623785, 0.000007, 89.999992, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1336.532348, 1561.022094, -13.103777, -0.000007, -0.000007, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1336.524291, 1559.420166, -11.393777, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.395019, 1559.371826, -12.903775, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1336.524291, 1559.388793, -12.083777, 0.000007, 89.999992, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1336.524291, 1559.388793, -14.553779, 0.000007, 89.999992, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.395019, 1559.371826, -16.013769, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.675415, 1559.371826, -12.903775, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1335.675415, 1559.371826, -16.063766, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1343.113769, 1561.022094, -13.103777, 0.000000, -0.000007, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "newindow4", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1343.105712, 1559.420166, -11.393777, 0.000000, 89.999992, -90.000015, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.976440, 1559.371826, -12.903775, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1343.105712, 1559.388793, -12.083777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1343.105712, 1559.388793, -14.553779, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.976440, 1559.371826, -16.013769, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.256835, 1559.371826, -12.903775, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1342.256835, 1559.371826, -16.063766, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.712890, 1562.683105, -11.043776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.802856, 1562.683105, -11.043776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.572753, 1562.683105, -10.953774, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.712890, 1562.683105, -10.953774, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.802856, 1562.683105, -10.953774, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.201904, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.992431, 1562.683105, -11.043775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.201904, 1562.683105, -11.003775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.991088, 1562.683105, -11.003775, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1350.337402, 1561.102661, -12.823074, -0.000007, -0.000007, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1331.207031, 1561.102661, -12.823074, -0.000007, -0.000007, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14853, "gen_pol_vegas", "pol_win_kb", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1348.647094, 1559.371826, -12.713771, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1348.647094, 1559.371826, -15.793771, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.587402, 1559.491943, -15.793771, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1349.587402, 1559.491943, -12.623774, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.097778, 1559.491943, -12.623774, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1351.097778, 1559.491943, -15.653772, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1352.017944, 1559.491943, -15.653772, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1352.017944, 1559.491943, -12.433774, 89.999992, 424.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1349.486572, 1559.498779, -12.083777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1351.096801, 1559.498779, -12.083777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1351.156860, 1559.498779, -12.083777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1351.156860, 1559.498779, -14.483776, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1349.576782, 1559.498779, -14.483776, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1349.486694, 1559.498779, -14.483776, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1332.007080, 1559.498779, -14.483777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1330.406982, 1559.498779, -14.483777, 0.000015, 89.999992, -90.000061, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.905273, 1559.371826, -12.663763, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1332.905273, 1559.371826, -15.813766, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.994750, 1559.471923, -15.813766, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.994750, 1559.471923, -12.623768, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1330.424438, 1559.471923, -12.623768, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1330.424438, 1559.471923, -15.633765, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1329.524902, 1559.471923, -15.633765, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1329.524902, 1559.471923, -12.443765, 89.999992, 424.471191, -64.471237, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.195800, 1559.471923, -11.843766, -0.000015, 450.000000, -89.999923, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.265869, 1559.471923, -11.843766, -0.000015, 450.000000, -89.999923, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1359.802856, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1356.602905, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1353.472656, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1350.262817, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1347.062988, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1343.912475, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1340.702880, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1337.513061, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1334.362548, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1331.202514, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1328.011596, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1324.821655, 1562.683105, -6.193776, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1359.651733, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1356.151367, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1352.741577, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1349.371582, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1346.061523, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1342.661376, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1339.241455, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1335.791625, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1332.391479, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1328.931274, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1325.461181, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1322.001342, 1565.185180, -6.027727, -0.000007, 270.000000, 0.000007, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1323.971801, 1567.704833, -6.027727, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1567.704833, -6.027736, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.795898, 1562.739501, -14.669319, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1347.196166, 1562.739501, -14.669318, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1337.595825, 1562.739501, -14.669318, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1328.005737, 1562.739501, -14.669318, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.795898, 1566.239379, -14.669319, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1347.165893, 1566.239379, -14.669319, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1337.556274, 1566.239379, -14.669319, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1327.966430, 1566.239379, -14.669319, 0.000015, 270.000000, 89.999893, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1567.936035, -16.409330, 180.000000, 180.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.152832, 1571.672241, -6.027736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.152832, 1568.172485, -6.027736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1354.971679, 1567.728271, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1345.341918, 1567.728271, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1335.731933, 1567.728271, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1326.142089, 1567.728271, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1356.788208, 1569.667480, -16.129320, 180.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "wood02S", 0x00000000);
    tmpobjid = CreateDynamicObject(14407, 1353.767089, 1569.875854, -17.800491, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1347.142578, 1569.708984, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1337.502563, 1569.708984, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 1364.556274, 1560.613159, -13.629467, 89.999992, 154.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 1316.986694, 1560.613159, -13.629467, 89.999992, 154.471221, -64.471221, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1327.953125, 1569.708984, -14.667894, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 2127, "cj_kitchen", "marble2", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.152832, 1566.992553, -6.027736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1571.194702, -6.027736, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1574.644653, -6.067737, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1576.934814, -6.027736, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1354.971679, 1571.178100, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1345.371459, 1571.178100, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1335.801147, 1571.178100, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1326.261352, 1571.178100, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1326.261352, 1573.659790, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1335.541625, 1573.659790, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1344.881591, 1573.659790, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1354.532348, 1573.659790, -6.057892, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 1364.041625, 1573.659790, -6.017893, -0.000007, 89.999992, -89.999984, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "lightblue", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1577.294555, -12.883778, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1567.704833, -12.883777, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1577.294555, -9.393789, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1567.704833, -16.373779, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1577.234252, -16.373779, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1577.234252, -5.973781, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1567.704833, -9.403776, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1567.704833, -5.973776, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1361.230957, 1558.104858, -12.883777, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1577.785156, -6.067737, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1571.355468, -6.067737, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1567.995483, -6.067737, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1360.601806, 1564.665039, -6.067737, 0.000015, 270.000000, 89.999916, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.162841, 1573.912231, -6.067736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.162841, 1570.432495, -6.067736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1324.162841, 1566.972534, -6.067736, 720.000000, 270.000000, 990.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19394, 1323.592041, 1571.404541, -12.940052, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1561.874755, -12.933777, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19411, 1323.599365, 1574.582763, -12.940191, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19411, 1323.588989, 1568.252929, -12.940191, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1568.284423, -9.453786, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1558.704589, -9.453786, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1577.864257, -9.453789, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1580.964233, -12.943792, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1573.794067, -6.013792, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1323.590576, 1564.224121, -6.013790, 0.000015, 0.000000, 179.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19466, 1323.608032, 1574.535888, -12.656896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(19466, 1323.608032, 1568.225219, -12.656896, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(14597, 1310.336791, 1571.199218, -12.561954, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 3, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1316.793579, 1561.012817, -12.883778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1310.913452, 1561.013061, -9.393779, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1316.793579, 1581.912353, -12.883778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1310.913452, 1561.013061, -12.893778, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1316.793579, 1581.912353, -9.453780, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1307.243286, 1581.912353, -9.453780, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(1499, 1323.676391, 1570.669067, -14.581956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(18763, 1338.794067, 1571.480346, -12.171959, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(18763, 1338.794067, 1571.480346, -7.581960, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1339.648193, 1571.457275, -9.943777, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1338.077880, 1571.457275, -9.943777, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1337.927734, 1571.457275, -9.943777, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1337.927734, 1571.457275, -6.193772, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1339.698486, 1571.457275, -6.193772, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(19426, 1339.197998, 1571.457275, -6.193772, 0.000015, 90.000000, 89.999954, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
    tmpobjid = CreateDynamicObject(18070, 1343.675659, 1571.451538, -14.121958, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14847, "mp_policesf", "mp_cop_marble", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1340.260498, 1571.529785, -12.011949, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "RECEPTION", 90, "Ariel", 40, 0, 0xFFFF0000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19453, 1316.793579, 1561.012817, -9.393776, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, 1307.243286, 1581.912353, -12.873782, 0.000007, -0.000007, -90.000030, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 8, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 9, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 10, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 12, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 13, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 14, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 15, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 1295.228881, 1582.293823, -13.629467, 90.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(2165, 1318.957031, 1578.579223, -14.564146, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 3, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    tmpobjid = CreateDynamicObject(1817, 1315.210327, 1577.001464, -14.554141, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "black64", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "black64", 0x00000000);
    tmpobjid = CreateDynamicObject(2162, 1314.207641, 1579.139160, -13.116815, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    tmpobjid = CreateDynamicObject(1742, 1321.685058, 1576.300659, -14.554141, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 2, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(11691, 1311.374877, 1564.343750, -14.546813, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "pavegrey128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "pavegrey128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14623, "mafcasmain", "marble_wall", 0x00000000);
    tmpobjid = CreateDynamicObject(11691, 1308.464477, 1564.343750, -14.546813, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 16640, "a51", "pavegrey128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "pavegrey128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14623, "mafcasmain", "marble_wall", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1311.945434, 1566.132934, -14.554141, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1310.724609, 1566.132934, -14.554141, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1309.264404, 1566.132934, -14.554141, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1307.833862, 1566.132934, -14.554141, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1307.833862, 1562.491699, -14.554141, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1309.244506, 1562.491699, -14.554141, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1310.515014, 1562.491699, -14.554141, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1312.005249, 1562.491699, -14.554141, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(2207, 1302.161987, 1570.357055, -14.554141, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14623, "mafcasmain", "marble_wall2", 0x00000000);
    tmpobjid = CreateDynamicObject(1715, 1303.712890, 1571.273681, -14.554141, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8420, "carpark3_lvs", "greyground12802", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18081, "cj_barb", "ab_leather_strips", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3881, "apsecurity_sfxrf", "leather_seat_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 1323.689331, 1571.529785, -8.441939, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "TOWN HALL", 90, "Engravers MT", 50, 1, 0xFFFF0000, 0x00000000, 1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(14902, 1334.998291, 1563.651123, -10.769712, 0.000000, 0.000007, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(14902, 1349.756347, 1579.255859, -10.769712, 0.000007, -0.000000, 179.999832, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19825, 1340.323852, 1571.498046, -10.901955, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(638, 1340.643920, 1571.436401, -13.901953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1557, 1361.150146, 1569.870483, -16.043382, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1557, 1361.150146, 1572.880737, -16.043382, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(640, 1360.633544, 1564.481201, -13.901380, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(640, 1360.633544, 1578.422363, -13.901380, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3810, 1360.399902, 1573.795776, -13.558034, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3810, 1360.399902, 1569.064819, -13.558034, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2836, 1361.040527, 1570.865112, -16.041965, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1354.028930, 1567.961303, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1358.109497, 1567.961303, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1362.228881, 1567.961303, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1354.048339, 1574.964111, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1358.158691, 1574.964111, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(970, 1362.269409, 1574.964111, -14.071950, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(16378, 1308.614013, 1578.552246, -13.786813, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1714, 1318.434204, 1579.801635, -14.546813, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2688, 1314.185668, 1578.460327, -13.404137, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19172, 1317.811523, 1581.808837, -12.124142, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2271, 1321.094604, 1577.943603, -12.906808, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2262, 1321.069580, 1580.378540, -12.856812, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1582, 1314.675781, 1577.277954, -14.034139, 0.000000, 0.000000, -25.499994, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19805, 1313.800537, 1564.390625, -12.595563, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19174, 1310.138549, 1561.121582, -11.974136, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19893, 1309.287353, 1564.796752, -13.754139, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(11724, 1297.480468, 1571.135864, -14.016812, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19632, 1297.529663, 1571.096923, -14.546813, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3017, 1311.120605, 1564.710205, -13.754131, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2332, 1297.007080, 1571.102294, -12.714144, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1753, 1297.744018, 1573.619262, -14.554141, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1753, 1299.763305, 1568.827880, -14.554141, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2835, 1298.598388, 1570.725708, -14.556816, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1791, 1296.938110, 1571.214477, -12.344141, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1886, 1297.987792, 1568.836303, -10.420343, 25.000000, 0.000000, 125.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2258, 1297.255859, 1569.467529, -12.296805, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2612, 1302.248535, 1574.062255, -12.654140, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1714, 1300.581054, 1571.276489, -14.554141, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2614, 1361.010864, 1571.417724, -10.031951, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2257, 1340.331420, 1571.466552, -8.221951, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(16779, 1348.732788, 1571.300781, -6.083371, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2011, 1345.701538, 1575.352294, -14.581956, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2011, 1345.701538, 1567.502319, -14.581956, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(948, 1355.298217, 1578.429565, -14.581956, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(948, 1352.456787, 1564.488159, -14.581956, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2894, 1345.589111, 1571.274902, -13.611951, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1723, 1324.217773, 1577.425659, -14.581956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1723, 1324.217773, 1563.473022, -14.581956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1723, 1347.449096, 1561.671630, -14.581956, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1723, 1337.278930, 1581.253173, -14.581956, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1724, 1349.948486, 1581.213745, -14.583380, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1724, 1334.887817, 1561.652099, -14.583380, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2001, 1340.364501, 1581.192016, -14.583381, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2254, 1338.211791, 1581.677001, -12.393378, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1724, 1336.718872, 1572.822631, -14.583380, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1724, 1336.718872, 1571.291625, -14.583380, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2256, 1326.392211, 1561.135375, -12.191954, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2269, 1346.520751, 1561.677490, -12.823375, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2614, 1323.720825, 1571.437744, -10.371955, 0.000000, 0.000000, 450.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1811, 1343.661132, 1571.431762, -13.981950, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(19807, 1345.267700, 1570.460083, -13.581948, 0.000000, 0.000000, 225.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(1776, 1324.248535, 1580.760620, -13.513377, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3761, 1315.106445, 1564.507690, -12.586805, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3761, 1315.106445, 1564.507690, -12.586805, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(3761, 1320.767944, 1564.507690, -12.586805, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2608, 1318.067626, 1561.318359, -12.256814, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2162, 1302.604248, 1568.317749, -14.534149, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(2167, 1300.847412, 1568.266235, -14.546813, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(11738, 1302.447387, 1568.598999, -14.006811, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00); 
    tmpobjid = CreateDynamicObject(16779, 1330.822875, 1571.300781, -6.083371, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);

    // Flat Interior (Tyler)
    tmpobjid = CreateDynamicObject(14534, 1442.360107, 1539.966918, -22.739709, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(1498, 1438.073974, 1540.439453, -22.095954, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "flatdoor01_law", 0x00000000);
    tmpobjid = CreateDynamicObject(19361, 1437.995727, 1541.751708, -20.845943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

    // Mental Health Unit
    tmpobjid = CreateDynamicObject(13681, 667.509277, 1710.331909, 10.885499, 0.000000, 0.000000, 221.678085, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 3820, "boxhses_sfsx", "ws_mixedbrick", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 8391, "ballys01", "vgncorpdoor1_512", 0x00000000);
    tmpobjid = CreateDynamicObject(995, 651.486877, 1709.722045, 11.810301, 90.000000, 0.000000, 41.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFFCCFFFF);
    SetDynamicObjectMaterial(tmpobjid, 9, -1, "none", "none", 0xFF000033);
    tmpobjid = CreateDynamicObject(995, 655.398437, 1712.099121, 11.740299, 90.000000, 0.000000, -49.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFFCCFFFF);
    SetDynamicObjectMaterial(tmpobjid, 9, -1, "none", "none", 0xFF000033);
    tmpobjid = CreateDynamicObject(995, 651.370971, 1708.485595, 11.720307, 90.000000, 0.000000, -49.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFFCCFFFF);
    SetDynamicObjectMaterial(tmpobjid, 9, -1, "none", "none", 0xFF000033);
    tmpobjid = CreateDynamicObject(19368, 677.495300, 1706.397338, 6.090178, 0.000000, 89.799995, 40.699996, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 680.083923, 1708.663940, 6.102187, 0.000000, 89.799995, 40.699996, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 682.661437, 1710.880004, 6.114054, 0.000000, 89.799995, 40.999992, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, 684.020019, 1712.060058, 6.120334, 0.000000, 89.799995, 40.999992, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 651.607177, 1709.048461, 7.892190, 0.000000, 0.000000, 131.099960, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterialText(tmpobjid, 0, "House", 30, "Engravers MT", 20, 1, 0xFFFF0000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19360, 652.156250, 1709.509155, 7.872184, 0.000000, 0.000000, 130.699935, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterialText(tmpobjid, 0, "Hilmore", 30, "Engravers MT", 20, 1, 0xFFFF0000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(18234, 644.386901, 1691.353759, 5.712187, 0.000000, 0.000000, 221.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(18234, 633.345581, 1694.911132, 5.712187, 0.000000, 0.000000, 851.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, 640.768005, 1701.585693, 8.562186, 0.000000, 0.000000, 220.699935, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 1349, "cj_dyn_prop", "CJ_AIRPLOGO", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "WARD B1", 50, "Engravers MT", 15, 1, 0xFFFF0000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19460, 631.075256, 1685.199462, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 633.668151, 1687.534912, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 637.833374, 1687.864868, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 640.188171, 1690.061035, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 637.629150, 1678.170898, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 644.928649, 1684.978393, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 642.376220, 1682.598144, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, 639.831237, 1680.225097, 5.952187, 0.000000, 90.000000, 43.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(984, 633.421203, 1689.728393, 10.092194, 0.000000, 0.000000, 130.499969, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(1280, 640.728820, 1684.632812, 6.388124, 0.000000, 0.000000, 41.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(1280, 637.822937, 1682.107666, 6.388124, 0.000000, 0.000000, 221.000000, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(2244, 641.690185, 1683.371093, 6.288125, 0.000000, 0.000000, 40.500022, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 3, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
    tmpobjid = CreateDynamicObject(19174, 654.778442, 1711.830810, 7.989529, 0.000000, 0.000000, 41.099994, -1, -1, -1, 315.00, 315.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 3899, "hospital2", "hospitalboard_128a", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(641, 677.380676, 1705.693115, 3.902187, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(641, 680.610900, 1707.844360, 3.692187, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(641, 685.090881, 1711.825195, 3.692187, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(629, 665.412109, 1719.163696, 5.999528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(630, 673.019226, 1726.686279, 7.242191, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(652, 630.683654, 1735.183593, 2.996954, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(652, 666.264160, 1759.234130, 3.386953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 635.264526, 1678.139892, 6.612188, 0.000000, 0.000000, 43.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 635.264526, 1678.139892, 7.882186, 0.000000, 0.000000, 43.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 627.728637, 1686.422485, 6.612188, 0.000000, 0.000000, 41.600013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 627.728637, 1686.422485, 7.852191, 0.000000, 0.000000, 41.600013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 627.728637, 1686.422485, 9.122187, 0.000000, 0.000000, 41.600013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 635.264526, 1678.139892, 9.122183, 0.000000, 0.000000, 43.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 627.728637, 1686.422485, 10.372188, 0.000000, 0.000000, 41.600013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 635.264526, 1678.139892, 10.382183, 0.000000, 0.000000, 43.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 644.317565, 1677.832885, 6.612188, 0.000000, 0.000000, 133.100006, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 644.317565, 1677.832885, 7.882189, 0.000000, 0.000000, 133.100006, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 644.317565, 1677.832885, 9.112195, 0.000000, 0.000000, 133.100006, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 644.317565, 1677.832885, 10.352198, 0.000000, 0.000000, 133.100006, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 643.799255, 1686.294433, 10.172180, 0.000000, 0.000000, 41.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(984, 641.892761, 1688.479492, 10.172180, 0.000000, 0.000000, 41.100013, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(738, 639.591247, 1675.224365, 6.128124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(738, 632.920715, 1688.114379, 6.128124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(640, 643.926757, 1678.061523, 6.578127, 0.000000, 0.000000, 131.800003, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(2244, 639.541564, 1685.795654, 6.288125, 0.000000, 0.000000, 45.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(2244, 636.797485, 1683.320312, 6.288125, 0.000000, 0.000000, 45.000000, -1, -1, -1, 315.00, 315.00);
    tmpobjid = CreateDynamicObject(2244, 638.838745, 1680.936035, 6.288125, 0.000000, 0.000000, 40.500022, -1, -1, -1, 315.00, 315.00);

    // Hanger Interior
    CreateDynamicObject(3816, 317.13840, 389.21436, 999.24182,   0.00000, 0.00000, 179.75711);
    CreateDynamicObject(3816, 317.23679, 444.68689, 999.24182,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19533, 280.23074, 403.75027, 990.73688,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19534, 317.88699, 403.85629, 990.74872,   0.00000, 0.00000, 0.91800);
    CreateDynamicObject(19533, 318.50211, 365.45258, 990.81689,   -0.16000, 0.00000, 0.91800);
    CreateDynamicObject(19533, 317.26959, 442.28430, 990.73688,   0.00000, 0.00000, 0.91800);
    CreateDynamicObject(19533, 355.30829, 403.97623, 990.73688,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19503, 300.29559, 376.89120, 993.59583,   0.00000, 0.00000, 90.37167);
    CreateDynamicObject(19504, 300.29800, 376.88910, 993.61060,   0.00000, 0.00000, 90.37400);
    CreateDynamicObject(1491, 292.32529, 386.77457, 991.44611,   0.00000, 0.00000, 89.96090);
    CreateDynamicObject(1897, 302.21640, 375.56320, 993.01227,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1897, 302.21640, 375.56320, 992.38892,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1897, 302.25641, 377.32791, 993.30219,   0.00000, 0.00000, 169.68919);
    CreateDynamicObject(1897, 302.25641, 377.32791, 992.38892,   0.00000, 0.00000, 169.68919);
    CreateDynamicObject(1649, 292.33524, 377.36624, 992.92480,   0.00000, 0.00000, 270.63260);
    CreateDynamicObject(1649, 325.91302, 377.11127, 994.63525,   0.00000, 0.00000, 270.95523);
    CreateDynamicObject(1649, 309.47409, 366.46115, 992.92480,   0.00000, 0.00000, 90.35640);
    CreateDynamicObject(1649, 292.38400, 368.34839, 992.92480,   0.00000, 0.00000, 271.92593);
    CreateDynamicObject(3279, 327.29630, 394.55203, 982.00366,   0.00000, 0.00000, 89.82578);
    CreateDynamicObject(1649, 299.96799, 363.93497, 992.92480,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1649, 306.84485, 363.99603, 992.92480,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1491, 302.24030, 375.68021, 991.33270,   0.00000, 0.00000, 89.96090);
    CreateDynamicObject(1491, 302.06161, 380.90619, 991.33270,   0.00000, 0.00000, 90.78947);
    CreateDynamicObject(19491, 331.95679, 377.88708, 995.58392,   0.00000, 0.00000, 0.83470);
    CreateDynamicObject(19492, 331.95599, 377.86292, 995.58228,   0.00000, 0.00000, 0.83470);
    CreateDynamicObject(1649, 309.49084, 370.37454, 992.92480,   0.00000, 0.00000, 90.65312);
    CreateDynamicObject(1649, 338.35999, 379.37711, 991.79749,   0.00000, 0.00000, 90.30264);
    CreateDynamicObject(1649, 325.88791, 380.52756, 994.63525,   0.00000, 0.00000, 270.95523);
    CreateDynamicObject(1649, 325.91302, 377.11127, 991.39148,   0.00000, 0.00000, 270.95523);
    CreateDynamicObject(1649, 338.39453, 377.11566, 995.06055,   0.00000, 0.00000, 90.51051);
    CreateDynamicObject(1649, 338.35629, 380.34274, 991.79749,   0.00000, 0.00000, 90.51051);
    CreateDynamicObject(1649, 338.35629, 380.34274, 994.85956,   0.00000, 0.00000, 90.51051);
    CreateDynamicObject(2049, 302.16284, 385.88327, 993.17432,   0.00000, 0.00000, 90.59476);
    CreateDynamicObject(1586, 302.99011, 364.37112, 991.46289,   0.00000, 0.00000, 181.09109);
    CreateDynamicObject(2290, 307.98782, 367.29422, 991.46301,   0.00000, 0.00000, 270.99014);
    CreateDynamicObject(2290, 307.93686, 371.40054, 991.46301,   0.00000, 0.00000, 270.99014);
    CreateDynamicObject(1433, 302.95581, 365.32330, 991.67090,   0.00000, 0.00000, 0.10721);
    CreateDynamicObject(1786, 303.06613, 364.95074, 992.16949,   0.00000, 0.00000, 180.15669);
    CreateDynamicObject(1586, 308.73007, 370.57855, 991.46289,   0.00000, 0.00000, 270.25116);
    CreateDynamicObject(11449, 300.10672, 434.73495, 993.27277,   0.00000, 0.00000, 90.73267);
    CreateDynamicObject(17522, 332.12067, 462.60126, 992.85223,   0.00000, 0.00000, 91.10793);
    CreateDynamicObject(12951, 330.90884, 448.28745, 990.72620,   0.00000, 0.00000, 180.57094);
    CreateDynamicObject(1498, 317.79691, 361.67410, 990.82782,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19598, 332.53491, 438.40121, 993.27393,   0.00000, 0.00000, 270.84451);
    CreateDynamicObject(19599, 332.53491, 438.40121, 993.27393,   0.00000, 0.00000, 270.84451);

    // Tyler Apartment Complex
    tmpobjid = CreateDynamicObject(19377, -53.833488, 1662.596923, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -43.371700, 1652.957275, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -43.351699, 1662.576538, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -48.670799, 1643.332885, -31.181299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19389, -48.670799, 1640.118652, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    tmpobjid = CreateDynamicObject(2774, -48.923198, 1657.480102, -45.661300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -53.832500, 1651.576049, -32.879199, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -54.315498, 1657.693237, -34.670299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -48.861301, 1652.657958, -33.307399, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -48.861301, 1654.918090, -33.307399, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -48.838600, 1657.017822, -33.307399, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -53.755809, 1643.345825, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -46.551719, 1663.275512, -34.670299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -43.804500, 1638.458007, -34.670299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -41.236728, 1639.390625, -34.670299, 0.000000, 0.000000, 135.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -39.998729, 1645.321655, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -40.949748, 1662.234130, -34.670299, 0.000000, 0.000000, 45.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -39.998001, 1654.921630, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -40.016700, 1664.461425, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -44.530399, 1646.352172, -35.214698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -44.530399, 1646.352172, -33.014850, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -43.337799, 1643.337768, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -43.337799, 1643.337768, -32.854999, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -43.337799, 1652.897827, -32.854999, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -43.328430, 1662.357177, -32.854999, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -53.614818, 1662.510131, -32.854999, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -64.252838, 1662.579833, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -63.900001, 1657.693237, -34.670299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -67.679512, 1661.244018, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -63.974838, 1662.498046, -32.854999, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -53.193790, 1638.496582, -31.181299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19389, -52.740001, 1640.138671, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -52.740001, 1642.033081, -31.181299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -53.792499, 1652.796142, -36.416301, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -52.740001, 1646.512939, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -53.204498, 1638.458007, -34.670299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -48.670799, 1646.512939, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -48.670799, 1652.933837, -31.181299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -47.871398, 1652.064331, -31.181299, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -64.279258, 1651.570800, -32.879199, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, -74.758903, 1651.560668, -32.879199, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
    tmpobjid = CreateDynamicObject(19451, -73.456390, 1649.707519, -31.181299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -47.550380, 1643.257202, -29.383600, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -47.535171, 1652.478759, -29.383600, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -57.961769, 1649.152221, -29.383600, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -68.301933, 1649.141357, -29.383600, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0x00000000);
    tmpobjid = CreateDynamicObject(2774, -48.923198, 1651.159545, -45.661300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 6205, "lawartg", "luxorwall01_128", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -73.347839, 1649.676147, -31.029869, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -73.677001, 1648.942260, -32.234600, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -73.677001, 1650.382324, -32.234600, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -39.710159, 1653.479980, -35.214698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -39.714595, 1649.776000, -35.214698, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -39.710300, 1652.723999, -33.687400, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(9131, -39.710304, 1650.524047, -33.687400, 0.000000, 90.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -67.580200, 1660.563842, -34.610401, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -40.089141, 1657.331665, -34.610401, 0.000000, 0.000000, 270.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 5154, "dkcargoshp_las2", "boatrailing_128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 5154, "dkcargoshp_las2", "boatrailing_128", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -40.087898, 1645.357788, -34.610401, 0.000000, 0.000000, 270.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(1504, -57.417499, 1663.294189, -36.328998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000099);
    tmpobjid = CreateDynamicObject(2108, -42.888774, 1662.893432, -36.350364, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFCCCC66);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFF330000);
    SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 4, -1, "none", "none", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 5, -1, "none", "none", 0xFF333333);
    tmpobjid = CreateDynamicObject(19360, -48.628101, 1647.932983, -34.690372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterialText(tmpobjid, 0, "APARTMENTS", 50, "courier", 20, 1, 0xFFFF0000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(1499, -48.599037, 1639.388671, -36.330364, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(19360, -48.628101, 1646.482666, -33.660377, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    SetDynamicObjectMaterialText(tmpobjid, 0, "ECLIPSE", 50, "courier", 20, 1, 0xFFFF0000, 0x00000000, 1);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(14407, -50.671199, 1644.934814, -35.985900, 0.000000, 0.000000, 180.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(2774, -48.923198, 1651.159545, -20.447340, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19370, -49.290500, 1652.754028, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19370, -49.290500, 1655.934204, -34.670299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19856, -60.900199, 1657.129394, -33.556999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19856, -59.460948, 1668.059082, -37.076000, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19856, -65.667846, 1642.106811, -33.556999, 0.000000, 0.000000, 180.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1557, -52.762401, 1639.389038, -36.391899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1557, -40.028869, 1650.120117, -36.391899, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1557, -40.028900, 1653.141601, -36.391899, 0.000000, 0.000000, 270.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -54.827449, 1663.294189, -36.328979, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -65.927001, 1663.294311, -36.328998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -58.853099, 1652.363159, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -56.263000, 1652.368774, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -67.369918, 1652.360839, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -69.249000, 1646.844238, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -71.829078, 1646.844238, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1504, -60.727100, 1646.840698, -32.808200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1604, -48.617118, 1653.355468, -34.862529, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1604, -48.625900, 1655.306152, -35.463500, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19325, -48.560699, 1654.113037, -34.762901, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19603, -48.679679, 1654.415161, -35.540298, 0.000000, 90.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19630, -48.616500, 1655.060424, -34.637798, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1604, -48.617099, 1653.995483, -34.556499, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1604, -48.617118, 1653.355468, -34.857479, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(11724, -41.150398, 1662.063476, -35.810699, 0.000000, 0.000000, 315.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(11725, -41.237739, 1661.961791, -36.163101, 0.000000, 0.000000, 315.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19632, -41.161701, 1662.063476, -36.429000, 0.000000, 0.000000, 310.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(2007, -40.108436, 1648.264892, -35.864139, -0.299998, 0.099999, -89.599990, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1703, -40.658023, 1646.377685, -36.340339, 0.199999, 0.000000, -89.400016, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1703, -44.628662, 1660.065795, -36.330364, 0.000000, 0.000000, 114.900001, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(1703, -40.863647, 1658.329467, -36.330364, 0.000000, 0.000000, 171.900070, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -40.701515, 1638.955444, -33.040386, 0.000000, 90.000000, 45.200000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.315742, 1642.372802, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.326919, 1645.572509, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.338989, 1649.021972, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.351100, 1652.491943, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.361881, 1655.582397, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.370994, 1658.192382, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.382442, 1661.472290, -33.040386, 0.000000, 90.000000, 90.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -40.604934, 1662.876342, -33.040386, 0.000000, 90.000000, 135.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -43.691097, 1663.953735, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -47.121078, 1663.942016, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -49.571071, 1663.933227, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -43.599761, 1637.782226, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -46.959732, 1637.770751, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -50.419712, 1637.758422, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -53.469699, 1637.747802, -33.040386, 0.000000, 90.000000, 180.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -48.439025, 1637.754882, -34.616783, 0.000012, -179.999938, 4.199995, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -42.192798, 1637.762939, -34.616783, 0.000012, -179.999938, 4.199995, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.513645, 1640.136474, -34.616783, 0.000012, -179.999938, 49.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.335868, 1654.003295, -34.616783, 0.000012, -179.999938, 94.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.309604, 1649.412963, -34.616783, 0.000012, -179.999938, 94.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -39.622257, 1661.888183, -34.616798, 0.000012, -179.999938, 139.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -41.496570, 1663.757446, -34.616798, 0.000012, -179.999938, 139.199996, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -51.213726, 1663.930541, -34.616783, 0.000012, -179.999938, 4.199995, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -49.350341, 1655.133300, -36.310375, 180.000000, 270.000000, 270.200012, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19439, -49.340003, 1652.173828, -36.310375, 180.000000, 270.000000, 270.200012, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(11726, -45.105041, 1653.634399, -33.160358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(19121, -40.366443, 1648.966552, -35.760353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(11726, -45.105041, 1642.514282, -33.160358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 310.00, 310.00);
    tmpobjid = CreateDynamicObject(2834, -40.142837, 1651.174194, -36.330364, 0.000000, 0.000000, 90.000000, -1, -1, -1, 310.00, 310.00);

    //Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////and Crayder////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Map Information////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        Exported on "2018-07-20 16:12:54" by "Seanny"
        Created by "Seanny"
    */
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(19460, -162.767898, 1156.701171, 1320.493041, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -167.494796, 1161.443481, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -167.521606, 1151.983398, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -177.128799, 1161.443481, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -177.128799, 1151.983398, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -178.624603, 1156.605102, 1320.493041, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19460, -170.689605, 1162.258056, 1320.493041, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19396, -170.007598, 1155.836791, 1320.493041, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, -169.078994, 1157.518676, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, -170.007598, 1152.625244, 1322.993041, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, -165.869003, 1157.518676, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19368, -162.658996, 1157.518676, 1320.493041, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(2446, -169.836807, 1153.715332, 1318.919677, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(2446, -169.836807, 1152.715332, 1318.919677, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(2446, -169.836807, 1151.715332, 1318.919677, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -173.422500, 1156.787353, 1322.197265, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10355, "haight1_sfs", "ws_apartmentwhite2", 0x00000000);
    tmpobjid = CreateDynamicObject(19380, -162.922500, 1156.783447, 1322.197265, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10355, "haight1_sfs", "ws_apartmentwhite2", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -173.422500, 1156.787353, 1318.798583, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -162.922500, 1156.783447, 1318.798583, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16639, "a51_labs", "dam_terazzo", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1569, -178.546997, 1155.285278, 1318.910034, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1569, -178.546997, 1158.270385, 1318.910034, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1724, -175.652099, 1160.670654, 1318.919189, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1724, -177.070602, 1160.670654, 1318.919189, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1724, -177.902099, 1153.825683, 1318.919189, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1724, -177.902099, 1152.465698, 1318.919189, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19324, -178.130203, 1159.222167, 1319.527954, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2634, -164.162506, 1157.483642, 1320.456909, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -170.065093, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -169.015106, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -167.965103, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -166.915100, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -165.865097, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -164.815093, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -163.765106, 1161.275024, 1319.838256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -162.923294, 1160.747802, 1319.838256, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -162.923294, 1159.697875, 1319.838256, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, -162.923294, 1158.647949, 1319.838256, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2332, -170.245498, 1158.113647, 1319.419921, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2332, -170.245498, 1159.063598, 1319.419921, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1829, -169.895492, 1160.013549, 1319.419921, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19172, -173.580596, 1152.072387, 1320.861450, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19173, -174.686599, 1161.354125, 1320.864746, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19174, -170.816894, 1159.440063, 1320.861450, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19175, -178.533599, 1153.652099, 1320.861450, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2166, -163.393768, 1153.611206, 1318.920166, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1806, -164.471496, 1153.966796, 1318.920654, 0.000000, 0.000000, -143.279998, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19787, -176.275711, 1152.119995, 1321.053833, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2190, -164.293304, 1152.296630, 1319.696777, 0.000000, 0.000000, -179.159988, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, -170.066070, 1153.113769, 1321.316650, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 


    // Apartment Complex 1 (Fort Carson Main Street)
    new BrickWall[4], NormalWall[24], Floor[16], Stairs[2];

    Floor[0] = CreateDynamicObject(19379, -175.13741, 1117.64539, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[1] = CreateDynamicObject(19379, -164.63460, 1117.64539, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[2] = CreateDynamicObject(19379, -154.13710, 1117.64539, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[3] = CreateDynamicObject(19379, -154.05280, 1108.01184, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[4] = CreateDynamicObject(19379, -164.55260, 1108.01184, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[5] = CreateDynamicObject(19379, -175.05260, 1108.07300, 1318.71069,   0.00000, 90.00000, 0.51010);
    Floor[6] = CreateDynamicObject(19379, -159.80530, 1122.57190, 1322.36023,   0.00000, 90.00000, 0.51010);
    Floor[7] = CreateDynamicObject(19379, -159.68069, 1108.83032, 1322.36023,   0.00000, 90.00000, 0.51010);
    Floor[8] = CreateDynamicObject(19379, -170.22180, 1113.22388, 1322.36023,   0.00000, 90.00000, 0.51010);
    Floor[9] = CreateDynamicObject(19379, -170.30780, 1122.85779, 1322.36023,   0.00000, 90.00000, 0.51010);
    Floor[10] = CreateDynamicObject(19379, -180.72380, 1113.22388, 1322.36023,   0.00000, 90.00000, 0.51010);
    Floor[11] = CreateDynamicObject(19379, -163.01590, 1113.18799, 1325.64819,   0.00000, 90.00000, 0.51010);
    Floor[12] = CreateDynamicObject(19379, -163.09970, 1122.81812, 1325.64819,   0.00000, 90.00000, 0.51010);
    Floor[13] = CreateDynamicObject(19379, -173.51610, 1113.18799, 1325.64819,   0.00000, 90.00000, 0.51010);
    Floor[14] = CreateDynamicObject(19379, -184.01781, 1113.09399, 1325.64819,   0.00000, 90.00000, 0.51010);
    Floor[15] = CreateDynamicObject(19379, -180.80980, 1122.85779, 1322.36023,   0.00000, 90.00000, 0.51010);

    NormalWall[0] = CreateDynamicObject(19446, -181.77220, 1113.50940, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[1] = CreateDynamicObject(19446, -174.96051, 1106.34204, 1320.53455,   0.00000, 0.00000, 0.00000);
    NormalWall[2] = CreateDynamicObject(19446, -170.31010, 1111.06079, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[3] = CreateDynamicObject(19446, -157.68730, 1113.01794, 1320.53455,   0.00000, 0.00000, 0.00000);
    NormalWall[4] = CreateDynamicObject(19446, -157.68730, 1122.65186, 1320.53455,   0.00000, 0.00000, 0.00000);
    NormalWall[5] = CreateDynamicObject(19446, -172.16760, 1121.95935, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[6] = CreateDynamicObject(19446, -181.80161, 1121.95935, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[7] = CreateDynamicObject(19446, -158.64391, 1113.65662, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[8] = CreateDynamicObject(19446, -168.26790, 1113.65662, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[9] = CreateDynamicObject(19446, -158.64391, 1117.73035, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[10] = CreateDynamicObject(19446, -168.26790, 1117.73035, 1320.53455,   0.00000, 0.00000, 90.00000);
    NormalWall[11] = CreateDynamicObject(19446, -172.99519, 1122.45935, 1320.53455,   0.00000, 0.00000, 0.00000);
    NormalWall[12] = CreateDynamicObject(19446, -172.99519, 1108.92737, 1320.53455,   0.00000, 0.00000, 0.00000);
    NormalWall[13] = CreateDynamicObject(19446, -162.53360, 1121.95935, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[14] = CreateDynamicObject(19446, -170.31010, 1108.40076, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[15] = CreateDynamicObject(19446, -160.67610, 1108.40076, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[16] = CreateDynamicObject(19446, -180.11420, 1108.16077, 1324.02942,   0.00000, 0.00000, 0.00000);
    NormalWall[17] = CreateDynamicObject(19446, -166.46851, 1108.79004, 1324.02942,   0.00000, 0.00000, 0.00000);
    NormalWall[18] = CreateDynamicObject(19446, -166.46851, 1122.53992, 1324.02942,   0.00000, 0.00000, 0.00000);
    NormalWall[19] = CreateDynamicObject(19446, -171.19930, 1113.52759, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[20] = CreateDynamicObject(19446, -171.19930, 1117.80762, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[21] = CreateDynamicObject(19446, -180.83211, 1113.52759, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[22] = CreateDynamicObject(19446, -180.83211, 1117.80762, 1324.02942,   0.00000, 0.00000, 90.00000);
    NormalWall[23] = CreateDynamicObject(19354, -175.97110, 1112.33044, 1320.52454,   0.00000, 0.00000, 40.00000);

    BrickWall[0] = CreateDynamicObject(19447, -180.11420, 1117.79077, 1320.53455,   0.00000, 0.00000, 0.00000);
    BrickWall[1] = CreateDynamicObject(19447, -180.11420, 1117.79077, 1324.02942,   0.00000, 0.00000, 0.00000);
    BrickWall[2] = CreateDynamicObject(19447, -157.68730, 1113.01794, 1324.02942,   0.00000, 0.00000, 0.00000);
    BrickWall[3] = CreateDynamicObject(19447, -157.68730, 1122.65186, 1324.02942,   0.00000, 0.00000, 0.00000);

    Stairs[0] = CreateDynamicObject(14407, -162.08270, 1115.68262, 1319.09045,   0.00000, 0.00000, 90.00000);
    Stairs[1] = CreateDynamicObject(14407, -155.91161, 1115.66833, 1319.09045,   0.00000, 0.00000, 270.00000);

    CreateDynamicObject(970, -162.89780, 1113.59631, 1322.97595,   0.00000, 0.00000, 0.51010);
    CreateDynamicObject(970, -162.93980, 1117.74084, 1322.97595,   0.00000, 0.00000, 0.51010);
    CreateDynamicObject(970, -165.00290, 1115.65820, 1322.97595,   0.00000, 0.00000, 90.51010);
    CreateDynamicObject(1569, -171.48100, 1113.58667, 1322.44299,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -176.80569, 1113.58667, 1322.44299,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -171.48100, 1117.76062, 1322.44299,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -176.80569, 1117.76062, 1322.44299,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -169.98410, 1117.66858, 1318.78992,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -169.86470, 1113.71533, 1318.78992,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1569, -174.98199, 1111.32434, 1318.78992,   0.00000, 0.00000, 131.52020);
    CreateDynamicObject(1569, -176.96410, 1113.57776, 1318.78992,   0.00000, 0.00000, -49.00000);
    CreateDynamicObject(2007, -174.45911, 1121.82275, 1319.90906,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2007, -175.45911, 1121.82275, 1319.90906,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1524, -177.60960, 1121.86914, 1320.68457,   10.00000, 0.00000, 90.00000);
    CreateDynamicObject(1526, -171.32930, 1117.64270, 1320.34692,   -15.00000, 0.00000, 90.00000);
    CreateDynamicObject(17969, -157.81670, 1115.94678, 1324.08984,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(4227, -163.95979, 1108.41956, 1323.93005,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(1728, -179.34480, 1119.32349, 1318.79797,   0.00000, 0.00000, 81.05992);
    CreateDynamicObject(1498, -165.14931, 1115.92322, 1318.85144,   50.00000, 0.00000, 90.00000);
    CreateDynamicObject(1896, -178.15527, 1115.52454, 1319.77844,   0.00000, 0.00000, 126.00000);
    CreateDynamicObject(1728, -173.92355, 1119.94287, 1318.79822,   0.00000, 0.00000, -81.42009);

    for(new i; i < sizeof(NormalWall); i++)
    {
        SetDynamicObjectMaterial(NormalWall[i], 0, 8842, "vgse24hr", "compcouwall1", 0xFFFFFFFF);
    }

    for(new i; i < sizeof(BrickWall); i++)
    {
        SetDynamicObjectMaterial(BrickWall[i], 0, 11471, "des_wtownmain", "des_brick1", 0xFFFFFFFF);
    }

    for(new i; i < sizeof(Floor); i++)
    {
        SetDynamicObjectMaterial(Floor[i], 0, 11484, "des_wdam", "des_dustconc", 0xFFFFFFFF);
    }

    for(new i; i < sizeof(Stairs); i++)
    {
        SetDynamicObjectMaterial(Stairs[i], 0, 11484, "des_wdam", "des_dustconc", 0xFFFFFFFF);
    }


    // LS Airport Gate - LS Airport is where we store unused businesses, houses and objects.
    //CreateDynamicObject(980, 1961.65369, -2189.78955, 15.28372,   0.00000, 0.00000, 0.00000);

    // Fort Carson Street Lights
    CreateDynamicObject(1294, 49.2, 1202.9, 22.3, 0, 0, 90, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (1)
    CreateDynamicObject(1294, 49.1, 1193.6, 22.3, 0, 0, 270, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (3)
    CreateDynamicObject(1294, 20.9, 1193.7, 22.5, 0, 0, 270, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (4)
    CreateDynamicObject(1294, 20.9, 1202.8, 22.5, 0, 0, 90, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (5)
    CreateDynamicObject(1294, -0.2, 1193.7, 22.7, 0, 0, 270, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (6)
    CreateDynamicObject(1294, -11.8, 1202.8, 22.7, 0, 0, 90, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (7)
    CreateDynamicObject(1294, -38, 1202.8, 22.7, 0, 0, 90, -1, -1, -1, 200.0, 0.0); // object (mlamppost) (8)

    // Bathroom Interior
    CreateDynamicObject(18020, 1985.099609375, 3817.8994140625, 121.30000305176, 0, 0, 0);
    CreateDynamicObject(18553, 1977.1999511719, 3820.6000976563, 120.59999847412, 0, 0, 90);
    CreateDynamicObject(2742, 1976.4000244141, 3828.3999023438, 120.5, 0, 0, 0);
    CreateDynamicObject(2742, 1977.8000488281, 3828.3999023438, 120.5, 0, 0, 0);
    CreateDynamicObject(2514, 1980.0999755859, 3827.8999023438, 119.30000305176, 0, 0, 0);
    CreateDynamicObject(2514, 1984.19921875, 3827.8994140625, 119.30000305176, 0, 0, 0);
    CreateDynamicObject(1651, 1981.8000488281, 3821.5, 121.59999847412, 0, 0, 90);
    CreateDynamicObject(2515, 1979.1999511719, 3821.8999023438, 120.30000152588, 0, 0, 179.99993896484);
    CreateDynamicObject(2515, 1980.9000244141, 3821.8999023438, 120.30000152588, 0, 0, 179.99993896484);
    CreateDynamicObject(2515, 1982.5999755859, 3821.8999023438, 120.30000152588, 0, 0, 179.99993896484);
    CreateDynamicObject(2515, 1984.1999511719, 3821.8999023438, 120.30000152588, 0, 0, 179.99993896484);
    CreateDynamicObject(1359, 1975.5999755859, 3824.8000488281, 120, 0, 0, 0);
    CreateDynamicObject(2740, 1977.5999755859, 3824.8000488281, 123.20000305176, 0, 0, 0);
    CreateDynamicObject(2740, 1982.1999511719, 3824.8000488281, 123.20000305176, 0, 0, 0);
    CreateDynamicObject(2514, 1982.1999511719, 3827.8999023438, 119.30000305176, 0, 0, 0);
    CreateDynamicObject(2674, 1976.5, 3825.3999023438, 119.40000000000, 0, 0, 0);
    CreateDynamicObject(2959, 1977.3000488281, 3820.6999511719, 119.30000305176, 0, 0, 92);

    // Pay 'n' Spray Blocks
    CreateDynamicObject(19912, -92.98193, 1111.54456, 20.47277,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, -1416.02808, 2591.03467, 56.65247,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, 1968.59753, 2167.73975, 11.65403,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19912, 720.03009, -462.37161, 7.39789,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19912, -1897.54456, 277.97501, 42.62510,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, -2421.79517, 1028.05652, 52.10580,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, 492.14725, -1735.91162, 11.84904,   0.00000, 0.00000, 352.70981);
    CreateDynamicObject(19912, 1031.61914, -1029.08740, 32.41924,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19912, 2071.36060, -1826.19958, 14.14866,   0.00000, 0.00000, 90.00000);

    // Fort Carson House Exteriors
    CreateDynamicObject(3310, -38.06090, 1045.88611, 20.77540,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3310, 6.93950, 1075.88086, 20.77540,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3310, -38.05120, 1075.86804, 20.77540,   0.00000, 0.00000, 270.00000);
    CreateDynamicObject(3310, -43.05200, 1120.85437, 20.78480,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3310, -18.06400, 1120.85437, 20.78480,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3310, 6.93070, 1120.85828, 20.78480,   0.00000, 0.00000, 90.00000);

    // Fixed Trailer
    CreateDynamicObject(11015, 4.2412109375, -0.25, 1002.3616333008, 0, 90, 179.99450683594, .interiorid = 2);
    CreateDynamicObject(11015, -3.7464447021484, -0.46751827001572, 1002.3616333008, 0, 90, 0, .interiorid = 2);
    CreateDynamicObject(11015, -2.0341796875, -0.2255859375, 996.58734130859, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(11015, -1.7412109375, -8.029296875, 1002.3616333008, 0, 90, 89.994506835938, .interiorid = 2);
    CreateDynamicObject(11015, 2.349609375, 9.3095703125, 1002.3616333008, 0, 90, 270, .interiorid = 2);
    CreateDynamicObject(976, -8.3762712478638, 5.4238820075989, 998.02801513672, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(976, 10.326154708862, 5.4526047706604, 998.02801513672, 0, 0, 180, .interiorid = 2);
    CreateDynamicObject(976, -0.78860986232758, 4.5294494628906, 998.02801513672, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(976, -9.4923362731934, 2.8067343235016, 998.30328369141, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(968, -0.78987210988998, 3.085230588913, 996.65313720703, 0, 0, 88.375030517578, .interiorid = 2);
    CreateDynamicObject(2424, -1.1989899873734, 2.1414895057678, 998.20440673828, 0, 0, 270, .interiorid = 2);
    CreateDynamicObject(2424, -1.4444495439529, 1.2195072174072, 998.20440673828, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.2420085668564, 0.15943863987923, 998.20440673828, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.2046113014221, -0.27639570832253, 998.20440673828, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.6594306230545, -1.5798351764679, 998.40460205078, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.6048280000687, -3.7030065059662, 998.50469970703, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.3431304693222, -4.7396554946899, 997.82904052734, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -1.3272333145142, -5.6384997367859, 997.85406494141, 0, 0, 269.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, -0.82665449380875, -5.819974899292, 997.82904052734, 0, 0, 0.07452392578125, .interiorid = 2);
    CreateDynamicObject(2424, 0.90103495121002, -5.7934393882751, 997.82904052734, 0, 0, 0.0714111328125, .interiorid = 2);
    CreateDynamicObject(2424, 1.8007507324219, -5.7772388458252, 997.82904052734, 0, 0, 0.0714111328125, .interiorid = 2);
    CreateDynamicObject(2424, 2.0067005157471, -4.656822681427, 997.82904052734, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 2.0016891956329, -5.5176014900208, 997.82904052734, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 0.095220312476158, -5.8064684867859, 997.85406494141, 0, 0, 0.0714111328125, .interiorid = 2);
    CreateDynamicObject(2424, 1.9964281320572, -1.4732304811478, 997.82904052734, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 2.0242736339569, -0.59229171276093, 997.82904052734, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 1.105211853981, -0.25799462199211, 997.82904052734, 0, 0, 180, .interiorid = 2);
    CreateDynamicObject(2424, 0.85449481010437, -0.25893545150757, 997.82904052734, 0, 0, 179.99450683594, .interiorid = 2);
    CreateDynamicObject(2424, 0.94933843612671, 0.93138349056244, 998.40460205078, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(2424, 1.9278947114944, 1.8640511035919, 998.40386962891, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 1.912776350975, 2.7815411090851, 998.40386962891, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 1.9282813072205, 3.7311086654663, 998.40386962891, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2424, 0.94268548488617, 0.38233369588852, 998.40460205078, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(2424, 1.8336682319641, 0.42996874451637, 998.40460205078, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(1814, -0.070350080728531, -4.9489212036133, 998.45343017578, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(2108, 0.87250107526779, -1.5103777647018, 997.35357666016, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(2738, -1.3212617635727, 5.0136914253235, 998.98120117188, 0, 0, 0, .interiorid = 2);
    CreateDynamicObject(2558, -0.45861941576004, 3.3949182033539, 999.67913818359, 0, 0, 90, .interiorid = 2);
    CreateDynamicObject(2558, -1.1560896635056, 4.4181189537048, 999.70416259766, 0, 0, 270, .interiorid = 2);
    CreateDynamicObject(1745, 2.4512000083923, 6.3230948448181, 998.07806396484, 0, 0, 90, .interiorid = 2);

    // DMV Parking
    /*new ParkingLot[3];
    ParkingLot[0] = CreateDynamicObject(19460, -197.86900, 1225.26929, 18.67370,   0.00000, 90.00000, 90.00000);
    ParkingLot[1] = CreateDynamicObject(19460, -197.86900, 1221.75317, 18.67370,   0.00000, 90.00000, 90.00000);
    ParkingLot[2] = CreateDynamicObject(19460, -204.33009, 1222.20898, 18.67370,   0.00000, 90.00000, 0.00000);
    for(new i; i < sizeof(ParkingLot); i++)
    {
        SetDynamicObjectMaterial(ParkingLot[i], 0, 8529, "vgsmotelgrnd", "parking2plain", 0xFFFFFFFF);
    }

    CreateDynamicObject(19357, -193.23940, 1225.38123, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -196.40739, 1225.38123, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -199.62340, 1225.38123, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -203.07941, 1225.38123, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -203.07941, 1222.16516, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -199.62340, 1222.16516, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -196.40739, 1222.16516, 17.05690,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19357, -193.23940, 1222.16516, 17.05690,   0.00000, 0.00000, 0.00000);*/

    DMVVehicles[0] = AddStaticVehicle(404, -201.3676, 1224.0121, 19.4338, 0.0000, 1, 1);
    DMVVehicles[1] = AddStaticVehicle(404, -198.0076, 1224.0121, 19.4338, 0.0000, 1, 1);
    DMVVehicles[2] = AddStaticVehicle(404, -194.8876, 1224.0121, 19.4338, 0.0000, 1, 1);

    new counter = 0;
    for(new i; i < sizeof(DMVVehicles); i++)
    {
        counter++;
        new plate[32];
        format(plate, sizeof(plate), "DMV %i", counter);
        SetVehicleNumberPlate(DMVVehicles[i], plate);
        SetVehicleToRespawn(DMVVehicles[i]);
    }

    AddHousesInteriors();
    LoadHospitalInterior();
    LoadPDInterior();
    TylerMap();
    LoadConcertMapping();
}

stock LoadConcertMapping()
{
    new tmpobjid;
    tmpobjid = CreateDynamicObject(16000, 110.813003, 1039.032104, 14.548392, 89.999992, 89.999992, -89.999977, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 3, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 116.699104, 1038.982299, 12.631869, 0.000015, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 107.099105, 1038.982299, 12.641869, 0.000015, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 104.939117, 1038.982299, 12.641869, 0.000015, 0.000000, 89.999954, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 100.179107, 1034.262451, 12.641869, 0.000000, -0.000015, 179.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 121.439018, 1034.262451, 12.801871, 0.000000, -0.000015, 179.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18761, 110.843803, 1029.216186, 19.209362, 0.000000, 0.000015, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19307, "goflagx2", "goflag2", 0xFFCCFFFF);
    SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 120.747138, 1038.382812, 21.771863, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 120.747138, 1038.382812, 16.921867, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 101.027137, 1038.382812, 21.771863, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 101.027137, 1038.382812, 16.911867, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 104.007087, 1038.382812, 23.771883, 90.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 108.967079, 1038.382812, 23.771883, 90.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 113.947082, 1038.382812, 23.771883, 90.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 117.897071, 1038.382812, 23.771883, 90.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 120.737045, 1035.402343, 23.771883, 90.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 120.737045, 1030.412597, 23.771883, 90.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 101.037055, 1035.402343, 23.771883, 90.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 101.037055, 1030.421020, 23.771883, 90.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 103.027038, 1027.441528, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 108.017028, 1027.441528, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 113.017059, 1027.441528, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 118.007095, 1027.441528, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 118.737121, 1027.441528, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 123.707099, 1032.922851, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 125.707122, 1032.933227, 20.911853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 125.707122, 1032.933227, 16.011857, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 125.707122, 1032.933227, 11.161861, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 98.117103, 1032.922851, 23.771860, 90.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 96.107070, 1032.933227, 20.911853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 96.107070, 1032.933227, 16.081853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 96.107070, 1032.933227, 11.231851, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 104.933883, 1026.748657, 14.459385, 180.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 114.523895, 1026.748657, 14.459385, 180.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 116.703895, 1026.748657, 14.459385, 180.000000, 90.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 100.179107, 1029.821533, 12.641869, 0.000000, -0.000015, 179.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 104.909133, 1025.081420, 12.641869, 0.000000, -0.000015, 269.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 114.489143, 1025.081420, 12.641869, 0.000000, -0.000015, 269.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 116.699081, 1025.081420, 12.641869, 0.000000, -0.000015, 269.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 121.449073, 1029.821044, 12.641869, 0.000000, -0.000015, 359.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19446, 116.623275, 1028.297241, 16.241872, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 116.563262, 1028.297241, 19.721870, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 107.093261, 1028.297241, 19.721870, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 107.093261, 1028.297241, 16.241872, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 104.903274, 1028.297241, 16.241888, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19449, 98.403884, 1028.618164, 14.489386, 180.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3967, "cj_airprt", "CJ_BLACK_RUB2", 0x00000000);
    tmpobjid = CreateDynamicObject(19446, 116.613265, 1028.297241, 22.521881, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 107.203254, 1028.297241, 22.521881, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 101.623275, 1028.297241, 22.521881, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19446, 101.523277, 1028.297241, 19.071868, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10871, "blacksky_sfse", "ws_blackmarble", 0xFF333333);
    tmpobjid = CreateDynamicObject(19447, 101.469093, 1033.341796, 12.761871, 0.000000, -0.000015, 269.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 96.739067, 1028.611572, 12.801872, 0.000000, -0.000015, 359.999908, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14384, "kit3hghg", "AH_greencurtain", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.262405, 1023.879882, 12.801956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.542388, 1023.879882, 12.801956, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.072326, 1025.401000, 12.801956, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1034.250976, 16.232559, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1034.250976, 19.722568, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1029.769653, 19.722568, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1029.769653, 16.242576, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1029.769653, 22.522548, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 121.419662, 1034.240234, 22.522548, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 116.699645, 1025.030151, 22.522548, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 116.699645, 1025.030151, 19.062553, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 116.699645, 1025.030151, 16.232551, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 116.699645, 1025.030151, 16.232551, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 107.109642, 1025.030151, 16.232551, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 107.109642, 1025.030151, 19.722539, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 107.109642, 1025.030151, 22.522556, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 101.479705, 1025.030151, 22.522525, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 101.479705, 1025.030151, 16.212526, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 101.479705, 1025.030151, 19.692518, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 96.749748, 1028.610351, 16.292491, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 96.749748, 1028.610351, 19.702482, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19458, 96.749748, 1028.610351, 22.512496, 0.000000, 0.000000, 360.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF330000);
    tmpobjid = CreateDynamicObject(19364, 98.322364, 1033.371337, 16.161958, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.322364, 1033.371337, 19.621942, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.322364, 1033.371337, 22.511936, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1035.041503, 16.161958, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.502418, 1033.371337, 16.161958, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.502418, 1033.371337, 19.471954, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 98.502418, 1033.371337, 22.491949, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1035.041503, 19.511957, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1035.041503, 22.521957, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1037.462524, 16.161958, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1037.462524, 19.631977, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 100.192344, 1037.462524, 22.522001, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "redFabric", 0xFF333333);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "sl_vicrfedge", 0x00000000);
    tmpobjid = CreateDynamicObject(19448, 114.941291, 1028.354980, 17.841869, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 5998, "sunstr_lawn", "sunneon01", 0x00000000);
    tmpobjid = CreateDynamicObject(19448, 106.941276, 1028.354980, 17.841869, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 5998, "sunstr_lawn", "sunneon01", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 116.698677, 1033.801879, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 116.698677, 1033.801879, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 107.128692, 1033.801879, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 104.918701, 1033.801879, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 104.918701, 1030.209838, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 114.488754, 1030.209838, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19376, 116.688728, 1030.209838, 24.305734, 1620.000000, 810.000000, 630.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 98.403884, 1028.618164, 24.309394, 180.000000, 90.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 100.627113, 1024.433227, 15.111853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 100.627113, 1024.433227, 20.071840, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 100.627113, 1024.433227, 21.911836, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 103.557144, 1024.433227, 23.921848, 90.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 108.507148, 1024.433227, 23.921848, 90.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 113.497131, 1024.433227, 23.921848, 90.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 118.357116, 1024.433227, 23.921848, 90.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 121.017089, 1024.463256, 21.901842, 180.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 121.017089, 1024.463256, 17.081855, 180.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 121.017089, 1024.463256, 12.251854, 180.000000, 0.000000, 450.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 110.507156, 1022.533142, 22.229129, 225.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 110.507156, 1019.103088, 18.799654, 225.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 110.507156, 1015.659606, 15.356050, 225.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 110.507156, 1012.180358, 11.877087, 225.000000, 0.000000, 540.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18761, "matracing", "bridgeframe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19363, 125.621353, 1033.397827, 16.439380, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1414, "break_street1", "CJ_TV_SCREEN", 0x00000000);
    tmpobjid = CreateDynamicObject(19363, 125.621353, 1033.397827, 19.889383, 0.000000, 0.000000, 90.000000, -1, -1, -1, 600.00, 600.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 1414, "break_street1", "CJ_TV_SCREEN", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(18275, -2376.120117, -2196.250000, 34.539100, 0.000000, 0.000000, -65.000061, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19279, 102.616714, 1037.941650, 14.731873, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19279, 106.826675, 1037.941650, 14.731873, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(18653, 117.992439, 1029.159545, 14.431872, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19279, 115.646614, 1037.941650, 14.731873, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19279, 119.406539, 1037.941650, 14.731873, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(18654, 103.577209, 1029.204589, 14.551870, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19152, 110.448059, 1037.837402, 23.441896, -20.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(18655, 110.741935, 1029.257568, 14.500455, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19159, 110.701248, 1033.888671, 24.013187, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(18102, 115.777725, 1030.691894, 24.516529, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19611, 110.950813, 1037.708984, 14.551871, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19610, 110.950454, 1037.703857, 16.182537, 135.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19614, 114.856552, 1033.473876, 14.551871, 0.000000, 0.000000, 210.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19317, 114.658836, 1033.546386, 15.311755, -10.000000, 0.000000, 210.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19616, 113.592956, 1031.929565, 14.631873, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19609, 106.829833, 1033.718505, 14.551871, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19613, 110.923065, 1031.749511, 14.581871, 0.000000, 0.000000, 165.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2125, 106.938636, 1032.759155, 14.871870, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19318, 113.552780, 1032.179077, 15.301870, -5.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 101.048446, 1039.425781, 13.189373, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 120.718383, 1039.375976, 13.189373, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 120.718383, 1039.375976, 14.359377, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 101.038414, 1039.416015, 14.359377, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 101.073020, 1038.741577, 17.475383, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 101.073020, 1038.741577, 17.925392, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 101.073020, 1038.741577, 18.365394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 120.732986, 1038.741577, 18.365394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 120.732986, 1038.741577, 17.895397, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1840, 120.732986, 1038.741577, 17.435401, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 113.652946, 1038.265869, 15.069380, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 108.712966, 1038.265869, 15.099381, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 108.712966, 1028.794433, 15.169383, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 115.852951, 1028.794433, 15.169383, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 120.051727, 1030.542358, 15.169383, 0.000000, 0.000000, 220.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19152, 108.468109, 1037.837402, 23.441896, -20.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19152, 112.438095, 1037.837402, 23.441896, -20.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19152, 116.368072, 1037.837402, 23.441896, -20.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(19152, 104.978141, 1037.837402, 23.441896, -20.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 15.289376, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 16.459375, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 17.589378, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 17.589378, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 18.749383, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 19.939393, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 123.708412, 1033.094970, 21.119411, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 21.119411, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 19.979421, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 18.839426, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 17.659425, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 16.489423, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(2232, 127.558403, 1033.094970, 15.289427, 0.000000, 0.000000, 180.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(996, 113.749191, 1040.846313, 13.259376, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(996, 105.449134, 1040.846313, 13.259376, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(996, 101.419120, 1040.846313, 13.259376, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1569, 97.234100, 1025.062011, 14.545324, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(1569, 97.234100, 1024.992065, 14.545324, 0.000000, 0.000000, 0.000000, -1, -1, -1, 600.00, 600.00); 
    tmpobjid = CreateDynamicObject(3361, 97.958221, 1020.874877, 12.476252, 0.000000, 0.000000, 270.000000, -1, -1, -1, 600.00, 600.00);
}

stock TylerMap()
{
    // SD Exterior
    CreateDynamicObject(12855, 69.56466, 1168.95227, 23.03340,   0.00000, 0.00000, 90.62230);
    CreateDynamicObject(5153, 104.93510, 1190.06738, 16.63500,   0.00000, 0.00000, 268.83340);
    CreateDynamicObject(5153, 102.79620, 1190.13306, 16.63500,   0.00000, 0.00000, 268.83340);
    CreateDynamicObject(5153, 100.69740, 1190.19470, 16.63500,   0.00000, 0.00000, 268.83340);
    CreateDynamicObject(5153, 98.57760, 1190.25903, 16.63500,   0.00000, 0.00000, 268.83340);
    CreateDynamicObject(5153, 96.47820, 1190.32239, 16.63500,   0.00000, 0.00000, 268.83340);

    // House maps (no furniture)
    CreateDynamicObject(14748, 1365.361694, -2141.651611, 1051.588623, 0.000000, 0.000000, 270.000000);
    CreateDynamicObject(1506, 1364.546875, -2146.731689, 1049.618652, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(14750, 1752.987548, -1814.000000, 1005.840515, 0.000000, 0.000000, 0.000000);
    CreateDynamicObject(1506, 1750.443969, -1823.364013, 999.340454, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(14754, 1284.700317, -1132.096679, 982.990844, 0.000000, 0.000000, 0.000000);
    CreateDynamicObject(1506, 1282.763061, -1141.286621, 979.051940, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(14718, 2005.202270, -1701.831054, 1164.692260, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(1506, 2010.115234, -1698.054321, 1164.701660, 0.000000, 0.000000, -90.000000);
    CreateDynamicObject(14713, 1183.433837, -422.981140, 1235.509155, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(1506, 1177.512084, -418.100250, 1233.734375, 0.000000, 0.000000, 0.000000);
    CreateDynamicObject(14712, 2190.703125, -1127.359619, 1129.335815, 0.000000, 0.000000, 270.000000);
    CreateDynamicObject(1506, 2183.202392, -1131.089599, 1127.785400, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(14700, 1437.169189, -1832.845703, 1314.057250, 0.000000, 0.000000, 270.000000);
    CreateDynamicObject(1506, 1433.098266, -1833.567993, 1312.596801, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(14707, 911.334106, -484.425170, 847.481384, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(14710, 836.976257, -1017.067077, 800.481994, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(1506, 827.483337, -1014.606506, 798.996154, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(14711, 1312.136840, -175.075073, 1088.675659, 0.000000, 0.000000, 0.000000);
    CreateDynamicObject(1506, 1321.403198, -166.876174, 1087.131591, 0.000000, 0.000000, 270.000000);
    CreateDynamicObject(14706, 1834.514404, -1290.143066, 834.363037, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(14701, 2654.076171, -1032.999389, 930.996948, 0.000000, 0.000000, 180.000000);
    CreateDynamicObject(1506, 2653.683593, -1022.535644, 928.926269, 0.000000, 0.000000, 0.000000);

    // Big Garage
    CreateDynamicObject(10980, 1413.79797, 1580.14148, 3013.30151,   0.00000, 0.00000, 90.00000, .interiorid = 50);
    CreateDynamicObject(10980, 1435.86023, 1610.00354, 3013.30151,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(10980, 1466.71130, 1573.75696, 3013.30151,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(10980, 1440.75977, 1546.00244, 3013.30151,   0.00000, 0.00000, -180.00000, .interiorid = 50);
    CreateDynamicObject(10789, 1445.69556, 1578.38196, 3013.87915,   0.00000, -180.00000, -180.00000, .interiorid = 50);
    CreateDynamicObject(19861, 1439.83020, 1564.47522, 3007.60352,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1443.29639, 1564.59692, 3006.78784,   0.00000, 0.00000, 90.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1436.42090, 1564.56213, 3006.78784,   0.00000, 0.00000, 90.00000, .interiorid = 50);
// Medium Garage
    CreateDynamicObject(8399, 1429.41382, 1632.59399, 3006.23218,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(8399, 1447.01453, 1662.71594, 3006.22485,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(8399, 1467.62268, 1646.23840, 3006.23218,   0.00000, 0.00000, -180.00000, .interiorid = 50);
    CreateDynamicObject(8399, 1452.06091, 1620.87012, 3006.23218,   0.00000, 0.00000, -270.00000, .interiorid = 50);
    CreateDynamicObject(11313, 1448.41895, 1631.20410, 3006.44678,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(10789, 1452.76306, 1639.30151, 3012.93506,   0.00000, -180.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1452.72522, 1631.34509, 3007.26636,   0.00000, 0.00000, 90.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1444.08679, 1631.34302, 3007.26636,   0.00000, 0.00000, 90.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1442.87683, 1652.26660, 3007.46509,   0.00000, 0.00000, 270.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1454.14478, 1652.26013, 3007.46509,   0.00000, 0.00000, 270.00000, .interiorid = 50);
// Small Garage
    CreateDynamicObject(8689, 1508.50708, 1657.43445, 3008.61304,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(8689, 1509.05957, 1618.44397, 3008.61304,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(8689, 1489.83911, 1638.71460, 3008.61304,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(8689, 1534.56470, 1637.35303, 3008.61304,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(10789, 1515.84558, 1640.77429, 3012.93506,   0.00000, -180.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(10149, 1504.02637, 1637.98682, 3006.55615,   0.00000, 0.00000, -90.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1504.12219, 1635.03723, 3007.37891,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1504.10608, 1640.74524, 3007.37891,   0.00000, 0.00000, 0.00000, .interiorid = 50);
    CreateDynamicObject(3785, 1520.25708, 1637.85486, 3007.37891,   0.00000, 0.00000, 180.00000, .interiorid = 50);

    // Construction Company
    new g_Object[97];
    g_Object[0] = CreateDynamicObject(19380, 44.6829, 1133.5743, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[0], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[1] = CreateDynamicObject(19380, 55.1829, 1133.5605, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[1], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[2] = CreateDynamicObject(19380, 55.1829, 1123.9312, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[2], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[3] = CreateDynamicObject(19380, 44.6829, 1143.2049, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[3], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[4] = CreateDynamicObject(19380, 55.1829, 1114.3114, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[4], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[5] = CreateDynamicObject(19380, 44.6829, 1114.3114, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[5], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[6] = CreateDynamicObject(19380, 44.6829, 1123.9428, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[6], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[7] = CreateDynamicObject(4021, 54.6137, 1122.1599, 25.1917, 0.0000, 0.0000, -90.0000); //Officessml1_lan
    SetDynamicObjectMaterial(g_Object[7], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 1, 6522, "cuntclub_law2", "marinawindow1_256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 2, 6522, "cuntclub_law2", "marinawindow1_256", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 3, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 4, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 5, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 6, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 7, 3629, "arprtxxref_las", "corrRoof_64HV", 0xFFFFFFFF);
    g_Object[8] = CreateDynamicObject(19380, 55.1730, 1143.1949, 18.6749, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[8], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[9] = CreateDynamicObject(19380, 58.7130, 1143.1949, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[9], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[10] = CreateDynamicObject(19380, 58.7130, 1133.5645, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[10], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[11] = CreateDynamicObject(19380, 58.7130, 1123.9344, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[11], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[12] = CreateDynamicObject(19380, 58.7130, 1114.3028, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[12], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[13] = CreateDynamicObject(19380, 58.7029, 1112.6711, 18.6548, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[13], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[14] = CreateDynamicObject(19380, 44.6930, 1112.6711, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[14], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[15] = CreateDynamicObject(19380, 55.1829, 1112.6711, 18.6648, 0.0000, 90.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[15], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[16] = CreateDynamicObject(19380, 63.8829, 1143.1949, 13.4849, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[16], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[17] = CreateDynamicObject(19380, 63.8829, 1133.5645, 13.4849, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[17], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[18] = CreateDynamicObject(19380, 63.8829, 1123.9344, 13.4849, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[18], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[19] = CreateDynamicObject(19380, 59.1529, 1147.9251, 13.4849, 0.0000, 0.0000, 90.0000); //wall028
    SetDynamicObjectMaterial(g_Object[19], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[20] = CreateDynamicObject(8948, 57.6393, 1134.6208, 20.5014, 0.0000, 0.0000, -90.0000); //lckupgrgdoor_lvs
    g_Object[21] = CreateDynamicObject(19353, 59.9243, 1134.5490, 20.7299, 0.0000, 0.0000, 90.0000); //wall001
    SetDynamicObjectMaterial(g_Object[21], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[22] = CreateDynamicObject(19353, 55.3442, 1134.5490, 20.7299, 0.0000, 0.0000, 90.0000); //wall001
    SetDynamicObjectMaterial(g_Object[22], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[23] = CreateDynamicObject(19353, 57.7843, 1134.5390, 20.7299, 0.0000, 0.0000, 90.0000); //wall001
    SetDynamicObjectMaterial(g_Object[23], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[24] = CreateDynamicObject(19353, 55.3442, 1134.5490, 17.2299, 0.0000, 0.0000, 90.0000); //wall001
    SetDynamicObjectMaterial(g_Object[24], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[25] = CreateDynamicObject(19353, 59.9243, 1134.5490, 17.2299, 0.0000, 0.0000, 90.0000); //wall001
    SetDynamicObjectMaterial(g_Object[25], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[26] = CreateDynamicObject(1569, 49.0317, 1118.9538, 19.2532, 0.0000, 0.0000, 90.0000); //ADAM_V_DOOR
    g_Object[27] = CreateDynamicObject(1569, 49.0218, 1121.9560, 19.2532, 0.0000, 0.0000, -90.0000); //ADAM_V_DOOR
    g_Object[28] = CreateDynamicObject(18762, 47.3408, 1123.4261, 19.9619, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[28], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[29] = CreateDynamicObject(18762, 47.3408, 1124.4271, 19.9619, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[29], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[30] = CreateDynamicObject(19380, 49.5229, 1147.9353, 14.8949, 0.0000, 0.0000, 90.0000); //wall028
    SetDynamicObjectMaterial(g_Object[30], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[31] = CreateDynamicObject(18763, 47.5494, 1120.3939, 16.5534, 0.0000, 0.0000, 0.0000); //Concrete3mx3mx5m
    SetDynamicObjectMaterial(g_Object[31], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[32] = CreateDynamicObject(19380, 59.1529, 1147.9353, 14.8949, 0.0000, 0.0000, 90.0000); //wall028
    SetDynamicObjectMaterial(g_Object[32], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[33] = CreateDynamicObject(19380, 44.2430, 1147.9453, 14.8949, 0.0998, 0.0000, 90.0000); //wall028
    SetDynamicObjectMaterial(g_Object[33], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[34] = CreateDynamicObject(19360, 39.5154, 1143.2137, 18.4132, 0.0000, 0.0000, 0.0000); //wall008
    SetDynamicObjectMaterial(g_Object[34], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[35] = CreateDynamicObject(19360, 39.5154, 1146.4249, 18.4132, 0.0000, 0.0000, 0.0000); //wall008
    SetDynamicObjectMaterial(g_Object[35], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[36] = CreateDynamicObject(19380, 39.5130, 1128.8824, 14.9148, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[36], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[37] = CreateDynamicObject(19380, 39.5130, 1112.6700, 14.9148, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[37], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[38] = CreateDynamicObject(19380, 63.8930, 1143.2036, 14.9148, 0.0000, 0.0000, 0.0000); //wall028
    SetDynamicObjectMaterial(g_Object[38], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[39] = CreateDynamicObject(19360, 63.8954, 1136.7812, 18.4132, 0.0000, 0.0000, 0.0000); //wall008
    SetDynamicObjectMaterial(g_Object[39], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[40] = CreateDynamicObject(19360, 63.8954, 1133.5704, 18.4132, 0.0000, 0.0000, 0.0000); //wall008
    SetDynamicObjectMaterial(g_Object[40], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[41] = CreateDynamicObject(19360, 62.3754, 1132.0498, 18.4232, 0.0000, 0.0000, 90.0000); //wall008
    SetDynamicObjectMaterial(g_Object[41], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[42] = CreateDynamicObject(18762, 39.9108, 1134.1259, 17.8017, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[42], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[43] = CreateDynamicObject(18762, 39.9108, 1141.1378, 17.8017, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[43], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[44] = CreateDynamicObject(18762, 39.9108, 1123.5655, 17.8017, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[44], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[45] = CreateDynamicObject(18762, 39.9108, 1117.0241, 17.8017, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[45], 0, 1736, "cj_ammo", "CJ_Black_metal", 0xFFFFFFFF);
    g_Object[46] = CreateDynamicObject(19380, 44.2430, 1107.9410, 14.9048, 0.0000, 0.0000, 90.0000); //wall028
    SetDynamicObjectMaterial(g_Object[46], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[47] = CreateDynamicObject(19360, 50.6654, 1107.9422, 18.4032, 0.0000, 0.0000, 90.0000); //wall008
    SetDynamicObjectMaterial(g_Object[47], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[48] = CreateDynamicObject(19360, 52.1853, 1109.4631, 18.4132, 0.0000, 0.0000, 0.0000); //wall008
    SetDynamicObjectMaterial(g_Object[48], 0, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    g_Object[49] = CreateDynamicObject(19175, 47.0238, 1120.3238, 29.2483, 0.0000, 0.0000, -90.0000); //SAMPPicture4
    SetDynamicObjectMaterialText(g_Object[49], 0, "ECLIPSE", 90, "Arial", 70, 1, 0xFF000000, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[49], 1, " ", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[50] = CreateDynamicObject(1372, 62.8380, 1122.6578, 18.8738, 0.0000, 0.0000, 90.0000); //CJ_Dump2_LOW
    g_Object[51] = CreateDynamicObject(19175, 47.5559, 1119.6971, 19.2735, -90.0000, 90.0000, 0.0000); //SAMPPicture4
    SetDynamicObjectMaterialText(g_Object[51], 0, "WELCOME", 90, "Arial", 28, 1, 0xFF000000, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[51], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[52] = CreateDynamicObject(19354, 45.6166, 1126.8923, 18.6835, 0.0000, 90.0000, 0.0000); //wall002
    SetDynamicObjectMaterial(g_Object[52], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[53] = CreateDynamicObject(19354, 45.6166, 1130.1024, 18.6835, 0.0000, 90.0000, 0.0000); //wall002
    SetDynamicObjectMaterial(g_Object[53], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[54] = CreateDynamicObject(19354, 45.6166, 1115.6009, 18.6835, 0.0000, 90.0000, 0.0000); //wall002
    SetDynamicObjectMaterial(g_Object[54], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[55] = CreateDynamicObject(817, 45.8508, 1130.1223, 19.1487, 0.0000, 0.0000, 0.0000); //veg_Pflowers01
    g_Object[56] = CreateDynamicObject(817, 45.8508, 1127.1014, 19.1487, 0.0000, 0.0000, 0.0000); //veg_Pflowers01
    g_Object[57] = CreateDynamicObject(817, 45.8508, 1115.6206, 19.1487, 0.0000, 0.0000, 0.0000); //veg_Pflowers01
    g_Object[58] = CreateDynamicObject(638, 44.3232, 1115.4948, 19.0599, 0.0000, 0.0000, 0.0000); //kb_planter+bush
    g_Object[59] = CreateDynamicObject(638, 44.3232, 1126.6250, 19.0599, 0.0000, 0.0000, 0.0000); //kb_planter+bush
    g_Object[60] = CreateDynamicObject(638, 44.3232, 1128.7352, 19.0599, 0.0000, 0.0000, 0.0000); //kb_planter+bush
    g_Object[61] = CreateDynamicObject(638, 44.3232, 1130.1961, 19.0599, 0.0000, 0.0000, 0.0000); //kb_planter+bush
    g_Object[62] = CreateDynamicObject(1617, 50.2549, 1134.6019, 25.4909, 0.0000, 0.0000, -90.0000); //nt_aircon1_01
    g_Object[63] = CreateDynamicObject(19360, 40.9910, 1139.2746, 18.6532, 0.0000, 90.0000, 9.3000); //wall008
    SetDynamicObjectMaterial(g_Object[63], 0, 9515, "bigboxtemp1", "sf_concrete1", 0xFFFFFFFF);
    g_Object[64] = CreateDynamicObject(1420, 50.1316, 1126.5683, 29.8917, 0.0000, 0.0000, 0.0000); //DYN_AIRCON
    g_Object[65] = CreateDynamicObject(1215, 39.8975, 1141.1145, 20.2523, 0.0000, 0.0000, 0.0000); //bollardlight
    g_Object[66] = CreateDynamicObject(1215, 39.8975, 1134.1151, 20.2523, 0.0000, 0.0000, 0.0000); //bollardlight
    g_Object[67] = CreateDynamicObject(19429, 44.1091, 1146.1185, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[67], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[68] = CreateDynamicObject(19429, 40.8791, 1146.1185, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[68], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[69] = CreateDynamicObject(19429, 44.1091, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[69], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[70] = CreateDynamicObject(19429, 40.8791, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[70], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[71] = CreateDynamicObject(19429, 47.2092, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[71], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[72] = CreateDynamicObject(19429, 47.2092, 1146.2794, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[72], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[73] = CreateDynamicObject(19429, 50.4991, 1146.2794, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[73], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[74] = CreateDynamicObject(19429, 50.4990, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[74], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[75] = CreateDynamicObject(19429, 53.8091, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[75], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[76] = CreateDynamicObject(19429, 56.8991, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[76], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[77] = CreateDynamicObject(19429, 60.1991, 1143.7579, 17.9782, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[77], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[78] = CreateDynamicObject(19429, 60.1991, 1146.1395, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[78], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[79] = CreateDynamicObject(19429, 56.8991, 1146.1395, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[79], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[80] = CreateDynamicObject(19429, 53.8092, 1146.1395, 17.9682, 90.0000, 0.0000, 0.0000); //wall069
    SetDynamicObjectMaterial(g_Object[80], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[81] = CreateDynamicObject(1368, 40.0088, 1110.7065, 19.4319, 0.0000, 0.0000, 90.0000); //CJ_BLOCKER_BENCH
    SetDynamicObjectMaterial(g_Object[81], 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[81], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    g_Object[82] = CreateDynamicObject(1368, 42.4387, 1108.4564, 19.4319, 0.0000, 0.0000, 180.0000); //CJ_BLOCKER_BENCH
    SetDynamicObjectMaterial(g_Object[82], 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[82], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    g_Object[83] = CreateDynamicObject(1215, 39.8025, 1108.2115, 19.2889, 0.0000, 0.0000, 0.0000); //bollardlight
    g_Object[84] = CreateDynamicObject(710, 53.8911, 1106.7769, 23.3164, 0.0000, 0.0000, 0.0000); //vgs_palm01
    g_Object[85] = CreateDynamicObject(711, 40.4570, 1108.7916, 23.6695, 0.0000, 0.0000, 0.0000); //vgs_palm02
    g_Object[86] = CreateDynamicObject(18762, 40.4907, 1115.6373, 16.2819, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[86], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[87] = CreateDynamicObject(18762, 40.4907, 1108.8244, 16.2819, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[87], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[88] = CreateDynamicObject(18762, 40.4907, 1124.9586, 16.2819, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[88], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[89] = CreateDynamicObject(18762, 40.4907, 1132.6783, 16.2819, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[89], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[90] = CreateDynamicObject(18762, 40.1907, 1147.0498, 16.2819, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[90], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[91] = CreateDynamicObject(711, 40.4570, 1115.6125, 23.6695, 0.0000, 0.0000, 0.0000); //vgs_palm02
    g_Object[92] = CreateDynamicObject(711, 40.4570, 1124.9233, 23.6695, 0.0000, 0.0000, 0.0000); //vgs_palm02
    g_Object[93] = CreateDynamicObject(711, 40.4570, 1132.6546, 23.6695, 0.0000, 0.0000, 0.0000); //vgs_palm02
    g_Object[94] = CreateDynamicObject(711, 40.1670, 1147.0261, 23.6695, 0.0000, 0.0000, 0.0000); //vgs_palm02
    g_Object[95] = CreateDynamicObject(19175, 47.0238, 1120.0135, 28.5382, 0.0000, 0.0000, -90.0000); //SAMPPicture4
    SetDynamicObjectMaterialText(g_Object[95], 0, "Apartments", 90, "Arial", 48, 1, 0xFF000000, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[95], 1, " ", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[96] = CreateDynamicObject(1415, 62.9282, 1124.9425, 18.8537, 0.0000, 0.0000, 90.0000); //DYN_DUMPSTER

    LoadPier();
    LoadSomeMap();
    LoadBusStation();
}

stock LoadSomeMap()
{
    //Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////and Crayder////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Map Information////////////////////////////////////////////////////////////////////////////////////////////////
    /*
        Exported on "2018-05-24 20:25:01" by "Tyler"
        Created by "Tyler"
    */
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    new tmpobjid;
    tmpobjid = CreateDynamicObject(19462, 1131.128417, 1286.582641, -46.249668, 180.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1127.626831, 1286.582641, -46.249668, 180.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1132.950195, 1286.610229, -47.013725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1128.230102, 1291.480590, -47.013725, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1132.967651, 1286.602294, -43.573745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1128.236694, 1291.501098, -43.573745, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1127.627319, 1276.968750, -46.249668, 180.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1131.117431, 1276.968750, -46.249668, 180.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1121.117797, 1286.226928, -46.249668, 180.000000, 90.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1121.117797, 1289.687988, -46.249668, 180.000000, 90.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1111.547119, 1286.226928, -46.249668, 180.000000, 90.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1111.547119, 1289.686767, -46.249668, 180.000000, 90.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1127.627319, 1267.377807, -46.249668, 180.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 1131.117919, 1267.377807, -46.249668, 180.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14415, "carter_block_2", "mp_motel_carpet1", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1118.609008, 1291.480590, -47.013725, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1109.059448, 1291.480590, -47.013725, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1132.950195, 1277.020263, -47.013725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1132.950195, 1267.430541, -47.013725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1128.230102, 1262.648315, -47.013725, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, 1106.708740, 1286.610229, -47.013725, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1118.647460, 1291.501098, -43.573745, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 2, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 3, -1, "none", "none", 0xFF000000);
    SetDynamicObjectMaterial(tmpobjid, 5, -1, "none", "none", 0xFF000033);
    SetDynamicObjectMaterial(tmpobjid, 6, -1, "none", "none", 0xFF000000);
    tmpobjid = CreateDynamicObject(19449, 1109.028320, 1291.501098, -43.573745, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1106.698242, 1287.769531, -43.573745, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1132.967651, 1276.991699, -43.573745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1132.967651, 1267.411254, -43.573745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 1128.236694, 1262.627807, -43.573745, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19393, 1125.795410, 1267.510498, -44.423763, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1264.304443, -44.423728, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.795410, 1270.684814, -44.423728, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.784545, 1273.834960, -47.013721, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.784545, 1276.975463, -47.013721, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.784545, 1280.144653, -47.013721, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.784545, 1282.855957, -44.453723, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1124.153686, 1284.366821, -44.453723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19393, 1121.035522, 1284.352294, -44.423763, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1117.864379, 1284.366821, -44.453723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19393, 1114.704833, 1284.352294, -44.423763, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1111.494262, 1284.366821, -44.453723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1108.354492, 1284.366821, -44.453723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1264.304443, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1267.404418, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1270.553710, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1273.723388, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1276.872314, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1279.982666, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1125.785400, 1282.853393, -40.983730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1124.153686, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1120.983642, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1117.903686, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1114.753784, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1111.574340, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19364, 1108.374511, 1284.366821, -40.973735, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "sl_vicwall02", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1273.386230, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1275.656127, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1277.865966, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1280.066284, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1281.166748, -44.003719, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1277.396118, -44.003719, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1272.335205, -44.003719, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1273.386230, -42.783721, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1275.596069, -42.783721, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1277.835693, -42.783721, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.802368, 1280.125854, -42.783721, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19377, 1120.684326, 1279.677124, -46.263721, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1110.372436, 1279.677124, -46.263721, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1120.684326, 1270.107299, -46.263721, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1120.684326, 1260.597412, -46.263721, 0.000000, 90.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14786, "ab_sfgymbeams", "knot_wood128", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1120.923706, 1262.824584, -44.467792, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1116.172973, 1270.056152, -44.467792, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1111.402587, 1274.787231, -44.467792, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1116.172973, 1260.485839, -44.467792, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1108.912597, 1279.506958, -44.467792, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1116.164062, 1279.506958, -44.467792, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3653, "beachapts_lax", "eastwall4_LAe2", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1130.575927, 1277.076049, -41.753738, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1130.575927, 1287.475830, -41.753738, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1130.575927, 1267.065917, -41.753738, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1121.035522, 1287.475830, -41.753738, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1111.514770, 1287.475830, -41.753738, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1111.374633, 1279.093505, -42.733715, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1120.977661, 1279.093505, -42.733715, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1120.977661, 1268.913940, -42.733715, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 1120.977661, 1258.523681, -42.733715, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1273.386230, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19392, 1131.274902, 1288.222778, -44.603725, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1129.763183, 1289.895751, -44.613712, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 1131.453491, 1289.895751, -42.933700, 0.000000, 90.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 982, "bar_chainlink", "awirex2", 0x00000000);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1275.646606, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1277.926757, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1280.186889, -45.203723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1281.187744, -44.003723, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1277.407348, -44.003723, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19834, 1125.722290, 1272.347045, -44.003723, 0.000000, 90.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19175, 1116.276367, 1274.159667, -44.007804, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2655, "cj_banner", "CJ_MERC_LOGO", 0x00000000);
    tmpobjid = CreateDynamicObject(19174, 1126.678955, 1291.394653, -43.713764, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2811, "gb_ornaments01", "GB_photo01", 0x00000000);
    tmpobjid = CreateDynamicObject(19357, 1126.938354, 1291.486083, -44.003723, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterialText(tmpobjid, 0, "{000000} John & Mary Hilmore", 130, "Ariel", 50, 0, 0x00000000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(2254, 1116.307250, 1267.107177, -44.157779, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14420, "dr_gsbits", "mp_apt1_pic1", 0x00000000);
    tmpobjid = CreateDynamicObject(19466, 1120.817871, 1291.385009, -43.587814, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1116.447753, 1291.385009, -43.587814, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1111.896484, 1291.385009, -43.587814, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1106.835327, 1287.934570, -43.587814, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1132.866455, 1283.993774, -43.587814, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1132.866455, 1278.812622, -43.587814, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1132.866455, 1273.512329, -43.587814, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19466, 1132.866455, 1268.781860, -43.587814, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 4877, "downtown1_las", "GB_nastybar14", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19174, 1129.565673, 1262.773803, -43.553733, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14420, "dr_gsbits", "mp_apt1_pic6", 0x00000000);
    tmpobjid = CreateDynamicObject(2269, 1117.912597, 1283.793090, -44.647773, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14420, "dr_gsbits", "mp_apt1_pic7", 0x00000000);
    tmpobjid = CreateDynamicObject(1700, 1119.759277, 1269.759033, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_fabricRed", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1700, 1119.759277, 1264.157592, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_fabricRed", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1700, 1119.759277, 1277.308959, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_fabricRed", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1700, 1119.759277, 1281.729736, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_fabricRed", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(2612, 1111.754882, 1284.237426, -44.267799, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 7009, "vgndwntwn1", "newpolice_sa", 0x00000000);
    tmpobjid = CreateDynamicObject(1821, 1119.650024, 1277.311401, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1821, 1119.650024, 1281.761596, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1821, 1119.650024, 1269.820678, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1821, 1119.650024, 1264.160400, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    tmpobjid = CreateDynamicObject(1742, 1125.084594, 1283.904418, -46.177783, 0.000000, 0.000000, 315.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 2, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1109.818969, 1276.639282, -45.077796, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3187, "cxref_quarrytest", "gs_barge2", 0x00000000);
    tmpobjid = CreateDynamicObject(1535, 1110.723999, 1274.859741, -46.177783, 0.000000, 0.000000, 110.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    tmpobjid = CreateDynamicObject(1535, 1110.570190, 1276.687500, -46.177783, 0.000000, 0.000000, 110.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1109.818969, 1278.490844, -45.077796, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3187, "cxref_quarrytest", "gs_barge2", 0x00000000);
    tmpobjid = CreateDynamicObject(19427, 1109.818969, 1280.521606, -45.077796, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 3187, "cxref_quarrytest", "gs_barge2", 0x00000000);
    tmpobjid = CreateDynamicObject(1535, 1110.560791, 1278.557128, -46.177783, 0.000000, 0.000000, 110.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    tmpobjid = CreateDynamicObject(19174, 1116.041259, 1279.627685, -44.207786, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 2811, "gb_ornaments01", "GB_photo02", 0x00000000);
    tmpobjid = CreateDynamicObject(1499, 1113.920654, 1284.338623, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(19325, 1125.786499, 1274.086547, -44.103713, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19325, 1125.786499, 1280.727050, -44.103713, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1506, 1130.485351, 1291.343872, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19829, 1125.677490, 1268.793090, -44.957786, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19829, 1122.275512, 1284.273681, -44.957786, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(11721, 1116.365966, 1274.190551, -45.557777, 0.000000, 0.000000, 450.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(11721, 1125.616455, 1270.390258, -45.557777, 0.000000, 0.000000, 630.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(11710, 1131.258911, 1291.447753, -43.473739, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19787, 1125.759643, 1270.429809, -44.007778, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19997, 1116.908447, 1267.161865, -46.177783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19997, 1116.908447, 1280.042602, -46.177783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1722, 1118.381469, 1266.335083, -46.177783, 0.000000, 0.000000, 135.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1722, 1117.010009, 1272.286987, -46.177783, 0.000000, 0.000000, 211.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1125.136474, 1278.307983, -46.177783, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2162, 1122.995971, 1262.916625, -44.727798, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1123.736328, 1263.436401, -46.177783, 0.000000, 0.000000, 540.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2069, 1125.190917, 1263.372802, -46.137786, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2855, 1122.816528, 1263.087768, -44.697784, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2855, 1122.366088, 1263.087768, -44.247806, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1121.727294, 1274.483886, -42.987789, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1121.827392, 1268.072753, -42.987789, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1121.827392, 1278.232788, -42.987789, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1128.957275, 1278.232788, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1128.957275, 1271.602539, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1128.957275, 1265.751831, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1128.957275, 1286.532104, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1122.856323, 1288.322265, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1116.374877, 1288.322265, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2740, 1109.354980, 1288.322265, -42.007778, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2528, 1109.347412, 1279.317260, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2528, 1109.347412, 1277.545776, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2528, 1109.347412, 1275.624877, -46.177783, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2518, 1109.467773, 1283.697875, -46.177783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2518, 1111.078369, 1283.697875, -46.177783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2518, 1112.638427, 1283.697875, -46.177783, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1132.248535, 1278.307983, -46.177783, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1132.248535, 1269.857177, -46.177783, 0.000000, 0.000000, 270.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19929, 1126.760375, 1288.848632, -46.163730, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19925, 1128.593505, 1288.851928, -46.163730, 0.000000, 0.000000, 90.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19925, 1124.903808, 1288.851928, -46.163730, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(19893, 1126.764038, 1288.793334, -45.243724, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2894, 1127.598266, 1288.844848, -45.233745, 0.000000, 0.000000, 190.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1722, 1126.788574, 1290.697021, -46.163730, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1117.526733, 1290.728637, -46.177783, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(1723, 1112.885864, 1290.728637, -46.177783, 0.000000, 0.000000, 360.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2949, 1106.816528, 1284.778686, -46.163730, 0.000000, 0.000000, 180.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1132.536743, 1263.192871, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1132.536743, 1281.303344, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1124.145874, 1289.012573, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1116.174926, 1290.953369, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1125.604858, 1282.132446, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
    tmpobjid = CreateDynamicObject(2001, 1125.604858, 1271.791259, -46.163730, 0.000000, 0.000000, 0.000000, -1, -1, -1, 400.00, 400.00);
}

hook OnPlayerConnect(playerid)
{
    // Bus Station
    RemoveBuildingForPlayer(playerid, 16566, -222.1953, 979.2500, 17.3828, 0.25);
    RemoveBuildingForPlayer(playerid, 16752, 14.9766, 1225.5547, 20.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 16563, -222.1953, 979.2500, 17.3828, 0.25);
    RemoveBuildingForPlayer(playerid, 16738, -217.4922, 1026.8203, 27.6797, 0.25);
    RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
    RemoveBuildingForPlayer(playerid, 652, -8.0234, 1232.8516, 18.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 16562, 14.9766, 1225.5547, 20.5313, 0.25);

    // Impound Lot
    RemoveBuildingForPlayer(playerid, 16402, -318.2891, 2650.2422, 69.0156, 0.25);
    RemoveBuildingForPlayer(playerid, 16401, -271.9688, 2662.1953, 61.5859, 0.25);

    // Gas Pumps
	RemoveBuildingForPlayer(playerid, 1676, 1941.6563, -1767.2891, 14.1406, 6000.00);
	RemoveBuildingForPlayer(playerid, 3465, 2120.8203, 914.7188, 11.2578, 6000.00);
	RemoveBuildingForPlayer(playerid, 1686, -1610.6172, -2721.0000, 47.9297, 6000.00);

    // Fishing Spot
    RemoveBuildingForPlayer(playerid, 1506, -370.632, 1169.209, 19.257, 0.250);
    RemoveBuildingForPlayer(playerid, 3356, -369.921, 1173.550, 23.078, 0.250);
    RemoveBuildingForPlayer(playerid, 3358, -369.921, 1173.550, 23.078, 0.250);
    RemoveBuildingForPlayer(playerid, 3359, -362.062, 1198.660, 18.593, 0.250);
    RemoveBuildingForPlayer(playerid, 3360, -362.062, 1198.660, 18.593, 0.250);
    RemoveBuildingForPlayer(playerid, 16500, -360.765, 1194.260, 20.593, 0.250);
    return 1;
}

stock LoadBusStation()
{
    CreateDynamicObject(18274, 9.78480, 1237.88342, 18.31190,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1257, -4.05850, 1210.12622, 19.57750,   0.00000, 0.00000, 270.00000);
    CreateDynamicObject(8673, 33.00165, 1230.32886, 19.67195,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, 23.05770, 1241.06641, 19.67200,   0.00000, 0.00000, -4.38000);
    CreateDynamicObject(8673, 2.66318, 1241.86328, 19.67200,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, 2.66318, 1241.86328, 16.71943,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(8673, -7.78520, 1231.85938, 19.67200,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, -7.77850, 1218.88245, 19.67200,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, 33.00300, 1219.19409, 19.67200,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(8673, 2.67640, 1208.43616, 19.67200,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1257, -4.05848, 1217.45508, 19.57750,   0.00000, 0.00000, 270.00000);
    CreateDynamicObject(1257, -4.05845, 1225.21497, 19.57750,   0.00000, 0.00000, 270.00000);
    CreateDynamicObject(18234, 28.14189, 1229.68127, 18.31190,   0.00000, 0.00000, 0.00000);
}

stock LoadPier()
{
    CreateDynamicObject(11497, -367.480468, 1169.542968, 18.826969, 0.000000, 0.000000, -120.199989, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(2840, -366.410095, 1164.481079, 19.335163, 0.000000, 0.000000, 112.599975, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(1728, -370.151123, 1173.738647, 18.728548, 0.000000, 0.000000, -119.500015, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(660, -372.223846, 1175.922241, 18.848936, 0.000000, 0.000000, 173.299987, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(731, -373.835418, 1201.454467, 18.359228, 0.000000, 0.000000, 166.499969, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(3276, -379.389923, 1175.981323, 19.623937, 0.000000, 0.000000, -101.399993, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(3276, -373.491119, 1184.920166, 19.623937, 0.000000, 0.000000, -145.300033, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(3173, -365.583496, 1196.879150, 18.755918, 0.000000, 0.000000, -55.599967, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(3173, -351.383026, 1202.931640, 18.735918, 0.000000, 0.000000, -90.799949, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(19831, -360.324096, 1202.832763, 18.731945, 0.000000, 0.000000, 26.000007, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(11289, -363.415466, 1168.011230, 20.871139, 0.000000, 0.000000, 59.299991, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(864, -373.824737, 1180.706787, 18.974420, 0.000000, 0.000000, -90.800010, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(864, -372.236419, 1182.704956, 18.974420, 0.000000, 0.000000, 164.999938, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(862, -364.268920, 1182.777221, 18.731992, 0.000000, 0.000000, -140.300018, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(2241, -360.040313, 1197.708374, 19.212078, 0.000000, 0.000000, 174.000015, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(18268, -332.008178, 1204.394653, 40.479976, 0.000000, 0.000000, 119.499977, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(769, -374.389404, 1154.630249, 18.722013, 0.000000, 0.000000, 118.500007, -1, -1, -1, 300.00, 300.00);
    CreateDynamicObject(806, -362.568084, 1173.893554, 22.318702, 0.000000, 0.000000, 153.699890, -1, -1, -1, 300.00, 300.00);
    return 1;
}

stock LoadHospitalInterior()
{   
    new g_Object[407];
    g_Object[0] = CreateDynamicObject(19379, 1573.9041, 1615.4414, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[0], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[1] = CreateDynamicObject(19379, 1584.4050, 1586.5511, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[1], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[2] = CreateDynamicObject(18762, 1580.8514, 1593.4626, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[2], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[3] = CreateDynamicObject(19353, 1585.0328, 1598.7624, 9.2791, 0.0000, 0.0000, 0.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[3], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[4] = CreateDynamicObject(18762, 1585.0223, 1593.4626, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[4], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[5] = CreateDynamicObject(19353, 1582.9416, 1593.4499, 9.2791, 0.0000, 0.0000, 90.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[5], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[6] = CreateDynamicObject(18762, 1585.0223, 1600.8468, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[6], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[7] = CreateDynamicObject(19353, 1585.0328, 1595.5511, 15.0389, 0.0000, 0.0000, 0.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[7], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[8] = CreateDynamicObject(19353, 1585.0328, 1595.5511, 9.2791, 0.0000, 0.0000, 0.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[8], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[9] = CreateDynamicObject(19353, 1585.0328, 1598.7535, 15.0389, 0.0000, 0.0000, 0.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[9], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[10] = CreateDynamicObject(19325, 1585.0290, 1597.1606, 14.3288, 0.0000, 0.0000, 0.0000, -1, 1); //lsmall_window01
    g_Object[11] = CreateDynamicObject(19353, 1582.9217, 1593.4300, 14.9490, 0.0000, 0.0000, 90.0000, -1, 1); //wall001
    SetDynamicObjectMaterial(g_Object[11], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[12] = CreateDynamicObject(19325, 1581.8364, 1593.4105, 14.2742, 0.0000, 0.0000, 90.0000, -1, 1); //lsmall_window01
    g_Object[13] = CreateDynamicObject(19379, 1584.4068, 1586.5500, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[13], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[14] = CreateDynamicObject(19379, 1584.4050, 1596.1811, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[14], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[15] = CreateDynamicObject(19358, 1585.0367, 1599.3558, 12.0326, 0.0000, 0.0000, 0.0000, -1, 1); //wall006
    SetDynamicObjectMaterialText(g_Object[15], 0, "Front Desk", 90, "Arial", 15, 1, 0xFF840410, 0x0, 0);
    g_Object[16] = CreateDynamicObject(1239, 1585.0981, 1597.1462, 10.5218, 0.0000, 0.0000, 90.0000, -1, 1); //info
    g_Object[17] = CreateDynamicObject(19358, 1585.0373, 1597.9244, 12.7826, 0.0000, 0.0000, 0.0000, -1, 1); //wall006
    SetDynamicObjectMaterialText(g_Object[17], 0, "HOSPITAL", 90, "Arial", 35, 1, 0xFF840410, 0x0, 0);
    g_Object[18] = CreateDynamicObject(2165, 1584.4663, 1598.9333, 9.8515, 0.0000, 0.0000, -90.0000, -1, 1); //MED_OFFICE_DESK_1
    g_Object[19] = CreateDynamicObject(2165, 1584.4663, 1596.4333, 9.8515, 0.0000, 0.0000, -90.0000, -1, 1); //MED_OFFICE_DESK_1
    g_Object[20] = CreateDynamicObject(2165, 1583.0561, 1594.0218, 9.8515, 0.0000, 0.0000, 180.0000, -1, 1); //MED_OFFICE_DESK_1
    g_Object[21] = CreateDynamicObject(948, 1584.5019, 1599.8564, 9.8091, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_10
    g_Object[22] = CreateDynamicObject(948, 1584.5019, 1594.4824, 9.8091, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_10
    g_Object[23] = CreateDynamicObject(1714, 1582.4842, 1595.1317, 9.8443, 0.0000, 0.0000, 0.0000, -1, 1); //kb_swivelchair1
    g_Object[24] = CreateDynamicObject(1714, 1583.1048, 1596.0124, 9.8443, 0.0000, 0.0000, 90.0000, -1, 1); //kb_swivelchair1
    g_Object[25] = CreateDynamicObject(1714, 1583.1048, 1598.3635, 9.8443, 0.0000, 0.0000, 90.0000, -1, 1); //kb_swivelchair1
    g_Object[26] = CreateDynamicObject(19377, 1590.6330, 1596.2762, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[26], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[27] = CreateDynamicObject(19377, 1583.9587, 1584.6258, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[27], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[28] = CreateDynamicObject(19377, 1592.3586, 1601.0655, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[28], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[29] = CreateDynamicObject(19377, 1590.6330, 1586.6446, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[29], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[30] = CreateDynamicObject(19379, 1594.8977, 1596.1811, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[30], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[31] = CreateDynamicObject(19379, 1594.8977, 1586.5588, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[31], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[32] = CreateDynamicObject(1811, 1590.0101, 1590.4283, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[33] = CreateDynamicObject(1811, 1590.0101, 1589.5080, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[34] = CreateDynamicObject(1811, 1590.0101, 1588.5871, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[35] = CreateDynamicObject(1811, 1590.0101, 1587.6462, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[36] = CreateDynamicObject(1811, 1590.0101, 1586.7054, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[37] = CreateDynamicObject(1811, 1588.6689, 1585.1839, 10.4742, 0.0000, 0.0000, -90.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[38] = CreateDynamicObject(1811, 1587.7181, 1585.1839, 10.4742, 0.0000, 0.0000, -90.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[39] = CreateDynamicObject(1811, 1586.7972, 1585.1839, 10.4742, 0.0000, 0.0000, -90.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[40] = CreateDynamicObject(1811, 1585.8767, 1585.1839, 10.4742, 0.0000, 0.0000, -90.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[41] = CreateDynamicObject(1811, 1584.9460, 1585.1839, 10.4742, 0.0000, 0.0000, -90.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[42] = CreateDynamicObject(1811, 1587.7087, 1587.7060, 10.4742, 0.0000, 0.0000, 180.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[43] = CreateDynamicObject(1811, 1587.7087, 1588.5969, 10.4742, 0.0000, 0.0000, 180.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[44] = CreateDynamicObject(1811, 1587.7087, 1589.4875, 10.4742, 0.0000, 0.0000, 180.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[45] = CreateDynamicObject(1811, 1586.7878, 1589.4875, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[46] = CreateDynamicObject(1811, 1586.7878, 1588.5969, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[47] = CreateDynamicObject(1811, 1586.7878, 1587.7060, 10.4742, 0.0000, 0.0000, 0.0000, -1, 1); //MED_DIN_CHAIR_5
    g_Object[48] = CreateDynamicObject(1823, 1589.4654, 1584.9670, 9.8062, 0.0000, 0.0000, 0.0000, -1, 1); //COFFEE_MED_5
    SetDynamicObjectMaterial(g_Object[48], 0, 14652, "ab_trukstpa", "CJ_WOOD1(EDGE)", 0xFFFFFFFF);
    g_Object[49] = CreateDynamicObject(1742, 1583.8685, 1584.5705, 9.8491, 0.0000, 0.0000, 180.0000, -1, 1); //Med_BOOKSHELF
    g_Object[50] = CreateDynamicObject(19377, 1580.8686, 1583.9730, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[50], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[51] = CreateDynamicObject(2852, 1590.1081, 1585.4543, 10.2958, 0.0000, 0.0000, 0.0000, -1, 1); //gb_bedmags02
    g_Object[52] = CreateDynamicObject(2855, 1589.7921, 1585.5660, 9.8774, 0.0000, 0.0000, 0.0000, -1, 1); //gb_bedmags05
    g_Object[53] = CreateDynamicObject(19835, 1589.5246, 1585.3171, 10.3985, 0.0000, 0.0000, 0.0000, -1, 1); //CoffeeCup1
    g_Object[54] = CreateDynamicObject(18762, 1580.8514, 1589.2822, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[54], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[55] = CreateDynamicObject(19377, 1593.5920, 1584.6258, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[55], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[56] = CreateDynamicObject(19377, 1580.8586, 1588.7269, 18.5720, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[56], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[57] = CreateDynamicObject(1775, 1581.4305, 1587.9095, 10.9455, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_SPRUNK1
    g_Object[58] = CreateDynamicObject(1209, 1581.2165, 1586.4863, 9.8599, 0.0000, 0.0000, 90.0000, -1, 1); //vendmach
    g_Object[59] = CreateDynamicObject(2010, 1581.4272, 1585.1595, 9.8429, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant3_ofc
    g_Object[60] = CreateDynamicObject(19383, 1580.8570, 1591.3758, 11.5964, 0.0000, 0.0000, 0.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[60], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[61] = CreateDynamicObject(19377, 1582.7275, 1601.0655, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[61], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[62] = CreateDynamicObject(19379, 1594.8974, 1596.1811, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[62], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[63] = CreateDynamicObject(19379, 1573.9041, 1596.1811, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[63], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[64] = CreateDynamicObject(19458, 1590.6135, 1586.5903, 15.9799, 0.0000, 0.0000, 0.0000, -1, 1); //wall098
    SetDynamicObjectMaterial(g_Object[64], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[65] = CreateDynamicObject(19458, 1590.6135, 1596.2209, 15.9799, 0.0000, 0.0000, 0.0000, -1, 1); //wall098
    SetDynamicObjectMaterial(g_Object[65], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[66] = CreateDynamicObject(19458, 1590.3032, 1601.0537, 15.9799, 0.0000, 0.0000, 90.0000, -1, 1); //wall098
    SetDynamicObjectMaterial(g_Object[66], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[67] = CreateDynamicObject(19458, 1585.7113, 1584.6523, 15.9799, 0.0000, 0.0000, 90.0000, -1, 1); //wall098
    SetDynamicObjectMaterial(g_Object[67], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[68] = CreateDynamicObject(19458, 1580.8702, 1588.1853, 15.9799, 0.0000, 0.0000, 0.0000, -1, 1); //wall098
    SetDynamicObjectMaterial(g_Object[68], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[69] = CreateDynamicObject(19377, 1594.9626, 1601.0483, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[69], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[70] = CreateDynamicObject(19377, 1590.6230, 1605.3697, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[70], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[71] = CreateDynamicObject(19377, 1594.9626, 1584.6440, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[71], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[72] = CreateDynamicObject(19377, 1590.6312, 1580.2635, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[72], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[73] = CreateDynamicObject(19377, 1580.8697, 1580.2635, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[73], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[74] = CreateDynamicObject(19377, 1576.4593, 1584.6455, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[74], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[75] = CreateDynamicObject(1569, 1590.5909, 1595.6468, 9.8303, 0.0000, 0.0000, 90.0000, -1, 1); //ADAM_V_DOOR
    g_Object[76] = CreateDynamicObject(1569, 1590.5810, 1598.6285, 9.8303, 0.0000, 0.0000, -90.0000, -1, 1); //ADAM_V_DOOR
    g_Object[77] = CreateDynamicObject(2261, 1588.4311, 1585.2104, 11.9895, 0.0000, 0.0000, 180.0000, -1, 1); //Frame_SLIM_2
    g_Object[78] = CreateDynamicObject(19361, 1590.6230, 1597.1313, 10.6954, 0.0000, 0.0000, 0.0000, -1, 1); //wall009
    SetDynamicObjectMaterial(g_Object[78], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[79] = CreateDynamicObject(2260, 1585.7204, 1585.1822, 12.0635, 0.0000, 0.0000, 180.0000, -1, 1); //Frame_SLIM_1
    g_Object[80] = CreateDynamicObject(2262, 1590.0605, 1587.1423, 12.0052, 0.0000, 0.0000, -90.0000, -1, 1); //Frame_SLIM_3
    g_Object[81] = CreateDynamicObject(2264, 1590.0445, 1590.3619, 12.8135, 0.0000, 0.0000, -90.0000, -1, 1); //Frame_SLIM_5
    g_Object[82] = CreateDynamicObject(2265, 1590.0627, 1589.4831, 11.6915, 0.0000, 0.0000, -90.0000, -1, 1); //Frame_SLIM_6
    g_Object[83] = CreateDynamicObject(19379, 1573.9049, 1586.5511, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[83], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[84] = CreateDynamicObject(19379, 1573.9049, 1596.1834, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[84], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[85] = CreateDynamicObject(19383, 1577.7247, 1589.2557, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[85], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[86] = CreateDynamicObject(19377, 1576.5577, 1598.2955, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[86], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[87] = CreateDynamicObject(19429, 1580.1269, 1593.4249, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[87], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[88] = CreateDynamicObject(19377, 1581.4062, 1601.0555, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[88], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[89] = CreateDynamicObject(19429, 1580.1269, 1593.4249, 15.0623, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[89], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[90] = CreateDynamicObject(19360, 1577.7297, 1593.4232, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[90], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[91] = CreateDynamicObject(18762, 1576.7298, 1600.8940, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[91], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[92] = CreateDynamicObject(2164, 1576.6556, 1598.1756, 9.8512, 0.0000, 0.0000, 90.0000, -1, 1); //MED_OFFICE_UNIT_5
    g_Object[93] = CreateDynamicObject(2161, 1576.6605, 1595.8541, 9.8499, 0.0000, 0.0000, 90.0000, -1, 1); //MED_OFFICE_UNIT_4
    g_Object[94] = CreateDynamicObject(2161, 1576.6605, 1595.8541, 11.1998, 0.0000, 0.0000, 90.0000, -1, 1); //MED_OFFICE_UNIT_4
    g_Object[95] = CreateDynamicObject(2162, 1578.6395, 1600.9885, 11.2489, 0.0000, 0.0000, 0.0000, -1, 1); //MED_OFFICE_UNIT_1
    g_Object[96] = CreateDynamicObject(2163, 1581.6253, 1600.9924, 11.2678, 0.0000, 0.0000, 0.0000, -1, 1); //MED_OFFICE_UNIT_2
    g_Object[97] = CreateDynamicObject(2001, 1577.5676, 1600.1259, 9.8322, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant_ofc
    g_Object[98] = CreateDynamicObject(2001, 1579.8586, 1593.9454, 9.8322, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant_ofc
    g_Object[99] = CreateDynamicObject(19379, 1573.9041, 1586.5477, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[99], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[100] = CreateDynamicObject(19383, 1574.3520, 1589.2557, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[100], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[101] = CreateDynamicObject(19429, 1580.1269, 1589.2547, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[101], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[102] = CreateDynamicObject(19429, 1580.1269, 1589.2524, 15.0623, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[102], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[103] = CreateDynamicObject(19360, 1577.7297, 1589.2429, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[103], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[104] = CreateDynamicObject(2514, 1580.2838, 1587.8347, 9.8450, 0.0000, 0.0000, -90.0000, -1, 1); //CJ_TOILET1
    g_Object[105] = CreateDynamicObject(2514, 1580.2838, 1586.0030, 9.8450, 0.0000, 0.0000, -90.0000, -1, 1); //CJ_TOILET1
    g_Object[106] = CreateDynamicObject(19429, 1579.9968, 1586.9631, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[106], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[107] = CreateDynamicObject(19873, 1580.7136, 1587.7169, 10.8397, 0.0000, 0.0000, 0.0000, -1, 1); //ToiletPaperRoll1
    g_Object[108] = CreateDynamicObject(19873, 1580.7136, 1585.8856, 10.8397, 0.0000, 0.0000, 0.0000, -1, 1); //ToiletPaperRoll1
    g_Object[109] = CreateDynamicObject(2518, 1576.6301, 1587.4675, 10.0757, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_B_SINK2
    g_Object[110] = CreateDynamicObject(2518, 1576.6301, 1585.6057, 10.0757, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_B_SINK2
    g_Object[111] = CreateDynamicObject(19377, 1576.0351, 1584.5135, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[111], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[112] = CreateDynamicObject(19360, 1574.6506, 1593.4332, 11.5988, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[112], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[113] = CreateDynamicObject(19360, 1574.3564, 1589.2429, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[113], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[114] = CreateDynamicObject(2518, 1579.9162, 1587.8631, 17.3290, 0.0000, 0.0000, 0.0000, -1, 1); //CJ_B_SINK2
    g_Object[115] = CreateDynamicObject(2518, 1575.4189, 1586.4361, 10.0757, 0.0000, 0.0000, -90.0000, -1, 1); //CJ_B_SINK2
    g_Object[116] = CreateDynamicObject(2518, 1575.4189, 1588.3875, 10.0757, 0.0000, 0.0000, -90.0000, -1, 1); //CJ_B_SINK2
    g_Object[117] = CreateDynamicObject(2514, 1571.8370, 1587.8347, 9.8450, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_TOILET1
    g_Object[118] = CreateDynamicObject(19429, 1571.9530, 1589.2547, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[118], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[119] = CreateDynamicObject(19429, 1571.9530, 1589.2524, 15.0623, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[119], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[120] = CreateDynamicObject(19377, 1571.2347, 1584.5135, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[120], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[121] = CreateDynamicObject(2514, 1571.8370, 1586.0438, 9.8450, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_TOILET1
    g_Object[122] = CreateDynamicObject(19429, 1572.1025, 1586.9631, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[122], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[123] = CreateDynamicObject(19359, 1574.4128, 1584.6683, 11.5857, 0.0000, 0.0000, 90.0000, -1, 1); //wall007
    SetDynamicObjectMaterial(g_Object[123], 0, 10988, "mission2_sfse", "ws_fancywallpink", 0xFFFFFFFF);
    g_Object[124] = CreateDynamicObject(19359, 1572.8615, 1584.6583, 11.5857, 0.0000, 0.0000, 90.0000, -1, 1); //wall007
    SetDynamicObjectMaterial(g_Object[124], 0, 10988, "mission2_sfse", "ws_fancywallpink", 0xFFFFFFFF);
    g_Object[125] = CreateDynamicObject(19359, 1577.6749, 1584.6683, 11.5857, 0.0000, 0.0000, 90.0000, -1, 1); //wall007
    SetDynamicObjectMaterial(g_Object[125], 0, 17547, "eastbeach4a_lae2", "bluestucco1", 0xFFFFFFFF);
    g_Object[126] = CreateDynamicObject(19359, 1579.2058, 1584.6583, 11.5857, 0.0000, 0.0000, 90.0000, -1, 1); //wall007
    SetDynamicObjectMaterial(g_Object[126], 0, 17547, "eastbeach4a_lae2", "bluestucco1", 0xFFFFFFFF);
    g_Object[127] = CreateDynamicObject(19379, 1563.4030, 1586.5477, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[127], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[128] = CreateDynamicObject(19379, 1562.7247, 1579.9816, 13.4207, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[128], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[129] = CreateDynamicObject(19379, 1573.9049, 1605.8040, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[129], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[130] = CreateDynamicObject(19379, 1563.4144, 1605.8040, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[130], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[131] = CreateDynamicObject(19379, 1563.4144, 1596.1739, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[131], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[132] = CreateDynamicObject(19379, 1563.4144, 1586.5428, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[132], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[133] = CreateDynamicObject(19360, 1574.5305, 1593.4232, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[133], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[134] = CreateDynamicObject(19360, 1574.5305, 1593.4232, 11.5988, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[134], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[135] = CreateDynamicObject(19383, 1577.7247, 1593.4277, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[135], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[136] = CreateDynamicObject(19360, 1571.3209, 1593.4232, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[136], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[137] = CreateDynamicObject(19377, 1576.2874, 1598.2755, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[137], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[138] = CreateDynamicObject(19377, 1566.5207, 1598.2755, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[138], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[139] = CreateDynamicObject(19360, 1568.1175, 1593.4232, 11.5988, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[139], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[140] = CreateDynamicObject(19360, 1568.1196, 1593.4232, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[140], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[141] = CreateDynamicObject(1997, 1575.1407, 1595.0876, 9.8410, 0.0000, 0.0000, -90.0000, -1, 1); //hos_trolley
    g_Object[142] = CreateDynamicObject(1997, 1575.1407, 1597.9593, 9.8410, 0.0000, 0.0000, -90.0000, -1, 1); //hos_trolley
    g_Object[143] = CreateDynamicObject(1997, 1575.1407, 1600.7514, 9.8410, 0.0000, 0.0000, -90.0000, -1, 1); //hos_trolley
    g_Object[144] = CreateDynamicObject(3386, 1575.7722, 1596.0418, 7.7410, 0.0000, 0.0000, 0.0000, -1, 1); //a51_srack2_
    g_Object[145] = CreateDynamicObject(3386, 1575.7722, 1598.9237, 7.7410, 0.0000, 0.0000, 0.0000, -1, 1); //a51_srack2_
    g_Object[146] = CreateDynamicObject(3386, 1575.7722, 1601.7152, 7.7410, 0.0000, 0.0000, 0.0000, -1, 1); //a51_srack2_
    g_Object[147] = CreateDynamicObject(2558, 1574.7640, 1599.1018, 10.9940, 0.0000, 0.0000, 0.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[148] = CreateDynamicObject(2558, 1574.7640, 1596.2099, 10.9940, 0.0000, 0.0000, 0.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[149] = CreateDynamicObject(2558, 1575.7650, 1597.0008, 10.9940, 0.0000, 0.0000, 180.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[150] = CreateDynamicObject(2558, 1575.7650, 1599.8923, 10.9940, 0.0000, 0.0000, 180.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[151] = CreateDynamicObject(2558, 1568.0511, 1599.8923, 10.9940, 0.0000, 0.0000, 180.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[152] = CreateDynamicObject(2558, 1568.0511, 1597.0096, 10.9940, 0.0000, 0.0000, 180.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[153] = CreateDynamicObject(2558, 1567.0404, 1596.2197, 10.9940, 0.0000, 0.0000, 0.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[154] = CreateDynamicObject(2558, 1567.0404, 1599.1015, 10.9940, 0.0000, 0.0000, 0.0000, -1, 1); //CURTAIN_1_CLOSED
    g_Object[155] = CreateDynamicObject(1997, 1567.6566, 1595.0876, 9.8410, 0.0000, 0.0000, 90.0000, -1, 1); //hos_trolley
    g_Object[156] = CreateDynamicObject(1997, 1567.6566, 1597.9488, 9.8410, 0.0000, 0.0000, 90.0000, -1, 1); //hos_trolley
    g_Object[157] = CreateDynamicObject(1997, 1567.6566, 1600.7209, 9.8410, 0.0000, 0.0000, 90.0000, -1, 1); //hos_trolley
    g_Object[158] = CreateDynamicObject(3386, 1567.0083, 1601.7152, 7.7410, 0.0000, 0.0000, 180.0000, -1, 1); //a51_srack2_
    g_Object[159] = CreateDynamicObject(3386, 1567.0083, 1598.9229, 7.7410, 0.0000, 0.0000, 180.0000, -1, 1); //a51_srack2_
    g_Object[160] = CreateDynamicObject(3386, 1567.0083, 1596.0709, 7.7410, 0.0000, 0.0000, 180.0000, -1, 1); //a51_srack2_
    g_Object[161] = CreateDynamicObject(19377, 1571.3929, 1603.1358, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[161], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[162] = CreateDynamicObject(19383, 1571.3225, 1593.4277, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[162], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[163] = CreateDynamicObject(11736, 1567.0898, 1595.8023, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[164] = CreateDynamicObject(11736, 1567.0898, 1598.6445, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[165] = CreateDynamicObject(11736, 1567.0898, 1601.4555, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[166] = CreateDynamicObject(11736, 1575.7833, 1601.4555, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[167] = CreateDynamicObject(11736, 1575.7833, 1598.6538, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[168] = CreateDynamicObject(11736, 1575.7833, 1595.7916, 10.7667, 0.0000, 0.0000, 0.0000, -1, 1); //MedicalSatchel1
    g_Object[169] = CreateDynamicObject(11738, 1575.5959, 1596.2337, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    g_Object[170] = CreateDynamicObject(11738, 1575.5959, 1599.1057, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    g_Object[171] = CreateDynamicObject(11738, 1575.5959, 1601.8972, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    g_Object[172] = CreateDynamicObject(11738, 1567.2143, 1601.8972, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    g_Object[173] = CreateDynamicObject(11738, 1567.2143, 1599.1145, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    g_Object[174] = CreateDynamicObject(11738, 1567.2143, 1596.2723, 10.7739, 0.0000, 0.0000, 90.0000, -1, 1); //MedicCase1
    //g_Object[175] = CreateDynamicObject(1499, 1576.9510, 1589.2623, 9.8353, 0.0000, 0.0000, 0.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[175], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[175], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[176] = CreateDynamicObject(1499, 1573.5786, 1589.2623, 9.8353, 0.0000, 0.0000, 0.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[176], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[176], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[177] = CreateDynamicObject(1856, 1577.7108, 1589.3366, 12.6731, 0.0000, 90.0000, 90.0000, -1, 1); //pkr_chp_hi02
    SetDynamicObjectMaterial(g_Object[177], 0, 17547, "eastbeach4a_lae2", "bluestucco1", 0xFFFFFFFF);
    g_Object[178] = CreateDynamicObject(1856, 1574.3387, 1589.3366, 12.6932, 0.0000, 90.0000, 90.0000, -1, 1); //pkr_chp_hi02
    SetDynamicObjectMaterial(g_Object[178], 0, 10988, "mission2_sfse", "ws_fancywallpink", 0xFFFFFFFF);
    g_Object[179] = CreateDynamicObject(1499, 1576.9510, 1593.4038, 9.8353, 0.0000, 0.0000, 0.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[179], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[179], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[180] = CreateDynamicObject(1499, 1570.5466, 1593.4038, 9.8353, 0.0000, 0.0000, 0.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[180], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[180], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[181] = CreateDynamicObject(19379, 1557.5308, 1604.5093, 13.4104, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[181], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[182] = CreateDynamicObject(19379, 1575.5958, 1584.4969, 13.3905, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[182], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[183] = CreateDynamicObject(19433, 1566.5238, 1597.9995, 9.4951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[183], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[184] = CreateDynamicObject(19433, 1566.5238, 1597.9995, 12.9951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[184], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[185] = CreateDynamicObject(19433, 1566.5238, 1600.8513, 9.4951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[185], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[186] = CreateDynamicObject(19433, 1566.5238, 1600.8513, 9.4951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[186], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[187] = CreateDynamicObject(19433, 1566.5238, 1600.8513, 12.9951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[187], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[188] = CreateDynamicObject(19433, 1566.5238, 1595.1379, 12.9951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[188], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[189] = CreateDynamicObject(19433, 1566.5238, 1595.1379, 9.4951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[189], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[190] = CreateDynamicObject(19433, 1576.2849, 1595.1379, 9.4951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[190], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[191] = CreateDynamicObject(19433, 1576.2849, 1595.1379, 12.9951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[191], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[192] = CreateDynamicObject(19433, 1576.2849, 1598.0299, 12.9951, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[192], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[193] = CreateDynamicObject(19433, 1576.2849, 1598.0299, 9.5151, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[193], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[194] = CreateDynamicObject(19433, 1576.2849, 1600.9013, 9.5151, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[194], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[195] = CreateDynamicObject(19433, 1576.2849, 1600.9013, 13.0051, 0.0000, 0.0000, 0.0000, -1, 1); //wall073
    SetDynamicObjectMaterial(g_Object[195], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[196] = CreateDynamicObject(2267, 1567.8446, 1603.0251, 12.0940, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_WOOD_3
    g_Object[197] = CreateDynamicObject(2270, 1569.9700, 1602.5451, 11.7456, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_WOOD_6
    g_Object[198] = CreateDynamicObject(2270, 1570.5206, 1602.5451, 12.1556, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_WOOD_6
    g_Object[199] = CreateDynamicObject(2270, 1571.0811, 1602.5451, 11.7455, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_WOOD_6
    g_Object[200] = CreateDynamicObject(2266, 1572.1687, 1602.5612, 11.7747, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_WOOD_5
    g_Object[201] = CreateDynamicObject(2283, 1573.8604, 1603.0239, 11.9862, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_Thick_3
    g_Object[202] = CreateDynamicObject(2240, 1572.5107, 1602.6622, 10.3717, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_8
    g_Object[203] = CreateDynamicObject(2243, 1571.8041, 1602.7280, 10.0873, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_6
    g_Object[204] = CreateDynamicObject(19172, 1571.7988, 1593.3514, 12.1812, 0.0000, 0.0000, 0.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[204], 0, "Operations room", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[204], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[205] = CreateDynamicObject(19383, 1565.2880, 1592.3992, 11.5964, 0.0000, 0.0000, -50.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[205], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[206] = CreateDynamicObject(19172, 1578.5423, 1593.3514, 12.1812, 0.0000, 0.0000, 0.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[206], 0, "Front desk", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[206], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[207] = CreateDynamicObject(19360, 1565.2883, 1592.3961, 15.0888, 0.0000, 0.0000, -50.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[207], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[208] = CreateDynamicObject(19377, 1557.8200, 1592.3646, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[208], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[209] = CreateDynamicObject(19429, 1563.3417, 1591.8868, 11.6023, 0.0000, 0.0000, 50.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[209], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[210] = CreateDynamicObject(19429, 1563.3417, 1591.8868, 15.0823, 0.0000, 0.0000, 50.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[210], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[211] = CreateDynamicObject(19383, 1562.6981, 1594.0487, 11.5964, 0.0000, 0.0000, 0.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[211], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[212] = CreateDynamicObject(19377, 1557.1894, 1594.7739, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[212], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[213] = CreateDynamicObject(19377, 1557.8200, 1598.9536, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[213], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[214] = CreateDynamicObject(19360, 1562.6968, 1594.0477, 15.0888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[214], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[215] = CreateDynamicObject(19360, 1562.6968, 1597.2593, 15.0888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[215], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[216] = CreateDynamicObject(19360, 1562.6968, 1597.2593, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[216], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[217] = CreateDynamicObject(19379, 1552.9122, 1596.1739, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[217], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[218] = CreateDynamicObject(1997, 1561.6452, 1598.6546, 10.2966, 0.0000, 90.0000, -103.4000, -1, 1); //hos_trolley
    g_Object[219] = CreateDynamicObject(926, 1562.1643, 1596.9984, 10.1094, 0.0000, 0.0000, 0.0000, -1, 1); //RUBBISH_BOX2
    g_Object[220] = CreateDynamicObject(1221, 1559.9692, 1598.3092, 10.3021, 0.0000, 0.0000, 0.0000, -1, 1); //cardboardbox4
    g_Object[221] = CreateDynamicObject(1221, 1558.9382, 1598.3092, 10.3021, 0.0000, 0.0000, 0.0000, -1, 1); //cardboardbox4
    g_Object[222] = CreateDynamicObject(1230, 1559.4239, 1598.2445, 11.1486, 0.0000, 0.0000, 0.0000, -1, 1); //cardboardbox
    g_Object[223] = CreateDynamicObject(3630, 1554.0733, 1593.9969, 11.3266, 0.0000, 0.0000, 180.0000, -1, 1); //crdboxes2_LAs
    g_Object[224] = CreateDynamicObject(1778, 1566.1784, 1596.6236, 9.8693, 0.0000, 0.0000, 0.0000, -1, 1); //CJ_MOP_PAIL
    g_Object[225] = CreateDynamicObject(19587, 1557.6917, 1596.0180, 10.2745, 0.1999, 48.0999, 0.0000, -1, 1); //PlasticTray1
    g_Object[226] = CreateDynamicObject(19622, 1559.8587, 1592.5726, 10.5260, 10.2999, -0.3999, 0.0000, -1, 1); //Broom1
    g_Object[227] = CreateDynamicObject(19816, 1558.9010, 1593.5018, 10.1079, 0.0000, 0.0000, 0.0000, -1, 1); //OxygenCylinder1
    g_Object[228] = CreateDynamicObject(19816, 1558.9010, 1593.6820, 10.1079, 0.0000, 0.0000, 0.0000, -1, 1); //OxygenCylinder1
    g_Object[229] = CreateDynamicObject(19816, 1558.9010, 1593.8721, 10.1079, 0.0000, 0.0000, 0.0000, -1, 1); //OxygenCylinder1
    g_Object[230] = CreateDynamicObject(11713, 1568.1705, 1593.3305, 11.5584, 0.0000, 0.0000, -90.0000, -1, 1); //FireExtPanel1
    g_Object[231] = CreateDynamicObject(19360, 1562.6968, 1600.4710, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[231], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[232] = CreateDynamicObject(19360, 1562.6968, 1600.4710, 15.0788, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[232], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[233] = CreateDynamicObject(1620, 1576.1771, 1598.0224, 13.6235, 0.0000, 0.0000, 0.0000, -1, 1); //nt_vent2_01
    g_Object[234] = CreateDynamicObject(1620, 1579.8272, 1600.9639, 13.6535, 0.0000, 0.0000, 90.0000, -1, 1); //nt_vent2_01
    g_Object[235] = CreateDynamicObject(1620, 1568.1297, 1593.3316, 13.6370, 0.0000, 0.0000, 90.0000, -1, 1); //nt_vent2_01
    g_Object[236] = CreateDynamicObject(19383, 1562.6981, 1606.0344, 11.5964, 0.0000, 0.0000, 0.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[236], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[237] = CreateDynamicObject(19360, 1562.7069, 1602.8320, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[237], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[238] = CreateDynamicObject(19360, 1562.7069, 1602.8320, 15.0889, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[238], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[239] = CreateDynamicObject(19360, 1562.6968, 1606.0335, 15.0788, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[239], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[240] = CreateDynamicObject(19377, 1562.6993, 1612.4465, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[240], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[241] = CreateDynamicObject(19379, 1552.9139, 1605.8040, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[241], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[242] = CreateDynamicObject(19379, 1552.9139, 1615.4361, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[242], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[243] = CreateDynamicObject(19379, 1563.4042, 1615.4361, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[243], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[244] = CreateDynamicObject(19360, 1562.6868, 1602.8320, 15.0789, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[244], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[245] = CreateDynamicObject(19377, 1557.7900, 1599.6525, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[245], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[246] = CreateDynamicObject(19360, 1562.6868, 1602.8320, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[246], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[247] = CreateDynamicObject(19360, 1562.6868, 1606.0423, 15.0689, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[247], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[248] = CreateDynamicObject(19377, 1562.6900, 1612.4548, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[248], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[249] = CreateDynamicObject(19360, 1562.6768, 1601.3205, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[249], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[250] = CreateDynamicObject(19360, 1562.6768, 1601.3205, 15.0788, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[250], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[251] = CreateDynamicObject(19383, 1561.0073, 1603.6530, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[251], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[252] = CreateDynamicObject(19383, 1557.8061, 1603.6530, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[252], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[253] = CreateDynamicObject(19383, 1554.5961, 1603.6530, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[253], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[254] = CreateDynamicObject(19383, 1560.9992, 1608.3959, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[254], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[255] = CreateDynamicObject(19383, 1557.7895, 1608.3959, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[255], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[256] = CreateDynamicObject(19383, 1554.5781, 1608.3959, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[256], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[257] = CreateDynamicObject(19377, 1552.8891, 1604.5584, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[257], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[258] = CreateDynamicObject(19377, 1552.8891, 1614.1900, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[258], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[259] = CreateDynamicObject(19377, 1557.7900, 1612.5039, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[259], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[260] = CreateDynamicObject(19377, 1556.1517, 1613.1510, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[260], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[261] = CreateDynamicObject(19377, 1559.3719, 1613.1409, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[261], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[262] = CreateDynamicObject(19360, 1556.2056, 1601.9625, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[262], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[263] = CreateDynamicObject(19360, 1559.3951, 1601.9725, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[263], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[264] = CreateDynamicObject(19429, 1556.2087, 1599.7473, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[264], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[265] = CreateDynamicObject(19429, 1559.4008, 1599.7473, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[265], 0, 4835, "airoads_las", "easykerb", 0xFFFFFFFF);
    g_Object[266] = CreateDynamicObject(19379, 1557.5308, 1614.1392, 13.4104, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[266], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[267] = CreateDynamicObject(19379, 1573.9041, 1605.8106, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[267], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[268] = CreateDynamicObject(1997, 1560.0136, 1600.8198, 9.8447, 0.0000, 0.0000, 180.0000, -1, 1); //hos_trolley
    g_Object[269] = CreateDynamicObject(1997, 1556.8308, 1600.8198, 9.8447, 0.0000, 0.0000, 180.0000, -1, 1); //hos_trolley
    g_Object[270] = CreateDynamicObject(1997, 1553.5291, 1600.8198, 9.8447, 0.0000, 0.0000, 180.0000, -1, 1); //hos_trolley
    g_Object[271] = CreateDynamicObject(1997, 1553.5291, 1611.3347, 9.8447, 0.0000, 0.0000, 0.0000, -1, 1); //hos_trolley
    g_Object[272] = CreateDynamicObject(1997, 1556.7907, 1611.3347, 9.8447, 0.0000, 0.0000, 0.0000, -1, 1); //hos_trolley
    g_Object[273] = CreateDynamicObject(1997, 1559.9934, 1611.3347, 9.8447, 0.0000, 0.0000, 0.0000, -1, 1); //hos_trolley
    g_Object[274] = CreateDynamicObject(1499, 1562.7137, 1593.3125, 9.8353, 0.0000, 0.0000, 90.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[274], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[274], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[275] = CreateDynamicObject(19360, 1564.3869, 1608.5122, 11.5888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[275], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[276] = CreateDynamicObject(19360, 1564.3869, 1608.5122, 15.0888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[276], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[277] = CreateDynamicObject(19377, 1568.0432, 1584.5135, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[277], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[278] = CreateDynamicObject(19172, 1562.7756, 1594.7327, 12.1812, 0.0000, 0.0000, 90.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[278], 0, "Storage room", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[278], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[279] = CreateDynamicObject(19172, 1562.7756, 1606.2592, 12.1812, 0.0000, 0.0000, 90.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[279], 0, "High Risk Patient Ward", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[279], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[280] = CreateDynamicObject(19360, 1569.5592, 1589.2620, 11.5988, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[280], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[281] = CreateDynamicObject(19360, 1569.5592, 1589.2620, 15.0989, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[281], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[282] = CreateDynamicObject(19379, 1552.9129, 1586.5428, 9.7707, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[282], 0, 16640, "a51", "ws_stationfloor", 0xFFFFFFFF);
    g_Object[283] = CreateDynamicObject(19429, 1564.0312, 1590.5354, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[283], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[284] = CreateDynamicObject(19383, 1566.5211, 1606.0344, 11.5964, 0.0000, 0.0000, 0.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[284], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[285] = CreateDynamicObject(19360, 1566.5078, 1602.8320, 11.5888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[285], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[286] = CreateDynamicObject(19360, 1566.5078, 1602.8320, 15.0788, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[286], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[287] = CreateDynamicObject(19360, 1564.9074, 1608.5021, 11.5888, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[287], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[288] = CreateDynamicObject(19360, 1564.9074, 1608.5021, 15.0988, 0.0000, 0.0000, 90.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[288], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[289] = CreateDynamicObject(19377, 1566.5207, 1609.2368, 18.5821, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[289], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[290] = CreateDynamicObject(19377, 1566.5307, 1612.3886, 15.0921, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[290], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[291] = CreateDynamicObject(19379, 1571.8629, 1608.0136, 9.7807, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[291], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
    g_Object[292] = CreateDynamicObject(19377, 1576.3050, 1608.0765, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[292], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[293] = CreateDynamicObject(19377, 1571.3929, 1603.1959, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[293], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[294] = CreateDynamicObject(19379, 1563.4133, 1596.1806, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[294], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[295] = CreateDynamicObject(19360, 1566.5278, 1602.8320, 14.5188, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[295], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[296] = CreateDynamicObject(19377, 1566.5507, 1612.3786, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[296], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[297] = CreateDynamicObject(19360, 1566.5278, 1602.8320, 11.0188, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[297], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[298] = CreateDynamicObject(19360, 1566.5278, 1606.0440, 15.0888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[298], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[299] = CreateDynamicObject(19379, 1552.9207, 1596.1806, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[299], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[300] = CreateDynamicObject(19379, 1552.9020, 1586.5477, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[300], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[301] = CreateDynamicObject(3383, 1571.4647, 1610.1234, 9.8087, 0.0000, 0.0000, 180.0000, -1, 1); //a51_labtable1_
    g_Object[302] = CreateDynamicObject(3383, 1571.4647, 1605.8395, 9.8087, 0.0000, 0.0000, 0.0000, -1, 1); //a51_labtable1_
    g_Object[303] = CreateDynamicObject(19944, 1571.3985, 1605.8498, 10.8595, 0.0000, 0.0000, -90.0000, -1, 1); //BodyBag1
    g_Object[304] = CreateDynamicObject(2905, 1571.5993, 1609.7958, 10.9377, 0.0000, 0.0000, 135.7000, -1, 1); //kmb_deadleg
    g_Object[305] = CreateDynamicObject(2907, 1572.2611, 1609.9704, 11.0026, 0.0000, 0.0000, -171.8999, -1, 1); //kmb_deadtorso
    g_Object[306] = CreateDynamicObject(2906, 1571.2774, 1610.0864, 10.9171, 0.0000, 0.0000, 92.8999, -1, 1); //kmb_deadarm
    g_Object[307] = CreateDynamicObject(2908, 1570.8541, 1609.5777, 10.9209, 0.0000, 0.0000, 87.6999, -1, 1); //kmb_deadhead
    g_Object[308] = CreateDynamicObject(19619, 1576.2138, 1607.6452, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[309] = CreateDynamicObject(19619, 1576.2138, 1609.3662, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[310] = CreateDynamicObject(19619, 1576.2138, 1609.3662, 11.9463, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[311] = CreateDynamicObject(19619, 1576.2138, 1607.6448, 11.9463, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[312] = CreateDynamicObject(19619, 1576.2138, 1606.1635, 11.9463, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[313] = CreateDynamicObject(19619, 1576.2138, 1606.1635, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[314] = CreateDynamicObject(19619, 1576.2138, 1604.5119, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[315] = CreateDynamicObject(19619, 1576.2138, 1604.5119, 11.9563, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[316] = CreateDynamicObject(19619, 1576.2138, 1610.9160, 11.9563, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[317] = CreateDynamicObject(19619, 1576.2138, 1610.9160, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[318] = CreateDynamicObject(19619, 1576.2138, 1612.3974, 10.7863, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[319] = CreateDynamicObject(19619, 1576.2138, 1612.3974, 11.9663, 0.0000, 0.0000, -90.0000, -1, 1); //SafeDoor1
    g_Object[320] = CreateDynamicObject(19583, 1570.1389, 1609.4948, 10.8664, 0.0000, 0.0000, -178.7000, -1, 1); //MarcosKnife1
    g_Object[321] = CreateDynamicObject(2524, 1567.1448, 1608.5482, 9.8576, 0.0000, 0.0000, 90.0000, -1, 1); //CJ_B_SINK4
    g_Object[322] = CreateDynamicObject(19383, 1564.0369, 1588.1375, 11.5964, 0.0000, 0.0000, 0.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[322], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[323] = CreateDynamicObject(19172, 1566.4375, 1605.3583, 12.1812, 0.0000, 0.0000, -90.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[323], 0, "Morgue room", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[323], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[324] = CreateDynamicObject(19429, 1564.0312, 1585.7531, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[324], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[325] = CreateDynamicObject(19429, 1564.0212, 1585.7537, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[325], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[326] = CreateDynamicObject(19377, 1559.2714, 1591.3181, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[326], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[327] = CreateDynamicObject(19377, 1559.2714, 1584.8840, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[327], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[328] = CreateDynamicObject(19377, 1557.2211, 1586.4655, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[328], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[329] = CreateDynamicObject(19429, 1564.0212, 1590.5253, 11.6023, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[329], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[330] = CreateDynamicObject(19429, 1564.0212, 1590.5253, 15.0924, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[330], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[331] = CreateDynamicObject(11729, 1558.2348, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[332] = CreateDynamicObject(19429, 1564.0212, 1585.7524, 15.0924, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[332], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[333] = CreateDynamicObject(11729, 1558.9755, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[334] = CreateDynamicObject(11729, 1559.7062, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[335] = CreateDynamicObject(11729, 1560.4470, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[336] = CreateDynamicObject(11729, 1561.1777, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[337] = CreateDynamicObject(11729, 1561.9084, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[338] = CreateDynamicObject(11729, 1562.6491, 1590.9849, 9.8269, 0.0000, 0.0000, 0.0000, -1, 1); //GymLockerClosed1
    g_Object[339] = CreateDynamicObject(11729, 1562.6491, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[340] = CreateDynamicObject(11729, 1561.9084, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[341] = CreateDynamicObject(11729, 1561.1877, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[342] = CreateDynamicObject(11729, 1560.4570, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[343] = CreateDynamicObject(11729, 1559.7264, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[344] = CreateDynamicObject(11729, 1559.0058, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[345] = CreateDynamicObject(11729, 1558.2851, 1585.2225, 9.8269, 0.0000, 0.0000, 180.0000, -1, 1); //GymLockerClosed1
    g_Object[346] = CreateDynamicObject(948, 1563.4613, 1585.3968, 9.8400, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_10
    g_Object[347] = CreateDynamicObject(948, 1563.4613, 1590.7790, 9.8400, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_10
    g_Object[348] = CreateDynamicObject(14401, 1568.2608, 1573.8994, 10.1790, 0.0000, 0.0000, 0.0000, -1, 1); //bench1
    g_Object[349] = CreateDynamicObject(19383, 1566.0283, 1584.8671, 11.5964, 0.0000, 0.0000, 90.0000, -1, 1); //wall031
    SetDynamicObjectMaterial(g_Object[349], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[350] = CreateDynamicObject(19429, 1564.0312, 1590.5449, 15.0924, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[350], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[351] = CreateDynamicObject(19429, 1564.0312, 1585.7524, 15.0924, 0.0000, 0.0000, 0.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[351], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[352] = CreateDynamicObject(19360, 1564.0473, 1588.1540, 15.0888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[352], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[353] = CreateDynamicObject(1499, 1564.0548, 1587.3994, 9.8353, 0.0000, 0.0000, 90.0000, -1, 1); //Gen_doorINT05
    SetDynamicObjectMaterial(g_Object[353], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[353], 1, 2821, "gb_foodwrap01", "midgrey64", 0xFFFFFFFF);
    g_Object[354] = CreateDynamicObject(19360, 1564.0273, 1588.1540, 15.0888, 0.0000, 0.0000, 0.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[354], 0, 4830, "airport2", "brnstucco1", 0xFFFFFFFF);
    g_Object[355] = CreateDynamicObject(19429, 1563.6608, 1584.8634, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[355], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[356] = CreateDynamicObject(19429, 1568.4338, 1584.8634, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[356], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[357] = CreateDynamicObject(19379, 1562.7247, 1579.9716, 9.7807, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[357], 0, 14652, "ab_trukstpa", "mp_diner_wood", 0xFFFFFFFF);
    g_Object[358] = CreateDynamicObject(19377, 1557.4558, 1579.9531, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[358], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[359] = CreateDynamicObject(19377, 1568.0131, 1579.9531, 11.0221, 0.0000, 0.0000, 0.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[359], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[360] = CreateDynamicObject(19377, 1563.1492, 1576.4018, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[360], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[361] = CreateDynamicObject(19377, 1553.5163, 1576.4018, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[361], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[362] = CreateDynamicObject(19377, 1559.6689, 1584.8536, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[362], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[363] = CreateDynamicObject(19379, 1563.4133, 1605.8106, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[363], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[364] = CreateDynamicObject(19429, 1568.4238, 1584.8533, 11.6023, 0.0000, 0.0000, 90.0000, -1, 1); //wall069
    SetDynamicObjectMaterial(g_Object[364], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[365] = CreateDynamicObject(2166, 1564.8404, 1578.8955, 9.8600, 0.0000, 0.0000, 0.0000, -1, 1); //MED_OFFICE_DESK_2
    g_Object[366] = CreateDynamicObject(2161, 1566.1745, 1576.4777, 9.8540, 0.0000, 0.0000, 180.0000, -1, 1); //MED_OFFICE_UNIT_4
    g_Object[367] = CreateDynamicObject(2161, 1566.1745, 1576.4777, 11.2040, 0.0000, 0.0000, 180.0000, -1, 1); //MED_OFFICE_UNIT_4
    g_Object[368] = CreateDynamicObject(2162, 1567.9473, 1579.4173, 11.0564, 0.0000, 0.0000, -90.0000, -1, 1); //MED_OFFICE_UNIT_1
    g_Object[369] = CreateDynamicObject(2164, 1567.9246, 1581.5880, 9.5838, 0.0000, 0.0000, -90.0000, -1, 1); //MED_OFFICE_UNIT_5
    g_Object[370] = CreateDynamicObject(2167, 1564.1529, 1576.5107, 9.8533, 0.0000, 0.0000, 180.0000, -1, 1); //MED_OFFICE_UNIT_7
    g_Object[371] = CreateDynamicObject(19835, 1565.8990, 1579.6815, 10.7471, 0.0000, 0.0000, 0.0000, -1, 1); //CoffeeCup1
    g_Object[372] = CreateDynamicObject(19893, 1565.5759, 1579.7059, 10.6479, 0.0000, 0.0000, 0.0000, -1, 1); //LaptopSAMP1
    SetDynamicObjectMaterial(g_Object[372], 1, 5708, "hospital_lawn", "allsaints_law", 0xFFFFFFFF);
    g_Object[373] = CreateDynamicObject(19576, 1566.0499, 1579.7604, 10.6840, 0.0000, 0.0000, 0.0000, -1, 1); //Apple2
    g_Object[374] = CreateDynamicObject(19015, 1565.2591, 1579.7214, 10.6863, 0.0000, 0.0000, 54.5999, -1, 1); //GlassesType10
    g_Object[375] = CreateDynamicObject(2894, 1564.6909, 1578.9532, 10.6442, 0.0000, 0.0000, 94.2999, -1, 1); //kmb_rhymesbook
    g_Object[376] = CreateDynamicObject(1714, 1565.5863, 1578.4066, 9.8641, 0.0000, 0.0000, 180.0000, -1, 1); //kb_swivelchair1
    g_Object[377] = CreateDynamicObject(11724, 1558.7070, 1583.4645, 10.3760, 0.0000, 0.0000, 50.0000, -1, 1); //FireplaceSurround1
    SetDynamicObjectMaterial(g_Object[377], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[377], 1, 3676, "lawnxref", "lasthoose6", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[377], 2, 16640, "a51", "concretemanky", 0xFFFFFFFF);
    g_Object[378] = CreateDynamicObject(14455, 1558.4687, 1576.6708, 11.5273, 0.0000, 0.0000, 0.0000, -1, 1); //Gs_BOOKCASE
    g_Object[379] = CreateDynamicObject(19360, 1558.3808, 1583.6562, 11.5988, 0.0000, 0.0000, -40.0000, -1, 1); //wall008
    SetDynamicObjectMaterial(g_Object[379], 0, 6293, "lawland2", "lasjmflat1", 0xFFFFFFFF);
    g_Object[380] = CreateDynamicObject(19632, 1558.8062, 1583.4151, 9.8720, 0.0000, 0.0000, 47.8999, -1, 1); //FireWood1
    g_Object[381] = CreateDynamicObject(1819, 1560.2534, 1581.1933, 9.8496, 0.0000, 0.0000, 0.0000, -1, 1); //COFFEE_SWANK_4
    SetDynamicObjectMaterial(g_Object[381], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
    g_Object[382] = CreateDynamicObject(1705, 1561.6428, 1583.2950, 9.8640, 0.0000, 0.0000, -98.5999, -1, 1); //kb_chair04
    g_Object[383] = CreateDynamicObject(1705, 1560.5327, 1580.8454, 9.8640, 0.0000, 0.0000, -140.9000, -1, 1); //kb_chair04
    g_Object[384] = CreateDynamicObject(2854, 1560.7335, 1581.6577, 10.3386, 0.0000, 0.0000, 0.0000, -1, 1); //gb_bedmags04
    g_Object[385] = CreateDynamicObject(2286, 1562.8912, 1584.7351, 11.7684, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_5
    g_Object[386] = CreateDynamicObject(2287, 1560.5942, 1584.2976, 11.4446, 0.0000, 0.0000, 0.0000, -1, 1); //Frame_4
    g_Object[387] = CreateDynamicObject(2289, 1557.5848, 1578.3170, 11.7115, 0.0000, 0.0000, 90.0000, -1, 1); //Frame_2
    g_Object[388] = CreateDynamicObject(2275, 1558.9011, 1583.3807, 11.9424, 0.0000, 0.0000, 50.0000, -1, 1); //Frame_Fab_4
    g_Object[389] = CreateDynamicObject(2281, 1558.0219, 1581.0626, 11.4760, 0.0000, 0.0000, 90.0000, -1, 1); //Frame_Thick_5
    g_Object[390] = CreateDynamicObject(1705, 1568.1567, 1584.4238, 6.6406, 0.0000, 0.0000, 0.0000, -1, 1); //kb_chair04
    g_Object[391] = CreateDynamicObject(1671, 1565.9057, 1581.3236, 10.3106, 0.0000, 0.0000, 0.0000, -1, 1); //swivelchair_A
    g_Object[392] = CreateDynamicObject(1671, 1564.8248, 1581.3236, 10.3106, 0.0000, 0.0000, 0.0000, -1, 1); //swivelchair_A
    g_Object[393] = CreateDynamicObject(2011, 1567.3566, 1584.2478, 9.8348, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant2_ofc
    g_Object[394] = CreateDynamicObject(2011, 1564.6259, 1584.2478, 9.8348, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant2_ofc
    g_Object[395] = CreateDynamicObject(2001, 1567.3802, 1576.9520, 9.8437, 0.0000, 0.0000, 0.0000, -1, 1); //nu_plant_ofc
    g_Object[396] = CreateDynamicObject(948, 1557.8822, 1581.8563, 9.8365, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_10
    g_Object[397] = CreateDynamicObject(2194, 1564.4340, 1576.6920, 11.6218, 0.0000, 0.0000, 0.0000, -1, 1); //Plant_Pot_2
    g_Object[398] = CreateDynamicObject(19377, 1571.3929, 1612.7595, 11.0221, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[398], 0, 16640, "a51", "ws_metalpanel1", 0xFFFFFFFF);
    g_Object[399] = CreateDynamicObject(19377, 1566.0531, 1584.8823, 18.5720, 0.0000, 0.0000, 90.0000, -1, 1); //wall025
    SetDynamicObjectMaterial(g_Object[399], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
    g_Object[400] = CreateDynamicObject(19379, 1594.8974, 1586.5500, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[400], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[401] = CreateDynamicObject(11711, 1580.8104, 1591.4265, 12.7105, 0.0000, 0.0000, 90.0000, -1, 1); //ExitSign1
    g_Object[402] = CreateDynamicObject(18762, 1568.0762, 1589.2822, 12.2672, 0.0000, 0.0000, 0.0000, -1, 1); //Concrete1mx1mx5m
    SetDynamicObjectMaterial(g_Object[402], 0, 6522, "cuntclub_law2", "helipad_grey1", 0xFFFFFFFF);
    g_Object[403] = CreateDynamicObject(19172, 1564.1152, 1588.8538, 12.1812, 0.0000, 0.0000, 90.0000, -1, 1); //SAMPPicture1
    SetDynamicObjectMaterialText(g_Object[403], 0, "Locker Room", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText(g_Object[403], 1, ".", 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[404] = CreateDynamicObject(19379, 1584.4050, 1596.1811, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[404], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
    g_Object[405] = CreateDynamicObject(19379, 1563.4033, 1615.4414, 14.7904, 0.0000, 90.0000, 0.0000, -1, 1, -1, 1); //wall027
    SetDynamicObjectMaterial(g_Object[405], 0, 14668, "711c", "gun_ceiling1128", 0xFFFFFFFF);
}

stock LoadPDInterior()
{
    //Map Exported with Texture Studio By: [uL]Pottus////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
    new tmpobjid;
    tmpobjid = CreateDynamicObject(19454, -33.877799, -0.994300, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -37.329299, -0.529380, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -40.767601, 0.012400, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -37.028301, 4.287498, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -30.415500, -1.514700, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -27.554199, 2.856899, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -26.979719, -2.030590, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -23.537000, -2.538558, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -42.433200, 0.258700, -14.397198, 0.000000, 0.000000, 171.135498, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -36.279598, -0.658500, -14.397198, 0.000000, 0.000000, 171.135498, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -42.186000, -9.501998, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -38.743659, -10.024828, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -43.411399, -6.021298, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -43.893600, -9.188798, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -44.378501, -12.358300, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -32.331298, -6.067500, -10.923298, 0.000000, 180.000000, 80.994003, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -33.036701, -10.126700, -10.903300, 0.000000, 180.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -37.676651, -14.312398, -14.397198, 0.000000, 0.000000, 171.135498, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -39.936798, -14.658800, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -45.645809, -9.001990, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -49.088199, -8.484748, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -52.937290, -10.902020, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -56.378860, -10.387100, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -48.313549, -6.679100, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -48.848300, -10.257300, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -52.264518, -1.304849, -14.397198, 0.000000, 0.000000, 171.135498, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -57.476631, -0.484230, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -56.205669, 4.054658, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -60.832199, -4.816898, -14.397198, 0.000000, 0.000000, 81.715301, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -58.080581, -10.001758, -14.397198, 0.000000, 0.000000, 171.739440, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -54.526039, -5.741158, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -61.506679, 0.062590, -14.397198, 0.000000, 0.000000, 172.364868, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -54.226200, -14.230898, -10.909998, 0.000000, 0.000000, 171.739395, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -55.149021, -20.547679, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -56.836570, -20.021549, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -60.301250, -19.521829, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -1267.641235, 7160.821289, -7903.291503, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -49.104389, -15.764180, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -39.560768, -22.675949, -16.056900, 0.000000, 90.000000, 351.189880, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -51.364151, -30.578300, -16.056900, 0.000000, 90.000000, 351.189880, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -41.031700, -32.168849, -16.056900, 0.000000, 90.000000, 351.189880, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -28.115699, -34.302200, -10.869998, 0.000000, 0.000000, 170.614715, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -57.065399, -32.934799, -10.909998, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -52.621398, -35.183998, -10.909998, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -31.032449, -23.593959, -10.909998, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -49.700489, -17.222190, -10.914500, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -49.733528, -17.214130, -14.390800, 0.000000, 0.000000, 81.094276, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -49.940391, -21.072460, -16.056900, 0.000000, 90.000000, 351.189880, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -40.226791, -18.706489, -10.914468, 0.000000, 0.000000, 81.094276, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -40.226791, -18.706489, -14.390800, 0.000000, 0.000000, 81.094276, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -38.739089, -17.316869, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -17.968900, -24.756589, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -25.648149, -38.578838, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -46.731948, -37.721511, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -57.095439, -36.160449, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -36.445301, -23.255699, -14.390800, 0.000000, 0.000000, 351.804809, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -37.810390, -32.723220, -14.390800, 0.000000, 0.000000, 351.804809, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -43.136699, -36.669601, -14.390000, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -52.621368, -35.184009, -14.390800, 0.000000, 0.000000, 81.094276, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -57.065380, -32.934761, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -60.628658, -24.236610, -14.397198, 0.000000, 0.000000, 83.393608, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -55.142879, -20.461330, -10.909998, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -54.226238, -14.230870, -14.397198, 0.000000, 0.000000, 171.739440, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -56.184520, 3.942399, -14.064908, 0.000000, 0.000000, 351.416168, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(19454, -63.757259, -19.015859, -16.056900, 0.000000, 90.000000, 351.503112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "cof_wood1", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14668, "711c", "CJ_7_11_win", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 19076, "xmastree1", "goldplate", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 19076, "xmastree1", "goldplate", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -63.457080, -14.129220, -14.397198, 0.000000, 0.000000, 81.715301, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -59.040580, -16.479780, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -60.017520, -22.806739, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -59.532669, -19.650770, -14.397198, 0.000000, 0.000000, 171.355499, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -64.241241, -18.968210, -14.397198, 0.000000, 0.000000, 81.715301, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -32.331298, -6.067500, -14.397198, 0.000000, 0.000000, 80.993972, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -33.036701, -10.126700, -14.397198, 0.000000, 0.000000, 81.400001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -36.973041, -4.164878, -11.004300, 0.000000, 180.000000, 350.891906, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -38.000099, -10.499198, -11.004300, 0.000000, 180.000000, 350.891906, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -27.334499, -8.727800, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -28.957380, -18.199859, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -17.030509, -10.477620, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -18.646549, -19.959930, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -29.067100, -15.497598, -10.907698, 0.000000, 0.000000, 351.301757, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -23.688919, -11.568980, -10.914468, 0.000000, 0.000000, 80.893287, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -17.361400, -12.579998, -10.914500, 0.000000, 0.000000, 80.893302, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -19.008390, -17.201549, -10.914500, 0.000000, 0.000000, 350.278686, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -16.145439, -14.467207, -10.914500, 0.000000, 0.000000, 350.278686, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -15.590000, -11.179597, -10.914500, 0.000000, 0.000000, 350.048492, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -18.479459, -14.063460, -10.914500, 0.000000, 0.000000, 350.586242, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -17.254049, -27.092039, -10.914500, 0.000000, 0.000000, 352.629821, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -14.794540, -16.211900, -10.914500, 0.000000, 0.000000, 261.083679, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -13.546938, -17.944229, -10.914500, 0.000000, 0.000000, 350.992340, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -14.064768, -21.082809, -10.914500, 0.000000, 0.000000, 350.280212, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -15.139418, -22.559009, -10.914500, 0.000000, 0.000000, 261.083679, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -23.946170, -7.417078, -10.914468, 0.000000, 0.000000, 80.693290, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -18.474500, -3.444600, -10.907698, 0.000000, 0.000000, 350.395690, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -14.553298, -4.866798, -10.907698, 0.000000, 0.000000, 350.797698, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -13.535497, 1.458299, -10.914500, 0.000000, 0.000000, 351.058685, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -19.176979, -0.368200, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -6.720347, -12.217880, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -8.343770, -21.700090, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, -9.173520, -1.662719, -12.663998, 0.000000, 90.000000, 260.681884, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 13007, "sw_bankint", "woodfloor1", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, -7.488120, 8.662070, -12.663998, 0.000000, 90.000000, 260.681884, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 13007, "sw_bankint", "woodfloor1", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -9.971228, -6.786358, -10.914468, 0.000000, 0.000000, 80.591293, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -0.517799, -8.355500, -10.914500, 0.000000, 0.000000, 80.591300, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -4.503428, -2.920140, -10.907698, 0.000000, 0.000000, 351.098693, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -3.023128, 6.525908, -10.907698, 0.000000, 0.000000, 351.098693, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -12.529588, 7.769989, -10.907698, 0.000000, 0.000000, 350.897674, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -7.074140, 11.651228, -10.914468, 0.000000, 0.000000, 80.591293, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -16.883129, 6.043048, -10.907698, 0.000000, 0.000000, 350.598724, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -17.563249, 9.109727, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -4.793418, -3.916918, -10.405440, 0.000000, 0.000000, 260.558868, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -3.824528, 2.087008, -10.405440, 0.000000, 0.000000, 260.558868, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -2.996309, 7.363338, -10.405440, 0.000000, 0.000000, 260.558868, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -9.595520, 1.457620, -12.581740, 0.000000, 0.000000, 80.281112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -9.910820, -0.357639, -12.581740, 0.000000, 0.000000, 80.281112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -9.293020, 3.273570, -12.581740, 0.000000, 0.000000, 80.281112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -8.993940, 5.110340, -12.581740, 0.000000, 0.000000, 80.281112, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -7.971370, 5.917920, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -8.265810, 4.101520, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -8.560250, 2.285120, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -8.874400, 0.472140, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -8.085240, 0.340909, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -7.777790, 2.155478, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -7.470338, 3.970060, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -7.182528, 5.788400, -12.581740, 0.000000, 0.000000, 260.503448, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -11.065138, -13.608710, -10.914468, 0.000000, 0.000000, 80.591293, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -6.045218, -12.237368, -10.907698, 0.000000, 0.000000, 351.098693, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -7.534998, -21.740400, -10.907698, 0.000000, 0.000000, 351.098693, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -8.862700, -23.584999, -10.914500, 0.000000, 0.000000, 80.591300, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -5.954420, -10.982278, -10.405440, 0.000000, 0.000000, 260.563934, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -11.066498, -23.112239, -10.405440, 0.000000, 0.000000, 170.274566, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -28.809560, -14.403260, -10.405440, 0.000000, 0.000000, 81.294769, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -15.949257, 18.573150, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -6.669198, 13.773758, -10.914468, 0.000000, 0.000000, 80.591293, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -7.842860, 13.394740, -10.914500, 0.000000, 0.000000, 170.699768, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -11.671547, 13.056440, -10.914500, 0.000000, 0.000000, 351.058685, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1523, -11.573610, 14.006448, -12.577268, 0.000000, 0.000000, 261.361999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -15.851200, 12.368700, -10.914500, 0.000000, 0.000000, 351.058685, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1523, -15.765330, 13.156990, -12.577268, 0.000000, 0.000000, 261.361999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -16.900579, 6.101058, -10.914500, 0.000000, 0.000000, 170.869873, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19385, -15.895898, 12.378510, -10.914500, 0.000000, 0.000000, 350.737091, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -20.465639, 14.544158, -10.914500, 0.000000, 0.000000, 81.870002, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -22.652519, 9.967690, -10.914500, 0.000000, 0.000000, 170.364852, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -21.976430, 5.102818, -10.914500, 0.000000, 0.000000, 81.870002, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(14401, -19.000270, 8.806550, -12.378378, 0.000000, 0.000000, 351.606781, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "ab_wood01", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -14.869500, 18.604900, -10.914500, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -14.596960, 23.534709, -10.914500, 0.000000, 0.000000, 80.525047, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1523, -11.785498, 15.523618, -12.577268, 0.000000, 0.000000, 170.762649, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1523, -14.759110, 15.922670, -12.577268, 0.000000, 0.000000, 351.512756, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -16.214899, 16.200000, -10.914500, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -10.325558, 15.285670, -10.914500, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -13.213298, 15.737798, -8.362998, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -14.334137, 28.058900, -12.663997, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -1.488129, 20.701860, -14.983070, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -9.452050, 17.412879, -14.439418, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -6.325510, 16.952499, -14.420510, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -6.325500, 16.952499, -10.944499, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -9.451998, 17.412900, -10.944998, 0.000000, 0.000000, 81.246299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -4.586900, 24.604999, -10.898098, 0.000000, 0.000000, 80.650901, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -8.353690, 21.263650, -10.914500, 0.000000, 0.000000, 81.846298, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -8.350098, 25.226699, -14.389100, 0.000000, 0.000000, 260.687103, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -4.026700, 21.385900, -10.894900, 0.000000, 0.000000, 350.178497, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -4.026690, 21.385879, -14.385860, 0.000000, 0.000000, 350.178497, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -11.539010, 21.728790, -14.385860, 0.000000, 0.000000, 81.454803, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -8.272777, 25.190147, -14.385860, 0.000000, 0.000000, 80.650863, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -21.037879, 23.118539, -14.385860, 0.000000, 0.000000, 81.870002, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -11.645177, 31.872880, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -22.884939, 28.256389, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -11.677498, 30.515729, -10.914500, 0.000000, 0.000000, 81.271690, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -14.532037, 26.236379, -14.389100, 0.000000, 0.000000, 80.740402, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -20.862819, 27.281179, -14.389100, 0.000000, 0.000000, 260.687103, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -21.254829, 37.737369, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -7.250500, 26.752199, -14.389100, 0.000000, 0.000000, 170.298797, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -10.034680, 41.358131, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19404, -6.714360, 29.877040, -14.389100, 0.000000, 0.000000, 170.298797, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -6.176808, 33.043781, -14.389100, 0.000000, 0.000000, 170.298797, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19404, -5.652678, 36.187648, -14.389100, 0.000000, 0.000000, 170.899826, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -5.136000, 39.318130, -14.389100, 0.000000, 0.000000, 170.298797, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -27.090200, 28.299999, -14.389100, 0.000000, 0.000000, 80.740402, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(18070, -19.368209, 34.645919, -15.758998, 0.000000, 0.000000, 81.120002, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    tmpobjid = CreateDynamicObject(18070, -19.407499, 34.635898, -13.265198, 0.000000, 180.000000, 81.120002, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -17.294870, 32.281879, -17.011100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -16.808870, 35.424800, -17.011100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -16.677000, 36.276298, -17.011100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -17.953189, 38.022201, -17.011100, 0.000000, 0.000000, 261.118988, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -20.660129, 31.252780, -17.011100, 0.000000, 0.000000, 261.118988, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -19.039129, 31.000749, -17.011100, 0.000000, 0.000000, 261.118988, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -19.671300, 38.291000, -17.011100, 0.000000, 0.000000, 261.118988, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -20.524000, 29.694200, -14.389100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -20.634399, 28.960899, -14.389100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -19.015449, 39.691459, -14.389100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -19.687919, 47.184688, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -18.517030, 42.852638, -14.389100, 0.000000, 0.000000, 351.121307, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -18.831300, 42.551399, -14.389100, 0.000000, 0.000000, 260.687103, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -12.546400, 41.528499, -14.389100, 0.000000, 0.000000, 80.941398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -6.296400, 40.512699, -14.389100, 0.000000, 0.000000, 260.687103, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -33.124740, 29.999069, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -31.577480, 39.449901, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -32.230831, 53.290180, -16.208999, 0.000000, 90.000000, 351.289459, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -27.859399, 33.242221, -14.385410, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -25.619358, 37.745658, -14.389100, 0.000000, 0.000000, 80.740402, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -23.371339, 42.163650, -14.385410, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -28.268320, 44.104969, -14.389100, 0.000000, 0.000000, 260.687103, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -33.237739, 42.924419, -14.385410, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -31.936649, 38.774879, -14.389100, 0.000000, 0.000000, 260.797210, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -30.528099, 24.632299, -14.385898, 0.000000, 0.000000, 80.000999, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -33.437999, 29.365100, -14.385898, 0.000000, 0.000000, 80.346801, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -37.379669, 34.867080, -14.385898, 0.000000, 0.000000, 351.208343, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -40.019500, 26.276199, -14.385898, 0.000000, 0.000000, 80.346801, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -62.079730, 30.019769, -14.385898, 0.000000, 0.000000, 80.346801, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -54.240558, 32.119709, -14.385898, 0.000000, 0.000000, 80.752838, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -58.750171, 34.410961, -14.385898, 0.000000, 0.000000, 351.208343, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(18070, -46.764801, 34.499099, -13.140398, 0.000000, 180.000000, 80.175613, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14789, "ab_sfgymmain", "ab_wood02", 0x00000000);
    tmpobjid = CreateDynamicObject(19385, -53.613998, 30.315900, -14.359298, 0.000000, 0.000000, 350.502410, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(18070, -46.764801, 34.499099, -15.627799, 0.000000, 0.000000, 80.174606, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -55.151218, 39.329719, -14.385898, 0.000000, 0.000000, 80.752838, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -57.261020, 43.915248, -14.385898, 0.000000, 0.000000, 351.007324, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -47.730030, 42.597251, -14.385898, 0.000000, 0.000000, 80.954856, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, -38.177188, 39.801399, -14.416390, 0.000000, 0.000000, 81.174087, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -38.950981, 44.720851, -14.385898, 0.000000, 0.000000, 351.208343, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -33.505519, 48.619941, -14.389100, 0.000000, 0.000000, 261.999267, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19385, -37.990001, 50.932300, -14.376898, 0.000000, 0.000000, 351.137695, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19385, -37.500000, 54.076900, -14.376898, 0.000000, 0.000000, 351.137695, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -36.521301, 60.384700, -14.376898, 0.000000, 0.000000, 351.208312, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -30.815589, 62.709171, -16.208999, 0.000000, 90.000000, 351.289459, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -28.527700, 55.894199, -14.376898, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -32.892318, 59.174591, -14.389100, 0.000000, 0.000000, 261.597229, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19404, -36.087398, 52.158199, -14.376897, 0.000000, 0.000000, 80.876861, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -29.799499, 51.198001, -14.376898, 0.000000, 0.000000, 261.489105, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -42.118980, 55.887969, -14.385898, 0.000000, 0.000000, 81.055847, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -40.787521, 56.076179, -14.376898, 0.000000, 0.000000, 351.208312, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -55.762260, 53.429340, -14.385898, 0.000000, 0.000000, 351.007324, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -55.683208, 53.586460, -14.385898, 0.000000, 0.000000, 81.055847, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -9.810878, 43.283699, -16.122289, 0.000000, 0.000000, 351.519317, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(3034, -28.817869, 54.663021, -13.929300, 0.000000, 0.000000, 260.984405, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "mcstraps_window", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -28.413679, 49.796501, -14.385410, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -8.427557, 50.789859, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19385, -46.345500, 27.353000, -14.389498, 0.000000, 0.000000, 260.578094, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -52.634891, 28.409870, -14.385898, 0.000000, 0.000000, 80.346801, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -46.839351, 22.565900, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -51.139560, 23.261550, -14.385898, 0.000000, 0.000000, 351.208343, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -44.463878, 22.133039, -14.385898, 0.000000, 0.000000, 351.208343, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19447, -48.144878, 18.909410, -14.385898, 0.000000, 0.000000, 81.262931, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1537, -5.646490, 36.303890, -15.506230, 0.000000, 0.000000, 80.910202, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1537, -6.683000, 29.980699, -15.506197, 0.000000, 0.000000, 80.610198, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1537, -6.464138, 31.303630, -15.506230, 0.000000, 0.000000, 80.610206, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(1537, -5.432178, 37.614509, -15.506230, 0.000000, 0.000000, 80.910202, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -4.133038, 45.605968, -14.385398, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -17.560100, 48.942699, -14.385398, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -9.979377, 46.012229, -14.389100, 0.000000, 0.000000, 171.779602, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -10.455618, 42.872058, -14.389100, 0.000000, 0.000000, 351.003997, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -14.031668, 43.422889, -14.389100, 0.000000, 0.000000, 352.231445, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -13.590047, 46.529861, -14.389100, 0.000000, 0.000000, 171.578598, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -12.968190, 47.974258, -14.389100, 0.000000, 0.000000, 261.913482, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -3.437510, 46.612270, -14.389100, 0.000000, 0.000000, 261.813476, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -32.941211, 57.516529, -16.122289, 0.000000, 0.000000, 81.179939, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(2180, -15.517760, 44.153881, -16.122289, 0.000000, 0.000000, 351.519317, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -11.466930, 23.038360, -10.914500, 0.000000, 0.000000, 81.482597, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -11.180000, 16.124300, -10.914500, 0.000000, 0.000000, 170.699798, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -15.182579, 28.592599, -10.914500, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -9.298740, 26.178039, -10.914500, 0.000000, 0.000000, 351.108886, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -37.483039, -7.336938, -11.004300, 0.000000, 180.000000, 350.799652, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -56.120601, -26.787799, -14.397198, 0.000000, 0.000000, 171.165405, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -13.264369, 22.423149, -16.228990, 0.000000, 90.000000, 350.289398, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -65.726928, -19.716850, -14.397198, 0.000000, 0.000000, 353.175109, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19397, -66.130111, -22.894180, -14.397198, 0.000000, 0.000000, 352.272033, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19369, -64.584800, -23.778450, -14.397198, 0.000000, 0.000000, 83.393600, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(902, -3.870599, 20.525880, -11.133850, 108.000000, 90.000000, 170.251434, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18631, "nomodelfile", "hazardtile6", 0x00000000);
    tmpobjid = CreateDynamicObject(902, -58.102199, -24.976999, -13.989000, 108.000000, 90.000000, 83.846801, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18631, "nomodelfile", "hazardtile6", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -26.625879, -25.816209, -10.909997, 0.000000, 0.000000, 351.220001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -35.881221, -21.047990, -10.914500, 0.000000, 0.000000, 351.833007, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19450, -33.578399, -38.167999, -10.909998, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -36.022441, -36.956668, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -34.613548, -27.526020, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19461, -56.120601, -26.787799, -10.909998, 0.000000, 0.000000, 171.165405, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 6873, "vgnshambild1", "fitzwallvgn6_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -46.287601, -36.179000, -10.909997, 0.000000, 0.000000, 81.094299, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -27.119358, -28.974990, -10.909998, 0.000000, 0.000000, 351.034851, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -21.892219, -25.046590, -10.914500, 0.000000, 0.000000, 261.086303, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -19.531959, -20.315620, -10.914500, 0.000000, 0.000000, 350.586242, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, -24.258430, -29.058139, -12.583990, 0.000000, 90.000000, 351.484771, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "walp45S", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -18.896219, -28.552988, -10.914500, 0.000000, 0.000000, 261.164337, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -20.058050, -23.382789, -10.914500, 0.000000, 0.000000, 350.081176, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -24.731510, -24.590700, -10.914500, 0.000000, 0.000000, 260.758270, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -25.215269, -27.571260, -10.914500, 0.000000, 0.000000, 261.164337, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -20.127410, -23.779790, -10.914500, 0.000000, 0.000000, 350.081176, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -22.066770, -28.062540, -10.914500, 0.000000, 0.000000, 261.164337, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -16.852500, -23.961999, -10.914500, 0.000000, 0.000000, 352.629821, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19388, -38.100368, -35.925590, -10.909997, 0.000000, 0.000000, 351.220001, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19404, -43.225299, -36.635700, -10.909997, 0.000000, 0.000000, 81.904296, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -40.052558, -37.103549, -10.909998, 0.000000, 0.000000, 81.503303, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19358, -39.993881, -37.116050, -10.909998, 0.000000, 0.000000, 81.503303, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10756, "airportroads_sfse", "sf_junction5", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, -41.742378, -43.335830, -10.909998, 0.000000, 0.000000, 261.868591, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 15041, "bigsfsave", "ah_ceilpan1", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, -41.927761, -41.694229, -10.909998, 0.000000, 0.000000, 351.570373, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 15041, "bigsfsave", "ah_ceilpan1", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, -55.615379, -39.583019, -10.909998, 0.000000, 0.000000, 351.570373, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 15041, "bigsfsave", "ah_ceilpan1", 0x00000000);
    tmpobjid = CreateDynamicObject(19453, -51.232070, -41.971488, -10.909998, 0.000000, 0.000000, 261.868591, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 15041, "bigsfsave", "ah_ceilpan1", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1533, -40.124679, 4.620240, -16.075599, 0.000000, 0.000000, 351.432891, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1533, -38.654109, 4.395780, -16.075599, 0.000000, 0.000000, 351.432891, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19325, -42.520599, 2.104398, -15.970998, 90.180000, 0.000000, 81.253906, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19325, -35.804248, 1.082579, -15.970998, 90.180000, 0.000000, 81.253898, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2886, -36.617401, 4.203790, -14.671190, 0.000000, 0.000000, 351.276702, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14416, -34.544078, -7.873538, -15.816699, 0.000000, 0.000000, 260.495391, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1775, -37.629798, -10.152600, -14.808098, 0.000000, 0.000000, 261.715606, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19172, -37.523559, -12.835289, -14.067998, 0.000000, 0.000000, 261.132049, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -38.420600, -0.246098, -12.680100, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -42.989341, -9.237540, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -33.297290, -14.971890, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -53.365100, -7.587600, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -56.897640, 2.678848, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -63.602489, -5.933380, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -59.852279, -16.308200, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -61.373279, -25.795230, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -50.200698, -21.989000, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -51.697860, -31.501909, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -39.857761, -23.670179, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -29.501600, -25.246000, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -52.874061, -20.023269, -11.990710, 0.000000, 0.000000, 351.489196, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -48.796619, -20.616870, -11.990710, 0.000000, 0.000000, 351.489196, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -44.722980, -21.233659, -11.990710, 0.000000, 0.000000, 351.489196, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -54.683238, -31.708599, -11.990710, 0.000000, 0.000000, 351.083129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -39.366889, -24.132089, -11.990710, 0.000000, 0.000000, 261.512420, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -39.974620, -28.207220, -11.990710, 0.000000, 0.000000, 261.311401, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -40.541900, -31.883909, -11.990710, 0.000000, 0.000000, 261.311401, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -41.065708, -21.788850, -11.990710, 0.000000, 0.000000, 351.489196, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -42.867591, -33.561779, -11.990710, 0.000000, 0.000000, 351.083129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -46.949680, -32.923019, -11.990710, 0.000000, 0.000000, 351.083129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -51.002399, -32.288558, -11.990710, 0.000000, 0.000000, 351.083129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2614, -55.795860, -25.566759, -10.906229, 0.000000, 0.000000, 81.687812, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -45.550098, -36.247200, -12.653400, 0.000000, 0.000000, 171.020797, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -53.780399, -5.836100, -16.152999, 0.000000, 0.000000, 171.431503, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -59.852279, -16.308200, -12.680100, 0.000000, 90.000000, 350.948944, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -59.912818, -22.063129, -16.152999, 0.000000, 0.000000, 261.536773, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2835, -59.352008, -16.911230, -15.971678, 0.000000, 0.000000, 81.251426, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -28.634479, -5.594950, -11.973798, 0.000000, 0.000000, 80.589599, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, -29.619419, -11.716360, -11.973798, 0.000000, 0.000000, 80.589599, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2605, -3.813220, 8.940440, -12.176400, 0.000000, 0.000000, 170.661437, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -10.418628, 10.160110, -12.577838, 0.000000, 0.000000, 170.760604, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2184, -8.715298, 8.096090, -12.576860, 0.000000, 0.000000, 350.989135, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -3.930928, 10.979940, -10.380920, 0.000000, 0.000000, 351.540740, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -11.930958, 10.511698, -10.391400, 0.000000, 0.000000, 79.829177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2615, -13.950268, -2.159929, -10.520500, 0.000000, 0.000000, 81.080673, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -13.691450, -0.438230, -10.621350, 0.000000, 0.000000, 81.032028, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2000, -10.018898, -1.351199, -12.582400, 0.000000, 0.000000, 350.134094, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2007, -9.280810, -1.468209, -13.084300, 0.000000, 0.000000, 350.504608, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14782, -12.410940, 5.977778, -11.571000, 0.000000, 0.000000, 80.881378, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -13.708430, -3.366070, -12.570598, 0.000000, 0.000000, 81.807456, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -13.636678, -2.789139, -12.570598, 0.000000, 0.000000, 81.807456, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2007, -13.766090, -4.180088, -13.084300, 0.000000, 0.000000, 80.833229, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -14.308620, -5.542640, -12.578558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1998, -5.542388, -5.851610, -12.577058, 0.000000, 0.000000, 170.842132, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -7.608270, -6.516160, -12.576978, 0.000000, 0.000000, 170.720718, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -11.941340, -5.825348, -12.576978, 0.000000, 0.000000, 170.827926, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -4.735178, -0.369749, -12.576978, 0.000000, 0.000000, 261.105926, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -4.000110, 4.253038, -12.576978, 0.000000, 0.000000, 261.105926, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -10.360460, -6.433138, -10.353549, 0.000000, 0.000000, 171.075103, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -8.621310, 11.305350, -12.582288, 0.000000, 0.000000, 349.817596, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -11.080260, 11.498680, -12.477390, 0.000000, 0.000000, 172.912460, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -12.577078, -4.767529, -12.477390, 0.000000, 0.000000, 172.912460, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -8.258890, -5.371860, -12.477390, 0.000000, 0.000000, 169.809051, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -6.508600, -6.107028, -12.477390, 0.000000, 0.000000, 169.809051, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -5.634678, -0.635760, -12.477390, 0.000000, 0.000000, 214.088317, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -4.861548, 3.416249, -12.477390, 0.000000, 0.000000, 253.226638, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -3.144659, 10.073988, -12.477390, 0.000000, 0.000000, 172.912460, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1671, -7.349339, 9.597208, -12.072448, 0.000000, 0.000000, 350.925109, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -6.098370, 5.254118, -12.073840, 0.000000, 0.000000, 260.607177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -6.423530, 3.236629, -12.073840, 0.000000, 0.000000, 260.607177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -7.038528, 1.497609, -12.073840, 0.000000, 0.000000, 260.607177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -7.191520, -0.384779, -12.073840, 0.000000, 0.000000, 260.607177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -11.061010, 0.100390, -12.073840, 0.000000, 0.000000, 80.172523, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -10.711270, 2.151170, -12.073840, 0.000000, 0.000000, 80.172523, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -10.310070, 4.151420, -12.073840, 0.000000, 0.000000, 80.172523, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -9.791898, 5.803658, -12.073840, 0.000000, 0.000000, 80.172523, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -7.422800, 6.944378, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -8.943380, -2.535190, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -15.482000, -10.408300, -12.595198, 0.000000, 0.000000, 259.855590, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -16.039699, -13.689998, -12.595198, 0.000000, 0.000000, 260.168701, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19446, -24.159839, -18.751590, -10.914500, 0.000000, 0.000000, 80.796997, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19446, -33.632530, -17.224069, -10.914500, 0.000000, 0.000000, 80.796997, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2132, -23.131200, -18.369800, -12.577698, 0.000000, 0.000000, 170.585205, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2134, -25.075740, -18.056970, -12.578350, 0.000000, 0.000000, 170.833633, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2134, -22.146730, -18.513099, -12.578350, 0.000000, 0.000000, 170.833633, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2133, -26.052789, -17.881380, -12.578220, 0.000000, 0.000000, 170.065185, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2141, -21.175149, -18.666669, -12.578148, 0.000000, 0.000000, 170.853103, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2133, -27.039409, -17.713529, -12.578220, 0.000000, 0.000000, 170.065185, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19174, -23.128749, -11.753918, -10.409830, 0.000000, 0.000000, 350.880218, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2165, -9.134168, -11.043880, -12.580148, 0.000000, 0.000000, 80.474586, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -9.853018, -13.464280, -10.353549, 0.000000, 0.000000, 170.772094, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -13.783828, -12.832558, -10.353549, 0.000000, 0.000000, 170.772094, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2614, -37.357791, -7.408490, -10.458290, 0.000000, 0.000000, 80.912513, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1828, -11.000530, -10.189888, -12.578410, 0.000000, 0.000000, 81.081947, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1705, -10.851058, -10.792148, -12.553930, 0.000000, 0.000000, 80.836433, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1714, -7.726270, -10.767680, -12.575940, 0.000000, 0.000000, 260.213378, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -14.194668, -6.490038, -12.570598, 0.000000, 0.000000, 80.592361, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2007, -14.315678, -7.252728, -13.084300, 0.000000, 0.000000, 80.833229, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -5.982800, -7.920030, -12.578558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1417, -10.437560, -7.134819, -12.316598, 0.000000, 0.000000, 351.605651, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2271, -8.039608, -7.695209, -10.538040, 0.000000, 0.000000, 350.749816, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -6.784190, -7.643448, -12.577488, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -12.178520, -7.126200, -10.593990, 0.000000, 0.000000, 350.338775, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1998, -8.047418, -14.726368, -12.578108, 0.000000, 0.000000, 260.596618, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -7.469398, -17.755809, -12.577090, 0.000000, 0.000000, 260.565155, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2181, -7.873040, -20.166709, -12.577870, 0.000000, 0.000000, 260.578582, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2193, -9.131770, -21.920700, -12.577738, 0.000000, 0.000000, 259.763854, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -13.509188, -21.186180, -12.577448, 0.000000, 0.000000, 351.290039, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -12.363180, -20.333509, -12.577448, 0.000000, 0.000000, 171.431076, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -11.940878, -17.927450, -12.577448, 0.000000, 0.000000, 171.431076, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -11.411088, -14.214098, -12.577448, 0.000000, 0.000000, 351.290039, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -14.655770, -15.877638, -10.353549, 0.000000, 0.000000, 170.772094, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -9.612070, -14.439688, -12.570598, 0.000000, 0.000000, 350.347320, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -9.041468, -14.551150, -12.570598, 0.000000, 0.000000, 350.347320, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -7.391398, -16.621980, -12.570598, 0.000000, 0.000000, 260.606872, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -13.579058, -18.997900, -10.469570, 0.000000, 0.000000, 80.263229, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2615, -9.972510, -13.939900, -10.287118, 0.000000, 0.000000, 350.928039, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2271, -14.032010, -13.736828, -10.538040, 0.000000, 0.000000, 350.749816, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -12.503270, -17.064460, -12.477390, 0.000000, 0.000000, 170.489120, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -12.796588, -19.184360, -12.477390, 0.000000, 0.000000, 170.489120, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -12.834810, -22.102390, -12.477390, 0.000000, 0.000000, 329.413940, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -9.392628, -22.771480, -12.477390, 0.000000, 0.000000, 299.142883, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -8.821550, -20.501209, -12.477390, 0.000000, 0.000000, 261.009307, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -8.358498, -15.626910, -12.477390, 0.000000, 0.000000, 261.009307, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -10.590958, -14.860400, -12.477390, 0.000000, 0.000000, 349.618194, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -10.466678, -11.973050, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -11.989688, -21.450569, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -19.298099, -26.824699, -9.185810, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -32.166931, -15.090640, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -20.288890, -7.419990, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -30.637519, -5.612430, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -41.254600, -6.047729, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -18.623010, 2.033468, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2525, -8.476440, 13.031700, -12.577239, 0.000000, 0.000000, 261.232177, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2518, -10.193980, 13.754058, -12.576998, 0.000000, 0.000000, 350.561126, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -8.516868, 13.076338, -10.708200, 0.000000, 0.000000, 260.857513, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14782, -21.849489, 11.512318, -11.571000, 0.000000, 0.000000, 80.881378, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14782, -17.066469, 7.950640, -11.571000, 0.000000, 0.000000, 261.319580, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1808, -20.217199, 5.155930, -12.577948, 0.000000, 0.000000, 172.819046, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2986, -22.029289, 5.226490, -10.453969, 0.000000, 90.000000, 81.482398, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2397, -22.763240, 7.445118, -11.473628, 0.000000, 0.000000, 80.144523, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19100, -20.245300, 9.445098, -11.982198, 0.000000, 270.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -18.679529, 14.118840, -10.783928, 0.000000, 0.000000, 351.540740, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18637, -22.125669, 12.431870, -11.970600, 85.000000, 0.000000, 81.427200, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -17.154769, 11.509590, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -15.643500, 20.976829, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2200, -56.996520, -33.925331, -15.972438, 0.000000, 0.000000, 81.494422, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2200, -56.676441, -31.728519, -15.972438, 0.000000, 0.000000, 81.494422, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -56.031040, -29.776689, -15.970608, 0.000000, 0.000000, 81.569679, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -55.945289, -29.182519, -15.970608, 0.000000, 0.000000, 81.569679, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -55.944339, -28.549579, -15.970120, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -55.364170, -23.023639, -14.463608, 0.000000, 0.000000, 81.228126, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -55.669998, -25.004329, -14.463600, 0.000000, 0.000000, 81.588401, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -55.861831, -27.016000, -14.188610, 0.000000, 0.000000, 81.081871, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -54.399909, -18.316949, -15.266328, 0.000000, 0.000000, 351.502227, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2183, -52.901290, -24.721420, -15.985460, 0.000000, 0.000000, 351.461364, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2183, -53.595119, -29.450838, -15.985460, 0.000000, 0.000000, 351.461364, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2183, -48.899311, -33.866859, -15.985460, 0.000000, 0.000000, 351.461364, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2193, -50.246551, -18.865079, -15.973548, 0.000000, 0.000000, 351.158416, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2193, -48.409839, -19.162759, -15.973548, 0.000000, 0.000000, 351.158416, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2193, -46.576358, -19.476509, -15.973548, 0.000000, 0.000000, 351.158416, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -51.937618, -17.482210, -15.972188, 0.000000, 0.000000, 350.837310, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -49.326839, -18.968320, -15.972128, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -47.834789, -19.190710, -15.972128, 0.000000, 0.000000, 331.097442, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -45.780509, -19.634420, -15.972128, 0.000000, 0.000000, 345.101409, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -50.576309, -25.862039, -15.971758, 0.000000, 0.000000, 352.712921, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -52.431079, -25.584440, -15.971758, 0.000000, 0.000000, 352.712921, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -46.454860, -35.017429, -15.971758, 0.000000, 0.000000, 352.712921, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -53.507850, -30.401779, -15.971758, 0.000000, 0.000000, 352.712921, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -51.291149, -30.483209, -15.971758, 0.000000, 0.000000, 352.712921, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -50.994220, -27.969299, -15.971758, 0.000000, 0.000000, 133.515914, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -47.864311, -32.143459, -15.971758, 0.000000, 0.000000, 172.654235, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -46.261058, -32.374870, -15.971758, 0.000000, 0.000000, 172.654235, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -50.124431, -23.088960, -15.971758, 0.000000, 0.000000, 172.654235, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -52.220489, -23.071380, -15.971758, 0.000000, 0.000000, 172.654235, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14782, -41.720939, -36.378368, -15.066880, 0.000000, 0.000000, 171.725326, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -43.266510, -18.726970, -15.266328, 0.000000, 0.000000, 81.127937, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -38.264301, -19.490699, -15.266328, 0.000000, 0.000000, 81.127937, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -50.774929, -35.943710, -12.450160, 0.000000, 0.000000, 357.943786, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2198, -44.915550, -22.974109, -15.975150, 0.000000, 0.000000, 261.348876, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2198, -45.199958, -24.831529, -15.975150, 0.000000, 0.000000, 261.348876, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2198, -44.107669, -24.119949, -15.975150, 0.000000, 0.000000, 82.201301, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2198, -44.372249, -25.981340, -15.975150, 0.000000, 0.000000, 82.201301, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -46.215751, -25.461109, -15.971758, 0.000000, 0.000000, 268.211853, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -45.806068, -23.397960, -15.971758, 0.000000, 0.000000, 264.493194, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2356, -43.443359, -25.517950, -15.971758, 0.000000, 0.000000, 93.672950, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2164, -41.120910, -18.674379, -15.972579, 0.000000, 0.000000, 350.861755, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -39.068271, -25.605810, -15.973170, 0.000000, 0.000000, 81.674301, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19354, -39.598918, -25.473009, -16.920499, 0.000000, 0.000000, 352.058898, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19354, -37.769680, -24.202230, -16.920499, 0.000000, 0.000000, 261.825744, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -39.965690, -32.206558, -15.973170, 0.000000, 0.000000, 81.674301, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19354, -40.380619, -31.179710, -16.920499, 0.000000, 0.000000, 352.058898, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19354, -38.984260, -32.918449, -16.920499, 0.000000, 0.000000, 261.825744, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -38.365100, -33.399349, -15.971190, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -37.104999, -26.933969, -13.957778, 0.000000, 0.000000, 261.522827, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -38.169189, -32.416809, -15.971899, 0.000000, 0.000000, 171.767105, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1671, -37.733791, -25.079719, -15.481410, 0.000000, 0.000000, 265.490966, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1671, -38.899459, -31.538770, -15.481410, 0.000000, 0.000000, 263.599884, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1808, -36.854129, -23.977470, -15.972378, 0.000000, 0.000000, 261.794830, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -51.704250, -34.752849, -15.971899, 0.000000, 0.000000, 170.890975, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -39.850521, -34.805030, -14.969658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -38.450008, -21.496149, -14.969658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -52.699890, -19.127870, -14.969658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -53.892551, -33.002799, -14.969658, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14407, -8.458338, 19.343469, -15.760000, 0.000000, 0.000000, 260.895385, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14407, -8.435296, 23.155616, -18.079999, 0.000000, 0.000000, 80.651206, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -14.381500, 26.860300, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -5.032299, 21.162559, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1536, -6.510098, 31.380580, -16.146299, 0.000000, 0.000000, 80.117958, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1536, -6.044919, 34.337791, -16.146299, 0.000000, 0.000000, 260.101684, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -3.366260, 29.375730, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -12.835908, 36.339191, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -1.813740, 38.822910, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -11.313610, 45.828670, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -22.986820, 38.494228, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -24.521499, 29.057600, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -26.038150, 19.576810, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19325, -17.416620, 34.364589, -12.702158, 0.000000, 0.000000, 349.326293, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19466, -17.905689, 37.811088, -13.800000, 0.000000, 0.000000, 260.476013, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -20.188329, 31.478900, -16.142080, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19466, -19.137439, 31.285860, -13.800000, 0.000000, 0.000000, 260.476013, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -19.234039, 37.925251, -16.142080, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1892, -6.701468, 33.179931, -16.143720, 0.000000, 0.000000, 80.856857, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1892, -6.951508, 31.599580, -16.143720, 0.000000, 0.000000, 80.956863, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2001, -6.309820, 35.009510, -16.142280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -20.130130, 29.206399, -15.436260, 0.000000, 0.000000, 350.276214, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -18.464550, 40.295150, -15.436260, 0.000000, 0.000000, 350.987365, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2606, -17.904640, 35.519481, -12.956398, 40.000000, 0.000000, 261.780212, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2606, -18.253700, 33.299541, -12.956398, 40.000000, 0.000000, 261.780212, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2162, -20.499660, 30.640169, -16.183500, 0.000000, 0.000000, 261.151092, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2163, -20.950309, 42.817260, -16.143400, 0.000000, 0.000000, 350.628112, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2001, -19.112239, 42.143299, -16.141910, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1715, -19.761890, 33.740169, -16.144779, 0.000000, 0.000000, 79.883827, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1715, -19.309570, 36.041610, -16.144779, 0.000000, 0.000000, 79.883827, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2773, -15.619138, 34.214679, -15.638778, 0.000000, 0.000000, 260.411315, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2604, -23.826349, 28.322559, -15.391208, 0.000000, 0.000000, 170.716262, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2001, -21.303279, 27.937049, -16.142690, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1715, -23.181470, 29.592199, -16.142099, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19171, -19.043539, 40.060569, -14.005760, 90.000000, 270.000000, 350.871093, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -20.402469, 29.520769, -14.026740, 0.000000, 0.000000, 80.714073, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, -43.313369, 41.445800, -15.840820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, -16.383810, 38.190048, -15.840820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1726, -5.870490, 38.830989, -16.143539, 0.000000, 0.000000, 260.791137, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1726, -7.570230, 28.908369, -16.143539, 0.000000, 0.000000, 260.791137, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19172, -7.297248, 27.046810, -13.874710, 0.000000, 0.000000, 260.326202, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1216, -10.390870, 40.734191, -15.554770, 0.000000, 0.000000, 350.032562, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2263, -7.575650, 40.121990, -14.368330, 0.000000, 0.000000, 350.663574, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(948, -7.882510, 25.625770, -16.144439, 0.000000, 0.000000, 351.203826, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -15.970170, 26.731750, -16.144399, 0.000000, 0.000000, 351.140014, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -16.961069, 26.872079, -16.144399, 0.000000, 0.000000, 351.140014, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -17.971649, 27.016000, -16.144399, 0.000000, 0.000000, 350.736968, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2482, -24.195610, 43.271629, -16.143430, 0.000000, 0.000000, 350.327728, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -25.691810, 43.377079, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -27.152629, 43.615451, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -28.613439, 43.853839, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -30.054479, 44.089260, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -31.495529, 44.324699, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -32.957950, 43.587890, -16.242719, 0.000000, 0.000000, 78.668251, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -32.857238, 44.544200, -16.242719, 0.000000, 0.000000, 350.758544, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2475, -33.208530, 42.148990, -16.242719, 0.000000, 0.000000, 81.323837, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1580, -23.995189, 43.091369, -15.128318, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2034, -25.682960, 43.105998, -15.356308, 0.000000, 0.000000, 344.771575, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2036, -26.809009, 43.330310, -16.041770, 0.000000, 0.000000, 354.168273, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1580, -28.298770, 43.624790, -16.142200, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2384, -29.518629, 43.909980, -15.334138, 0.000000, 0.000000, 82.850151, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1580, -33.075321, 42.355560, -15.464698, 0.000000, 0.000000, 84.921653, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1580, -32.917709, 43.387619, -14.759690, 0.000000, 0.000000, 87.131149, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2045, -29.934999, 43.904300, -14.689498, 0.000000, 0.000000, 79.124801, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2043, -30.967199, 44.001300, -16.022899, 0.000000, 0.000000, 259.985198, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2043, -26.206529, 43.299289, -14.605810, 0.000000, 0.000000, 77.868659, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2886, -24.420330, 37.490718, -14.506850, 0.000000, 0.000000, 349.529937, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -33.146259, 41.219009, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -31.256620, 24.983879, -14.935798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3440, -30.668609, 28.695880, -14.935798, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19302, -31.135419, 25.618669, -12.764530, 0.000000, 270.000000, 261.621826, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19302, -30.745229, 28.072549, -12.764530, 0.000000, 270.000000, 260.711700, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -199.610290, 7450.458984, -7002.676269, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -2541.493896, 6412.913085, -8536.639648, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -43.257900, 31.667299, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -41.718521, 41.163410, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -53.562019, 33.347969, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -52.046821, 42.818641, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1892, -38.221969, 28.548690, -16.138809, 0.000000, 0.000000, 80.776336, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1892, -38.538700, 26.614349, -16.138809, 0.000000, 0.000000, 80.776336, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1498, -58.308448, 29.450229, -16.137979, 0.000000, 0.000000, 349.954864, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3657, -58.812500, 31.074899, -15.634900, 0.000000, 0.000000, 80.916999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2615, -59.121299, 31.204139, -13.830808, 0.000000, 0.000000, 81.044189, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1499, -53.731098, 29.589000, -16.125000, 0.000000, 0.000000, 80.665298, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3657, -38.284851, 32.066379, -15.626468, 0.000000, 0.000000, 261.230346, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3657, -37.772499, 35.402118, -15.626468, 0.000000, 0.000000, 261.230346, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19456, -47.721500, 42.648998, -14.385898, 0.000000, 0.000000, 80.752799, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19456, -47.019741, 47.354808, -14.385898, 0.000000, 0.000000, 170.718078, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -41.272289, 50.830181, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -51.566169, 52.459079, -16.223400, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -42.805809, 43.378959, -14.385898, 0.000000, 0.000000, 350.942993, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -42.299999, 46.538501, -14.385898, 0.000000, 0.000000, 350.942993, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -41.791000, 49.698101, -14.385898, 0.000000, 0.000000, 350.742004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19456, -47.224498, 45.750701, -14.385898, 0.000000, 0.000000, 80.346801, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19456, -46.712619, 48.887489, -14.385898, 0.000000, 0.000000, 80.346763, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19456, -46.202899, 52.046340, -14.385898, 0.000000, 0.000000, 80.346763, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -52.142490, 44.930969, -14.385898, 0.000000, 0.000000, 350.942993, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -51.629501, 48.114398, -14.385898, 0.000000, 0.000000, 350.742004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19393, -51.124370, 51.213581, -14.385898, 0.000000, 0.000000, 350.742004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1651, -36.302879, 52.238048, -14.169618, 0.000000, 0.000000, 80.921356, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2165, -51.781120, 38.133708, -16.138370, 0.000000, 0.000000, 260.820617, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1998, -57.298400, 33.220241, -16.137638, 0.000000, 0.000000, 81.109878, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -57.505809, 39.132789, -16.138479, 0.000000, 0.000000, 350.813323, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -55.794731, 38.971080, -16.136859, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -58.404350, 35.726150, -14.162528, 0.000000, 0.000000, 81.057289, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2604, -51.431140, 32.203948, -15.363800, 0.000000, 0.000000, 170.552337, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1806, -52.522171, 33.268630, -16.137550, 0.000000, 0.000000, 188.574554, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1806, -56.884880, 34.095668, -16.137550, 0.000000, 0.000000, 86.950019, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1714, -53.328189, 37.749160, -16.137210, 0.000000, 0.000000, 78.047988, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -52.703948, 38.314720, -14.166830, 0.000000, 0.000000, 351.252868, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -54.314460, 39.048431, -14.115200, 0.000000, 0.000000, 350.266754, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2000, -53.534580, 32.584339, -16.137670, 0.000000, 0.000000, 170.900161, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -55.185070, 32.565280, -13.783080, 0.000000, 0.000000, 171.401412, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2606, -45.349540, 35.349628, -13.185298, 45.000000, 0.000000, 259.933258, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2606, -45.728351, 33.202690, -13.185298, 45.000000, 0.000000, 259.933258, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1806, -46.603908, 35.971099, -16.137550, 0.000000, 0.000000, 251.010406, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1806, -46.990989, 33.156970, -16.137550, 0.000000, 0.000000, 260.998077, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -34.615360, 31.881250, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -36.131080, 22.380880, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -45.135501, 32.080699, -12.675600, 0.000000, 90.000000, 349.805999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -55.436321, 33.618610, -12.675600, 0.000000, 90.000000, 350.409088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -43.681598, 41.485298, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -53.980930, 43.054279, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -50.712539, 52.222309, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -40.407501, 50.694499, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -32.416469, 56.461799, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -48.204299, 43.345001, -16.136299, 0.000000, 0.000000, 351.027496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -47.120121, 43.157390, -16.136299, 0.000000, 0.000000, 351.027496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -47.676280, 46.480838, -16.136299, 0.000000, 0.000000, 351.027496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -47.184539, 49.642860, -16.136299, 0.000000, 0.000000, 350.617370, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -46.619018, 46.317821, -16.136299, 0.000000, 0.000000, 351.027496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1812, -46.121021, 49.458541, -16.136299, 0.000000, 0.000000, 351.027496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2602, -43.017299, 51.038848, -15.629960, 0.000000, 0.000000, 349.720977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2602, -43.676158, 47.904338, -15.629960, 0.000000, 0.000000, 349.720977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2602, -44.181991, 44.764228, -15.629960, 0.000000, 0.000000, 349.720977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2602, -50.298469, 45.780509, -15.629960, 0.000000, 0.000000, 349.720977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2602, -49.705921, 48.905101, -15.629960, 0.000000, 0.000000, 349.720977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -41.122261, 51.687141, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -40.966041, 52.654819, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -40.841999, 53.669029, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2690, -40.847229, 54.692428, -15.274550, 0.000000, 0.000000, 83.180580, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2690, -47.194808, 42.290401, -15.332440, 0.000000, 0.000000, 350.830322, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -49.420970, 42.727149, -14.225250, 0.000000, 0.000000, 350.715332, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -52.919189, 31.021379, -12.686200, 20.000000, 0.000000, 80.024497, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -56.863288, 40.384571, -12.697898, 20.000000, 0.000000, 125.958602, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -37.564990, 39.026111, -12.668498, 20.000000, 0.000000, 299.426300, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -37.823589, 54.681518, -12.668498, 20.000000, 0.000000, 334.385528, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1892, -53.368968, 29.789810, -16.138809, 0.000000, 0.000000, 80.776336, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -58.446369, 32.126911, -12.586198, 20.000000, 0.000000, 36.982810, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1216, -45.000480, 41.790889, -15.531760, 0.000000, 0.000000, 351.956207, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3390, -31.083459, 52.102081, -16.122930, 0.000000, 0.000000, 261.033813, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.768320, 53.251689, -16.138849, 0.000000, 0.000000, 214.354400, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -28.734909, 58.080341, -12.668498, 20.000000, 0.000000, 304.519653, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1516, -35.927810, 59.025730, -16.123020, 0.000000, 0.000000, 350.448089, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -34.072750, 58.781848, -16.138849, 0.000000, 0.000000, 262.389129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -34.186588, 57.767429, -16.138849, 0.000000, 0.000000, 262.389129, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.327350, 58.344051, -16.138849, 0.000000, 0.000000, 80.318466, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.552099, 57.265571, -16.138849, 0.000000, 0.000000, 80.318466, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1787, -10.054308, 43.278911, -15.239398, 0.000000, 0.000000, 81.658981, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1781, -36.015819, 59.417690, -15.437898, 0.000000, 0.000000, 29.872299, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1782, -35.997268, 59.072189, -15.532400, 0.000000, 0.000000, 28.339799, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1808, -42.685039, -3.243958, -15.971798, 0.000000, 0.000000, 80.358879, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2685, -59.438919, -18.248119, -14.389100, 0.000000, 0.000000, -98.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1778, -44.695758, -10.173390, -15.969160, 0.000000, 0.000000, 359.589874, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2688, -46.701450, 42.360050, -14.906648, 0.000000, 0.000000, 351.247222, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -55.673080, 52.148529, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -55.776870, 51.395618, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -55.883388, 50.622898, -16.138849, 0.000000, 0.000000, 260.837585, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1886, -37.218021, 52.890338, -12.668498, 20.000000, 0.000000, 132.339996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2165, -56.261150, 0.831910, -15.971070, 0.000000, 0.000000, 171.854110, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1663, -56.713378, 1.990339, -15.468170, 0.000000, 0.000000, 350.215270, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1705, -57.726341, -4.647688, -15.970418, 0.000000, 0.000000, 172.298171, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1705, -56.494918, -4.798970, -15.970418, 0.000000, 0.000000, 172.298171, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -61.066291, -0.030518, -15.264340, 0.000000, 0.000000, 351.528289, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -52.151161, 2.783998, -15.970720, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2200, -52.221881, 0.822529, -15.970290, 0.000000, 0.000000, 261.607513, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2200, -60.315898, 4.442890, -15.970290, 0.000000, 0.000000, 351.033386, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18636, -57.457901, 0.941500, -15.130000, 0.000000, 0.000000, 227.745803, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19521, -58.971408, 3.853480, -14.032600, 180.000000, 90.000000, 350.205200, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19942, -55.930240, 0.929718, -15.080590, 0.000000, 0.000000, 205.862243, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19172, -58.947811, -5.008958, -14.086370, 0.000000, 0.000000, 172.011962, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -60.583309, -4.290400, -15.970780, 0.000000, 0.000000, 171.727355, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -60.909988, 0.011749, -14.309160, 0.000000, 0.000000, 78.863662, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2608, -52.894191, -3.389270, -14.337940, 0.000000, 0.000000, 261.181121, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2000, -52.997859, -2.054080, -15.963998, 0.000000, 0.000000, 261.542938, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2000, -52.917728, -1.560549, -15.963998, 0.000000, 0.000000, 261.542938, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -56.495780, -0.567718, -15.970378, 0.000000, 0.000000, 351.930938, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -57.339481, -0.448529, -15.970378, 0.000000, 0.000000, 351.953399, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11749, -9.771940, 0.219678, -11.781558, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19942, -8.979688, 3.516880, -11.680568, 0.000000, 0.000000, 249.678466, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19942, -7.196168, 8.153248, -11.680568, 0.000000, 0.000000, 198.678970, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19835, -7.257790, 5.408040, -11.682128, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19835, -3.731220, 8.837800, -11.682128, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19521, -8.139498, 2.247800, -11.742500, 0.000000, -90.000000, 256.313385, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19142, -12.527998, 3.238399, -12.355098, 0.000000, -90.000000, 263.872314, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19142, -17.067920, 6.932710, -12.355098, 0.000000, -90.000000, 84.027458, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(334, -21.454629, 12.951808, -12.377518, 0.000000, 0.000000, 77.510368, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(343, -19.566419, 7.339778, -11.973958, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3390, -49.881950, 19.887840, -16.143100, 0.000000, 0.000000, 261.363037, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2613, -45.182628, 19.811309, -16.142089, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2132, -44.412338, 26.433700, -16.142919, 0.000000, 0.000000, 261.465698, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2152, -44.406379, 24.437440, -16.143079, 0.000000, 0.000000, 261.297027, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2152, -44.605381, 23.132530, -16.143079, 0.000000, 0.000000, 261.297027, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2152, -44.801361, 21.847379, -16.143079, 0.000000, 0.000000, 261.297027, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2152, -44.997360, 20.562240, -16.143079, 0.000000, 0.000000, 261.297027, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11736, -44.473159, 22.754369, -14.298660, 90.000000, 90.000000, 350.816314, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11738, -44.783298, 21.218200, -15.057700, 0.000000, 0.000000, 260.812103, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2685, -44.014739, 25.767719, -14.336798, 0.000000, 0.000000, 261.183410, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2491, -48.945190, 25.700559, -17.051679, 0.000000, 0.000000, 350.655700, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19623, -49.204170, 25.528360, -15.110300, 0.000000, 0.000000, 170.710006, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -48.875579, 27.514600, -16.142440, 0.000000, 0.000000, 170.327743, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19809, -44.588741, 23.902469, -15.031298, 0.000000, 0.000000, 354.812103, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -49.485019, 21.256889, -16.142440, 0.000000, 0.000000, 157.029815, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19893, -45.465579, 32.957199, -15.105198, 0.000000, 0.000000, 261.183807, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19805, -6.795188, 11.539440, -10.669368, 0.000000, 0.000000, 350.492065, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19893, -8.345108, 8.468918, -11.773248, 0.000000, 0.000000, 144.453643, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19781, -15.502280, -10.095910, -10.977198, 90.000000, 90.000000, 353.653228, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19777, -16.458309, -15.600950, -10.956560, 90.000000, 90.000000, 169.313156, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11749, -52.007728, 36.955421, -15.347848, 0.000000, 0.000000, 16.515180, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19834, -53.481800, 30.332069, -13.436260, 0.000000, 0.000000, 80.602012, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19805, -51.003040, 23.779939, -14.145408, 0.000000, 0.000000, 81.248626, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -14.787549, 42.527019, -16.141660, 0.000000, 0.000000, 350.814849, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -15.354370, 45.414878, -16.141660, 0.000000, 0.000000, 171.654510, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -9.610388, 41.664680, -16.141660, 0.000000, 0.000000, 351.672760, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -15.811058, 42.712600, -16.141660, 0.000000, 0.000000, 350.924133, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(948, -18.194679, 42.824638, -16.142650, 0.000000, 0.000000, 352.106750, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -14.347620, 45.251068, -16.141660, 0.000000, 0.000000, 171.654510, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -9.086448, 44.546100, -16.141660, 0.000000, 0.000000, 170.531143, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(948, -5.346078, 40.725688, -16.142259, 0.000000, 0.000000, 351.495635, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1787, -32.719398, 58.701599, -15.241498, 0.000000, 0.000000, 351.706878, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1787, -14.310640, 43.924251, -15.239398, 0.000000, 0.000000, 261.891693, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14532, -5.025198, 42.530601, -15.148500, 0.000000, 0.000000, 81.298599, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2270, -7.668660, 41.357498, -14.376540, 0.000000, 0.000000, 170.688644, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2164, -12.785140, 47.823028, -16.142120, 0.000000, 0.000000, 352.231628, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2690, -10.572480, 47.487628, -15.431288, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19825, -11.427080, 47.630439, -13.663370, 0.000000, 0.000000, 352.347167, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19825, -17.099569, 34.381340, -13.337968, 0.000000, 0.000000, 84.201690, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1775, -19.337699, 26.451599, -15.055600, 0.000000, 0.000000, 351.690307, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -5.880808, 41.491779, -14.223950, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -19.806400, 37.611560, -14.222949, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -24.220760, 23.355060, -14.222949, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -22.960329, 30.528640, -14.222949, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -25.948499, 39.483528, -14.222949, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14438, -7.672369, 33.316669, -10.637518, 0.000000, 0.000000, 353.640716, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -14.596150, 42.302150, -14.223950, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -10.384730, 41.897560, -14.223950, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -15.127658, 21.794689, -14.223950, 0.000000, 0.000000, 354.774017, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -8.070110, 21.572759, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2614, -9.541749, 23.478830, -10.495498, 0.000000, 0.000000, 81.112442, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11710, -38.576019, 4.459670, -13.325518, 0.000000, 0.000000, 350.784149, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11706, -37.208889, -4.308178, -15.970298, 0.000000, 0.000000, 260.998046, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1808, -13.644260, 23.671140, -12.578498, 0.000000, 0.000000, 170.806991, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -14.381830, 24.101390, -12.578028, 0.000000, 0.000000, 171.213455, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -11.766980, 26.507270, -12.577150, 0.000000, 0.000000, 171.531036, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1715, -12.636678, 27.775709, -12.576820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -11.983940, 25.212980, -12.576869, 0.000000, 0.000000, 351.634857, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -12.976280, 25.338029, -12.576869, 0.000000, 0.000000, 351.634857, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19781, -12.613730, 23.117790, -11.124858, 90.000000, 90.000000, 80.868659, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19805, -11.571188, 30.446199, -10.481820, 0.000000, 0.000000, 351.229187, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2001, -9.032110, 29.726100, -12.578240, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2163, -14.264348, 30.820600, -12.577770, 0.000000, 0.000000, 351.395172, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2066, -10.114080, 23.453229, -12.577710, 0.000000, 0.000000, 170.950210, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -9.429530, 26.200410, -10.552820, 0.000000, 0.000000, 261.310577, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2267, -14.609370, 23.656070, -10.347370, 0.000000, 0.000000, 169.863220, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -11.562258, 17.955310, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -15.190468, 25.591690, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -16.689529, 10.535340, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -18.212749, 2.173368, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1753, -14.054690, -18.532730, -12.578228, 0.000000, 0.000000, 260.562408, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11706, -19.966489, -18.993869, -12.576720, 0.000000, 0.000000, 13.211258, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19787, -19.421829, -19.833240, -10.491760, 0.000000, 0.000000, 80.401741, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2229, -13.350468, -16.925790, -12.576620, 0.000000, 0.000000, 303.269714, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11743, -22.077030, -18.743759, -11.522028, 0.000000, 0.000000, 198.372344, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19859, -58.881069, -15.755350, -14.777480, 0.000000, 0.000000, 260.704498, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19779, -55.627960, -5.667418, -14.653300, 90.000000, 0.000000, 350.984680, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19370, -9.703068, 13.777210, -9.109900, 0.000000, 90.000000, 351.092132, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19370, -6.279980, 13.254038, -9.109900, 0.000000, 90.000000, 351.092132, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -13.907520, 30.379619, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -30.529060, 46.479480, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -37.598201, 53.344001, -16.136699, 0.000000, 0.000000, 81.054702, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -38.070301, 50.189201, -16.136699, 0.000000, 0.000000, 81.054702, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -10.106430, 45.241241, -16.142450, 0.000000, 0.000000, 81.544692, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -27.860990, 28.414199, -16.142450, 0.000000, 0.000000, 350.327728, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -26.386480, 37.859550, -16.142450, 0.000000, 0.000000, 350.327728, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -13.686498, 45.752998, -16.142499, 0.000000, 0.000000, 81.544700, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11714, -57.080600, 44.542499, -14.869098, 0.000000, 0.000000, 350.548400, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11710, -57.112831, 44.566219, -13.414440, 0.000000, 0.000000, 79.718032, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -12.241000, 23.134000, -12.577798, 0.000000, 0.000000, 351.663665, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -0.376230, 48.260501, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -21.466739, 47.964939, -12.675600, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -47.678989, 22.903919, -12.675600, 0.000000, 90.000000, 349.805999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1753, -40.099090, -14.120638, -15.971420, 0.000000, 0.000000, 171.875579, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(949, -43.958271, -13.428350, -15.259340, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1819, -39.072731, -14.681038, -15.970560, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -65.381607, -20.571620, -15.279600, 0.000000, 0.000000, 352.886444, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2611, -58.245868, -12.003910, -14.212800, 0.000000, 0.000000, 81.892280, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1722, -58.120109, -11.557800, -15.970748, 0.000000, 0.000000, 261.403472, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1722, -58.267719, -12.576728, -15.970748, 0.000000, 0.000000, 261.403472, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(949, -44.313289, -7.850580, -15.366410, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2269, -49.754428, -9.539030, -14.351698, 0.000000, 0.000000, 171.441894, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -19.835819, -8.090028, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -30.148620, -10.538269, -10.578668, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -41.746330, 1.567209, -14.163660, 0.000000, 0.000000, 260.009277, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -38.910068, -6.742790, -14.163660, 0.000000, 0.000000, 349.613098, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -39.906749, -13.324958, -14.163660, 0.000000, 0.000000, 349.613098, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14699, -49.023708, -10.937258, -14.163660, 0.000000, 0.000000, 349.613098, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -40.488998, 1.710000, -12.899998, 0.000000, 0.000000, 351.883392, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.869998, 1.281298, -13.245800, 0.000000, 0.000000, 351.883392, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -27.323410, -30.234119, -9.477000, 0.000000, 0.000000, 350.705078, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -40.460731, 1.895429, -15.016300, 180.000000, 0.000000, 351.883392, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.843299, 1.469200, -15.016300, 180.000000, 0.000000, 351.883392, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -43.966098, -9.965298, -16.129898, 0.000000, 0.000000, 80.966102, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.189098, 52.162200, -13.624500, 90.000000, 0.000000, 81.448799, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.947200, 52.229000, -14.338800, 0.000000, 0.000000, 354.540405, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -35.256408, 51.970939, -14.338800, 0.000000, 0.000000, 354.540405, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.189098, 52.162200, -14.988800, 90.000000, 0.000000, 81.448799, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1744, -25.881950, -18.551610, -11.124798, 0.000000, 0.000000, 170.231979, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1744, -23.270549, -18.961860, -10.824798, 0.000000, 0.000000, 170.231979, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2867, -25.237739, -18.192930, -11.530220, 0.000000, 0.000000, 14.886658, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2856, -26.655660, -18.048469, -10.791250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2829, -23.284059, -18.465560, -11.539999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2863, -23.480100, -18.679500, -10.482898, 0.000000, 0.000000, 109.601280, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2687, -24.120689, -18.637889, -11.021698, 0.000000, 0.000000, 170.945663, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19825, -19.124500, -17.136400, -9.805898, 0.000000, 0.000000, 261.394592, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1969, -20.008859, -14.972378, -11.979260, 0.000000, 0.000000, 351.304443, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -6.670080, -23.081129, -9.166950, 0.000000, 0.000000, 350.257659, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1969, -19.705839, -12.703060, -11.979260, 0.000000, 0.000000, 351.404449, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2747, -23.260110, -14.535868, -12.154198, 0.000000, 0.000000, 350.928924, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2747, -27.029970, -14.003528, -12.154198, 0.000000, 0.000000, 350.928924, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2747, -22.890459, -12.351980, -12.154198, 0.000000, 0.000000, 350.928924, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2747, -26.732418, -11.739190, -12.154198, 0.000000, 0.000000, 350.928924, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -21.883209, -14.696390, -12.576938, 0.000000, 0.000000, 259.288574, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -24.311010, -14.370618, -12.576938, 0.000000, 0.000000, 81.654441, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -24.005170, -11.966070, -12.576938, 0.000000, 0.000000, 81.654441, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -27.748260, -11.467940, -12.576938, 0.000000, 0.000000, 81.654441, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -28.124809, -13.764430, -12.576938, 0.000000, 0.000000, 81.654441, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1720, -21.516809, -12.461750, -12.576938, 0.000000, 0.000000, 259.288574, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11706, -14.740360, -22.073219, -12.576720, 0.000000, 0.000000, 39.668060, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(949, -28.811199, -17.482500, -11.929498, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -24.505479, -17.240570, -9.166950, 0.000000, 0.000000, 350.609588, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -14.706809, -21.693080, -9.166950, 0.000000, 0.000000, 350.257659, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2614, -15.022370, -8.575180, -10.358288, 0.000000, 0.000000, 80.912513, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14794, -77.796600, -28.784099, -13.545700, 0.000000, 0.000000, 82.581497, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2627, -72.637718, -20.234529, -15.978638, 0.000000, 0.000000, 352.267272, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2627, -75.179367, -19.912410, -15.978638, 0.000000, 0.000000, 352.267272, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2627, -73.921188, -20.071870, -15.978638, 0.000000, 0.000000, 352.267272, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1985, -80.396438, -18.621509, -13.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1985, -83.922836, -20.987199, -13.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1985, -80.673797, -20.894500, -13.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1985, -86.190490, -20.693519, -13.013400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14782, -88.262603, -27.663400, -14.972498, 0.000000, 0.000000, 83.306701, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2631, -77.592781, -26.212499, -15.996800, 0.000000, 0.000000, 352.537994, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2631, -84.178100, -25.659900, -15.996800, 0.000000, 0.000000, 352.537994, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2631, -80.841522, -30.514249, -15.996800, 0.000000, 0.000000, 352.537994, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2631, -75.403083, -31.329929, -15.996800, 0.000000, 0.000000, 352.537994, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2628, -69.387992, -37.746768, -15.975440, 0.000000, 0.000000, 264.638732, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2628, -71.923652, -34.357460, -15.975440, 0.000000, 0.000000, 82.919113, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2629, -83.998443, -33.769149, -15.976670, 0.000000, 0.000000, 354.241088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2630, -88.550056, -32.537448, -15.978948, 0.000000, 0.000000, 82.849777, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2630, -88.889236, -35.584461, -15.978948, 0.000000, 0.000000, 82.849777, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2630, -88.719596, -34.060451, -15.978948, 0.000000, 0.000000, 82.849777, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -57.940528, -24.079900, -15.279600, 0.000000, 0.000000, 83.040496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(638, -57.940528, -24.079900, -15.279600, 0.000000, 0.000000, 83.040496, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2714, -65.662849, -20.537460, -14.040768, 0.000000, 0.000000, 83.209259, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2616, -63.518890, -23.767959, -14.344538, 0.000000, 0.000000, 173.440231, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -59.880088, -20.228229, -15.969799, 0.000000, 0.000000, 82.338897, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -59.990070, -21.098569, -15.969799, 0.000000, 0.000000, 81.828796, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2163, -49.386829, -10.073260, -15.969690, 0.000000, 0.000000, 171.749069, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(949, -56.904430, -5.854518, -15.365928, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -37.816501, -34.009700, -9.133798, 0.000000, 0.000000, 351.867309, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -36.146701, -22.962499, -9.110798, 0.000000, 0.000000, 351.564208, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -27.416418, -29.532070, -9.082308, 0.000000, 0.000000, 352.221923, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -36.146598, -22.962099, -11.371898, 0.000000, 0.000000, 351.564208, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19325, -36.346000, -23.777999, -10.414098, 0.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19325, -37.292278, -30.352750, -10.414090, 0.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -37.816398, -34.009700, -11.371898, 0.000000, 0.000000, 351.867309, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(9131, -27.416418, -29.532070, -11.351948, 0.000000, 0.000000, 352.173034, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -57.443759, -40.276618, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -31.041959, -34.715049, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19805, -28.610120, -36.767021, -10.975998, 0.000000, 0.000000, 260.635986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19805, -27.814710, -31.909830, -10.975998, 0.000000, 0.000000, 260.635986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2491, -29.842599, -33.877399, -13.394300, 0.000000, 0.000000, 351.100189, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19610, -30.253498, -34.051399, -11.483200, 65.000000, 0.000000, 265.505187, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1840, -27.580789, -29.955820, -10.043100, 0.000000, -30.000000, 36.645828, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1840, -29.071479, -38.693531, -10.043100, 0.000000, -30.000000, 314.092285, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.389801, -23.816799, -9.399998, 270.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.457851, -24.387319, -12.539299, 90.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.775218, -26.583459, -12.539299, 90.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.092189, -28.776859, -12.539299, 90.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.412101, -30.989458, -12.539299, 90.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.729301, -33.184501, -12.539299, 90.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.644500, -32.567001, -9.399998, 270.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.326999, -30.361299, -9.399998, 270.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.010929, -28.158969, -9.399998, 270.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.699001, -25.994300, -9.399998, 270.000000, 0.000000, 351.807800, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -37.224769, -34.095588, -12.496918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2001, -27.761520, -30.138399, -12.497179, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14604, -29.486280, -38.131301, -11.494958, 0.000000, 0.000000, 52.833808, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -57.377861, -3.200040, -12.747830, 0.000000, 0.000000, 351.651306, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -36.471668, -28.752420, -9.477000, 0.000000, 0.000000, 350.705078, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -33.250080, -29.638650, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -34.387218, -37.282768, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -34.066440, -35.239208, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -34.217529, -36.250339, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -32.565238, -37.560668, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -32.411628, -36.525779, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -32.261520, -35.514499, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.398069, -29.948999, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -32.111579, -34.504329, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.873140, -32.982021, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.714479, -31.969070, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -31.556270, -30.959030, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -33.876129, -34.235191, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -33.666648, -32.697120, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -33.527698, -31.676969, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1721, -33.388889, -30.657810, -12.497118, 0.000000, 0.000000, 261.416290, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.261001, -23.187200, -9.309329, 0.000000, 0.000000, 172.356506, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.814998, -33.741199, -11.386400, 0.000000, 0.000000, -10.356498, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -36.261001, -23.187200, -11.386400, 0.000000, 0.000000, 172.356506, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1897, -37.814998, -33.741199, -9.343890, 0.000000, 0.000000, -10.356498, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1703, -35.889930, -24.749980, -12.547430, 0.000000, 0.000000, 30.254880, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1704, -32.764530, -23.884529, -12.497710, 0.000000, 0.000000, 301.424499, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1704, -35.663761, -27.198400, -12.497710, 0.000000, 0.000000, 126.692733, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2815, -34.487281, -26.081399, -12.505000, 0.000000, 0.000000, 30.805400, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1822, -34.850410, -25.883579, -12.496470, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2852, -34.377300, -25.350500, -12.395700, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2200, -29.167060, -24.023920, -12.498020, 0.000000, 0.000000, 350.877838, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -27.095279, -27.917240, -10.651028, 0.000000, 0.000000, 260.786102, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2614, -28.267419, -34.344871, -10.931550, 0.000000, 0.000000, 260.724090, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -47.121719, -27.268430, -9.477000, 0.000000, 0.000000, 351.651306, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -59.555698, -17.900150, -12.747830, 0.000000, 0.000000, 351.651306, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -22.531400, 7.848480, -9.170180, 0.000000, 0.000000, 350.571166, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -5.489640, -8.944238, -9.170180, 0.000000, 0.000000, 350.571166, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -8.380708, 4.059720, -9.170180, 0.000000, 0.000000, 350.571166, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -50.865749, 39.674480, -12.714348, 0.000000, 0.000000, 350.115417, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -41.349601, 32.836738, -12.714348, 0.000000, 0.000000, 350.115417, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18075, -33.472370, 53.712078, -12.728670, 0.000000, 0.000000, 350.146820, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -3.978559, 24.081989, -14.895250, 0.000000, 0.000000, 319.724731, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2612, -4.377200, 20.601760, -13.420088, 0.000000, 0.000000, 260.035125, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -21.835409, -16.773080, -9.094900, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2165, -27.975748, 38.809368, -16.142370, 0.000000, 0.000000, 169.979675, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2165, -32.368320, 51.016071, -16.124628, 0.000000, 0.000000, 350.856506, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1703, -28.924390, 50.491130, -16.122100, 0.000000, 0.000000, 261.220275, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19172, -33.414421, 48.698291, -13.867130, 0.000000, 0.000000, 172.150741, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -19.298099, -26.824699, -9.288820, 0.000000, 90.000000, 350.843902, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19466, -43.150859, -36.657760, -10.599180, 0.000000, 0.000000, 81.840682, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2332, -41.560909, -40.077030, -10.822030, 0.000000, 0.000000, 261.617492, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2008, -43.953380, -40.230998, -12.497428, 0.000000, 0.000000, 82.193847, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1714, -42.703990, -39.965831, -12.497308, 0.000000, 0.000000, 262.082366, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14455, -50.911548, -41.977218, -10.969148, 0.000000, 0.000000, 351.964630, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -36.458271, -19.782829, -15.973170, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14806, -54.617221, -38.224739, -11.779898, 0.000000, 0.000000, 81.168228, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1705, -51.636440, -35.759170, -12.499110, 0.000000, 0.000000, 289.165893, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1705, -51.769630, -40.565399, -12.499110, 0.000000, 0.000000, 211.657424, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2204, -49.746921, -35.824188, -12.520830, 0.000000, 0.000000, 351.218444, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1828, -51.701999, -38.573799, -12.517498, 0.000000, 0.000000, 352.860504, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -27.111000, -25.002990, -12.450160, 0.000000, 0.000000, 357.943786, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2606, -48.784198, -36.139900, -10.505599, 0.000000, 0.000000, 351.137908, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2260, -52.675350, -35.767620, -10.567930, 0.000000, 0.000000, 350.971710, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2202, -41.838241, -37.431198, -12.498180, 0.000000, 0.000000, 262.349426, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2310, -45.161109, -38.933998, -12.009900, 0.000000, 0.000000, 172.257507, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2310, -45.326198, -40.202598, -12.009900, 0.000000, 0.000000, 172.257507, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2269, -44.144969, -42.395149, -10.419508, 0.000000, 0.000000, 172.237579, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2855, -48.602638, -36.247421, -11.757450, 0.000000, 0.000000, 79.664703, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14705, -50.010501, -35.996200, -10.472498, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2010, -44.243549, -41.041778, -12.498060, 0.000000, 0.000000, 319.882965, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19808, -48.686500, -36.154991, -11.474188, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11738, -47.776519, -36.481048, -11.709198, 0.000000, 0.000000, 351.173889, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19521, -47.804359, -36.366168, -11.078800, 0.000000, -91.000000, 195.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1491, -55.045200, -19.825000, -16.152999, 0.000000, 0.000000, 261.737792, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -42.642700, -42.823890, -12.450160, 0.000000, 0.000000, 357.943786, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -41.386199, -33.140319, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19377, -47.212360, -41.973529, -9.389100, 0.000000, 90.000000, 350.948913, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2108, -35.534851, -23.426469, -12.450160, 0.000000, 0.000000, 357.943786, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, -17.596090, 30.341489, -15.840820, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
}