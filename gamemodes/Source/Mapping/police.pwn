//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

stock LoadPoliceHQ()
{
    // Police HQ
	new PoliceGround[2];
	CreateDynamicObject(12959, -250.52390, 991.90973, 18.83740,   0.00000, 0.00000, 180.00000);
	PoliceGround[0] = CreateDynamicObject(4199, -278.59579, 999.20721, 16.61740,   0.00000, 0.00000, 0.00000);
	PoliceGround[1] = CreateDynamicObject(4199, -280.01031, 999.07422, 16.60540,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9244, -274.77420, 986.76208, 23.46780,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14819, -269.22781, 994.65363, 19.93660,   0.00000, 0.00000, 180.00000);

	for(new i; i < 2; i++)
	{
		SetDynamicObjectMaterial(PoliceGround[i], 2, 8678, "wddngchplgrnd01", "greyground256", 0xFFFFFFFF);
	}
}