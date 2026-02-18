extends Node
class_name StatsComponent

signal died
signal health_changed(current, max)

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

func get_current_health():
	return current_health

func get_max_health():
	return max_health

func get_speed() -> float:
	return speed

func take_damage(amount: int):

	current_health -= amount
	current_health = clamp(current_health, 0, max_health)

	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		died.emit()
