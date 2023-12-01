class_name Player
extends CharacterBody2D

signal healthChanged
signal bulletChanged

@export var speed: float = 250.0
@export var jump_velocity: float = -300.0
@export var can_fire: bool = true
@export var can_punch: bool = true
@export var MAX_JUMPS: int = 2
@export var MAX_HELTH: int = 3
@export var INITIAL_BULLETS: int = 5

#FIRE
@export var bullet_speed: float = 400
@export var fire_delay: float = 0.5
var _can_fire: bool = true
@onready var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var _qtd_jumps = 1;
var _can_jump = true;
var can_idle = true
var is_walking = true
var is_attacking: bool = false
var health: int = MAX_HELTH
var is_moving_left: bool = true
var bullets: int = INITIAL_BULLETS

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D


func update_animation(direction):
	if is_on_floor():
		if can_idle:
			if direction == 0:
				is_walking = false
				animationPlayer.play("idle")
			else:
				is_walking = true
				if can_fire:
					animationPlayer.play("walk_gun")
				else:
					animationPlayer.play("walk")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if _qtd_jumps > MAX_JUMPS:
			_can_jump = false
	else:
		_qtd_jumps = 1
		_can_jump = true

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif _qtd_jumps < MAX_JUMPS and _can_jump:
			_qtd_jumps += 1
			velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		sprite.flip_h = (direction == -1);
		
		
	if Input.is_action_just_pressed("right"):
		is_moving_left = false
		$PunchArea2D/Colision.position.x = abs($PunchArea2D/Colision.position.x)
		$Marker2D.position.x = 27
	
	if Input.is_action_just_pressed("left"):
		is_moving_left = true
		$PunchArea2D/Colision.position.x = -abs($PunchArea2D/Colision.position.x)
		$Marker2D.position.x = -27
		
		
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if bullets <= 0:
		can_fire = false
	else:
		can_fire = true

	move_and_slide()
	
	# SOCO
	if Input.is_action_just_pressed("punch") and can_punch:
		is_attacking = true
		can_idle = false
		$AnimationPlayer.play("punch")
		await $AnimationPlayer.animation_finished
		can_idle = true
		is_attacking = false
			

	# TIRO
	if Input.is_action_just_pressed("fire") and can_fire:
		is_attacking = true
		can_idle =  false
		if is_walking:
			$AnimationPlayer.play("shot_gun_run")
		else:
			$AnimationPlayer.play("idle_shot")
			
		_fire_bullet(sprite.flip_h)
		await $AnimationPlayer.animation_finished
		can_idle = true
		is_attacking = false

	update_animation(direction)

func _on_punch_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().take_damage()

func _fire_bullet(dir):
	if not can_fire:
		return
	if not _can_fire:
		return
	
	bullets -= 1
	bulletChanged.emit()
	
	var bullet: Sprite2D = _bullet_res.instantiate()
	bullet.init(dir, bullet_speed)
	bullet.position = $Marker2D.global_position
	get_tree().get_root().add_child(bullet)
	
	_can_fire = false
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true


func die():
	get_tree().reload_current_scene()

func take_damage():
	if not is_attacking:
		health -= 1
		healthChanged.emit()
	if health <= 0:
		die()

func increase_health():
	if health < MAX_HELTH:
		health += 1
		healthChanged.emit()
		
		
