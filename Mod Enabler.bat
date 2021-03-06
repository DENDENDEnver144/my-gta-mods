@echo off
rem Thanks for downloading my launcher, feel free to take a look at/borrow anything you find in here

rem GTA 5 Mod Enabler 1.3.6
set "version=1.3.6"

rem See if the current directory has the GTA5 files
:dircheck
@echo off
cd /d "%~dp0"
if exist GTA5.exe (
	if exist common.rpf (
		if exist x64a.rpf (
			goto start)
		)
	) else (
		title Please put this file in Grand Theft Auto V's root directory
		echo Please put this file in Grand Theft Auto V's root directory
		echo:
		echo:
		pause
		goto end)

rem Main menu
:start
@echo off
cls
set "curpath=%cd%"
title FaZe IlLuMiNaTi's Mod Enabler %version%
echo Welcome to FaZe IlLuMiNaTi's Mod Enabler %version%
echo:
if not exist disabled echo Mods are currently enabled
if exist disabled echo Mods are currently disabled
echo:
echo Would you like to enable or disable your mods?
echo:
echo Enable mods: 1
echo Disable mods: 2
echo Skip to the end: 3
echo:
choice /n /c 123 /m Pick:
if errorlevel 3 goto launchoption
if errorlevel 2 goto uninstall
if errorlevel 1 goto install


rem Enabling mods
:install
@echo off
cls
mkdir disabled > nul 2> nul
cd disabled

rem All files
move *.* .. > nul 2> nul

rem Folders
move menyooStuff .. > nul 2> nul
move scripts .. > nul 2> nul
move plugins .. > nul 2> nul
move ExecuteCode .. > nul 2> nul
move Logs .. > nul 2> nul
move SweetFX .. > nul 2> nul

rem CLeaning
cd ..
attrib -h "mods"
rd disabled > nul 2> nul
goto launchoption


rem Disabling mods
:uninstall
@echo off
cls
if not exist disabled mkdir disabled > nul 2> nul

rem Basic files
move *.asi disabled > nul 2> nul
move *.log disabled > nul 2> nul
move *.ini disabled > nul 2> nul
move *.sav disabled > nul 2> nul
move *.file disabled > nul 2> nul
move Readme.txt disabled > nul 2> nul

rem ScriptHookV
move dinput8.dll disabled > nul 2> nul
move ScriptHookV.dll disabled > nul 2> nul

rem ScriptHookVDotNet
move ScriptHookVDotNet.dll disabled > nul 2> nul

rem GTALua
move lua.dll disabled > nul 2> nul
move luabind.dll disabled > nul 2> nul

rem DrDaxxy's FOV mod
move dsound.dll disabled > nul 2> nul
move fov-log.txt disabled > nul 2> nul

rem Menyoo
move menyooLog.txt disabled > nul 2> nul

rem RageHook
move cursor_32_2.png disabled > nul 2> nul
move DefaultSkin.png disabled > nul 2> nul
move FW1FontWrapper.dll disabled > nul 2> nul
move Gwen.dll disabled > nul 2> nul
move Gwen.UnitTest.dll disabled > nul 2> nul
move LMS.PortableExecutable.dll disabled > nul 2> nul
move Microsoft.Expression.Drawing.dll disabled > nul 2> nul
move Mono.Cecil.dll disabled > nul 2> nul
move Mono.Cecil.Mdb.dll disabled > nul 2> nul
move Mono.Cecil.Pdb.dll disabled > nul 2> nul
move Mono.Cecil.Rocks.dll disabled > nul 2> nul
move RagePluginHook.exe disabled > nul 2> nul
move SlimDX.dll disabled > nul 2> nul
move XInput1_4.dll disabled > nul 2> nul
move GameBackups.rph disabled > nul 2> nul
move startup.rphs disabled > nul 2> nul

rem SweetFX
move dxgi.dll disabled > nul 2> nul
move ReShade.fx disabled > nul 2> nul
move Sweet.fx disabled > nul 2> nul

rem ENB
move d3d11.dll > nul 2> nul
move d3dcompiler_46e.dll > nul 2> nul
move enblightsprite.fx disabled > nul 2> nul
move enblocal.ini disabled > nul 2> nul
move enbseries.ini > nul 2> nul
move license_en.txt > nul 2> nul
move readme_en.txt > nul 2> nul
move hbaosettings.xml > nul 2> nul

rem Folders
rem Can't move OpenIV's mods folder because it would be quite large in most situations
rem Making files hidden instead
attrib +h "mods"
move menyooStuff disabled > nul 2> nul
move scripts disabled > nul 2> nul
move plugins disabled > nul 2> nul 
move ExecuteCode disabled > nul 2> nul
move Logs disabled > nul 2> nul
move SweetFX disabled > nul 2> nul
move enbseries disabled > nul 2> nul

