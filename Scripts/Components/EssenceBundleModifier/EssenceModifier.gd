extends Node
class_name EssenceModifier

@export var source_essence_container : EssenceContainer
@export var target_essence_container : EssenceContainer

signal essence_modifier_modified()


# Ready
func _ready() -> void:
	if source_essence_container != null && source_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		source_essence_container.essence_bundle = EssenceBundleData.new()
	
	if target_essence_container != null && target_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		target_essence_container.essence_bundle = EssenceBundleData.new()
	
	reset_modifier()


# Handles the modification of the source / target essence container
func modify_essence_bundle() -> void:
	essence_modifier_modified.emit()
	#remove_essences_from_clearing_containers()
	#var essence_bundle : EssenceBundleData = source_essence_container.essence_bundle.get_random_single_essence_in_essence_bundle()
	#source_essence_container.essence_bundle.subtract(essence_bundle)
	#target_essence_container.essence_bundle.add(essence_bundle)


# Resets the essence modifier to its original state, clears source and target, e.g. after a potion has been created
func reset_modifier() -> void:
	if source_essence_container != null:
		source_essence_container.essence_bundle.empty_essence_bundle()
		source_essence_container.render_data()
	
	if target_essence_container != null:
		target_essence_container.essence_bundle.empty_essence_bundle()
		target_essence_container.render_data()
