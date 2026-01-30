extends Label

var dots := 0
var timer := 0.0
const SPEED := 0.5 

func _ready():
	text = "Cargando"

func _process(delta):
	timer += delta
	if timer >= SPEED:
		dots = (dots + 1) % 4
		text = "Cargando" + ".".repeat(dots)
		timer = 0.0
