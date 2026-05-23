extends Area2D
class_name CrawlTrigger

# Private reference to the shape resource
var __shape: ConvexPolygonShape2D

func _ready():
    # Create and set up the CollisionShape2D
    var collision_shape = CollisionShape2D.new()
    add_child(collision_shape)

    # Create the ConvexPolygonShape2D and assign it to the CollisionShape2D
    __shape = ConvexPolygonShape2D.new()
    collision_shape.shape = __shape

    # Draw collision shape
    var new_shape_points: Array[Vector2] = [
        Vector2(-128.0, 0.0),
        Vector2(0.0, 64.0),
        Vector2(128.0, 0.0),
        Vector2(0.0, -64.0)
    ]
    __shape.points = new_shape_points