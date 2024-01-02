extends Resource
class_name DamageData

@export var contact_damage : int = 1


# Adds two damage objects, e.g. for potion generation
func add(other_damage_data : DamageData) -> void:
	contact_damage += other_damage_data.contact_damage
