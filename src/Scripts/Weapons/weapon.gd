#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. Read README.md for more info.
#
# TODO: Work on the weapon class

extends Node;

class Gun:
	var owner : Node;
	var name : String;
	var fire_rate : float;
	var clip_size : int;
	var ammo : int;
	
	func _init(Owner, Name, FireRate, ClipSize, Ammo):
		self.owner = Owner;
		self.name = Name;
		self.fire_rate = FireRate;
		self.clip_size = ClipSize;
		self.ammo = Ammo;
	
	func _draw()->void:
		print("Weapon drawn")
	
	func _hide()->void:
		print("Weapon hidden")
