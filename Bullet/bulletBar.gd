class_name BulletValue
extends Label

@export var player: Player

func _ready():
	text = str(player.bullets)
	player.bulletChanged.connect(update)
	update()

	

func update():
	text = str(player.bullets)
