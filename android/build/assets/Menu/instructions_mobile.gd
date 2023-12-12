class_name MobileInstruction
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = OS.has_feature("mobile")
