@echo off

rem Requirements
rem Python, Godot 3.2.2 and a copy of Triside source code

echo -------------------------------------------------------
echo - Triside Shell                                       -
echo - Version 1.0.0                                       -
echo - Created by JB Stepan                                -
echo - Part of the Triside Game                            -
echo - Copyright (c) 2020. JB Stepan. All rights reserved. -
echo -------------------------------------------------------

set /p input="Triside Shell > "
if %input% == --help goto help
if %input% == --export goto export
if %input% == --quit goto quit
if %input% == --about goto about
if %input% == --update goto update
if %input% == -h goto help
if %input% == -e goto export
if %input% == -q goto quit
if %input% == -a goto about
if %input% == -u goto update

:help
echo --------------------------------------
echo - Triside Shell Commands             -
echo - --help - Gives you this            -
echo - --export - Exports Triside         -
echo - --quit - Quits the shell           -
echo - --update - Update a GD file to 4.0 -
echo - -h - Gives you this                -
echo - -e - Exports Triside               -
echo - -q - Quits the shell               -
echo - -u - Update a GD file to 4.0       -
echo --------------------------------------
goto shellinput

:shellinput
set /p input="Triside Shell > "
if %input% == --help goto help
if %input% == --export goto export
if %input% == --quit goto quit
if %input% == --about goto about
if %input% == --update goto update
if %input% == -h goto help
if %input% == -e goto export
if %input% == -q goto quit
if %input% == -a goto about
if %input% == -u goto update

:: Shell inputs things

:quit
	echo Exiting...
	exit

:about
	echo -------------------------------------------------------
	echo - Triside Shell                                       -
	echo - Version 1.0.0                                       -
	echo - Created by JB Stepan                                -
	echo - Part of the Triside Game                            -
	echo - Copyright (c) 2020. JB Stepan. All rights reserved. -
	echo -------------------------------------------------------
	goto shellinput

:: GDScript updates

:update
set /p file_to_change="File > "
python Update.py %file_to_change%
goto shellinput

:: Exports
:export
	set /p export_preset_input="Export Preset > "
	IF %export_preset_input% == win (
		goto winexport
	) ELSE (
		IF %export_preset_input% == mac (
			goto macexport
		) ELSE (
			IF %export_preset_input% == linux (
				goto linuxexport
			) ELSE (
				IF %export_preset_input% == quit (
					goto shellinput
				) ELSE (
					echo Invalid export preset 
					goto shellinput
				)
			)
		)
	) 

:winexport
	echo Building Triside
	C:\Games\Godot_v3.2.2-stable_win64.exe --windowed --path C:\Games\Triside\src\project.godot --export "Windows Main" C:\Games\Triside\builds\12-27-2020\triside.exe
	echo Done
	echo Returning to Triside Shell
	goto export

:macexport
	echo Mac export not set up
	goto export
	
:linuxexport
	echo Linux export not set up
	goto export