extends CharacterBody2D
class_name EnemigoBase

@export var exp_drop := 3
@export var exp_orb_scene : PackedScene

@export var hp : int = 10
@export var mov_speed = 100

@onready var anim: AnimatedSprite2D = $Sprite
var player : Player
var is_dead := false


func _ready():
	EnemyManager.register_enemy(self)
	add_to_group("enemy")
	player = get_tree().get_first_node_in_group("player")
	exp_drop = 5

func _exit_tree():
	EnemyManager.unregister_enemy(self)
	
	
func _physics_process(_delta):
	
	if is_dead:
		return
		
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
	
	is_dead = true

	velocity = Vector2.ZERO
	move_and_slide()

	anim.play("death")

	await get_tree().create_timer(0.5).timeout

	drop_exp()
	queue_free()


func drop_exp():

	if exp_orb_scene == null:
		return

	for i in range(exp_drop):

		var orb = exp_orb_scene.instantiate()
		get_tree().current_scene.add_child(orb)

		orb.global_position = global_position + Vector2(
			randf_range(-20, 20),
			randf_range(-20, 20)
		)
