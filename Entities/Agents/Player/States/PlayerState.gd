extends LimboState
class_name PlayerState

func core_movement(delta: float, speed: float) -> void:
	var direction = agent.get_movement_direction()
	agent.velocity = direction * speed
	agent.look_toward_direction(direction, delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("melee_attack"):
		dispatch("attack_01")
