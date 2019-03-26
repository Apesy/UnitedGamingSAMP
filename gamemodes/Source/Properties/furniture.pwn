//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

/*
    House & Business Furniture
*/

#include <YSI\y_hooks>

#define MAX_FURNITURE 20000

enum furnitureEnum
{
    furID,
    furHouseID,
    furModelID,
    furObjectName[128],
    Float:furX,
    Float:furY,
    Float:furZ,
    Float:furRX,
    Float:furRY,
    Float:furRZ,
    furWorld,
    furInterior,
    furAddedBy[MAX_PLAYER_NAME],
    furAddedDate[32],

    Texture1TXD[32],
    Texture1Texture[32],
    Texture1Colour,
    Texture1ModelID,

    Texture2TXD[32],
    Texture2Texture[32],
    Texture2Colour,
    Texture2ModelID,

    Texture3TXD[32],
    Texture3Texture[32],
    Texture3Colour,
    Texture3ModelID,

    Texture4TXD[32],
    Texture4Texture[32],
    Texture4Colour,
    Texture4ModelID,

    Texture5TXD[32],
    Texture5Texture[32],
    Texture5Colour,
    Texture5ModelID,

    furObjectID,
}
new FurnitureInfo[MAX_FURNITURE][furnitureEnum];

new const furnitureCategories[][] =
{
	{"Appliances"},
	{"Bathroom"},
	{"Bedroom"},
	{"Carpets"},
	{"Kitchen"},
	{"Tables"},
	{"Chairs"},
	{"Posters/Frames"},
	{"Storage"},
	{"Plants"},
	{"Trash"},
	{"Doors"},
	{"Walls"},
	{"Decor"}
};

enum furnitureItemsEnum
{
    Model,
    Name[128],
    Price,
    Category
};
new furnitureItems[][furnitureItemsEnum] = 
{
    // Appliances
    {2135, "Cooker 1", 500, 0},
    {2170, "Cooker 2", 500, 0},
    {2417, "Cooker 3", 500, 0},
    {2144, "Cooker 4", 500, 0},
    {2294, "Cooker 5", 500, 0},
    {19915, "Cooker 6", 500, 0},
    {1773, "Shit Cooker 1", 100, 0},
    {1777, "Shit Cooker 2", 100, 0},
    {19923, "Island Cooker 1", 700, 0},
    {2500, "Sprunk Machine", 250, 0},
    {19830, "Blender", 150, 0},
    {1208, "Dish Washer", 150, 0},
    {1203, "Washing Machine", 150, 0},

    // Bathroom
    {2515, "Wash Basin 1", 250, 1},
    {2739, "Wash Basin 2", 250, 1},
    {2528, "Toilet 1", 450, 1},
    {2521, "Toilet 2", 450, 1},
    {2525, "Toilet 3", 450, 1},
    {2748, "Toilet 4", 450, 1},
    {2514, "Toilet 5", 450, 1},
    {2602, "Jail Toilet", 500, 1},
    {2527, "Shower 1", 600, 1},
    {2520, "Shower 2", 600, 1},
    {2517, "Shower 3", 600, 1},
    {2526, "Bath 1", 600, 1},
    {2516, "Bath 2", 600, 1},
    {2519, "Bath 3", 600, 1},

    // Bedroom
    {2302, "Double Bed 1", 350, 2},
    {1794, "Double Bed 2", 350, 2},
    {14866, "Double Bed 3", 350, 2},
    {11720, "Double Bed 4", 350, 2},
    {1700, "Double Bed 5", 350, 2},
    {2300, "Double Bed 6", 350, 2},
    {2301, "Double Bed 7", 350, 2},
    {2090, "Double Bed 8", 350, 2},
    {1796, "Single Bed", 250, 2},
    {1800, "Prison Bed", 100, 2},

    // Carpets
    {2631, "Red Mat", 50, 3},
    {2632, "Green Mat", 50, 3},
    {2842, "Burgundy Mat", 50, 3},
    {11737, "Rockstar Mat", 50, 3},
    {1828, "Bug Cat Rug", 150, 3},
    {2835, "Oval Rug", 50, 3},

    // Kitchen
    {2130, "White Sink/Counter", 500, 4},
    {2137, "White Sink", 500, 4},
    {2134, "White counter", 500, 4},
    {2131, "White fridge", 500, 4},
    {2133, "White drawers", 500, 4},
    {2341, "White corner", 500, 4},
    {2141, "White cupboard", 500, 4},

    // Tables
    {2644, "Wood Table 1", 100, 4},
    {2370, "Square Coffee Table 1", 100, 5},
    {2083, "Square Coffee Table 2", 100, 5},
    {1827, "Round Coffee Table 1", 100, 5},
    {1820, "Round Coffee Table 2", 100, 5},
    {2319, "Rectangle Table 1", 100, 5},
    {1814, "Rectangle Table 2", 100, 5},
    {2357, "Rectangle Table 3", 200, 5},
    {2115, "Rectangle Table 4", 200, 5},

    // Chair
    {1811, "Wooden Chair 1", 100, 6},
    {2636, "Wooden Chair 2", 100, 6},
    {2310, "Wooden Chair 3", 100, 6},
    {2079, "Wooden Chair 4", 100, 6},
    {2356, "Office Chair 1", 100, 6},
    {1671, "Office Chair 2", 100, 6},
    {1663, "Office Chair 3", 100, 6},
    {1714, "Office Chair 4", 100, 6},

    // Posters/Frames
    {2641, "Double Barreled Burger", 10, 7},
    {2685, "Wash Hands", 10, 7},
    {19328, "Monkey", 10, 7},
    {2695, "Base 5", 10, 7},
    {2277, "Cat", 10, 7},
    {19172, "Los Santos", 10, 7},
    {19174, "San Fierro", 10, 7},
    {19173, "San Fierro 2", 10, 7},
    {2282, "Forest", 10, 7},
    {2258, "City", 10, 7},
    {2263, "City at Night", 10, 7},
    {2273, "Flowers", 10, 7},

    // Storage
    {2307, "Wooden Wardrobe 1", 100, 8},
    {2329, "Wooden Wardrobe 2", 100, 8},
    {11729, "Locker", 100, 8},
    {2000, "Single Filing Cabinet", 50, 8},
    {2007, "Double Filing Cabinet", 50, 8},
    {2197, "Office Case", 50, 8},
    {2191, "Filng Cabinet with books", 50, 8},
    {912, "Open Wooden Cabinet", 50, 8},
    {19899, "Tool Cabinet 1", 100, 8},
    {19900, "Tool Cabinet 2", 100, 8},
    {2167, "Office Case", 80, 8},

    // Plants
    {2001, "Plant 1", 80, 9},
    {2241, "Plant 2", 80, 9},
    {2245, "Plant 3", 80, 9},
    {625, "Plant 4", 80, 9},

    // Trash
    {1330, "Trash Can 1", 100, 10},
    {11706, "Trash Can 2", 100, 10},
    {2770, "Clukin Bell Trash Can", 100, 10},
    {926, "Box 1", 5, 10},
    {928, "Box 2", 5, 10},
    {2670, "Rubbish 1", 5, 10},
    {2671, "Rubbish 2", 5, 10},
    {2672, "Rubbish 3", 5, 10},
    {2673, "Rubbish 4", 5, 10},

    // Doors & Gates
    {1502, "Wood Door", 100, 11},
    {1492, "Green Door", 100, 11},
    {1494, "Dark Door", 100, 11},
    {1499, "Ugly Door", 100, 11},
    {1499, "Ugly Door", 100, 11},

    // Doors & Gates
    {19368, "Concrete Wall 1", 500, 12},
    {19367, "Concrete Wall 2", 500, 12},
    {19366, "Wood Wall 1", 500, 12},
    {19370, "Wood Wall 2", 500, 12},
    {19362, "White Floor Small", 500, 12},
    {19377, "White Floor Big", 500, 12},
    {19380, "Sand Floor", 500, 12},

    // Decor
    {1781, "Old TV 1", 100, 13},
    {14772, "Old TV 2", 100, 13},
    {1518, "Old TV 3", 100, 13},
    {1747, "Old TV 4", 100, 13},
    {1751, "Old TV 5", 100, 13},
    {1752, "Old TV 6", 100, 13},
    {1786, "Big Old TV", 100, 13},
    {19786, "Big Flat Screen TV", 100, 13},
    {19787, "Small Flat Screen TV", 100, 13},
    {2190, "Old PC", 100, 13},
    {2894, "Rhyme Book", 100, 13},
    {2961, "Fire Alarm", 100, 13},
    {19273, "Keypad", 100, 13},
    {18659, "Graffiti 1", 5, 13},
    {18660, "Graffiti 2", 5, 13},
    {18661, "Graffiti 3", 5, 13},
    {18667, "Graffiti 4", 5, 13},
    {18663, "Graffiti 5", 5, 13},
    {18665, "Graffiti 6", 5, 13}
};

