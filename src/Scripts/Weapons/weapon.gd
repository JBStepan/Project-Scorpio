#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. Read README.md for more info.
#
# TODO: Work on the weapon class

extends Node;
class_name Gun

var fire_rate : float;
var clip_size : int;
var ammo : int;

	
var ray = owner.get_node("RayCast");
	
var can_fire : bool = true;
var reloading : bool = false;
	

