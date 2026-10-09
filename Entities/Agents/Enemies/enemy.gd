extends CharacterBody3D
class_name Enemy

@export var speed: float  = 3.0
@export var attack_range: float = 2.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var model_root: Node3D = $ModelRoot

var player_in_attack_range: bool = false

func on_defeat() -> void:
	pass # Replace with function body.

func core_movement(direction: Vector3) -> void:
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)

func look_at_target(target: Vector3) -> void:
	target.y = model_root.global_position.y
	model_root.look_at(target, Vector3.UP, true)

func _on_attack_area_player_entered() -> void:
	player_in_attack_range = true

func _on_attack_area_player_exit() -> void:
	player_in_attack_range = false
