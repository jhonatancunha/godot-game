class_name LevelValue
extends Label


func _physics_process(delta: float) -> void:
	print(GameController.get_play_again_count())
	text = str(GameController.get_play_again_count())
