class_name PlatformTween
extends CharacterBody2D

@export var speed: float = 200

func init(path: Array[Vector2]) -> void:

	var tween: Tween = create_tween()
	tween.set_loops(0)
		
	var last_pos: Vector2 = global_position
	for i in range(len(path)):	
		var next_pos = path[i]
		var distance: float = (next_pos - last_pos).length()
		last_pos = next_pos
		
		tween.tween_property(self, "global_position", next_pos, distance/speed).set_trans(Tween.TRANS_SINE)
		tween.tween_interval(0.3)
