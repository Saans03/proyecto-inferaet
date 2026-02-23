extends Control

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var total_seconds: int = 0

func _ready():
	custom_minimum_size = Vector2(200, 60)
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.text = "00:00"
	label.add_theme_color_override("font_color", Color.ORANGE_RED)
	
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	get_viewport().size_changed.connect(_update_position)
	_update_position()


func _on_timer_timeout():
	total_seconds += 1
	
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	
	label.text = "%02d:%02d" % [minutes, seconds]


func _update_position():
	var mode = DisplayServer.window_get_mode()
	
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		offset_top = 15   
	else:
		offset_top = 20   
