#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Node

class_name Weapon

export var fire_rate = 0.5;
export var clip_size = 5;
export var reload_rate = 1;
export var raycast_path : NodePath;

var current_ammo = 0
var can_fire = true
var reloading = false

var raycast : RayCast;

func _ready():
	current_ammo = clip_size
	raycast = raycast_path;
	
func _process(delta):
	if Input.is_action_just_pressed("fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire()
		elif not reloading:
			reload()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name)

func fire():
	print("Fired weapon")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	
	can_fire = true

func reload():
	print("Reloading")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	reloading = false
	print("Reload complete")
