extends Control

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var total_seconds: int = 300  # 5 minutos

func _ready():
	custom_minimum_size = Vector2(200, 60)
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color.ORANGE_RED)
	
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	
	_update_label()  # Mostrar 05:00 antes de empezar
	timer.start()
	
	get_viewport().size_changed.connect(_update_position)
	_update_position()


func _on_timer_timeout():
	if total_seconds > 0:
		total_seconds -= 1
		_update_label()
	else:
		timer.stop()
		print("Tiempo terminado")


func _update_label():
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	label.text = "%02d:%02d" % [minutes, seconds]


func _update_position():
	var mode = DisplayServer.window_get_mode()
	
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		offset_top = 15
	else:
		offset_top = 20
