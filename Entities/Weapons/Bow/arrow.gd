extends ShapeCast3D

@export var speed: int = 20
@export var damage: int = 10

@onready var trail: GPUTrail3D = $GPUTrail3D
@onready var attack_component: AttackComponent = $AttackComponent

var direction := Vector3.FORWARD
var fly := false
var character_stats: StatsComponent

func _process(delta: float) -> void:
	if fly:
		global_position += direction * speed * delta

func _physics_process(delta: float) -> void:
	if character_stats:
		attack_component.deal_damage(character_stats, Vector3.FORWARD)
	
	if is_colliding():
		queue_free()
