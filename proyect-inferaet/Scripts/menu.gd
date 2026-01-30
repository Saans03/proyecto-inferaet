extends Control

#funciones
func _on_salir_pressed() -> void:
	get_tree().quit()
func _on_jugar_pressed() -> void:
	SceneManager.change_screen("res://PantallaInicio/Escenas/pantalla_carga.tscn")

func _on_configuracion_pressed() -> void:
	SceneManager.change_screen("res://PantallaInicio/EscenasConfiguración/configuracion1.tscn")
