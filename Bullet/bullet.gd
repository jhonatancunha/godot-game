class_name Bullet
extends Sprite2D


@export var damage: float = 1	
@export var not_target: String = "player"
@export var bullet_speed = 600

var direction = true


func init(dir, _bullet_speed):
	bullet_speed = _bullet_speed
	direction = dir

func _ready():
	#scale = Vector2(0.1, 0.1)
	pass

func _physics_process(delta: float) -> void:
	
	if direction:
		position.x -= bullet_speed * delta
	else:
		position.x += bullet_speed * delta



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


# detecta os cenarios
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group(not_target):
		queue_free()


# detecta os inimigos
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().take_damage()
		queue_free()
