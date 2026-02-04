extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitbox") var HurtBoxType = 0 

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal received_damage(damage: int)


func _on_area_entered(area):
	
	if not area.is_in_group("attack"):
		return

	if area.get("damage") == null:
		return

	match HurtBoxType:

		0: # Cooldown
			collision.call_deferred("set", "disabled", true)
			disableTimer.start()

		1: # HitOnce
			pass

		2: # DisableHitbox
			if area.has_method("tempdisable"):
				area.tempdisable()

	emit_signal("received_damage", area.damage)


func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
