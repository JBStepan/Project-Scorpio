#
# Logger.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 
# NOTES:
#
extends Node

func loadNote(message):
	if ProjectSettings.get_setting("jblogging/config/enable_logging") == true:
		# Get datetime to dictionary
		var dt=OS.get_datetime()
		# Format and print with message
		print("%02d:%02d:%02d " % [dt.hour,dt.minute,dt.second], message)
	return true
