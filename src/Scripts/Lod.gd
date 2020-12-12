extends Spatial;

# LOD nodes
export var lod0 : NodePath;
export var lod1 : NodePath;
export var lod2 : NodePath;

# LOD Distance Settings
export var lod_distance_0 : float = 50;
export var lod_distance_1 : float = 100;
export var lod_distance_2 : float = 150;
export var lod_culling : bool = true;

# Find "Camera" from Root scene. Name must be exact "Camera"
export var auto_detect_camera : bool = true; 

# Or, you can specify the camera from Inspector or from Script
export var camera : NodePath;

var enabled = true;
var mesh_lod0;
var mesh_lod1;
var mesh_lod2;

func _ready():
	if auto_detect_camera:
	 camera = get_tree().get_root().find_node("Camera", true, false);
	
	if typeof(camera) == TYPE_NODE_PATH:
		camera = get_node(camera);
		
	if camera == null:
		print("Camera not found. LOD will not work.");
		set_process(false);
		return;
		
	mesh_lod0 = lod0;
	mesh_lod1 = lod1;
	mesh_lod2 = lod2;
		
	update_lod();
	
func _process(delta):
	if enabled == false:
		return;

	update_lod();
	
func get_distance_to_camera() -> float:
	var camera_translation = camera.get_global_transform().origin;
	var object_translation = get_global_transform().origin;
	
	return camera_translation.distance_to(object_translation);
	
func update_lod()->void:
	var distance = get_distance_to_camera();
	
	if distance <= lod_distance_0:
		mesh_lod0.visible = true;
		mesh_lod1.visible = false;
		mesh_lod2.visible = false;
	elif distance <= lod_distance_1:
		mesh_lod0.visible = false;
		mesh_lod1.visible = true;
		mesh_lod2.visible = false;
	elif distance <= lod_distance_2:
		mesh_lod0.visible = false;
		mesh_lod1.visible = false;
		mesh_lod2.visible = true;
	else:
		if lod_culling:
			mesh_lod0.visible = false;
			mesh_lod1.visible = false;
			mesh_lod2.visible = false;
		else:
			mesh_lod0.visible = false;
			mesh_lod1.visible = false;
			mesh_lod2.visible = true;
