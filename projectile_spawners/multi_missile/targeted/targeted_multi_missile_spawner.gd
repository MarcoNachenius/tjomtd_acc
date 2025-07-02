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
## If true, an aoe hurtbox will be created on ready 
## which allows for area of effect damage infliction
@export var __aoe_enabled: bool
## The radius of aoe damage infliction for projectile.
@export var __aoe_detection_radius: int
## The amount of damage that gets inflicted when triggered
@export var __aoe_damage_amount: int
## If true, an aoe show hurtbox will be created on ready 
## which allows for area of effect slow infliction
@export var __aoe_slow_enabled: bool
## The radius of aoe slow infliction for projectile.
@export var __aoe_slow_detection_radius: int
## The percentage a creep's speed will be reduced when triggered
@export var __aoe_slow_percentage: int
## The duration in seconds for which a creep will be slowed down
@export var __aoe_slow_duration: float


# LOCALS
var __missile_load


func _launch_projectiles():
    # Play sound effect
    play_launch_projectile_sound_effect()
	
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
        # set Speed
        new_missile.set_speed(__missile_speed)
        # set Target
        new_missile.set_target(detectable_creep)
        # set Damage
        new_missile.set_damage(__missile_damage)
        # Parameters that require 
        # Area‑of‑effect parameters
        new_missile.set_aoe_enabled(__aoe_enabled)
        new_missile.set_aoe_detection_radius(__aoe_detection_radius)
        new_missile.set_aoe_damage_amount(__aoe_damage_amount)
    
        # Area‑of‑effect slow parameters
        new_missile.set_aoe_slow_enabled(__aoe_slow_enabled)
        new_missile.set_aoe_slow_detection_radius(__aoe_slow_detection_radius)
        new_missile.set_aoe_slow_percentage(__aoe_slow_percentage)
        new_missile.set_aoe_slow_duration(__aoe_slow_duration)
        # Add to parent
        add_child(new_missile)
        # Increment number of missiles launched
        number_of_missiles_launched += 1

func _execute_extended_onready_commands():
    # Create instance of missile
    __missile_load = load(ProjectileConstants.MISSILE_PATHS[MISSILE_ID])

func get_damage() -> int:
    return __missile_damage