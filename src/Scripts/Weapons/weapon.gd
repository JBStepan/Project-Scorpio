#
# weapon.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: Work on the weapon class

extends Node;

class Gun:
	# Basic
	var owner : Node;
	var name : String;
	var type : int;
	