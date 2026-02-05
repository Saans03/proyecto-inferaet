extends Control


func _on_pantalla_inicio_pressed() -> void:
	SceneManager.change_screen("res://Escenas/base/menu.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
