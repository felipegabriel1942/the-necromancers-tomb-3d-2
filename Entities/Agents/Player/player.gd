extends CharacterBody3D
class_name Player

signal moved()

@export var decay := 12.0
@export var movement_speed := 8.0
@export var attack := 30
@export var action_slots: Dictionary[String, PackedScene] = {
	"1": null,
	"2": null,
	"3": null,
	"4": null
}

@onready var player_root: Node3D = $PlayerRoot
@onready var animation_tree: AnimationTree = $PlayerRoot/AnimationTree
@onready var camera_3d: Camera3D = $CameraRoot/Camera3D
@onready var health_component: HealthComponent = $HealthComponent

@onready var state_machine: LimboHSM = $StateMachine
@onready var idle: PlayerState = $StateMachine/Idle
@onready var run: PlayerState = $StateMachine/Run
@onready var attack_01: PlayerState = $StateMachine/Attack_01
@onready var attack_02: PlayerState = $StateMachine/Attack_02
@onready var attack_03: PlayerState = $StateMachine/Attack_03
@onready var block: PlayerState = $StateMachine/Block

@onready var weapon_root: WeaponRoot = $PlayerRoot/Rig_Medium/Skeleton3D/WeaponSlot/WeaponRoot
@onready var attack_slots: Node3D = $PlayerRoot/AttackSlots
@onready var impulse_component: ImpulseComponent = $ImpulseComponent

var weapon: Node3D

func _ready() -> void:
	weapon = weapon_root.get_child(0)
	state_machine.add_transition(idle, run, run.name)
	state_machine.add_transition(run, idle, idle.name)
	state_machine.add_transition(idle, attack_01, attack_01.name)
	state_machine.add_transition(run, attack_01, attack_01.name)
	state_machine.add_transition(attack_01, idle, attack_01.EVENT_FINISHED)
	state_machine.add_transition(attack_01, attack_02, attack_02.name)
	state_machine.add_transition(attack_02, idle, attack_02.EVENT_FINISHED)
	state_machine.add_transition(attack_02, attack_03, attack_03.name)
	state_machine.add_transition(attack_03, idle, attack_03.EVENT_FINISHED)
	state_machine.add_transition(idle, block, block.name)
	state_machine.add_transition(block, idle, idle.name)
	state_machine.add_transition(run, block, block.name)
	state_machine.add_transition(attack_01, block, block.name)
	
	state_machine.initial_state = idle
	state_machine.initialize(self)
	state_machine.set_active(true)

func get_movement_direction() -> Vector3:
	var input = Vector3.ZERO
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	input = Vector3(input_vector.x, 0.0, input_vector.y)
	var camera = get_viewport().get_camera_3d()
	var camera_rotation = camera.global_rotation.y
	input = input.rotated(Vector3.UP, camera_rotation)
	return input.normalized()

func look_toward_direction(direction: Vector3, delta: float) -> void:
	if direction.is_zero_approx():
		return
	
	var target = player_root.global_transform
	target = target.looking_at(player_root.global_position + direction, Vector3.UP, true)
	player_root.global_transform = player_root.global_transform.interpolate_with(target, 
		1.0 - exp(-decay * delta)
	)

func _on_health_changed(value: Variant) -> void:
	get_viewport().get_camera_3d().quick_shake(0.75)
