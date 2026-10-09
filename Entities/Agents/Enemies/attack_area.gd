extends ShapeCast3D
class_name AttackArea

signal player_entered
signal player_exit

var player_in: bool = false

func _physics_process(delta: float) -> void:
	force_shapecast_update()
	
	var player_detected := false
	
	for i in get_collision_count():
		var collider = get_collider(i)
		
		if collider is Player:
			player_detected = true
			break
	
	if player_detected and player_in:
		return

	player_in = player_detected
	
	if player_in:
		player_entered.emit()
	else:
		player_exit.emit()
