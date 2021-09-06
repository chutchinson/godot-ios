extends MeshInstance

export(String) var light_id = ''
export(Color) var light_color = Color.yellow
var state = false

func _ready():
	# $OmniLight.visible = true
	pass

func set_state (value: bool):
	state = value
	$OmniLight.light_color = light_color
	$OmniLight.visible = value
	Game.light_toggle(light_id)
	
func _on_Area_input_event(_camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		set_state(not state)
	pass # Replace with function body.	
