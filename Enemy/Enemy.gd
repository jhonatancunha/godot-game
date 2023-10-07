class_name Enemy
extends CharacterBody2D


@export var speed: float = 300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_moving_left: bool = true



func _process(delta: float) -> void:
	move_enemy(delta)
	detect_turn_around()

func move_enemy(delta: float) -> void:
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity* delta

	move_and_slide()


func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
