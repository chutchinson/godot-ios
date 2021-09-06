extends Spatial

onready var camera = get_viewport().get_camera()

export(Plane) var plane = Plane(0, -1.0, 0, 0.0)

var levels = [2.2, 0.8, 0.0]
var level_index = 0
var level_y = 2.2

func _visit (node: Node):
	for child in node.get_children():
		if child is MeshInstance:
			_apply(child)
		else:
			_visit(child)

func _apply (node: MeshInstance):
	var distance = node.global_transform.origin.distance_to(camera.global_transform.origin)
	for x in range(0, node.get_surface_material_count()):
		var material = node.get_surface_material(x)
		if material is ShaderMaterial:
			material.render_priority = 0
			material.set_shader_param('plane', plane)

func _ready():
	_visit(self)

func _process(delta):
	_visit(self)
	
	if (Input.is_action_just_pressed("ui_accept")):
		level_index = wrapi(level_index + 1, 0, len(levels))
		$Tween.remove_all()
		$Tween.interpolate_property(self, 'level_y', level_y, levels[level_index], 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		
	plane.d = level_y
