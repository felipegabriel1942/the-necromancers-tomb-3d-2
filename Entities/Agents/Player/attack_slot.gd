class_name AttackSlot
extends Node3D

var occupant: Enemy

func is_available() -> bool:
	return occupant == null

func occupy(enemy: Enemy) -> void:
	occupant = enemy

func release() -> void:
	occupant = null
