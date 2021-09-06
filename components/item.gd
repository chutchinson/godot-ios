tool
extends HBoxContainer

export(Resource) var icon setget set_icon
export(String) var when = 'Tomorrow' setget set_when
export(String) var description = '' setget set_description

func _update():
	$Container/TextureRect.texture = icon
	$Label2.text = when
	$Label.text = description

func set_icon(value: Texture):
	icon = value
	_update()
	
func set_when(value: String):
	when = value
	_update()

func set_description(value: String):
	description = value
	_update()

func _ready():
	_update()
	pass

