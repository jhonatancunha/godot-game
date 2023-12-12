class_name MovingPlatform
extends Node2D

@onready var pathFollow: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 100;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pathFollow.progress += speed * delta;
