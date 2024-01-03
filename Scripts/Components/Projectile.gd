extends Node2D
class_name Projectile

@export var projectile_data : ProjectileData
@export var damage_manager : DamageManager

var direction : Vector2 = Vector2.ZERO
var origin_node : Node2D


# Ready
func _ready() -> void:
	initialize_child_objects()


# Sets up projectile object with variables passed on creation
func initialize(projectile_origin_node : Node2D, projectile_position : Vector2, projectile_direction : Vector2, projectile_faction : UTILS.FACTIONS) -> void:
	origin_node = projectile_origin_node
	position = projectile_position
	direction = projectile_direction
	damage_manager.faction = projectile_faction


# Sets up child managers like the damage manager
func initialize_child_objects() -> void:
	damage_manager.damage_data = projectile_data.damage


# Process
func _physics_process(delta : float) -> void:
	position += projectile_data.speed * direction * delta


# Handles collision
func handle_collision(other_node : Node2D) -> void:
	print("Projectile node entered: " + str(other_node))
	
	if other_node.get_instance_id() == origin_node.get_instance_id():
		return
	
	if projectile_data.destroy_on_contact == true:
		queue_free()


# On area entered
func _on_area_entered(area : Area2D) -> void:
	handle_collision(area as Node2D)


# On body entered
func _on_body_entered(body: Node2D) -> void:
	handle_collision(body)
