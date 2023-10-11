extends CharacterBody2D


@export var speed: float = 200.0
@export var jump_velocity: float = -300.0
@export var double_jump_velocity: float = -300
@export var can_double_jump: bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var already_did_double_jump: bool = false
var can_idle = true

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D


func update_animation(direction):
	if is_on_floor():
		if can_idle:
			if direction == 0:
				animationPlayer.play("idle")
			else:
				animationPlayer.play("walk")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		already_did_double_jump = false
		

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif not already_did_double_jump and can_double_jump:
			velocity.y = double_jump_velocity
			already_did_double_jump = true
			
	

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		sprite.flip_h = (direction == -1);
		
		
	if Input.is_action_just_pressed("right"):
		$PunchArea2D/Colision.position.x = abs($PunchArea2D/Colision.position.x)
	
	if Input.is_action_just_pressed("left"):
		$PunchArea2D/Colision.position.x = -abs($PunchArea2D/Colision.position.x)
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	if Input.is_action_just_pressed("punch"):
		can_idle = false
		$AnimationPlayer.play("punch")
		await $AnimationPlayer.animation_finished
		can_idle = true

	update_animation(direction)

func _on_punch_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().take_damage()
