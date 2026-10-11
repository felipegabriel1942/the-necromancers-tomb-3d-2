extends PlayerState

@export var attack_animation_name := ""
@export var impulse := 5
@export var queued_attack_time := 0.5
@export var next_attack: PlayerState

var queued_attack := false

func _enter() -> void:
	print("AttackState")
	agent.impulse_component.add_impulse(agent.player_root.global_basis.z * impulse)
	agent.sword.attack_component.reset_exceptions()
	agent.animation_tree.change_immediate(attack_animation_name)
	agent.animation_tree.animation_finished.connect(finish_attack, CONNECT_ONE_SHOT)
	var timer = get_tree().create_timer(queued_attack_time)
	timer.timeout.connect(attempt_queue_attack)

func _update(delta: float) -> void:
	if agent.impulse_component.is_active():
		agent.velocity = agent.impulse_component.magnitude
		
	agent.sword.attack_component.deal_damage(
		agent.attack, 
		agent.player_root.global_basis.z * agent.sword.knockback)
	
	agent.move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("melee_attack"):
		queued_attack = true

func finish_attack(_animation_name: String) -> void:
	dispatch(EVENT_FINISHED)

func attempt_queue_attack() -> void:
	if next_attack and queued_attack:
		dispatch(next_attack.name)
