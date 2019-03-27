# UG-RP SA-MP Gamemode
Based on DC-RP gamemode by Seanny.

## Giving yourself admin
You need to create yourself an in-game master account first by registering in-game (use any name).
Then you need to log yourself out using /q (or Pause Menu quit button) and log into the MySQL database (using PHPMyAdmin or mysql shell).

Then execute the following query:
``UPDATE players SET AdminLevel = 5 WHERE username = 'USERNAME'``
Replace USERNAME with your master account name, or
``UPDATE players SET AdminLevel = 5 WHERE id = ID``
Replace ID with your master account ID (integer/number).

## License:
MIT License. See LICENSE.md.  

## Compiling
You will need `sampctl`, the old pawno.exe method will **not** work!  
Do not attempt to use pawno or you will be in for a very nasty surprise.  

This gamemode is very broken, seems pawn likes to break itself.  
Anyway, you will need to fix a shit-tonne of errors.  

## Installation:
You must change mysql.cfg to match your local mysql settings.  
**NOTE:** Make sure you also have custom assets installed otherwise you will not see the login/register dialog.  

## Support
If you have an issue, please make an issue via the github issues button.

## Credits
Seanny for creating the gamemode originally for DC-RP and for giving permission to open source it.  
Apes for UG-RP and some minor edits.  
Hansrutger for some features.  
Tyler for mapping.  
