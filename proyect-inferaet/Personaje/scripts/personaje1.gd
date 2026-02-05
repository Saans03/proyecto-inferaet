extends CharacterBody2D
class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: StatsComponent = $StatsComponent

var facing_direction := 1

signal health_changed
signal exp_changed
signal level_up

# -------------------------
# EXP SYSTEM
# -------------------------
@export var level := 1
@export var current_exp := 0
@export var exp_to_next := 10


func _ready():
	add_to_group("player")
	print("PLAYER READY")
	exp_to_next = 5


func _physics_process(delta):
	movement()


# -------------------------
# MOVEMENT
# -------------------------
func movement():

	var mov_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var mov_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(mov_x, mov_y)

	if mov_x != 0:
		facing_direction = sign(mov_x)
		anim.flip_h = facing_direction > 0

	if mov != Vector2.ZERO:
		velocity = mov.normalized() * stats.get_speed()

		if anim.animation != "walk":
			anim.play("walk")
	else:
		velocity = Vector2.ZERO

		if anim.animation != "idle":
			anim.play("idle")

	move_and_slide()


# -------------------------
# EXP SYSTEM
# -------------------------
func add_exp(amount:int):

	current_exp += amount
	print("EXP +", amount, " -> ", current_exp, "/", exp_to_next)

	exp_changed.emit()

	while current_exp >= exp_to_next:

		current_exp -= exp_to_next
		level += 1
		exp_to_next = int(exp_to_next * 1.4)

		print("LEVEL UP -> ", level)
		level_up.emit()


# -------------------------
# DAMAGE SYSTEM (CORRECTO)
# -------------------------
func _on_hurt_box_received_damage(damage):
	apply_damage(damage)


func apply_damage(damage:int):

	stats.current_health -= damage

	print("PLAYER TOOK DAMAGE:", damage)
	print("HP:", stats.current_health)

	health_changed.emit()

	if stats.current_health <= 0:
		SceneManager.change_screen("res://Escenas/base/gameover.tscn")
		return

	
	anim.modulate = Color.RED
	if not is_inside_tree():
		return
	await get_tree().create_timer(0.1).timeout
	if not is_inside_tree():
		return
	anim.modulate = Color.WHITE
