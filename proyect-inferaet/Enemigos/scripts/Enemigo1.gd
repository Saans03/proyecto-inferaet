extends CharacterBody2D

var hp : int = 10
var mov_speed = 100

@onready var anim: AnimatedSprite2D = $Sprite
@onready var player = get_tree().get_first_node_in_group("player")
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mov_speed
	move_and_slide()
	anim.play("walk")
	if direction.x != 0:
		anim.flip_h = direction.x>0



func _on_hurt_box_received_damage(damage):
	hp -= damage
	if hp <= 0 :
		queue_free()
		
func _ready():
	add_to_group("enemy")
