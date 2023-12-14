class_name LevelValue
extends Label


func _physics_process(delta: float) -> void:
	text = str(GameController.get_play_again_count())
