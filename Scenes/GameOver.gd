class_name GameOver
extends Node2D

func _process(delta: float) -> void:
	if not $Sounds/AudioStreamPlayer2D.playing:
		$Sounds/AudioStreamPlayer2D.play()

func _on_button_go_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
