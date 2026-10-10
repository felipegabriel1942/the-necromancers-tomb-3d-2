extends CharacterBody3D
class_name Enemy

@export var speed: float  = 3.0
@export var attack_range: float = 2.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var model_root: Node3D = $ModelRoot
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var path_timer: Timer = $PathTimer

var player_in_attack_range: bool = false
var attack_slot

func _ready() -> void:
	path_timer.timeout.connect(update_path)

func on_defeat() -> void:
	pass # Replace with function body.

func look_at_target(target: Vector3) -> void:
	target.y = model_root.global_position.y
	model_root.look_at(target, Vector3.UP, true)

func _on_attack_area_player_entered() -> void:
	player_in_attack_range = true

func _on_attack_area_player_exit() -> void:
	player_in_attack_range = false

func acquire_attack_slot() -> bool:
	var best_slot: AttackSlot
	var best_distance := INF
	
	if attack_slot != null:
		attack_slot.release()

	for slot: AttackSlot in player.attack_slots.get_children():
		if not slot.is_available():
			continue

		var distance := global_position.distance_squared_to(
			slot.global_position
		)

		if distance < best_distance:
			best_distance = distance
			best_slot = slot

	if best_slot == null:
		return false

	best_slot.occupy(self)
	attack_slot = best_slot

	return true

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	if not player_in_attack_range:
		velocity = safe_velocity
	
		move_and_slide()

func update_path() -> void:
	acquire_attack_slot()
	navigation_agent_3d.set_target_position(attack_slot.global_position)