enum e_FurnitureTextures
{
    Model_ID,
    TXD_Name[32],
    Texture_Name[32],
    Show_Name[32],
    Category
};
new FurnitureTextures[][e_FurnitureTextures] = 
{
    // Basic
    {16150, "ufo_bar", "GEwhite1_64", "White", 0}, // White
    {5716, "sunrise02_lawn", "duskyred_64", "Red", 0}, // Red
    {8839, "garag3_lawn", "bluestucco1", "Blue", 0}, // Blue
    {18233, "cuntwshopscs_t", "orange1", "Orange", 0}, // Orange
    {8839, "vgsecarshow", "lightgreen2_32", "Green", 0}, // Green
    {1676, "wshxrefpump", "black64", "Black", 0}, // Black
    {8839, "vgsecarshow", "lightpurple2_32", "Light Purple", 0}, // Black

    // Wall
    {18265, "vgsecarshow", "sw_wallbrick_06", "Yellow Brick", 1},
    {12959, "sw_library", "sw_brick05", "Red Brick", 1},
    {18265, "w_town3cs_t", "ws_redbrickold", "Old Red Brick", 1},
    {16150, "ufo_bar", "stonewall2_la", "Stone Wall 1", 1},
    {6057, "venicegb02_law", "stonewall3_la", "Stone Wall 2", 1},
    {12937, "sw_oldshack", "stonewall3_la", "Stone Wall 3", 1},
    {17514, "landhub", "stoneclad1", "Stone Wall 4", 1},
    {4032, "lanpolicecp", "poundwall1_sfe", "Police Wall", 1},

    // Ground
    {3890, "libertygen", "mp_snow", "Snow", 2},
    {9135, "vgseseabed", "sw_sand", "Sand", 2},
    {8463, "vgseland", "Grass_128HV", "Grass", 2},
    {16109, "des_se1", "des_crackeddirt1", "Cracked", 2},
    {8459, "vgsland2", "Heliconcrete", "Grey Concrete", 2},
    {6328, "sunset04_law2", "ws_carparknew2", "Black Concrete", 2},

    // Floor
    {5134, "wasteland_las2", "floorboard256128", "Wood", 3},
    {9947, "lombard", "pier69_ground1", "White Wood", 3},
    {18265, "w_town3cs_t", "sw_barnwoodblu", "Blue Wood", 3},
    {16150, "ufo_bar", "sa_wood08_128", "Modern Wood", 3},
    {16150, "ufo_bar", "dinerfloor01_128", "Black and White", 3},
    {13007, "sw_bankint", "beige_64", "White Concrete", 3},
    {13691, "bevcunto2_lahills", "ws_floortiles2", "Pattern Brick", 3},

    // Other
    {3947, "rczero_track", "waterclear256", "Water", 4},
    {3853, "gay_xref", "ws_gayflag2", "Rainbow", 4},
    {12853, "cunte_gas01", "cj_flag2", "Confederate Flag", 4},
    {6357, "sunstrans_law2", "SunBillB05", "Candy Suxx", 4},
    {6357, "sunstrans_law2", "SunBillB10", "92' Elegance", 4}
};

stock GetMaxFurniture(playerid)
{
    new maxFurn;
    switch(Player[playerid][DonateLevel])
    {
        case 0: maxFurn = 50;
        case 1: maxFurn = 100;
        case 2: maxFurn = 250;
        case 3: maxFurn = 500;
    }
    return maxFurn;
}

stock DeleteFurniture(id)
{
    if(id < 0 || !FurnitureInfo[id][furID]) return 0;
}

stock GetNextFurnitureID()
{
    for(new i; i < MAX_FURNITURE; i++)
    {
        if(!FurnitureInfo[i][furID])
        {
            return i;
        }
    }
    return -1;
}

stock LoadFurniture()
{
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `Furniture` LIMIT %i", MAX_FURNITURE);
    mysql_tquery(g_SQL, query, "OnLoadFurniture");
}

