#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: Work on hold to fire

extends Node

class_name Weapon

export var debug_name : String
export(String, FILE, '*.weapon') var weapon_file
export var fire_rate : float;
export var hold_fire_rate : float;
export var clip_size :int;
export var reload_rate : float;
export var damage : float;
export var can_hold : bool;
export var raycast_path : NodePath;

# Enums
enum WeaponType { RIFLE, SNIPER, SMG, LMG, PISTOL }
enum Rarity { COMMON, UNCOMMON, RARE, ULTIMATE, LEGENDARY, EXOTIC }

# Triside Vars
export(WeaponType) var weapon_type;
export(Rarity) var rarity;
export var weapon_name : String;
export(String, MULTILINE) var weapon_desc

var current_ammo = 0;
var can_fire = true;
var reloading = false;

var raycast : RayCast;

func _ready():
	if weapon_file != "":
		_read_weapon_file(weapon_file)
	else:
		print("No weapon file defined")
	
	current_ammo = clip_size;
	raycast = get_node(raycast_path);
	
func _process_gun():
	if Input.is_action_just_pressed("fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire();
		elif not reloading:
			reload();
	
	if Input.is_action_just_pressed("reload") and not reloading and current_ammo < clip_size:
		reload();

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider();
		if collider.is_in_group("Enemies"):
			collider.queue_free();
		else:
			print("Hit Nothing!");

func fire():
	print("Fired weapon " + weapon_name);
	can_fire = false;
	current_ammo -= 1;
	yield(get_tree().create_timer(fire_rate), "timeout");
	can_fire = true

func reload():
	reloading = true;
	print("Reloading weapon " + weapon_name)
	yield(get_tree().create_timer(reload_rate), "timeout");
	current_ammo = clip_size;
	print("Done reloading weapon" + weapon_name)
	reloading = false;

# Reads the .weapon file given to it.
func _read_weapon_file(weaponfile):
	var config = ConfigFile.new()
	var err = config.load(weaponfile)
	
	var weapon_file_type = config.get_value("Weapon", "type");
	
	# If type in the .weapon file is gun, then read the variables in the file, else, print an error
	if weapon_file_type == "gun":
		if err == OK: # If not, something went wrong with the file loading
			weapon_name = config.get_value("Weapon", "name");
			fire_rate = config.get_value("Weapon", "firerate");
			hold_fire_rate = config.get_value("Weapon", "holdfirerate");
			clip_size = config.get_value("Weapon", "clipsize");
			reload_rate = config.get_value("Weapon", "reloadrate");
			damage = config.get_value("Weapon", "damage");
		else:
			print("Something went wrong loading file " + weapon_file)
	else:
		print("Weapon type is not accepted!")
