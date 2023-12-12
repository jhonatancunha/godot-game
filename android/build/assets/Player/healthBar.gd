class_name HealthValue
extends Label

@export var player: Player

func _ready():
	text = str(player.MAX_HELTH)
	player.healthChanged.connect(update)
	update()

	

func update():
	print(player.health)
	text = str(player.health)
