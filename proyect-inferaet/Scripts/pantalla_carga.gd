extends Control

 
@onready var timer: Timer = $Timer

func _ready():
	timer.start(5)

func _on_timer_timeout():
	SceneManager.change_screen("res://Mapas/mapa.tscn")
