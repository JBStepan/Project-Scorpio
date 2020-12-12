#
# weapon.old.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: Delete soon


#extends Node
#
#class_name Weapon
#
##export var owner : NodePath;
#export var ammo_label_path : NodePath;
#export var raycast_path : NodePath;
#export var weapon_name : String;
#export var fire_rate : float;
#export var clip_size : int;
#export var bullets : int;
#export var max_clip_size : int;
#export var damage : float;
#export var reload_speed : float;
#export(int, "RIFLE", "PISTOL", "SNIPER") var weapon_type;
##export(int, "COMMON", "UNIQUE", "RARE", "ULIMATE", "LEGENDARY", "CONVERT") var weapon_rarity;
export(Curve2D) var google
#
#var current_ammo;
#var can_fire = true;
#
#var ammo_label : Label;
#var raycast : RayCast;
#
#func _ready()->void:
#	ammo_label = get_node(ammo_label_path);
#	raycast = get_node(raycast_path);
#	current_ammo = clip_size
#
#func _fire(delta)->void:
#	pass
#
#func _shoot(delta)->void:
#	pass
#
#func _reload(delta)->void:
#	pass
#
#func _aim(delta)->void:
#	pass
#
#func _draw(delta)->void:
#	print(weapon_name + " equiped");
#
#func _hide(delta)->void:
#	print(weapon_name + " unequiped");
#
#
