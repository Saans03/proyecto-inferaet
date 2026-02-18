extends Control
 
var change_scene = load("res://Escenas/base/menu.tscn")
var change_scene1 = load("res://Escenas/configuración/configuracion1.tscn")
var change_scene2 = load("res://Escenas/configuración/configuracion2.tscn")
var change_scene3 = load("res://Escenas/configuración/configuracion3.tscn")
var change_scene4 = load("res://Escenas/configuración/configuracion4.tscn")
 
var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]
 
@onready var resolution_option = find_child("ResolutionOption", true, false)
 
 
func _ready():
 
	if resolution_option != null:
 
		resolution_option.clear()
 
		for r in resolutions:
			resolution_option.add_item(str(r.x) + "x" + str(r.y))
 
 
# --- CAMBIAR RESOLUCIÓN ---
func _on_resolution_option_item_selected(index):

	if resolution_option == null:
		return
 
	print("Cambiando a:", resolutions[index])
 
	# Forzar modo ventana
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
 
	# Esperar un frame (esto arregla MUCHOS bugs)
	await get_tree().process_frame
 
	# Aplicar resolución
	DisplayServer.window_set_size(resolutions[index])
 
 
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


func _on_confirm_exit_dialog_confirmed() -> void:
	pass # Replace with function body.
