extends Node2D
class_name Projectile

@export var projectile_data : ProjectileData
@export var damage_manager : DamageManager

var direction : Vector2 = Vector2.ZERO


# Ready
func _ready() -> void:
	initialize_child_objects()


# Sets up child managers like the damage manager
func initialize_child_objects() -> void:
	damage_manager.damage_data = projectile_data.damage


# Process
func _physics_process(delta : float) -> void:
	position += projectile_data.speed * direction * delta


# Handles collision
func handle_collision(other_node : Node2D) -> void:
	print("Projectile node entered: " + str(other_node))
	
	if projectile_data.destroy_on_contact == true:
		queue_free()


# On area entered
func _on_area_entered(area : Area2D) -> void:
	handle_collision(area as Node2D)


# On body entered
func _on_body_entered(body: Node2D) -> void:
	handle_collision(body)
