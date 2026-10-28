extends Node3D

@onready var flash: GPUParticles3D = $Flash
@onready var flare: GPUParticles3D = $Flare
@onready var shockwave: GPUParticles3D = $Shockwave
@onready var sparks: GPUParticles3D = $Sparks

func _ready() -> void:
	flare.emitting = true
	flash.emitting = true
	shockwave.emitting = true
	sparks.emitting = true
