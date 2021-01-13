#
# Configs.gd
# ------------------
# Part of the Triside
# Copyright (c) 2021 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Node

func _enter_tree():
	var config = ConfigFile.new();
	var setting = config.load("user://settings.cfg");
	
	if setting == OK:
		pass
