extends armaBase

@export var slash_distance := 80.0
@export var attack_duration := 0.25

func _ready():
	super._ready()
	level = 1
	damage = 25
	cooldown = 1
	range = 300
	
	if hitbox:
		hitbox.mode = "instant"


func _find_target():
	var player: Player = get_parent()
	if player == null or not is_instance_valid(player):
		return null

	var best = null
	var best_dist = INF

	for e in EnemyManager.enemies:
		if e == null or not is_instance_valid(e):
			continue

		var d = player.global_position.distance_to(e.global_position)
		if d < best_dist and d <= range:
			best_dist = d
			best = e

	return best


func _attack(target):

	var player: Player = get_parent()
	if player == null or not is_instance_valid(player):
		return  

	var tree := get_tree()
	if tree == null:
		return

	attacking = true
	attack_active = true
	visible = true

	if hitbox:
		hitbox.damage = damage
		hitbox.enable_hitbox()

	var time := 0.0

	while time < attack_duration and attack_active:

		# Failsafes dentro del loop
		if not is_inside_tree():
			break

		player = get_parent()
		if player == null or not is_instance_valid(player):
			break

		tree = get_tree()
		if tree == null:
			break

		var dir = 1
		if "facing_direction" in player:
			dir = player.facing_direction

		global_position = player.global_position + Vector2(dir * slash_distance, 0)

		if sprite:
			sprite.flip_h = dir == -1
			sprite.flip_v = false 

		time += get_process_delta_time()

		await tree.process_frame

	_end_attack()

	if tree:
		await tree.create_timer(cooldown).timeout

	attacking = false


func _end_attack():
	visible = false
	attack_active = false
	
	if hitbox:
		hitbox.disable_hitbox()


func aplicarStatsNivel():
	damage += 20
	cooldown *= 0.97
	
	if hitbox:
		hitbox.damage = damage
