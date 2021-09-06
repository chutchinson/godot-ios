extends Node

export var duration = 1.0
export var start_alpha = 1.0
export var end_alpha = 0.5

var pulse = false

onready var tween = Tween.new()
onready var timer = Timer.new()

func _ready():
	timer.autostart = true
	timer.wait_time = duration
	timer.connect('timeout', self, '_on_tick')
	add_child(tween)
	add_child(timer)
	pass
	
func _on_tick():
	var parent = get_parent()
	if parent != null and parent is Control:
		var start = Color(1.0, 1.0, 1.0, start_alpha)
		var end = Color(1.0, 1.0, 1.0, end_alpha)
		var color = start if pulse else end
		
		tween.interpolate_property(parent, 'modulate', parent.modulate, color, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		
		pulse = not pulse
	pass
