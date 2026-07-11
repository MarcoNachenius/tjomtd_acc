extends Area2D
class_name CreepCrawlScanner

@export var  RADIUS: int = 31
# Private reference to the shape resource
var __shape: ConvexPolygonShape2D

func _ready():
	# Create and set up the CollisionShape2D
	var collision_shape = CollisionShape2D.new()
	add_child(collision_shape)

	# Create the ConvexPolygonShape2D and assign it to the CollisionShape2D
	__shape = ConvexPolygonShape2D.new()
	collision_shape.shape = __shape

	# Initialize the oval shape dimensions
	__shape.points = _generate_oval_points()


# Helper function to generate points for the oval shape
func _generate_oval_points() -> Array[Vector2]:
	var points: Array[Vector2] = []
	var width = RADIUS * 2
	var height = RADIUS
	var num_segments = GameConstants.COLLISION_SHAPE_PRECISION

	for i in range(num_segments):
		var angle = i * (2 * PI / num_segments)  # Angle for each segment
		var x = cos(angle) * width
		var y = sin(angle) * height
		points.append(Vector2(x, y))
	
	return points

# ************
# TODO METHODS
# ************




# **********
# DEGBUGGING
# **********