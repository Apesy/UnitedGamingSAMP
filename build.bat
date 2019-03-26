@echo off
echo Copyright (C) 2018 United Gaming LLC
echo Executing SA-MP gamemode build...
sampctl package ensure
sampctl package build
pause