extends Area2D
class_name Hitbox

@export var damage = 1
@export var auto_add_attack_group := true

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHitboxTimer


func _ready():

	if auto_add_attack_group:
		add_to_group("attack")

	# IMPORTANTE → siempre listo para detectar
	monitoring = true


# ---------------------------------
# YA EXISTENTE
# ---------------------------------
func tempdisable():
	collision.call_deferred("set", "disabled", true)
	disableTimer.start()


func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set", "disabled", false)


# ---------------------------------
# ARMA AUTOMATICA
# ---------------------------------
func trigger_hit():

	collision.disabled = false

	await get_tree().create_timer(0.08).timeout

	collision.disabled = true
