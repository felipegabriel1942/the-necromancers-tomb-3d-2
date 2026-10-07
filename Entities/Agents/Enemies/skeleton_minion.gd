extends Enemy

@onready var animation_tree: AnimationTree = $ModelRoot/Skeleton_Minion/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var bt_player: BTPlayer = $BTPlayer
@onready var skeleton_blade: Node3D = $ModelRoot/Skeleton_Minion/Rig_Medium/Skeleton3D/WeaponSlot/WeaponRoot/SkeletonBlade

func _ready() -> void:
	if skeleton_blade.shape_cast_3d:
		skeleton_blade.shape_cast_3d.add_exception(self)

func on_defeat() -> void:
	collision_shape_3d.set_deferred("disabled", true)
	animation_tree.change_immediate("Death")
	bt_player.active = false
	
	var tween := create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(queue_free)