stock ReloadFurniture(i)
{
    if(i != -1 && FurnitureInfo[i][furID])
    {
        if(IsValidDynamicObject(FurnitureInfo[i][furObjectID]))
            DestroyDynamicObject(FurnitureInfo[i][furObjectID]);

        FurnitureInfo[i][furObjectID] = CreateDynamicObject(
            FurnitureInfo[i][furModelID], 
            FurnitureInfo[i][furX], 
            FurnitureInfo[i][furY], 
            FurnitureInfo[i][furZ], 
            FurnitureInfo[i][furRX], 
            FurnitureInfo[i][furRY], 
            FurnitureInfo[i][furRZ], 
            .interiorid = HouseInfo[FurnitureInfo[i][furHouseID]][HouseInteriorInt],
            .worldid = FurnitureInfo[i][furHouseID]
        );

        if(strlen(FurnitureInfo[i][Texture1TXD]) > 0)
        {
            SetDynamicObjectMaterial(FurnitureInfo[i][furObjectID], 0, FurnitureInfo[i][Texture1ModelID], FurnitureInfo[i][Texture1TXD], FurnitureInfo[i][Texture1Texture], FurnitureInfo[i][Texture1Colour]);
        }
        if(strlen(FurnitureInfo[i][Texture2TXD]) > 0)
        {
            SetDynamicObjectMaterial(FurnitureInfo[i][furObjectID], 1, FurnitureInfo[i][Texture2ModelID], FurnitureInfo[i][Texture2TXD], FurnitureInfo[i][Texture2Texture], FurnitureInfo[i][Texture2Colour]);
        }
        if(strlen(FurnitureInfo[i][Texture3TXD]) > 0)
        {
            SetDynamicObjectMaterial(FurnitureInfo[i][furObjectID], 2, FurnitureInfo[i][Texture3ModelID], FurnitureInfo[i][Texture3TXD], FurnitureInfo[i][Texture3Texture], FurnitureInfo[i][Texture3Colour]);
        }
        if(strlen(FurnitureInfo[i][Texture4TXD]) > 0)
        {
            SetDynamicObjectMaterial(FurnitureInfo[i][furObjectID], 3, FurnitureInfo[i][Texture4ModelID], FurnitureInfo[i][Texture4TXD], FurnitureInfo[i][Texture4Texture], FurnitureInfo[i][Texture4Colour]);
        }
        if(strlen(FurnitureInfo[i][Texture5TXD]) > 0)
        {
            SetDynamicObjectMaterial(FurnitureInfo[i][furObjectID], 4, FurnitureInfo[i][Texture5ModelID], FurnitureInfo[i][Texture5TXD], FurnitureInfo[i][Texture5Texture], FurnitureInfo[i][Texture5Colour]);
        }
    }
    return 1;
}

stock SaveFurniture(i)
{
    if(i != -1 && FurnitureInfo[i][furID] > 0)
    {
        new query[256];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `HouseID` = %d, `ModelID` = %d, `ObjectName` = '%e', `X` = %f, `Y` = %f, `Z` = %f, `RX` = %f, `RY` = %f, `RZ` = %f, `Interior` = %d WHERE `Furniture`.`ID` = %d", 
        FurnitureInfo[i][furHouseID],
        FurnitureInfo[i][furModelID], 
        FurnitureInfo[i][furObjectName], 
        FurnitureInfo[i][furX], 
        FurnitureInfo[i][furY], 
        FurnitureInfo[i][furZ], 
        FurnitureInfo[i][furRX], 
        FurnitureInfo[i][furRY], 
        FurnitureInfo[i][furRZ],
        FurnitureInfo[i][furInterior],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `TXD1` = '%e', `Texture1` = '%e', `Colour1` = %d, `ModelID1` = %d WHERE `ID` = %d", 
        FurnitureInfo[i][Texture1TXD],
        FurnitureInfo[i][Texture1Texture],
        FurnitureInfo[i][Texture1Colour],
        FurnitureInfo[i][Texture1ModelID],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `TXD2` = '%e', `Texture2` = '%e', `Colour2` = %d, `ModelID2` = %d WHERE `ID` = %d", 
        FurnitureInfo[i][Texture2TXD],
        FurnitureInfo[i][Texture2Texture],
        FurnitureInfo[i][Texture2Colour],
        FurnitureInfo[i][Texture2ModelID],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `TXD3` = '%e', `Texture3` = '%e', `Colour3` = %d, `ModelID3` = %d WHERE `ID` = %d", 
        FurnitureInfo[i][Texture3TXD],
        FurnitureInfo[i][Texture3Texture],
        FurnitureInfo[i][Texture3Colour],
        FurnitureInfo[i][Texture3ModelID],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `TXD4` = '%e', `Texture4` = '%e', `Colour4` = %d, `ModelID4` = %d WHERE `ID` = %d", 
        FurnitureInfo[i][Texture4TXD],
        FurnitureInfo[i][Texture4Texture],
        FurnitureInfo[i][Texture4Colour],
        FurnitureInfo[i][Texture4ModelID],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);

        mysql_format(g_SQL, query, sizeof(query), "UPDATE `Furniture` SET `TXD5` = '%e', `Texture5` = '%e', `Colour5` = %d, `ModelID5` = %d WHERE `ID` = %d", 
        FurnitureInfo[i][Texture5TXD],
        FurnitureInfo[i][Texture5Texture],
        FurnitureInfo[i][Texture5Colour],
        FurnitureInfo[i][Texture5ModelID],
        FurnitureInfo[i][furID]);
        mysql_tquery(g_SQL, query);
        return 1;
    }
    return 0;
}

stock ResetFurniture(i)
{
    if(IsValidDynamicObject(FurnitureInfo[i][furObjectID]))
        DestroyDynamicObject(FurnitureInfo[i][furObjectID]);
    
    FurnitureInfo[i][furID] = 0;
    FurnitureInfo[i][furHouseID] = 0;
    FurnitureInfo[i][furModelID] = 0;
    FurnitureInfo[i][furObjectName][0] = 0;
    FurnitureInfo[i][furX] = 0.0;
    FurnitureInfo[i][furY] = 0.0;
    FurnitureInfo[i][furZ] = 0.0;
    FurnitureInfo[i][furRX] = 0.0;
    FurnitureInfo[i][furRY] = 0.0;
    FurnitureInfo[i][furRZ] = 0.0;
    FurnitureInfo[i][furWorld] = 0;
    FurnitureInfo[i][furInterior] = 0;
    FurnitureInfo[i][furAddedBy][0] = 0;
    FurnitureInfo[i][furAddedDate][0] = 0;

    FurnitureInfo[i][Texture1TXD][0] = 0;
    FurnitureInfo[i][Texture1Texture][0] = 0;
    FurnitureInfo[i][Texture1Colour] = 0;
    FurnitureInfo[i][Texture1ModelID] = 0;

    FurnitureInfo[i][Texture2TXD][0] = 0;
    FurnitureInfo[i][Texture2Texture][0] = 0;
    FurnitureInfo[i][Texture2Colour] = 0;
    FurnitureInfo[i][Texture2ModelID] = 0;

    FurnitureInfo[i][Texture3TXD][0] = 0;
    FurnitureInfo[i][Texture3Texture][0] = 0;
    FurnitureInfo[i][Texture3Colour] = 0;
    FurnitureInfo[i][Texture3ModelID] = 0;

    FurnitureInfo[i][Texture4TXD][0] = 0;
    FurnitureInfo[i][Texture4Texture][0] = 0;
    FurnitureInfo[i][Texture4Colour] = 0;
    FurnitureInfo[i][Texture4ModelID] = 0;

    FurnitureInfo[i][Texture5TXD][0] = 0;
    FurnitureInfo[i][Texture5Texture][0] = 0;
    FurnitureInfo[i][Texture5Colour] = 0;
    FurnitureInfo[i][Texture5ModelID] = 0;
    return 1;
}

