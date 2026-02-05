extends CharacterBody2D

@export var exp_drop := 3
@export var exp_orb_scene : PackedScene

var hp : int = 10
var mov_speed = 100

@onready var anim: AnimatedSprite2D = $Sprite
var player : Player


func _ready():
	add_to_group("enemy")
	player = get_tree().get_first_node_in_group("player")
	exp_drop = 5


func _physics_process(_delta):

	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	var direction = global_position.direction_to(player.global_position)

	velocity = direction * mov_speed
	move_and_slide()

	anim.play("walk")

	if direction.x != 0:
		anim.flip_h = direction.x > 0


func _on_hurt_box_received_damage(damage):

	hp -= damage

	if hp <= 0:
		die()


func die():

	drop_exp()
	queue_free()


func drop_exp():

	if exp_orb_scene == null:
		print("NO EXP ORB SCENE")
		return

	for i in exp_drop:

		var orb = exp_orb_scene.instantiate()
		get_tree().current_scene.add_child(orb)

		orb.global_position = global_position + Vector2(
			randf_range(-20, 20),
			randf_range(-20, 20)
		)
