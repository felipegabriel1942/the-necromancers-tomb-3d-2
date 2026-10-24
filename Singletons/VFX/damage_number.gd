extends Node3D
class_name DamageNumber

@onready var label: Label3D = $Label

var target_position := Vector3.ZERO

func set_damage_text(amount: float, position_in: Vector3) -> void:
	if not is_inside_tree():
		await ready
	
	label.text = "%.0f" % amount
	global_position = position_in


#func _physics_process(delta: float) -> void:
	#var camera = get_viewport().get_camera_3d()
	#
	#if not camera:
		#return 
	#
	#position = camera.unproject_position(target_position)