function OnLoadFurniture()
{
    new rows = cache_num_rows();
    if(rows)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_int(i, "ID", FurnitureInfo[i][furID]);
            cache_get_value_int(i, "HouseID", FurnitureInfo[i][furHouseID]);
            cache_get_value_int(i, "ModelID", FurnitureInfo[i][furModelID]);
            cache_get_value(i, "ObjectName", FurnitureInfo[i][furObjectName], 128);
            cache_get_value_float(i, "X", FurnitureInfo[i][furX]);
            cache_get_value_float(i, "Y", FurnitureInfo[i][furY]);
            cache_get_value_float(i, "Z", FurnitureInfo[i][furZ]);
            cache_get_value_float(i, "RX", FurnitureInfo[i][furRX]);
            cache_get_value_float(i, "RY", FurnitureInfo[i][furRY]);
            cache_get_value_float(i, "RZ", FurnitureInfo[i][furRZ]);
            cache_get_value_int(i, "World", FurnitureInfo[i][furWorld]);
            cache_get_value_int(i, "Interior", FurnitureInfo[i][furInterior]);
            cache_get_value(i, "AddedBy", FurnitureInfo[i][furAddedBy], MAX_PLAYER_NAME);
            cache_get_value(i, "AddedDate", FurnitureInfo[i][furAddedDate], 32);

            cache_get_value(i, "TXD1", FurnitureInfo[i][Texture1TXD], 32);
            cache_get_value(i, "Texture1", FurnitureInfo[i][Texture1Texture], 32);
            cache_get_value_int(i, "Colour1", FurnitureInfo[i][Texture1Colour]);
            cache_get_value_int(i, "ModelID1", FurnitureInfo[i][Texture1ModelID]);

            cache_get_value(i, "TXD2", FurnitureInfo[i][Texture2TXD], 32);
            cache_get_value(i, "Texture2", FurnitureInfo[i][Texture2Texture], 32);
            cache_get_value_int(i, "Colour2", FurnitureInfo[i][Texture2Colour]);
            cache_get_value_int(i, "ModelID2", FurnitureInfo[i][Texture2ModelID]);
            
            cache_get_value(i, "TXD3", FurnitureInfo[i][Texture3TXD], 32);
            cache_get_value(i, "Texture3", FurnitureInfo[i][Texture3Texture], 32);
            cache_get_value_int(i, "Colour3", FurnitureInfo[i][Texture3Colour]);
            cache_get_value_int(i, "ModelID3", FurnitureInfo[i][Texture3ModelID]);
            
            cache_get_value(i, "TXD4", FurnitureInfo[i][Texture4TXD], 32);
            cache_get_value(i, "Texture4", FurnitureInfo[i][Texture4Texture], 32);
            cache_get_value_int(i, "Colour4", FurnitureInfo[i][Texture4Colour]);
            cache_get_value_int(i, "ModelID4", FurnitureInfo[i][Texture4ModelID]);
            
            cache_get_value(i, "TXD5", FurnitureInfo[i][Texture5TXD], 32);
            cache_get_value(i, "Texture5", FurnitureInfo[i][Texture5Texture], 32);
            cache_get_value_int(i, "Colour5", FurnitureInfo[i][Texture5Colour]);
            cache_get_value_int(i, "ModelID5", FurnitureInfo[i][Texture5ModelID]);
            ReloadFurniture(i);
        }
        printf("(INFO): Loaded %d furniture from the database.", rows);
    }
    return 1;
}

CMD:createfurn(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new model;
        if(sscanf(params, "d", model))
            return SendUsageMessage(playerid, "/createfurn [ModelID]");

        for(new i; i < MAX_FURNITURE; i++)
        {
            if(!FurnitureInfo[i][furID])
            {
                new query[256], Float:pos[3];
                GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                format(query, sizeof(query), "INSERT INTO `Furniture` (`HouseID`, `ModelID`, `X`, `Y`, `Z`, `Interior`, `AddedBy`, `AddedDate`) VALUES (%d, %d, %f, %f, %f, %d, '%q', '%q')", 
                    GetPlayerVirtualWorld(playerid), model, pos[0], pos[1], pos[2], GetPlayerInterior(playerid), GetUserName(playerid), GetDateTime());
                mysql_tquery(g_SQL, query, "OnAdminCreateFurniture", "ddddfffd", playerid, i, GetPlayerVirtualWorld(playerid), model, pos[0], pos[1], pos[2], GetPlayerInterior(playerid));
                return 1;
            }
        }
    }
    return 1;
}

function OnAdminCreateFurniture(playerid, i, house, model, Float:x, Float:y, Float:z, int)
{
    FurnitureInfo[i][furID] = cache_insert_id();
    FurnitureInfo[i][furHouseID] = house;
    FurnitureInfo[i][furX] = x;
    FurnitureInfo[i][furModelID] = model;
    FurnitureInfo[i][furY] = y;
    FurnitureInfo[i][furZ] = z;
    FurnitureInfo[i][furInterior] = int;

    for(new f; f < sizeof furnitureItems; f++)
    {
        if(furnitureItems[f][Model] == model)
        {
            format(FurnitureInfo[i][furObjectName], 128, "%s", furnitureItems[f][Name]);
            break;
        }
    }

    SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}Added model %d for {FF0000}house %d{FFFFFF}.", model, house);

    SaveFurniture(i);
    ReloadFurniture(i);
    return 1;
}

new FurnBuyObject[MAX_PLAYERS], FurnBuyModel[MAX_PLAYERS];
function OnCreateFurniture(playerid, house, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, int)
{
    for(new i; i < MAX_FURNITURE; i++)
    {
        if(!FurnitureInfo[i][furID])
        {
            new price = 0;
            FurnitureInfo[i][furID] = cache_insert_id();
            FurnitureInfo[i][furHouseID] = house;
            FurnitureInfo[i][furModelID] = model;
            FurnitureInfo[i][furX] = x;
            FurnitureInfo[i][furY] = y;
            FurnitureInfo[i][furZ] = z;
            FurnitureInfo[i][furRX] = rx;
            FurnitureInfo[i][furRY] = ry;
            FurnitureInfo[i][furRZ] = rz;
            FurnitureInfo[i][furInterior] = int;

            for(new f; f < sizeof furnitureItems; f++)
            {
                if(furnitureItems[f][Model] == model)
                {
                    format(FurnitureInfo[i][furObjectName], 128, "%s", furnitureItems[f][Name]);
                    price = furnitureItems[f][Price];
                    TakeMoney(playerid, price);
                    SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}Purchased %s for $%s.", furnitureItems[f][Name], FormatNumber(price));
                    break;
                }
            }
            DestroyDynamicObject(FurnBuyObject[playerid]);
            FurnBuyObject[playerid] = INVALID_OBJECT_ID;
            SaveFurniture(i);
            ReloadFurniture(i);
            return 1;
        }
    }
    return 1;
}

