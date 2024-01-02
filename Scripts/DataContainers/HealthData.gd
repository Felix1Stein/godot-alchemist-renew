extends Resource
class_name HealthData

@export var max_health_points : int = 10
@export var health_points : int = 10


signal health_points_changed(new_health_points : int)
signal died()


# Constructor
func _init(max_health_points : int = 1, health_points : int = 1):
	self.max_health_points = max_health_points
	self.health_points = health_points


# Modifies health data according ot the damage_data ruleset
func attack(damage_data : DamageData) -> void:
	change_health(- damage_data.contact_damage)


# Adds the delta to the health_points and handles potential death 
func change_health(delta : int) -> void:
	health_points = clamp(health_points + delta, 0, max_health_points)
	
	if health_points <= 0:
		handle_death()
	
	health_points_changed.emit(health_points)
	print_health_stats()


# Removes all health_points and triggers death handling
func die() -> void:
	change_health(- health_points)


# Does death aftercare and triggers death signal
func handle_death() -> void:
	died.emit()


# Prints relevant health statistics to the console
func print_health_stats() -> void:
	print("HEALTH DATA: " + " HP: " + str(health_points) + "/" + str(max_health_points))
