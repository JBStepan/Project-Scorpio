class WeaponNew:
	var owner : Node;
	var name : String;
	var fire_rate : float;
	var clip_size : int;
	var bullets : int;
	var max_clip_size : int;
	var damage : float;
	var reload_speed : float;
	var type : int;
	var rarity : int;
	
	func _init(owner, name, fire_rate, clip_size, bullets, max_clip_size, damage, reload_speed, type, rarity) -> void:
		self.owner = owner;
		self.name = name;
		self.fire_rate = fire_rate;
		self.clip_size = clip_size;
		self.bullets = bullets;
		self.max_clip_size = max_clip_size;
		self.damage = damage;
		self.reload_speed = reload_speed;
		self.type = type;
		self.rarity = rarity;
		
