extends Area2D

@export var speed := 450
@export var damage := 25
@export var lifetime := 3

var direction := Vector2.ZERO

func _ready():
	
	var hitbox = get_node_or_null("HitBox")
	
	if hitbox != null:
		hitbox.damage = damage
	else:
		push_error("HitBox no encontrada en BossBubble")

	await get_tree().create_timer(lifetime).timeout
	queue_free()


func set_direction(dir: Vector2):
	direction = dir.normalized()
	rotation = direction.angle()


func _physics_process(delta):
	position += direction * speed * delta
