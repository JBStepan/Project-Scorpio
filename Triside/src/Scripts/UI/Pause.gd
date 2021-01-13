#
# pause.gd
# ------------------
# Part of the Triside
# Copyright (c) 2021 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Control

onready var background = $CanvasLayer/ColorRect

func _ready():
	pass

func pause():
	var paused_state = not get_tree().paused;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = paused_state;
	visible = paused_state;
	background.visible = paused_state;

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pause()

func _on_Resume_pressed():
	pause()

func _on_Button_pressed():
	get_tree().quit()
	print("Exited Game")
