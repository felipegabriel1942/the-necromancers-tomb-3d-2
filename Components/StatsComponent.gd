extends Node
class_name StatsComponent

signal stats_changed()

const BASE_LEVEL_XP: float = 100.0

var experience: int = 0
var level: int = 1
var experience_to_next_lvl: int = BASE_LEVEL_XP

@export_group("Base Attributes")
@export var base_max_health: int = 10
@export var base_attack: int = 2
@export var base_defense: int = 0

@export_group("Growth by Level")
@export var health_per_level: int = 4
@export var attack_per_level: int = 1
@export var defense_per_level: int = 1

@export_group("Equipment")
@export var shield: Shield
@export var weapon: Weapon

var max_health: int:
	get:
		return base_max_health + (level - 1) * health_per_level

var attack: int:
	get:
		var bonus_attack = 0
		
		if weapon:
			bonus_attack = weapon.damage
		
		return base_attack + (level - 1) * attack_per_level + bonus_attack

var defense: int:
	get:
		var bonus_defense = 0
		
		if shield:
			bonus_defense = shield.defense

		return (level - 1) + bonus_defense * defense_per_level + base_defense 

func calculate_damage_against(target: StatsComponent) -> int:
	var base_damage := maxi(1, attack - target.defense)
	
	var variation := randf_range(0.85, 1.15)
	var damage := int(floor(base_damage * variation))
	
	return maxi(1, damage)

func add_experience(new_experience) -> void:
	experience += new_experience
	
	if experience >= experience_to_next_lvl:
		level += 1
		experience = 0
		experience_to_next_lvl = BASE_LEVEL_XP * level
		recalculate_stats()
		
		print("Level: {level} | HP: {max_health} | Attack: {attack} | Defense: {defense}".format({
			"level": level,
			"max_health": max_health,
			"attack": attack,
			"defense": defense
		}))
		
		VfxManager.spawn_level_up(get_parent(), level)
		
		
	stats_changed.emit()

func recalculate_stats() -> void:
	base_attack += attack_per_level
	base_defense += defense_per_level
	base_max_health += health_per_level
