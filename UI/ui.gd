extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu
@onready var status_screen: StatusScreen = $StatusScreen

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.hide()
	status_screen.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_game"):
		toggle_pause()
		get_viewport().set_input_as_handled()
		
	if event.is_action_pressed("open_char_stats"):
		get_tree().paused = !get_tree().paused
		status_screen.visible = !status_screen.visible
		get_viewport().set_input_as_handled()
		
func toggle_pause() -> void:
	var is_paused := not get_tree().paused
	
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	
	if is_paused:
		pause_menu.open_menu()
