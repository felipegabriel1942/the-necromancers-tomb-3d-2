extends Enemy

@onready var animation_tree: AnimationTree = $ModelRoot/Skeleton_Minion/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var bt_player: BTPlayer = $BTPlayer
@onready var weapon_root: WeaponRoot = $ModelRoot/Skeleton_Minion/Rig_Medium/Skeleton3D/WeaponSlot/WeaponRoot

func _ready() -> void:
	weapon = weapon_root.get_child(0)
	if weapon.shape_cast_3d:
		weapon.shape_cast_3d.add_exception(self)
	
	super._ready()

func _on_health_changed(value: Variant) -> void:
	get_viewport().get_camera_3d().quick_shake(0.1)
	hit_stop(hit_stop_time)
	weapon_root.set_collision(false)
	weapon_root.set_trail_lenght(0)
	animation_tree.change_immediate("Hit")
	bt_player.active = false

func on_defeat() -> void:
	collision_shape_3d.set_deferred("disabled", true)
	animation_tree.change_immediate("Death")
	bt_player.active = false
	
	var tween := create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(queue_free)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("Hit"):
		bt_player.restart()
		bt_player.active = true
