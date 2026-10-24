extends Weapon
class_name MeleeWeapon

@export var knockback := 5.0

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var attack_component: AttackComponent = $AttackComponent
@onready var attack_audio: AudioStreamPlayer3D = $AttackAudio
@onready var gpu_trail_3d: GPUTrail3D = $GPUTrail3D

@export var collision_enabled: bool = false:
	set(value):
		if value and not attack_audio.playing:
			attack_audio.play()
			
		collision_enabled = value
		shape_cast_3d.enabled = collision_enabled

func set_trail_lenght(value: int) -> void:
	gpu_trail_3d.length = value
