extends Control

@onready var animacion: AnimatedSprite2D = $AnimatedSprite2D
#funciones
func _physics_process(delta):
	animacion.play("titulo")
	
func _on_salir_pressed() -> void:
	get_tree().quit()
func _on_jugar_pressed() -> void:
	SceneManager.change_screen("res://Escenas/base/pantalla_carga.tscn")

func _on_configuracion_pressed() -> void:
	SceneManager.change_screen("res://Escenas/configuración/configuracion1.tscn")

func _ready():
	load_video_settings()
	
func load_video_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		return
	
	var window_mode = config.get_value("video", "window_mode", 0)
	var resolution_index = config.get_value("video", "resolution", 0)
	
	var resolutions = [
		Vector2i(1280, 720),
		Vector2i(1600, 900),
		Vector2i(1920, 1080)
	]
	
	# Aplicar modo
	match window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	# Aplicar resolución (solo si es válida)
	if resolution_index >= 0 and resolution_index < resolutions.size():
		DisplayServer.window_set_size(resolutions[resolution_index])
