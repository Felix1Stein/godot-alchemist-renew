extends Area2D
class_name Interactible


var active_player : PlayerManager


signal player_interacted(player : PlayerManager)


# Ready
func _ready() -> void:
	print("READY")


# Process
func _process(delta : float) -> void:
	if active_player == null:
		return
	
	var input_map : Dictionary = active_player.player_data.input_binding.input_movement_map
	if Input.is_action_just_pressed(input_map[InputBindingData.INPUTS.INTERACT]):
		interact()


# Handles player interaction script logic and triggers event
func interact() -> void:
	player_interacted.emit(active_player)


# Handles player collision entry and sets active_player
func handle_player_entry(player : PlayerManager) -> void:
	active_player = player


# Handles player collision exit and resets active_player
func handle_player_exit(player : PlayerManager) -> void:
	if active_player == player:
		active_player = null


# On area entered
func _on_area_entered(area : Node2D):
	if area.get_parent() is PlayerManager:
		handle_player_entry(area.get_parent() as PlayerManager)


# On area exited
func _on_area_exited(area):
	if area.get_parent() is PlayerManager:
		handle_player_exit(area.get_parent() as PlayerManager)
