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
	
	if agent.navigation_agent_3d.is_target_reached() or agent.player_in_attack_range:
		agent.animation_tree.blend_target = -1.0
		return SUCCESS

	agent.navigation_agent_3d.target_position = target.global_position
	var destination = agent.navigation_agent_3d.get_next_path_position()
	var local_destination = destination - agent.global_position
	var direction = local_destination.normalized()

	agent.core_movement(direction)
	agent.look_at_target(target.global_position)
	agent.move_and_slide()
	
	return RUNNING
	
func distance_to_target(target: Node3D) -> float:
	return agent.global_position.distance_to(target.global_position)
