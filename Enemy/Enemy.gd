class_name Enemy
extends CharacterBody2D


@export var speed: float = 100.0
@export var health: int = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_moving_left: bool = true

# knockback amount when get damage
var knockback_distance = 40

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
		
		
func take_damage():
	health -= 1
	
	if health <= 0:
		queue_free()
	else:
		if is_moving_left:
			position.x += knockback_distance
		else:
			position.x -= knockback_distance

func _on_Player_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not body.is_attacking:
		body.take_damage()
