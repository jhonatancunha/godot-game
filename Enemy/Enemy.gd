class_name Enemy
extends CharacterBody2D


@export var speed: float = 100.0
@export var health: int = 6

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

var can_idle = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_moving_left: bool = true
var is_walking = true

# knockback amount when get damage
var knockback_distance = 60

func _process(delta: float) -> void:
	move_enemy(delta)
	detect_turn_around()
	update_animation()

func move_enemy(delta: float) -> void:
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity* delta

	move_and_slide()

func update_animation():
	if is_on_floor():
		if can_idle:
			if not is_walking:
				animationPlayer.play("idle")
			else:
				if is_moving_left:
					sprite.flip_h = 1
				else:
					sprite.flip_h = -1
				animationPlayer.play("walk")

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		update_animation()
		
		
func take_damage():
	health -= 1
	
	if health <= 0:
		queue_free()
	else:
		if is_moving_left:
			position.x += knockback_distance
		else:
			position.x -= knockback_distance



func _on_attack_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage_area"):
		print("TOMOU DANO")
		print(health)
		area.get_parent().take_damage()
		animationPlayer.play("punch")
