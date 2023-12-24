extends Node
class_name PlayerInventoryManager


@export var player_manager : PlayerManager

@export var inventory : Inventory
@export var equipment_inventory : Inventory

@export var attack_manager_primary : AttackManager
@export var attack_manager_secondary : AttackManager

var tooltips_visible : bool = false
var equipment_inventory_selected : bool = false


# Ready
func _ready():
	initialize_inventory()
	set_tooltip_visibility(tooltips_visible)
	change_equipment_inventory_selected_statue(false)


# Initializes inventory with item data from player
func initialize_inventory() -> void:
	inventory.items = player_manager.player_data.inventory.items
	equipment_inventory.items = player_manager.player_data.equipment_inventory.items
	set_inventory_visibility(false)


# Sets the tooltips_visble variable to the value of visible and updates the visibility layer of item tooltips
func set_tooltip_visibility(visible : bool) -> void:
	get_viewport().set_canvas_cull_mask_bit(1, visible)


# Switches the state of the tooltip visibility
func toggle_tooltip_visibility() -> void:
	tooltips_visible = ! tooltips_visible
	set_tooltip_visibility(tooltips_visible)


# Opens / closes the inventory and disables player movement depeding on the value of visibility
func set_inventory_visibility(visibility : bool) -> void:
	inventory.change_inventory_visibility(visibility)
	equipment_inventory.change_inventory_visibility(visibility)


# Activates / toggles item or equipment inventory active status
func change_equipment_inventory_selected_statue(equipment : bool) -> void:
	equipment_inventory_selected = equipment
	equipment_inventory.set_inventory_selector_visibility(equipment)
	inventory.set_inventory_selector_visibility(! equipment)


# Drops the item currently selected
func drop_selected_item() -> void:
	if equipment_inventory_selected == true:
		equipment_inventory.drop_selected_item()
	else:
		inventory.drop_selected_item()


# Opens the inventory and triggers a state change in the player_manager
func open_inventory() -> void:
	set_inventory_visibility(true)
	set_tooltip_visibility(true)
	player_manager.change_state(PlayerManager.STATES.INVENTORY)

# Closes the inventory and triggers a state change in the player_manager
func close_inventory() -> void:
	set_inventory_visibility(false)
	set_tooltip_visibility(tooltips_visible)
	player_manager.change_state(PlayerManager.STATES.MOVEMENT)


# Handles inventory interaction when the inventory is open, e.g. cursor movement, dropping items
func handle_inventory_open_interaction(input_movement_map : Dictionary, player_velocity : Vector2) -> void:
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.TOGGLE_INVENTORY]):
		close_inventory()
	
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.MOVE_RIGHT]):
		inventory.move_inventory_selector(1)
		equipment_inventory.move_inventory_selector(1)
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.MOVE_LEFT]):
		inventory.move_inventory_selector(-1)
		equipment_inventory.move_inventory_selector(-1)
	
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.MOVE_DOWN]):
		change_equipment_inventory_selected_statue(true)
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.MOVE_UP]):
		change_equipment_inventory_selected_statue(false)
	
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.INTERACT]):
		drop_selected_item()


# Handles inventory interaction when the inventory is closed, e.g. attacking, toggling tooltips
func handle_inventory_closed_interaction(input_movement_map : Dictionary, player_velocity : Vector2) -> void:
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.TOGGLE_INVENTORY]):
		open_inventory()
	
	if Input.is_action_just_pressed(input_movement_map[InputBindingData.INPUTS.TOGGLE_TOOLTIPS]):
		toggle_tooltip_visibility()
		
	if Input.is_action_pressed(input_movement_map[InputBindingData.INPUTS.ATTACK]):
		if equipment_inventory.items.size() > 0:
			var potion_data : PotionData = equipment_inventory.items[0] as PotionData
			attack_manager_primary.attack(potion_data, player_velocity)
		
	if Input.is_action_pressed(input_movement_map[InputBindingData.INPUTS.ATTACK_ALTERNATE]):
		if equipment_inventory.items.size() > 1:
			var potion_data : PotionData = equipment_inventory.items[1] as PotionData
			attack_manager_secondary.attack(potion_data, player_velocity)
