extends EssenceModifier
class_name EssenceModifierRandomSubtractor

@export var subtractor_source_essence_container : EssenceContainer

@export var refill_essence_bundle : EssenceBundleData


# A random essence either from the infinite_source_essence_container or the source_essence_container will be added to the target essence container
func modify_essence_bundle() -> void:
	if source_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		return
	
	if subtractor_source_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		return
	
	var selected_essence_bundle : EssenceBundleData = subtractor_source_essence_container.essence_bundle.get_random_single_essence_in_essence_bundle()
	
	if source_essence_container.essence_bundle.can_subtract(selected_essence_bundle) == false:
		return
	
	source_essence_container.essence_bundle.subtract(selected_essence_bundle)
	source_essence_container.render_data()
	
	subtractor_source_essence_container.essence_bundle.subtract(selected_essence_bundle)
	subtractor_source_essence_container.render_data()
	
	super.modify_essence_bundle()


# Resets the essence modifier to its original state, refills source, e.g. after a potion has been created
func reset_modifier() -> void:
	super.reset_modifier()
	subtractor_source_essence_container.essence_bundle.empty_essence_bundle()
	subtractor_source_essence_container.essence_bundle.add(refill_essence_bundle)
	subtractor_source_essence_container.render_data()


# on player interacted
func _on_player_interacted(player : PlayerManager) -> void:
	modify_essence_bundle()

