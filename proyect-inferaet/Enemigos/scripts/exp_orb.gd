extends Area2D

@export var exp_value := 1
var player = null


func _ready():
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta):

	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	global_position = global_position.lerp(player.global_position, 6 * delta)

	if global_position.distance_to(player.global_position) < 20:
		collect()


func collect():

	if player != null:
		player.add_exp(exp_value)

	queue_free()
