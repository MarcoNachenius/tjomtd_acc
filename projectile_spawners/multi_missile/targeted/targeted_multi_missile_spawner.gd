extends ProjectileSpawner
class_name TargetedMultiMissileSpawner


# EXPORTS
## The maximum number of missiles that can be launched at once,
## provided that the number of targets is greater than or equal to this value.
@export var __missile_damage: int
@export var __missile_speed: int
@export var __infinite_missiles_per_launch: bool = false
@export var __missiles_per_launch: int = 3
@export var MISSILE_ID: ProjectileConstants.MissilesForSpawner


# LOCALS
var __missile_load


func _launch_projectiles():
    var number_of_missiles_launched: int = 0
    for detectable_creep in __hurtbox.get_detectable_creeps_in_range():
        # Check if the maximum number of missiles has been reached
        if !__infinite_missiles_per_launch and number_of_missiles_launched >= __missiles_per_launch:
            break
        # Create missile
        var new_missile = __missile_load.instantiate()
        assert(new_missile != null, "Failed to instantiate missile")
        # set Target
        assert(__target, "No target provided")
        new_missile.set_target(detectable_creep)
        # set Damage
        new_missile.set_damage(__missile_damage)
        # set Speed
        new_missile.set_speed(__missile_speed)
        # Add to parent
        add_child(new_missile)
        # Increment number of missiles launched
        number_of_missiles_launched += 1

func _execute_extended_onready_commands():
    # Create instance of missile
    __missile_load = load(ProjectileConstants.MISSILE_PATHS[MISSILE_ID])