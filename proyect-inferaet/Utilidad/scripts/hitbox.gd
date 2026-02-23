extends Area2D
class_name Hitbox

@export var damage := 1
@export var mode := "instant"
@export var tick_rate := 0.2 

var weapon = null
var tick_timer := 0.0

@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready():
	monitoring = true
	area_entered.connect(_on_area_entered)
	


func enable_hitbox():
	collision.disabled = false


func disable_hitbox():
	collision.disabled = true


func _process(delta):

	if mode != "continuous":
		return

	if weapon == null or not weapon.attack_active:
		return
	

	tick_timer -= delta
	if tick_timer > 0:
		return

	for area in get_overlapping_areas():
		print("Detectado:", area.name, " | Grupo:", area.get_groups())
		if area.has_signal("received_damage"):
			area.emit_signal("received_damage", damage)

	tick_timer = tick_rate


func _on_area_entered(area):

	if mode != "instant":
		return

	if weapon == null or not weapon.attack_active:
		return

	if area.has_signal("received_damage"):
		area.emit_signal("received_damage", damage)