CMD:deletefurn(playerid, params[])
{
    if(IsAdminLevel(playerid, 4))
    {
        new id;
        if(sscanf(params, "d", id))
            return SendUsageMessage(playerid, "/deletefurn [FurnitureID]");

        if(!FurnitureInfo[id][furID])
            return SendErrorMessage(playerid, "This furniture ID does not exist.");
        
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `Furniture` WHERE `Furniture`.`ID` = %d", FurnitureInfo[id][furID]);
        mysql_tquery(g_SQL, query, "OnDeleteFurn", "dd", playerid, id);
    }
    return 1;
}

function OnDeleteFurn(playerid, id)
{
    SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}Deleted furniture %d.", id);
    ResetFurniture(id);
    return 1;
}

CMD:furniturehelp(playerid, params[])
{
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Furniture Help:{FFFFFF} Type a command for more information.");
    SendClientMessageEx(playerid, COLOR_GRAD5, "Commands: /buyfurn, /editfurn, /furnlist, /sellfurn");
    SendClientMessageEx(playerid, COLOR_GREEN, "______________________________________________________");
    return 1;
}

stock IsFurnReady(playerid)
{
    new houseID = IsPlayerInsideHouse(playerid);
    new ownerID = GetHouseOwnerID(houseID);
    if(houseID != -1 && PlayerInfo[playerid][pCharacterID] == ownerID)
    {
        return houseID;
    }
    return -1;
}

new EditFurnHouseID[MAX_PLAYERS], EditingSlot[MAX_PLAYERS];
stock EditTexture(playerid, slot)
{
    new name[22];
    EditingSlot[playerid] = slot;
    format(name, sizeof name, "Edit Texture (Slot %d)", slot);
    Dialog_Show(playerid, Texture_EditMain, DIALOG_STYLE_LIST, name, "Edit Colour\nEdit Texture\nReset", "Select", "Back");
}

Dialog:Texture_EditMain(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Dialog_Show(playerid, FurnitureEdit, DIALOG_STYLE_LIST, "Edit Furniture", "Position\nSell\nTexture", "Continue", "Close");
        return 1;
    }
    switch(listitem)
    {
        case 0: Dialog_Show(playerid, Texture_ColourList, DIALOG_STYLE_LIST, "Edit Colour", "White\nRed\nOrange\nYellow\nGreen\nBlue\nPurple\nBrown", "Continue", "Close");
        case 1: Dialog_Show(playerid, Texture_TextureCat, DIALOG_STYLE_LIST, "Edit Texture", "Basic\nWall\nGround\nFloor\nOther", "Continue", "Close");
        case 2: Dialog_Show(playerid, Texture_Reset, DIALOG_STYLE_MSGBOX, "Reset Texture", "Are you sure you wish to do this?\nThis action is irreversible!", "Confirm", "Close");
    }
    return 1;
}

Dialog:Texture_ColourList(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new furn = TempVar[playerid][EditFurnitureID];
        switch(EditingSlot[playerid])
        {
            case 0:
            {
                switch(listitem)
                {
                    case 0: // White
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFFFFFFFF");
                        SendServerMessage(playerid, "Colour changed to White.");
                    }
                    case 1: // Red
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFFFF0000");
                        SendServerMessage(playerid, "Colour changed to {FF0000}Red{FFFFFF}.");
                    }
                    case 2: // Orange
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFFFFA500");
                        SendServerMessage(playerid, "Colour changed to {FFA500}Orange{FFFFFF}.");
                    }
                    case 3: // Yellow
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFFFFFF00");
                        SendServerMessage(playerid, "Colour changed to {FFFF00}Yellow{FFFFFF}.");
                    }
                    case 4: // Green
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFF00FF00");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Green{FFFFFF}.");
                    }
                    case 5: // Blue
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFF0000FF");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Blue{FFFFFF}.");
                    }
                    case 6: // Purple
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFF800080");
                        SendServerMessage(playerid, "Colour changed to {800080}Purple{FFFFFF}.");
                    }
                    case 7: // Brown
                    {
                        FurnitureInfo[furn][Texture1Colour] = HexToInt("0xFF80461B");
                        SendServerMessage(playerid, "Colour changed to {80461B}Brown{FFFFFF}.");
                    }
                }
            }
            case 1:
            {
                switch(listitem)
                {
                    case 0: // White
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFFFFFFFF");
                        SendServerMessage(playerid, "Colour changed to White.");
                    }
                    case 1: // Red
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFFFF0000");
                        SendServerMessage(playerid, "Colour changed to {FF0000}Red{FFFFFF}.");
                    }
                    case 2: // Orange
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFFFFA500");
                        SendServerMessage(playerid, "Colour changed to {FFA500}Orange{FFFFFF}.");
                    }
                    case 3: // Yellow
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFFFFFF00");
                        SendServerMessage(playerid, "Colour changed to {FFFF00}Yellow{FFFFFF}.");
                    }
                    case 4: // Green
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFF00FF00");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Green{FFFFFF}.");
                    }
                    case 5: // Blue
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFF0000FF");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Blue{FFFFFF}.");
                    }
                    case 6: // Purple
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFF800080");
                        SendServerMessage(playerid, "Colour changed to {800080}Purple{FFFFFF}.");
                    }
                    case 7: // Brown
                    {
                        FurnitureInfo[furn][Texture2Colour] = HexToInt("0xFF80461B");
                        SendServerMessage(playerid, "Colour changed to {80461B}Brown{FFFFFF}.");
                    }
                }
            }
            case 2:
            {
                switch(listitem)
                {
                    case 0: // White
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFFFFFFFF");
                        SendServerMessage(playerid, "Colour changed to White.");
                    }
                    case 1: // Red
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFFFF0000");
                        SendServerMessage(playerid, "Colour changed to {FF0000}Red{FFFFFF}.");
                    }
                    case 2: // Orange
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFFFFA500");
                        SendServerMessage(playerid, "Colour changed to {FFA500}Orange{FFFFFF}.");
                    }
                    case 3: // Yellow
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFFFFFF00");
                        SendServerMessage(playerid, "Colour changed to {FFFF00}Yellow{FFFFFF}.");
                    }
                    case 4: // Green
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFF00FF00");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Green{FFFFFF}.");
                    }
                    case 5: // Blue
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFF0000FF");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Blue{FFFFFF}.");
                    }
                    case 6: // Purple
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFF800080");
                        SendServerMessage(playerid, "Colour changed to {800080}Purple{FFFFFF}.");
                    }
                    case 7: // Brown
                    {
                        FurnitureInfo[furn][Texture3Colour] = HexToInt("0xFF80461B");
                        SendServerMessage(playerid, "Colour changed to {80461B}Brown{FFFFFF}.");
                    }
                }
            }
            case 3:
            {
                switch(listitem)
                {
                    case 0: // White
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFFFFFFFF");
                        SendServerMessage(playerid, "Colour changed to White.");
                    }
                    case 1: // Red
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFFFF0000");
                        SendServerMessage(playerid, "Colour changed to {FF0000}Red{FFFFFF}.");
                    }
                    case 2: // Orange
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFFFFA500");
                        SendServerMessage(playerid, "Colour changed to {FFA500}Orange{FFFFFF}.");
                    }
                    case 3: // Yellow
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFFFFFF00");
                        SendServerMessage(playerid, "Colour changed to {FFFF00}Yellow{FFFFFF}.");
                    }
                    case 4: // Green
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFF00FF00");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Green{FFFFFF}.");
                    }
                    case 5: // Blue
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFF0000FF");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Blue{FFFFFF}.");
                    }
                    case 6: // Purple
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFF800080");
                        SendServerMessage(playerid, "Colour changed to {800080}Purple{FFFFFF}.");
                    }
                    case 7: // Brown
                    {
                        FurnitureInfo[furn][Texture4Colour] = HexToInt("0xFF80461B");
                        SendServerMessage(playerid, "Colour changed to {80461B}Brown{FFFFFF}.");
                    }
                }
            }
            case 4:
            {
                switch(listitem)
                {
                    case 0: // White
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFFFFFFFF");
                        SendServerMessage(playerid, "Colour changed to White.");
                    }
                    case 1: // Red
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFFFF0000");
                        SendServerMessage(playerid, "Colour changed to {FF0000}Red{FFFFFF}.");
                    }
                    case 2: // Orange
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFFFFA500");
                        SendServerMessage(playerid, "Colour changed to {FFA500}Orange{FFFFFF}.");
                    }
                    case 3: // Yellow
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFFFFFF00");
                        SendServerMessage(playerid, "Colour changed to {FFFF00}Yellow{FFFFFF}.");
                    }
                    case 4: // Green
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFF00FF00");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Green{FFFFFF}.");
                    }
                    case 5: // Blue
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFF0000FF");
                        SendServerMessage(playerid, "Colour changed to {00FF00}Blue{FFFFFF}.");
                    }
                    case 6: // Purple
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFF800080");
                        SendServerMessage(playerid, "Colour changed to {800080}Purple{FFFFFF}.");
                    }
                    case 7: // Brown
                    {
                        FurnitureInfo[furn][Texture5Colour] = HexToInt("0xFF80461B");
                        SendServerMessage(playerid, "Colour changed to {80461B}Brown{FFFFFF}.");
                    }
                }
            }
        }
        ReloadFurniture(furn);
        SaveFurniture(furn);
        Dialog_Show(playerid, Texture_ColourList, DIALOG_STYLE_LIST, "Edit Colour", "White\nRed\nOrange\nYellow\nGreen\nBlue\nPurple\nBrown", "Continue", "Close");
    }
    else EditTexture(playerid, EditingSlot[playerid]);
    return 1;
}

