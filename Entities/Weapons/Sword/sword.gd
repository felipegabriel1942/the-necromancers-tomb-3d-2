extends Node3D
class_name Sword

@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var attack_component: AttackComponent = $AttackComponent
@onready var attack_audio: AudioStreamPlayer3D = $AttackAudio
@onready var trail: GPUTrail3D = $Trail

@export var collision_enabled: bool = false:
	set(value):
		if value and not attack_audio.playing:
			attack_audio.play()
			
		collision_enabled = value
		shape_cast_3d.enabled = collision_enabled

func set_trail_lenght(value: int) -> void:
	trail.length = value
