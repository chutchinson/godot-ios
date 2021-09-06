extends Node
class_name HomeIntegration

export var base_url: String = 'http://192.168.86.192:8123'

signal refresh

var _token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiI0MGU3ZDEwMzEzNjc0YzM2OTgxMTdkMjI5NGNiYTg2MiIsImlhdCI6MTYzMDc3NzcwMCwiZXhwIjoxOTQ2MTM3NzAwfQ.FJ0bq76LNA2cP1z015at_Ct6oDuVRlLnbQGV375-mg4'
var _http: HTTPRequest

var lights = []
var temperature: float = 0.0
var humidity: float = 0.0
var mode = 'off'
var index = 0

onready var rng = RandomNumberGenerator.new()

func _enter_tree():
	_http = HTTPRequest.new()
	add_child(_http)

func _ready():
	$UpdateTimer.connect('timeout', self, '_update')
	$UpdateTimer.wait_time = 5.0
	Game.home = self
	Game.init()
	_update()
	
func _process(_delta):
	if Input.is_action_just_pressed('ui_focus_next'):
		set_mode_debug()
		
func set_mode_debug():
	index = wrapi(index + 1, 0, 3)
	if index == 0: mode = 'off'
	if index == 1: mode = 'heating'
	if index == 2: mode = 'cooling'
	_refresh()
	pass
		
func _refresh():
	print('refresh')
	$UpdateTimer.start(0.0)
	emit_signal('refresh')
		
func _update():
	_update_temperature()
	_update_humidity()
	_refresh()
	
func _update_temperature():
	var content = yield(_send(HTTPClient.METHOD_GET, 'api/states/sensor.temperature', null), 'completed')
	var json = JSON.parse(content)
	temperature = float(json.result['state'])
	
func _update_humidity():
	return 0.0

func _send(method, url, payload):
	var headers = PoolStringArray()
	headers.append('Content-Type: application/json')
	headers.append('Authorization: Bearer %s' % [_token])
	
	var request_uri = '%s/%s' % [base_url, url]
	_http.request(request_uri, headers, false, method, payload if payload != null else '')
	var result = yield(_http, 'request_completed')
	var content: PoolByteArray = result[3]
	
	return content.get_string_from_ascii()
	
func set_light_state(id, state):
	var payload = JSON.print({
		"entity_id": id
	})
	
	var content = _send(HTTPClient.METHOD_POST, 'api/services/light/%s' % ['turn_on' if state else 'turn_off'], payload)
	print(content)
