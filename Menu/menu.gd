class_name Menu
extends Control



func _on_play_pressed() -> void:
	GameController.reset_play_again()
	get_tree().change_scene_to_file("res://Levels/level1.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/instructions.tscn")
