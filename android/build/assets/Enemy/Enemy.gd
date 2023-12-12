class_name Enemy
extends CharacterBody2D


@export var speed: float = 100.0
@export var health: int = 6

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

var start_marker: Marker2D
var end_marker: Marker2D
var current_marker: Marker2D
var move_speed: float = 200

var can_idle = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_punching = false
var last_position = Vector2.ZERO
var direction: int = 1

# knockback amount when get damage
var knockback_distance = 60

func _physics_process(delta: float) -> void:
	move_enemy(delta)
	detect_turn_around()
	if is_punching:
		animationPlayer.play("punch")
	else:
		animationPlayer.play("walk")


func move_enemy(delta: float) -> void:
#	update_animation()
	velocity.x = direction * speed
	velocity.y += gravity * delta

	move_and_slide()
	last_position = global_position


func update_animation():
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
	
	if not is_punching:						
		animationPlayer.play("walk")


#func detect_turn_around():
#	if (not $RayCast2D.is_colliding() or $RayCast2D2H.is_colliding()) and is_on_floor():
#		direction = -direction
#		scale.x = -scale.x
#		global_position.x += direction * 40

func detect_turn_around():
	var collision = $RayCast2D2H.is_colliding()
	var colliding_body = $RayCast2D2H.get_collider()

	if collision and colliding_body.is_in_group("IgnoreRaycastGroup") and is_on_floor():		
		return

	if (not $RayCast2D.is_colliding() or $RayCast2D2H.is_colliding()) and is_on_floor():
		direction = -direction
		scale.x = -scale.x
		global_position.x += direction * 40


func take_damage():
	health -= 1
	
	if health <= 0:
		queue_free()
	else:
		position.x += knockback_distance * -direction


func _on_attack_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage_area"):
		area.get_parent().take_damage()
		is_punching = true
		await animationPlayer.animation_finished
		is_punching = false
