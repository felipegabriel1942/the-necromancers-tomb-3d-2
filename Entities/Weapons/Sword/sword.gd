extends Node3D
class_name Sword

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var attack_component: AttackComponent = $AttackComponent

@export var collision_enabled: bool = false:
	set(value):
		collision_enabled = value
		shape_cast_3d.enabled = collision_enabled
