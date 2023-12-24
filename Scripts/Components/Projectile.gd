extends Node2D
class_name Projectile

var velocity : Vector2 = Vector2.ZERO


# Process
func _physics_process(delta : float):
	position += velocity * delta
