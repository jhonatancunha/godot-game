class_name ButtonGoToMenu
extends Button



func _on_pressed() -> void:
	_go_to_menu()

func _go_to_menu() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	


func _on_button_down() -> void:
	_go_to_menu()
