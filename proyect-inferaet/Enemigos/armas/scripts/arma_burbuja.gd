extends Area2D

@export var speed := 220
@export var damage := 15
@export var lifetime := 6.0

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
