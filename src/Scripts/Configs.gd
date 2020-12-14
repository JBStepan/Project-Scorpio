extends Node

func _enter_tree():
	var config = ConfigFile.new();
	var setting = config.load("user://settings.cfg");
	
	if setting == OK:
		pass
