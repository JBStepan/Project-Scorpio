#
# ShakeCam.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 
# NOTES:
#

extends Camera 

export var time : float;
export var force : float;

func _process(delta):
	shake(delta);

func shake(delta)->void:
	if time > 0:
		h_offset = rand_range(-force, force);
		v_offset = rand_range(-force, force);
		time -= delta;
	else:
		h_offset = 0;
		v_offset = 0;
