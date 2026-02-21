extends TextureProgressBar

@export var player: Player

func _ready():
	player.health_changed.connect(update)
	update()

func update():
	value = player.stats.current_health * 100 / player.stats.max_health
