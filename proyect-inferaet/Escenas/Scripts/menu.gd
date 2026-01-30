extends Control

#funciones
func _on_salir_pressed() -> void:
	get_tree().quit()
func _on_jugar_pressed() -> void:
	SceneManager.change_screen("res://Escenas/base/pantalla_carga.tscn")

func _on_configuracion_pressed() -> void:
	SceneManager.change_screen("res://Escenas/configuración/configuracion1.tscn")
