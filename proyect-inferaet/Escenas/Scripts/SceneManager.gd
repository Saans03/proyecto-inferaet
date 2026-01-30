extends Node

func change_screen(path: String):
	get_tree().change_scene_to_file(path)

func change_packed_screen(packed : PackedScene):
	get_tree().change_scene_to_packed(packed)
	
func paused_scene() :
	get_tree().paused = true
