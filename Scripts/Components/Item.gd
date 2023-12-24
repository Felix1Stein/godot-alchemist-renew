extends Area2D
class_name Item

@export var item_data : ItemData
@export var item_renderer : ItemRenderer


# Ready
func _ready() -> void:
	pass


# Enter tree
func _enter_tree() -> void:
	refresh_ui()


# Refreshes all UI display objects
func refresh_ui() -> void:
	item_renderer.render_data(item_data)
