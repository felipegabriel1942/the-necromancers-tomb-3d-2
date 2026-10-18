extends Node2D
class_name DamageNumber

@onready var label: Label = $Label

var target_position := Vector3.ZERO

func set_damage_text(amount: float) -> void:
	if not is_inside_tree():
		await ready
	label.text = "%.1f" % amount


func _physics_process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	
	if not camera:
		return 
	
	position = camera.unproject_position(target_position)
