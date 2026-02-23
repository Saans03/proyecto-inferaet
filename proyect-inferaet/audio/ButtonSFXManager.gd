extends Node

var sfx_player: AudioStreamPlayer

func _ready():
	var master_index = AudioServer.get_bus_index("Master")
	if master_index != -1:
		AudioServer.set_bus_volume_db(master_index, -6)

	var sfx_index = AudioServer.get_bus_index("SFX")
	if sfx_index != -1:
		AudioServer.set_bus_volume_db(sfx_index, -65)

	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "SFX"
	sfx_player.stream = preload("res://audio/Button press sound _ Sonido de presionar boton.mp3")
	sfx_player.volume_db = -65  
	add_child(sfx_player)
	get_tree().node_added.connect(_on_node_added)
	_connect_existing_buttons(get_tree().root)

func _connect_existing_buttons(node):
	for child in node.get_children():
		if child is Button:
			if not child.pressed.is_connected(_on_button_pressed):
				child.pressed.connect(_on_button_pressed)
		_connect_existing_buttons(child)

func _on_node_added(node):
	if node is Button:
		if not node.pressed.is_connected(_on_button_pressed):
			node.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if sfx_player.playing:
		sfx_player.stop()
	sfx_player.play()
