class_name Portal
extends Node2D

@export var targetLevel: int = -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if(targetLevel == -1):
			GameController.go_next_level()
		else:
			GameController.go_to_level(targetLevel)
		print("GameController.get_current_level()", GameController.get_current_level())
		get_tree().change_scene_to_file(GameController.get_current_level())
