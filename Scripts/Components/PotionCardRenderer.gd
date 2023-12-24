extends Node2D
class_name PotionCardRenderer

@export var name_display : Label
@export var essence_requirement_display : Label
@export var effect_display : Label

@export var potion_card_data : PotionCardData


# Enter tree
func _enter_tree() -> void:
	#refresh_ui()
	pass


# Updates all ui fields
func refresh_ui() -> void:
	name_display.text = potion_card_data.name
	essence_requirement_display.text = potion_card_data.essence_requirement.get_essence_bundle_string()
	effect_display.text = potion_card_data.description
