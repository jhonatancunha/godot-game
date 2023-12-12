class_name GameOver
extends Node2D


func _ready() -> void:
	if not OS.has_feature("mobile"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_try_again_pressed() -> void:
	GameController.reset_play_again()
	get_tree().change_scene_to_file(GameController.restart_game_over())


func _on_quit_pressed() -> void:
	GameController.reset_play_again()
	get_tree().change_scene_to_file("res://main.tscn")
