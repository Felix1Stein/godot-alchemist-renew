extends Node2D
class_name TargetChecker

@export var target_group_name : String = "Player"
@export var influence_radius : float = 100
@export var current_target : Node2D = null

@export var influence_box : CollisionShape2D

var potential_target_list : Array[Node2D] = []

signal target_changed(new_target : Node2D)


# Ready
func _ready() -> void:
	var circle_shape : CircleShape2D = CircleShape2D.new()
	circle_shape.set_radius(influence_radius)
	influence_box.shape.set_radius(influence_radius)


# Returns closest target in actively managed list of targets
func get_closest_target() -> Node2D:
	var closest_target : Node2D = null
	var closest_target_distance : float = INF
	
	for target in potential_target_list:
		var target_node : Node2D = target as Node2D
		var distance : float = (position - target_node.position).length()
		
		if distance < closest_target_distance:
			closest_target = target
			closest_target_distance = distance
	
	return closest_target


# Adds object to list of potential targets
func add_potential_target(node : Area2D) -> void:
	var parent : Node2D
	
	if node.get_parent() is Node2D:
		parent = node.get_parent()
	else:
		return
	
	if parent.is_in_group(target_group_name) == false:
		return
	
	potential_target_list.append(parent)
	refresh_target()


# Removes object from list of potential targets
func remove_potential_target(node : Area2D) -> void:
	var parent : Node2D
	
	if node.get_parent() is Node2D:
		parent = node.get_parent()
	else:
		return
	
	if parent.is_in_group(target_group_name) == false:
		return
	
	var index : int = potential_target_list.find(parent)
	if index == -1:
		return
	
	potential_target_list.remove_at(index)
	refresh_target()


# Updates current target and triggers a signal if the target changed
func refresh_target() -> void:
	var new_target : Node2D = get_closest_target()
	
	if new_target == current_target:
		return
	
	current_target = new_target
	target_changed.emit(new_target)


# On area entered
func _on_area_entered(area : Area2D) -> void:
	add_potential_target(area)


# On area exited
func _on_area_exited(area : Area2D) -> void:
	remove_potential_target(area)
