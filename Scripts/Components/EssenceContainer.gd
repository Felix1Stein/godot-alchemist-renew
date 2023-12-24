extends Node
class_name EssenceContainer

@export var essence_display : Label
@export var essence_bundle : EssenceBundleData


# Ready
func _ready() -> void:
	essence_bundle.essence_bundle_changed.connect(render_data)
	render_data()


# Renders essence bundle to UI
func render_data() -> void:
	essence_display.text = essence_bundle.get_essence_bundle_string()
