extends PlayerState

@export var attack_animation_name := ""

func _enter() -> void:
	print("AttackState")
	agent.sword.attack_component.reset_exceptions()
	agent.animation_tree.change_immediate(attack_animation_name)
	agent.animation_tree.animation_finished.connect(finish_attack, CONNECT_ONE_SHOT)

func _update(delta: float) -> void:
	agent.sword.attack_component.deal_damage(agent.attack, Vector3.FORWARD)

func finish_attack(_animation_name: String) -> void:
	dispatch(EVENT_FINISHED)
