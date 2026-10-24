extends Node
class_name AttackComponent

@export var attack_shapecast: ShapeCast3D

var temporary_exceptions := []

func deal_damage(attacker_stats: StatsComponent, knockback: Vector3) -> void:
		if not attack_shapecast.enabled:
			return
			
		attack_shapecast.force_shapecast_update()
		
		for index in attack_shapecast.get_collision_count():
			var collider = attack_shapecast.get_collider(index)

			if collider.has_node("HealthComponent"):
				var health_component = collider.get_node("HealthComponent") as HealthComponent
				health_component.take_damage(attacker_stats.calculate_damage_against(collider.get_node("StatsComponent")))
				attack_shapecast.add_exception(collider)
				temporary_exceptions.append(collider)
			
			if collider.has_node("KnockbackComponent"):
				var knockback_component = collider.get_node("KnockbackComponent") as KnockbackComponent
				knockback_component.add_knockback(knockback)

func reset_exceptions() -> void:
	for exception in temporary_exceptions:
		attack_shapecast.remove_exception(exception)
	
	temporary_exceptions = []
