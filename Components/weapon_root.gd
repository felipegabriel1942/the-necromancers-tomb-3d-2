@tool
extends Node3D
class_name WeaponRoot

@export var weapon_scene: PackedScene
@export var parent_stats: StatsComponent

var weapon: Weapon

func _ready() -> void:
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	parent_stats.weapon = weapon
	weapon.parent_stats = parent_stats

func set_trail_lenght(value: int) -> void:
	weapon.set_trail_lenght(value)

func set_collision(value_in: bool) -> void:
	weapon.collision_enabled = value_in

func load_arrow() -> void:
	if weapon is Bow:
		weapon.load_arrow()
	
func shoot_arrow() -> void:
	if weapon is Bow:
		weapon.shoot_arrow()
