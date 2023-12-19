class_name ShooterEnemy
extends CharacterBody2D

signal bulletChanged

@export var maxHealth: int = 6
@export var facing_right: bool = false
@export var bullet_speed: float = 400
@export var fire_delay: float = 1.5

@onready var _bullet_res: Resource = preload("res://Bullet/bullet.tscn")

var shooting_area: Area2D
var sprite: Sprite2D
var animation_player: AnimationPlayer
var player_in_range: bool = false
var health: int = maxHealth
var _can_fire: bool = true

func _ready():
	shooting_area = $Area2D
	sprite = $Sprite2D
	animation_player = $AnimationPlayer


func _physics_process(delta):
	# Verificar se o jogador está na área de detecção
	if player_in_range:
		# Se sim, atirar (executar animação "shoot")
		
		if _can_fire:
			animation_player.play("idle_shot")
			sprite.flip_h = not facing_right
			_fire_bullet(sprite.flip_h)
		
		if not facing_right:
			$Marker2D.scale.x = abs($Marker2D.scale.x)
		else:
			$Marker2D.scale.x = -abs($Marker2D.scale.x)
	else:
		# Se não, ficar parado (executar animação "idle")
		animation_player.play("idle")
		sprite.flip_h = not facing_right
		if not facing_right:
			$Marker2D.scale.x = abs($Marker2D.scale.x)
		else:
			$Marker2D.scale.x = -abs($Marker2D.scale.x)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage_area"):
		print("entrou")
		player_in_range = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("damage_area"):
		print("SAIU")
		player_in_range = false	


func take_damage():
	health -= 1
	print(health)
	if health <= 0:
		queue_free()


func _fire_bullet(dir):
	bulletChanged.emit()
	
	var bullet: Sprite2D = _bullet_res.instantiate()
	bullet.init(dir, bullet_speed)
	bullet.position = $Marker2D.global_position
	get_tree().get_root().add_child(bullet)


	_can_fire = false
	if not $Sounds/ShotSound.playing:
			$Sounds/ShotSound.play()
	await get_tree().create_timer(fire_delay).timeout
	_can_fire = true

