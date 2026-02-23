extends Node2D

@onready var menuPausa = $Player/Camera2D/CanvasLayer/MenuPausa
var pausa = false
var tiempo = 0

func _ready():
	Engine.time_scale = 1
	pausa = false
	menuPausa.hide()

func _process(delta):
	if Input.is_action_just_pressed("escapeMenu"):
		if get_tree().current_scene.has_node("Configuracion"):
			return
		PauseMenu()

func PauseMenu ():
	if pausa:
		menuPausa.hide()
		Engine.time_scale = 1
	else:
		menuPausa.show()
		Engine.time_scale = 0
	pausa = !pausa


func _on_timer_timeout():
	tiempo += 1
	$timer/Label.text = str(tiempo)
