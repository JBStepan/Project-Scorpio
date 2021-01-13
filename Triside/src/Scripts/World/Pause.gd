#
# Pause.gd
# ------------------
# Part of the Triside
# Copyright (c) 2021 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: I dont know why this does not work
extends Control

onready var resume_button = $CanvasLayer/Buttons/Resume
onready var quit_button = $CanvasLayer/Buttons/Quit
onready var buttons = $CanvasLayer/Buttons

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("ui_accept"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_process_pause_menu();
	if resume_button.pressed:
		_process_pause_menu();
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	if quit_button.pressed:
		get_tree().quit()

func _process_pause_menu()->void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var pause_state = not get_tree().paused;
	get_tree().paused = pause_state;
	visible = pause_state;
	buttons.visible = pause_state;
