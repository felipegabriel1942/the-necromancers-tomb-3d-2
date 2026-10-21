extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
		get_viewport().set_input_as_handled()
		
func toggle_pause() -> void:
	var is_paused := not get_tree().paused
	
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	
	if is_paused:
		pause_menu.open_menu()
