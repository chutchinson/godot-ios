extends Control

var separator = false

func _ready():
	$ClockTimer.connect('timeout', self, '_on_clock_tick')

func _process(delta):
	var date_time = OS.get_datetime()
	var hour = date_time["hour"]
	var minute = date_time["minute"]
	var tt = 'am' if hour < 12 else 'pm'
	var sep = ':' if separator else ' '

	if hour >= 12: hour -= 12
	if hour == 0: hour = 12

	# $ClockHourLabel.text = '%02d%s%02d %s' % [hour, sep, minute, tt]\
	$ClockHourLabel.text = '%02d' % [hour]
	$ClockMinutesLabel.text = '%02d %s' % [minute, tt]

func _on_clock_tick():
	var color_start = Color(1.0, 1.0, 1.0, 1.0)
	var color_end = Color(1.0, 1.0, 1.0, 0.3)
	var to = color_start if separator else color_end
	
	$ClockTween.interpolate_property($ClockSeparator, 'modulate', $ClockSeparator.modulate, to, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$ClockTween.start()
	
	separator = not separator
	pass
	
