extends Node

const DAMAGE_NUMBER = preload("uid://mogh3gfalqwi")
const DAMAGE_NUMBER_3D = preload("uid://by63qgstmq66m")

func spawn_damage_number(source: Node3D, damage: float, color: Color) -> void:	
	var damage_number = DAMAGE_NUMBER_3D.instantiate()
	add_child(damage_number)
	damage_number.set_damage_text(damage, source.global_position, color)
