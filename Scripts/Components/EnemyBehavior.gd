extends Node
class_name EnemyBehavior

@export var speed : float = 50
@export var engage_min_distance : float = 500
@export var retreat_max_distance : float = 100

var target : Node2D = null
var anchor_position : Vector2

enum STATES {IDLE, TARGETING}
var state : STATES = STATES.IDLE


# Ready
func _ready():
	anchor_position = get_parent().position


# Physics process
func _physics_process(delta : float) -> void:
	if state == STATES.TARGETING:
		process_targeting_state(delta)


# Handles enemy update in targeting state
func process_targeting_state(delta : float) -> void:
	var parent : Node2D = get_parent()
	var target_difference : Vector2 = (target.position - get_parent().position)
	
	if target_difference.length() >= engage_min_distance:
		get_parent().position += target_difference.normalized() * speed * delta
	elif target_difference.length() <= retreat_max_distance:
		get_parent().position -= target_difference.normalized() * speed * delta


# Updates the currently set target and changes the enemy state
func update_target(new_target : Node2D) -> void:
	target = new_target
	
	if new_target == null:
		state = STATES.IDLE
	else:
		state = STATES.TARGETING


# On Target Checker Target Changed
func _on_target_checker_target_changed(new_target : Node2D) -> void:
	update_target(new_target)
