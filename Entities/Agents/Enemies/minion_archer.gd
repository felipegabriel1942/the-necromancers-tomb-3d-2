extends Enemy

@onready var animation_tree: AnimationTree = $ModelRoot/Skeleton_Minion/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var bt_player: BTPlayer = $BTPlayer
@onready var weapon_root: WeaponRoot = $ModelRoot/Skeleton_Minion/Rig_Medium/Skeleton3D/WeaponSlot/WeaponRoot

func _ready() -> void:
	weapon = weapon_root.get_child(0)
	super._ready()

func on_defeat() -> void:
	collision_shape_3d.set_deferred("disabled", true)
	animation_tree.change_immediate("Death")
	bt_player.active = false
	
	var tween := create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(queue_free)
