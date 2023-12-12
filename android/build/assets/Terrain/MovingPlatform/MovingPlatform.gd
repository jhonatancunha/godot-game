class_name MovingPlatform
extends Node2D

@onready var pathFollow: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pathFollow.progress += speed * delta;
