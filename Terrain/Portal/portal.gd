class_name Portal
extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameController.go_next_level()
		get_tree().change_scene_to_file(GameController.get_current_level())
