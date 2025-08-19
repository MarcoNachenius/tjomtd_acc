extends Area2D
class_name TowerAuraArea

# Base radius controls the height of the oval (half of the vertical size).
@export var __radius: float = 48
# Private reference to the shape resource
var __shape: ConvexPolygonShape2D

# INHERITED METHODS
# =================
func _ready():
	_create_collision_shape()
	_extended_ready()

# ABSTRACT METHODS
# ================
## Runs addidional commands in _ready() for objects that inherit from TowerAuraArea
func _extended_ready() -> void:
	pass

# PRIVATE METHODS
# ===============
func _create_collision_shape() -> void:
	# Create and set up the CollisionShape2D
	var collision_shape = CollisionShape2D.new()
	add_child(collision_shape)

	# Create the ConvexPolygonShape2D and assign it to the CollisionShape2D
	__shape = ConvexPolygonShape2D.new()
	collision_shape.shape = __shape

	# Initialize the oval shape dimensions
	_update_collision_shape()

# Private function to update the collision shape's size
func _update_collision_shape():
	# Generate points for the oval
	__shape.points = _generate_oval_points()

# Helper function to generate points for the oval collision shape
func _generate_oval_points() -> Array[Vector2]:
	var points: Array[Vector2] = []
	var width = __radius * 2
	var height = __radius
	var num_segments = GameConstants.COLLISION_SHAPE_PRECISION

	for i in range(num_segments):
		var angle = i * (2 * PI / num_segments)  # Angle for each segment
		var x = cos(angle) * width
		var y = sin(angle) * height
		points.append(Vector2(x, y))
	
	return points

# SETTERS
# =======
# Setters and getters for __radius
func set_base_radius(value: float) -> void:
	__radius = value
	_update_collision_shape()


# GETTERS
# =======
func get_base_radius() -> float:
	return __radius
