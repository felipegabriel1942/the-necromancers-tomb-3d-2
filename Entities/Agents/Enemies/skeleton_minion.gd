extends Enemy

@onready var animation_tree: AnimationTree = $Skeleton_Minion/AnimationTree

func on_defeat() -> void:
	animation_tree.change_immediate("Death")
