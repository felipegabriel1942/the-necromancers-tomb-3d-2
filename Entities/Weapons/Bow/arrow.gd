extends ShapeCast3D

@export var speed: int = 20
@export var damage: int = 10

@onready var trail: GPUTrail3D = $GPUTrail3D

var direction := Vector3.FORWARD
var fly := false

func _process(delta: float) -> void:
	if fly:
		global_position += direction * speed * delta

func _physics_process(delta: float) -> void:
	if is_colliding():
		queue_free()
