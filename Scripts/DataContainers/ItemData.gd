extends Resource
class_name ItemData

@export var name : String = "ITEM NAME"
@export var description : String = "ITEM DESCRIPTION"
@export var texture : CompressedTexture2D
@export var gold_value : int = 0

var object_prefab_path : String = ""
var object_prefab : PackedScene

var renderer_prefab_path : String = ""
var renderer_prefab : PackedScene

var item_type : ITEM_TYPES
enum ITEM_TYPES {ITEM, EQUIPMENT}

# Init
func _init():
	item_type = ITEM_TYPES.ITEM
	
	object_prefab_path = "res://Prefabs/Item.tscn"
	object_prefab = load(object_prefab_path)
	renderer_prefab_path = "res://Prefabs/ItemRenderer.tscn"
	renderer_prefab = load(renderer_prefab_path)
	print("ItemData _init")


# Creates and returns ItemRenderer object , needs to be added as a child to the scene, e.g. with get_tree().root.add_child(item_renderer)
func instantiate_render_object(renderer_position : Vector2) -> ItemRenderer:
	var renderer : ItemRenderer = renderer_prefab.instantiate() as ItemRenderer
	
	renderer.render_data(self)
	renderer.global_position = renderer_position
	
	return renderer


# Creates and returns Item object, needs to be added as a child to the scene, e.g. with get_tree().root.add_child(item)
func instantiate_item_object(drop_position : Vector2) -> Item:
	var item : Item = object_prefab.instantiate() as Item
	
	item.item_data = self
	item.global_position = drop_position
	
	return item
