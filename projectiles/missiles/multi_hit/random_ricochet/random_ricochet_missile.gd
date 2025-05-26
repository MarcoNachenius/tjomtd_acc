extends Projectile
class_name RandomRicochetMissile


@export var MISSILE_SPRITE: Sprite2D
@export var __damage: int
## If set to true, the missile will lose damage every time it hits a creep.
@export var __damage_degredation_enabled: bool = false
## The rate at which the missile loses damage after hitting a creep.
@export var __damage_degredation_rate: int
@export var __infinite_ricochets: bool = false
@export var __ricochet_detection_radius: int = 100
@export var __total_ricochets: int = 3

# LOCAL VARS
var __curr_ricochets: int


func _process(delta):
    _handle_movement()


func _handle_movement():
    assert(__velocity, "No velocity provided")
    assert(__speed, "No speed provided")
    if __target and is_instance_valid(__target) and __target.is_detectable():
        update_velocity_towards_target()
        update_isometric_speed()
        MISSILE_SPRITE.look_at(__target.global_position)
    
    # Change missile position
    position += __velocity * __isometric_speed

## Alters direction of missile to new target in range of richochet hurtbox,
## if one exists. 
## This method also avoids ping-ponging between same two targets when there is 
## more than one viable ricochet target in range that is not last hit creep.
func _handle_ricochet():
    print("Handling Ricochet")
    # Gererate random x and y values between -10 and 10
    var random_x_coordinate = randi_range(-10, 10)
    var random_y_coordinate = randi_range(-10, 10)
    # Consturct random position coordinates
    var random_next_position = Vector2(random_x_coordinate, random_y_coordinate)

    # Ensure random position does not cause missile to stop moving or
    # keep traveling in same direction
    while random_next_position == Vector2.ZERO or random_next_position.normalized() == __velocity:
        random_next_position = position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
    
    # Update velocity to new target
    __velocity = random_next_position.normalized()
    
    # Update isometric speed
    var direction_angle = position.angle_to_point(random_next_position)
    update_movement_towards_angle(direction_angle)
    # Reset sprite rotation ot 0
    MISSILE_SPRITE.rotate(-MISSILE_SPRITE.rotation)
    # Set new rotation angle
    MISSILE_SPRITE.rotate(direction_angle)

# Executes additional logic during _ready() method
func _extended_onready():
    __curr_ricochets = 0

## Inflicts damage to specified creep and handles ricochet logic.
func _inflict_damange(creep: Creep):

    # Remove current target if one exists
    if __target:
        __target = null


    # Handle damage infliction
    creep.take_damage(__damage)

    # Signal that creep has been hit
    creep_hit.emit(creep)

    # Handle AOE damage if enabled
    _handle_aoe_damage_infliction()

    # Handle slow infliction
    _handle_slow_infliction(creep)

    # Handle ricochet
    __curr_ricochets += 1
    # Destroy missile if it has reached maximum ricochets
    if !__infinite_ricochets and __curr_ricochets >= __total_ricochets:
        queue_free()
        return

    # Handle potential damage degredation
    if __damage_degredation_enabled:
        # Destroy missile if it has no more damage after hitting a creep
        if __damage - __damage_degredation_rate <= 0:
            queue_free()
            return
        # Reduce damage of missile
        __damage -= __damage_degredation_rate

    # Handle ricochet
    _handle_ricochet()

func _on_hurtbox_entered(area):
    if !area.get_parent() is Creep:
        return
    var entered_creep: Creep = area.get_parent() 
    if !entered_creep.is_detectable():
        return
    
    _inflict_damange(entered_creep)

# *******
# SETTERS
# *******

func set_damage(amount: int):
    __damage = amount

func set_damage_degredation_enabled(value: bool) -> void:
    __damage_degredation_enabled = value

func set_damage_degredation_rate(value: int) -> void:
    __damage_degredation_rate = value

func set_infinite_ricochets(value: bool) -> void:
    __infinite_ricochets = value

func set_ricochet_detection_radius(value: int) -> void:
    __ricochet_detection_radius = value

func set_total_ricochets(value: int) -> void:
    __total_ricochets = value
