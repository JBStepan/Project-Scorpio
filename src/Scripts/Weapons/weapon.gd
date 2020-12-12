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
	# Basic
	var owner : Node;
	var name : String;
	var firerate : float;
	var bullets : int;
	var ammo : int;
	var max_bullets : int;
	var damage : int;
	var reload_speed : float;
	
	# NOTE(@JB Stepan): Not going to do these right now
	# Triside Things
	var type : int;
	var is_sniper : bool = false;
	
	# NOTE(@JB Steapn): I know im going againest my own words here, but I dont want to confuse the engine or myself
	func _init(Owner : Node, Name : String, Firerate : float, Bullets : int, Ammo : int, MaxBullets : int, Damage : float, ReloadSpeed : float)->void:
		self.owner = Owner;
		self.name = Name;
		self.firerate = Firerate;
		self.bullets = Bullets;
		self.ammo = Ammo;
		self.max_bullets = MaxBullets;
		self.damage = Damage;
		self.reload_speed = ReloadSpeed;
		
	var can_fire : bool = false;
	
	var mesh = owner.get_node("{}".format([name], "{}"));
	
	func _draw()->void:
		if not mesh.visable: #TODO: Anims
			mesh.visable = true;
			print("Weapon drawn");
			can_fire = true;

	func _hide()->void:
		if mesh.visable:
			mesh.visable = false
			print("Weapon hidden");
			can_fire = false;
	
	#NOTE(@JB Stepan): Im doing the same thing here, sue me
	func _sprint(sprint, _delta)->void:
		pass
	
	func _fire(_delta)->void:
		pass
		
	func _reload(_delta)->void:
		pass
	
	func _aim(_delta)->void:
		pass
		
	func _change(_delta)->void:
		pass
