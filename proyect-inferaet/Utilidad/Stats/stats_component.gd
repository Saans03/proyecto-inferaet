extends Node
class_name StatsComponent

var stats_base: StatsBasePersonaje

var max_health: int
var current_health: int
var speed: float
var attack: int
var defense: int

@export var stats_template: StatsBasePersonaje

func _ready():
	
	stats_base = stats_template.duplicate(true)
	max_health = stats_base.max_health
	current_health = max_health
	speed = stats_base.speed
	attack = stats_base.attack
	defense = stats_base.defense

func get_health():
	return stats_base.max_health
func get_speed() -> float:
	return stats_base.speed

func take_damage(amount: int):
	current_health -= amount
	current_health = clamp(current_health, 0 , stats_base.max_health)
	if current_health <= 0:
		queue_free()
