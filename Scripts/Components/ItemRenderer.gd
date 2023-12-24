extends Node
class_name ItemRenderer

@export var sprite : Sprite2D
@export var name_display : Label


# Updates all rendering components with item data
func render_data(data : Variant) -> void:
	var item_data : ItemData = data as ItemData
	sprite.texture = item_data.texture
	name_display.text = item_data.name
