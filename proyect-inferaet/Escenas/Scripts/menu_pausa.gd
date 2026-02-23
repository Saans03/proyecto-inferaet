extends Control

# =====================================================
# BOTÓN CONTINUAR
# =====================================================
func _on_continuar_pressed() -> void:
	var mapa = get_tree().current_scene
	if mapa.has_method("PauseMenu"):
		mapa.PauseMenu()

# =====================================================
# BOTÓN SALIR
# =====================================================
func _on_salir_pressed() -> void:
	Engine.time_scale = 1
	SceneManager.change_screen("res://Escenas/base/menu.tscn")

# =====================================================
# BOTÓN CONFIGURACIÓN
# =====================================================
func _on_config_pressed() -> void:
	var config_scene = load("res://Escenas/configuración/configuracion1.tscn").instantiate()
	config_scene.return_mode = "pause_menu" # 🔥 Indicamos que viene desde pausa
	get_parent().add_child(config_scene)
	hide() # 🔥 Ocultamos menú pausa mientras está configuración
