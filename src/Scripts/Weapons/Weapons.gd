extends Spatial

export var gun1_path : NodePath;
export var gun2_path : NodePath;

var gun1 : Spatial;
var gun2 : Spatial;

var current_weapon = 1;

func _ready():
	gun1 = get_node(gun1_path);
	gun2 = get_node(gun2_path);

func _process(delta):
	weapon_select();

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
