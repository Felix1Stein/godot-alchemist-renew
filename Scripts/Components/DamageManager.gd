extends Node
class_name DamageManager

var damage_data : DamageData


# On area entered
func _on_area_entered(area : Object) -> void:
	print("DAMAGE AREA ENTERED " + str(area))
	if area is HealthManager:
		var health_manager : HealthManager = area as HealthManager
		health_manager.attack(self)
