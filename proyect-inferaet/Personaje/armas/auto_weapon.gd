extends Node2D

@export var damage := 500
@export var range := 300.0
@export var slash_distance := 80.0
@export var attack_duration := 0.25
@export var cooldown := 0.8

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox

var attacking := false


func _ready():
	visible = false

	hitbox.damage = damage
	hitbox.weapon = self   # Opcional si usas lógica extra en hitbox
	hitbox.disable_hitbox()

	attack_loop()


# -------------------------
# LOOP ATAQUE AUTOMÁTICO
# -------------------------
func attack_loop():
	while true:

		if not attacking and _find_closest_enemy():
			await _attack()

		await get_tree().process_frame


# -------------------------
# ATAQUE SINCRONIZADO REAL
# -------------------------
func _attack():

	var player: Player = get_parent()
	if player == null:
		return

	attacking = true

	# ⭐ INICIO EXACTO DEL ATAQUE
	visible = true
	hitbox.enable_hitbox()

	var time := 0.0

	while time < attack_duration:

		var dir = player.facing_direction

		global_position = player.global_position + Vector2(dir * slash_distance, 0)
		sprite.flip_h = dir == -1

		time += get_process_delta_time()
		await get_tree().process_frame


	# ⭐ FIN EXACTO DEL ATAQUE
	hitbox.disable_hitbox()
	visible = false

	await get_tree().create_timer(cooldown).timeout

	attacking = false


# -------------------------
# BUSCAR ENEMIGO
# -------------------------
func _find_closest_enemy():

	var player: Player = get_parent()
	if player == null:
		return null

	var enemies = get_tree().get_nodes_in_group("enemy")

	var best = null
	var best_dist = INF

	for e in enemies:
		if e == null:
			continue

		var d = player.global_position.distance_to(e.global_position)

		if d < best_dist and d <= range:
			best_dist = d
			best = e

	return best
