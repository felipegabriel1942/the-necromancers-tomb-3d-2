@tool
extends BTAction

@export var target_var: StringName = &"target"
@export var attack_interval: float = 2.0

var target: Node3D
var cooldown_timer: float = 0.0
var attacking: bool = false

func _generate_name() -> String:
	return "AttackTarget " + LimboUtility.decorate_var(target_var)
	
func _enter() -> void:
	target = blackboard.get_var(target_var)
	cooldown_timer = 1.0
	
	if not agent.animation_tree.animation_finished.is_connected(end_attack):
		agent.animation_tree.animation_finished.connect(end_attack)

func _tick(delta: float) -> Status:
	agent.skeleton_blade.attack_component.deal_damage(10, Vector3.FORWARD)
	
	if not agent.player_in_attack_range and not attacking:
		return FAILURE
	
	if attacking:
		return RUNNING
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
		return RUNNING
	
	if agent.player_in_attack_range:
		attack()
		return RUNNING
	
	return SUCCESS

func attack() -> void:
	attacking = true
	agent.look_at_target(target.global_position)
	agent.animation_tree.change_immediate("Attack")

func end_attack(_animation_name: String) -> void:
	attacking = false
	agent.skeleton_blade.attack_component.reset_exceptions()
	cooldown_timer = attack_interval

func distance_to_target(target: Node3D) -> float:
	return agent.global_position.distance_to(target.global_position)
