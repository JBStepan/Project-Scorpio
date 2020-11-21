# Copyright JB Stepan. 2020. All rights reserved
# Please read License.md and Readme.md for more info
# Copyright (c) 2020 Droivox
# Under the MIT License
# https://github.com/Droivox/Godot-Engine-FPS
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
