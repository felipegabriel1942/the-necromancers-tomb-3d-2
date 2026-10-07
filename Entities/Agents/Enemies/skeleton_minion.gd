extends Enemy

@onready var animation_tree: AnimationTree = $Skeleton_Minion/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var bt_player: BTPlayer = $BTPlayer

func on_defeat() -> void:
	collision_shape_3d.set_deferred("disabled", true)
	animation_tree.change_immediate("Death")
	bt_player.active = false
	
	var tween := create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(queue_free)
