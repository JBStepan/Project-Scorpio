extends Node

func _enter_tree():
	var config = ConfigFile.new();
	var setting = config.load("user://settings.cfg")
	
	if setting == OK:
		Log.loadNote("Looking for value: LogPath")
		var log_path = config.get_value("Logging", "LogPath");
		Log.loadNote("Key found!")
		ProjectSettings.set_setting("jblogging/config/log_path", log_path);
		Log.loadNote("Setting LogPath to " + log_path)
