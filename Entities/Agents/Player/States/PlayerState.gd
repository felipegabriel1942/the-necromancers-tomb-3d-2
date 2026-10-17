extends LimboState
class_name PlayerState

@export var attack: PlayerState
@export var block: PlayerState

func core_movement(delta: float, speed: float) -> void:
	var direction = agent.get_movement_direction()
	agent.velocity = direction * speed
	agent.look_toward_direction(direction, delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("block"):
		dispatch(block.name)
		
	if event.is_action_released("block"):
		dispatch("Idle")
	
	if event.is_action_pressed("melee_attack"):
		dispatch(attack.name)
		
	#if event.is_action_pressed("cast_fireball"):
		#print(agent.action_slots["1"])
