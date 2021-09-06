extends HBoxContainer

func _ready():
	Game.home.connect('refresh', self, '_on_refresh')
	pass
	
func _fahrenheit(value):
	return value * (9.0 / 5.0) + 32.0
	
func _on_refresh():
	var temperature = Game.home.temperature
	var temperature_f = _fahrenheit(temperature)
	$TemperatureLabel.text = '%02d°F' % [temperature_f]
	pass
