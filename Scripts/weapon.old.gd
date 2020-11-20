extends Node

class_name Weapon

#export var owner : NodePath;
export var weapon_name : String;
export var fire_rate : float;
export var clip_size : int;
export var bullets : int;
export var max_clip_size : int;
export var damage : float;
export var reload_speed : float;
export(int, "RIFLE", "PISTOL", "SNIPER") var weapon_type;
#export(int, "COMMON", "UNIQUE", "RARE", "ULIMATE", "LEGENDARY", "CONVERT") var weapon_rarity;

var current_ammp = clip_size;
var can_fire = true;

