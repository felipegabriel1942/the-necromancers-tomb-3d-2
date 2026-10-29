extends Node3D

@onready var label_3d: Label3D = $Label3D

func set_level(new_level: int, agent: Node3D) -> void:
	label_3d.text = "Level Up! Nível %d!" % new_level
	global_position = agent.global_position
