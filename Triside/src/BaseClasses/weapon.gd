#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2021 JB Stepan. All Rights Reserved
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
export var weapon_things : String = "-----------------------"
export var editor_id : String
export var use_weapon_file : bool = true;
export(String, FILE, '*.weapon') var weapon_file
export var weapon_variables : String = "-----------------------"
export var fire_rate : float;
export var wait_time : float;
export var hold_fire_variables : String = "-----------------------"
export var can_hold : bool;
export var hold_fire_rate : float;
export var clip_size : int;
export var ammo : int;
export var reload_rate : float;
export var damage : float;

export var node_paths : String = "-----------------------"
export var anim_path : NodePath;
export var raycast_path : NodePath;
export var fire_sound_path : NodePath;
export var reload_sound_path : NodePath;

# Aiming
export var aiming : String = "-----------------------"
export var default_pos : Vector3;
export var aim_pos : Vector3;
export var aim_speed : float = 1;

# Enums
enum WeaponType { RIFLE, SNIPER, SMG, LMG, PISTOL }
enum Rarity { COMMON, UNCOMMON, RARE, ULTIMATE, LEGENDARY, EXOTIC }
enum AmmoType { FORTYFIVE, FIFTY, ENERGY, PLASMA, BIO }

export var triside_variables : String = "-----------------------"
# Triside Vars
export(WeaponType) var weapon_type;
export(Rarity) var rarity;
export(AmmoType) var ammo_type
export var weapon_name : String;
export(String, MULTILINE) var weapon_desc

var current_ammo = 0;
var can_fire = true;
var reloading = false;
var is_aiming = false;

var anim : AnimationPlayer;
var raycast : RayCast;
var fire_sound : AudioStreamPlayer3D
var reload_sound : AudioStreamPlayer3D

func _ready()->void:
	if use_weapon_file == true:
		if weapon_file != "":
			_read_weapon_file(weapon_file)
		else:
			print("No weapon file defined")
	else:
		print("Not using weapon file")
	
	current_ammo = clip_size;
	raycast = get_node(raycast_path)
	anim = get_node(anim_path)
	fire_sound = get_node(fire_sound_path)
	reload_sound = get_node(reload_sound_path)
	
	# Sets the postion of the weapon to the given defualt postion
	self.transform.origin = default_pos;
	
func _process_weapon()->void:
	if Input.is_action_just_pressed("fire"):
		# Stops people from spam clicking
		if can_fire == true:
			if current_ammo > 0 and not reloading:
				fire();
				
			elif not reloading:
				reload();
		else:
			pass
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
			collider.health -= damage;
			print("Hit enemy for damage " + str(damage))
		else:
			print("Hit Nothing!");
	else:
		print("Hit Nothing!")

func fire()->void:
	if anim.current_animation != "reload":
		print("Fired weapon " + weapon_name);
		can_fire = false;
		# Removes 1 ammo from the weapon
		current_ammo -= 1;
		
		if is_aiming == true:
			anim.play("fired_aim", 0, fire_rate)
			fire_sound.play(0.0)
		else:
			anim.play("fired", 0, fire_rate)
			fire_sound.play(0.0)
		
		check_collision()
		
		# Emits the, weapon_fired, signal use for anything
		emit_signal("weapon_fired", weapon_name);
		
		yield(get_tree().create_timer(wait_time), "timeout")
		can_fire = true;
	else:
		print("Can fire while reloading")

func reload()->void:
	reloading = true;
	print("Reloading weapon " + weapon_name);
	anim.play("reload", 0, reload_rate)
	reload_sound.play(0.0)
	
	for i in ammo:
		current_ammo += 1;
		ammo -= 1;
			
		if current_ammo >= clip_size:
			break
	
	yield(get_tree().create_timer(1), "timeout")
	
	emit_signal("weapon_reloaded", weapon_name,current_ammo, ammo)
	print("Done reloading weapon " + weapon_name + " remaining ammo " + str(ammo));
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

