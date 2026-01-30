extends Control
@onready var map = $"../../.."
func _on_continuar_pressed() -> void:
	map.PauseMenu()

func _on_salir_pressed() -> void:
	SceneManager.change_screen("res://Escenas/base/menu.tscn")
