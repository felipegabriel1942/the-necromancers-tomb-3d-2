extends Control

@onready var resume_button: Button = $CenterContainer/PanelContainer/VBoxContainer/VBoxContainer2/ResumeButton
@onready var restart_button: Button = $CenterContainer/PanelContainer/VBoxContainer/VBoxContainer2/RestartButton
@onready var quit_button: Button = $CenterContainer/PanelContainer/VBoxContainer/VBoxContainer2/QuitButton

func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func open_menu() -> void:
	resume_button.grab_focus()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if restart_button.has_focus():
			restart_button.release_focus()
			
		if quit_button.has_focus():
			quit_button.release_focus()
			
		if resume_button.has_focus():
			resume_button.release_focus()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()
	
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
