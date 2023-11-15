@tool
class_name PlatformTweenInit
extends Node2D

@onready var platform: PlatformTween = $Block

@export var closed: bool = true

var path: Array[Vector2]
var speed: float = 300

func _ready() -> void:
	for marker in $Path.get_children():
		path.append(marker.global_position)

	if closed:
		path.append(path[0])
	
	if not Engine.is_editor_hint():
		platform.init(path)

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	for i in range(len(path)):
		var _start_pos = path[i]
		var _final_pos
		if (i == len(path)-1):
			_final_pos = path[0]
		else:
			_final_pos = path[i+1]
				
		draw_line(_start_pos - global_position, _final_pos - global_position, Color.BLACK, 2)
