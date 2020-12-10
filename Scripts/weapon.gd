extends Node;
class weapon:
	var owner : Node;
	var name : String;
	var firerate : float;
	var bullets : int;
	var ammo : int;
	var max_bullets : int;
	var damage : int;
	var reload_speed : float;
	
	func _init(owner, name, firerate, bullets, ammo, max_bullets, damage, reload_speed) -> void:
		self.owner = owner;
		self.name = name;
		self.firerate = firerate;
		self.bullets = bullets;
		self.ammo = ammo;
		self.max_bullets = max_bullets;
		self.damage = damage;
		self.reload_speed = reload_speed;
	
	# Get animation node
	#var anim = owner.get_node("{}/mesh/anim".format([name], "{}"));
	
	# Get current animation
	#var animc = anim.current_animation;
	
	# Get animation node
	var mesh = owner.get_node("{}".format([name], "{}"));
	
#	func _draw() -> void:
#		# Check is visible
#		if not mesh.visible:
#			# Play draw animaton
#			anim.play("Draw");
#
#	func _hide() -> void:
#		# Check is visible
#		if mesh.visible:
#			# Play hide animaton
#			anim.play("Hide");
	
	func _sprint(sprint, _delta) -> void:
		if sprint and owner.character.direction:
			mesh.rotation.x = lerp(mesh.rotation.x, -deg2rad(40), 5 * _delta);
		else:
			mesh.rotation.x = lerp(mesh.rotation.x, 0, 5 * _delta);
	
	func _shoot(_delta) -> void:
		pass

	func _reload() -> void:
		if bullets < max_bullets and ammo > 0:				
			for b in ammo:
				bullets += 1
				ammo -= 1;
					
				if bullets >= max_bullets:
					break;
	
	func _zoom(input, _delta) -> void:
		var lerp_speed : int = 30;
		var camera = owner.camera;
		
		if input:
			camera.fov = lerp(camera.fov, 40, lerp_speed * _delta);
			mesh.translation.y = lerp(mesh.translation.y, 0.001, lerp_speed * _delta);
			mesh.translation.x = lerp(mesh.translation.x, -0.088, lerp_speed * _delta);
		else:
			camera.fov = lerp(camera.fov, 70, lerp_speed * _delta);
			mesh.translation.y = lerp(mesh.translation.y, 0, lerp_speed * _delta);
			mesh.translation.x = lerp(mesh.translation.x, 0, lerp_speed * _delta);
	
#	func _update(_delta) -> void:
#		if animc != "Shoot":
#			if owner.arsenal.values()[owner.current] == self:
#				owner.camera.rotation.x = lerp(owner.camera.rotation.x, 0, 10 * _delta);
#				owner.camera.rotation.y = lerp(owner.camera.rotation.y, 0, 10 * _delta);
		
		# Remove recoil
		mesh.rotation.x = lerp(mesh.rotation.x, 0, 5 * _delta);
