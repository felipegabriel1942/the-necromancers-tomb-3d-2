extends Interactable

@export var locked: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var closed: bool = true
var can_interact = true

func interact() -> void:
	if not can_interact or locked:
		#if locked:
			#locked_sound.play()
		return
		
	can_interact = false
	
	if closed:
		animation_player.play("Open")
		closed = false
	else:
		animation_player.play("Close")
		closed = true
