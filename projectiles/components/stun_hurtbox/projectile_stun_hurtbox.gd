extends Area2D
class_name ProjectileStunHurtbox

var __stun_duration_seconds: float
var __stun_probability_percentage: int


## Base radius controls the height of the oval (half of the vertical size).
var __radius: float
# Private reference to the shape resource
var __shape: ConvexPolygonShape2D
var __creeps_in_range: Array[Creep]


func _ready():
    # Connect signals
    area_entered.connect(_on_area_entered)
    
    # Create and set up the CollisionShape2D
    var collision_shape = CollisionShape2D.new()
    add_child(collision_shape)

    # Create the ConvexPolygonShape2D and assign it to the CollisionShape2D
    __shape = ConvexPolygonShape2D.new()
    collision_shape.shape = __shape

## Sets the base radius of the hurtbox and updates the collision shape size.
func set_base_radius(value: float) -> void:
    __radius = value
    _update_collision_shape()

func get_base_radius() -> float:
    return __radius

# Private function to update the collision shape's size
func _update_collision_shape():
    # Generate points for the oval
    __shape.points = _generate_oval_points()

# Helper function to generate points for the oval shape
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


func get_creeps_in_range() -> Array[Creep]:
    return __creeps_in_range

## Retrieves a list of detectable creeps within range.
## 
## This method filters through the creeps currently in range (__creeps_in_range)
## and returns only those that are detectable based on the `is_detectable()` 
## condition of each creep.
##
## Returns:
##     Array[Creep]: A list of detectable creeps (empty if none are in range or detectable).
func get_detectable_creeps_in_range() -> Array[Creep]:
    # Initialize an empty array to store detectable creeps.
    var detectable_creeps: Array[Creep] = []
    
    # Early exit if there are no creeps in range to avoid unnecessary iteration.
    if __creeps_in_range.is_empty():
        return detectable_creeps
    
    # Iterate through all creeps currently in range.
    for creep in __creeps_in_range:
        # Check if the creep meets the detectable condition.
        if creep.is_detectable():
            # Add the creep to the list of detectable creeps.
            detectable_creeps.append(creep)
    
    # Return the filtered list of detectable creeps.
    return detectable_creeps


func set_stun_duration_seconds(value: float) -> void:
    __stun_duration_seconds = value

func set_stun_probability_percentage(value: int) -> void:
    __stun_probability_percentage = value

# *******
# SIGNALS
# *******
func _on_area_entered(area):
    assert(area.get_parent() is Creep, "Non-creep object entered projectile spawner (review physics layer assignment)")
    if !area.get_parent() is Creep:
        return
    
    # Assume area is the creep's hitbox
    var entered_creep: Creep = area.get_parent()

    # Ignore creeps that are not detectable or are already dying.
    if !entered_creep.is_detectable() or entered_creep.get_curr_state() == Creep.States.DYING:
        return

    # Try to inflict the stun effect on the creep.
    if randi_range(0, 99) < __stun_probability_percentage:
        entered_creep.stun(__stun_duration_seconds)