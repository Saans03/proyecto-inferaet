extends Control

var change_scene = load("res://PantallaInicio/Escenas/menu.tscn")
var change_scene1 = load("res://PantallaInicio/EscenasConfiguración/configuracion1.tscn")
var change_scene2 = load("res://PantallaInicio/EscenasConfiguración/configuracion2.tscn")
var change_scene3 = load("res://PantallaInicio/EscenasConfiguración/configuracion3.tscn")
var change_scene4 = load("res://PantallaInicio/EscenasConfiguración/configuracion4.tscn")


func _on_salir_pressed() -> void:
	SceneManager.change_packed_screen(change_scene)

func _on_controles_pressed() -> void:
	SceneManager.change_packed_screen(change_scene1)
	
func _on_gráficos_pressed() -> void:
	SceneManager.change_packed_screen(change_scene2)

func _on_jugabilidad_pressed() -> void:
	SceneManager.change_packed_screen(change_scene3)

func _on_sistema_pressed() -> void:
	SceneManager.change_packed_screen(change_scene4)
