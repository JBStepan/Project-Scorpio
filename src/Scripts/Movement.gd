#
# Movement.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 
# NOTES:
#
extends KinematicBody;

# Speed vars
export var walk_speed : float = 6;
export var sprint_speed : float = 10;
export var crouch_speed : float = 3;
export var normal_speed : float = 6;
export var crawl_speed : float = 2

# Physics Things
export var gravity_force : float = 50;
export var jump_force : float = 15;
export var friction : float = 30;

# Trisde things
export var player_name : String;
export var player_detection : int = 80;

# All vectors
var velocity = Vector3();
var direction = Vector3();
var acceleration = Vector3();

# Inputs
var player_inputs : Dictionary = {};

func _physics_process(_delta: float) -> void:
	_move(_delta);
	_jump(_delta);
	_crouch(_delta);
	_sprint(_delta);

func _enter_tree()->void:
	Log.loadNote("Player has enter scene!");
	
func _move(_delta) -> void:
	# Inputs
	player_inputs["left"]   = int(Input.is_action_pressed("left"));
	player_inputs["right"]  = int(Input.is_action_pressed("right"));
	player_inputs["foward"] = int(Input.is_action_pressed("forword"));
	player_inputs["back"]   = int(Input.is_action_pressed("backword"));
	
	# Check is on floor
	if is_on_floor():
		direction = Vector3();
	else:
		direction = direction.linear_interpolate(Vector3(), friction * _delta);
		
		# Applies gravity
		velocity.y += -gravity_force * _delta;
	
	var basis = $Head.global_transform.basis;
	direction += (-player_inputs["left"]    + player_inputs["right"]) * basis.x;
	direction += (-player_inputs["foward"]  +  player_inputs["back"]) * basis.z;
	
	direction.y = 0; direction = direction.normalized()
	
	# Interpolates between the current position and the future position of the character
	var target = direction * normal_speed; direction.y = 0;
	var temp_velocity = velocity.linear_interpolate(target, normal_speed * _delta);
	
	# Applies interpolation to the velocity vector
	velocity.x = temp_velocity.x;
	velocity.z = temp_velocity.z;
	
	# Calls the motion function by passing the velocity vector
	velocity = move_and_slide(velocity, Vector3(0, 1, 0), false, 4, PI/4, false);
	
func _jump(_delta):
	player_inputs["jump"] = int(Input.is_action_just_pressed("jump"));
	
	if player_inputs["jump"]:
		if is_on_floor():
			velocity.y = jump_force;

func _crouch(_delta) -> void:
	# Inputs
	player_inputs["crouch"] = int(Input.is_action_pressed("crouch"));

	# Get the character's head node
	var head = $"Head";
		# If the head node is not touching the ceiling
	if not head.is_colliding():
			
		# Takes the character collision node
		var collision = $CollisionShape;
	
		# Get the character's collision shape
		var shape = collision.shape.height;
	
		# Changes the shape of the character's collision
		shape = lerp(shape, 2 - (player_inputs["crouch"] * 1.5), crouch_speed  * _delta);
			
		# Apply the new character collision shape
		collision.shape.height = shape;

func _sprint(_delta) -> void:
	# Inputs
	player_inputs["sprint"] = int(Input.is_action_pressed("sprint"));
	
	# Make the character sprint
	if not player_inputs["crouch"]: # If you are not crouching
		# switch between sprint and walking
		var toggle_speed : float = walk_speed + ((sprint_speed - walk_speed) * player_inputs["sprint"])
		
		# Create a character speed interpolation
		normal_speed = lerp(normal_speed, toggle_speed, 3 * _delta);
	else:
		# Create a character speed interpolation
		normal_speed = lerp(normal_speed, walk_speed, _delta);
