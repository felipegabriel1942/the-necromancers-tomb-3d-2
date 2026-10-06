extends Node
class_name AttackComponent

@export var attack_shapecast: ShapeCast3D

var temporary_exceptions := []

func deal_damage(damage: float, knockback: Vector3) -> void:
		if not attack_shapecast.enabled:
			return
			
		attack_shapecast.force_shapecast_update()
		
		for index in attack_shapecast.get_collision_count():
			var collider = attack_shapecast.get_collider(index)
			attack_shapecast.add_exception(collider)
			temporary_exceptions.append(collider)
			print(collider)

func reset_exceptions() -> void:
	for exception in temporary_exceptions:
		attack_shapecast.remove_exception(exception)
	
	temporary_exceptions = []
