@tool
extends BTAction

@export var target_var: StringName = &"target"

func _generate_name() -> String:
	return "Pursue %s" % [LimboUtility.decorate_var(target_var)]

func _enter() -> void:
	agent.animation_tree.change_immediate("WalkSpace")
	agent.animation_tree.blend_target = 1.0
	
func _tick(delta: float) -> Status:
	var target: Node3D = blackboard.get_var(target_var)
	
	if not is_instance_valid(target):
		return FAILURE
	
	if agent.attack_slot == null:
		return FAILURE
	
	if agent.navigation_agent_3d.is_navigation_finished() or agent.player_in_attack_range:
		agent.animation_tree.blend_target = -1.0
		agent.velocity = Vector3.ZERO
		agent.look_at_target(target.global_position)
		agent.navigation_agent_3d.set_velocity(Vector3.ZERO)
		return SUCCESS
	
	var next_path_position: Vector3 = agent.navigation_agent_3d.get_next_path_position()
	var new_velocity: Vector3 = agent.global_position.direction_to(next_path_position) * agent.speed
	
	agent.navigation_agent_3d.set_velocity(new_velocity)
	agent.look_at_target(target.global_position)
	
	return RUNNING
	
func distance_to_target(target: Node3D) -> float:
	return agent.global_position.distance_to(target.global_position)
