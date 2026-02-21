extends TextureProgressBar

@export var player: Player
@export var fullscreen_offset: float = 40.0 # cuánto subir en fullscreen

func _ready():
	player.health_changed.connect(update)
	update()
	update_container_position()

func update():
	value = player.stats.current_health * 100.0 / player.stats.max_health

func update_container_position():
	var parent_container = get_parent() as MarginContainer
	if parent_container == null:
		return
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		parent_container.position.y -= fullscreen_offset
	else:
		parent_container.position.y = 0
