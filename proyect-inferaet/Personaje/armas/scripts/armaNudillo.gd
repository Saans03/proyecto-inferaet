extends armaBase
@export var slash_distance := 80.0
@export var attack_duration := 0.25

func _ready():
	super._ready()
	level = 1
	damage = 25
	cooldown = 1
	range = 300
	
	hitbox.mode = "instant"

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
	var player: Player = get_parent()
	if player == null:
		return  

	attacking = true
	attack_active = true
	visible = true
	hitbox.enable_hitbox()
	hitbox.damage = damage

	var time := 0.0

	while time < attack_duration:
		player = get_parent()
		if player == null or not is_inside_tree():
			break

		var dir = player.facing_direction
		global_position = player.global_position + Vector2(dir * slash_distance, 0)
		sprite.flip_h = dir == -1
		sprite.flip_v = dir == -1

		time += get_process_delta_time()

		if get_tree() != null:
			await get_tree().process_frame

	hitbox.disable_hitbox()
	visible = false
	attacking = false
	
func aplicarStatsNivel():

	damage += 20
	cooldown *= 0.97
	
	hitbox.damage = damage
