extends Area2D
class_name Inventory

var items : Array[ItemData]
@export var item_slot_node : Node2D
@export var item_slots : Array[Node2D]
@export var item_selector_node : Node2D
@export var hide_item_selector : bool = false

var selected_item_slot_id : int = 0

@export var drop_position_node : Node2D
@export_range(0, 250) var drop_radius : float = 4

@export var collection_item_types : COLLECTION_CATEGORIES = COLLECTION_CATEGORIES.ALL
enum COLLECTION_CATEGORIES {ALL, ITEMS_ONLY, EQUIPMENT_ONLY}


# Enter tree
func _enter_tree() -> void:
	for child in item_slot_node.get_children():
		item_slots.append(child as Node2D)
	
	set_inventory_selector_visibility(! hide_item_selector)


# Ready
func _ready() -> void:
	move_inventory_selector(0)


# Generates random drop position within radius
func get_drop_position() -> Vector2:
	return drop_position_node.global_position + Utils.get_random_point_inside_unit_circle() * drop_radius


# Handles item pickup and immediately deletes item from the world
func pickup(item : Item) -> void:
	if collection_item_types == COLLECTION_CATEGORIES.EQUIPMENT_ONLY && item.item_data.item_type == ItemData.ITEM_TYPES.ITEM:
		return
	
	if collection_item_types == COLLECTION_CATEGORIES.ITEMS_ONLY && item.item_data.item_type == ItemData.ITEM_TYPES.EQUIPMENT:
		return
	
	if inventory_is_full() == true:
		return
	
	# picks and deletes item immediately, so no other inventory can pick it
	items.append(item.item_data)
	item.free()
	
	update_inventory_renderers()
	print_inventory()


func inventory_is_full() -> bool:
	if items.size() < item_slots.size():
		return false
	return true


# Drops the item of the the currently selected item slot
func drop_selected_item() -> void:
	drop(selected_item_slot_id)


# Drops item and creates item instance at position of drop_position_node
func drop(item_slot_id : int) -> void:
	if item_slot_id < 0 || item_slot_id >= items.size():
		return
	
	var item_object : Item = items[item_slot_id].instantiate_item_object(get_drop_position())
	get_tree().root.add_child(item_object)
	item_object.refresh_ui()
	items.remove_at(item_slot_id)
	update_inventory_renderers()


# Only clears rendered items, but keeps the items in items variable
func clear_rendered_items() -> void:
	for slot in item_slots:
		for child in slot.get_children():
			child.queue_free()


# Deletes and clears all inventory items from storage of the inventory without dropping
func delete_all_inventory_items() -> void:
	items = []
	clear_rendered_items()


# Refills all item renderers in the item_render_node on inventory update
func update_inventory_renderers() -> void:
	clear_rendered_items()
	
	for index in items.size():
		var renderer : ItemRenderer = items[index].instantiate_render_object(Vector2.ZERO)
		item_slots[index].add_child(renderer)


# Opens / closes inventory depending on the state of the open parameter by changing the inventory visibility
func change_inventory_visibility(open : bool) -> void:
	visible = open


# Moves the inventory selector direction number of slots to the right and changes the indicator
func move_inventory_selector(direction : int) -> void:
	selected_item_slot_id = clamp(selected_item_slot_id + direction, 0, item_slots.size() - 1)
	item_selector_node.position = item_slots[selected_item_slot_id].position + Vector2.ONE


# Hides / Shows inventory selector
func set_inventory_selector_visibility(visibility : bool) -> void:
	item_selector_node.visible = visibility


# Prints inventory
func print_inventory() -> void:
	print("Inventory")
	print("item count: " + str(items.size()))
	
	for item in items:
		print(item.name)
	print("\n")


# Area Entered
func _on_area_entered(area : Object) -> void:
	if area is Item:
		pickup(area)
