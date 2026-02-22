extends Node2D
class_name armaBase

@export var level := 1
@export var damage := 500
@export var cooldown := 0.8
@export var range:=300

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
		var player: Player = get_parent()
		if player == null:
			break 

		if not attacking:
			var target = _find_target()
			if target:
				await _attack(target)

		if get_tree() != null:
			await get_tree().process_frame

func _attack(target):
	pass  # Las armas hijas definen el ataque

func _find_target():
	return null  # Por defecto no hay target
