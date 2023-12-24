extends Ingredient
class_name Potion

# Ready
func _ready() -> void:
	pass


# Enter tree
func _enter_tree() -> void:
	refresh_ui()
