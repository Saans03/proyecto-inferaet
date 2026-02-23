extends CanvasLayer

@onready var player = $Player   

func setup(p: Player):
	player = p
	update_buttons()
	get_tree().paused = true
	visible = true

func update_buttons():

	var w = player.weapons
	
	if w.has("nudillo"):
		var nud = w["nudillo"]
		$Panel/ButtonNudillo.text = "Nudillo Lv." + str(nud.level)
		$Panel/ButtonNudillo.disabled = nud.level >= nud.max_level
	else:
		$Panel/ButtonNudillo.text = "Desbloquear Nudillo"
	
	if w.has("lanza"):
		var lan = w["lanza"]
		$Panel/ButtonLanza.text = "Lanza Lv." + str(lan.level)
		$Panel/ButtonLanza.disabled = lan.level >= lan.max_level
	else:
		$Panel/ButtonLanza.text = "Desbloquear Lanza"
	
	if w.has("aura"):
		var au = w["aura"]
		$Panel/ButtonAura.text = "Aura Lv." + str(au.level)
		$Panel/ButtonAura.disabled = au.level >= au.max_level
	else:
		$Panel/ButtonAura.text = "Desbloquear Aura"


func _on_button_nudillo_pressed() -> void:
	if player.weapons.has("nudillo"):
		player.level_up_weapon("nudillo")
	else:
		player.add_weapon("nudillo")

	close_ui()

func _on_button_lanza_pressed() -> void:
	if player.weapons.has("lanza"):
		player.level_up_weapon("lanza")
	else:
		player.add_weapon("lanza")

	close_ui()

func _on_button_aura_pressed() -> void:
	if player.weapons.has("aura"):
		player.level_up_weapon("aura")
	else:
		player.add_weapon("aura")

	close_ui()


func close_ui():
	get_tree().paused = false
	visible = false
