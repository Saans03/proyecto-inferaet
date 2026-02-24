extends armaBase
class_name ArmaAjo

@export var damage_interval := 0.2

var _last_range := -1.0


func _ready():
	super._ready()
	
	level = 1
	damage = 5
	range = 100
	cooldown = 0.0

	visible = true

	hitbox.mode = "continuous"
	hitbox.damage = damage
	hitbox.enable_hitbox()

	attack_active = true
	attacking = true

	_update_visuals()
	_last_range = range


func _process(_delta):
	
	
	var player: Player = get_parent()
	if player:
		global_position = player.global_position

	if range != _last_range:
		_update_visuals()
		_last_range = range

func _update_visuals():

	if hitbox and hitbox.collision:
		var shape = hitbox.collision.shape
		if shape is CircleShape2D:
			shape.radius = range *0.8
			
	var sprite: Sprite2D = $Sprite2D
	if sprite and sprite.texture:

		var texture_size = sprite.texture.get_size().x
		var desired_diameter = range * 1.8

		if texture_size > 0:
			var scale_factor = desired_diameter / texture_size
			sprite.scale = Vector2(scale_factor, scale_factor)
			
			
func aplicarStatsNivel():

	damage += 3
	range += 20
	
	hitbox.damage = damage
	_update_visuals()
