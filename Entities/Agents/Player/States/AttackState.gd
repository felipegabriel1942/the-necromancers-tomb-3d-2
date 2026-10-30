extends PlayerState

@export var attack_animation_name := ""
@export var impulse := 5
@export var queued_attack_time := 0.5
@export var next_attack: PlayerState

var queued_attack := false

func _enter() -> void:
	queued_attack = false
	printt("AttackState", queued_attack)
	agent.weapon.attack_component.collider_hit.connect(set_attack_direction)
	#agent.impulse_component.add_impulse(agent.player_root.global_basis.z * impulse)
	agent.weapon.attack_component.reset_exceptions()
	agent.animation_tree.change_immediate(attack_animation_name)
	agent.animation_tree.animation_finished.connect(finish_attack, CONNECT_ONE_SHOT)
	var timer = get_tree().create_timer(queued_attack_time)
	timer.timeout.connect(attempt_queue_attack)

func _update(delta: float) -> void:
	if agent.impulse_component.is_active():
		agent.velocity = agent.impulse_component.magnitude
		
	agent.weapon.attack_component.deal_damage(
		agent.stats_component, 
		agent.player_root.global_basis.z * agent.weapon.knockback)
	
	#agent.move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("block"):
		get_root().dispatch(block.name)
	
	if event.is_action_pressed("melee_attack"):
		queued_attack = true

func finish_attack(_animation_name: String) -> void:
	dispatch(EVENT_FINISHED)

func attempt_queue_attack() -> void:
	if next_attack and queued_attack:
		dispatch(next_attack.name)

func set_attack_direction(collider) -> void:
	if not is_instance_valid(collider):
		return
		
	var direction = collider.global_position - agent.player_root.global_position
	
	direction.y = 0.0
	
	if direction.length_squared() == 0.0:
		return
		
	direction = direction.normalized()
	
	agent.player_root.look_at(
		agent.player_root.global_position - direction,
		Vector3.UP
	)
	
	if agent.weapon.attack_component.collider_hit.is_connected(set_attack_direction):
		agent.weapon.attack_component.collider_hit.disconnect(set_attack_direction)

func _exit() -> void:
	agent.weapon_root.set_trail_lenght(0)
	agent.weapon_root.set_collision(false)
		
	if agent.weapon.attack_component.collider_hit.is_connected(set_attack_direction):
		agent.weapon.attack_component.collider_hit.disconnect(set_attack_direction)
	
	if agent.animation_tree.animation_finished.is_connected(finish_attack):
		agent.animation_tree.animation_finished.disconnect(finish_attack)
