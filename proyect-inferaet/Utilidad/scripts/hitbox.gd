extends Area2D
class_name Hitbox

@export var damage = 1
@export var auto_add_attack_group := true

var weapon = null

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHitboxTimer


func _ready():

	if auto_add_attack_group:
		add_to_group("attack")

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
# ⭐ AHORA SOLO CONTROL EXTERNO
# ---------------------------------
func enable_hitbox():
	collision.disabled = false


func disable_hitbox():
	collision.disabled = true
