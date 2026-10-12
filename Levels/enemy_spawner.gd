extends Node3D

@export var enemies_scenes: Array[PackedScene]

var spawn_positions: Array[Marker3D]

func _ready() -> void:
	for child in get_children():
		if child is Marker3D:
			spawn_positions.append(child)

func _on_spawn_timer_timeout() -> void:
	var enemy_scene = enemies_scenes.pick_random()
	var enemy = enemy_scene.instantiate()
	var spawn_position = spawn_positions.pick_random()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position.global_position
