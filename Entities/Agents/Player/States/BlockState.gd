extends PlayerState

func _enter() -> void:
	print("BlockState")
	agent.health_component.is_blocking = true
	agent.animation_tree.change_immediate("Block")

func _exit() -> void:
	agent.health_component.is_blocking = false
	agent.animation_tree.change_immediate("WalkSpace")
