extends Control
 
var change_scene = load("res://Escenas/base/menu.tscn")
var change_scene1 = load("res://Escenas/configuración/configuracion1.tscn")
var change_scene2 = load("res://Escenas/configuración/configuracion2.tscn")
 
var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]
 
@onready var resolution_option = find_child("ResolucionOption", true, false)
@onready var window_mode_option = find_child("PantallaOption", true, false)
 
@onready var master_slider = find_child("MasterSlider", true, false)
@onready var music_slider = find_child("MusicSlider", true, false)
@onready var sfx_slider = find_child("SFXSlider", true, false)

var opened_from_pause := false
 
func _ready():

	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
 
	if resolution_option != null:
		resolution_option.clear()
		for r in resolutions:
			resolution_option.add_item(str(r.x) + "x" + str(r.y))
		resolution_option.connect("item_selected", Callable(self, "_on_resolution_option_item_selected"))

	if window_mode_option != null:
		window_mode_option.clear()
		window_mode_option.add_item("Ventana")
		window_mode_option.add_item("Pantalla completa")
		window_mode_option.connect("item_selected", Callable(self, "_on_window_mode_selected"))

	if master_slider != null:
		master_slider.connect("value_changed", Callable(self, "_on_master_slider_value_changed"))
	if music_slider != null:
		music_slider.connect("value_changed", Callable(self, "_on_music_slider_value_changed"))
	if sfx_slider != null:
		sfx_slider.connect("value_changed", Callable(self, "_on_sfx_slider_value_changed"))
 
	load_settings()

	if get_tree().current_scene.has_node("Player/Camera2D/CanvasLayer/MenuPausa"):
		opened_from_pause = true
func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
 
	if master_slider != null:
		var master_val = 1.0
		if err == OK:
			master_val = config.get_value("audio", "master", 1.0)
		master_slider.value = master_val
		_apply_master_volume(master_val)
 
	if music_slider != null:
		var music_val = 1.0
		if err == OK:
			music_val = config.get_value("audio", "music", 1.0)
		music_slider.value = music_val
		_apply_music_volume(music_val)
 
	if sfx_slider != null:
		var sfx_val = 1.0
		if err == OK:
			sfx_val = config.get_value("audio", "sfx", 1.0)
		sfx_slider.value = sfx_val
		_apply_sfx_volume(sfx_val)
 
	var window_mode = 0
	if err == OK:
		window_mode = config.get_value("video", "window_mode", 0)
	if window_mode_option != null:
		window_mode_option.select(window_mode)
		_apply_window_mode(window_mode)
 
	var resolution_index = 0
	if err == OK:
		resolution_index = config.get_value("video", "resolution", 0)
	if resolution_option != null:
		resolution_option.select(resolution_index)
 
func save_settings():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
 
	if window_mode_option != null:
		config.set_value("video", "window_mode", window_mode_option.selected)
	if resolution_option != null:
		config.set_value("video", "resolution", resolution_option.selected)
 
	if master_slider != null:
		config.set_value("audio", "master", master_slider.value)
	if music_slider != null:
		config.set_value("audio", "music", music_slider.value)
	if sfx_slider != null:
		config.set_value("audio", "sfx", sfx_slider.value)
 
	config.save("user://settings.cfg")
 
func _on_resolution_option_item_selected(index):
	_apply_resolution(index, true)
	save_settings()
 
func _apply_resolution(index, force_windowed := true):
	if index >= 0 and index < resolutions.size():
		if force_windowed:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
			await get_tree().process_frame
		DisplayServer.window_set_size(resolutions[index])
 
func _on_window_mode_selected(index):
	_apply_window_mode(index)
	save_settings()
 
func _apply_window_mode(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
			if resolution_option != null:
				resolution_option.disabled = false
 
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			if resolution_option != null:
				resolution_option.disabled = true
 
func _apply_master_volume(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
 
func _apply_music_volume(value):
	var bus = AudioServer.get_bus_index("Music")
	if bus != -1:
		AudioServer.set_bus_volume_db(bus, linear_to_db(value))
 
func _apply_sfx_volume(value):
	var bus = AudioServer.get_bus_index("SFX")
	if bus != -1:
		AudioServer.set_bus_volume_db(bus, linear_to_db(value))
 
func _on_master_slider_value_changed(value):
	_apply_master_volume(value)
	save_settings()
 
func _on_music_slider_value_changed(value):
	_apply_music_volume(value)
	save_settings()
 
func _on_sfx_slider_value_changed(value):
	_apply_sfx_volume(value)
	save_settings()

func _on_salir_pressed() -> void:
	if opened_from_pause:
		queue_free()
		var menu_pausa = get_tree().current_scene.get_node("Player/Camera2D/CanvasLayer/MenuPausa")
		menu_pausa.show()
	else:
		SceneManager.change_packed_screen(change_scene)
 
func _on_controles_pressed() -> void:
	SceneManager.change_packed_screen(change_scene1)
 
func _on_gráficos_pressed() -> void:
	SceneManager.change_packed_screen(change_scene2)
 
func _on_confirm_exit_dialog_confirmed() -> void:
	pass
