extends Node
class_name HealthComponent

signal health_changed(value)
signal defeat()

@export var hit_audio: AudioStreamPlayer3D
@export var stats_component: StatsComponent
@export var damage_number_color: Color = Color.WHITE

var current_health: float
var is_blocking: bool = false

func _ready() -> void:
	call_deferred("setup")

func setup() -> void:
	current_health = stats_component.max_health

func take_damage(damage_in: float) -> void :
		
	var final_damage := damage_in
		
	if is_blocking and stats_component.shield:
		var reduction: float = stats_component.shield.block_damage_redution
		final_damage *= 1.0 - clampf(reduction, 0.0, 1.0)
	
	current_health = maxf(current_health - final_damage, 0.0) 
	
	health_changed.emit(current_health)
		
	VfxManager.spawn_damage_number(
		get_parent(), 
		final_damage, 
		damage_number_color,
		"Blocked" if is_blocking else ""
	)
	
	if hit_audio: hit_audio.play()
	
	if current_health <= 0.0: defeat.emit()
