#
# Movement.gd
# ------------------
# Part of the Triside
# Copyright (c) 2020 JB Stepan. All Rights Reserved
# Licensed under License.txt. License.txt for more info.
#
# TODO: 

extends KinematicBody;

# Signals
signal player_move();
signal player_jump();
signal player_crouch();
signal player_sprint();

# Speed vars
export var normal_speed : float = 08; # Normal
export var sprint_speed : float = 12; # Sprint
export var walk_speed : float = 08; # Walking
export var crouch_speed_movement : float = 05; # Crouch
export var crouch_speed : float = 20;
var current_speed

# Physics vars
export var gravity : float = 50; # Gravity force
export var jump_height : float = 15; # Jump height
export var friction : float = 25; # friction

# Misc vars
export var defualt_height = 1.5;
export var crouch_height = 0.5;

# All vectors
var velocity : = Vector3(); # Velocity vector
var direction : = Vector3(); # Direction Vector
var acceleration : = Vector3(); # Acceleration Vector

# Character inputs
var input : Dictionary = {};

func _physics_process(_delta : float)->void:
	_move(_delta);
	_crouch(_delta);
	_jump(_delta);
	_sprint(_delta)

func _move(_delta : float)->void:
	# Inputs
	input["left"] = int(Input.is_action_pressed("left"));
	input["right"] = int(Input.is_action_pressed("right"));
	input["forward"] = int(Input.is_action_pressed("forword"));
	input["back"] = int(Input.is_action_pressed("backword"));
	
	# Check is on floor
	if is_on_floor():
		direction = Vector3();
	else:
		direction = direction.linear_interpolate(Vector3(), friction * _delta);
		
		# Applies gravity
		velocity.y += -gravity * _delta;
	
	var basis = $"Head".global_transform.basis;
	direction += (-input["left"] + input["right"]) * basis.x;
	direction += (-input["forward"] + input["back"]) * basis.z;
	emit_signal("player_move")
	
	direction.y = 0; direction = direction.normalized()
	
	# Interpolates between the current position and the future position of the character
	var target = direction * normal_speed; direction.y = 0;
	var temp_velocity = velocity.linear_interpolate(target, normal_speed * _delta);
	
	# Applies interpolation to the velocity vector
	velocity.x = temp_velocity.x;
	velocity.z = temp_velocity.z;
	
	# Calls the motion function by passing the velocity vector
	velocity = move_and_slide(velocity, Vector3(0, 1, 0), false, 4, PI/4, false);

func _crouch(_delta : float)->void:
	input["crouch"] = int(Input.is_action_pressed("crouch"));
	
	var collision = $"CollisionShape";
	
	var head = $"Head";
	
	if not head.is_colliding():
		if input["crouch"]:
			emit_signal("player_crouch")
			collision.shape.height -= crouch_speed * _delta;
			normal_speed = crouch_speed_movement;
		else:
			collision.shape.height += crouch_speed * _delta;
			normal_speed = normal_speed;
		
		collision.shape.height = clamp(collision.shape.height, 0.5, 2)
		

func _jump(_delta : float)->void:
	# Inputs
	input["jump"] = int(Input.is_action_pressed("jump"));
	
	if input["jump"]:
		emit_signal("player_jump")
		if is_on_floor():
			velocity.y = jump_height;

func _sprint(_delta : float)->void:
	# Inputs
	input["sprint"] = int(Input.is_action_pressed("sprint"));
	
	if not input["crouch"]: # If you are not crouching
		var toggle_speed : float = walk_speed + ((sprint_speed - walk_speed) * input["sprint"])
		emit_signal("player_sprint")
		
		normal_speed = lerp(normal_speed, toggle_speed, 3 * _delta);
	else:
		normal_speed = lerp(normal_speed, walk_speed, _delta);
