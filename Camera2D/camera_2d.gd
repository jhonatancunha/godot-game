extends Camera2D


func _auto_set_limits():
	var tilemaps = get_tree().get_nodes_in_group("tilemap")
	
	for tilemap in tilemaps:
		if tilemap is TileMap:
			var used = tilemap.get_used_rect()
			
			limit_left = used.position.x * tilemap.tile_set.tile_size.x
			limit_right = used.end.x * tilemap.tile_set.tile_size.x
			limit_bottom = used.end.y * tilemap.tile_set.tile_size.y
			



func _ready() -> void:
	_auto_set_limits()
