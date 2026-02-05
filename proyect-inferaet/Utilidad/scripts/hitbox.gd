extends Area2D
class_name Hitbox

@export var damage := 1

var weapon = null

@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready():
	monitoring = true


# -------------------------
# CONTROL EXTERNO
# -------------------------
func enable_hitbox():
	collision.disabled = false


func disable_hitbox():
	collision.disabled = true


# -------------------------
# DETECCIÓN DAÑO
# -------------------------
func _on_area_entered(area):

	if weapon == null:
		return

	if not weapon.attack_active:
		return

	if area.has_method("take_damage"):
		area.take_damage(damage)
