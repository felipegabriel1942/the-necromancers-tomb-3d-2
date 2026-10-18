extends Node

const DAMAGE_NUMBER = preload("uid://mogh3gfalqwi")

func spawn_damage_number(source: Node3D, damage: float) -> void:
	var damage_number: DamageNumber = DAMAGE_NUMBER.instantiate()
	source.add_child(damage_number)
	damage_number.target_position = source.global_position
	damage_number.set_damage_text(damage)
	
	
