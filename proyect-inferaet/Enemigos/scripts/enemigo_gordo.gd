extends EnemigoBase

func _ready():
	super._ready()
	hp = 1000
	mov_speed = 20
	exp_drop = 300


func handle_flip(direction: Vector2):
	if direction.x != 0:
		anim.flip_h = direction.x < 0
