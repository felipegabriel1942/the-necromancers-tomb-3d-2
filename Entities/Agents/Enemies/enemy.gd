extends CharacterBody3D
class_name Enemy

@export var speed: float  = 3.0
@export var attack_range: float = 2.0
@export var hit_stop_time: float = 0.05
@export var experience_given: int = 50

@onready var stats_component: StatsComponent = $StatsComponent
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var model_root: Node3D = $ModelRoot
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var path_timer: Timer = $PathTimer
@onready var knockback_component: KnockbackComponent = $KnockbackComponent
@onready var health_component: HealthComponent = $HealthComponent

var player_in_attack_range: bool = false
var attack_slot
var weapon

func _ready() -> void:
	path_timer.timeout.connect(update_path)
	health_component.defeat.connect(give_player_experience)

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
	velocity = Vector3.ZERO
	
	if not player_in_attack_range and not knockback_component.is_active():
		velocity = safe_velocity
	
	if knockback_component.is_active():
		velocity = knockback_component.magnitude
	
	move_and_slide()

func update_path() -> void:
	acquire_attack_slot()
	navigation_agent_3d.set_target_position(attack_slot.global_position)

func _on_health_changed(value: Variant) -> void:
	get_viewport().get_camera_3d().quick_shake(0.2)
	hit_stop(0.1)

func hit_stop(duration: float) -> void:
	Engine.time_scale = 0.0
	await get_tree().create_timer(
		duration,
		true,
		false,
		true
	).timeout
	Engine.time_scale = 1.0

func give_player_experience() -> void:
	player.stats_component.add_experience(experience_given)
