class_name GameOver
extends Node2D




func _on_try_again_pressed() -> void:
	GameController.reset_play_again()
	get_tree().change_scene_to_file(GameController.get_current_level())


func _on_quit_pressed() -> void:
	GameController.reset_play_again()
	get_tree().change_scene_to_file("res://main.tscn")
