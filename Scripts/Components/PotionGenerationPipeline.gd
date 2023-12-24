extends Node2D
class_name PotionGenerationPipeline

@export var essence_modifier_prefabs : Array[PackedScene]

var essence_modifiers : Array[EssenceModifier]


# Ready
func _enter_tree() -> void:
	generate_essence_modifiers()


# Sets up essence modifiers and links the essence containers
func generate_essence_modifiers() -> void:
	var anchor_position : Vector2 = Vector2.ZERO
	
	for prefab in essence_modifier_prefabs:
		var essence_modifier : EssenceModifier = prefab.instantiate() as EssenceModifier
		
		# skip first source container when no target is set
		if essence_modifiers.size() == 0:
			essence_modifier.link_with_previous(null)
			anchor_position = - essence_modifier.source_anchor.position
		else:
			essence_modifier.link_with_previous(essence_modifiers.back())
			anchor_position = essence_modifiers.back().position + essence_modifiers.back().target_anchor.position - essence_modifier.source_anchor.position
		
		essence_modifier.position = anchor_position
		add_child(essence_modifier)
		
		essence_modifiers.append(essence_modifier)
	
	if essence_modifiers.size() > 0 && essence_modifiers.back() is EssenceModifierPotionCreator:
		var potion_creator : EssenceModifierPotionCreator = essence_modifiers.back() as EssenceModifierPotionCreator
		potion_creator.potion_generated.connect(on_potion_generated)


# Resets all essence modifiers in list
func reset_all_essence_modifiers() -> void:
	for essence_modifier in essence_modifiers:
		essence_modifier.reset_modifier()


# On potion generated
func on_potion_generated() -> void:
	reset_all_essence_modifiers()
