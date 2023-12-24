extends Node
class_name EssenceBundleTester

@export var essence_bundle : EssenceBundleData
@export var essence_bundle_add : EssenceBundleData
@export var essence_bundle_subtract : EssenceBundleData


# Ready
func _ready() -> void:
	run_test()
	

func run_test() -> void:
	print_essence_bundles()
	essence_bundle.add(essence_bundle_add)
	print_essence_bundles()
	essence_bundle.subtract(essence_bundle_subtract)
	print_essence_bundles()

# Prints out essence glyph strings
func print_essence_bundles() -> void:
	print("Essence Bundle Data:")
	print("essence_bundle: (x" + str(essence_bundle.essences.size()) + ") " + essence_bundle.get_essence_bundle_string())
	print("essence_bundle_add: " + essence_bundle_add.get_essence_bundle_string())
	print("essence_bundle_subtract: " + essence_bundle_subtract.get_essence_bundle_string())
	print("\n")
