//
//  Copyright (C) 2019 United Gaming LLC. All Rights Reserved.
//
//  This document is the property of United Gaming LLC.
//  It is considered confidential and proprietary.
//
//  This document may not be reproduced or transmitted in any form
//  without the consent of United Gaming LLC.
//

#include <a_http>
#include <YSI\y_hooks>

#define ANNOUNCE_URL        "monitor.sacnr.com/api/?Action=announce"
#define LOG_PREFIX          "[SACNR Monitor] "

#define HTTP_CREATED                201
#define HTTP_FORBIDDEN				403
#define HTTP_UNPROCESSABLE_ENTITY   422
#define HTTP_TOO_MANY_REQUESTS      429

hook OnGameModeInit()
{
    Announce();
}

stock GetBindIP(ip[], const len)
{
    GetServerVarAsString("bind", ip, len);
}

forward Announce();
public Announce()
{
    new postData[32],
        ip[16];
	GetBindIP(ip, sizeof(ip));
    if (!strlen(ip)) {
        print("[Warning] Bind address empty, can't announce server");
        return 1;
    }
    format(postData, sizeof(postData), "ipp=%s:%d", ip, GetServerVarAsInt("port"));
    HTTP(0, HTTP_POST, ANNOUNCE_URL, postData, "OnAnnounced"); // no need for different announce indices
    return 1;
}

forward OnAnnounced(index, response_code, data[]);
public OnAnnounced(index, response_code, data[])
{
    if(response_code != HTTP_CREATED)
    {
        switch (response_code) 
        {
            case HTTP_ERROR_BAD_HOST: {
                print("[Warning] Server failed to announce: HTTP_ERROR_BAD_HOST");
            }
            case HTTP_ERROR_NO_SOCKET: {
                print("[Warning] Server failed to announce: HTTP_ERROR_NO_SOCKET");
            }
            case HTTP_ERROR_CANT_CONNECT: {
                print("[Warning] Server failed to announce: HTTP_ERROR_CANT_CONNECT");
            }
            case HTTP_ERROR_CANT_WRITE: {
                print("[Warning] Server failed to announce: HTTP_ERROR_CANT_WRITE");
            }
            case HTTP_ERROR_CONTENT_TOO_BIG: {
                print("[Warning] Server failed to announce: HTTP_ERROR_CONTENT_TOO_BIG");
            }
            case HTTP_ERROR_MALFORMED_RESPONSE: {
                print("[Warning] Server failed to announce: HTTP_ERROR_MALFORMED_RESPONSE");
            }
            case HTTP_CREATED: {
                print("[] Server announced successfully.");
            }
            case HTTP_FORBIDDEN: {
                print("[Warning] Server failed to announce: 403 Forbidden. This can happen if your server has multiple IP addresses or lots of public SA-MP servers on your subnet.");
            }
            case HTTP_UNPROCESSABLE_ENTITY: {
                print("[Warning] Server failed to announce: 422 Unprocessable Entity. You might get this error if you are running a local/LAN server.");
            }
            case HTTP_TOO_MANY_REQUESTS: {
                print("[Warning] Server already announced (interval too small?).");
            }
            default: {
                printf("[Warning] Server failed to announce (error %d).", response_code);
            }
        }
    }
    else print("[Debug] Server announced successfully.");
}