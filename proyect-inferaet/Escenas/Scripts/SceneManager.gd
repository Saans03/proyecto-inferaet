extends Node

func change_screen(path : String):
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_file(path)
	
func change_packed_screen(path : PackedScene):
	Engine.time_scale = 1
	get_tree().paused = false
	get_tree().change_scene_to_packed(path)
