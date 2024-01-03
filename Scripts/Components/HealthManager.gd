extends Node
class_name HealthManager

@export var faction : UTILS.FACTIONS = UTILS.FACTIONS.ENEMY
var health_data : HealthData


# Executes attack
func attack(damage_manager : DamageManager) -> void:
	health_data.attack(damage_manager.damage_data)
