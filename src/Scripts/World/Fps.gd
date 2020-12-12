#
# Fps.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
# 
# TODO: 

extends Label

onready var fps_label = $".";

func _ready()->void:
	pass;
func _process(delta):
	var fps = str(Engine.get_frames_per_second());
	fps_label.text = "FPS: " + fps;
