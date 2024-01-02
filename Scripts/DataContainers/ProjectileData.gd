extends Resource
class_name ProjectileData

@export var damage : DamageData
@export var speed : float = 100
@export var destroy_on_contact : bool = true


# Adds attributes of two projectile data components, e.g. for potion generation
func add(other_projectile_data : ProjectileData) -> void:
	damage.add(other_projectile_data.damage)
	speed = (speed + other_projectile_data.speed) / 2
	destroy_on_contact = destroy_on_contact || other_projectile_data.destroy_on_contact
