extends PlayerState

func _enter() -> void:
	print("RunState")

func _update(delta: float) -> void:
	var input = agent.get_movement_direction() as Vector3
	
	if input.is_zero_approx():
		dispatch("idle")
	
	core_movement(delta, agent.movement_speed)
	agent.move_and_slide()
