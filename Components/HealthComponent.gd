extends Node
class_name HealthComponent

signal health_changed(value)
signal defeat()

@export var hit_audio: AudioStreamPlayer3D
@export var max_health: float = 100.0

var current_health: float
var is_blocking: bool = false

func _ready() -> void:
	current_health = max_health
	
func take_damage(damage_in: float) -> void :
		
	var final_damage := damage_in
	
	if is_blocking:
		final_damage *= 1.0 - 0.7
	
	current_health = maxf(current_health - final_damage, 0.0) 
	
	health_changed.emit(current_health)
	
	print(final_damage)
	
	#VfxManager.spawn_damage_number(get_parent(), final_damage)
	
	if hit_audio: hit_audio.play()
	
	if current_health <= 0.0: defeat.emit()
