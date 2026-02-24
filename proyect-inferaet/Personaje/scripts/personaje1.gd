extends CharacterBody2D
class_name Player

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats: StatsComponent = $StatsComponent
@onready var level_ui = preload("res://Escenas/interfaz_level_up.tscn")

var facing_direction := 1

signal health_changed
signal exp_changed
signal level_up
var weapons = {}

@export var level := 1
@export var current_exp := 0
@export var exp_to_next := 10
@export var nudillo_scene : PackedScene
@export var lanza_scene : PackedScene
@export var aura_scene : PackedScene


func _ready():
	add_to_group("player")
	add_weapon("nudillo")
	exp_to_next = 5
	
	level_up.connect(_on_level_up)
	stats.died.connect(_on_stats_died)
	stats.health_changed.connect(_on_stats_health_changed)

func _physics_process(delta):
	movement()

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


func add_exp(amount:int):

	current_exp += amount

	exp_changed.emit()

	while current_exp >= exp_to_next:

		current_exp -= exp_to_next
		level += 1
		exp_to_next = int(exp_to_next * 2)
		
		level_up.emit()


func _on_hurt_box_received_damage(damage):
	apply_damage(damage)


func apply_damage(damage:int):

	stats.take_damage(damage)

	anim.modulate = Color.RED
	if not is_inside_tree():
		return
	await get_tree().create_timer(0.1).timeout
	if not is_inside_tree():
		return
	anim.modulate = Color.WHITE

func _on_stats_health_changed(current, max):
	health_changed.emit()

func _on_stats_died():
	SceneManager.change_screen("res://Escenas/base/gameover.tscn")
	
func _on_level_up():

	var ui = level_ui.instantiate()
	get_tree().current_scene.add_child(ui)
	ui.setup(self)

func add_weapon(weapon_id: String):

	if weapons.has(weapon_id):
		return

	var weapon_instance
	
	match weapon_id:
		"nudillo":
			weapon_instance = nudillo_scene.instantiate()
		"lanza":
			weapon_instance = lanza_scene.instantiate()
		"aura":
			weapon_instance = aura_scene.instantiate()

	if weapon_instance:
		add_child(weapon_instance)
		weapons[weapon_id] = weapon_instance

func get_weapons():
	var result = []
	
	for node in get_tree().current_scene.get_children():
		if node is armaBase:
			result.append(node)
	
	return result

func level_up_weapon(weapon_id: String):

	if not weapons.has(weapon_id):
		return
	
	weapons[weapon_id].level_up()
