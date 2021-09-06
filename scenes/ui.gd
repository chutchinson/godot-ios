extends Control

export(Texture) var heating_icon
export(Texture) var cooling_icon

onready var home: HomeIntegration = Game.home
onready var climate_background = $"TextureRect"
onready var climate_info = $"Climate/HBoxContainer2"
onready var climate_label = $"Climate/HBoxContainer2/ClimateLabel"
onready var climate_icon = $"Climate/HBoxContainer2/ClimateIcon"
onready var climate_temperature_label = $"Climate/HBoxContainer/TemperatureLabel"
onready var climate_anim = $"Climate/HBoxContainer2/Pulse"

var last_mode = ''

func _ready():
	home.connect('refresh', self, '_on_refresh')
	_update()
	pass
	
func _update():
	var gradient_texture = climate_background.texture as GradientTexture
	var gradient = gradient_texture.gradient
	var climate_color = Color.black
	
	$Tween.remove_all()
	
	if home.mode != last_mode:
		last_mode = home.mode
		match home.mode:
			'heating':
				_fade_in(climate_background)
				_fade_in(climate_info)
				climate_anim.set_process(true)
				climate_icon.texture = heating_icon
				climate_label.text = 'Heating'
				climate_color = Color('#ffff9b00')
			'cooling':
				_fade_in(climate_background)
				_fade_in(climate_info)
				climate_anim.set_process(true)
				climate_icon.texture = cooling_icon
				climate_label.text = 'Cooling'
				climate_color = Color('#ff00b1ff')
			'off':
				_fade_out(climate_background)
				_fade_out(climate_info)
				climate_anim.set_process(false)
				
		gradient.colors[0] = climate_color
		
		climate_background.self_modulate.a = 0.567
		climate_icon.modulate = climate_color
		climate_label.modulate = climate_color
	pass
	
func _on_refresh():
	_update()
	pass
	
func _fade_out(target: Control):
	print('fade out')
	_fade(target, 0.0)

func _fade_in(target: Control):
	print('fade in')
	_fade(target, 1.0)

func _fade(target: Control, alpha: float):
	var color = Color(1.0, 1.0, 1.0, alpha)
	$Tween.interpolate_property(target, 'modulate', target.modulate, color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	pass
	
func _on_Control_gui_input(event):
	if (event is InputEventScreenTouch and event.pressed) or \
	   (event is InputEventMouseButton and event.pressed and event.button_index == 1):
		print('debug')
		Game.home.set_mode_debug()
	pass # Replace with function body.
