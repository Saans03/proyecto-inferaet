extends Node

var enemies: Array = []

func register_enemy(enemy):
	enemies.append(enemy)
	
func unregister_enemy(enemy):
	enemies.erase(enemy)
