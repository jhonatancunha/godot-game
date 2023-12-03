class_name DesktopInstruction
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = not OS.has_feature("mobile")
