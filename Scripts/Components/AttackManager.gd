extends Node
class_name AttackManager

@export var projectile_prefab : PackedScene

var delay : float = 0

# Process
func _process(delta : float):
	if delay > 0:
		delay -= delta


# Checks if delay is smaller or equal to 0 and returns true otherwise false
func can_attack() -> bool:
	return delay <= 0


# Sets delay to the new maximum
func reset_delay(max_delay : float):
	delay = max_delay


# Executes attack stored in potion_data
func attack(potion_data : PotionData, velocity : Vector2, projectile_direction : Vector2) -> void:
	if can_attack() == false || potion_data.can_use() == false:
		return
	
	potion_data.decrease_uses()
	reset_delay(potion_data.usage_delay)
	
	create_projectile(potion_data, velocity, projectile_direction)


# Spanwns projectile with behavior configured in potion_data with the given velocity and projectile direction
func create_projectile(potion_data : PotionData, velocity : Vector2, projectile_direction : Vector2) -> void:
	var projectile : Projectile = projectile_prefab.instantiate() as Projectile
	projectile.position = get_parent().global_position
	
	# ignores player velocity
	projectile.velocity = projectile_direction.normalized() * potion_data.speed
	
	get_tree().root.add_child(projectile)
	
	print("attack with : " + potion_data.name)
	print("uses: " + str(potion_data.uses) + " / " + str(potion_data.max_uses))
