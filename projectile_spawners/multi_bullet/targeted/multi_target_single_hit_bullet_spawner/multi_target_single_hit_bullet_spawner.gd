extends ProjectileSpawner
class_name MultiTargetSingleHitSingleBulletSpawner

@export var __infinite_targets_per_launch: bool
@export var __bullets_per_launch: int
@export var __bullet_damage: int
@export var __bullet_speed: int
@export var BULLET_PRELOAD: ProjectileConstants.SingleHitBullets
@export var __can_stun: bool = false
## Duration of the stun in seconds.
@export var __stun_duration_seconds: float = 0.0
## Percentage chance(0-100) of stunning the creep.
@export var __stun_probability_percentage: int = 0
## If true, projectile will be able to slow creep
@export var __can_slow: bool
## Duration of slow effect in seconds
@export var __slow_duration_seconds: float = 0.0
## Percentage of speed reduction for creep when inflicted
@export var __slow_speed_reduction_percentage: int
## If true, an aoe hurtbox will be created on ready 
## which allows for area of effect damage infliction
@export var __aoe_enabled: bool
## The radius of aoe damage infliction for projectile.
@export var __aoe_detection_radius: int
## The amount of damage that gets inflicted when triggered
@export var __aoe_damage_amount: int

func _execute_extended_onready_commands():
    assert(__bullets_per_launch or __infinite_targets_per_launch, "No bullets per launch has been provided and infinite targets is set to false")

func _launch_projectiles():
    var detectable_creeps: Array[Creep] = __hurtbox.get_detectable_creeps_in_range()
    var num_of_bullets_launched: int = 0
    for creep in detectable_creeps:
        # Create bullet
        var new_bullet: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[BULLET_PRELOAD].instantiate()
        add_child(new_bullet)
    
        # ──────── Setters ────────
        # Target
        new_bullet.set_target(creep)
    
        # Velocity / speed
        new_bullet.update_velocity_towards_target()
        new_bullet.set_speed(__bullet_speed)
        new_bullet.update_isometric_speed()
    
        # Base damage
        new_bullet.set_damage(__bullet_damage)
    
        # Stun parameters
        new_bullet.set_can_stun(__can_stun)
        new_bullet.set_stun_duration_seconds(__stun_duration_seconds)
        new_bullet.set_stun_probability_percentage(__stun_probability_percentage)
    
        # Slow parameters
        new_bullet.set_can_slow(__can_slow)
        new_bullet.set_slow_duration_seconds(__slow_duration_seconds)
        new_bullet.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)
    
        # Area‑of‑effect parameters
        new_bullet.set_aoe_enabled(__aoe_enabled)
        new_bullet.set_aoe_detection_radius(__aoe_detection_radius)
        new_bullet.set_aoe_damage_amount(__aoe_damage_amount)

        # Dont keep track of amount of bullets launched if infinite bullet launch is set to true
        if __infinite_targets_per_launch:
            continue

        # Increment bullets launched
        num_of_bullets_launched += 1

        # End loop if max number of simultaneous launches has been reached
        if num_of_bullets_launched == __bullets_per_launch:
            break

