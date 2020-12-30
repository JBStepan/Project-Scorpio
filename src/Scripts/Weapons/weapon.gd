#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: Work on hold to fire

extends Spatial 

class_name Gun

# Weapon signals
signal weapon_fired(weaponname)
signal weapon_reloaded(weaponname, ammo, ammo_left)
signal weapon_file_read_done()

# Base weapon things
export var editor_id : String
export var use_weapon_file : bool = true;
export(String, FILE, '*.weapon') var weapon_file
export var fire_rate : float;
export var hold_fire_rate : float;
export var clip_size : int;
export var ammo : int;
export var reload_rate : float;
export var damage : float;
export var can_hold : bool;
export var raycast_path : NodePath;
export var anim_path : NodePath;

# Aiming
export var default_pos : Vector3;
export var aim_pos : Vector3;
export var aim_speed : float = 1;

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
var is_aiming = false;

var raycast : RayCast;
var anim : AnimationPlayer;

func _ready()->void:
	if weapon_file != "":
		_read_weapon_file(weapon_file)
	else:
		print("No weapon file defined")
	
	current_ammo = clip_size;
	raycast = get_node(raycast_path);
	anim = get_node(anim_path)
	
func _process_weapon()->void:
	if Input.is_action_just_pressed("fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire();
		elif not reloading:
			reload();
	
	if Input.is_action_just_pressed("reload") and not reloading and current_ammo < clip_size:
		reload();
	
	# Aiming
	if Input.is_action_pressed("aim"):
		is_aiming = true
		transform.origin = transform.origin.linear_interpolate(aim_pos, aim_speed)
	else:
		is_aiming = false
		transform.origin = transform.origin.linear_interpolate(default_pos, aim_speed)

func check_collision()->void:
	# Check the collison of the given RayCast
	if raycast.is_colliding():
		var collider = raycast.get_collider();
		# If the collider is in group, enemies, delete it
		if collider.is_in_group("Enemies"):
			collider.queue_free();
		else:
			print("Hit Nothing!");

func fire()->void:
	if !reloading:
		print("Fired weapon " + weapon_name);
		can_fire = false;
		# Removes 1 ammo from the weapon
		current_ammo -= 1;
		
		
		if is_aiming == true:
			anim.play("fired_aim")
		else:
			anim.play("fired")
		# Emits the, weapon_fired, signal for use for anything
		emit_signal("weapon_fired", weapon_name);
		
		# Creates a timers for the firerate
		yield(get_tree().create_timer(fire_rate), "timeout");
		can_fire = true;
	else:
		print("Unable to fire while reloading")

func reload()->void:
	reloading = true;
	print("Reloading weapon " + weapon_name);
	anim.play("reload", 0, reload_rate)
	
	for i in ammo:
		current_ammo += 1;
		ammo -= 1;
		
		if current_ammo >= clip_size:
			break

	emit_signal("weapon_reloaded", weapon_name,current_ammo, ammo)
	print("Done reloading weapon " + weapon_name);
	reloading = false;

# Reads the .weapon file given to it.
func _read_weapon_file(weaponfile)->void:
	var config = ConfigFile.new();
	var err = config.load(weaponfile);
	
	var weapon_file_type = config.get_value("Weapon", "sType");
	
	if use_weapon_file == true:
		# If type in the .weapon file is gun, then read the variables in the file, else, print an error
		if weapon_file_type == "gun":
			if err == OK: # If not, something went wrong with the file loading
				weapon_name = config.get_value("Weapon", "sName");
				fire_rate = config.get_value("Weapon", "fFirerate");
				hold_fire_rate = config.get_value("Weapon", "fHoldFireRate");
				clip_size = config.get_value("Weapon", "iClipSize");
				ammo = config.get_value("Weapon", "iAmmo");
				reload_rate = config.get_value("Weapon", "fReloadRate");
				damage = config.get_value("Weapon", "fDamage");
				default_pos = config.get_value("Weapon", "v3DefaultPos");
				aim_pos = config.get_value("Weapon", "v3AimPos");
				aim_speed = config.get_value("Weapon", "fAimSpeed");
				emit_signal("weapon_file_read_done");
			else:
				print("Something went wrong loading file " + weapon_file);
		else:
			print("Weapon type is not accepted!");
	else:
		print("Not using .weapon file")
