extends Node


# Global setup functions
func _ready() -> void:
	randomize()


# Gets a randomly distributed point inside a circle
static func get_random_point_inside_unit_circle() -> Vector2:
	var theta : float = randf() * 2 * PI
	return Vector2(cos(theta), sin(theta)) * sqrt(randf())
