extends Interactable

@export var locked: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var opening_sound: AudioStreamPlayer3D = $OpeningSound
@onready var closing_sound: AudioStreamPlayer3D = $ClosingSound
@onready var locked_sound: AudioStreamPlayer3D = $LockedSound

var closed: bool = true
var can_interact: bool = true

func interact() -> void:
	if not can_interact or locked:
		if locked:
			locked_sound.play()
		return
		
	can_interact = false
	
	if closed:
		animation_player.play("Open")
		closed = false
	else:
		animation_player.play("Close")
		closed = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	can_interact = true
