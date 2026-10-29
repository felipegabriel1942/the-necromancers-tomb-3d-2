extends Node

const DAMAGE_NUMBER = preload("uid://mogh3gfalqwi")
const DAMAGE_NUMBER_3D = preload("uid://by63qgstmq66m")
const LEVEL_UP = preload("uid://bx87uw5y7code")

func spawn_damage_number(source: Node3D, damage: float, color: Color, text: String) -> void:
	var damage_number = DAMAGE_NUMBER_3D.instantiate()
	add_child(damage_number)
	damage_number.set_damage_text(damage, source.global_position, color, text)

func spawn_level_up(agent: Node3D, new_level: int) -> void:
	var level_up = LEVEL_UP.instantiate()
	agent.add_child(level_up)
	level_up.set_level(new_level, agent)
