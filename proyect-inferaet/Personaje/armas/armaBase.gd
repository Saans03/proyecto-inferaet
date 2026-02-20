extends Node2D
class_name armaBase

@export var damage := 500
@export var cooldown := 0.8

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox

var attacking := false
var attack_active := false

func _ready():
	visible = false
	hitbox.damage = damage
	hitbox.weapon = self
	hitbox.disable_hitbox()
	attack_loop()

func attack_loop():
	while is_inside_tree():
		if not attacking:
			var target = _find_target()
			if target:
				await _attack(target)
		await get_tree().process_frame

func _attack(target):
	pass

func _find_target():
	return null
