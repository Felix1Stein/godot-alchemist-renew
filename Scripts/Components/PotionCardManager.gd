extends Node2D
class_name PotionCardManager

@export var potion_cards : Array[PotionCardData]

@export var potion_card_prefab : PackedScene


# Enter tree
func _ready() -> void:
	render_potion_cards()


# Generates potion data from potion cards
func generate_potion_data(essence_budget : EssenceBundleData) -> PotionData:
	var new_potion_data : PotionData = cumulate_potion_cards(essence_budget)
	
	if new_potion_data == null:
		return null
	
	new_potion_data.name = "POTION"
	new_potion_data.description = "DESCRIPTION"
	new_potion_data.texture = load("res://Assets/Items/Item_Potion_Violet.png")
	
	return new_potion_data


# Checks all potion cards if they match the ingredients and returns the assembled PotionData element as a sum of all cards
func cumulate_potion_cards(essence_budget : EssenceBundleData) -> PotionData:
	var new_potion_data : PotionData = null
	
	for potion_card in potion_cards:
		if essence_budget.can_subtract(potion_card.essence_requirement) == false:
			continue
		
		# cards do not "cost" essences, they just require them
		# essence_budget.subtract(potion_card.essence_requirement)
		
		if new_potion_data == null:
			new_potion_data = potion_card.potion_effect
		else:
			new_potion_data.add(potion_card.potion_effect)
	
	return new_potion_data


# Instantiates and renders all potion cards
func render_potion_cards() -> void:
	var offset : Vector2 = Vector2.ZERO
	
	for potion_card_data in potion_cards:
		var renderer : PotionCardRenderer = potion_card_prefab.instantiate() as PotionCardRenderer
		renderer.position = offset
		renderer.potion_card_data = potion_card_data
		self.add_child(renderer)
		renderer.refresh_ui()
		
		offset += Vector2(110, 0)
