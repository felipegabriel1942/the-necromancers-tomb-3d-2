@tool
extends BTAction

@export var target_var: StringName = &"target"

var target: Node3D

func _generate_name() -> String:
	return "FaceTarget " + LimboUtility.decorate_var(target_var)
	
func _enter() -> void:
	target = blackboard.get_var(target_var)
	print(target)
	
func _tick(delta: float) -> Status:
	if not is_instance_valid(target):
		return FAILURE

	var direction = target.global_position - agent.global_position
	direction.y = 0
	
	if direction.length_squared() < 0.001:
		return SUCCESS
	
	var target_rotation = atan2(direction.x, direction.z)
	
	agent.rotation.y = lerp_angle(
		agent.rotation.y,
		target_rotation,
		10.0 * delta
	)
	
	if abs(angle_difference(agent.rotation.y, target_rotation)) < 0.05:
		return SUCCESS
	
	return RUNNING
