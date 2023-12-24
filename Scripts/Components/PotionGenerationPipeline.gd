extends Node2D
class_name PotionGenerationPipeline

@export var essence_modifier_prefabs : Array[PackedScene]

@export var offset : Vector2 = Vector2(100, 0)

var essence_modifiers : Array[EssenceModifier]


# Ready
func _enter_tree() -> void:
	generate_essence_modifiers()


# Sets up essence modifiers and links the essence containers
func generate_essence_modifiers() -> void:
	var running_offset : Vector2 = Vector2.ZERO
	
	for prefab in essence_modifier_prefabs:
		var essence_modifier : EssenceModifier = prefab.instantiate() as EssenceModifier
		essence_modifier.position = running_offset
		
		# skip first source container when no target is set
		if essence_modifiers.size() == 0:
			essence_modifier.link_with_previous(null)
		else:
			essence_modifier.link_with_previous(essence_modifiers.back())
		
		add_child(essence_modifier)
		
		essence_modifiers.append(essence_modifier)
		running_offset += offset
	
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