new CurrentFurniture[MAX_PLAYERS][15];
Dialog:Texture_TextureSelect(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new texture = CurrentFurniture[playerid][listitem], furn = TempVar[playerid][EditFurnitureID];
        SendClientMessageEx(playerid, -1, "TXD_Name: %s", FurnitureTextures[texture][TXD_Name]);
        SendClientMessageEx(playerid, -1, "Texture_Name: %s", FurnitureTextures[texture][Texture_Name]);
        SendClientMessageEx(playerid, -1, "Model_ID: %d", FurnitureTextures[texture][Model_ID]);
        switch(EditingSlot[playerid])
        {
            case 0:
            {
                format(FurnitureInfo[furn][Texture1TXD], 32, "%s", FurnitureTextures[texture][TXD_Name]);
                format(FurnitureInfo[furn][Texture1Texture], 32, "%s", FurnitureTextures[texture][Texture_Name]);
                FurnitureInfo[furn][Texture1ModelID] = FurnitureTextures[texture][Model_ID];
            }
            case 1:
            {
                format(FurnitureInfo[furn][Texture2TXD], 32, "%s", FurnitureTextures[texture][TXD_Name]);
                format(FurnitureInfo[furn][Texture2Texture], 32, "%s", FurnitureTextures[texture][Texture_Name]);
                FurnitureInfo[furn][Texture2ModelID] = FurnitureTextures[texture][Model_ID];
            }
            case 2:
            {
                format(FurnitureInfo[furn][Texture3TXD], 32, "%s", FurnitureTextures[texture][TXD_Name]);
                format(FurnitureInfo[furn][Texture3Texture], 32, "%s", FurnitureTextures[texture][Texture_Name]);
                FurnitureInfo[furn][Texture3ModelID] = FurnitureTextures[texture][Model_ID];
            }
            case 3:
            {
                format(FurnitureInfo[furn][Texture4TXD], 32, "%s", FurnitureTextures[texture][TXD_Name]);
                format(FurnitureInfo[furn][Texture4Texture], 32, "%s", FurnitureTextures[texture][Texture_Name]);
                FurnitureInfo[furn][Texture4ModelID] = FurnitureTextures[texture][Model_ID];
            }
            case 4:
            {
                format(FurnitureInfo[furn][Texture5TXD], 32, "%s", FurnitureTextures[texture][TXD_Name]);
                format(FurnitureInfo[furn][Texture5Texture], 32, "%s", FurnitureTextures[texture][Texture_Name]);
                FurnitureInfo[furn][Texture5ModelID] = FurnitureTextures[texture][Model_ID];
            }
        }
        ReloadFurniture(furn);
        SaveFurniture(furn);
    }
    else Dialog_Show(playerid, Texture_TextureCat, DIALOG_STYLE_LIST, "Edit Texture", "Basic\nWall\nGround\nFloor\nOther", "Continue", "Close");
    return 1;
}

stock ShowTextures(playerid, listitem)
{
    new count = 0, string[128*15];
    for(new i; i < sizeof FurnitureTextures; i++)
    {
        if(FurnitureTextures[i][Category] == listitem)
        {
            CurrentFurniture[playerid][count] = i;
            format(string, sizeof string, "%s%s\n", string, FurnitureTextures[i][Show_Name]);
            count++;
        }
    }
    if(count == 0)
    {
        SendErrorMessage(playerid, "There is nothing in this category, report on the forums. (Listitem: %d)", listitem);
    }
    else Dialog_Show(playerid, Texture_TextureSelect, DIALOG_STYLE_LIST, "Select Texture", string, "Select", "Back");
}

