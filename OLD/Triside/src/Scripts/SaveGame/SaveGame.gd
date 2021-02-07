#
# SaveGame.gd
# ------------------
# Part of the Triside
# Copyright (c) 2021 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Resource
class_name SaveGame

signal game_saved(save_file);

export var game_version : String;
export var data : Dictionary = {};
