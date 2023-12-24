extends ItemData
class_name IngredientData

@export var essence_bundle : EssenceBundleData


# Init
func _init() -> void:
	item_type = ITEM_TYPES.ITEM
	
	object_prefab_path = "res://Prefabs/Ingredient.tscn"
	object_prefab = load(object_prefab_path)
	renderer_prefab_path = "res://Prefabs/IngredientRenderer.tscn"
	renderer_prefab = load(renderer_prefab_path)
	essence_bundle = EssenceBundleData.new()


# Creates and returns ItemRenderer object , needs to be added as a child to the scene, e.g. with get_tree().root.add_child(item_renderer)
func instantiate_render_object(renderer_position : Vector2) -> IngredientRenderer:
	var renderer : IngredientRenderer = renderer_prefab.instantiate() as IngredientRenderer
	
	renderer.render_data(self as IngredientData)
	renderer.global_position = renderer_position
	
	return renderer
