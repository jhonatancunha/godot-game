class_name GameOver
extends Node2D

func _process(delta: float) -> void:
	pass
	


func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
