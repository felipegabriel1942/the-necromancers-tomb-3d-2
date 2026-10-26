extends Node3D

@onready var number_label: Label3D = $NumberLabel
@onready var text_label: Label3D = $TextLabel

var target_position := Vector3.ZERO

func set_damage_text(amount: float, position_in: Vector3, color: Color, text: String = "") -> void:
	if not is_inside_tree():
		await ready
	
	number_label.text = "%.0f" % amount
	global_position = position_in
	text_label.text = text
	number_label.modulate = color
