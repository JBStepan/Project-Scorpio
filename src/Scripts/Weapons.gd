#
# Weapons.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 
# NOTES:
#
# func _init(owner, name, firerate, bullets, ammo, max_bullets, damage, reload_speed) -> void:
extends Node

# Get character's node path
export(NodePath) var character;

# Get head's node path
export(NodePath) var head;

# Get camera's node path
export(NodePath) var neck;

# Get camera's node path
export(NodePath) var camera;

onready var gun1 = $Gun1
onready var gun2 = $Gun2
onready var gun3 = $Gun3

var player_inputs : Dictionary = {};
var weapon_inv : Dictionary = {};

var weapon = load("res://Scripts/weapon.gd")

#var ar = weapon.weapon.new(self, "AR-15", 3.0, 32, 999, 33, 25, 1.5)

func _ready()->void:
	gun1.visible = false;
	gun2.visible = false;
	gun2.visible = false;
	
#func _weapon(_delta)->void:
#	player_inputs["fire"] = int(Input.is_action_just_pressed("fire"));

