extends Node2D

var opened = false
var options = ['heatlh', 'bullets', 'heatlh', 'bullets']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage_area"):
		if not opened:
			opened = true
			var chosen_option = options[randi_range(0, 3)]
			$Sounds/PowerUp.play()
			if chosen_option == 'heatlh':
				area.get_parent().increase_health()
			elif chosen_option == 'bullets':
				area.get_parent().increase_bullets()
			queue_free()
