//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

hook Discord_Init()
{
    #if defined dcconnector_included
    if (_:g_StaffChat == 0)
        g_StaffChat = DCC_FindChannelById("404635128602558466");

    if (_:g_AdminChat == 0)
        g_AdminChat = DCC_FindChannelById("404635633831903232");

    if (_:g_LeadAdminChat == 0)
        g_LeadAdminChat = DCC_FindChannelById("418200465432510464");

    if (_:g_HelperChat == 0)
        g_HelperChat = DCC_FindChannelById("418200637482729474");

    if (_:g_AdminWarning == 0)
        g_AdminWarning = DCC_FindChannelById("420618860522110977");
    #else
    print("[Discord_Init]: Discord connector is not included.");
    #endif
}

stock SendDiscordMessage(channel, const message[])
{
    #if defined dcconnector_included
    switch(channel)
    {
        case DISCORD_STAFF: // #staff
        {
            g_StaffChat = DCC_FindChannelById("404635128602558466");
            DCC_SendChannelMessage(g_StaffChat, message);
        }
        case DISCORD_ADMIN: // #admin
        {
            g_AdminChat = DCC_FindChannelById("404635633831903232");
            DCC_SendChannelMessage(g_AdminChat, message);
        }
        case DISCORD_LEAD: // #lead-admin
        {
            g_LeadAdminChat = DCC_FindChannelById("418200465432510464");
            DCC_SendChannelMessage(g_LeadAdminChat, message);
        }
        case DISCORD_HELPER: // #helper
        {
            g_HelperChat = DCC_FindChannelById("418200637482729474");
            DCC_SendChannelMessage(g_HelperChat, message);
        }
        case DISCORD_WARNING:
        {
            g_AdminWarning = DCC_FindChannelById("420618860522110977");
            DCC_SendChannelMessage(g_AdminWarning, message);
        }
    }
    #else
    print("[SendDiscordMessage]: Discord connector is not included.");
    #endif
}

public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
    #if defined dcconnector_included
    new channel_name[32];
    if (!DCC_GetChannelName(channel, channel_name))
        return 0; // invalid channel

    new user_name[32 + 1];
    if (!DCC_GetUserName(author, user_name))
        return 0; // invalid user

    if(strcmp(user_name, "United Gaming RP", true))
    {
        if(strlen(message) < 144)
        {
            printf("[DCC] OnChannelMessage (Channel %s): Author %s sent message: %s", channel_name, user_name, message);
            if(!strcmp(channel_name, "staff", true))
            {
                if(strlen(message) > 70)
                {
                    SendAdminMessage(COLOR_STAFF, 1, "* [STAFF] %s (Discord): %.70s ...", user_name, message);
                    SendAdminMessage(COLOR_STAFF, 1, "* [STAFF] %s (Discord): ... %s", user_name, message[70]);
                }
                else
                {
                    SendAdminMessage(COLOR_STAFF, 1, "* [STAFF] %s (Discord): %s", user_name, message);
                }
            }
            else if(!strcmp(channel_name, "admin", true))
            {
                if(strlen(message) > 70)
                {
                    SendAdminMessage(COLOR_YELLOW, 1, "* [ADMIN] %s (Discord): %.70s ...", user_name, message);
                    SendAdminMessage(COLOR_YELLOW, 1, "* [ADMIN] %s (Discord): ... %s", user_name, message[70]);
                }
                else
                {
                    SendAdminMessage(COLOR_YELLOW, 1, "* [ADMIN] %s (Discord): %s", user_name, message);
                }
            }
            else if(!strcmp(channel_name, "lead-admin", true))
            {
                if(strlen(message) > 70)
                {
                    SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s (Discord): %.70s ...", user_name, message);
                    SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s (Discord): ... %s", user_name, message[70]);
                }
                else
                {
                    SendAdminMessage(COLOR_GREEN, 4, "* [LEAD] %s (Discord): %s", user_name, message);
                }
            }
            else if(!strcmp(channel_name, "helper", true))
            {
                if(strlen(message) > 70)
                {
                    SendHelperMessage(COLOR_LIGHTBLUE, 1, "* [HELPER] %s (Discord): %.70s ...", user_name, message);
                    SendHelperMessage(COLOR_LIGHTBLUE, 1, "* [HELPER] %s (Discord): ... %s", user_name, message[70]);
                }
                else
                {
                    SendHelperMessage(COLOR_LIGHTBLUE, 1, "* [HELPER] %s (Discord): %s", user_name, message);
                }
            }
        }
    }
    #endif
	return 1;
}