Dialog:Texture_TextureCat(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        ShowTextures(playerid, listitem);
    }
    else EditTexture(playerid, EditingSlot[playerid]);
    return 1;
}

Dialog:Texture_Reset(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = TempVar[playerid][EditFurnitureID];
        switch(EditingSlot[playerid])
        {
            case 0:
            {
                FurnitureInfo[i][Texture1TXD][0] = 0;
                FurnitureInfo[i][Texture1Texture][0] = 0;
                FurnitureInfo[i][Texture1Colour] = 0;
                FurnitureInfo[i][Texture1ModelID] = 0;
            }
            case 1:
            {
                FurnitureInfo[i][Texture2TXD][0] = 0;
                FurnitureInfo[i][Texture2Texture][0] = 0;
                FurnitureInfo[i][Texture2Colour] = 0;
                FurnitureInfo[i][Texture2ModelID] = 0;
            }
            case 2:
            {
                FurnitureInfo[i][Texture3TXD][0] = 0;
                FurnitureInfo[i][Texture3Texture][0] = 0;
                FurnitureInfo[i][Texture3Colour] = 0;
                FurnitureInfo[i][Texture3ModelID] = 0;
            }
            case 3:
            {
                FurnitureInfo[i][Texture4TXD][0] = 0;
                FurnitureInfo[i][Texture4Texture][0] = 0;
                FurnitureInfo[i][Texture4Colour] = 0;
                FurnitureInfo[i][Texture4ModelID] = 0;
            }
            case 4:
            {
                FurnitureInfo[i][Texture5TXD][0] = 0;
                FurnitureInfo[i][Texture5Texture][0] = 0;
                FurnitureInfo[i][Texture5Colour] = 0;
                FurnitureInfo[i][Texture5ModelID] = 0;
            }
        }
        ReloadFurniture(i);
    }
    EditTexture(playerid, EditingSlot[playerid]);
    return 1;
}

Dialog:Texture_ResetAll(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new i = TempVar[playerid][EditFurnitureID];
        FurnitureInfo[i][Texture1TXD][0] = 0;
        FurnitureInfo[i][Texture1Texture][0] = 0;
        FurnitureInfo[i][Texture1Colour] = 0;
        FurnitureInfo[i][Texture1ModelID] = 0;

        FurnitureInfo[i][Texture2TXD][0] = 0;
        FurnitureInfo[i][Texture2Texture][0] = 0;
        FurnitureInfo[i][Texture2Colour] = 0;
        FurnitureInfo[i][Texture2ModelID] = 0;

        FurnitureInfo[i][Texture3TXD][0] = 0;
        FurnitureInfo[i][Texture3Texture][0] = 0;
        FurnitureInfo[i][Texture3Colour] = 0;
        FurnitureInfo[i][Texture3ModelID] = 0;

        FurnitureInfo[i][Texture4TXD][0] = 0;
        FurnitureInfo[i][Texture4Texture][0] = 0;
        FurnitureInfo[i][Texture4Colour] = 0;
        FurnitureInfo[i][Texture4ModelID] = 0;

        FurnitureInfo[i][Texture5TXD][0] = 0;
        FurnitureInfo[i][Texture5Texture][0] = 0;
        FurnitureInfo[i][Texture5Colour] = 0;
        FurnitureInfo[i][Texture5ModelID] = 0;

        ReloadFurniture(i);
    }
    EditTexture(playerid, EditingSlot[playerid]);
    return 1;
}

Dialog:Texture_SelectSlot(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Dialog_Show(playerid, FurnitureEdit, DIALOG_STYLE_LIST, "Edit Furniture", "Position\nSell\nTexture", "Continue", "Close");
        return 1;
    }
    if(listitem == 5)
    {
        Dialog_Show(playerid, Texture_ResetAll, DIALOG_STYLE_MSGBOX, "Reset Textures", "Are you sure you wish to reset the textures?\nThis action cannot be undone.", "Continue", "Exit");
    }
    else
    {
        EditTexture(playerid, listitem);
    }
    return 1;
}

Dialog:FurnitureEdit(playerid, response, listitem, inputtext[])
{
    // Position\Sell
    new furn = TempVar[playerid][EditFurnitureID];
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                EditDynamicObject(playerid, FurnitureInfo[furn][furObjectID]);
                TempVar[playerid][EditType] = EDIT_TYPE_EDIT_FURNITURE;
                SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}You are editing {FF0000}%s{FFFFFF}. Click the {00FF00}FLOPPY DISK{FFFFFF} to confirm your edit.", furnitureItems[furn][Name]);
                SendClientMessage(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}Use the cursor to control the editor.");
            }
            case 1:
            {
                Dialog_Show(playerid, Furniture_Sell, DIALOG_STYLE_MSGBOX, "Sell Furniture", "Are you sure you wish to sell this item?\nYou will only recieve 70 percent of the price back.", "Select", "Exit");
            }
            case 2:
            {
                if(Player[playerid][DonateLevel] < 1)
                    return SendErrorMessage(playerid, "You must donate to the server in order to use this.");
                
                Dialog_Show(playerid, Texture_SelectSlot, DIALOG_STYLE_LIST, "Editing Slots", "Slot 1\nSlot 2\nSlot 3\nSlot 4\nSlot 5\n{FF0000}Remove All Textures", "Select", "Back");
            }
        }
    }
    return 1;
}

Dialog:Furniture_Sell(playerid, response, listitem, inputtext[])
{
    // Position\Sell
    new furn = TempVar[playerid][EditFurnitureID];
    if(response)
    {
        for(new i; i < sizeof furnitureItems; i++)
        {
            if(furnitureItems[i][Model] == FurnitureInfo[furn][furModelID])
            {
                new price = percent(furnitureItems[i][Price], 70), query[128];
                mysql_format(g_SQL, query, sizeof query, "DELETE FROM `Furniture` WHERE `ID` = %d LIMIT 1", FurnitureInfo[furn][furID]);
                mysql_tquery(g_SQL, query, "OnSellFurn", "ddd", playerid, furn, price);
                return 1;
            }
        }
    }
    else Dialog_Show(playerid, FurnitureEdit, DIALOG_STYLE_LIST, "Edit Furniture", "Position\nSell\nTexture", "Continue", "Close");
    return 1;
}

function OnSellFurn(playerid, furn, price)
{
    GiveMoney(playerid, price);
    ResetFurniture(furn);
    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Furniture has been sold for $%s.", FormatNumber(price));
    return 1;
}

CMD:sellfurn(playerid, params[])
{
    new houseID = IsFurnReady(playerid);
    if(houseID != -1)
    {
        SelectObject(playerid);
        TempVar[playerid][SelectType] = SELECT_TYPE_SELL_FURNITURE;
        EditFurnHouseID[playerid] = houseID;
    }
    else SendErrorMessage(playerid, "You do not own this house.");
    return 1;
}

