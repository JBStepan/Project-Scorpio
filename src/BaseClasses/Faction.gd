#
# Faction.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Node

class_name Faction

export var _faction_id : String;
export var _name : String;
export var _ranks : Dictionary = { }

# 0 = Neutrel, 1 = Friend, 2 = Ally, -1 = Enemy
# NewKey = String, NewValue = Int
export var _faction_relations = { }

func _ready():
	pass
