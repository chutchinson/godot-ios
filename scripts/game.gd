extends Node

var home: HomeIntegration = null
var lights = {
	'light.kitchen_main_lights': false,
	'light.kitchen_ceiling_fan_light': false
}

func light_toggle(id: String):
	var state = lights.get(id)
	lights[id] = not state
	yield (home.set_light_state(id, not state), 'completed')

func init():
	pass
	# yield (home.set_light_state('light.kitchen_main_lights', false), 'completed')
	# yield (home.set_light_state('light.kitchen_ceiling_fan_light', false), 'completed')
	
