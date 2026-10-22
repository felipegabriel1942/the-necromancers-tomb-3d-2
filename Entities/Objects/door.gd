extends Interactable

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var closed: bool = true

func interact() -> void:
	if closed:
		print("ola")
		animation_player.play("Open")
		closed = false
	else:
		print("olas")
		animation_player.play("Close")
		closed = true
