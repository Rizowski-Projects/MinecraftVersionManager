ECHO OFF
SET backupdir="%appdata%\.minecraftold"
SET minedir="%appdata%\.minecraft"
:STARTMENU
CLS
	ECHO ...............................................
	ECHO         Rizowski's Minecraft Versioner
	ECHO ...............................................
	ECHO ...............................................
	ECHO Welcome to Rizowski's Minecraft Versioner.
	ECHO This tool will help you downgrade your minecraft 
	ECHO version if you have previously updated to a version 
	ECHO that isn't supported by the sever.
	ECHO ...............................................
	ECHO PLEASE NOTE THIS COULD CORRUPT ANY WORLDS THAT YOU HAVE SAVED
	ECHO DO NOT LOGIN TO YOUR PRIVATE GAMES AFTER DOWNGRADING
	ECHO I AM NOT RESPONSIBLE FOR ANY DAMAGE YOU DO TO YOUR OWN GAME
	ECHO ...............................................
	ECHO.
	ECHO 1 - Download 1.5.2
	ECHO 2 - Begin Conversion
	ECHO 3 - Restore backup
	ECHO 0 - EXIT
	ECHO.

	SET /P input=Type 1, 2, 3, or 0 then press ENTER:
	IF %input%==1 GOTO VERSION
	IF %input%==2 GOTO CONVERTS
	IF %input%==3 GOTO RESTOREB
	IF %input%==0 GOTO EOF

:VERSION
CLS
	ECHO ...............................................
	ECHO         Rizowski's Minecraft Versioner
	ECHO ...............................................
	::ECHO Select a Minecraft version that you would like 
	::ECHO to downgrade to. Once a version has been selected 
	::ECHO I will download the file and set it up for moving.
	::ECHO ...............................................
	::ECHO.
	::ECHO 1 - Version 1.5.2
	::ECHO 2 - Version 1.6
	::ECHO 0 - Main Menu

	SET vers=1
	::SET vers=1 /P vers=Type 1 or 0 then press ENTER:
	::IF %vers%==0 GOTO STARTMENU
GOTO GETVER

:CONVERTS
CLS
	ECHO ...............................................
	ECHO         Rizowski's Minecraft Versioner
	ECHO ...............................................
	ECHO Now copying the files over to your 
	ECHO %appdata%\.minecraft folder.
	ECHO This may take some time. If there are any problems
	ECHO Please let Rizowski know.
	ECHO ...............................................
	IF EXIST %minedir% (
		 PAUSE
		IF EXIST %backupdir% (
			ECHO PLEASE NOTE THAT IF YOU HAVE RUN THIS PROGRAM BEFORE 
			ECHO ALL BACKED UP DATA WILL BE OVERWRITTEN!!! PLEASE 
			ECHO CLOSE NOW IF YOU DONT WANT THAT. HITTING ANY KEY
			ECHO WILL CONTINUE!!!
			PAUSE
		)
		ECHO Making a Backup of current data...
		XCOPY %minedir% %backupdir% /s /k /h /i /y > nul
	)
	ECHO Extracting Files...
	IF NOT EXIST "download.zip" GOTO VERSION
	programs\7za x "download.zip" -o".minecraft" -y > nul
	ECHO DONE
	ECHO Copying Files....
	XCOPY ".minecraft" %minedir% /s /k /h /i /y > nul
	ECHO DONE
	PAUSE
GOTO STARTMENU

:GETVER
	IF %vers%==1 (
		SET url="http://dl.dropboxusercontent.com/s/zdu5xumdghl3pll/1.5.2.zip?token_hash=AAHTZROb9-0_14DGRe5dibz8mGFa7lPV_oUsKAi2osTyHw&dl=1"
		ECHO Downloading Version 1.5.2
	)
	::If %vers%==2 (
	::	SET url=""
	::	ECHO Downloading Version 1.6
	::)
	programs\curl -O %url% -# -0 "download.zip"
	PAUSE
GOTO STARTMENU

:RESTOREB
CLS
	ECHO ...............................................
	ECHO         Rizowski's Minecraft Versioner
	ECHO ...............................................
	IF NOT EXIST %backupdir% ( 
		ECHO Backup Not Found D:
	)
	IF EXIST %backupdir% (
		ECHO Restoring backup
		XCOPY %backupdir% %minedir% /s /k /h /i /y
		ECHO DONE
	)
	PAUSE
GOTO STARTMENU

pause