extends Node2D

@onready var menuPausa = $Player/Camera2D/MenuPausa
var pausa = false

func _process(delta):
	if Input.is_action_just_pressed("escapeMenu"):
		PauseMenu()

func PauseMenu ():
	if pausa:
		menuPausa.hide()
		Engine.time_scale = 1
	else:
		menuPausa.show()
		Engine.time_scale = 0
	pausa = !pausa
