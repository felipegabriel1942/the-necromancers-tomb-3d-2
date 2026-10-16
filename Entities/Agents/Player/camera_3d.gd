extends Camera3D

@export var noise: FastNoiseLite
@export var trauma: float = 0.0
@export var offset_scale: float = 1.0
@export var camera_shake: bool = true

func _physics_process(delta: float) -> void:
	var time = Time.get_ticks_msec()
	h_offset = noise.get_noise_2d(time, 0.0) * trauma * offset_scale
	v_offset = noise.get_noise_2d(0.0, time) * trauma * offset_scale
	
func quick_shake(magnitude: float) -> void:
	if not camera_shake:
		return
		
	var tween = create_tween()
	tween.tween_property(self, "trauma", 0.0, 0.5).from(magnitude)
