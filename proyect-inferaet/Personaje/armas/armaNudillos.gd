extends armaBase

@export var range := 300.0
@export var slash_distance := 80.0
@export var attack_duration := 0.25

func _ready():
	super._ready()
	damage = 500
	cooldown = 0.2

func _attack(target):
	var player: Player = get_parent()
	if player == null:
		return

	attacking = true
	attack_active = true
	visible = true
	hitbox.enable_hitbox()

	var time := 0.0

	while time < attack_duration:
		var dir = player.facing_direction
		global_position = player.global_position + Vector2(dir * slash_distance, 0)
		sprite.flip_h = dir == -1
		sprite.flip_v = dir == -1

		time += get_process_delta_time()
		await get_tree().process_frame

	attack_active = false
	hitbox.disable_hitbox()
	visible = false

	await get_tree().create_timer(cooldown).timeout
	attacking = false

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
