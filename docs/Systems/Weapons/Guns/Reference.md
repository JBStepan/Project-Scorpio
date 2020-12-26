## Main reference 
```gdscript
extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1

onready var ammo_label = $"/root/World/UI/Label"
onready var raycast = $"../Head/Camera/RayCast"
var current_ammo = 0
var can_fire = true
var reloading = false

func _ready():
	current_ammo = clip_size
	
func _process(delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		if current_ammo > 0 and not reloading:
			fire()
		elif not reloading:
			reload()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name)

func fire():
	print("Fired weapon")
	can_fire = false
	current_ammo -= 1
	check_collision()
	yield(get_tree().create_timer(fire_rate), "timeout")
	
	can_fire = true

func reload():
	print("Reloading")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	reloading = false
	print("Reload complete")
```

## Weapons Reference
```gdscript
# This was so simple, but I over thought it
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
```

## Also good reference
```gdscript
extends Spatial

# Get character's node path
export(NodePath) var character;

# Get head's node path
export(NodePath) var head;

# Get camera's node path
export(NodePath) var neck;

# Get camera's node path
export(NodePath) var camera;

# Load weapon class for make weapons
var weapon = load("res://data/scripts/weapon/weapon.gd");

# All weapons
var arsenal : Dictionary;

# Current weapon
var current : int = 0;

# Dict of inputs
var input : Dictionary = {};

func _ready() -> void:
	set_as_toplevel(true);
	
	# Get camera node from path
	camera = get_node(camera);
	
	# Get neck node from path
	neck = get_node(neck);
	
	# Get head node from path
	head = get_node(head);
	
	# Get head node from path
	character = get_node(character);
	
	# Class reference : 
	# owner, name, firerate, bullets, ammo, max_bullets, damage, reload_speed;
	
	# Create mk 23 using weapon classs
	arsenal["mk_23"] = weapon.weapon.new(self, "mk_23", 2.0, 12, 999, 12, 40, 1.2);
	
	# Create glock 17 using weapon class
	arsenal["glock_17"] = weapon.weapon.new(self, "glock_17", 3.0, 12, 999, 12, 35, 1.2);
	
	# Create kriss using weapon class
	arsenal["kriss"] = weapon.weapon.new(self, "kriss", 6.0, 32, 999, 33, 25, 1.5);
	
	for w in arsenal:
		arsenal.values()[current]._hide();

func _physics_process(_delta) -> void:
	# Call weapon function
	_weapon(_delta);
	_change();
	_position(_delta);

func _weapon(_delta) -> void:
	input["shoot"] = int(Input.is_action_pressed("mb_left"));
	input["reload"] = int(Input.is_action_pressed("KEY_R"));
	input["zoom"] = int(Input.is_action_pressed("mb_right"));
	
	arsenal.values()[current]._sprint(character.input["sprint"] or character.input["jump"], _delta);
	
	if not character.input["sprint"] or not character.direction:
		if input["shoot"]:
			arsenal.values()[current]._shoot(_delta);
		
		arsenal.values()[current]._zoom(input["zoom"], _delta);
	
	if input["reload"]:
		arsenal.values()[current]._reload();
	
	# Update arsenal
	for w in range(arsenal.size()):
		arsenal.values()[w]._update(_delta);

func _change() -> void:
	# change weapons
	for w in range(arsenal.size()):
		if arsenal.values()[w] != arsenal.values()[current]:
			arsenal.values()[w]._hide();
		else:
			arsenal.values()[w]._draw();

func _position(_delta) -> void:
	var y_lerp = 20;
	var x_lerp = 40;
	
	global_transform.origin = head.global_transform.origin;
	
	if not input["zoom"]:
		rotation.x = lerp_angle(rotation.x, camera.global_transform.basis.get_euler().x, y_lerp * _delta);
		rotation.y = lerp_angle(rotation.y, camera.global_transform.basis.get_euler().y, x_lerp * _delta);
	else:
		rotation = camera.global_transform.basis.get_euler();

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			var anim = arsenal.values()[current].anim
			
			if not anim.is_playing():
				if event.scancode == KEY_1:
					current = 0;
				if event.scancode == KEY_2:
					current = 1;
				if event.scancode == KEY_3:
					current = 2;
#########################################################################################################################################################
func _shoot(_delta) -> void:
		# Get audio node
		var audio = owner.get_node("{}/audio".format([name], "{}"));
		
		# Get effects node
		var effect = owner.get_node("{}/effect".format([name], "{}"));
		
		if bullets > 0:
			# Play shoot animation if not reloading
			if animc != "Shoot" and animc != "Reload" and animc != "Draw" and animc != "Hide":
				bullets -= 1;
				
				# recoil
				owner.camera.rotation.x = lerp(owner.camera.rotation.x, rand_range(1, 2), _delta);
				owner.camera.rotation.y = lerp(owner.camera.rotation.y, rand_range(-1, 1), _delta);
				
				# Shake the camera
				owner.camera.shake_force = 0.002;
				owner.camera.shake_time = 0.2;
				
				# Change light energy
				effect.get_node("shoot").light_energy = 2;
				
				# Emitt fire particles
				effect.get_node("fire").emitting = true;
				
				# Emitt smoke particles
				effect.get_node("smoke").emitting = true;
				
				# Play shoot sound
				audio.get_node("shoot").pitch_scale = rand_range(0.9, 1.1);
				audio.get_node("shoot").play();
				
				# Play shoot animation using firate speed
				anim.play("Shoot", 0, firerate);
				
				# Get barrel node
				var barrel = owner.get_node("{}/barrel".format([name], "{}"));
				
				# Get main scene
				var main = owner.get_tree().get_root().get_child(0);
				
				# Create a instance of trail scene
				var trail = preload("res://data/scenes/trail.tscn").instance();
				
				# Change trail position to out of barrel position
				trail.translation = barrel.global_transform.origin;
				
				# Change trail rotation to camera rotation
				trail.rotation = owner.camera.global_transform.basis.get_euler();
				
				# Add the trail to main scene
				main.add_child(trail);
				
				# Get raycast weapon range
				var ray = owner.get_node("{}/ray".format([name], "{}"));
				
				# Check raycast is colliding
				if ray.is_colliding():
					var local_damage = int(rand_range(damage/1.5, damage))
					
					# Do damage
					if ray.get_collider() is RigidBody:
						ray.get_collider().apply_central_impulse(-ray.get_collision_normal() * (local_damage * 0.3));
					
					if ray.get_collider().is_in_group("prop"):
						if ray.get_collider().is_in_group("metal"):
							var spark = preload("res://data/scenes/spark.tscn").instance();
							
							# Add spark scene in collider
							ray.get_collider().add_child(spark);
								
							# Change spark position to collider position
							spark.global_transform.origin = ray.get_collision_point();
							
							spark.emitting = true;
						
						if ray.get_collider().has_method("_damage"):
							ray.get_collider()._damage(local_damage);
					
					# Create a instance of decal scene
					var decal = preload("res://data/scenes/decal.tscn").instance();
					
					# Add decal scene in collider
					ray.get_collider().add_child(decal);
					
					# Change decal position to collider position
					decal.global_transform.origin = ray.get_collision_point();
					
					# decal spins to collider normal
					decal.look_at(ray.get_collision_point() + ray.get_collision_normal(), Vector3(1, 1, 0));
		else:
			# Play out sound
			if not audio.get_node("out").playing:
				audio.get_node("out").pitch_scale = rand_range(0.9, 1.1);
				audio.get_node("out").play();
```