goto launchoption

rem Choose what to do next
:launchoption
cls
title Launch?
echo Thanks for using FaZe IlLuMiNaTi's Mod Enabler
echo:
if not exist disabled echo Mods are now enabled
if exist disabled echo Mods are now disabled
echo:
echo Would you like to launch Grand Theft Auto V now?
echo:
echo Launch Grand Theft Auto V with High Priority: 1
echo Exit without launching: 2
echo Return to the start: 3
echo Launch Grand Theft Auto V: 4
if exist "%USERPROFILE%\Desktop\GTA5 Mod Enabler.lnk" (
	echo:
	choice /n /c 1234 /m Pick:
	if errorlevel 4 goto launch
	if errorlevel 3 goto start
	if errorlevel 2 goto end
	if errorlevel 1 goto launchhigh
	) else (
		echo Make a shortcut to this script on the desktop: 5
		echo:
		choice /n /c 12345 /m Pick:
		if errorlevel 5 goto scut
		if errorlevel 4 goto launch
		if errorlevel 3 goto start
		if errorlevel 2 goto end
		if errorlevel 1 goto launchhigh
		)


rem Create a shortcut to the desktop using a temporary vb script
:scut
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\GTA5 Mod Enabler.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%curpath%\Mod Enabler.bat" >> %SCRIPT%
echo oLink.IconLocation = "%curpath%\GTA5.exe" >> %SCRIPT%
echo oLink.WorkingDirectory = "%curpath%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
cls
rem Launch the newly create shortcut
echo Shortcut created, relaunching in 2 seconds!
timeout /t 2 /nobreak > nul
rundll32 shell32.dll,ShellExec_RunDLL "%USERPROFILE%\Desktop\GTA5 Mod Enabler.lnk"
goto end


rem Check what version of the game the user has and launch it
:launch
if exist RagePluginHook.exe (
	if exist Gwen.dll (
		start RagePluginHook.exe
		goto end )
	) 
if exist steam_api64.dll (
	if exist steam_appid.txt (
		explorer steam://rungameid/271590
		goto end )
	) 
if not exist steam_api64.dll (
	if not exist steam_appid.txt (
		if not exist PlayGTAV.exe (
			start GTAVLauncher.exe
			goto end )
		)
	)
if not exist steam_api64.dll (
	if not exist steam_appid.txt (
		if exist PlayGTAV.exe (
			start PlayGTAV.exe
			goto end)
		)
	)


rem Check what version of the game the user has and go to that section
:launchhigh
if exist RagePluginHook.exe (
	if exist Gwen.dll (
		goto launchragehookhigh )
	) 
if exist steam_api64.dll (
	if exist steam_appid.txt (
		goto launchsteamhigh )
	) 
if not exist steam_api64.dll (
	if not exist steam_appid.txt (
		if not exist PlayGTAV.exe (
			goto launchpiratehigh)
		)
	)
if not exist steam_api64.dll (
	if not exist steam_appid.txt (
		if exist PlayGTAV.exe (
			goto launchsocialhigh)
		)
	)


rem Launch the game through Steam with High Priority mode
:launchsteamhigh
explorer steam://rungameid/271590
cls
title Leave this window open, it will close automatically
echo Leave this window open, it will close automatically
goto processdetect

rem Launch the game through the R* warehouse launcher with High Priority mode
:launchsocialhigh
start PlayGTAV.exe
cls
title Leave this window open, it will close automatically
echo Leave this window open, it will close automatically
goto processdetect

rem I dont support piracy, but I understand why people do it
rem Launch the game through the pirate launcher with High Priority mode
:launchpiratehigh
start GTAVLauncher.exe
cls
title Leave this window open, it will close automatically
echo Leave this window open, it will close automatically
goto processdetect

rem RageHook
:launchragehookhigh
start RagePluginHook.exe
cls
title Leave this window open, it will close automatically
echo Leave this window open, it will close automatically
goto processdetect


rem Detect the process "gta5.exe" before starting the 60 second counter, this could potentially help people with slow PCs
:processdetect
tasklist /nh /fi "imagename eq gta5.exe" | find /i "gta5.exe" >nul && (
echo GTA5.exe detected, waiting 60 seconds
timeout /t 60 /nobreak > nul
wmic process where name="GTA5.exe" CALL setpriority "high priority" > nul 2> nul
wmic process where name="gtavlauncher.exe" CALL setpriority "idle" > nul 2> nul
wmic process where name="PlayGTAV.exe" CALL setpriority "idle" > nul 2> nul
wmic process where name="subprocess.exe" CALL setpriority "idle" > nul 2> nul
goto end
) || (
goto processdetect
)



rem Welp, what do you expect, its the end...
:end