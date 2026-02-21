extends MarginContainer

@export var fullscreen_offset: float = 40.0
var original_y: float = 0.0
var last_mode: int = -1

func _ready():
	original_y = position.y
	_update_position()

func _process(_delta):
	var mode = DisplayServer.window_get_mode()
	if mode != last_mode:
		last_mode = mode
		_update_position()

func _update_position():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		position.y = original_y - fullscreen_offset
	else:
		position.y = original_y
