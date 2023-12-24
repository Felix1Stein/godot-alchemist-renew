extends EssenceModifier
class_name EssenceModifierInventoryExtractor

@export var source_inventory : Inventory


# Extracts all essences from the inventory and outputs them into the target essence bundle
func modify_essence_bundle() -> void:
	if source_inventory.items.size() <= 0:
		return
	
	target_essence_container.essence_bundle = EssenceBundleData.new()
	
	for item in source_inventory.items:
		if item is IngredientData:
			var ingredient = item as IngredientData
			target_essence_container.essence_bundle.add(ingredient.essence_bundle)
	
	source_inventory.delete_all_inventory_items()
	target_essence_container.render_data()
	super.modify_essence_bundle()


# Links essence modifier with previous element to configure e.g. essence source
func link_with_previous(previous_essence_modifier : EssenceModifier) -> void:
	# no link required, as this element is the first in the chain
	pass


# Resets the essence modifier to its original state, e.g. after a potion has been created and removes all items from the inventory and clears the target
func reset_modifier() -> void:
	super.reset_modifier()
	source_inventory.delete_all_inventory_items()


# on player interacted
func _on_player_interacted(player : PlayerManager) -> void:
	modify_essence_bundle()
