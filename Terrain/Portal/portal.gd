class_name Portal
extends Node2D

@export var destinationPath: String = "";




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("dwadwa", body, destinationPath)
		get_tree().change_scene_to_file(destinationPath)
