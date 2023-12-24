extends IngredientData
class_name PotionData

@export var max_uses : int = 10
@export var uses : int = 10
@export var usage_delay : float = 1

@export var damage : int = 1
@export var speed : float = 100


# Init
func _init() -> void:
	item_type = ITEM_TYPES.EQUIPMENT
	
	object_prefab_path = "res://Prefabs/Potion.tscn"
	object_prefab = load(object_prefab_path)
	renderer_prefab_path = "res://Prefabs/IngredientRenderer.tscn"
	renderer_prefab = load(renderer_prefab_path)
	essence_bundle = EssenceBundleData.new()


# Adds two PotionData elements together and sums their attributes, if possible
func add(other_potion_data : PotionData) -> void:
	max_uses = (max_uses + other_potion_data.max_uses) / 2
	uses = (uses + other_potion_data.uses) / 2
	
	usage_delay = (usage_delay + other_potion_data.usage_delay) / 2
	
	damage += other_potion_data.damage
	speed = (speed + other_potion_data.speed) / 2


# Checks if potion can be used and returns true otherwise false
func can_use() -> bool:
	return uses > 0


# Checks if potion can be used and decreases use by 1
func decrease_uses() -> void:
	if can_use() == false:
		return
	
	uses = clamp(uses - 1, 0, max_uses)
