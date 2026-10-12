extends Node3D
class_name WeaponRoot

@export var weapon_scene: PackedScene

func _ready() -> void:
	var weapon = weapon_scene.instantiate()
	add_child(weapon)
