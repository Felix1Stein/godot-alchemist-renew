extends Node
class_name PlayerMovement

@export var player_manager : PlayerManager

@onready var character_movement_data : CharacterMovementData = player_manager.player_data.character_movement
@onready var input_binding_data : InputBindingData = player_manager.player_data.input_binding
@onready var input_map : Dictionary = input_binding_data.input_movement_map

var input_direction : Vector2 = Vector2.RIGHT
var look_direction : Vector2 = Vector2.ZERO
var dash_direction : Vector2 = Vector2.RIGHT
var is_dashing : bool = false
var dash_duration : float = 0
var dash_regeneration : float = 0


# Ready
func _ready():
	#await get_tree().process_frame
	pass


# Takes care of player inputs and updates player position
func handle_movement(delta : float) -> void:
	input_direction = get_input_direction()
	
	if Input.is_action_pressed(input_map[InputBindingData.INPUTS.DASH]):
		start_dash()
	
	if player_manager.get_global_mouse_position() != player_manager.global_position:
		look_direction = player_manager.get_global_mouse_position() - player_manager.global_position
	
	handle_dash(delta)
	player_manager.velocity = get_target_velocity()
	player_manager.move_and_slide()


# Gets key input and returns normalized movement direction
func get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed(input_map[InputBindingData.INPUTS.MOVE_RIGHT]):
		direction.x += 1
	if Input.is_action_pressed(input_map[InputBindingData.INPUTS.MOVE_LEFT]):
		direction.x -= 1
	if Input.is_action_pressed(input_map[InputBindingData.INPUTS.MOVE_DOWN]):
		direction.y += 1
	if Input.is_action_pressed(input_map[InputBindingData.INPUTS.MOVE_UP]):
		direction.y -= 1
	
	return direction.normalized()


# Initializes dash, called on dash key down
func start_dash() -> void:
	if is_dashing == true || dash_regeneration > 0:
		return
	
	dash_direction = get_input_direction()
	if dash_direction.length() <= 0.05:
		return

	is_dashing = true
	dash_duration = character_movement_data.dash_max_duration
	dash_regeneration = character_movement_data.dash_max_regeneration


# Sets up wait time for next dash, called when dash movement has finished
func end_dash() -> void:
	is_dashing = false


# Updates all dash values
func handle_dash(delta : float) -> void:
	if dash_regeneration > 0:
		dash_regeneration -= delta
	
	if is_dashing == true:
		if dash_duration > 0:
			dash_duration -= delta
		else:
			end_dash()


# Calculates velocity, taking input and dash into consideration
func get_target_velocity() -> Vector2:
	var direction : Vector2 = Vector2.ZERO
	
	if is_dashing == true:
		direction = dash_direction * character_movement_data.dash_speed_profile.sample_baked(1 - dash_duration / character_movement_data.dash_max_duration)
	else:
		direction = get_input_direction()
	
	return direction * character_movement_data.speed

