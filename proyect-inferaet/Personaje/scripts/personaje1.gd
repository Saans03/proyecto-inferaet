extends CharacterBody2D

class_name Player

@onready var stats: StatsComponent = $StatsComponent

signal health_changed

func _ready():
	print("Vida inicial:", stats.current_health)

func _physics_process(delta):
	movement()

func movement():
	var mov_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var mov_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(mov_x, mov_y)
	velocity = mov.normalized() * stats.get_speed()
	move_and_slide()


func _on_hurt_box_received_damage(damage):
	stats.current_health -= damage
	print(stats.current_health)
	health_changed.emit()
	if stats.current_health <= 0:
		SceneManager.change_screen("res://Escenas/base/gameover.tscn")
