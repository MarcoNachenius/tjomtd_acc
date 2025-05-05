extends Area2D
class_name TowerSelectionArea

var __collision_shape: CollisionShape2D
var __referenced_tower: Tower

# ================
# BUILT-IN METHODS
# ================

func _ready():
	_create_collision_shape()

# ====================
# CUSTOM LOCAL METHODS
# ====================

func _create_collision_shape():
	var collision_shape: CollisionShape2D = CollisionShape2D.new()
	add_child(collision_shape)
	# Create a ConvexPolygonShape2D and define a diamond shape
	var diamond_shape = ConvexPolygonShape2D.new()
	
	# Here, the shape will be centered on the tower:
	#  (-128, 0)   (0, -64)   (128, 0)   (0, 64)
	# 
	# If you plot these points, you'll see a diamond that
	# extends 128 px left/right from center, and 64 px up/down,
	# thus 256 wide and 128 tall overall.
	var diamond_points = PackedVector2Array()
	diamond_points.append(Vector2(-128, 0))
	diamond_points.append(Vector2(0, -64))
	diamond_points.append(Vector2(128, 0))
	diamond_points.append(Vector2(0, 64))

	# Assign the points to the ConvexPolygonShape2D
	diamond_shape.points = diamond_points
	
	# Assign the ConvexPolygonShape2D to the CollisionShape2D
	collision_shape.shape = diamond_shape

	# Assign to local var
	__collision_shape = collision_shape

func get_referenced_tower() -> Tower:
	return __referenced_tower

func get_collision_shape() -> CollisionShape2D:
	return __collision_shape

## Sets the tower which this area will reference when selected. 
func set_referenced_tower(referenced_tower: Tower) -> void:
	__referenced_tower = referenced_tower
