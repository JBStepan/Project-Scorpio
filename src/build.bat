@echo off

set godot_path = C:\Games\Godot_v3.2.2-stable_win64.exe
set proj_path = C:\Games\Triside\src\project.godot
set export_preset = "Windows Main"
set export_path = C:\Games\Triside\builds\12-27-2020\triside.exe

echo Building Triside!
%godot% --path %proj_path% --export %export_preset% %export_path%
echo Done!
pause