#
# enemy.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends NPC

func _process(_delta):
	if health <= 0:
		queue_free()
		print("Dead")
