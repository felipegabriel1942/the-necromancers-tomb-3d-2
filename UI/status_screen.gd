extends Control
class_name StatusScreen

@onready var attack_num: Label = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/CombatAttributesContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/Label2
@onready var defense_num: Label = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/CombatAttributesContainer/MarginContainer/VBoxContainer/HBoxContainer3/PanelContainer/MarginContainer/Label2
@onready var next_level_exp: Label = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/ExperienceContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/NextLevelExpLabel
@onready var level_label: Label = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/LevelContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/LevelLabel
@onready var health_bar: ProgressBar = $CenterContainer/PanelContainer/MarginContainer/HBoxContainer/StatsContainer/MarginContainer/VBoxContainer/VitalsContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ProgressBar

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.health_component.health_changed.connect(update_health)
	call_deferred("set_data")

func set_data() -> void:
	attack_num.text = str(player.stats_component.attack)
	defense_num.text = str(player.stats_component.defense)
	health_bar.value = player.health_component.current_health / player.stats_component.max_health * 100
	level_label.text = str(player.stats_component.level)
	
func update_health(new_health: int) -> void:
	health_bar.value = player.health_component.current_health / player.stats_component.max_health * 100
