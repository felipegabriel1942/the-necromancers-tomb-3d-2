extends Node3D
class_name Bow

@onready var arrow_origin: Marker3D = $ArrowOrigin

const ARROW = preload("uid://bvhlyvnwsbr8w")

var loaded_arrow

func load_arrow() -> void:
	loaded_arrow = ARROW.instantiate()
	add_child(loaded_arrow)
	loaded_arrow.global_position = arrow_origin.global_position

func shoot_arrow() -> void:
	if loaded_arrow == null:
		return
	
	loaded_arrow.trail.length = 100
	loaded_arrow.direction = arrow_origin.global_basis.z.normalized()
	loaded_arrow.reparent(get_tree().current_scene, true)
	loaded_arrow.fly = true
	loaded_arrow = null
