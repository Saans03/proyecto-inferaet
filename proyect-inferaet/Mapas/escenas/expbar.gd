extends TextureProgressBar

@export var player: Player


func _ready():
	player.exp_changed.connect(update_bar)
	player.level_up.connect(update_bar)
	update_bar()


func update_bar():
	value = player.current_exp * 100 / player.exp_to_next
