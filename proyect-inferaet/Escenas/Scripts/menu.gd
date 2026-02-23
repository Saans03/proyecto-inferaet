extends Control

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_jugar_pressed() -> void:
	SceneManager.change_screen("res://Escenas/base/pantalla_carga.tscn")

func _on_configuracion_pressed() -> void:
	SceneManager.change_screen("res://Escenas/configuración/configuracion1.tscn")

func _ready():
	load_audio_settings()
	load_video_settings()

	await get_tree().process_frame

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

	match window_mode:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

	if resolution_index >= 0 and resolution_index < resolutions.size():
		DisplayServer.window_set_size(resolutions[resolution_index])
		

func load_audio_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		return

	var master_val = config.get_value("audio", "master", 1.0)
	var music_val = config.get_value("audio", "music", 1.0)
	var sfx_val = config.get_value("audio", "sfx", 1.0)

	AudioServer.set_bus_volume_db(0, linear_to_db(master_val))

	var music_bus = AudioServer.get_bus_index("Music")
	if music_bus != -1:
		AudioServer.set_bus_volume_db(music_bus, linear_to_db(music_val))

	var sfx_bus = AudioServer.get_bus_index("SFX")
	if sfx_bus != -1:
		AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(sfx_val))
