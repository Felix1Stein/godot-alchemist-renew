extends Item
class_name Ingredient

# Ready
func _ready() -> void:
	pass


# Enter tree
func _enter_tree() -> void:
	refresh_ui()
