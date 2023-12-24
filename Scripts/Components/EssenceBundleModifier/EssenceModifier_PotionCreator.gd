extends EssenceModifier
class_name EssenceModifierPotionCreator

@export var potion_prefab : PackedScene
@export var drop_position : Node2D

@export var potion_card_manager : PotionCardManager

# List of all essence modifiers that will be reset after a potion has been created
@export var reset_essence_modifiers : Array[EssenceModifier]


# Generates potion from essence bundle source
func modify_essence_bundle() -> void:
	if source_essence_container.essence_bundle.get_total_essence_amount() <= 0:
		return
	
	create_potion_item()
	clear_source_essence_container()
	super.modify_essence_bundle()
	
	reset_all_essence_modifiers()


# Creates a PotionData element according to specification and returns it
func generate_potion_data() -> PotionData:
	var potion_data : PotionData = potion_card_manager.generate_potion_data(source_essence_container.essence_bundle)
	return potion_data


# Creates potion item and instantiates it
func create_potion_item() -> void:
	var potion_data : PotionData = generate_potion_data()
	
	if potion_data == null:
		return
	
	var potion : Potion = potion_prefab.instantiate() as Potion
	potion.position = drop_position.global_position
	potion.item_data = potion_data
	get_tree().root.add_child(potion)


# Empties source essence bundle
func clear_source_essence_container() -> void:
	source_essence_container.essence_bundle.empty_essence_bundle()
	source_essence_container.render_data()


# Resets all essence modifiers in list
func reset_all_essence_modifiers() -> void:
	for essence_modifier in reset_essence_modifiers:
		essence_modifier.reset_modifier()


# On player interacted
func _on_player_interacted(player : PlayerManager) -> void:
	modify_essence_bundle()
