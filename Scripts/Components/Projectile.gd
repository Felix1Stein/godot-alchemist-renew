extends Node2D
class_name Projectile

var velocity : Vector2 = Vector2.ZERO


# Process
func _physics_process(delta : float) -> void:
	position += velocity * delta


func _on_area_entered(area : Area2D) -> void:
	print(area)
