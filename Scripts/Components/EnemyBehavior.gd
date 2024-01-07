extends Node
class_name EnemyBehavior

@export var speed : float = 50
@export var engage_min_distance : float = 75
@export var retreat_max_distance : float = 50
@export var health_data : HealthData

@export var attack_manager : AttackManager
@export var health_manager : HealthManager
@export var potion : PotionData

var target : Node2D = null
var velocity : Vector2 = Vector2.ZERO
var anchor_position : Vector2

enum STATES {IDLE, TARGETING}
var state : STATES = STATES.IDLE


# Ready
func _ready():
	anchor_position = get_parent().position
	health_manager.health_data = health_data


# Physics process
func _physics_process(delta : float) -> void:
	if state == STATES.TARGETING:
		move_to_target(delta)
		attack_target()


# Handles enemy update in targeting state
func move_to_target(delta : float) -> void:
	var parent : Node2D = get_parent()
	var target_difference : Vector2 = (target.position - get_parent().position)
	
	if target_difference.length() >= engage_min_distance:
		velocity = target_difference.normalized() * speed * delta
	elif target_difference.length() <= retreat_max_distance:
		velocity = - target_difference.normalized() * speed * delta
	else:
		velocity = Vector2.ZERO
	
	get_parent().position += velocity


# Handles attack sequence in the targeting state
func attack_target() -> void:
	var projectile_direction : Vector2 = (target.global_position - get_parent().global_position).normalized()
	attack_manager.attack(potion, velocity, projectile_direction)


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
