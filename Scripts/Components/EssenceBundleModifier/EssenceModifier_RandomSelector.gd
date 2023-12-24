extends EssenceModifier
class_name EssenceModifierRandomSelector

# Essence container that will be selected randomly for an random essence to move to the target essence bundle without removing the essence
@export var infinite_source_essence_container : EssenceContainer

# Chance that the infinite source is chosen instead of the source bundle
@export_range(0, 1) var random_source_chance : float = 0.25


# A random essence either from the infinite_source_essence_container or the source_essence_container will be added to the target essence container
func modify_essence_bundle() -> void:
	if source_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		return
	
	var selected_essence_bundle : EssenceBundleData = null
	
	if randf() <= random_source_chance:
		selected_essence_bundle = infinite_source_essence_container.essence_bundle.get_random_single_essence_in_essence_bundle()
	else:
		selected_essence_bundle = source_essence_container.essence_bundle.get_random_single_essence_in_essence_bundle()
		source_essence_container.essence_bundle.subtract(selected_essence_bundle)
		source_essence_container.render_data()
	
	target_essence_container.essence_bundle.add(selected_essence_bundle)
	target_essence_container.render_data()
	super.modify_essence_bundle()


# On player interacted
func _on_player_interacted(player : PlayerManager) -> void:
	modify_essence_bundle()
