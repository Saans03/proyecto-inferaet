extends Node2D

@export var damage : int = 5
@export var attack_rate : float = 1.5
@export var range : float = 300.0

@export var orbit_speed = 4.0
@export var orbit_radius = 60.0

var target = null
var angle = 0.0

@onready var sprite = $Sprite2D
@onready var hitbox : Hitbox = $Hitbox
@onready var timer = $Timer


func _ready():

	hitbox.damage = damage

	# MUY IMPORTANTE → empieza desactivada
	hitbox.collision.disabled = true

	timer.wait_time = 1.0 / attack_rate
	timer.timeout.connect(_attack)
	timer.start()


func _process(delta):

	angle += orbit_speed * delta
	position = Vector2(cos(angle), sin(angle)) * orbit_radius

	_find_closest_enemy()

	if target:
		look_at(target.global_position)


# -------------------------
# BUSCAR ENEMIGO
# -------------------------
func _find_closest_enemy():

	var enemies = get_tree().get_nodes_in_group("enemy")

	var closest_dist = INF
	target = null

	for e in enemies:

		if e == null:
			continue

		var dist = global_position.distance_to(e.global_position)
		
		if dist < closest_dist and dist <= range:
			closest_dist = dist
			target = e
		


# -------------------------
# ATAQUE
# -------------------------
func _attack():

	if target == null:
		return

	hitbox.damage = damage
	hitbox.trigger_hit()

	_hit_effect()


# -------------------------
# EFECTO VISUAL
# -------------------------
func _hit_effect():

	sprite.scale = Vector2(1.25, 1.25)

	await get_tree().create_timer(0.05).timeout

	sprite.scale = Vector2(1, 1)
