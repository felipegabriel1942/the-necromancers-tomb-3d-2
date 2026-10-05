extends PlayerState

func _enter() -> void:
	agent.animation_tree.blend_target = -1.0
	print("IdleState")

func _update(delta: float) -> void:
	var input = agent.get_movement_direction() as Vector3
	
	if not input.is_zero_approx():
		dispatch("run")
