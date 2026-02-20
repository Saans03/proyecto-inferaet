extends armaBase

func _ready():
	super._ready()
	level = 1
	damage = 50
	cooldown = 1

func _find_target():
	
	var player: Player = get_parent()
	if player == null:
		return null

	var best = null
	var best_dist = INF

	for e in EnemyManager.enemies:
		if e == null:
			continue

		var d = player.global_position.distance_to(e.global_position)
		if d < best_dist and d <= range:
			best_dist = d
			best = e

	return best
func _attack(target):
	return true
