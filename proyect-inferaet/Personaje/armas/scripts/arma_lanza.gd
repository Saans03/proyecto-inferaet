extends armaBase

@export var speed := 300.0
@export var max_distance := 1000.0
@export var spawn_offset := 40.0

var direction: Vector2 = Vector2.ZERO
var distance_travelled: float = 0.0


func _ready():
	super._ready()
	level = 1
	damage = 15
	cooldown = 1
	range = 1000
	
	if hitbox:
		hitbox.mode = "instant"


func _find_target():
	var player: Player = get_parent()
	if player == null:
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

	if target == null or not is_instance_valid(target):
		return

	var player: Player = get_parent()
	if player == null or not is_instance_valid(player):
		return

	var tree := get_tree()
	if tree == null:
		return

	var original_parent = player
	var world = tree.current_scene
	if world:
		reparent(world)
		set_as_top_level(true)

	attacking = true
	attack_active = true
	visible = true

	# Dirección
	direction = (target.global_position - player.global_position).normalized()

	global_position = player.global_position + direction * spawn_offset
	rotation = direction.angle()

	if hitbox:
		hitbox.damage = damage
		hitbox.enable_hitbox()

	distance_travelled = 0.0

	while distance_travelled < max_distance and attack_active:

		if not is_inside_tree():
			break

		if tree == null:
			break

		var delta := get_process_delta_time()
		var movement := direction * speed * delta
		
		global_position += movement
		distance_travelled += movement.length()

		await tree.process_frame

	_end_attack()

	if original_parent and is_instance_valid(original_parent):
		reparent(original_parent)
		set_as_top_level(false)
		global_position = original_parent.global_position

	if tree:
		await tree.create_timer(cooldown).timeout

	attacking = false


func _end_attack():
	visible = false
	
	if hitbox:
		hitbox.disable_hitbox()
	
	attack_active = false


func aplicarStatsNivel():
	damage += 15
	cooldown *= 0.4
	speed += 10
	
	if hitbox:
		hitbox.damage = damage
