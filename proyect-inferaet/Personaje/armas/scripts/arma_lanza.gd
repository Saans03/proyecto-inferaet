extends armaBase

@export var speed := 300.0
@export var max_distance := 1000.0

var direction: Vector2 = Vector2.ZERO
var distance_travelled: float = 0.0

func _ready():
	super._ready()
	level = 1
	damage = 50
	cooldown = 3
	range = 1000
	
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
	
	global_position = player.global_position
	
	direction = (target.global_position - global_position).normalized()
	rotation = direction.angle()
	
	hitbox.damage = damage
	hitbox.enable_hitbox()
	
	distance_travelled = 0.0

	while distance_travelled < max_distance and attack_active:

		var player_node = get_parent()
		if player_node == null or not is_instance_valid(player_node):
			break

		var tree = get_tree()
		if tree == null:
			break

		var delta = get_process_delta_time()
		var movement = direction * speed * delta
	
		global_position += movement
		distance_travelled += movement.length()

		await tree.process_frame

	_end_attack()

	var tree = get_tree()
	if tree:
		await tree.create_timer(cooldown).timeout

	attacking = false

func _end_attack():
	visible = false
	hitbox.disable_hitbox()
	attack_active = false
	

func aplicarStatsNivel():

	damage += 15
	cooldown *= 0.95
	speed += 10
	
	hitbox.damage = damage
