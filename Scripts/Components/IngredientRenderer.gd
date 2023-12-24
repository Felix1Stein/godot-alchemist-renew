extends ItemRenderer
class_name IngredientRenderer

@export var essence_display : Label


# Updates all rendering components with item data
func render_data(data : Variant) -> void:
	var ingredient_data : IngredientData = data as IngredientData
	
	super.render_data(ingredient_data as IngredientData)
	essence_display.text = ingredient_data.essence_bundle.get_essence_bundle_string()
