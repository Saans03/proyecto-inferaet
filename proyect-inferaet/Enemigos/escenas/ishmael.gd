extends EnemigoBase

@export var bubble_scene : PackedScene
@export var spear_scene : PackedScene

var phase_two := false
var max_hp := 7000

@onready var bubble_timer = $TimerBurbujas
@onready var spear_timer = $TimerLanzas


func _ready():
	super._ready()
	
	hp = max_hp
	mov_speed = 50
	exp_drop = 20
	
	bubble_timer.timeout.connect(_on_timer_burbujas_timeout)
	spear_timer.timeout.connect(_on_timer_lanzas_timeout)

func _physics_process(delta):
	super._physics_process(delta)
	
	if is_dead:
		return
	
	if phase_two:
		if anim.animation != "walk2":
			anim.play("walk2")
	else:
		if anim.animation != "walk":
			anim.play("walk")

func _on_hurt_box_received_damage(damage):

	super._on_hurt_box_received_damage(damage)
	if hp <= max_hp / 2 and not phase_two:
		activate_phase_two()

func activate_phase_two():
	phase_two = true
	anim.play("walk2")  
	
	mov_speed *= 1.6
	bubble_timer.wait_time = 0.6
	spear_timer.start()

func _on_timer_burbujas_timeout():
	if player == null or bubble_scene == null:
		return

	if phase_two:
		shoot_circle()
	else:
		shoot_basic()

func shoot_basic():
	var bubble = bubble_scene.instantiate()
	get_tree().current_scene.add_child(bubble)
	
	bubble.global_position = global_position
	
	var dir = global_position.direction_to(player.global_position)
	bubble.set_direction(dir)

func shoot_circle():
	var amount := 8

	for i in amount:

		var bubble = bubble_scene.instantiate()
		get_tree().current_scene.add_child(bubble)
		
		bubble.global_position = global_position
		
		var angle = i * (TAU / amount)
		var dir = Vector2(cos(angle), sin(angle))
		
		bubble.set_direction(dir)

func _on_timer_lanzas_timeout():
	if player == null or spear_scene == null:
		return

	for i in 4:
		spawn_spear_from_screen()

func spawn_spear_from_screen():
	var spear = spear_scene.instantiate()
	get_tree().current_scene.add_child(spear)

	var camera = get_viewport().get_camera_2d()
	var rect = get_viewport_rect()

	var half_w = rect.size.x / 2
	var half_h = rect.size.y / 2

	var side = randi() % 4
	var spawn_pos := Vector2.ZERO

	match side:
		0:
			spawn_pos.x = camera.global_position.x - half_w - 50
			spawn_pos.y = randf_range(camera.global_position.y - half_h, camera.global_position.y + half_h)

		1:
			spawn_pos.x = camera.global_position.x + half_w + 50
			spawn_pos.y = randf_range(camera.global_position.y - half_h, camera.global_position.y + half_h)

		2:
			spawn_pos.y = camera.global_position.y - half_h - 50
			spawn_pos.x = randf_range(camera.global_position.x - half_w, camera.global_position.x + half_w)

		3:
			spawn_pos.y = camera.global_position.y + half_h + 50
			spawn_pos.x = randf_range(camera.global_position.x - half_w, camera.global_position.x + half_w)

	spear.global_position = spawn_pos

	var dir = spawn_pos.direction_to(player.global_position)
	spear.set_direction(dir)
