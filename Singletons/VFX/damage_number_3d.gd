extends Node3D

@onready var label: Label3D = $Label3D

var target_position := Vector3.ZERO

func set_damage_text(amount: float, position_in: Vector3, color: Color) -> void:
	if not is_inside_tree():
		await ready
	
	label.text = "%.0f" % amount
	global_position = position_in
	label.modulate = color
