extends CharacterBody2D
class_name PlayerManager


@export var player_data : PlayerData

@export var player_movement : PlayerMovement
@export var player_inventory_manager : PlayerInventoryManager
@export var sprite : Sprite2D

var tooltips_visible : bool = false
var equipment_inventory_selected : bool = false

enum STATES {
	MOVEMENT,
	INVENTORY
}

var state = STATES.MOVEMENT


# Ready
func _ready():
	initialize_sprite()


# Sets player sprites
func initialize_sprite() -> void:
	sprite.texture = player_data.texture


# Handles state-changes and switches to new state
func change_state(new_state : STATES) -> void:
	state = new_state


# Process
func _process(delta : float) -> void:
	pass


# Physics process
func _physics_process(delta : float) -> void:
	if state == STATES.MOVEMENT:
		player_movement.handle_movement(delta)
		player_inventory_manager.handle_inventory_closed_interaction(player_movement.input_binding_data.input_movement_map, velocity)
	elif state == STATES.INVENTORY:
		player_inventory_manager.handle_inventory_open_interaction(player_movement.input_binding_data.input_movement_map, velocity)
