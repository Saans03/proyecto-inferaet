extends Control

# Nodo del mapa/juego principal
@onready var map = $"../../.."

# =====================================================
# BOTÓN CONTINUAR
# =====================================================
func _on_continuar_pressed() -> void:
	# Llama a la función PauseMenu() del mapa para despausar
	if map.has_method("PauseMenu"):
		map.PauseMenu()
	queue_free() # Cerramos la UI de pausa

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
	# Abrir la configuración encima del juego, sin cerrar la UI de pausa
	var config_scene = load("res://Escenas/configuración/configuracion1.tscn").instantiate()
	get_parent().add_child(config_scene)
	# ❌ NO usar queue_free() aquí, para evitar errores de nodos eliminados
