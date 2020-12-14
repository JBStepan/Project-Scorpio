#
# HeadMovement.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends Spatial;

export var player_path : NodePath;
export var cam_path : NodePath;
export var sensitivity : float = 0.2;
export var captured : bool = true;
export var gun1_path : NodePath;
export var gun2_path : NodePath;

var gun1 : Spatial;
var gun2 : Spatial;
var player;
var cam : Camera;

var current_weapon = 1;

var player_inputs : Dictionary = {};

func _ready() -> void:
	player = get_node(player_path);
	cam = get_node(cam_path);
	gun1 = get_node(gun1_path);
	gun2 = get_node(gun2_path);

func _physics_process(_delta) -> void:
	# Calls function to switch between locked and unlocked mouse
	_mouse_toggle();
	_zoom();
	weapon_select();
	
func _mouse_toggle() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		captured = !captured;
	
	if captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);

func _cam_rotate(event) -> void:
	# If the mouse is locked
	if captured:
		var camera : Dictionary = {0: $".", 1: $"."};
		
		if event is InputEventMouseMotion:
			# Rotates the camera on the x axis
			camera[0].rotation.x += -deg2rad(event.relative.y * sensitivity);
			
			# Rotates the camera on the y axis
			camera[1].rotation.y += -deg2rad(event.relative.x * sensitivity);
		
		# Creates a limit for the camera on the x axis
		var max_angle: int = 85; # Maximum camera angle
		camera[0].rotation.x = min(camera[0].rotation.x,  deg2rad(max_angle))
		camera[0].rotation.x = max(camera[0].rotation.x, -deg2rad(max_angle))

func _zoom():
	player_inputs["zoom"] = int(Input.is_action_pressed("zoom"));

	if player_inputs["zoom"]:
		cam.fov -= 50;
		sensitivity = 0.1;
	else:
		cam.fov = 70;
		sensitivity = 0.2;
	

func _input(_event) -> void:
	# Calls the function to rotate the camera
	_cam_rotate(_event);

func weapon_select():
	if Input.is_action_just_pressed("gun1"):
		current_weapon = 1
	elif Input.is_action_just_pressed("gun2"):
		current_weapon = 2

	if current_weapon == 1:
		gun1.visible = true
		gun1._process_gun();
	else:
		gun1.visible = false

	if current_weapon == 2:
		gun2.visible = true
		gun2._process_gun();
	else:
		gun2.visible = false
