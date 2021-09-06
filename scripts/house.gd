extends Spatial

var rotation_speed = 180.0
var margin = 0.3
var drag_x = 0.0
var dragging = false

func _input(ev):
	
	if ev is InputEventMouseButton:
		if ev.button_index == 1 and ev.pressed:
			_check_touch(ev)
		elif not ev.pressed:
			drag_x = 0.0
	if ev is InputEventScreenTouch:
		if ev.pressed:
			_check_touch(ev)
		else:
			drag_x = 0.0
			
	if ev is InputEventKey and ev.pressed and ev.scancode == KEY_BACKSPACE:
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png('D:/bastion.png')
		pass
		
func _check_touch(ev):
		
	var viewport = get_viewport()
	var rect = viewport.get_visible_rect()
	var vw = rect.size.x
	var vh = rect.size.y
	
	if ev.position.x <= vw * margin:
		drag_x = -1.0
	if ev.position.x >= vw - (vw * margin):
		drag_x = 1.0
		
func _physics_process(delta):

	var can_turn_left = Input.is_key_pressed(KEY_A) or drag_x < 0.0
	var can_turn_right = Input.is_key_pressed(KEY_D) or drag_x > 0.0
	
	if can_turn_left:
		rotation_degrees.y += rotation_speed * delta
		
	if can_turn_right:
		rotation_degrees.y -= rotation_speed * delta
		
	pass

func _process(delta):
	pass