CMD:editfurn(playerid, params[])
{
    new houseID = IsFurnReady(playerid);
    if(houseID != -1)
    {
        SelectObject(playerid);
        TempVar[playerid][SelectType] = SELECT_TYPE_EDIT_FURNITURE;
        EditFurnHouseID[playerid] = houseID;
    }
    else SendErrorMessage(playerid, "You do not own this house.");
    return 1;
}

new FurnList[MAX_PLAYERS][10], Highest[MAX_PLAYERS];
stock ShowFurnList(playerid, start=0)
{
    new string[128*11], count = 0;
    for(new i = start; i < MAX_FURNITURE; i++)
    {
        if(count >= 10)
        {
            format(string, sizeof string, "%s{FFFF00}Next Page\n", string);
            Highest[playerid] = i;
            break;
        }
        if(FurnitureInfo[i][furID] > 0 && FurnitureInfo[i][furHouseID] == EditFurnHouseID[playerid])
        {
            FurnList[playerid][count] = i;
            if(strlen(FurnitureInfo[i][furObjectName]) > 0)
            {
                format(string, sizeof string, "%s%s\n", string, FurnitureInfo[i][furObjectName]);
            }
            else format(string, sizeof string, "%sUntitled\n", string);
            count++;
        }
    }
    Dialog_Show(playerid, Furniture_List, DIALOG_STYLE_LIST, "Furniture List", string, "Select", "Exit");
}

CMD:furnlist(playerid, params[])
{
    new houseID = IsFurnReady(playerid);
    if(houseID != -1)
    {
        EditFurnHouseID[playerid] = houseID;
        Highest[playerid] = 0;
        ShowFurnList(playerid);
    }
    else SendErrorMessage(playerid, "You are not inside your house.");
    return 1;
}

Dialog:Furniture_List(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem >= 10)
        {
            ShowFurnList(playerid, Highest[playerid]);
            return 1;
        }
        TempVar[playerid][EditFurnitureID] = FurnList[playerid][listitem];
        Dialog_Show(playerid, FurnitureEdit, DIALOG_STYLE_LIST, "Edit Furniture", "Position\nSell\nTexture", "Continue", "Close");
    }
    return 1;
}

CMD:buyfurn(playerid, params[])
{
    new houseID = IsFurnReady(playerid);
    if(houseID != -1)
    {
        new string[16*14];
        for(new i; i < sizeof furnitureCategories; i++)
        {
            format(string, sizeof string, "%s%s\n", string, furnitureCategories[i]);
        }
        Dialog_Show(playerid, Furniture_Category, DIALOG_STYLE_LIST, "Buy Furniture", string, "Select", "Exit");
    }
    else SendErrorMessage(playerid, "You are not inside your house.");
    return 1;
}

new SelectedItem[MAX_PLAYERS][MAX_FURNITURE char];
new SelectedCategory[MAX_PLAYERS];

stock ShowFurnCategory(playerid, listitem)
{
    SelectedCategory[playerid] = listitem;
    new list[(128+12)*15] = "Name\tPrice\n";
    new count = 0;
    for(new i; i < sizeof furnitureItems; i++)
    {
        if(furnitureItems[i][Category] == listitem)
        {
            SelectedItem[playerid]{count} = i;
            count++;
            format(list, sizeof list, "%s%s\t$%s\n", list, furnitureItems[i][Name], FormatNumber(furnitureItems[i][Price]));
        }
    }
    if(!count)
        return SendErrorMessage(playerid, "There is nothing in this furniture category, post a bug report. (Listitem: %d, Date/Time: %s)", listitem, GetDateTime());
    
    Dialog_Show(playerid, Furniture_Items, DIALOG_STYLE_TABLIST_HEADERS, "Buy Furniture", list, "Select", "Exit");
    return 1;
}

Dialog:Furniture_Category(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        ShowFurnCategory(playerid, listitem);
    }
    return 1;
}

Dialog:Furniture_Items(playerid, response, listitem, inputtext[])
{
    if(response)
    {

        /*
            listitem = selected item in dialog.
            SelectedItem[playerid] = furniture in furnitureItems array.
        */

        new i = SelectedItem[playerid]{listitem};
        if(furnitureItems[i][Model])
        {
            if(IsValidDynamicObject(FurnBuyObject[playerid]))
            {
                DestroyDynamicObject(FurnBuyObject[playerid]);
                FurnBuyObject[playerid] = INVALID_OBJECT_ID;
            }

            new Float:pos[4];
            FurnBuyModel[playerid] = furnitureItems[i][Model];
            GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
            GetPlayerFacingAngle(playerid, pos[3]);
            FurnBuyObject[playerid] = CreateDynamicObject(furnitureItems[i][Model], pos[0] + 2.0 * floatsin(-pos[3], degrees), pos[1] + 2.0 * floatcos(-pos[3], degrees), pos[2] + 1.0, 0.0, 0.0, ((19353 <= furnitureItems[i][Model] <= 19417) || (19426 <= furnitureItems[i][Model] <= 19465)) ? (pos[3] + 90.0) : (pos[3]), .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid));
            EditDynamicObject(playerid, FurnBuyObject[playerid]);
            TempVar[playerid][EditType] = EDIT_TYPE_BUY_FURNITURE;
            SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}You are previewing {FF0000}%s{FFFFFF}. Click the {00FF00}FLOPPY DISK{FFFFFF} to confirm your purchase.", furnitureItems[i][Name]);
            SendClientMessageEx(playerid, COLOR_YELLOW, "(INFO): {FFFFFF}Use the cursor to control the editor. This purchase, if confirmed, will cost you $%s.", FormatNumber(furnitureItems[i][Price]));
            return 1;
        }
        // We should never reach this, but just incase.
        SendErrorMessage(playerid, "There is nothing in this furniture item, post a bug report. (Furn Index: %d, Listitem: %d, Date/Time: %s)", i, listitem, GetDateTime());
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    FurnBuyModel[playerid] = 0;
    if(IsValidDynamicObject(FurnBuyObject[playerid]))
    {
        DestroyDynamicObject(FurnBuyObject[playerid]);
        FurnBuyObject[playerid] = INVALID_OBJECT_ID;
    }
    
    for(new i; i < MAX_FURNITURE; i++)
    {
        SelectedItem[playerid]{i} = 0;
    }
    EditFurnHouseID[playerid] = -1;
    EditingSlot[playerid] = -1;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    FurnBuyModel[playerid] = 0;
    if(IsValidDynamicObject(FurnBuyObject[playerid]))
    {
        DestroyDynamicObject(FurnBuyObject[playerid]);
        FurnBuyObject[playerid] = INVALID_OBJECT_ID;
    }
    return 1;
}